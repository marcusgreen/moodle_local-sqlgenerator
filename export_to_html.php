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
  This script connects to a MySQL database, exports data from all tables to CSV files,
  and generates HTML files to display the data in a tabular format.
  You can provide username, password, and database name via command line options.


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

// Directory to store CSV and HTML files
$output_dir = 'db_export';
if (!is_dir($output_dir)) {
    mkdir($output_dir, 0777, true);
}

try {
    // Connect to the database
    $conn = new mysqli($db_config['host'], $db_config['user'], $db_config['password'], $db_config['database']);
    
    if ($conn->connect_error) {
        throw new Exception('Connection failed: ' . $conn->connect_error);
    }
    
    // Get all tables in the database
    $result = $conn->query('SHOW TABLES');
    $tables = [];
    while ($row = $result->fetch_array()) {
        $tables[] = $row[0];
    }
    
    foreach ($tables as $table_name) {
        $result = $conn->query("SELECT * FROM `$table_name`");        
        if ($result->num_rows > 0) {
            // Get column names
            $fields = $result->fetch_fields();
            $columns = array_map(function($field) { return $field->name; }, $fields);
            
            // Export to CSV
            $csv_file = "$output_dir/$table_name.csv";
            $fp = fopen($csv_file, 'w');
            fputcsv($fp, $columns);
            while ($row = $result->fetch_array(MYSQLI_NUM)) {
                fputcsv($fp, $row);
            }
            fclose($fp);
            
            // Generate HTML
            $html_content = "<!DOCTYPE html>\n<html lang=\"en\">\n<head>\n";
            $html_content .= "    <meta charset=\"UTF-8\">\n";
            $html_content .= "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n";
            $html_content .= "    <title>$table_name Data</title>\n";
            $html_content .= "    <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\" rel=\"stylesheet\" integrity=\"sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM\" crossorigin=\"anonymous\">\n";
            $html_content .= "</head>\n<body>\n";
            $html_content .= "    <div class=\"container mt-5\">\n";
            $html_content .= "        <h1 class=\"mb-4\">$table_name Data</h1>\n";
            $html_content .= "        <table class=\"table table-striped table-hover\">\n        <thead class=\"table-dark\">\n            <tr>\n";
            foreach ($columns as $col) {
                $html_content .= "                <th>" . htmlspecialchars($col) . "</th>\n";
            }
            $html_content .= "            </tr>\n        </thead>\n        <tbody>\n";
            
            $result = $conn->query("SELECT * FROM `$table_name`"); // Reset result pointer
            while ($row = $result->fetch_array(MYSQLI_NUM)) {
                $html_content .= "            <tr>\n";
                foreach ($row as $cell) {
                    $html_content .= "                <td>" . htmlspecialchars($cell) . "</td>\n";
                }
                $html_content .= "            </tr>\n";
            }
            
            $html_content .= "        </tbody>\n    </table>\n    </div>\n</body>\n</html>";
            
            // Save HTML file
            $html_file = "$output_dir/$table_name.html";
            file_put_contents($html_file, $html_content);
            
            echo "Exported $table_name to $csv_file and $html_file\n";
        } else {
            echo "No data found in $table_name\n";
        }
    }
    
    $conn->close();
} catch (Exception $e) {
    echo 'Error: ' . $e->getMessage() . "\n";
}
