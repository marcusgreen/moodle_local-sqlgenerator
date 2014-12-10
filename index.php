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
       
require_once('./krumo/class.krumo.php');

require_once(__DIR__ . '/../../config.php');
require_once($CFG->libdir . '/adminlib.php');
require_once($CFG->dirroot . '/local/sqlgenerator/locallib.php');
$PAGE->set_context(context_system::instance());

//$mform = new local_sqlgenerator_form(new moodle_url('/local/sqlgenerator/'));

global $DB;
global $CFG;
$component= optional_param('component', '', PARAM_PATH);

//admin_externalpage_setup('local_sqlgenerator', '', $component);

$PAGE->set_url('/admin/sqlgenerator.php');

$mform = new local_sqlgenerator_form(new moodle_url('/local/sqlgenerator/'));
$output = $PAGE->get_renderer('local_sqlgenerator');
//redirect(new moodle_url('/local/sqlgenerator/'));
if ($data = $mform->get_data()) {
 generate_sql($data->component,"component.sql");
}
echo $OUTPUT->header();
$mform->display();
echo $OUTPUT->footer();

function generate_sql($component,$outputfile){
global $DB;
global $CFG;
$dbmanager=$DB->get_manager();
$dbmanager->generator->foreign_keys=true;
$xmldb_file = new xmldb_file("$CFG->libdir/db/install.xml");
  if (!$xmldb_file->fileExists()) {
            throw new ddl_exception('ddlxmlfileerror', null, 'File does not exist');
        }
$loaded = $xmldb_file->loadXMLStructure();
$xmldb_structure = $xmldb_file->getStructure();

$sqlarr = $dbmanager->generator->getCreateStructureSQL($xmldb_structure);

$fh = fopen($outputfile, 'a') or die("can't open file");
foreach ($sqlarr as $sql) {
        $sql=str_replace("CREATE TABLE",";CREATE TABLE",$sql);
        $sql=preg_replace("/ALTER TABLE(.*)COMMENT/"," COMMENT",$sql);
        $sql=preg_replace("/CREATE UNIQUE INDEX(.*)\)/","",$sql);
        $sql=preg_replace("/CREATE INDEX(.*)\)/","",$sql);
        fwrite($fh, $sql); 
}
  fclose($fh);
  print "<p>Done </p>";

}