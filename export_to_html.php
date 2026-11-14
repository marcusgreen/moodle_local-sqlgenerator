<?php

// Database connection configuration
$db_config = [
    'host' => 'localhost',
    'user' => '',
    'password' => '',
    'database' => ''
];

// Private data rules. Table names are matched without the prefix, column and
// setting names case-insensitively.

// Tables never exported because their rows are credentials, keys or sessions.
const EXCLUDED_TABLES = '/^(sessions|mnet_session|scorm_aicc_session|user_private_key|user_password_(resets|history)'
    . '|user_devices|message_airnotifier_devices|messageinbound_datakeys|tool_mfa.*|.*token.*|.*secret.*'
    . '|.*auth_codes|.*_linked_login|.*share_key|oauth2_system_account|badge_backpack_oauth2)$/';

// Columns redacted in every table: names, contact details, credentials, keys and IP addresses.
// logstore_standard_log.other can hold the username of a failed login, and
// task_adhoc.customdata the IP address and browser of a login.
const REDACTED_COLUMNS = '/^(username|password|passwd|secret|sesskey|sid|sessdata|.*token.*|.*secret.*|.*_key'
    . '|firstname|lastname|middlename|alternatename|firstnamephonetic|lastnamephonetic|author'
    . '|email|phone1|phone2|address|institution|department|ip|firstip|lastip|ip_address|hostname|other|customdata)$/i';

// Further columns redacted only in these tables.
const REDACTED_TABLE_COLUMNS = [
    'user' => ['idnumber', 'city', 'description', 'imagealt'],
    'repository_instances' => ['name'],
];

// Name/value tables: the value columns are redacted when the setting name looks sensitive.
const NAME_VALUE_TABLES = [
    'config' => ['name', ['value']],
    'config_plugins' => ['name', ['value']],
    'config_log' => ['name', ['value', 'oldvalue']],
    'user_preferences' => ['name', ['value']],
    'adminpresets_it' => ['name', ['value']],
    'course_format_options' => ['name', ['value']],
];
const SENSITIVE_SETTING = '/pass|secret|token|key|salt|hash|mail|address|identifier|user$|username|phone|openssl|cert/i';

const REDACTED = '[redacted]';

// The site's host names are replaced with this in every exported value so the pages do not reveal them.
const SITE_HOST_REPLACEMENT = 'localhost';

// Function to display help message
function show_help() {
    echo <<<EOT

Export the rows of every non-empty table in a MySQL/MariaDB database to HTML
pages, and add a "View table data" link to each matching SchemaSpy table page.
Empty tables are skipped.

Private data is left out: tables of credentials, keys and sessions are not
exported, and columns such as username, password, email, names, tokens and
IP addresses show [redacted]. Settings whose names look secret (passwords,
keys, tokens, email addresses) are redacted in config and similar tables.
The site's host names are replaced with localhost in every value.
The rules are at the top of this script.

Usage:
  php export_to_html.php -u <user> -p <password> -d <database> [options]

Required:
  -u, --username=<user>       Database username
  -p, --password=<password>   Database password
  -d, --db=<database>         Database to read rows from, usually the
                              Moodle site database (the ERD database
                              holds no rows)

Optional:
  -c, --properties=<file>     schemaspy.properties to read the SchemaSpy
                              output name (schemaspy.o) from.
                              Default: \$CFG->dataroot/local_sqlgenerator/
                              schemaspy.properties, then
                              output/schemaspy.properties.
                              Giving this skips loading Moodle.
      --prefix=<prefix>       Strip this exact table prefix from table names
                              before matching SchemaSpy pages, e.g. mdl_.
                              Default: \$CFG->prefix, or mdl_ with -c.
      --no-prefix             Do not strip any prefix
      --site-host=<list>      Host names to replace with localhost, comma
                              separated. Default: the host of the site's
                              own mnet_host record in the database, and
                              the host of \$CFG->wwwroot unless -c is given.
  -t, --tables=<list>         Export only these tables, comma separated.
                              Names may be given with or without the
                              prefix, e.g. course,course_modules.
                              Default: all tables.
  -h, --help                  Show this help and exit

Output:
  Data pages go to output/<schemaspy.o>_erd/tables/data/<table>_data.html
  (or output/<schemaspy.o>/tables/data/). If no properties file is found,
  <schemaspy.o> is the database name.

Examples:
  php export_to_html.php -u moodle -p secret -d mdl53er_erd
  php export_to_html.php -u moodle -p secret -d mdl53er_erd \\
      -c output/schemaspy.properties --no-prefix
  php export_to_html.php -u moodle -p secret -d mdl53er_erd \\
      -t course,course_sections,course_modules


EOT;

    exit(0);
}

function usage_error(string $message): void {
    fwrite(STDERR, "Error: $message\nRun with --help for usage.\n");
    exit(2);
}

// Parse command line arguments
$short_opts = 'hu:p:d:c:t:';
$long_opts = ['help', 'username:', 'password:', 'db:', 'properties:', 'prefix:', 'no-prefix', 'tables:', 'site-host:'];
$options = getopt($short_opts, $long_opts, $rest_index);

// getopt() silently ignores unknown switches, so check them here.
$takes_value = ['u', 'p', 'd', 'c', 'username', 'password', 'db', 'properties', 'prefix', 't', 'tables', 'site-host'];
$known = array_merge($takes_value, ['h', 'help', 'no-prefix']);
$args = array_slice($argv, 1, $rest_index - 1);
for ($i = 0; $i < count($args); $i++) {
    $arg = $args[$i];
    if (strpos($arg, '--') === 0) {
        [$name] = explode('=', substr($arg, 2), 2);
        $attached = strpos($arg, '=') !== false;
    } else {
        $name = substr($arg, 1, 1);
        $attached = strlen($arg) > 2;
    }
    if (!in_array($name, $known, true)) {
        usage_error("unknown option $arg");
    }
    if (!$attached && in_array($name, $takes_value, true)) {
        $i++; // Skip the option's value, which may itself start with '-'.
    }
}
if ($rest_index < count($argv)) {
    usage_error('unexpected argument ' . $argv[$rest_index]);
}

$properties_file = null;
$table_prefix = null;
$only_tables = null;
$site_hosts = null;
$wwwroot_host = null;

foreach ($options as $opt => $value) {
    if (is_array($value)) {
        usage_error("option -$opt given more than once");
    }
    switch ($opt) {
        case 'h':
        case 'help':
            show_help();
            break;
        case 'u':
        case 'username':
            $db_config['user'] = $value;
            break;
        case 'p':
        case 'password':
            $db_config['password'] = $value;
            break;
        case 'd':
        case 'db':
            $db_config['database'] = $value;
            break;
        case 'c':
        case 'properties':
            $properties_file = $value;
            break;
        case 'prefix':
            $table_prefix = $value;
            break;
        case 'no-prefix':
            $table_prefix = '';
            break;
        case 't':
        case 'tables':
            $only_tables = array_values(array_unique(array_filter(array_map('trim', explode(',', $value)), 'strlen')));
            if (!$only_tables) {
                usage_error('--tables needs at least one table name');
            }
            break;
        case 'site-host':
            $site_hosts = array_values(array_unique(array_filter(array_map('trim', explode(',', $value)), 'strlen')));
            if (!$site_hosts) {
                usage_error('--site-host needs at least one host name');
            }
            break;
    }
}

if (isset($options['prefix']) && isset($options['no-prefix'])) {
    usage_error('--prefix and --no-prefix cannot be used together');
}

// Validate required parameters
$missing = [];
foreach (['user' => '-u/--username', 'password' => '-p/--password', 'database' => '-d/--db'] as $key => $switch) {
    if ($db_config[$key] === '') {
        $missing[] = $switch;
    }
}
if ($missing) {
    usage_error('missing required option(s): ' . implode(', ', $missing));
}

// Parse schemaspy.properties to find the ERD tables directory
function parse_schemaspy_properties(string $file): array {
    $props = [];
    foreach (file($file, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES) as $line) {
        $line = trim($line);
        if ($line === '' || $line[0] === '#') {
            continue;
        }
        [$key, $value] = array_pad(explode('=', $line, 2), 2, '');
        $props[trim($key)] = trim($value);
    }
    return $props;
}

// index.php writes schemaspy.properties to $CFG->dataroot/local_sqlgenerator/. Moodle is only
// bootstrapped (to read dataroot) when no path was given on the command line.
if ($properties_file !== null) {
    if (!is_readable($properties_file)) {
        fwrite(STDERR, "Error: properties file not readable: $properties_file\n");
        exit(1);
    }
    $schemaspy_props_file = $properties_file;
} else {
    define('CLI_SCRIPT', true);
    require(__DIR__ . '/../../config.php');
    $schemaspy_props_file = null;
    foreach ([$CFG->dataroot . '/local_sqlgenerator/schemaspy.properties',
              __DIR__ . '/output/schemaspy.properties'] as $candidate_props) {
        if (is_readable($candidate_props)) {
            $schemaspy_props_file = $candidate_props;
            break;
        }
    }
    $table_prefix = $table_prefix ?? $CFG->prefix;
    $wwwroot_host = parse_url($CFG->wwwroot, PHP_URL_HOST);
}
$table_prefix = $table_prefix ?? 'mdl_';

$schemaspy_tables_dir = null;
// schemaspy.o defaults to the database name if no properties file is found.
$output_name = $db_config['database'];
if ($schemaspy_props_file !== null) {
    echo "Using properties file: $schemaspy_props_file\n";
    $props = parse_schemaspy_properties($schemaspy_props_file);
    $output_name = $props['schemaspy.o'] ?? $output_name;
}
$candidate = __DIR__ . '/output/' . $output_name . '_erd/tables';
if (is_dir($candidate)) {
    $schemaspy_tables_dir = $candidate;
} elseif (is_dir(__DIR__ . '/output/' . $output_name . '/tables')) {
    $schemaspy_tables_dir = __DIR__ . '/output/' . $output_name . '/tables';
}

if (!$schemaspy_tables_dir) {
    fwrite(STDERR, "Error: could not locate SchemaSpy tables directory. Cannot write output.\n");
    exit(1);
}

$data_dir = $schemaspy_tables_dir . '/data';
if (!is_dir($data_dir)) {
    mkdir($data_dir, 0755, true);
}

echo "SchemaSpy tables dir: $schemaspy_tables_dir\n";
echo "Data output dir: $data_dir\n";

function remove_data_link(string $html_file): void {
    $content = file_get_contents($html_file);
    $updated = preg_replace('/<p data-export-link="1">.*?<\/p>/', '', $content);
    if ($updated !== $content) {
        file_put_contents($html_file, $updated);
    }
}

function inject_data_link(string $html_file, string $display_name, string $data_html_rel_path): void {
    $content = file_get_contents($html_file);
    if (strpos($content, 'data-export-link') !== false) {
        return; // already injected
    }
    $link_html = '<p data-export-link="1"><a href="' . $data_html_rel_path . '">View table data</a></p>';
    $pattern = '/<h1>' . preg_quote($display_name, '/') . '<\/h1>/';
    if (preg_match($pattern, $content, $matches)) {
        $updated = preg_replace($pattern, $matches[0] . $link_html, $content, 1);
        file_put_contents($html_file, $updated);
    }
}

// Read the site's host name from its own mnet_host record, whose id is the
// mnet_localhost_id setting. Returns null if the tables or record are missing.
function find_site_host(mysqli $conn, string $prefix): ?string {
    try {
        $result = $conn->query("SELECT h.wwwroot FROM `{$prefix}mnet_host` h
            JOIN `{$prefix}config` c ON c.name = 'mnet_localhost_id' AND h.id = c.value");
    } catch (mysqli_sql_exception $e) {
        return null;
    }
    $row = $result ? $result->fetch_row() : null;
    return $row ? (parse_url($row[0], PHP_URL_HOST) ?: null) : null;
}

try {
    $conn = new mysqli($db_config['host'], $db_config['user'], $db_config['password'], $db_config['database']);

    if ($conn->connect_error) {
        throw new Exception('Connection failed: ' . $conn->connect_error);
    }

    // The mnet_host record keeps the host the site was installed with, which
    // can differ from $CFG->wwwroot, so both are replaced.
    if ($site_hosts === null) {
        $site_hosts = array_unique(array_filter([find_site_host($conn, $table_prefix), $wwwroot_host]));
    }
    $site_hosts = array_values(array_filter($site_hosts, function($host) {
        return strcasecmp($host, SITE_HOST_REPLACEMENT) !== 0;
    }));
    if ($site_hosts) {
        echo 'Replacing site host name(s) ' . implode(', ', $site_hosts) . ' with ' . SITE_HOST_REPLACEMENT . "\n";
    } else {
        echo 'No site host name to replace with ' . SITE_HOST_REPLACEMENT . "\n";
    }

    $result = $conn->query('SHOW TABLES');
    $tables = [];
    while ($row = $result->fetch_array()) {
        $tables[] = $row[0];
    }

    if ($only_tables !== null) {
        // Match each requested name against the full table name or the name without the prefix.
        $selected = [];
        $unknown = [];
        foreach ($only_tables as $wanted) {
            $match = null;
            foreach ($tables as $table_name) {
                if ($table_name === $wanted || $table_name === $table_prefix . $wanted) {
                    $match = $table_name;
                    break;
                }
            }
            if ($match === null) {
                $unknown[] = $wanted;
            } else {
                $selected[] = $match;
            }
        }
        if ($unknown) {
            throw new Exception('table(s) not found in ' . $db_config['database'] . ': ' . implode(', ', $unknown));
        }
        $tables = array_values(array_unique($selected));
    }

    $empty_tables = 0;
    $excluded_tables = [];
    foreach ($tables as $table_name) {
        $display_name = $table_name;
        if ($table_prefix !== '' && strpos($table_name, $table_prefix) === 0) {
            $display_name = substr($table_name, strlen($table_prefix));
        }
        $schema_file = "$display_name.html";
        $data_file   = "{$display_name}_data.html";
        $schemaspy_html = "$schemaspy_tables_dir/$schema_file";

        // Remove output from an earlier run, so a table that is now empty or
        // excluded does not keep a stale page.
        if (file_exists("$data_dir/$data_file")) {
            unlink("$data_dir/$data_file");
        }
        if (file_exists($schemaspy_html)) {
            remove_data_link($schemaspy_html);
        }

        if (preg_match(EXCLUDED_TABLES, $display_name)) {
            $excluded_tables[] = $table_name;
            continue;
        }

        $result = $conn->query("SELECT * FROM `$table_name`");
        if ($result->num_rows > 0) {
            $fields = $result->fetch_fields();
            $columns = array_map(function($field) { return $field->name; }, $fields);

            // Work out which column indexes are always redacted, and for
            // name/value tables which hold the name and the values.
            $table_columns = array_map('strtolower', REDACTED_TABLE_COLUMNS[$display_name] ?? []);
            $redacted_cols = [];
            foreach ($columns as $i => $col) {
                if (preg_match(REDACTED_COLUMNS, $col) || in_array(strtolower($col), $table_columns, true)) {
                    $redacted_cols[$i] = true;
                }
            }
            $name_col = null;
            $value_cols = [];
            if (isset(NAME_VALUE_TABLES[$display_name])) {
                [$name_column, $value_columns] = NAME_VALUE_TABLES[$display_name];
                $name_col = array_search($name_column, $columns, true);
                $value_cols = array_flip(array_keys(array_intersect($columns, $value_columns)));
            }

            $html_content  = "<!DOCTYPE html>\n<html lang=\"en\">\n<head>\n";
            $html_content .= "    <meta charset=\"UTF-8\">\n";
            $html_content .= "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n";
            $html_content .= "    <title>$display_name Data</title>\n";
            $html_content .= "    <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\" integrity=\"sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM\" crossorigin=\"anonymous\">\n";
            $html_content .= "</head>\n<body>\n";
            $html_content .= "    <div class=\"container mt-5\">\n";
            $html_content .= "        <p><a href=\"../$display_name.html\">&larr; Back to schema</a></p>\n";
            $html_content .= "        <h1 class=\"mb-4\">$display_name Data</h1>\n";
            $html_content .= "        <table class=\"table table-striped table-hover\">\n        <thead class=\"table-dark\">\n            <tr>\n";
            foreach ($columns as $col) {
                $html_content .= "                <th>" . htmlspecialchars($col) . "</th>\n";
            }
            $html_content .= "            </tr>\n        </thead>\n        <tbody>\n";

            $result = $conn->query("SELECT * FROM `$table_name`");
            while ($row = $result->fetch_array(MYSQLI_NUM)) {
                $sensitive_setting = $name_col !== false && $name_col !== null
                    && preg_match(SENSITIVE_SETTING, $row[$name_col] ?? '');
                $html_content .= "            <tr>\n";
                foreach ($row as $i => $cell) {
                    $redact = isset($redacted_cols[$i]) || ($sensitive_setting && isset($value_cols[$i]));
                    if ($redact && $cell !== null && $cell !== '') {
                        $cell = REDACTED;
                    } elseif ($cell !== null && $site_hosts) {
                        $cell = str_ireplace($site_hosts, SITE_HOST_REPLACEMENT, $cell);
                    }
                    $html_content .= "                <td>" . htmlspecialchars($cell ?? '') . "</td>\n";
                }
                $html_content .= "            </tr>\n";
            }

            $html_content .= "        </tbody>\n    </table>\n    </div>\n</body>\n</html>";

            $out_path = "$data_dir/$data_file";
            file_put_contents($out_path, $html_content);
            echo "Exported $table_name -> $out_path\n";

            if (file_exists($schemaspy_html)) {
                inject_data_link($schemaspy_html, $display_name, "data/$data_file");
                echo "  -> Updated $schema_file with data link\n";
            }
        } else {
            $empty_tables++;
        }
    }

    echo "Skipped $empty_tables empty table(s)\n";
    if ($excluded_tables) {
        echo 'Skipped ' . count($excluded_tables) . ' table(s) that hold credentials or sessions: '
            . implode(', ', $excluded_tables) . "\n";
    }

    $conn->close();
} catch (Exception $e) {
    fwrite(STDERR, 'Error: ' . $e->getMessage() . "\n");
    exit(1);
}
