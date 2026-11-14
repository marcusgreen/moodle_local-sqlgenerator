set -e

java -jar schemaspy-6.1.0.jar -noexportedkeys -v -imageformat=svg -meta=meta.xml -desc='Moodle 5.3 database schema with additional foreign key relationships see http://www.examulator.com/er' -template=./templates/

# Export rows from every non-empty table of the Moodle site database to HTML
# and link them from the SchemaSpy table pages, then check no site host name
# is left in them. The ERD database has no rows. See check_export_503.sh.
sh check_export_503.sh
