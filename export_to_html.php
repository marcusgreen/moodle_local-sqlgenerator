<?php

// Database connection configuration
$db_config = [
    'host' => 'localhost',
    'user' => '',
    'password' => '',
    'database' => ''
];

// Function to display help message
function show_help() {
    echo <<<EOT

Export the rows of every table in a MySQL/MariaDB database to HTML pages, and
add a "View table data" link to each matching SchemaSpy table page.

Usage:
  php export_to_html.php -u <user> -p <password> -d <database> [options]

Required:
  -u, --username=<user>       Database username
  -p, --password=<password>   Database password
  -d, --db=<database>         Database to export (the ERD database, not
                              the live Moodle one)

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
  -h, --help                  Show this help and exit

Output:
  Data pages go to output/<schemaspy.o>_erd/tables/data/<table>_data.html
  (or output/<schemaspy.o>/tables/data/). If no properties file is found,
  <schemaspy.o> is the database name.

Examples:
  php export_to_html.php -u moodle -p secret -d mdl53er_erd
  php export_to_html.php -u moodle -p secret -d mdl53er_erd \\
      -c output/schemaspy.properties --no-prefix


EOT;

    exit(0);
}

function usage_error(string $message): void {
    fwrite(STDERR, "Error: $message\nRun with --help for usage.\n");
    exit(2);
}

// Parse command line arguments
$short_opts = 'hu:p:d:c:';
$long_opts = ['help', 'username:', 'password:', 'db:', 'properties:', 'prefix:', 'no-prefix'];
$options = getopt($short_opts, $long_opts, $rest_index);

// getopt() silently ignores unknown switches, so check them here.
$takes_value = ['u', 'p', 'd', 'c', 'username', 'password', 'db', 'properties', 'prefix'];
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

try {
    $conn = new mysqli($db_config['host'], $db_config['user'], $db_config['password'], $db_config['database']);

    if ($conn->connect_error) {
        throw new Exception('Connection failed: ' . $conn->connect_error);
    }

    $result = $conn->query('SHOW TABLES');
    $tables = [];
    while ($row = $result->fetch_array()) {
        $tables[] = $row[0];
    }

    foreach ($tables as $table_name) {
        $display_name = $table_name;
        if ($table_prefix !== '' && strpos($table_name, $table_prefix) === 0) {
            $display_name = substr($table_name, strlen($table_prefix));
        }
        $result = $conn->query("SELECT * FROM `$table_name`");
        if ($result->num_rows > 0) {
            $fields = $result->fetch_fields();
            $columns = array_map(function($field) { return $field->name; }, $fields);

            $schema_file = "$display_name.html";
            $data_file   = "{$display_name}_data.html";

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
                $html_content .= "            <tr>\n";
                foreach ($row as $cell) {
                    $html_content .= "                <td>" . htmlspecialchars($cell ?? '') . "</td>\n";
                }
                $html_content .= "            </tr>\n";
            }

            $html_content .= "        </tbody>\n    </table>\n    </div>\n</body>\n</html>";

            $out_path = "$data_dir/$data_file";
            file_put_contents($out_path, $html_content);
            echo "Exported $table_name -> $out_path\n";

            $schemaspy_html = "$schemaspy_tables_dir/$schema_file";
            if (file_exists($schemaspy_html)) {
                inject_data_link($schemaspy_html, $display_name, "data/$data_file");
                echo "  -> Updated $schema_file with data link\n";
            }
        } else {
            echo "No data found in $table_name\n";
        }
    }

    $conn->close();
} catch (Exception $e) {
    fwrite(STDERR, 'Error: ' . $e->getMessage() . "\n");
    exit(1);
}
