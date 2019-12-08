<?php
// This file is part of Moodle - http://moodle.org/
//
// Moodle is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Moodle is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Moodle.  If not, see <http://www.gnu.org/licenses/>.

/**
 * Run the code checker from the web.
 *
 * @package    local_sqlgenerator
 * @copyright  2014 Marcus Green
 * @license    http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */
require_once(__DIR__ . '/../../config.php');
require_once($CFG->libdir . '/adminlib.php');
require_once($CFG->dirroot . '/local/sqlgenerator/locallib.php');
$PAGE->set_context(context_system::instance());

global $DB;
global $CFG;
$component = optional_param('component', '', PARAM_PATH);

$PAGE->set_url('/admin/sqlgenerator.php');

$mform = new local_sqlgenerator_form(new moodle_url('/local/sqlgenerator/'));
$output = $PAGE->get_renderer('local_sqlgenerator');
if ($data = $mform->get_data()) {
    $pluginfolder  = $data->pluginfolder ?? '';

    /* component.sql is the name of the output file with the sql statements */
    if (isset($data->checkmorekeys)) {
        $plugin_tablenames = get_tablenames_from_plugins();
        $keys = get_morekeys();
        print "<br/>SizeOf keys :" . sizeof($keys);
        print "<br/><br/><br/><br/>Rows in morekeys.xml with no matching plugin table";
        $nomatchcount = 0;
        $loopstep = 0;
        foreach ($keys as $key => $value) {
            $tablefound = false;
            $loopstep++;
            $name = get_field($value, 'NAME');
            if ($name == null) {
                continue;
            }
            $keytablename = (explode("_erd_", $name)[0]);

            foreach ($plugin_tablenames as $tablename) {
                if (strcasecmp($keytablename, $tablename) == 0) {
                    $tablefound = true;
                }
            }
            if ($tablefound == false) {
                $nomatchcount++;
                print "<br/>" . $keytablename;
            }
        }
        print "<br/>NoMatchCount:" . $nomatchcount;
        ;
    }
    if (isset($data->submitbutton)) {
        print "<br/>Generating:";
        generate_sql("placeholdercomponent", "output/create_tables.sql",$pluginfolder);
    }
    if (isset($data->writexml)) {
        write_xml();
        print "<br/>Writing XML completed:";

    }
}

function write_xml(array $tablestowrite=array()) {
    global $DB, $CFG;
    $dbmanager = $DB->get_manager();
    $plugins = getDirectoryTree();
    $fh = fopen('output/table_xml.html', 'w') or die("can't open file table_xml.html");
    $findex= fopen("output/pluginxml/index.htm", "w");
    fwrite($findex,"<h3>dbmxl files for each plugin extracted from the install folder</h3>");
    fwrite($fh,"<pre>");
    foreach ($plugins as $plugin) {
        $contents = file_get_contents($plugin);
        $xml = simplexml_load_string($contents);
        $arr = $xml->attributes();
        fwrite($fh,"<hr/>");
        $folder=rtrim($plugin,"install.xml");
        $folder=substr($folder,0,-4);
        $folder=str_replace($CFG->dirroot,'',$folder);
        $contents ="<br/><p>".$folder."<p/><pre>".htmlspecialchars($contents);
        $folder=substr($folder,1);
        $folder=str_replace("/","_",$folder);
        $folder=$folder.".html";
        echo "creating:".$folder."</br>";
        $pluginxml_file=fopen("output/pluginxml/".$folder, "w");
        fwrite($findex,"<a href=".$folder.">".$folder."</a><br/>");
        fwrite($pluginxml_file,$contents."</pre>");
        fclose($pluginxml_file);
        fwrite($fh,($contents));
    }

    fwrite($fh,"</pre>");
    fclose($findex);
    fclose($fh);
}

function get_tablenames_from_plugins() {
    global $DB;
    $dbmanager = $DB->get_manager();
    $plugins = getDirectoryTree();
    $tablecount = 0;
    $plugintables = array();
    foreach ($plugins as $plugin) {
        $sqlarr = get_sqlarr($plugin, $dbmanager);
        foreach ($sqlarr as $sql) {
            $tablename = get_tablename($sql);
            if ($tablename > "") {
                $plugintables[] = $tablename;
                $tablecount++;
            }
        }
    }
    return $plugintables;
}

function get_sqlarr($plugin, $dbmanager) {
    $xmldb_file = new xmldb_file($plugin);
    if (!$xmldb_file->fileExists()) {
        throw new ddl_exception('ddlxmlfileerror', null, 'File does not exist');
    }
    $xmldb_file->loadXMLStructure();
    $xmldb_structure = $xmldb_file->getStructure();
    $sqlarr = $dbmanager->generator->getCreateStructureSQL($xmldb_structure);
    return $sqlarr;
}

echo $OUTPUT->header();
$mform->display();
echo $OUTPUT->footer();

function get_field($key, $field) {
    $xml = simplexml_load_string($key);
    if ($xml <> null) {
        $arr = $xml->attributes();
        return $arr[$field];
    } else {
        return null;
    }
}

function generate_sql($component, $outputfile,$pluginfolder) {
    global $CFG;
    global $DB;

    $dbmanager = $DB->get_manager();
    $dbmanager->generator->foreign_keys = true;
    $plugins = [];
    if ($pluginfolder === "") {
        $plugins = getDirectoryTree();
    } else{
        $plugins[] = $CFG->dirroot . '/' . $pluginfolder . '/db/install.xml';
    }


    $fh = fopen($outputfile, 'w') or die("can't open file");
    fwrite($fh, "/* Moodle version " . $CFG->version . " Release " . $CFG->release . " SQL code */".PHP_EOL);
    /* This allows tables to created with foreign keys */
    fwrite($fh, 'SET FOREIGN_KEY_CHECKS=0;' . PHP_EOL);
    $keys = get_morekeys();
    $fhkeys = fopen('output/add_foreign_keys.sql', 'w') or die("can't open file add_foreign_keys.sql");
    fwrite($fhkeys, "/* Moodle version " . $CFG->version . " Release " . $CFG->release . " Add Foreign Keys code */".PHP_EOL);
    $keys = get_morekeys();
    create_extra_fkeys($keys,$fhkeys);
    fwrite($fhkeys, "/* End of Extra Foreign Keys */ ".PHP_EOL);
    foreach ($plugins as $plugin) {
        $xmldb_file = new xmldb_file($plugin);
        if (!$xmldb_file->fileExists()) {
            throw new ddl_exception('ddlxmlfileerror', null, 'File does not exist');
        }
        $xmldb_file->loadXMLStructure();
        $xmldb_structure = $xmldb_file->getStructure();
        $xmldb_tables = $xmldb_structure->getTables();
        create_add_fkeys($dbmanager,$xmldb_tables,$fhkeys);
        $sqlarr = $dbmanager->generator->getCreateStructureSQL($xmldb_structure);
        foreach ($sqlarr as $sql) {
            $sql = str_replace("CREATE TABLE", ";".PHP_EOL."CREATE TABLE", $sql);
            $engineloc = strpos($sql, 'ENGINE = InnoDB');
            $uptoengine = substr($sql, 0, $engineloc);
            $lastparenloc = strrpos($uptoengine, ")");
            $tablename = get_tablename($sql);
            $key = find_key_for_table($tablename, $keys);
            $keycount = count($key);
            if ($keycount > 0) {
                $keystring = "";
                foreach ($key as $value) {
                    $keystring .= $value;
                }
                $sql = substr_replace($sql, ',' . $keystring, $lastparenloc, 0);
            }
            fwrite($fh, $sql);
        }
    }
    fclose($fh);
    \core\notification::add('Complete', \core\notification::SUCCESS);
}

function create_add_fkeys($dbmanager,$xmldb_tables,$fkeys){
   global $CFG;
    foreach ($xmldb_tables as $xmldb_table) {
            $xmldb_keys = $xmldb_table->getKeys();
            foreach ($xmldb_keys as $key) {
                if ($key->getType() == XMLDB_KEY_FOREIGN) {
                    $keytext = $dbmanager->generator->getKeySQL($xmldb_table, $key);
                    $keytext = 'ALTER TABLE '.$CFG->prefix.$xmldb_table->getName().' ADD FOREIGN KEY ('.$key->getFields()[0]. ') REFERENCES '.$CFG->prefix.$key->getRefTable(). ' ('.$key->getRefFields()[0].');'.PHP_EOL;
                    fwrite($fkeys,$keytext);
                }
            }
        }
}

function create_extra_fkeys($keys,$fhkeys){
    print "<br/>";
    global $CFG,$DB;
    $sql = "update ".$CFG->prefix ."course_categories set parent=? where id=?";
    $DB->execute($sql,array(1,1));

    foreach ($keys as $key) {
        $keyname = get_field($key, "NAME");
        $keytablename = (explode("_erd_", $keyname)[0]);
        $field = get_field($key, 'FIELDS');
        $reffield = get_field($key, "REFFIELDS");
        $reftable = get_field($key, "REFTABLE");
        if ($keytablename > '') {
            /*PHP_EOL == end of line */
            $keytext = 'ALTER TABLE '.$CFG->prefix.$keytablename.' ADD FOREIGN KEY ('.$field. ') REFERENCES '.$CFG->prefix.$reftable. ' ('.$reffield.');'.PHP_EOL;
            fwrite($fhkeys,$keytext);
        }
    }
}
function find_key_for_table($tablename, $keys) {
    $foreignkeys = array();
    foreach ($keys as $key) {
        $keyname = get_field($key, "NAME");
        $keytablename = (explode("_erd_", $keyname)[0]);
        $field = get_field($key, 'FIELDS');
        $reffield = get_field($key, "REFFIELDS");
        $reftable = get_field($key, "REFTABLE");
        if (trim($keytablename) === trim($tablename)) {
            $comma = "";
            if (count($foreignkeys) > 0) {
                $comma = ",";
            }
            $foreignkeys[] = $comma . "CONSTRAINT " . $keyname . " FOREIGN KEY(" . $field . ") REFERENCES " . $reftable . "(" . $reffield . ")";
        }
    }
    return $foreignkeys;
}

function get_morekeys() {
    $fkeys = fopen('morekeys.xml', 'r') or ( "cant open morekeys.xml file");
    $keys = array();
    if ($fkeys) {
        while (($line = fgets($fkeys)) !== false) {
            $keys[] = $line;
        }
        fclose($fkeys);
        return $keys;
    } else {
        echo "<br/>error opening the file morekeys.xml";
    }
}

function get_tablename($sql) {
    $ct = PHP_EOL."CREATE TABLE";
    /* start point of CREATE TABLE */
    $ctloc = strpos($sql, $ct);
    $tablestart = $ctloc + strlen($ct);
    $tableend = strpos($sql, '(');
    $len = $tableend - $tablestart;
    $tablename = substr($sql, $tablestart, $len);
    return trim($tablename);
}

/** Loop through all folders and get a list of all install.xml files
 * with full path
 */
function getDirectoryTree($sort = 0) {
    global $CFG;
    $dir = $CFG->dirroot;
     $items = glob($dir . '/*');
     for ($i = 0; $i < count($items); $i++) {
        if (is_dir($items[$i])) {
            $add = glob($items[$i] . '/*');
            $items = array_merge($items, $add);
        }
    }
    $installfiles = array();
    foreach ($items as $item) {
        if (preg_match("/install\.xml/", $item)) {
            $installfiles[] = $item;
        }
    }
    return $installfiles;
}
