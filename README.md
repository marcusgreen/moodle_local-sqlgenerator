moodle_local-sqlgenerator
=========================
Marcus Green January 2015

Generate sql CREATE TABLE statements that will install an instance of Moodle. A standard Moodle installation
will discard all foreign key relationship and field comments. This preserves that information. The resulting
sql can be used to 'reverse engineer' documentation for the schema tools such as MySQL Workbench  (https://www.mysql.com/products/workbench/) and SchemaSpy (http://schemaspy.org/)

The morekeys.xml file is designed to contain any  additional pk/fk relationships that do not appear in the code but you may consider are implied by the data and suggested by the orphaned tables section of the output of SchemaSpy.  This uses the standard xml tags as defined by dbxml except it uses a convention whereby the first part of the name of the key contains the string _erd_ to indicate
that the first part is the table name. So for a key named user_preferences_erd_user_id the code would work out that this belonged in the user_preferences table.

I have done no checking for security issues at all so I recommend only running it on Moodle test installs. It loops through your source directories and parses the install.xml files and so may have a significant performance impact (though probably only for a minute or so), so that's another
reason for not running on a live system with real users.

You may need to increase the max_execution_time  value in your php.ini. On a machine with 16GB of RAM and an i7 chip I put the value up to 360
The SQL code is called create_tables.sql and  output to a folder called output (i.e. moodle\local\sqlgenerator\output
To see diagrams generated from the output of this plugin see here
http://www.examulator.com/er/


