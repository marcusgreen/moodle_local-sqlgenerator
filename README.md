moodle_local-sqlgenerator
=========================
Marcus Green January 2015

Generate sql statements from Moodle install to be used in generating ER diagrams. The morekeys.xml file is designed to contain any 
additional pk/fk relationships that do not appear in the code but you may consider are implied by the data. This uses the standard xml tags as defined by dbxml except it uses a convention whereby the first part of the name of the key contains the string _erd_ to indicate
that the first part is the table name. So for a key named user_preferences_erd_user_id the code would work out that this belonged in the user_preferences table. 

Read more about this plugin here
https://github.com/marcusgreen/moodle_local-sqlgenerator/wiki

The code only looks at the install files it does not interrogate the tables installs. I have done no checking
for security issues at all so I recommend only running it on Moodle test installs. It loops through your source directories
and so may have a significant performance impact (though probably only for a minute or so), so that's another
reason for not running on a live system with real users.

You may need to increase the max_execution_time  value in your php.ini. On a machine with 16GB of RAM and an i7 chip I put the value up to 360
Files generated from the web page (create_tables_moodle.sql, add_foreign_keys.sql, schemaspy.properties,
table_xml.html and pluginxml/) are written to $CFG->dataroot/local_sqlgenerator/, because the plugin
folder is usually not writable by the web server user. The exact path is shown after generation.

To run SchemaSpy, change to the output folder and point it at the generated properties file, e.g.

cd local/sqlgenerator/output
java -jar schemaspy-6.1.0.jar -configFile /path/to/moodledata/local_sqlgenerator/schemaspy.properties -imageformat=svg -meta=meta.xml -template=./templates/
To see diagrams generated from the output of this plugin see here
http://www.examulator.com/er/

To create the database that is used for the diagrams use this command line

mysql  -umoodle -p -f < /path/to/moodledata/local_sqlgenerator/create_tables_moodle.sql

The -f parameter is to force the process to continue if errors occur. There is at least one error triggered by an anomoly in the primary/foreign keys


