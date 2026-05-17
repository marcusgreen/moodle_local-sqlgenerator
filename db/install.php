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
 * Post-install hook: symlinks codemods files into Moodle core lib directories.
 * Requires Linux (symlink support). Replaces manual copy_mods.sh workflow.
 *
 * @package    local_sqlgenerator
 */

defined('MOODLE_INTERNAL') || die();

function xmldb_local_sqlgenerator_install() {
    global $CFG;

    $codemods = $CFG->dirroot . '/local/sqlgenerator/codemods';

    $links = [
        "$codemods/xmldb_field.php"            => $CFG->dirroot . '/lib/xmldb/xmldb_field.php',
        "$codemods/xmldb_structure.php"        => $CFG->dirroot . '/lib/xmldb/xmldb_structure.php',
        "$codemods/sql_generator.php"          => $CFG->dirroot . '/lib/ddl/sql_generator.php',
        "$codemods/mysql_sql_generator.php"    => $CFG->dirroot . '/lib/ddl/mysql_sql_generator.php',
    ];

    foreach ($links as $target => $link) {
        if (is_link($link)) {
            unlink($link);
        } else if (is_file($link)) {
            rename($link, $link . '.original');
        }
        if (!symlink($target, $link)) {
            throw new moodle_exception('cannotsymlink', 'local_sqlgenerator', '', $link);
        }
    }

    return true;
}
