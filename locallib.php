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
 * Code checker library code.
 *
 * @package    local_sqlgenerator
 * @copyright  2014 Marcus Green
 * @license    http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */
defined('MOODLE_INTERNAL') || die;

require_once($CFG->libdir . '/formslib.php');

/**
 * Directory for files generated from the web interface.
 *
 * Uses dataroot because the plugin folder is usually not writable by the web server user.
 *
 * @param string $subdir optional subdirectory to create within the output directory
 * @return string absolute path to the directory, created if necessary
 */
function local_sqlgenerator_output_dir(string $subdir = ''): string {
    global $CFG;
    $dir = $CFG->dataroot . '/local_sqlgenerator';
    if ($subdir !== '') {
        $dir .= '/' . $subdir;
    }
    return make_writable_directory($dir);
}

/**
 * Interactive form for the SQL Generator.
 *
 * @copyright  2014 Marcus Green
 * @license    http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */
class local_sqlgenerator_form extends moodleform {

    protected function definition() {
        global $CFG;
        $mform = $this->_form;
        $mform->addElement('text', 'pluginfolder', get_string('pluginfolder', 'local_sqlgenerator'));
        $mform->addHelpButton('pluginfolder', 'pluginfolder', 'local_sqlgenerator');
        $mform->setType('pluginfolder', PARAM_TEXT);
        $mform->addElement('text', 'targetdatabase', get_string('targetdatabase', 'local_sqlgenerator'));
        $mform->addHelpButton('targetdatabase', 'targetdatabase', 'local_sqlgenerator');
        $mform->setType('targetdatabase', PARAM_TEXT);
        $mform->setDefault('targetdatabase',$CFG->dbname .'_erd');
        $mform->addElement('submit', 'submitbutton', get_string('generate', 'local_sqlgenerator'));
        $mform->addElement('submit', 'checkmorekeys', 'Check MoreKeys.xml');
        $mform->addElement('submit', 'writexml', 'Write XML');
    }

}
