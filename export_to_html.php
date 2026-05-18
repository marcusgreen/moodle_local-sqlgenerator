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

Usage: php mysql_export_to_html.php [options]

Options:
  --help          Display this help message and exit
  --username, -u  Specify the database username
  --password, -p  Specify the database password
  --db, -d        Specify the database name

Description:
  This script connects to a MySQL database, exports data from all tables,
  and generates HTML files in the SchemaSpy tables directory to display
  the data in a tabular format with links back to the schema page.


EOT;

    exit(0);
}

// Parse command line arguments
$options = getopt('u:p:d:', ['help', 'username:', 'password:', 'db:']);

foreach ($options as $opt => $value) {
    switch ($opt) {
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
    }
}

// Validate required parameters
if (empty($db_config['user']) || empty($db_config['password']) || empty($db_config['database'])) {
    echo 'Username, password, and database name are required. Use --help for usage information'.PHP_EOL;
    exit(2);
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

$schemaspy_props_file = __DIR__ . '/output/schemaspy.properties';
$schemaspy_tables_dir = null;
if (file_exists($schemaspy_props_file)) {
    $props = parse_schemaspy_properties($schemaspy_props_file);
    $output_name = $props['schemaspy.o'] ?? null;
    if ($output_name) {
        $candidate = __DIR__ . '/output/' . $output_name . '_erd/tables';
        if (is_dir($candidate)) {
            $schemaspy_tables_dir = $candidate;
        } elseif (is_dir(__DIR__ . '/output/' . $output_name . '/tables')) {
            $schemaspy_tables_dir = __DIR__ . '/output/' . $output_name . '/tables';
        }
    }
}

if (!$schemaspy_tables_dir) {
    echo "Error: could not locate SchemaSpy tables directory. Cannot write output.\n";
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
        $display_name = preg_replace('/^[a-z]+_/', '', $table_name);
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
    echo 'Error: ' . $e->getMessage() . "\n";
}
