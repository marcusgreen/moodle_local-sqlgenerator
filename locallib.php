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
        $mform->addElement('submit', 'submitbutton', get_string('generate', 'local_sqlgenerator'));
        $mform->addElement('submit', 'checkmorekeys', 'Check MoreKeys.xml');
        $mform->addElement('submit', 'writexml', 'Write XML');
    }

}
