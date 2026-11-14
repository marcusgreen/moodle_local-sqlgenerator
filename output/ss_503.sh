set -e

java -jar schemaspy-6.1.0.jar -noexportedkeys -v -imageformat=svg -meta=meta.xml -desc='Moodle 5.3 database schema with additional foreign key relationships see http://www.examulator.com/er' -template=./templates/

# Export table rows to HTML and link them from the SchemaSpy table pages.
# Credentials come from schemaspy.properties, which is not committed.
prop() { sed -n "s/^schemaspy\.$1=//p" schemaspy.properties; }
php ../export_to_html.php -u "$(prop u)" -p "$(prop p)" -d "$(prop db)" \
    -c schemaspy.properties --no-prefix
