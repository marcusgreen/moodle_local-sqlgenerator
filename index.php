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

//$mform = new local_sqlgenerator_form(new moodle_url('/local/sqlgenerator/'));

global $DB;
global $CFG;
$component = optional_param('component', '', PARAM_PATH);


$PAGE->set_url('/admin/sqlgenerator.php');

$mform = new local_sqlgenerator_form(new moodle_url('/local/sqlgenerator/'));
$output = $PAGE->get_renderer('local_sqlgenerator');
if ($data = $mform->get_data()) {
    //generate_sql($data->component, "component.sql");
    /*component.sql is the name of the output file with the sql statements */
    generate_sql("placeholdercomponent","component.sql");
}
echo $OUTPUT->header();
$mform->display();
echo $OUTPUT->footer();

function generate_sql($component, $outputfile) {
    global $CFG;
    global $DB;
    $dbmanager = $DB->get_manager();
    $dbmanager->generator->foreign_keys = true;

/*
    $root = "$CFG->dirroot/mod";
    $plugins = get_folders($root);
    $root= "$CFG->dirroot/blocks";
    $plugins=array_merge($plugins,get_folders($root));
    $root= "$CFG->dirroot/enrol";
    $plugins=array_merge($plugins,get_folders($root));
    $root= "$CFG->dirroot/repository";
    $plugins=array_merge($plugins,get_folders($root));
    $root= "$CFG->dirroot/mod/assign/submission";
    $plugins=array_merge($plugins,get_folders($root));
    $root= "$CFG->dirroot/mod/assign/feedback";
    $plugins=array_merge($plugins,get_folders($root));    
    $root= "$CFG->dirroot/grade/grading/form";
    $plugins=array_merge($plugins,get_folders($root));
    
    $plugins=array_merge($plugins,array("$CFG->libdir"));
 * */
 
    $plugins=getDirectoryTree();
 
    $fh = fopen($outputfile, 'w') or die("can't open file");
    fwrite($fh,"/* Moodle version ". $CFG->version." Release ".$CFG->release ." SQL code */");
    foreach ($plugins as $plugin) {
        $xmldb_file = new xmldb_file($plugin);
        if (!$xmldb_file->fileExists()) {
            throw new ddl_exception('ddlxmlfileerror', null, 'File does not exist');
        }
        $loaded = $xmldb_file->loadXMLStructure();
        $xmldb_structure = $xmldb_file->getStructure();
        $sqlarr = $dbmanager->generator->getCreateStructureSQL($xmldb_structure);
        foreach ($sqlarr as $sql) {
            $sql = str_replace("CREATE TABLE", ";\r CREATE TABLE", $sql);
            fwrite($fh, $sql);
        }
    }

    fclose($fh);
    print "<p>Done </p>";
}

/** Loop through all filders and get a list of all install.xml files 
 * with full path
 */
function getDirectoryTree($sort=0){
    global $CFG;
    $dir=$CFG->dirroot;
    $items = glob($dir . '/*');    
    for ($i = 0; $i < count($items); $i++) {
        if (is_dir($items[$i])) {
            $add = glob($items[$i] . '/*');
            $items = array_merge($items, $add);
        }
    }
    $installfiles=array();
    foreach($items as $item){
        if(preg_match("/install\.xml/",$item)){
            $installfiles[]=$item;
        }
        
    }
   return $installfiles;
} 