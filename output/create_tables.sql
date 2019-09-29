/* Moodle version 2019052000.04 Release 3.7+ (Build: 20190614) SQL code */; CREATE TABLE mdl_config (
    id BIGINT(10) NOT NULL auto_increment,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    value LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY mdl_conf_nam2_uix (name)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Moodle configuration variables'; CREATE TABLE mdl_config_plugins (
    id BIGINT(10) NOT NULL auto_increment,
    plugin VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'core',
    name VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    value LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY mdl_confplug_plunam2_uix (plugin, name)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Moodle modules and plugins configuration variables'; CREATE TABLE mdl_config_log (
    id BIGINT(10) NOT NULL auto_increment,
    userid BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
    plugin VARCHAR(100) COLLATE utf8mb4_unicode_ci,
    name VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    value LONGTEXT COLLATE utf8mb4_unicode_ci,
    oldvalue LONGTEXT COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_conflog_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id)
, KEY mdl_conflog_tim2_ix (timemodified)
, KEY mdl_conflog_use4_ix (userid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Changes done in server configuration through admin UI'; CREATE TABLE mdl_upgrade_log (
    id BIGINT(10) NOT NULL auto_increment,
    type BIGINT(10) NOT NULL,
    plugin VARCHAR(100) COLLATE utf8mb4_unicode_ci,
    version VARCHAR(100) COLLATE utf8mb4_unicode_ci,
    targetversion VARCHAR(100) COLLATE utf8mb4_unicode_ci,
    info VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    details LONGTEXT COLLATE utf8mb4_unicode_ci,
    backtrace LONGTEXT COLLATE utf8mb4_unicode_ci,
    userid BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_upgrlog_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id)
, KEY mdl_upgrlog_tim2_ix (timemodified)
, KEY mdl_upgrlog_typtim2_ix (type, timemodified)
, KEY mdl_upgrlog_use4_ix (userid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Upgrade logging'; CREATE TABLE mdl_course (
    id BIGINT(10) NOT NULL auto_increment,
    category BIGINT(10) NOT NULL DEFAULT 0,
    sortorder BIGINT(10) NOT NULL DEFAULT 0,
    fullname VARCHAR(254) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    shortname VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    idnumber VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    summary LONGTEXT COLLATE utf8mb4_unicode_ci,
    summaryformat TINYINT(2) NOT NULL DEFAULT 0,
    format VARCHAR(21) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'topics',
    showgrades TINYINT(2) NOT NULL DEFAULT 1,
    newsitems MEDIUMINT(5) NOT NULL DEFAULT 1,
    startdate BIGINT(10) NOT NULL DEFAULT 0,
    enddate BIGINT(10) NOT NULL DEFAULT 0,
    marker BIGINT(10) NOT NULL DEFAULT 0,
    maxbytes BIGINT(10) NOT NULL DEFAULT 0,
    legacyfiles SMALLINT(4) NOT NULL DEFAULT 0,
    showreports SMALLINT(4) NOT NULL DEFAULT 0,
    visible TINYINT(1) NOT NULL DEFAULT 1,
    visibleold TINYINT(1) NOT NULL DEFAULT 1,
    groupmode SMALLINT(4) NOT NULL DEFAULT 0,
    groupmodeforce SMALLINT(4) NOT NULL DEFAULT 0,
    defaultgroupingid BIGINT(10) NOT NULL DEFAULT 0,
    lang VARCHAR(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    calendartype VARCHAR(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    theme VARCHAR(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    timecreated BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
    requested TINYINT(1) NOT NULL DEFAULT 0,
    enablecompletion TINYINT(1) NOT NULL DEFAULT 0,
    completionnotify TINYINT(1) NOT NULL DEFAULT 0,
    cacherev BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_cour_cat2_ix (category)
, KEY mdl_cour_idn2_ix (idnumber)
, KEY mdl_cour_sho2_ix (shortname)
, KEY mdl_cour_sor2_ix (sortorder)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Central course table'; CREATE TABLE mdl_course_categories (
    id BIGINT(10) NOT NULL auto_increment,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    idnumber VARCHAR(100) COLLATE utf8mb4_unicode_ci,
    description LONGTEXT COLLATE utf8mb4_unicode_ci,
    descriptionformat TINYINT(2) NOT NULL DEFAULT 0,
    parent BIGINT(10) NOT NULL DEFAULT 0,
    sortorder BIGINT(10) NOT NULL DEFAULT 0,
    coursecount BIGINT(10) NOT NULL DEFAULT 0,
    visible TINYINT(1) NOT NULL DEFAULT 1,
    visibleold TINYINT(1) NOT NULL DEFAULT 1,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
    depth BIGINT(10) NOT NULL DEFAULT 0,
    path VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    theme VARCHAR(50) COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_courcate_par2_fk FOREIGN KEY (parent) REFERENCES mdl_course_categories (id)
, KEY mdl_courcate_par4_ix (parent)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Course categories'; CREATE TABLE mdl_course_completion_aggr_methd (
    id BIGINT(10) NOT NULL auto_increment,
    course BIGINT(10) NOT NULL DEFAULT 0,
    criteriatype BIGINT(10),
    method TINYINT(1) NOT NULL DEFAULT 0,
    value NUMERIC(10,5),
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_courcompaggrmeth_cou2_ix (course)
, KEY mdl_courcompaggrmeth_cri2_ix (criteriatype)
, UNIQUE KEY mdl_courcompaggrmeth_couc2_uix (course, criteriatype)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Course completion aggregation methods for criteria'; CREATE TABLE mdl_course_completion_criteria (
    id BIGINT(10) NOT NULL auto_increment,
    course BIGINT(10) NOT NULL DEFAULT 0,
    criteriatype BIGINT(10) NOT NULL DEFAULT 0,
    module VARCHAR(100) COLLATE utf8mb4_unicode_ci,
    moduleinstance BIGINT(10),
    courseinstance BIGINT(10),
    enrolperiod BIGINT(10),
    timeend BIGINT(10),
    gradepass NUMERIC(10,5),
    role BIGINT(10),
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_courcompcrit_cou2_ix (course)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Course completion criteria'; CREATE TABLE mdl_course_completion_crit_compl (
    id BIGINT(10) NOT NULL auto_increment,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    course BIGINT(10) NOT NULL DEFAULT 0,
    criteriaid BIGINT(10) NOT NULL DEFAULT 0,
    gradefinal NUMERIC(10,5),
    unenroled BIGINT(10),
    timecompleted BIGINT(10),
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_courcompcritcomp_use2_ix (userid)
, KEY mdl_courcompcritcomp_cou2_ix (course)
, KEY mdl_courcompcritcomp_cri2_ix (criteriaid)
, KEY mdl_courcompcritcomp_tim2_ix (timecompleted)
, UNIQUE KEY mdl_courcompcritcomp_usec2_uix (userid, course, criteriaid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Course completion user records'; CREATE TABLE mdl_course_completions (
    id BIGINT(10) NOT NULL auto_increment,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    course BIGINT(10) NOT NULL DEFAULT 0,
    timeenrolled BIGINT(10) NOT NULL DEFAULT 0,
    timestarted BIGINT(10) NOT NULL DEFAULT 0,
    timecompleted BIGINT(10),
    reaggregate BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_courcomp_use2_ix (userid)
, KEY mdl_courcomp_cou2_ix (course)
, KEY mdl_courcomp_tim2_ix (timecompleted)
, UNIQUE KEY mdl_courcomp_usecou2_uix (userid, course)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Course completion records'; CREATE TABLE mdl_enrol (
    id BIGINT(10) NOT NULL auto_increment,
    enrol VARCHAR(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    status BIGINT(10) NOT NULL DEFAULT 0,
    courseid BIGINT(10) NOT NULL,
    sortorder BIGINT(10) NOT NULL DEFAULT 0,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    enrolperiod BIGINT(10) DEFAULT 0,
    enrolstartdate BIGINT(10) DEFAULT 0,
    enrolenddate BIGINT(10) DEFAULT 0,
    expirynotify TINYINT(1) DEFAULT 0,
    expirythreshold BIGINT(10) DEFAULT 0,
    notifyall TINYINT(1) DEFAULT 0,
    password VARCHAR(50) COLLATE utf8mb4_unicode_ci,
    cost VARCHAR(20) COLLATE utf8mb4_unicode_ci,
    currency VARCHAR(3) COLLATE utf8mb4_unicode_ci,
    roleid BIGINT(10) DEFAULT 0,
    customint1 BIGINT(10),
    customint2 BIGINT(10),
    customint3 BIGINT(10),
    customint4 BIGINT(10),
    customint5 BIGINT(10),
    customint6 BIGINT(10),
    customint7 BIGINT(10),
    customint8 BIGINT(10),
    customchar1 VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    customchar2 VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    customchar3 VARCHAR(1333) COLLATE utf8mb4_unicode_ci,
    customdec1 NUMERIC(12,7),
    customdec2 NUMERIC(12,7),
    customtext1 LONGTEXT COLLATE utf8mb4_unicode_ci,
    customtext2 LONGTEXT COLLATE utf8mb4_unicode_ci,
    customtext3 LONGTEXT COLLATE utf8mb4_unicode_ci,
    customtext4 LONGTEXT COLLATE utf8mb4_unicode_ci,
    timecreated BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_enro_cou2_fk FOREIGN KEY (courseid) REFERENCES mdl_course (id)
, KEY mdl_enro_enr2_ix (enrol)
, KEY mdl_enro_cou4_ix (courseid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Instances of enrolment plugins used in courses, fields marke'; CREATE TABLE mdl_user_enrolments (
    id BIGINT(10) NOT NULL auto_increment,
    status BIGINT(10) NOT NULL DEFAULT 0,
    enrolid BIGINT(10) NOT NULL,
    userid BIGINT(10) NOT NULL,
    timestart BIGINT(10) NOT NULL DEFAULT 0,
    timeend BIGINT(10) NOT NULL DEFAULT 2147483647,
    modifierid BIGINT(10) NOT NULL DEFAULT 0,
    timecreated BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_userenro_enr2_fk FOREIGN KEY (enrolid) REFERENCES mdl_enrol (id),
CONSTRAINT mdl_userenro_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id),
CONSTRAINT mdl_userenro_mod2_fk FOREIGN KEY (modifierid) REFERENCES mdl_user (id)
, UNIQUE KEY mdl_userenro_enruse2_uix (enrolid, userid)
, KEY mdl_userenro_enr4_ix (enrolid)
, KEY mdl_userenro_use4_ix (userid)
, KEY mdl_userenro_mod4_ix (modifierid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Users participating in courses (aka enrolled users) - everyb'; CREATE TABLE mdl_course_modules (
    id BIGINT(10) NOT NULL auto_increment,
    course BIGINT(10) NOT NULL DEFAULT 0,
    module BIGINT(10) NOT NULL DEFAULT 0,
    instance BIGINT(10) NOT NULL DEFAULT 0,
    section BIGINT(10) NOT NULL DEFAULT 0,
    idnumber VARCHAR(100) COLLATE utf8mb4_unicode_ci,
    added BIGINT(10) NOT NULL DEFAULT 0,
    score SMALLINT(4) NOT NULL DEFAULT 0,
    indent MEDIUMINT(5) NOT NULL DEFAULT 0,
    visible TINYINT(1) NOT NULL DEFAULT 1,
    visibleoncoursepage TINYINT(1) NOT NULL DEFAULT 1,
    visibleold TINYINT(1) NOT NULL DEFAULT 1,
    groupmode SMALLINT(4) NOT NULL DEFAULT 0,
    groupingid BIGINT(10) NOT NULL DEFAULT 0,
    completion TINYINT(1) NOT NULL DEFAULT 0,
    completiongradeitemnumber BIGINT(10),
    completionview TINYINT(1) NOT NULL DEFAULT 0,
    completionexpected BIGINT(10) NOT NULL DEFAULT 0,
    showdescription TINYINT(1) NOT NULL DEFAULT 0,
    availability LONGTEXT COLLATE utf8mb4_unicode_ci,
    deletioninprogress TINYINT(1) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_courmodu_gro2_fk FOREIGN KEY (groupingid) REFERENCES mdl_groupings (id)
, KEY mdl_courmodu_vis2_ix (visible)
, KEY mdl_courmodu_cou2_ix (course)
, KEY mdl_courmodu_mod2_ix (module)
, KEY mdl_courmodu_ins2_ix (instance)
, KEY mdl_courmodu_idncou2_ix (idnumber, course)
, KEY mdl_courmodu_gro4_ix (groupingid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='course_modules table retrofitted from MySQL'; CREATE TABLE mdl_course_modules_completion (
    id BIGINT(10) NOT NULL auto_increment,
    coursemoduleid BIGINT(10) NOT NULL,
    userid BIGINT(10) NOT NULL,
    completionstate TINYINT(1) NOT NULL,
    viewed TINYINT(1),
    overrideby BIGINT(10),
    timemodified BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_courmoducomp_cou2_ix (coursemoduleid)
, UNIQUE KEY mdl_courmoducomp_usecou2_uix (userid, coursemoduleid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stores the completion state (completed or not completed, etc'; CREATE TABLE mdl_course_sections (
    id BIGINT(10) NOT NULL auto_increment,
    course BIGINT(10) NOT NULL DEFAULT 0,
    section BIGINT(10) NOT NULL DEFAULT 0,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    summary LONGTEXT COLLATE utf8mb4_unicode_ci,
    summaryformat TINYINT(2) NOT NULL DEFAULT 0,
    sequence LONGTEXT COLLATE utf8mb4_unicode_ci,
    visible TINYINT(1) NOT NULL DEFAULT 1,
    availability LONGTEXT COLLATE utf8mb4_unicode_ci,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY mdl_coursect_cousec2_uix (course, section)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='to define the sections for each course'; CREATE TABLE mdl_course_request (
    id BIGINT(10) NOT NULL auto_increment,
    fullname VARCHAR(254) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    shortname VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    summary LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    summaryformat TINYINT(2) NOT NULL DEFAULT 0,
    category BIGINT(10) NOT NULL DEFAULT 0,
    reason LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    requester BIGINT(10) NOT NULL DEFAULT 0,
    password VARCHAR(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_courrequ_sho2_ix (shortname)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='course requests'; CREATE TABLE mdl_course_format_options (
    id BIGINT(10) NOT NULL auto_increment,
    courseid BIGINT(10) NOT NULL,
    format VARCHAR(21) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    sectionid BIGINT(10) NOT NULL DEFAULT 0,
    name VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    value LONGTEXT COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_courformopti_cou2_fk FOREIGN KEY (courseid) REFERENCES mdl_course (id)
, UNIQUE KEY mdl_courformopti_couforse2_uix (courseid, format, sectionid, name)
, KEY mdl_courformopti_cou4_ix (courseid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stores format-specific options for the course or course sect'; CREATE TABLE mdl_filter_active (
    id BIGINT(10) NOT NULL auto_increment,
    filter VARCHAR(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    contextid BIGINT(10) NOT NULL,
    active SMALLINT(4) NOT NULL,
    sortorder BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_filtacti_con2_fk FOREIGN KEY (contextid) REFERENCES mdl_context (id)
, UNIQUE KEY mdl_filtacti_confil2_uix (contextid, filter)
, KEY mdl_filtacti_con4_ix (contextid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stores information about which filters are active in which c'; CREATE TABLE mdl_filter_config (
    id BIGINT(10) NOT NULL auto_increment,
    filter VARCHAR(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    contextid BIGINT(10) NOT NULL,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    value LONGTEXT COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_filtconf_con2_fk FOREIGN KEY (contextid) REFERENCES mdl_context (id)
, UNIQUE KEY mdl_filtconf_confilnam2_uix (contextid, filter, name)
, KEY mdl_filtconf_con4_ix (contextid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stores per-context configuration settings for filters which '; CREATE TABLE mdl_event (
    id BIGINT(10) NOT NULL auto_increment,
    name LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    description LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    format SMALLINT(4) NOT NULL DEFAULT 0,
    categoryid BIGINT(10) NOT NULL DEFAULT 0,
    courseid BIGINT(10) NOT NULL DEFAULT 0,
    groupid BIGINT(10) NOT NULL DEFAULT 0,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    repeatid BIGINT(10) NOT NULL DEFAULT 0,
    modulename VARCHAR(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    instance BIGINT(10) NOT NULL DEFAULT 0,
    type SMALLINT(4) NOT NULL DEFAULT 0,
    eventtype VARCHAR(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    timestart BIGINT(10) NOT NULL DEFAULT 0,
    timeduration BIGINT(10) NOT NULL DEFAULT 0,
    timesort BIGINT(10),
    visible SMALLINT(4) NOT NULL DEFAULT 1,
    uuid VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    sequence BIGINT(10) NOT NULL DEFAULT 1,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
    subscriptionid BIGINT(10),
    priority BIGINT(10),
    location LONGTEXT COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_even_cat2_fk FOREIGN KEY (categoryid) REFERENCES mdl_course_categories (id),
CONSTRAINT mdl_even_sub2_fk FOREIGN KEY (subscriptionid) REFERENCES mdl_event_subscriptions (id)
, KEY mdl_even_cou2_ix (courseid)
, KEY mdl_even_use2_ix (userid)
, KEY mdl_even_tim3_ix (timestart)
, KEY mdl_even_tim4_ix (timeduration)
, KEY mdl_even_uui2_ix (uuid)
, KEY mdl_even_typtim2_ix (type, timesort)
, KEY mdl_even_grocoucatvisuse2_ix (groupid, courseid, categoryid, visible, userid)
, KEY mdl_even_cat4_ix (categoryid)
, KEY mdl_even_sub4_ix (subscriptionid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='For everything with a time associated to it'; CREATE TABLE mdl_cache_filters (
    id BIGINT(10) NOT NULL auto_increment,
    filter VARCHAR(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    version BIGINT(10) NOT NULL DEFAULT 0,
    md5key VARCHAR(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    rawtext LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_cachfilt_filmd52_ix (filter, md5key)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='For keeping information about cached data'; CREATE TABLE mdl_log (
    id BIGINT(10) NOT NULL auto_increment,
    time BIGINT(10) NOT NULL DEFAULT 0,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    ip VARCHAR(45) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    course BIGINT(10) NOT NULL DEFAULT 0,
    module VARCHAR(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    cmid BIGINT(10) NOT NULL DEFAULT 0,
    action VARCHAR(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    url VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    info VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_log_coumodact2_ix (course, module, action)
, KEY mdl_log_tim2_ix (time)
, KEY mdl_log_act2_ix (action)
, KEY mdl_log_usecou2_ix (userid, course)
, KEY mdl_log_cmi2_ix (cmid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Every action is logged as far as possible'; CREATE TABLE mdl_log_queries (
    id BIGINT(10) NOT NULL auto_increment,
    qtype MEDIUMINT(5) NOT NULL,
    sqltext LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    sqlparams LONGTEXT COLLATE utf8mb4_unicode_ci,
    error MEDIUMINT(5) NOT NULL DEFAULT 0,
    info LONGTEXT COLLATE utf8mb4_unicode_ci,
    backtrace LONGTEXT COLLATE utf8mb4_unicode_ci,
    exectime NUMERIC(10,5) NOT NULL,
    timelogged BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Logged database queries.'; CREATE TABLE mdl_log_display (
    id BIGINT(10) NOT NULL auto_increment,
    module VARCHAR(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    action VARCHAR(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    mtable VARCHAR(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    field VARCHAR(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    component VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY mdl_logdisp_modact2_uix (module, action)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='For a particular module/action, specifies a moodle table/fie'; CREATE TABLE mdl_message (
    id BIGINT(10) NOT NULL auto_increment,
    useridfrom BIGINT(10) NOT NULL DEFAULT 0,
    useridto BIGINT(10) NOT NULL DEFAULT 0,
    subject LONGTEXT COLLATE utf8mb4_unicode_ci,
    fullmessage LONGTEXT COLLATE utf8mb4_unicode_ci,
    fullmessageformat SMALLINT(4) DEFAULT 0,
    fullmessagehtml LONGTEXT COLLATE utf8mb4_unicode_ci,
    smallmessage LONGTEXT COLLATE utf8mb4_unicode_ci,
    notification TINYINT(1) DEFAULT 0,
    contexturl LONGTEXT COLLATE utf8mb4_unicode_ci,
    contexturlname LONGTEXT COLLATE utf8mb4_unicode_ci,
    timecreated BIGINT(10) NOT NULL DEFAULT 0,
    timeuserfromdeleted BIGINT(10) NOT NULL DEFAULT 0,
    timeusertodeleted BIGINT(10) NOT NULL DEFAULT 0,
    component VARCHAR(100) COLLATE utf8mb4_unicode_ci,
    eventtype VARCHAR(100) COLLATE utf8mb4_unicode_ci,
    customdata LONGTEXT COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_mess_useusetimtim2_ix (useridfrom, useridto, timeuserfromdeleted, timeusertodeleted)
, KEY mdl_mess_usetimnot3_ix (useridfrom, timeuserfromdeleted, notification)
, KEY mdl_mess_usetimnot4_ix (useridto, timeusertodeleted, notification)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stores all unread messages'; CREATE TABLE mdl_message_read (
    id BIGINT(10) NOT NULL auto_increment,
    useridfrom BIGINT(10) NOT NULL DEFAULT 0,
    useridto BIGINT(10) NOT NULL DEFAULT 0,
    subject LONGTEXT COLLATE utf8mb4_unicode_ci,
    fullmessage LONGTEXT COLLATE utf8mb4_unicode_ci,
    fullmessageformat SMALLINT(4) DEFAULT 0,
    fullmessagehtml LONGTEXT COLLATE utf8mb4_unicode_ci,
    smallmessage LONGTEXT COLLATE utf8mb4_unicode_ci,
    notification TINYINT(1) DEFAULT 0,
    contexturl LONGTEXT COLLATE utf8mb4_unicode_ci,
    contexturlname LONGTEXT COLLATE utf8mb4_unicode_ci,
    timecreated BIGINT(10) NOT NULL DEFAULT 0,
    timeread BIGINT(10) NOT NULL DEFAULT 0,
    timeuserfromdeleted BIGINT(10) NOT NULL DEFAULT 0,
    timeusertodeleted BIGINT(10) NOT NULL DEFAULT 0,
    component VARCHAR(100) COLLATE utf8mb4_unicode_ci,
    eventtype VARCHAR(100) COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_messread_useusetimtim2_ix (useridfrom, useridto, timeuserfromdeleted, timeusertodeleted)
, KEY mdl_messread_nottim2_ix (notification, timeread)
, KEY mdl_messread_usetimnot3_ix (useridfrom, timeuserfromdeleted, notification)
, KEY mdl_messread_usetimnot4_ix (useridto, timeusertodeleted, notification)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stores all messages that have been read'; CREATE TABLE mdl_messages (
    id BIGINT(10) NOT NULL auto_increment,
    useridfrom BIGINT(10) NOT NULL,
    conversationid BIGINT(10) NOT NULL,
    subject LONGTEXT COLLATE utf8mb4_unicode_ci,
    fullmessage LONGTEXT COLLATE utf8mb4_unicode_ci,
    fullmessageformat TINYINT(1) NOT NULL DEFAULT 0,
    fullmessagehtml LONGTEXT COLLATE utf8mb4_unicode_ci,
    smallmessage LONGTEXT COLLATE utf8mb4_unicode_ci,
    timecreated BIGINT(10) NOT NULL,
    fullmessagetrust TINYINT(2) NOT NULL DEFAULT 0,
    customdata LONGTEXT COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_mess_use2_fk FOREIGN KEY (useridfrom) REFERENCES mdl_user (id),
CONSTRAINT mdl_mess_con2_fk FOREIGN KEY (conversationid) REFERENCES mdl_message_conversations (id)
, KEY mdl_mess_contim2_ix (conversationid, timecreated)
, KEY mdl_mess_use4_ix (useridfrom)
, KEY mdl_mess_con4_ix (conversationid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stores all messages'; CREATE TABLE mdl_message_conversations (
    id BIGINT(10) NOT NULL auto_increment,
    type BIGINT(10) NOT NULL DEFAULT 1,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    convhash VARCHAR(40) COLLATE utf8mb4_unicode_ci,
    component VARCHAR(100) COLLATE utf8mb4_unicode_ci,
    itemtype VARCHAR(100) COLLATE utf8mb4_unicode_ci,
    itemid BIGINT(10),
    contextid BIGINT(10),
    enabled TINYINT(1) NOT NULL DEFAULT 0,
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10),
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_messconv_con2_fk FOREIGN KEY (contextid) REFERENCES mdl_context (id)
, KEY mdl_messconv_typ2_ix (type)
, KEY mdl_messconv_con3_ix (convhash)
, KEY mdl_messconv_comiteitecon2_ix (component, itemtype, itemid, contextid)
, KEY mdl_messconv_con5_ix (contextid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stores all message conversations'; CREATE TABLE mdl_message_conversation_members (
    id BIGINT(10) NOT NULL auto_increment,
    conversationid BIGINT(10) NOT NULL,
    userid BIGINT(10) NOT NULL,
    timecreated BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_messconvmemb_con2_fk FOREIGN KEY (conversationid) REFERENCES mdl_message_conversations (id),
CONSTRAINT mdl_messconvmemb_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id)
, KEY mdl_messconvmemb_con4_ix (conversationid)
, KEY mdl_messconvmemb_use4_ix (userid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stores all members in a conversations'; CREATE TABLE mdl_message_conversation_actions (
    id BIGINT(10) NOT NULL auto_increment,
    userid BIGINT(10) NOT NULL,
    conversationid BIGINT(10) NOT NULL,
    action BIGINT(10) NOT NULL,
    timecreated BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_messconvacti_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id),
CONSTRAINT mdl_messconvacti_con2_fk FOREIGN KEY (conversationid) REFERENCES mdl_message_conversations (id)
, KEY mdl_messconvacti_use4_ix (userid)
, KEY mdl_messconvacti_con4_ix (conversationid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stores all per-user actions on individual conversations'; CREATE TABLE mdl_message_user_actions (
    id BIGINT(10) NOT NULL auto_increment,
    userid BIGINT(10) NOT NULL,
    messageid BIGINT(10) NOT NULL,
    action BIGINT(10) NOT NULL,
    timecreated BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_messuseracti_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id),
CONSTRAINT mdl_messuseracti_mes2_fk FOREIGN KEY (messageid) REFERENCES mdl_messages (id)
, UNIQUE KEY mdl_messuseracti_usemesac2_uix (userid, messageid, action)
, KEY mdl_messuseracti_use4_ix (userid)
, KEY mdl_messuseracti_mes4_ix (messageid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stores all per-user actions on individual messages'; CREATE TABLE mdl_notifications (
    id BIGINT(10) NOT NULL auto_increment,
    useridfrom BIGINT(10) NOT NULL,
    useridto BIGINT(10) NOT NULL,
    subject LONGTEXT COLLATE utf8mb4_unicode_ci,
    fullmessage LONGTEXT COLLATE utf8mb4_unicode_ci,
    fullmessageformat TINYINT(1) NOT NULL DEFAULT 0,
    fullmessagehtml LONGTEXT COLLATE utf8mb4_unicode_ci,
    smallmessage LONGTEXT COLLATE utf8mb4_unicode_ci,
    component VARCHAR(100) COLLATE utf8mb4_unicode_ci,
    eventtype VARCHAR(100) COLLATE utf8mb4_unicode_ci,
    contexturl LONGTEXT COLLATE utf8mb4_unicode_ci,
    contexturlname LONGTEXT COLLATE utf8mb4_unicode_ci,
    timeread BIGINT(10),
    timecreated BIGINT(10) NOT NULL,
    customdata LONGTEXT COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_noti_use2_fk FOREIGN KEY (useridto) REFERENCES mdl_user (id)
, KEY mdl_noti_use3_ix (useridfrom)
, KEY mdl_noti_use5_ix (useridto)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stores all notifications'; CREATE TABLE mdl_message_contacts (
    id BIGINT(10) NOT NULL auto_increment,
    userid BIGINT(10) NOT NULL,
    contactid BIGINT(10) NOT NULL,
    timecreated BIGINT(10),
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_messcont_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id),
CONSTRAINT mdl_messcont_con2_fk FOREIGN KEY (contactid) REFERENCES mdl_user (id)
, UNIQUE KEY mdl_messcont_usecon2_uix (userid, contactid)
, KEY mdl_messcont_use4_ix (userid)
, KEY mdl_messcont_con4_ix (contactid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Maintains lists of contacts between users'; CREATE TABLE mdl_message_contact_requests (
    id BIGINT(10) NOT NULL auto_increment,
    userid BIGINT(10) NOT NULL,
    requesteduserid BIGINT(10) NOT NULL,
    timecreated BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_messcontrequ_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id),
CONSTRAINT mdl_messcontrequ_req2_fk FOREIGN KEY (requesteduserid) REFERENCES mdl_user (id)
, UNIQUE KEY mdl_messcontrequ_usereq2_uix (userid, requesteduserid)
, KEY mdl_messcontrequ_use4_ix (userid)
, KEY mdl_messcontrequ_req4_ix (requesteduserid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Maintains list of contact requests between users'; CREATE TABLE mdl_message_users_blocked (
    id BIGINT(10) NOT NULL auto_increment,
    userid BIGINT(10) NOT NULL,
    blockeduserid BIGINT(10) NOT NULL,
    timecreated BIGINT(10),
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_messuserbloc_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id),
CONSTRAINT mdl_messuserbloc_blo2_fk FOREIGN KEY (blockeduserid) REFERENCES mdl_user (id)
, UNIQUE KEY mdl_messuserbloc_useblo2_uix (userid, blockeduserid)
, KEY mdl_messuserbloc_use4_ix (userid)
, KEY mdl_messuserbloc_blo4_ix (blockeduserid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Maintains lists of blocked users'; CREATE TABLE mdl_modules (
    id BIGINT(10) NOT NULL auto_increment,
    name VARCHAR(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    cron BIGINT(10) NOT NULL DEFAULT 0,
    lastcron BIGINT(10) NOT NULL DEFAULT 0,
    search VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    visible TINYINT(1) NOT NULL DEFAULT 1,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_modu_nam2_ix (name)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='modules available in the site'; CREATE TABLE mdl_my_pages (
    id BIGINT(10) NOT NULL auto_increment,
    userid BIGINT(10) DEFAULT 0,
    name VARCHAR(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    private TINYINT(1) NOT NULL DEFAULT 1,
    sortorder MEDIUMINT(6) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_mypage_usepri2_ix (userid, private)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Extra user pages for the My Moodle system'; CREATE TABLE mdl_sessions (
    id BIGINT(10) NOT NULL auto_increment,
    state BIGINT(10) NOT NULL DEFAULT 0,
    sid VARCHAR(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    userid BIGINT(10) NOT NULL,
    sessdata LONGTEXT COLLATE utf8mb4_unicode_ci,
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
    firstip VARCHAR(45) COLLATE utf8mb4_unicode_ci,
    lastip VARCHAR(45) COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_sess_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id)
, KEY mdl_sess_sta2_ix (state)
, UNIQUE KEY mdl_sess_sid2_uix (sid)
, KEY mdl_sess_tim3_ix (timecreated)
, KEY mdl_sess_tim4_ix (timemodified)
, KEY mdl_sess_use4_ix (userid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Database based session storage - now recommended'; CREATE TABLE mdl_user (
    id BIGINT(10) NOT NULL auto_increment,
    auth VARCHAR(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'manual',
    confirmed TINYINT(1) NOT NULL DEFAULT 0,
    policyagreed TINYINT(1) NOT NULL DEFAULT 0,
    deleted TINYINT(1) NOT NULL DEFAULT 0,
    suspended TINYINT(1) NOT NULL DEFAULT 0,
    mnethostid BIGINT(10) NOT NULL DEFAULT 0,
    username VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    password VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    idnumber VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    firstname VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    lastname VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    email VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    emailstop TINYINT(1) NOT NULL DEFAULT 0,
    icq VARCHAR(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    skype VARCHAR(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    yahoo VARCHAR(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    aim VARCHAR(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    msn VARCHAR(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    phone1 VARCHAR(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    phone2 VARCHAR(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    institution VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    department VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    address VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    city VARCHAR(120) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    country VARCHAR(2) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    lang VARCHAR(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'en',
    calendartype VARCHAR(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'gregorian',
    theme VARCHAR(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    timezone VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '99',
    firstaccess BIGINT(10) NOT NULL DEFAULT 0,
    lastaccess BIGINT(10) NOT NULL DEFAULT 0,
    lastlogin BIGINT(10) NOT NULL DEFAULT 0,
    currentlogin BIGINT(10) NOT NULL DEFAULT 0,
    lastip VARCHAR(45) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    secret VARCHAR(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    picture BIGINT(10) NOT NULL DEFAULT 0,
    url VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    description LONGTEXT COLLATE utf8mb4_unicode_ci,
    descriptionformat TINYINT(2) NOT NULL DEFAULT 1,
    mailformat TINYINT(1) NOT NULL DEFAULT 1,
    maildigest TINYINT(1) NOT NULL DEFAULT 0,
    maildisplay TINYINT(2) NOT NULL DEFAULT 2,
    autosubscribe TINYINT(1) NOT NULL DEFAULT 1,
    trackforums TINYINT(1) NOT NULL DEFAULT 0,
    timecreated BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
    trustbitmask BIGINT(10) NOT NULL DEFAULT 0,
    imagealt VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    lastnamephonetic VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    firstnamephonetic VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    middlename VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    alternatename VARCHAR(255) COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY mdl_user_mneuse2_uix (mnethostid, username)
, KEY mdl_user_del2_ix (deleted)
, KEY mdl_user_con2_ix (confirmed)
, KEY mdl_user_fir3_ix (firstname)
, KEY mdl_user_las4_ix (lastname)
, KEY mdl_user_cit2_ix (city)
, KEY mdl_user_cou2_ix (country)
, KEY mdl_user_las5_ix (lastaccess)
, KEY mdl_user_ema2_ix (email)
, KEY mdl_user_aut2_ix (auth)
, KEY mdl_user_idn2_ix (idnumber)
, KEY mdl_user_fir4_ix (firstnamephonetic)
, KEY mdl_user_las6_ix (lastnamephonetic)
, KEY mdl_user_mid2_ix (middlename)
, KEY mdl_user_alt2_ix (alternatename)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='One record for each person'; CREATE TABLE mdl_user_preferences (
    id BIGINT(10) NOT NULL auto_increment,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    value VARCHAR(1333) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY mdl_userpref_usenam2_uix (userid, name)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Allows modules to store arbitrary user preferences'; CREATE TABLE mdl_user_lastaccess (
    id BIGINT(10) NOT NULL auto_increment,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    courseid BIGINT(10) NOT NULL DEFAULT 0,
    timeaccess BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY mdl_userlast_usecou2_uix (userid, courseid)
, KEY mdl_userlast_use2_ix (userid)
, KEY mdl_userlast_cou2_ix (courseid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='To keep track of course page access times, used in online pa'; CREATE TABLE mdl_user_password_history (
    id BIGINT(10) NOT NULL auto_increment,
    userid BIGINT(10) NOT NULL,
    hash VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    timecreated BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_userpasshist_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id)
, KEY mdl_userpasshist_use4_ix (userid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='A rotating log of hashes of previously used passwords for ea'; CREATE TABLE mdl_scale (
    id BIGINT(10) NOT NULL auto_increment,
    courseid BIGINT(10) NOT NULL DEFAULT 0,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    scale LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    description LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    descriptionformat TINYINT(2) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_scal_cou2_ix (courseid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Defines grading scales'; CREATE TABLE mdl_scale_history (
    id BIGINT(10) NOT NULL auto_increment,
    action BIGINT(10) NOT NULL DEFAULT 0,
    oldid BIGINT(10) NOT NULL,
    source VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    timemodified BIGINT(10),
    loggeduser BIGINT(10),
    courseid BIGINT(10) NOT NULL DEFAULT 0,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    scale LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    description LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_scalhist_old2_fk FOREIGN KEY (oldid) REFERENCES mdl_scale (id),
CONSTRAINT mdl_scalhist_cou2_fk FOREIGN KEY (courseid) REFERENCES mdl_course (id),
CONSTRAINT mdl_scalhist_log2_fk FOREIGN KEY (loggeduser) REFERENCES mdl_user (id)
, KEY mdl_scalhist_act2_ix (action)
, KEY mdl_scalhist_tim2_ix (timemodified)
, KEY mdl_scalhist_old4_ix (oldid)
, KEY mdl_scalhist_cou4_ix (courseid)
, KEY mdl_scalhist_log4_ix (loggeduser)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='History table'; CREATE TABLE mdl_stats_daily (
    id BIGINT(10) NOT NULL auto_increment,
    courseid BIGINT(10) NOT NULL DEFAULT 0,
    timeend BIGINT(10) NOT NULL DEFAULT 0,
    roleid BIGINT(10) NOT NULL DEFAULT 0,
    stattype VARCHAR(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'activity',
    stat1 BIGINT(10) NOT NULL DEFAULT 0,
    stat2 BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_statdail_cou2_ix (courseid)
, KEY mdl_statdail_tim2_ix (timeend)
, KEY mdl_statdail_rol2_ix (roleid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='to accumulate daily stats'; CREATE TABLE mdl_stats_weekly (
    id BIGINT(10) NOT NULL auto_increment,
    courseid BIGINT(10) NOT NULL DEFAULT 0,
    timeend BIGINT(10) NOT NULL DEFAULT 0,
    roleid BIGINT(10) NOT NULL DEFAULT 0,
    stattype VARCHAR(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'activity',
    stat1 BIGINT(10) NOT NULL DEFAULT 0,
    stat2 BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_statweek_cou2_ix (courseid)
, KEY mdl_statweek_tim2_ix (timeend)
, KEY mdl_statweek_rol2_ix (roleid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='To accumulate weekly stats'; CREATE TABLE mdl_stats_monthly (
    id BIGINT(10) NOT NULL auto_increment,
    courseid BIGINT(10) NOT NULL DEFAULT 0,
    timeend BIGINT(10) NOT NULL DEFAULT 0,
    roleid BIGINT(10) NOT NULL DEFAULT 0,
    stattype VARCHAR(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'activity',
    stat1 BIGINT(10) NOT NULL DEFAULT 0,
    stat2 BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_statmont_cou2_ix (courseid)
, KEY mdl_statmont_tim2_ix (timeend)
, KEY mdl_statmont_rol2_ix (roleid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='To accumulate monthly stats'; CREATE TABLE mdl_stats_user_daily (
    id BIGINT(10) NOT NULL auto_increment,
    courseid BIGINT(10) NOT NULL DEFAULT 0,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    roleid BIGINT(10) NOT NULL DEFAULT 0,
    timeend BIGINT(10) NOT NULL DEFAULT 0,
    statsreads BIGINT(10) NOT NULL DEFAULT 0,
    statswrites BIGINT(10) NOT NULL DEFAULT 0,
    stattype VARCHAR(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_statuserdail_cou2_ix (courseid)
, KEY mdl_statuserdail_use2_ix (userid)
, KEY mdl_statuserdail_rol2_ix (roleid)
, KEY mdl_statuserdail_tim2_ix (timeend)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='To accumulate daily stats per course/user'; CREATE TABLE mdl_stats_user_weekly (
    id BIGINT(10) NOT NULL auto_increment,
    courseid BIGINT(10) NOT NULL DEFAULT 0,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    roleid BIGINT(10) NOT NULL DEFAULT 0,
    timeend BIGINT(10) NOT NULL DEFAULT 0,
    statsreads BIGINT(10) NOT NULL DEFAULT 0,
    statswrites BIGINT(10) NOT NULL DEFAULT 0,
    stattype VARCHAR(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_statuserweek_cou2_ix (courseid)
, KEY mdl_statuserweek_use2_ix (userid)
, KEY mdl_statuserweek_rol2_ix (roleid)
, KEY mdl_statuserweek_tim2_ix (timeend)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='To accumulate weekly stats per course/user'; CREATE TABLE mdl_stats_user_monthly (
    id BIGINT(10) NOT NULL auto_increment,
    courseid BIGINT(10) NOT NULL DEFAULT 0,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    roleid BIGINT(10) NOT NULL DEFAULT 0,
    timeend BIGINT(10) NOT NULL DEFAULT 0,
    statsreads BIGINT(10) NOT NULL DEFAULT 0,
    statswrites BIGINT(10) NOT NULL DEFAULT 0,
    stattype VARCHAR(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_statusermont_cou2_ix (courseid)
, KEY mdl_statusermont_use2_ix (userid)
, KEY mdl_statusermont_rol2_ix (roleid)
, KEY mdl_statusermont_tim2_ix (timeend)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='To accumulate monthly stats per course/user'; CREATE TABLE mdl_post (
    id BIGINT(10) NOT NULL auto_increment,
    module VARCHAR(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    userid BIGINT(10) NOT NULL DEFAULT 0,
    courseid BIGINT(10) NOT NULL DEFAULT 0,
    groupid BIGINT(10) NOT NULL DEFAULT 0,
    moduleid BIGINT(10) NOT NULL DEFAULT 0,
    coursemoduleid BIGINT(10) NOT NULL DEFAULT 0,
    subject VARCHAR(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    summary LONGTEXT COLLATE utf8mb4_unicode_ci,
    content LONGTEXT COLLATE utf8mb4_unicode_ci,
    uniquehash VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    rating BIGINT(10) NOT NULL DEFAULT 0,
    format BIGINT(10) NOT NULL DEFAULT 0,
    summaryformat TINYINT(2) NOT NULL DEFAULT 0,
    attachment VARCHAR(100) COLLATE utf8mb4_unicode_ci,
    publishstate VARCHAR(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'draft',
    lastmodified BIGINT(10) NOT NULL DEFAULT 0,
    created BIGINT(10) NOT NULL DEFAULT 0,
    usermodified BIGINT(10),
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_post_use2_fk FOREIGN KEY (usermodified) REFERENCES mdl_user (id)
, UNIQUE KEY mdl_post_iduse2_uix (id, userid)
, KEY mdl_post_las2_ix (lastmodified)
, KEY mdl_post_mod2_ix (module)
, KEY mdl_post_sub2_ix (subject)
, KEY mdl_post_use4_ix (usermodified)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Generic post table to hold data blog entries etc in differen'; CREATE TABLE mdl_role (
    id BIGINT(10) NOT NULL auto_increment,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    shortname VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    description LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    sortorder BIGINT(10) NOT NULL DEFAULT 0,
    archetype VARCHAR(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY mdl_role_sor2_uix (sortorder)
, UNIQUE KEY mdl_role_sho2_uix (shortname)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='moodle roles'; CREATE TABLE mdl_context (
    id BIGINT(10) NOT NULL auto_increment,
    contextlevel BIGINT(10) NOT NULL DEFAULT 0,
    instanceid BIGINT(10) NOT NULL DEFAULT 0,
    path VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    depth TINYINT(2) NOT NULL DEFAULT 0,
    locked TINYINT(2) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY mdl_cont_conins2_uix (contextlevel, instanceid)
, KEY mdl_cont_ins2_ix (instanceid)
, KEY mdl_cont_pat2_ix (path)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='one of these must be set'; CREATE TABLE mdl_context_temp (
    id BIGINT(10) NOT NULL,
    path VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    depth TINYINT(2) NOT NULL,
    locked TINYINT(2) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Used by build_context_path() in upgrade and cron to keep con'; CREATE TABLE mdl_capabilities (
    id BIGINT(10) NOT NULL auto_increment,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    captype VARCHAR(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    contextlevel BIGINT(10) NOT NULL DEFAULT 0,
    component VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    riskbitmask BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY mdl_capa_nam2_uix (name)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='this defines all capabilities'; CREATE TABLE mdl_role_allow_assign (
    id BIGINT(10) NOT NULL auto_increment,
    roleid BIGINT(10) NOT NULL DEFAULT 0,
    allowassign BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_rolealloassi_rol2_fk FOREIGN KEY (roleid) REFERENCES mdl_role (id),
CONSTRAINT mdl_rolealloassi_all2_fk FOREIGN KEY (allowassign) REFERENCES mdl_role (id)
, UNIQUE KEY mdl_rolealloassi_rolall2_uix (roleid, allowassign)
, KEY mdl_rolealloassi_rol4_ix (roleid)
, KEY mdl_rolealloassi_all4_ix (allowassign)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='this defines what role can assign what role'; CREATE TABLE mdl_role_allow_override (
    id BIGINT(10) NOT NULL auto_increment,
    roleid BIGINT(10) NOT NULL DEFAULT 0,
    allowoverride BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_rolealloover_rol2_fk FOREIGN KEY (roleid) REFERENCES mdl_role (id),
CONSTRAINT mdl_rolealloover_all2_fk FOREIGN KEY (allowoverride) REFERENCES mdl_role (id)
, UNIQUE KEY mdl_rolealloover_rolall2_uix (roleid, allowoverride)
, KEY mdl_rolealloover_rol4_ix (roleid)
, KEY mdl_rolealloover_all4_ix (allowoverride)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='this defines what role can override what role'; CREATE TABLE mdl_role_allow_switch (
    id BIGINT(10) NOT NULL auto_increment,
    roleid BIGINT(10) NOT NULL,
    allowswitch BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_rolealloswit_rol2_fk FOREIGN KEY (roleid) REFERENCES mdl_role (id),
CONSTRAINT mdl_rolealloswit_all2_fk FOREIGN KEY (allowswitch) REFERENCES mdl_role (id)
, UNIQUE KEY mdl_rolealloswit_rolall2_uix (roleid, allowswitch)
, KEY mdl_rolealloswit_rol4_ix (roleid)
, KEY mdl_rolealloswit_all4_ix (allowswitch)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='This table stores which which other roles a user is allowed '; CREATE TABLE mdl_role_allow_view (
    id BIGINT(10) NOT NULL auto_increment,
    roleid BIGINT(10) NOT NULL,
    allowview BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_rolealloview_rol2_fk FOREIGN KEY (roleid) REFERENCES mdl_role (id),
CONSTRAINT mdl_rolealloview_all2_fk FOREIGN KEY (allowview) REFERENCES mdl_role (id)
, UNIQUE KEY mdl_rolealloview_rolall2_uix (roleid, allowview)
, KEY mdl_rolealloview_rol4_ix (roleid)
, KEY mdl_rolealloview_all4_ix (allowview)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='This table stores which which other roles a user is allowed '; CREATE TABLE mdl_role_assignments (
    id BIGINT(10) NOT NULL auto_increment,
    roleid BIGINT(10) NOT NULL DEFAULT 0,
    contextid BIGINT(10) NOT NULL DEFAULT 0,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
    modifierid BIGINT(10) NOT NULL DEFAULT 0,
    component VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    itemid BIGINT(10) NOT NULL DEFAULT 0,
    sortorder BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_roleassi_rol2_fk FOREIGN KEY (roleid) REFERENCES mdl_role (id),
CONSTRAINT mdl_roleassi_con2_fk FOREIGN KEY (contextid) REFERENCES mdl_context (id),
CONSTRAINT mdl_roleassi_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id)
, KEY mdl_roleassi_sor2_ix (sortorder)
, KEY mdl_roleassi_rolcon2_ix (roleid, contextid)
, KEY mdl_roleassi_useconrol2_ix (userid, contextid, roleid)
, KEY mdl_roleassi_comiteuse2_ix (component, itemid, userid)
, KEY mdl_roleassi_rol4_ix (roleid)
, KEY mdl_roleassi_con4_ix (contextid)
, KEY mdl_roleassi_use4_ix (userid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='assigning roles in different context'; CREATE TABLE mdl_role_capabilities (
    id BIGINT(10) NOT NULL auto_increment,
    contextid BIGINT(10) NOT NULL DEFAULT 0,
    roleid BIGINT(10) NOT NULL DEFAULT 0,
    capability VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    permission BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
    modifierid BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_rolecapa_rol2_fk FOREIGN KEY (roleid) REFERENCES mdl_role (id),
CONSTRAINT mdl_rolecapa_con2_fk FOREIGN KEY (contextid) REFERENCES mdl_context (id),
CONSTRAINT mdl_rolecapa_mod2_fk FOREIGN KEY (modifierid) REFERENCES mdl_user (id),
CONSTRAINT mdl_rolecapa_cap2_fk FOREIGN KEY (capability) REFERENCES mdl_capabilities (name)
, UNIQUE KEY mdl_rolecapa_rolconcap2_uix (roleid, contextid, capability)
, KEY mdl_rolecapa_rol4_ix (roleid)
, KEY mdl_rolecapa_con4_ix (contextid)
, KEY mdl_rolecapa_mod4_ix (modifierid)
, KEY mdl_rolecapa_cap4_ix (capability)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='permission has to be signed, overriding a capability for a p'; CREATE TABLE mdl_role_names (
    id BIGINT(10) NOT NULL auto_increment,
    roleid BIGINT(10) NOT NULL DEFAULT 0,
    contextid BIGINT(10) NOT NULL DEFAULT 0,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_rolename_rol2_fk FOREIGN KEY (roleid) REFERENCES mdl_role (id),
CONSTRAINT mdl_rolename_con2_fk FOREIGN KEY (contextid) REFERENCES mdl_context (id)
, UNIQUE KEY mdl_rolename_rolcon2_uix (roleid, contextid)
, KEY mdl_rolename_rol4_ix (roleid)
, KEY mdl_rolename_con4_ix (contextid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='role names in native strings'; CREATE TABLE mdl_role_context_levels (
    id BIGINT(10) NOT NULL auto_increment,
    roleid BIGINT(10) NOT NULL,
    contextlevel BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_rolecontleve_rol2_fk FOREIGN KEY (roleid) REFERENCES mdl_role (id)
, UNIQUE KEY mdl_rolecontleve_conrol2_uix (contextlevel, roleid)
, KEY mdl_rolecontleve_rol4_ix (roleid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Lists which roles can be assigned at which context levels. T'; CREATE TABLE mdl_user_info_field (
    id BIGINT(10) NOT NULL auto_increment,
    shortname VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'shortname',
    name LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    datatype VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    description LONGTEXT COLLATE utf8mb4_unicode_ci,
    descriptionformat TINYINT(2) NOT NULL DEFAULT 0,
    categoryid BIGINT(10) NOT NULL DEFAULT 0,
    sortorder BIGINT(10) NOT NULL DEFAULT 0,
    required TINYINT(2) NOT NULL DEFAULT 0,
    locked TINYINT(2) NOT NULL DEFAULT 0,
    visible SMALLINT(4) NOT NULL DEFAULT 0,
    forceunique TINYINT(2) NOT NULL DEFAULT 0,
    signup TINYINT(2) NOT NULL DEFAULT 0,
    defaultdata LONGTEXT COLLATE utf8mb4_unicode_ci,
    defaultdataformat TINYINT(2) NOT NULL DEFAULT 0,
    param1 LONGTEXT COLLATE utf8mb4_unicode_ci,
    param2 LONGTEXT COLLATE utf8mb4_unicode_ci,
    param3 LONGTEXT COLLATE utf8mb4_unicode_ci,
    param4 LONGTEXT COLLATE utf8mb4_unicode_ci,
    param5 LONGTEXT COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Customisable user profile fields'; CREATE TABLE mdl_user_info_category (
    id BIGINT(10) NOT NULL auto_increment,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    sortorder BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Customisable fields categories'; CREATE TABLE mdl_user_info_data (
    id BIGINT(10) NOT NULL auto_increment,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    fieldid BIGINT(10) NOT NULL DEFAULT 0,
    data LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    dataformat TINYINT(2) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY mdl_userinfodata_usefie2_uix (userid, fieldid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Data for the customisable user fields'; CREATE TABLE mdl_question_categories (
    id BIGINT(10) NOT NULL auto_increment,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    contextid BIGINT(10) NOT NULL DEFAULT 0,
    info LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    infoformat TINYINT(2) NOT NULL DEFAULT 0,
    stamp VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    parent BIGINT(10) NOT NULL DEFAULT 0,
    sortorder BIGINT(10) NOT NULL DEFAULT 999,
    idnumber VARCHAR(100) COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_quescate_par2_fk FOREIGN KEY (parent) REFERENCES mdl_question_categories (id)
, KEY mdl_quescate_con2_ix (contextid)
, UNIQUE KEY mdl_quescate_consta2_uix (contextid, stamp)
, UNIQUE KEY mdl_quescate_conidn2_uix (contextid, idnumber)
, KEY mdl_quescate_par4_ix (parent)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Categories are for grouping questions'; CREATE TABLE mdl_question (
    id BIGINT(10) NOT NULL auto_increment,
    category BIGINT(10) NOT NULL DEFAULT 0,
    parent BIGINT(10) NOT NULL DEFAULT 0,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    questiontext LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    questiontextformat TINYINT(2) NOT NULL DEFAULT 0,
    generalfeedback LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    generalfeedbackformat TINYINT(2) NOT NULL DEFAULT 0,
    defaultmark NUMERIC(12,7) NOT NULL DEFAULT 1,
    penalty NUMERIC(12,7) NOT NULL DEFAULT 0.3333333,
    qtype VARCHAR(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    length BIGINT(10) NOT NULL DEFAULT 1,
    stamp VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    version VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    hidden TINYINT(1) NOT NULL DEFAULT 0,
    timecreated BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
    createdby BIGINT(10),
    modifiedby BIGINT(10),
    idnumber VARCHAR(100) COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_ques_cat2_fk FOREIGN KEY (category) REFERENCES mdl_question_categories (id),
CONSTRAINT mdl_ques_par2_fk FOREIGN KEY (parent) REFERENCES mdl_question (id),
CONSTRAINT mdl_ques_cre2_fk FOREIGN KEY (createdby) REFERENCES mdl_user (id),
CONSTRAINT mdl_ques_mod2_fk FOREIGN KEY (modifiedby) REFERENCES mdl_user (id)
, KEY mdl_ques_qty2_ix (qtype)
, UNIQUE KEY mdl_ques_catidn2_uix (category, idnumber)
, KEY mdl_ques_cat4_ix (category)
, KEY mdl_ques_par4_ix (parent)
, KEY mdl_ques_cre4_ix (createdby)
, KEY mdl_ques_mod4_ix (modifiedby)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='The questions themselves'; CREATE TABLE mdl_question_answers (
    id BIGINT(10) NOT NULL auto_increment,
    question BIGINT(10) NOT NULL DEFAULT 0,
    answer LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    answerformat TINYINT(2) NOT NULL DEFAULT 0,
    fraction NUMERIC(12,7) NOT NULL DEFAULT 0,
    feedback LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    feedbackformat TINYINT(2) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_quesansw_que2_fk FOREIGN KEY (question) REFERENCES mdl_question (id)
, KEY mdl_quesansw_que4_ix (question)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Answers, with a fractional grade (0-1) and feedback'; CREATE TABLE mdl_question_hints (
    id BIGINT(10) NOT NULL auto_increment,
    questionid BIGINT(10) NOT NULL,
    hint LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    hintformat SMALLINT(4) NOT NULL DEFAULT 0,
    shownumcorrect TINYINT(1),
    clearwrong TINYINT(1),
    options VARCHAR(255) COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_queshint_que2_fk FOREIGN KEY (questionid) REFERENCES mdl_question (id)
, KEY mdl_queshint_que4_ix (questionid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stores the the part of the question definition that gives di'; CREATE TABLE mdl_question_usages (
    id BIGINT(10) NOT NULL auto_increment,
    contextid BIGINT(10) NOT NULL,
    component VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    preferredbehaviour VARCHAR(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_quesusag_con2_fk FOREIGN KEY (contextid) REFERENCES mdl_context (id)
, KEY mdl_quesusag_con4_ix (contextid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='This table\'s main purpose it to assign a unique id to each a'; CREATE TABLE mdl_question_attempts (
    id BIGINT(10) NOT NULL auto_increment,
    questionusageid BIGINT(10) NOT NULL,
    slot BIGINT(10) NOT NULL,
    behaviour VARCHAR(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    questionid BIGINT(10) NOT NULL,
    variant BIGINT(10) NOT NULL DEFAULT 1,
    maxmark NUMERIC(12,7) NOT NULL,
    minfraction NUMERIC(12,7) NOT NULL,
    maxfraction NUMERIC(12,7) NOT NULL DEFAULT 1,
    flagged TINYINT(1) NOT NULL DEFAULT 0,
    questionsummary LONGTEXT COLLATE utf8mb4_unicode_ci,
    rightanswer LONGTEXT COLLATE utf8mb4_unicode_ci,
    responsesummary LONGTEXT COLLATE utf8mb4_unicode_ci,
    timemodified BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_quesatte_que3_fk FOREIGN KEY (questionid) REFERENCES mdl_question (id),
CONSTRAINT mdl_quesatte_que4_fk FOREIGN KEY (questionusageid) REFERENCES mdl_question_usages (id)
, UNIQUE KEY mdl_quesatte_queslo2_uix (questionusageid, slot)
, KEY mdl_quesatte_beh2_ix (behaviour)
, KEY mdl_quesatte_que6_ix (questionid)
, KEY mdl_quesatte_que8_ix (questionusageid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Each row here corresponds to an attempt at one question, as '; CREATE TABLE mdl_question_attempt_steps (
    id BIGINT(10) NOT NULL auto_increment,
    questionattemptid BIGINT(10) NOT NULL,
    sequencenumber BIGINT(10) NOT NULL,
    state VARCHAR(13) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    fraction NUMERIC(12,7),
    timecreated BIGINT(10) NOT NULL,
    userid BIGINT(10),
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_quesattestep_que2_fk FOREIGN KEY (questionattemptid) REFERENCES mdl_question_attempts (id),
CONSTRAINT mdl_quesattestep_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id)
, UNIQUE KEY mdl_quesattestep_queseq2_uix (questionattemptid, sequencenumber)
, KEY mdl_quesattestep_que4_ix (questionattemptid)
, KEY mdl_quesattestep_use4_ix (userid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stores one step in in a question attempt. As well as the dat'; CREATE TABLE mdl_question_attempt_step_data (
    id BIGINT(10) NOT NULL auto_increment,
    attemptstepid BIGINT(10) NOT NULL,
    name VARCHAR(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    value LONGTEXT COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_quesattestepdata_att2_fk FOREIGN KEY (attemptstepid) REFERENCES mdl_question_attempt_steps (id)
, KEY mdl_quesattestepdata_att4_ix (attemptstepid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Each question_attempt_step has an associative array of the d'; CREATE TABLE mdl_question_statistics (
    id BIGINT(10) NOT NULL auto_increment,
    hashcode VARCHAR(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    timemodified BIGINT(10) NOT NULL,
    questionid BIGINT(10) NOT NULL,
    slot BIGINT(10),
    subquestion SMALLINT(4) NOT NULL,
    variant BIGINT(10),
    s BIGINT(10) NOT NULL DEFAULT 0,
    effectiveweight NUMERIC(15,5),
    negcovar TINYINT(2) NOT NULL DEFAULT 0,
    discriminationindex NUMERIC(15,5),
    discriminativeefficiency NUMERIC(15,5),
    sd NUMERIC(15,10),
    facility NUMERIC(15,10),
    subquestions LONGTEXT COLLATE utf8mb4_unicode_ci,
    maxmark NUMERIC(12,7),
    positions LONGTEXT COLLATE utf8mb4_unicode_ci,
    randomguessscore NUMERIC(12,7),
CONSTRAINT  PRIMARY KEY (id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Statistics for individual questions used in an activity.'; CREATE TABLE mdl_question_response_analysis (
    id BIGINT(10) NOT NULL auto_increment,
    hashcode VARCHAR(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    whichtries VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    timemodified BIGINT(10) NOT NULL,
    questionid BIGINT(10) NOT NULL,
    variant BIGINT(10),
    subqid VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    aid VARCHAR(100) COLLATE utf8mb4_unicode_ci,
    response LONGTEXT COLLATE utf8mb4_unicode_ci,
    credit NUMERIC(15,5) NOT NULL,
CONSTRAINT  PRIMARY KEY (id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Analysis of student responses given to questions.'; CREATE TABLE mdl_question_response_count (
    id BIGINT(10) NOT NULL auto_increment,
    analysisid BIGINT(10) NOT NULL,
    try BIGINT(10) NOT NULL,
    rcount BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_quesrespcoun_ana2_fk FOREIGN KEY (analysisid) REFERENCES mdl_question_response_analysis (id)
, KEY mdl_quesrespcoun_ana4_ix (analysisid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Count for each responses for each try at a question.'; CREATE TABLE mdl_mnet_application (
    id BIGINT(10) NOT NULL auto_increment,
    name VARCHAR(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    display_name VARCHAR(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    xmlrpc_server_url VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    sso_land_url VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    sso_jump_url VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
CONSTRAINT  PRIMARY KEY (id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Information about applications on remote hosts'; CREATE TABLE mdl_mnet_host (
    id BIGINT(10) NOT NULL auto_increment,
    deleted TINYINT(1) NOT NULL DEFAULT 0,
    wwwroot VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    ip_address VARCHAR(45) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    name VARCHAR(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    public_key LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    public_key_expires BIGINT(10) NOT NULL DEFAULT 0,
    transport TINYINT(2) NOT NULL DEFAULT 0,
    portno MEDIUMINT(5) NOT NULL DEFAULT 0,
    last_connect_time BIGINT(10) NOT NULL DEFAULT 0,
    last_log_id BIGINT(10) NOT NULL DEFAULT 0,
    force_theme TINYINT(1) NOT NULL DEFAULT 0,
    theme VARCHAR(100) COLLATE utf8mb4_unicode_ci,
    applicationid BIGINT(10) NOT NULL DEFAULT 1,
    sslverification TINYINT(1) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_mnethost_app2_fk FOREIGN KEY (applicationid) REFERENCES mdl_mnet_application (id)
, KEY mdl_mnethost_app4_ix (applicationid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Information about the local and remote hosts for RPC'; CREATE TABLE mdl_mnet_host2service (
    id BIGINT(10) NOT NULL auto_increment,
    hostid BIGINT(10) NOT NULL DEFAULT 0,
    serviceid BIGINT(10) NOT NULL DEFAULT 0,
    publish TINYINT(1) NOT NULL DEFAULT 0,
    subscribe TINYINT(1) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY mdl_mnethost_hosser2_uix (hostid, serviceid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Information about the services for a given host'; CREATE TABLE mdl_mnet_log (
    id BIGINT(10) NOT NULL auto_increment,
    hostid BIGINT(10) NOT NULL DEFAULT 0,
    remoteid BIGINT(10) NOT NULL DEFAULT 0,
    time BIGINT(10) NOT NULL DEFAULT 0,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    ip VARCHAR(45) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    course BIGINT(10) NOT NULL DEFAULT 0,
    coursename VARCHAR(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    module VARCHAR(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    cmid BIGINT(10) NOT NULL DEFAULT 0,
    action VARCHAR(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    url VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    info VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_mnetlog_hosusecou2_ix (hostid, userid, course)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Store session data from users migrating to other sites'; CREATE TABLE mdl_mnet_rpc (
    id BIGINT(10) NOT NULL auto_increment,
    functionname VARCHAR(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    xmlrpcpath VARCHAR(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    plugintype VARCHAR(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    pluginname VARCHAR(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    enabled TINYINT(1) NOT NULL DEFAULT 0,
    help LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    profile LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    filename VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    classname VARCHAR(150) COLLATE utf8mb4_unicode_ci,
    static TINYINT(1),
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_mnetrpc_enaxml2_ix (enabled, xmlrpcpath)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Functions or methods that we may publish or subscribe to'; CREATE TABLE mdl_mnet_remote_rpc (
    id BIGINT(10) NOT NULL auto_increment,
    functionname VARCHAR(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    xmlrpcpath VARCHAR(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    plugintype VARCHAR(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    pluginname VARCHAR(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    enabled TINYINT(1) NOT NULL,
CONSTRAINT  PRIMARY KEY (id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='This table describes functions that might be called remotely'; CREATE TABLE mdl_mnet_service (
    id BIGINT(10) NOT NULL auto_increment,
    name VARCHAR(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    description VARCHAR(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    apiversion VARCHAR(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    offer TINYINT(1) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='A service is a group of functions'; CREATE TABLE mdl_mnet_service2rpc (
    id BIGINT(10) NOT NULL auto_increment,
    serviceid BIGINT(10) NOT NULL DEFAULT 0,
    rpcid BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY mdl_mnetserv_rpcser2_uix (rpcid, serviceid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Group functions or methods under a service'; CREATE TABLE mdl_mnet_remote_service2rpc (
    id BIGINT(10) NOT NULL auto_increment,
    serviceid BIGINT(10) NOT NULL DEFAULT 0,
    rpcid BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY mdl_mnetremoserv_rpcser2_uix (rpcid, serviceid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Group functions or methods under a service'; CREATE TABLE mdl_mnet_session (
    id BIGINT(10) NOT NULL auto_increment,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    username VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    token VARCHAR(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    mnethostid BIGINT(10) NOT NULL DEFAULT 0,
    useragent VARCHAR(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    confirm_timeout BIGINT(10) NOT NULL DEFAULT 0,
    session_id VARCHAR(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    expires BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY mdl_mnetsess_tok2_uix (token)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Store session data from users migrating to other sites'; CREATE TABLE mdl_mnet_sso_access_control (
    id BIGINT(10) NOT NULL auto_increment,
    username VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    mnet_host_id BIGINT(10) NOT NULL DEFAULT 0,
    accessctrl VARCHAR(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'allow',
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY mdl_mnetssoaccecont_mneus2_uix (mnet_host_id, username)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Users by host permitted (or not) to login from a remote prov'; CREATE TABLE mdl_events_queue (
    id BIGINT(10) NOT NULL auto_increment,
    eventdata LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    stackdump LONGTEXT COLLATE utf8mb4_unicode_ci,
    userid BIGINT(10),
    timecreated BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_evenqueu_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id)
, KEY mdl_evenqueu_use4_ix (userid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='This table is for storing queued events. It stores only one '; CREATE TABLE mdl_events_handlers (
    id BIGINT(10) NOT NULL auto_increment,
    eventname VARCHAR(166) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    component VARCHAR(166) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    handlerfile VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    handlerfunction LONGTEXT COLLATE utf8mb4_unicode_ci,
    schedule VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    status BIGINT(10) NOT NULL DEFAULT 0,
    internal TINYINT(2) NOT NULL DEFAULT 1,
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY mdl_evenhand_evecom2_uix (eventname, component)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='This table is for storing which components requests what typ'; CREATE TABLE mdl_events_queue_handlers (
    id BIGINT(10) NOT NULL auto_increment,
    queuedeventid BIGINT(10) NOT NULL,
    handlerid BIGINT(10) NOT NULL,
    status BIGINT(10),
    errormessage LONGTEXT COLLATE utf8mb4_unicode_ci,
    timemodified BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_evenqueuhand_que2_fk FOREIGN KEY (queuedeventid) REFERENCES mdl_events_queue (id),
CONSTRAINT mdl_evenqueuhand_han2_fk FOREIGN KEY (handlerid) REFERENCES mdl_events_handlers (id)
, KEY mdl_evenqueuhand_que4_ix (queuedeventid)
, KEY mdl_evenqueuhand_han4_ix (handlerid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='This is the list of queued handlers for processing. The even'; CREATE TABLE mdl_grade_outcomes (
    id BIGINT(10) NOT NULL auto_increment,
    courseid BIGINT(10),
    shortname VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    fullname LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    scaleid BIGINT(10),
    description LONGTEXT COLLATE utf8mb4_unicode_ci,
    descriptionformat TINYINT(2) NOT NULL DEFAULT 0,
    timecreated BIGINT(10),
    timemodified BIGINT(10),
    usermodified BIGINT(10),
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_gradoutc_cou2_fk FOREIGN KEY (courseid) REFERENCES mdl_course (id),
CONSTRAINT mdl_gradoutc_sca2_fk FOREIGN KEY (scaleid) REFERENCES mdl_scale (id),
CONSTRAINT mdl_gradoutc_use2_fk FOREIGN KEY (usermodified) REFERENCES mdl_user (id)
, KEY mdl_gradoutc_cou4_ix (courseid)
, KEY mdl_gradoutc_sca4_ix (scaleid)
, KEY mdl_gradoutc_use4_ix (usermodified)
, UNIQUE KEY mdl_gradoutc_cousho2_uix (courseid, shortname)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='This table describes the outcomes used in the system. An out'; CREATE TABLE mdl_grade_outcomes_courses (
    id BIGINT(10) NOT NULL auto_increment,
    courseid BIGINT(10) NOT NULL,
    outcomeid BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_gradoutccour_cou2_fk FOREIGN KEY (courseid) REFERENCES mdl_course (id),
CONSTRAINT mdl_gradoutccour_out2_fk FOREIGN KEY (outcomeid) REFERENCES mdl_grade_outcomes (id)
, KEY mdl_gradoutccour_cou4_ix (courseid)
, KEY mdl_gradoutccour_out4_ix (outcomeid)
, UNIQUE KEY mdl_gradoutccour_couout2_uix (courseid, outcomeid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='stores what outcomes are used in what courses.'; CREATE TABLE mdl_grade_categories (
    id BIGINT(10) NOT NULL auto_increment,
    courseid BIGINT(10) NOT NULL,
    parent BIGINT(10),
    depth BIGINT(10) NOT NULL DEFAULT 0,
    path VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    fullname VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    aggregation BIGINT(10) NOT NULL DEFAULT 0,
    keephigh BIGINT(10) NOT NULL DEFAULT 0,
    droplow BIGINT(10) NOT NULL DEFAULT 0,
    aggregateonlygraded TINYINT(1) NOT NULL DEFAULT 0,
    aggregateoutcomes TINYINT(1) NOT NULL DEFAULT 0,
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
    hidden TINYINT(1) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_gradcate_cou2_fk FOREIGN KEY (courseid) REFERENCES mdl_course (id),
CONSTRAINT mdl_gradcate_par2_fk FOREIGN KEY (parent) REFERENCES mdl_grade_categories (id)
, KEY mdl_gradcate_cou4_ix (courseid)
, KEY mdl_gradcate_par4_ix (parent)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='This table keeps information about categories, used for grou'; CREATE TABLE mdl_grade_items (
    id BIGINT(10) NOT NULL auto_increment,
    courseid BIGINT(10),
    categoryid BIGINT(10),
    itemname VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    itemtype VARCHAR(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    itemmodule VARCHAR(30) COLLATE utf8mb4_unicode_ci,
    iteminstance BIGINT(10),
    itemnumber BIGINT(10),
    iteminfo LONGTEXT COLLATE utf8mb4_unicode_ci,
    idnumber VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    calculation LONGTEXT COLLATE utf8mb4_unicode_ci,
    gradetype SMALLINT(4) NOT NULL DEFAULT 1,
    grademax NUMERIC(10,5) NOT NULL DEFAULT 100,
    grademin NUMERIC(10,5) NOT NULL DEFAULT 0,
    scaleid BIGINT(10),
    outcomeid BIGINT(10),
    gradepass NUMERIC(10,5) NOT NULL DEFAULT 0,
    multfactor NUMERIC(10,5) NOT NULL DEFAULT 1.0,
    plusfactor NUMERIC(10,5) NOT NULL DEFAULT 0,
    aggregationcoef NUMERIC(10,5) NOT NULL DEFAULT 0,
    aggregationcoef2 NUMERIC(10,5) NOT NULL DEFAULT 0,
    sortorder BIGINT(10) NOT NULL DEFAULT 0,
    display BIGINT(10) NOT NULL DEFAULT 0,
    decimals TINYINT(1),
    hidden BIGINT(10) NOT NULL DEFAULT 0,
    locked BIGINT(10) NOT NULL DEFAULT 0,
    locktime BIGINT(10) NOT NULL DEFAULT 0,
    needsupdate BIGINT(10) NOT NULL DEFAULT 0,
    weightoverride TINYINT(1) NOT NULL DEFAULT 0,
    timecreated BIGINT(10),
    timemodified BIGINT(10),
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_graditem_cou2_fk FOREIGN KEY (courseid) REFERENCES mdl_course (id),
CONSTRAINT mdl_graditem_cat2_fk FOREIGN KEY (categoryid) REFERENCES mdl_grade_categories (id),
CONSTRAINT mdl_graditem_sca2_fk FOREIGN KEY (scaleid) REFERENCES mdl_scale (id),
CONSTRAINT mdl_graditem_out2_fk FOREIGN KEY (outcomeid) REFERENCES mdl_grade_outcomes (id)
, KEY mdl_graditem_locloc2_ix (locked, locktime)
, KEY mdl_graditem_itenee2_ix (itemtype, needsupdate)
, KEY mdl_graditem_gra2_ix (gradetype)
, KEY mdl_graditem_idncou2_ix (idnumber, courseid)
, KEY mdl_graditem_cou4_ix (courseid)
, KEY mdl_graditem_cat4_ix (categoryid)
, KEY mdl_graditem_sca4_ix (scaleid)
, KEY mdl_graditem_out4_ix (outcomeid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='This table keeps information about gradeable items (ie colum'; CREATE TABLE mdl_grade_grades (
    id BIGINT(10) NOT NULL auto_increment,
    itemid BIGINT(10) NOT NULL,
    userid BIGINT(10) NOT NULL,
    rawgrade NUMERIC(10,5),
    rawgrademax NUMERIC(10,5) NOT NULL DEFAULT 100,
    rawgrademin NUMERIC(10,5) NOT NULL DEFAULT 0,
    rawscaleid BIGINT(10),
    usermodified BIGINT(10),
    finalgrade NUMERIC(10,5),
    hidden BIGINT(10) NOT NULL DEFAULT 0,
    locked BIGINT(10) NOT NULL DEFAULT 0,
    locktime BIGINT(10) NOT NULL DEFAULT 0,
    exported BIGINT(10) NOT NULL DEFAULT 0,
    overridden BIGINT(10) NOT NULL DEFAULT 0,
    excluded BIGINT(10) NOT NULL DEFAULT 0,
    feedback LONGTEXT COLLATE utf8mb4_unicode_ci,
    feedbackformat BIGINT(10) NOT NULL DEFAULT 0,
    information LONGTEXT COLLATE utf8mb4_unicode_ci,
    informationformat BIGINT(10) NOT NULL DEFAULT 0,
    timecreated BIGINT(10),
    timemodified BIGINT(10),
    aggregationstatus VARCHAR(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unknown',
    aggregationweight NUMERIC(10,5),
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_gradgrad_ite2_fk FOREIGN KEY (itemid) REFERENCES mdl_grade_items (id),
CONSTRAINT mdl_gradgrad_use3_fk FOREIGN KEY (userid) REFERENCES mdl_user (id),
CONSTRAINT mdl_gradgrad_raw2_fk FOREIGN KEY (rawscaleid) REFERENCES mdl_scale (id),
CONSTRAINT mdl_gradgrad_use4_fk FOREIGN KEY (usermodified) REFERENCES mdl_user (id)
, KEY mdl_gradgrad_locloc2_ix (locked, locktime)
, KEY mdl_gradgrad_ite4_ix (itemid)
, KEY mdl_gradgrad_use6_ix (userid)
, KEY mdl_gradgrad_raw4_ix (rawscaleid)
, KEY mdl_gradgrad_use8_ix (usermodified)
, UNIQUE KEY mdl_gradgrad_useite2_uix (userid, itemid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='grade_grades  This table keeps individual grades for each us'; CREATE TABLE mdl_grade_outcomes_history (
    id BIGINT(10) NOT NULL auto_increment,
    action BIGINT(10) NOT NULL DEFAULT 0,
    oldid BIGINT(10) NOT NULL,
    source VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    timemodified BIGINT(10),
    loggeduser BIGINT(10),
    courseid BIGINT(10),
    shortname VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    fullname LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    scaleid BIGINT(10),
    description LONGTEXT COLLATE utf8mb4_unicode_ci,
    descriptionformat TINYINT(2) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_gradoutchist_old2_fk FOREIGN KEY (oldid) REFERENCES mdl_grade_outcomes (id),
CONSTRAINT mdl_gradoutchist_cou2_fk FOREIGN KEY (courseid) REFERENCES mdl_course (id),
CONSTRAINT mdl_gradoutchist_sca2_fk FOREIGN KEY (scaleid) REFERENCES mdl_scale (id),
CONSTRAINT mdl_gradoutchist_log2_fk FOREIGN KEY (loggeduser) REFERENCES mdl_user (id)
, KEY mdl_gradoutchist_act2_ix (action)
, KEY mdl_gradoutchist_tim2_ix (timemodified)
, KEY mdl_gradoutchist_old4_ix (oldid)
, KEY mdl_gradoutchist_cou4_ix (courseid)
, KEY mdl_gradoutchist_sca4_ix (scaleid)
, KEY mdl_gradoutchist_log4_ix (loggeduser)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='History table'; CREATE TABLE mdl_grade_categories_history (
    id BIGINT(10) NOT NULL auto_increment,
    action BIGINT(10) NOT NULL DEFAULT 0,
    oldid BIGINT(10) NOT NULL,
    source VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    timemodified BIGINT(10),
    loggeduser BIGINT(10),
    courseid BIGINT(10) NOT NULL,
    parent BIGINT(10),
    depth BIGINT(10) NOT NULL DEFAULT 0,
    path VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    fullname VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    aggregation BIGINT(10) NOT NULL DEFAULT 0,
    keephigh BIGINT(10) NOT NULL DEFAULT 0,
    droplow BIGINT(10) NOT NULL DEFAULT 0,
    aggregateonlygraded TINYINT(1) NOT NULL DEFAULT 0,
    aggregateoutcomes TINYINT(1) NOT NULL DEFAULT 0,
    aggregatesubcats TINYINT(1) NOT NULL DEFAULT 0,
    hidden TINYINT(1) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_gradcatehist_old2_fk FOREIGN KEY (oldid) REFERENCES mdl_grade_categories (id),
CONSTRAINT mdl_gradcatehist_cou2_fk FOREIGN KEY (courseid) REFERENCES mdl_course (id),
CONSTRAINT mdl_gradcatehist_par2_fk FOREIGN KEY (parent) REFERENCES mdl_grade_categories (id),
CONSTRAINT mdl_gradcatehist_log2_fk FOREIGN KEY (loggeduser) REFERENCES mdl_user (id)
, KEY mdl_gradcatehist_act2_ix (action)
, KEY mdl_gradcatehist_tim2_ix (timemodified)
, KEY mdl_gradcatehist_old4_ix (oldid)
, KEY mdl_gradcatehist_cou4_ix (courseid)
, KEY mdl_gradcatehist_par4_ix (parent)
, KEY mdl_gradcatehist_log4_ix (loggeduser)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='History of grade_categories'; CREATE TABLE mdl_grade_items_history (
    id BIGINT(10) NOT NULL auto_increment,
    action BIGINT(10) NOT NULL DEFAULT 0,
    oldid BIGINT(10) NOT NULL,
    source VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    timemodified BIGINT(10),
    loggeduser BIGINT(10),
    courseid BIGINT(10),
    categoryid BIGINT(10),
    itemname VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    itemtype VARCHAR(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    itemmodule VARCHAR(30) COLLATE utf8mb4_unicode_ci,
    iteminstance BIGINT(10),
    itemnumber BIGINT(10),
    iteminfo LONGTEXT COLLATE utf8mb4_unicode_ci,
    idnumber VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    calculation LONGTEXT COLLATE utf8mb4_unicode_ci,
    gradetype SMALLINT(4) NOT NULL DEFAULT 1,
    grademax NUMERIC(10,5) NOT NULL DEFAULT 100,
    grademin NUMERIC(10,5) NOT NULL DEFAULT 0,
    scaleid BIGINT(10),
    outcomeid BIGINT(10),
    gradepass NUMERIC(10,5) NOT NULL DEFAULT 0,
    multfactor NUMERIC(10,5) NOT NULL DEFAULT 1.0,
    plusfactor NUMERIC(10,5) NOT NULL DEFAULT 0,
    aggregationcoef NUMERIC(10,5) NOT NULL DEFAULT 0,
    aggregationcoef2 NUMERIC(10,5) NOT NULL DEFAULT 0,
    sortorder BIGINT(10) NOT NULL DEFAULT 0,
    hidden BIGINT(10) NOT NULL DEFAULT 0,
    locked BIGINT(10) NOT NULL DEFAULT 0,
    locktime BIGINT(10) NOT NULL DEFAULT 0,
    needsupdate BIGINT(10) NOT NULL DEFAULT 0,
    display BIGINT(10) NOT NULL DEFAULT 0,
    decimals TINYINT(1),
    weightoverride TINYINT(1) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_graditemhist_old2_fk FOREIGN KEY (oldid) REFERENCES mdl_grade_items (id),
CONSTRAINT mdl_graditemhist_cou2_fk FOREIGN KEY (courseid) REFERENCES mdl_course (id),
CONSTRAINT mdl_graditemhist_cat2_fk FOREIGN KEY (categoryid) REFERENCES mdl_grade_categories (id),
CONSTRAINT mdl_graditemhist_sca2_fk FOREIGN KEY (scaleid) REFERENCES mdl_scale (id),
CONSTRAINT mdl_graditemhist_out2_fk FOREIGN KEY (outcomeid) REFERENCES mdl_grade_outcomes (id),
CONSTRAINT mdl_graditemhist_log2_fk FOREIGN KEY (loggeduser) REFERENCES mdl_user (id)
, KEY mdl_graditemhist_act2_ix (action)
, KEY mdl_graditemhist_tim2_ix (timemodified)
, KEY mdl_graditemhist_old4_ix (oldid)
, KEY mdl_graditemhist_cou4_ix (courseid)
, KEY mdl_graditemhist_cat4_ix (categoryid)
, KEY mdl_graditemhist_sca4_ix (scaleid)
, KEY mdl_graditemhist_out4_ix (outcomeid)
, KEY mdl_graditemhist_log4_ix (loggeduser)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='History of grade_items'; CREATE TABLE mdl_grade_grades_history (
    id BIGINT(10) NOT NULL auto_increment,
    action BIGINT(10) NOT NULL DEFAULT 0,
    oldid BIGINT(10) NOT NULL,
    source VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    timemodified BIGINT(10),
    loggeduser BIGINT(10),
    itemid BIGINT(10) NOT NULL,
    userid BIGINT(10) NOT NULL,
    rawgrade NUMERIC(10,5),
    rawgrademax NUMERIC(10,5) NOT NULL DEFAULT 100,
    rawgrademin NUMERIC(10,5) NOT NULL DEFAULT 0,
    rawscaleid BIGINT(10),
    usermodified BIGINT(10),
    finalgrade NUMERIC(10,5),
    hidden BIGINT(10) NOT NULL DEFAULT 0,
    locked BIGINT(10) NOT NULL DEFAULT 0,
    locktime BIGINT(10) NOT NULL DEFAULT 0,
    exported BIGINT(10) NOT NULL DEFAULT 0,
    overridden BIGINT(10) NOT NULL DEFAULT 0,
    excluded BIGINT(10) NOT NULL DEFAULT 0,
    feedback LONGTEXT COLLATE utf8mb4_unicode_ci,
    feedbackformat BIGINT(10) NOT NULL DEFAULT 0,
    information LONGTEXT COLLATE utf8mb4_unicode_ci,
    informationformat BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_gradgradhist_old2_fk FOREIGN KEY (oldid) REFERENCES mdl_grade_grades (id),
CONSTRAINT mdl_gradgradhist_ite2_fk FOREIGN KEY (itemid) REFERENCES mdl_grade_items (id),
CONSTRAINT mdl_gradgradhist_use3_fk FOREIGN KEY (userid) REFERENCES mdl_user (id),
CONSTRAINT mdl_gradgradhist_raw2_fk FOREIGN KEY (rawscaleid) REFERENCES mdl_scale (id),
CONSTRAINT mdl_gradgradhist_use4_fk FOREIGN KEY (usermodified) REFERENCES mdl_user (id),
CONSTRAINT mdl_gradgradhist_log2_fk FOREIGN KEY (loggeduser) REFERENCES mdl_user (id)
, KEY mdl_gradgradhist_act2_ix (action)
, KEY mdl_gradgradhist_tim2_ix (timemodified)
, KEY mdl_gradgradhist_useitetim2_ix (userid, itemid, timemodified)
, KEY mdl_gradgradhist_old4_ix (oldid)
, KEY mdl_gradgradhist_ite4_ix (itemid)
, KEY mdl_gradgradhist_use6_ix (userid)
, KEY mdl_gradgradhist_raw4_ix (rawscaleid)
, KEY mdl_gradgradhist_use8_ix (usermodified)
, KEY mdl_gradgradhist_log4_ix (loggeduser)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='History table'; CREATE TABLE mdl_grade_import_newitem (
    id BIGINT(10) NOT NULL auto_increment,
    itemname VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    importcode BIGINT(10) NOT NULL,
    importer BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_gradimponewi_imp2_fk FOREIGN KEY (importer) REFERENCES mdl_user (id)
, KEY mdl_gradimponewi_imp4_ix (importer)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='temporary table for storing new grade_item names from grade '; CREATE TABLE mdl_grade_import_values (
    id BIGINT(10) NOT NULL auto_increment,
    itemid BIGINT(10),
    newgradeitem BIGINT(10),
    userid BIGINT(10) NOT NULL,
    finalgrade NUMERIC(10,5),
    feedback LONGTEXT COLLATE utf8mb4_unicode_ci,
    importcode BIGINT(10) NOT NULL,
    importer BIGINT(10),
    importonlyfeedback TINYINT(1) DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_gradimpovalu_ite2_fk FOREIGN KEY (itemid) REFERENCES mdl_grade_items (id),
CONSTRAINT mdl_gradimpovalu_new2_fk FOREIGN KEY (newgradeitem) REFERENCES mdl_grade_import_newitem (id),
CONSTRAINT mdl_gradimpovalu_imp2_fk FOREIGN KEY (importer) REFERENCES mdl_user (id)
, KEY mdl_gradimpovalu_ite4_ix (itemid)
, KEY mdl_gradimpovalu_new4_ix (newgradeitem)
, KEY mdl_gradimpovalu_imp4_ix (importer)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Temporary table for importing grades'; CREATE TABLE mdl_tag_coll (
    id BIGINT(10) NOT NULL auto_increment,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    isdefault TINYINT(2) NOT NULL DEFAULT 0,
    component VARCHAR(100) COLLATE utf8mb4_unicode_ci,
    sortorder MEDIUMINT(5) NOT NULL DEFAULT 0,
    searchable TINYINT(2) NOT NULL DEFAULT 1,
    customurl VARCHAR(255) COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Defines different set of tags'; CREATE TABLE mdl_tag_area (
    id BIGINT(10) NOT NULL auto_increment,
    component VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    itemtype VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    enabled TINYINT(1) NOT NULL DEFAULT 1,
    tagcollid BIGINT(10) NOT NULL,
    callback VARCHAR(100) COLLATE utf8mb4_unicode_ci,
    callbackfile VARCHAR(100) COLLATE utf8mb4_unicode_ci,
    showstandard TINYINT(1) NOT NULL DEFAULT 0,
    multiplecontexts TINYINT(1) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_tagarea_tag2_fk FOREIGN KEY (tagcollid) REFERENCES mdl_tag_coll (id)
, UNIQUE KEY mdl_tagarea_comite2_uix (component, itemtype)
, KEY mdl_tagarea_tag4_ix (tagcollid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Defines various tag areas, one area is identified by compone'; CREATE TABLE mdl_tag (
    id BIGINT(10) NOT NULL auto_increment,
    userid BIGINT(10) NOT NULL,
    tagcollid BIGINT(10) NOT NULL,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    rawname VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    isstandard TINYINT(1) NOT NULL DEFAULT 0,
    description LONGTEXT COLLATE utf8mb4_unicode_ci,
    descriptionformat TINYINT(2) NOT NULL DEFAULT 0,
    flag SMALLINT(4) DEFAULT 0,
    timemodified BIGINT(10),
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_tag_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id),
CONSTRAINT mdl_tag_tag2_fk FOREIGN KEY (tagcollid) REFERENCES mdl_tag_coll (id)
, UNIQUE KEY mdl_tag_tagnam2_uix (tagcollid, name)
, KEY mdl_tag_tagiss2_ix (tagcollid, isstandard)
, KEY mdl_tag_use4_ix (userid)
, KEY mdl_tag_tag4_ix (tagcollid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Tag table - this generic table will replace the old "tags" t'; CREATE TABLE mdl_tag_correlation (
    id BIGINT(10) NOT NULL auto_increment,
    tagid BIGINT(10) NOT NULL,
    correlatedtags LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_tagcorr_tag2_fk FOREIGN KEY (tagid) REFERENCES mdl_tag (id)
, KEY mdl_tagcorr_tag4_ix (tagid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='The rationale for the \'tag_correlation\' table is performance'; CREATE TABLE mdl_tag_instance (
    id BIGINT(10) NOT NULL auto_increment,
    tagid BIGINT(10) NOT NULL,
    component VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    itemtype VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    itemid BIGINT(10) NOT NULL,
    contextid BIGINT(10),
    tiuserid BIGINT(10) NOT NULL DEFAULT 0,
    ordering BIGINT(10),
    timecreated BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_taginst_tag2_fk FOREIGN KEY (tagid) REFERENCES mdl_tag (id),
CONSTRAINT mdl_taginst_con2_fk FOREIGN KEY (contextid) REFERENCES mdl_context (id)
, UNIQUE KEY mdl_taginst_comiteitecont2_uix (component, itemtype, itemid, contextid, tiuserid, tagid)
, KEY mdl_taginst_itecomtagcon2_ix (itemtype, component, tagid, contextid)
, KEY mdl_taginst_tag4_ix (tagid)
, KEY mdl_taginst_con4_ix (contextid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='tag_instance table holds the information of associations bet'; CREATE TABLE mdl_groups (
    id BIGINT(10) NOT NULL auto_increment,
    courseid BIGINT(10) NOT NULL,
    idnumber VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    name VARCHAR(254) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    description LONGTEXT COLLATE utf8mb4_unicode_ci,
    descriptionformat TINYINT(2) NOT NULL DEFAULT 0,
    enrolmentkey VARCHAR(50) COLLATE utf8mb4_unicode_ci,
    picture BIGINT(10) NOT NULL DEFAULT 0,
    hidepicture TINYINT(1) NOT NULL DEFAULT 0,
    timecreated BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_grou_cou3_fk FOREIGN KEY (courseid) REFERENCES mdl_course (id)
, KEY mdl_grou_idn2_ix (idnumber)
, KEY mdl_grou_cou5_ix (courseid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Each record represents a group.'; CREATE TABLE mdl_groupings (
    id BIGINT(10) NOT NULL auto_increment,
    courseid BIGINT(10) NOT NULL DEFAULT 0,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    idnumber VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    description LONGTEXT COLLATE utf8mb4_unicode_ci,
    descriptionformat TINYINT(2) NOT NULL DEFAULT 0,
    configdata LONGTEXT COLLATE utf8mb4_unicode_ci,
    timecreated BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_grou_cou6_fk FOREIGN KEY (courseid) REFERENCES mdl_course (id)
, KEY mdl_grou_idn3_ix (idnumber)
, KEY mdl_grou_cou8_ix (courseid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='A grouping is a collection of groups. WAS: groups_groupings'; CREATE TABLE mdl_groups_members (
    id BIGINT(10) NOT NULL auto_increment,
    groupid BIGINT(10) NOT NULL DEFAULT 0,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    timeadded BIGINT(10) NOT NULL DEFAULT 0,
    component VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    itemid BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_groumemb_gro2_fk FOREIGN KEY (groupid) REFERENCES mdl_groups (id),
CONSTRAINT mdl_groumemb_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id)
, KEY mdl_groumemb_gro4_ix (groupid)
, KEY mdl_groumemb_use4_ix (userid)
, UNIQUE KEY mdl_groumemb_usegro2_uix (userid, groupid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Link a user to a group.'; CREATE TABLE mdl_groupings_groups (
    id BIGINT(10) NOT NULL auto_increment,
    groupingid BIGINT(10) NOT NULL DEFAULT 0,
    groupid BIGINT(10) NOT NULL DEFAULT 0,
    timeadded BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_grougrou_gro3_fk FOREIGN KEY (groupingid) REFERENCES mdl_groupings (id),
CONSTRAINT mdl_grougrou_gro4_fk FOREIGN KEY (groupid) REFERENCES mdl_groups (id)
, KEY mdl_grougrou_gro6_ix (groupingid)
, KEY mdl_grougrou_gro8_ix (groupid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Link a grouping to a group (note, groups can be in multiple '; CREATE TABLE mdl_cohort (
    id BIGINT(10) NOT NULL auto_increment,
    contextid BIGINT(10) NOT NULL,
    name VARCHAR(254) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    idnumber VARCHAR(100) COLLATE utf8mb4_unicode_ci,
    description LONGTEXT COLLATE utf8mb4_unicode_ci,
    descriptionformat TINYINT(2) NOT NULL,
    visible TINYINT(1) NOT NULL DEFAULT 1,
    component VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
    theme VARCHAR(50) COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_coho_con2_fk FOREIGN KEY (contextid) REFERENCES mdl_context (id)
, KEY mdl_coho_con4_ix (contextid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Each record represents one cohort (aka site-wide group).'; CREATE TABLE mdl_cohort_members (
    id BIGINT(10) NOT NULL auto_increment,
    cohortid BIGINT(10) NOT NULL DEFAULT 0,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    timeadded BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_cohomemb_coh2_fk FOREIGN KEY (cohortid) REFERENCES mdl_cohort (id),
CONSTRAINT mdl_cohomemb_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id)
, UNIQUE KEY mdl_cohomemb_cohuse2_uix (cohortid, userid)
, KEY mdl_cohomemb_coh4_ix (cohortid)
, KEY mdl_cohomemb_use4_ix (userid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Link a user to a cohort.'; CREATE TABLE mdl_user_private_key (
    id BIGINT(10) NOT NULL auto_increment,
    script VARCHAR(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    value VARCHAR(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    userid BIGINT(10) NOT NULL,
    instance BIGINT(10),
    iprestriction VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    validuntil BIGINT(10),
    timecreated BIGINT(10),
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_userprivkey_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id)
, KEY mdl_userprivkey_scrval2_ix (script, value)
, KEY mdl_userprivkey_use4_ix (userid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='access keys used in cookieless scripts - rss, etc.'; CREATE TABLE mdl_grade_letters (
    id BIGINT(10) NOT NULL auto_increment,
    contextid BIGINT(10) NOT NULL,
    lowerboundary NUMERIC(10,5) NOT NULL,
    letter VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY mdl_gradlett_conlowlet2_uix (contextid, lowerboundary, letter)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Repository for grade letters, for courses and other moodle e'; CREATE TABLE mdl_cache_flags (
    id BIGINT(10) NOT NULL auto_increment,
    flagtype VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
    value LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    expiry BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_cachflag_fla2_ix (flagtype)
, KEY mdl_cachflag_nam2_ix (name)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Cache of time-sensitive flags'; CREATE TABLE mdl_grade_settings (
    id BIGINT(10) NOT NULL auto_increment,
    courseid BIGINT(10) NOT NULL,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    value LONGTEXT COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_gradsett_cou2_fk FOREIGN KEY (courseid) REFERENCES mdl_course (id)
, UNIQUE KEY mdl_gradsett_counam2_uix (courseid, name)
, KEY mdl_gradsett_cou4_ix (courseid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='gradebook settings'; CREATE TABLE mdl_portfolio_instance (
    id BIGINT(10) NOT NULL auto_increment,
    plugin VARCHAR(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    visible TINYINT(1) NOT NULL DEFAULT 1,
CONSTRAINT  PRIMARY KEY (id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='base table (not including config data) for instances of port'; CREATE TABLE mdl_portfolio_instance_config (
    id BIGINT(10) NOT NULL auto_increment,
    instance BIGINT(10) NOT NULL,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    value LONGTEXT COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_portinstconf_ins2_fk FOREIGN KEY (instance) REFERENCES mdl_portfolio_instance (id)
, KEY mdl_portinstconf_nam2_ix (name)
, KEY mdl_portinstconf_ins4_ix (instance)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='config for portfolio plugin instances'; CREATE TABLE mdl_portfolio_instance_user (
    id BIGINT(10) NOT NULL auto_increment,
    instance BIGINT(10) NOT NULL,
    userid BIGINT(10) NOT NULL,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    value LONGTEXT COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_portinstuser_ins2_fk FOREIGN KEY (instance) REFERENCES mdl_portfolio_instance (id),
CONSTRAINT mdl_portinstuser_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id)
, KEY mdl_portinstuser_ins4_ix (instance)
, KEY mdl_portinstuser_use4_ix (userid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='user data for portfolio instances.'; CREATE TABLE mdl_portfolio_log (
    id BIGINT(10) NOT NULL auto_increment,
    userid BIGINT(10) NOT NULL,
    time BIGINT(10) NOT NULL,
    portfolio BIGINT(10) NOT NULL,
    caller_class VARCHAR(150) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    caller_file VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    caller_component VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    caller_sha1 VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    tempdataid BIGINT(10) NOT NULL DEFAULT 0,
    returnurl VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    continueurl VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_portlog_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id),
CONSTRAINT mdl_portlog_por2_fk FOREIGN KEY (portfolio) REFERENCES mdl_portfolio_instance (id)
, KEY mdl_portlog_use4_ix (userid)
, KEY mdl_portlog_por4_ix (portfolio)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='log of portfolio transfers (used to later check for duplicat'; CREATE TABLE mdl_portfolio_tempdata (
    id BIGINT(10) NOT NULL auto_increment,
    data LONGTEXT COLLATE utf8mb4_unicode_ci,
    expirytime BIGINT(10) NOT NULL,
    userid BIGINT(10) NOT NULL,
    instance BIGINT(10) DEFAULT 0,
    queued TINYINT(1) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_porttemp_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id),
CONSTRAINT mdl_porttemp_ins2_fk FOREIGN KEY (instance) REFERENCES mdl_portfolio_instance (id)
, KEY mdl_porttemp_use4_ix (userid)
, KEY mdl_porttemp_ins4_ix (instance)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='stores temporary data for portfolio exports. the id of this '; CREATE TABLE mdl_message_providers (
    id BIGINT(10) NOT NULL auto_increment,
    name VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    component VARCHAR(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    capability VARCHAR(255) COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY mdl_messprov_comnam2_uix (component, name)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='This table stores the message providers (modules and core sy'; CREATE TABLE mdl_message_processors (
    id BIGINT(10) NOT NULL auto_increment,
    name VARCHAR(166) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    enabled TINYINT(1) NOT NULL DEFAULT 1,
CONSTRAINT  PRIMARY KEY (id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='List of message output plugins'; CREATE TABLE mdl_files (
    id BIGINT(10) NOT NULL auto_increment,
    contenthash VARCHAR(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    pathnamehash VARCHAR(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    contextid BIGINT(10) NOT NULL,
    component VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    filearea VARCHAR(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    itemid BIGINT(10) NOT NULL,
    filepath VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    filename VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    userid BIGINT(10),
    filesize BIGINT(10) NOT NULL,
    mimetype VARCHAR(100) COLLATE utf8mb4_unicode_ci,
    status BIGINT(10) NOT NULL DEFAULT 0,
    source LONGTEXT COLLATE utf8mb4_unicode_ci,
    author VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    license VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
    sortorder BIGINT(10) NOT NULL DEFAULT 0,
    referencefileid BIGINT(10),
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_file_con2_fk FOREIGN KEY (contextid) REFERENCES mdl_context (id),
CONSTRAINT mdl_file_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id),
CONSTRAINT mdl_file_ref2_fk FOREIGN KEY (referencefileid) REFERENCES mdl_files_reference (id)
, KEY mdl_file_comfilconite2_ix (component, filearea, contextid, itemid)
, KEY mdl_file_con3_ix (contenthash)
, UNIQUE KEY mdl_file_pat2_uix (pathnamehash)
, KEY mdl_file_con5_ix (contextid)
, KEY mdl_file_use4_ix (userid)
, KEY mdl_file_ref4_ix (referencefileid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='description of files, content is stored in sha1 file pool'; CREATE TABLE mdl_files_reference (
    id BIGINT(10) NOT NULL auto_increment,
    repositoryid BIGINT(10) NOT NULL,
    lastsync BIGINT(10),
    reference LONGTEXT COLLATE utf8mb4_unicode_ci,
    referencehash VARCHAR(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_filerefe_rep2_fk FOREIGN KEY (repositoryid) REFERENCES mdl_repository_instances (id)
, UNIQUE KEY mdl_filerefe_refrep2_uix (referencehash, repositoryid)
, KEY mdl_filerefe_rep4_ix (repositoryid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Store files references'; CREATE TABLE mdl_file_conversion (
    id BIGINT(10) NOT NULL auto_increment,
    usermodified BIGINT(10) NOT NULL,
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
    sourcefileid BIGINT(10) NOT NULL,
    targetformat VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    status BIGINT(10) DEFAULT 0,
    statusmessage LONGTEXT COLLATE utf8mb4_unicode_ci,
    converter VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    destfileid BIGINT(10),
    data LONGTEXT COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_fileconv_sou2_fk FOREIGN KEY (sourcefileid) REFERENCES mdl_files (id),
CONSTRAINT mdl_fileconv_des2_fk FOREIGN KEY (destfileid) REFERENCES mdl_files (id)
, KEY mdl_fileconv_sou4_ix (sourcefileid)
, KEY mdl_fileconv_des4_ix (destfileid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Table to track file conversions.'; CREATE TABLE mdl_repository (
    id BIGINT(10) NOT NULL auto_increment,
    type VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    visible TINYINT(1) DEFAULT 1,
    sortorder BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='This table contains one entry for every configured external '; CREATE TABLE mdl_repository_instances (
    id BIGINT(10) NOT NULL auto_increment,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    typeid BIGINT(10) NOT NULL,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    contextid BIGINT(10) NOT NULL,
    username VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    password VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    timecreated BIGINT(10),
    timemodified BIGINT(10),
    readonly TINYINT(1) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='This table contains one entry for every configured external '; CREATE TABLE mdl_repository_instance_config (
    id BIGINT(10) NOT NULL auto_increment,
    instanceid BIGINT(10) NOT NULL,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    value LONGTEXT COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='The config for intances'; CREATE TABLE mdl_backup_courses (
    id BIGINT(10) NOT NULL auto_increment,
    courseid BIGINT(10) NOT NULL DEFAULT 0,
    laststarttime BIGINT(10) NOT NULL DEFAULT 0,
    lastendtime BIGINT(10) NOT NULL DEFAULT 0,
    laststatus VARCHAR(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '5',
    nextstarttime BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY mdl_backcour_cou2_uix (courseid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='To store every course backup status'; CREATE TABLE mdl_block (
    id BIGINT(10) NOT NULL auto_increment,
    name VARCHAR(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    cron BIGINT(10) NOT NULL DEFAULT 0,
    lastcron BIGINT(10) NOT NULL DEFAULT 0,
    visible TINYINT(1) NOT NULL DEFAULT 1,
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY mdl_bloc_nam2_uix (name)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='contains all installed blocks'; CREATE TABLE mdl_block_instances (
    id BIGINT(10) NOT NULL auto_increment,
    blockname VARCHAR(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    parentcontextid BIGINT(10) NOT NULL,
    showinsubcontexts SMALLINT(4) NOT NULL,
    requiredbytheme SMALLINT(4) NOT NULL DEFAULT 0,
    pagetypepattern VARCHAR(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    subpagepattern VARCHAR(16) COLLATE utf8mb4_unicode_ci,
    defaultregion VARCHAR(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    defaultweight BIGINT(10) NOT NULL,
    configdata LONGTEXT COLLATE utf8mb4_unicode_ci,
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_blocinst_par2_fk FOREIGN KEY (parentcontextid) REFERENCES mdl_context (id)
, KEY mdl_blocinst_parshopagsub2_ix (parentcontextid, showinsubcontexts, pagetypepattern, subpagepattern)
, KEY mdl_blocinst_tim2_ix (timemodified)
, KEY mdl_blocinst_par4_ix (parentcontextid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='This table stores block instances. The type of block this is'; CREATE TABLE mdl_block_positions (
    id BIGINT(10) NOT NULL auto_increment,
    blockinstanceid BIGINT(10) NOT NULL,
    contextid BIGINT(10) NOT NULL,
    pagetype VARCHAR(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    subpage VARCHAR(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    visible SMALLINT(4) NOT NULL,
    region VARCHAR(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    weight BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_blocposi_blo2_fk FOREIGN KEY (blockinstanceid) REFERENCES mdl_block_instances (id),
CONSTRAINT mdl_blocposi_con2_fk FOREIGN KEY (contextid) REFERENCES mdl_context (id)
, UNIQUE KEY mdl_blocposi_bloconpagsub2_uix (blockinstanceid, contextid, pagetype, subpage)
, KEY mdl_blocposi_blo4_ix (blockinstanceid)
, KEY mdl_blocposi_con4_ix (contextid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stores the position of a sticky block_instance on a another '; CREATE TABLE mdl_comments (
    id BIGINT(10) NOT NULL auto_increment,
    contextid BIGINT(10) NOT NULL,
    component VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    commentarea VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    itemid BIGINT(10) NOT NULL,
    content LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    format TINYINT(2) NOT NULL DEFAULT 0,
    userid BIGINT(10) NOT NULL,
    timecreated BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_comm_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id)
, KEY mdl_comm_concomite2_ix (contextid, commentarea, itemid)
, KEY mdl_comm_use4_ix (userid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='moodle comments module'; CREATE TABLE mdl_external_services (
    id BIGINT(10) NOT NULL auto_increment,
    name VARCHAR(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    enabled TINYINT(1) NOT NULL,
    requiredcapability VARCHAR(150) COLLATE utf8mb4_unicode_ci,
    restrictedusers TINYINT(1) NOT NULL,
    component VARCHAR(100) COLLATE utf8mb4_unicode_ci,
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10),
    shortname VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    downloadfiles TINYINT(1) NOT NULL DEFAULT 0,
    uploadfiles TINYINT(1) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY mdl_exteserv_nam2_uix (name)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='built in and custom external services'; CREATE TABLE mdl_external_functions (
    id BIGINT(10) NOT NULL auto_increment,
    name VARCHAR(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    classname VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    methodname VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    classpath VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    component VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    capabilities VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    services VARCHAR(1333) COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY mdl_extefunc_nam2_uix (name)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='list of all external functions'; CREATE TABLE mdl_external_services_functions (
    id BIGINT(10) NOT NULL auto_increment,
    externalserviceid BIGINT(10) NOT NULL,
    functionname VARCHAR(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_exteservfunc_ext2_fk FOREIGN KEY (externalserviceid) REFERENCES mdl_external_services (id)
, KEY mdl_exteservfunc_ext4_ix (externalserviceid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='lists functions available in each service group'; CREATE TABLE mdl_external_services_users (
    id BIGINT(10) NOT NULL auto_increment,
    externalserviceid BIGINT(10) NOT NULL,
    userid BIGINT(10) NOT NULL,
    iprestriction VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    validuntil BIGINT(10),
    timecreated BIGINT(10),
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_exteservuser_ext2_fk FOREIGN KEY (externalserviceid) REFERENCES mdl_external_services (id),
CONSTRAINT mdl_exteservuser_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id)
, KEY mdl_exteservuser_ext4_ix (externalserviceid)
, KEY mdl_exteservuser_use4_ix (userid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='users allowed to use services with restricted users flag'; CREATE TABLE mdl_external_tokens (
    id BIGINT(10) NOT NULL auto_increment,
    token VARCHAR(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    privatetoken VARCHAR(64) COLLATE utf8mb4_unicode_ci,
    tokentype SMALLINT(4) NOT NULL,
    userid BIGINT(10) NOT NULL,
    externalserviceid BIGINT(10) NOT NULL,
    sid VARCHAR(128) COLLATE utf8mb4_unicode_ci,
    contextid BIGINT(10) NOT NULL,
    creatorid BIGINT(10) NOT NULL DEFAULT 1,
    iprestriction VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    validuntil BIGINT(10),
    timecreated BIGINT(10) NOT NULL,
    lastaccess BIGINT(10),
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_extetoke_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id),
CONSTRAINT mdl_extetoke_ext2_fk FOREIGN KEY (externalserviceid) REFERENCES mdl_external_services (id),
CONSTRAINT mdl_extetoke_con2_fk FOREIGN KEY (contextid) REFERENCES mdl_context (id),
CONSTRAINT mdl_extetoke_cre2_fk FOREIGN KEY (creatorid) REFERENCES mdl_user (id)
, KEY mdl_extetoke_use4_ix (userid)
, KEY mdl_extetoke_ext4_ix (externalserviceid)
, KEY mdl_extetoke_con4_ix (contextid)
, KEY mdl_extetoke_cre4_ix (creatorid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Security tokens for accessing of external services'; CREATE TABLE mdl_blog_association (
    id BIGINT(10) NOT NULL auto_increment,
    contextid BIGINT(10) NOT NULL,
    blogid BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_blogasso_con2_fk FOREIGN KEY (contextid) REFERENCES mdl_context (id),
CONSTRAINT mdl_blogasso_blo2_fk FOREIGN KEY (blogid) REFERENCES mdl_post (id)
, KEY mdl_blogasso_con4_ix (contextid)
, KEY mdl_blogasso_blo4_ix (blogid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Associations of blog entries with courses and module instanc'; CREATE TABLE mdl_blog_external (
    id BIGINT(10) NOT NULL auto_increment,
    userid BIGINT(10) NOT NULL,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    description LONGTEXT COLLATE utf8mb4_unicode_ci,
    url LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    filtertags VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    failedlastsync TINYINT(1) NOT NULL DEFAULT 0,
    timemodified BIGINT(10),
    timefetched BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_blogexte_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id)
, KEY mdl_blogexte_use4_ix (userid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='External blog links used for RSS copying of blog entries to '; CREATE TABLE mdl_rating (
    id BIGINT(10) NOT NULL auto_increment,
    contextid BIGINT(10) NOT NULL,
    component VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    ratingarea VARCHAR(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    itemid BIGINT(10) NOT NULL,
    scaleid BIGINT(10) NOT NULL,
    rating BIGINT(10) NOT NULL,
    userid BIGINT(10) NOT NULL,
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_rati_con2_fk FOREIGN KEY (contextid) REFERENCES mdl_context (id),
CONSTRAINT mdl_rati_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id)
, KEY mdl_rati_comratconite2_ix (component, ratingarea, contextid, itemid)
, KEY mdl_rati_con4_ix (contextid)
, KEY mdl_rati_use4_ix (userid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='moodle ratings'; CREATE TABLE mdl_license (
    id BIGINT(10) NOT NULL auto_increment,
    shortname VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    fullname LONGTEXT COLLATE utf8mb4_unicode_ci,
    source VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    enabled TINYINT(1) NOT NULL DEFAULT 1,
    version BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='store licenses used by moodle'; CREATE TABLE mdl_registration_hubs (
    id BIGINT(10) NOT NULL auto_increment,
    token VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    hubname VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    huburl VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    confirmed TINYINT(1) NOT NULL DEFAULT 0,
    secret VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='hub where the site is registered on with their associated to'; CREATE TABLE mdl_backup_controllers (
    id BIGINT(10) NOT NULL auto_increment,
    backupid VARCHAR(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    operation VARCHAR(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'backup',
    type VARCHAR(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    itemid BIGINT(10) NOT NULL,
    format VARCHAR(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    interactive SMALLINT(4) NOT NULL,
    purpose SMALLINT(4) NOT NULL,
    userid BIGINT(10) NOT NULL,
    status SMALLINT(4) NOT NULL,
    execution SMALLINT(4) NOT NULL,
    executiontime BIGINT(10) NOT NULL,
    checksum VARCHAR(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
    progress NUMERIC(15,14) NOT NULL DEFAULT 0,
    controller LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_backcont_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id)
, KEY mdl_backcont_typite2_ix (type, itemid)
, KEY mdl_backcont_useite2_ix (userid, itemid)
, UNIQUE KEY mdl_backcont_bac2_uix (backupid)
, KEY mdl_backcont_use4_ix (userid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='To store the backup_controllers as they are used'; CREATE TABLE mdl_backup_logs (
    id BIGINT(10) NOT NULL auto_increment,
    backupid VARCHAR(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    loglevel SMALLINT(4) NOT NULL,
    message LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    timecreated BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_backlogs_bac2_fk FOREIGN KEY (backupid) REFERENCES mdl_backup_controllers (backupid)
, UNIQUE KEY mdl_backlogs_bacid2_uix (backupid, id)
, KEY mdl_backlogs_bac4_ix (backupid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='To store all the logs from backup and restore operations (by'; CREATE TABLE mdl_profiling (
    id BIGINT(10) NOT NULL auto_increment,
    runid VARCHAR(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    url VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    data LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    totalexecutiontime BIGINT(10) NOT NULL,
    totalcputime BIGINT(10) NOT NULL,
    totalcalls BIGINT(10) NOT NULL,
    totalmemory BIGINT(10) NOT NULL,
    runreference TINYINT(2) NOT NULL DEFAULT 0,
    runcomment VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    timecreated BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_prof_urlrun2_ix (url, runreference)
, KEY mdl_prof_timrun2_ix (timecreated, runreference)
, UNIQUE KEY mdl_prof_run2_uix (runid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stores the results of all the profiling runs'; CREATE TABLE mdl_course_published (
    id BIGINT(10) NOT NULL auto_increment,
    huburl VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    courseid BIGINT(10) NOT NULL,
    timepublished BIGINT(10) NOT NULL,
    enrollable TINYINT(1) NOT NULL DEFAULT 1,
    hubcourseid BIGINT(10) NOT NULL,
    status TINYINT(1) DEFAULT 0,
    timechecked BIGINT(10),
CONSTRAINT  PRIMARY KEY (id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Information about how and when an local courses were publish'; CREATE TABLE mdl_grading_areas (
    id BIGINT(10) NOT NULL auto_increment,
    contextid BIGINT(10) NOT NULL,
    component VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    areaname VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    activemethod VARCHAR(100) COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_gradarea_con2_fk FOREIGN KEY (contextid) REFERENCES mdl_context (id)
, UNIQUE KEY mdl_gradarea_concomare2_uix (contextid, component, areaname)
, KEY mdl_gradarea_con4_ix (contextid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Identifies gradable areas where advanced grading can happen.'; CREATE TABLE mdl_grading_definitions (
    id BIGINT(10) NOT NULL auto_increment,
    areaid BIGINT(10) NOT NULL,
    method VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    description LONGTEXT COLLATE utf8mb4_unicode_ci,
    descriptionformat TINYINT(2),
    status BIGINT(10) NOT NULL DEFAULT 0,
    copiedfromid BIGINT(10),
    timecreated BIGINT(10) NOT NULL,
    usercreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
    usermodified BIGINT(10) NOT NULL,
    timecopied BIGINT(10) DEFAULT 0,
    options LONGTEXT COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_graddefi_are2_fk FOREIGN KEY (areaid) REFERENCES mdl_grading_areas (id),
CONSTRAINT mdl_graddefi_use3_fk FOREIGN KEY (usermodified) REFERENCES mdl_user (id),
CONSTRAINT mdl_graddefi_use4_fk FOREIGN KEY (usercreated) REFERENCES mdl_user (id)
, KEY mdl_graddefi_are4_ix (areaid)
, KEY mdl_graddefi_use6_ix (usermodified)
, UNIQUE KEY mdl_graddefi_aremet2_uix (areaid, method)
, KEY mdl_graddefi_use8_ix (usercreated)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Contains the basic information about an advanced grading for'; CREATE TABLE mdl_grading_instances (
    id BIGINT(10) NOT NULL auto_increment,
    definitionid BIGINT(10) NOT NULL,
    raterid BIGINT(10) NOT NULL,
    itemid BIGINT(10),
    rawgrade NUMERIC(10,5),
    status BIGINT(10) NOT NULL DEFAULT 0,
    feedback LONGTEXT COLLATE utf8mb4_unicode_ci,
    feedbackformat TINYINT(2),
    timemodified BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_gradinst_def2_fk FOREIGN KEY (definitionid) REFERENCES mdl_grading_definitions (id),
CONSTRAINT mdl_gradinst_rat2_fk FOREIGN KEY (raterid) REFERENCES mdl_user (id)
, KEY mdl_gradinst_def4_ix (definitionid)
, KEY mdl_gradinst_rat4_ix (raterid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Grading form instance is an assessment record for one gradab'; CREATE TABLE mdl_event_subscriptions (
    id BIGINT(10) NOT NULL auto_increment,
    url VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    categoryid BIGINT(10) NOT NULL DEFAULT 0,
    courseid BIGINT(10) NOT NULL DEFAULT 0,
    groupid BIGINT(10) NOT NULL DEFAULT 0,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    eventtype VARCHAR(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    pollinterval BIGINT(10) NOT NULL DEFAULT 0,
    lastupdated BIGINT(10),
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
CONSTRAINT  PRIMARY KEY (id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Tracks subscriptions to remote calendars.'; CREATE TABLE mdl_badge (
    id BIGINT(10) NOT NULL auto_increment,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    description LONGTEXT COLLATE utf8mb4_unicode_ci,
    timecreated BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
    usercreated BIGINT(10) NOT NULL,
    usermodified BIGINT(10) NOT NULL,
    issuername VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    issuerurl VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    issuercontact VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    expiredate BIGINT(10),
    expireperiod BIGINT(10),
    type TINYINT(1) NOT NULL DEFAULT 1,
    courseid BIGINT(10),
    message LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    messagesubject LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    attachment TINYINT(1) NOT NULL DEFAULT 1,
    notification TINYINT(1) NOT NULL DEFAULT 1,
    status TINYINT(1) NOT NULL DEFAULT 0,
    nextcron BIGINT(10),
    version VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    language VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    imageauthorname VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    imageauthoremail VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    imageauthorurl VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    imagecaption LONGTEXT COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_badg_cou2_fk FOREIGN KEY (courseid) REFERENCES mdl_course (id),
CONSTRAINT mdl_badg_use3_fk FOREIGN KEY (usermodified) REFERENCES mdl_user (id),
CONSTRAINT mdl_badg_use4_fk FOREIGN KEY (usercreated) REFERENCES mdl_user (id)
, KEY mdl_badg_typ2_ix (type)
, KEY mdl_badg_cou4_ix (courseid)
, KEY mdl_badg_use6_ix (usermodified)
, KEY mdl_badg_use8_ix (usercreated)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Defines badge'; CREATE TABLE mdl_badge_criteria (
    id BIGINT(10) NOT NULL auto_increment,
    badgeid BIGINT(10) NOT NULL DEFAULT 0,
    criteriatype BIGINT(10),
    method TINYINT(1) NOT NULL DEFAULT 1,
    description LONGTEXT COLLATE utf8mb4_unicode_ci,
    descriptionformat TINYINT(2) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_badgcrit_bad2_fk FOREIGN KEY (badgeid) REFERENCES mdl_badge (id)
, KEY mdl_badgcrit_cri2_ix (criteriatype)
, UNIQUE KEY mdl_badgcrit_badcri2_uix (badgeid, criteriatype)
, KEY mdl_badgcrit_bad4_ix (badgeid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Defines criteria for issuing badges'; CREATE TABLE mdl_badge_criteria_param (
    id BIGINT(10) NOT NULL auto_increment,
    critid BIGINT(10) NOT NULL,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    value VARCHAR(255) COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_badgcritpara_cri2_fk FOREIGN KEY (critid) REFERENCES mdl_badge_criteria (id)
, KEY mdl_badgcritpara_cri4_ix (critid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Defines parameters for badges criteria'; CREATE TABLE mdl_badge_issued (
    id BIGINT(10) NOT NULL auto_increment,
    badgeid BIGINT(10) NOT NULL DEFAULT 0,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    uniquehash LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    dateissued BIGINT(10) NOT NULL DEFAULT 0,
    dateexpire BIGINT(10),
    visible TINYINT(1) NOT NULL DEFAULT 0,
    issuernotified BIGINT(10),
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_badgissu_bad2_fk FOREIGN KEY (badgeid) REFERENCES mdl_badge (id),
CONSTRAINT mdl_badgissu_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id)
, UNIQUE KEY mdl_badgissu_baduse2_uix (badgeid, userid)
, KEY mdl_badgissu_bad4_ix (badgeid)
, KEY mdl_badgissu_use4_ix (userid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Defines issued badges'; CREATE TABLE mdl_badge_criteria_met (
    id BIGINT(10) NOT NULL auto_increment,
    issuedid BIGINT(10),
    critid BIGINT(10) NOT NULL,
    userid BIGINT(10) NOT NULL,
    datemet BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_badgcritmet_cri2_fk FOREIGN KEY (critid) REFERENCES mdl_badge_criteria (id),
CONSTRAINT mdl_badgcritmet_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id),
CONSTRAINT mdl_badgcritmet_iss2_fk FOREIGN KEY (issuedid) REFERENCES mdl_badge_issued (id)
, KEY mdl_badgcritmet_cri4_ix (critid)
, KEY mdl_badgcritmet_use4_ix (userid)
, KEY mdl_badgcritmet_iss4_ix (issuedid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Defines criteria that were met for an issued badge'; CREATE TABLE mdl_badge_endorsement (
    id BIGINT(10) NOT NULL auto_increment,
    badgeid BIGINT(10) NOT NULL DEFAULT 0,
    issuername VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    issuerurl VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    issueremail VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    claimid VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    claimcomment LONGTEXT COLLATE utf8mb4_unicode_ci,
    dateissued BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_badgendo_bad2_fk FOREIGN KEY (badgeid) REFERENCES mdl_badge (id)
, KEY mdl_badgendo_bad4_ix (badgeid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Defines endorsement for badge'; CREATE TABLE mdl_badge_manual_award (
    id BIGINT(10) NOT NULL auto_increment,
    badgeid BIGINT(10) NOT NULL,
    recipientid BIGINT(10) NOT NULL,
    issuerid BIGINT(10) NOT NULL,
    issuerrole BIGINT(10) NOT NULL,
    datemet BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_badgmanuawar_bad2_fk FOREIGN KEY (badgeid) REFERENCES mdl_badge (id),
CONSTRAINT mdl_badgmanuawar_rec2_fk FOREIGN KEY (recipientid) REFERENCES mdl_user (id),
CONSTRAINT mdl_badgmanuawar_iss3_fk FOREIGN KEY (issuerid) REFERENCES mdl_user (id),
CONSTRAINT mdl_badgmanuawar_iss4_fk FOREIGN KEY (issuerrole) REFERENCES mdl_role (id)
, KEY mdl_badgmanuawar_bad4_ix (badgeid)
, KEY mdl_badgmanuawar_rec4_ix (recipientid)
, KEY mdl_badgmanuawar_iss6_ix (issuerid)
, KEY mdl_badgmanuawar_iss8_ix (issuerrole)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Track manual award criteria for badges'; CREATE TABLE mdl_badge_backpack (
    id BIGINT(10) NOT NULL auto_increment,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    email VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    backpackuid BIGINT(10) NOT NULL,
    autosync TINYINT(1) NOT NULL DEFAULT 0,
    password VARCHAR(50) COLLATE utf8mb4_unicode_ci,
    externalbackpackid BIGINT(10),
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_badgback_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id),
CONSTRAINT mdl_badgback_ext2_fk FOREIGN KEY (externalbackpackid) REFERENCES mdl_badge_external_backpack (id)
, KEY mdl_badgback_use4_ix (userid)
, KEY mdl_badgback_ext4_ix (externalbackpackid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Defines settings for connecting external backpack'; CREATE TABLE mdl_badge_external (
    id BIGINT(10) NOT NULL auto_increment,
    backpackid BIGINT(10) NOT NULL,
    collectionid BIGINT(10) NOT NULL,
    entityid VARCHAR(255) COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_badgexte_bac2_fk FOREIGN KEY (backpackid) REFERENCES mdl_badge_backpack (id)
, KEY mdl_badgexte_bac4_ix (backpackid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Setting for external badges display'; CREATE TABLE mdl_badge_external_identifier (
    id BIGINT(10) NOT NULL auto_increment,
    sitebackpackid BIGINT(10) NOT NULL,
    internalid VARCHAR(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    externalid VARCHAR(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    type VARCHAR(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_badgexteiden_sit2_fk FOREIGN KEY (sitebackpackid) REFERENCES mdl_badge_backpack (id)
, KEY mdl_badgexteiden_sit4_ix (sitebackpackid)
, UNIQUE KEY mdl_badgexteiden_sitintex2_uix (sitebackpackid, internalid, externalid, type)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Setting for external badges mappings'; CREATE TABLE mdl_badge_alignment (
    id BIGINT(10) NOT NULL auto_increment,
    badgeid BIGINT(10) NOT NULL DEFAULT 0,
    targetname VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    targeturl VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    targetdescription LONGTEXT COLLATE utf8mb4_unicode_ci,
    targetframework VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    targetcode VARCHAR(255) COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_badgalig_bad2_fk FOREIGN KEY (badgeid) REFERENCES mdl_badge (id)
, KEY mdl_badgalig_bad4_ix (badgeid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Defines alignment for badges'; CREATE TABLE mdl_badge_related (
    id BIGINT(10) NOT NULL auto_increment,
    badgeid BIGINT(10) NOT NULL DEFAULT 0,
    relatedbadgeid BIGINT(10),
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_badgrela_bad2_fk FOREIGN KEY (badgeid) REFERENCES mdl_badge (id),
CONSTRAINT mdl_badgrela_rel2_fk FOREIGN KEY (relatedbadgeid) REFERENCES mdl_badge (id)
, KEY mdl_badgrela_bad4_ix (badgeid)
, KEY mdl_badgrela_rel4_ix (relatedbadgeid)
, UNIQUE KEY mdl_badgrela_badrel2_uix (badgeid, relatedbadgeid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Defines badge related for badges'; CREATE TABLE mdl_badge_external_backpack (
    id BIGINT(10) NOT NULL auto_increment,
    backpackapiurl VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    backpackweburl VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    apiversion VARCHAR(12) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1.0',
    sortorder BIGINT(10) NOT NULL DEFAULT 0,
    password VARCHAR(255) COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY mdl_badgexteback_bac3_uix (backpackapiurl)
, UNIQUE KEY mdl_badgexteback_bac4_uix (backpackweburl)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Defines settings for site level backpacks that a user can co'; CREATE TABLE mdl_user_devices (
    id BIGINT(10) NOT NULL auto_increment,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    appid VARCHAR(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    name VARCHAR(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    model VARCHAR(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    platform VARCHAR(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    version VARCHAR(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    pushid VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    uuid VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_userdevi_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id)
, KEY mdl_userdevi_uuiuse2_ix (uuid, userid)
, UNIQUE KEY mdl_userdevi_pususe2_uix (pushid, userid)
, KEY mdl_userdevi_use4_ix (userid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='This table stores user\'s mobile devices information in order'; CREATE TABLE mdl_user_password_resets (
    id BIGINT(10) NOT NULL auto_increment,
    userid BIGINT(10) NOT NULL,
    timerequested BIGINT(10) NOT NULL,
    timererequested BIGINT(10) NOT NULL DEFAULT 0,
    token VARCHAR(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_userpassrese_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id)
, KEY mdl_userpassrese_use4_ix (userid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='table tracking password reset confirmation tokens'; CREATE TABLE mdl_lock_db (
    id BIGINT(10) NOT NULL auto_increment,
    resourcekey VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    expires BIGINT(10),
    owner VARCHAR(36) COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY mdl_lockdb_res2_uix (resourcekey)
, KEY mdl_lockdb_exp2_ix (expires)
, KEY mdl_lockdb_own2_ix (owner)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stores active and inactive lock types for db locking method.'; CREATE TABLE mdl_task_scheduled (
    id BIGINT(10) NOT NULL auto_increment,
    component VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    classname VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    lastruntime BIGINT(10),
    nextruntime BIGINT(10),
    blocking TINYINT(2) NOT NULL DEFAULT 0,
    minute VARCHAR(25) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    hour VARCHAR(25) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    day VARCHAR(25) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    month VARCHAR(25) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    dayofweek VARCHAR(25) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    faildelay BIGINT(10),
    customised TINYINT(2) NOT NULL DEFAULT 0,
    disabled TINYINT(1) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY mdl_tasksche_cla2_uix (classname)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='List of scheduled tasks to be run by cron.'; CREATE TABLE mdl_task_adhoc (
    id BIGINT(10) NOT NULL auto_increment,
    component VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    classname VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    nextruntime BIGINT(10) NOT NULL,
    faildelay BIGINT(10),
    customdata LONGTEXT COLLATE utf8mb4_unicode_ci,
    userid BIGINT(10),
    blocking TINYINT(2) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_taskadho_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id)
, KEY mdl_taskadho_nex2_ix (nextruntime)
, KEY mdl_taskadho_use4_ix (userid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='List of adhoc tasks waiting to run.'; CREATE TABLE mdl_task_log (
    id BIGINT(10) NOT NULL auto_increment,
    type SMALLINT(4) NOT NULL,
    component VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    classname VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    userid BIGINT(10) NOT NULL,
    timestart NUMERIC(20,10) NOT NULL,
    timeend NUMERIC(20,10) NOT NULL,
    dbreads BIGINT(10) NOT NULL,
    dbwrites BIGINT(10) NOT NULL,
    result TINYINT(2) NOT NULL,
    output LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_tasklog_cla2_ix (classname)
, KEY mdl_tasklog_tim2_ix (timestart)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='The log table for all tasks'; CREATE TABLE mdl_messageinbound_handlers (
    id BIGINT(10) NOT NULL auto_increment,
    component VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    classname VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    defaultexpiration BIGINT(10) NOT NULL DEFAULT 86400,
    validateaddress TINYINT(1) NOT NULL DEFAULT 1,
    enabled TINYINT(1) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY mdl_messhand_cla2_uix (classname)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Inbound Message Handler definitions.'; CREATE TABLE mdl_messageinbound_datakeys (
    id BIGINT(10) NOT NULL auto_increment,
    handler BIGINT(10) NOT NULL,
    datavalue BIGINT(10) NOT NULL,
    datakey VARCHAR(64) COLLATE utf8mb4_unicode_ci,
    timecreated BIGINT(10) NOT NULL,
    expires BIGINT(10),
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_messdata_han2_fk FOREIGN KEY (handler) REFERENCES mdl_messageinbound_handlers (id)
, UNIQUE KEY mdl_messdata_handat2_uix (handler, datavalue)
, KEY mdl_messdata_han4_ix (handler)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Inbound Message data item secret keys.'; CREATE TABLE mdl_messageinbound_messagelist (
    id BIGINT(10) NOT NULL auto_increment,
    messageid LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    userid BIGINT(10) NOT NULL,
    address LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    timecreated BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_messmess_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id)
, KEY mdl_messmess_use4_ix (userid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='A list of message IDs for existing replies'; CREATE TABLE mdl_competency (
    id BIGINT(10) NOT NULL auto_increment,
    shortname VARCHAR(100) COLLATE utf8mb4_unicode_ci,
    description LONGTEXT COLLATE utf8mb4_unicode_ci,
    descriptionformat SMALLINT(4) NOT NULL DEFAULT 0,
    idnumber VARCHAR(100) COLLATE utf8mb4_unicode_ci,
    competencyframeworkid BIGINT(10) NOT NULL,
    parentid BIGINT(10) NOT NULL DEFAULT 0,
    path VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    sortorder BIGINT(10) NOT NULL,
    ruletype VARCHAR(100) COLLATE utf8mb4_unicode_ci,
    ruleoutcome TINYINT(2) NOT NULL DEFAULT 0,
    ruleconfig LONGTEXT COLLATE utf8mb4_unicode_ci,
    scaleid BIGINT(10),
    scaleconfiguration LONGTEXT COLLATE utf8mb4_unicode_ci,
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
    usermodified BIGINT(10),
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY mdl_comp_comidn2_uix (competencyframeworkid, idnumber)
, KEY mdl_comp_rul2_ix (ruleoutcome)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='This table contains the master record of each competency in '; CREATE TABLE mdl_competency_coursecompsetting (
    id BIGINT(10) NOT NULL auto_increment,
    courseid BIGINT(10) NOT NULL,
    pushratingstouserplans TINYINT(2),
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
    usermodified BIGINT(10),
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_compcour_cou2_fk FOREIGN KEY (courseid) REFERENCES mdl_course (id)
, UNIQUE KEY mdl_compcour_cou3_uix (courseid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='This table contains the course specific settings for compete'; CREATE TABLE mdl_competency_framework (
    id BIGINT(10) NOT NULL auto_increment,
    shortname VARCHAR(100) COLLATE utf8mb4_unicode_ci,
    contextid BIGINT(10) NOT NULL,
    idnumber VARCHAR(100) COLLATE utf8mb4_unicode_ci,
    description LONGTEXT COLLATE utf8mb4_unicode_ci,
    descriptionformat SMALLINT(4) NOT NULL DEFAULT 0,
    scaleid BIGINT(11),
    scaleconfiguration LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    visible TINYINT(2) NOT NULL DEFAULT 1,
    taxonomies VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
    usermodified BIGINT(10),
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY mdl_compfram_idn2_uix (idnumber)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='List of competency frameworks.'; CREATE TABLE mdl_competency_coursecomp (
    id BIGINT(10) NOT NULL auto_increment,
    courseid BIGINT(10) NOT NULL,
    competencyid BIGINT(10) NOT NULL,
    ruleoutcome TINYINT(2) NOT NULL,
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
    usermodified BIGINT(10) NOT NULL,
    sortorder BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_compcour_cou4_fk FOREIGN KEY (courseid) REFERENCES mdl_course (id),
CONSTRAINT mdl_compcour_com2_fk FOREIGN KEY (competencyid) REFERENCES mdl_competency (id)
, KEY mdl_compcour_courul2_ix (courseid, ruleoutcome)
, UNIQUE KEY mdl_compcour_coucom2_uix (courseid, competencyid)
, KEY mdl_compcour_cou6_ix (courseid)
, KEY mdl_compcour_com4_ix (competencyid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Link a competency to a course.'; CREATE TABLE mdl_competency_plan (
    id BIGINT(10) NOT NULL auto_increment,
    name VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    description LONGTEXT COLLATE utf8mb4_unicode_ci,
    descriptionformat SMALLINT(4) NOT NULL DEFAULT 0,
    userid BIGINT(10) NOT NULL,
    templateid BIGINT(10),
    origtemplateid BIGINT(10),
    status TINYINT(1) NOT NULL,
    duedate BIGINT(10) DEFAULT 0,
    reviewerid BIGINT(10),
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
    usermodified BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_compplan_usesta2_ix (userid, status)
, KEY mdl_compplan_tem2_ix (templateid)
, KEY mdl_compplan_stadue2_ix (status, duedate)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Learning plans'; CREATE TABLE mdl_competency_template (
    id BIGINT(10) NOT NULL auto_increment,
    shortname VARCHAR(100) COLLATE utf8mb4_unicode_ci,
    contextid BIGINT(10) NOT NULL,
    description LONGTEXT COLLATE utf8mb4_unicode_ci,
    descriptionformat SMALLINT(4) NOT NULL DEFAULT 0,
    visible TINYINT(2) NOT NULL DEFAULT 1,
    duedate BIGINT(10),
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
    usermodified BIGINT(10),
CONSTRAINT  PRIMARY KEY (id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Learning plan templates.'; CREATE TABLE mdl_competency_templatecomp (
    id BIGINT(10) NOT NULL auto_increment,
    templateid BIGINT(10) NOT NULL,
    competencyid BIGINT(10) NOT NULL,
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
    usermodified BIGINT(10) NOT NULL,
    sortorder BIGINT(10),
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_comptemp_tem2_fk FOREIGN KEY (templateid) REFERENCES mdl_competency_template (id),
CONSTRAINT mdl_comptemp_com2_fk FOREIGN KEY (competencyid) REFERENCES mdl_competency (id)
, KEY mdl_comptemp_tem4_ix (templateid)
, KEY mdl_comptemp_com4_ix (competencyid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Link a competency to a learning plan template.'; CREATE TABLE mdl_competency_templatecohort (
    id BIGINT(10) NOT NULL auto_increment,
    templateid BIGINT(10) NOT NULL,
    cohortid BIGINT(10) NOT NULL,
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
    usermodified BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_comptemp_tem5_ix (templateid)
, UNIQUE KEY mdl_comptemp_temcoh2_uix (templateid, cohortid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Default comment for the table, please edit me'; CREATE TABLE mdl_competency_relatedcomp (
    id BIGINT(10) NOT NULL auto_increment,
    competencyid BIGINT(10) NOT NULL,
    relatedcompetencyid BIGINT(10) NOT NULL,
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10),
    usermodified BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Related competencies'; CREATE TABLE mdl_competency_usercomp (
    id BIGINT(10) NOT NULL auto_increment,
    userid BIGINT(10) NOT NULL,
    competencyid BIGINT(10) NOT NULL,
    status TINYINT(2) NOT NULL DEFAULT 0,
    reviewerid BIGINT(10),
    proficiency TINYINT(2),
    grade BIGINT(10),
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10),
    usermodified BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY mdl_compuser_usecom2_uix (userid, competencyid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='User competencies'; CREATE TABLE mdl_competency_usercompcourse (
    id BIGINT(10) NOT NULL auto_increment,
    userid BIGINT(10) NOT NULL,
    courseid BIGINT(10) NOT NULL,
    competencyid BIGINT(10) NOT NULL,
    proficiency TINYINT(2),
    grade BIGINT(10),
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10),
    usermodified BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY mdl_compuser_usecoucom2_uix (userid, courseid, competencyid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='User competencies in a course'; CREATE TABLE mdl_competency_usercompplan (
    id BIGINT(10) NOT NULL auto_increment,
    userid BIGINT(10) NOT NULL,
    competencyid BIGINT(10) NOT NULL,
    planid BIGINT(10) NOT NULL,
    proficiency TINYINT(2),
    grade BIGINT(10),
    sortorder BIGINT(10),
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10),
    usermodified BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY mdl_compuser_usecompla2_uix (userid, competencyid, planid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='User competencies plans'; CREATE TABLE mdl_competency_plancomp (
    id BIGINT(10) NOT NULL auto_increment,
    planid BIGINT(10) NOT NULL,
    competencyid BIGINT(10) NOT NULL,
    sortorder BIGINT(10),
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10),
    usermodified BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY mdl_compplan_placom2_uix (planid, competencyid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Plan competencies'; CREATE TABLE mdl_competency_evidence (
    id BIGINT(10) NOT NULL auto_increment,
    usercompetencyid BIGINT(10) NOT NULL,
    contextid BIGINT(10) NOT NULL,
    action TINYINT(2) NOT NULL,
    actionuserid BIGINT(10),
    descidentifier VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    desccomponent VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    desca LONGTEXT COLLATE utf8mb4_unicode_ci,
    url VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    grade BIGINT(10),
    note LONGTEXT COLLATE utf8mb4_unicode_ci,
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
    usermodified BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_compevid_use2_ix (usercompetencyid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='The evidence linked to a user competency'; CREATE TABLE mdl_competency_userevidence (
    id BIGINT(10) NOT NULL auto_increment,
    userid BIGINT(10) NOT NULL,
    name VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    description LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    descriptionformat TINYINT(1) NOT NULL,
    url LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
    usermodified BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_compuser_use2_ix (userid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='The evidence of prior learning'; CREATE TABLE mdl_competency_userevidencecomp (
    id BIGINT(10) NOT NULL auto_increment,
    userevidenceid BIGINT(10) NOT NULL,
    competencyid BIGINT(10) NOT NULL,
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
    usermodified BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_compuser_use3_ix (userevidenceid)
, UNIQUE KEY mdl_compuser_usecom3_uix (userevidenceid, competencyid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Relationship between user evidence and competencies'; CREATE TABLE mdl_competency_modulecomp (
    id BIGINT(10) NOT NULL auto_increment,
    cmid BIGINT(10) NOT NULL,
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
    usermodified BIGINT(10) NOT NULL,
    sortorder BIGINT(10) NOT NULL,
    competencyid BIGINT(10) NOT NULL,
    ruleoutcome TINYINT(2) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_compmodu_cmi2_fk FOREIGN KEY (cmid) REFERENCES mdl_course_modules (id),
CONSTRAINT mdl_compmodu_com2_fk FOREIGN KEY (competencyid) REFERENCES mdl_competency (id)
, KEY mdl_compmodu_cmirul2_ix (cmid, ruleoutcome)
, UNIQUE KEY mdl_compmodu_cmicom2_uix (cmid, competencyid)
, KEY mdl_compmodu_cmi4_ix (cmid)
, KEY mdl_compmodu_com4_ix (competencyid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Link a competency to a module.'; CREATE TABLE mdl_oauth2_endpoint (
    id BIGINT(10) NOT NULL auto_increment,
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
    usermodified BIGINT(10) NOT NULL,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    url LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    issuerid BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_oautendp_iss2_fk FOREIGN KEY (issuerid) REFERENCES mdl_oauth2_issuer (id)
, KEY mdl_oautendp_iss4_ix (issuerid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Describes the named endpoint for an oauth2 service.'; CREATE TABLE mdl_oauth2_issuer (
    id BIGINT(10) NOT NULL auto_increment,
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
    usermodified BIGINT(10) NOT NULL,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    image LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    baseurl LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    clientid LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    clientsecret LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    loginscopes LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    loginscopesoffline LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    loginparams LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    loginparamsoffline LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    alloweddomains LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    scopessupported LONGTEXT COLLATE utf8mb4_unicode_ci,
    enabled TINYINT(2) NOT NULL DEFAULT 1,
    showonloginpage TINYINT(2) NOT NULL DEFAULT 1,
    basicauth TINYINT(2) NOT NULL DEFAULT 0,
    sortorder BIGINT(10) NOT NULL,
    requireconfirmation TINYINT(2) NOT NULL DEFAULT 1,
CONSTRAINT  PRIMARY KEY (id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Details for an oauth 2 connect identity issuer.'; CREATE TABLE mdl_oauth2_system_account (
    id BIGINT(10) NOT NULL auto_increment,
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
    usermodified BIGINT(10) NOT NULL,
    issuerid BIGINT(10) NOT NULL,
    refreshtoken LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    grantedscopes LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    email LONGTEXT COLLATE utf8mb4_unicode_ci,
    username LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_oautsystacco_iss_fk FOREIGN KEY (issuerid) REFERENCES mdl_oauth2_issuer (id)
, UNIQUE KEY mdl_oautsystacco_iss2_uix (issuerid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stored details used to get an access token as a system user '; CREATE TABLE mdl_oauth2_user_field_mapping (
    id BIGINT(10) NOT NULL auto_increment,
    timemodified BIGINT(10) NOT NULL,
    timecreated BIGINT(10) NOT NULL,
    usermodified BIGINT(10) NOT NULL,
    issuerid BIGINT(10) NOT NULL,
    externalfield VARCHAR(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    internalfield VARCHAR(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_oautuserfielmapp_iss2_fk FOREIGN KEY (issuerid) REFERENCES mdl_oauth2_issuer (id)
, KEY mdl_oautuserfielmapp_iss4_ix (issuerid)
, UNIQUE KEY mdl_oautuserfielmapp_issi2_uix (issuerid, internalfield)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Mapping of oauth user fields to moodle fields.'; CREATE TABLE mdl_course_completion_defaults (
    id BIGINT(10) NOT NULL auto_increment,
    course BIGINT(10) NOT NULL,
    module BIGINT(10) NOT NULL,
    completion TINYINT(1) NOT NULL DEFAULT 0,
    completionview TINYINT(1) NOT NULL DEFAULT 0,
    completionusegrade TINYINT(1) NOT NULL DEFAULT 0,
    completionexpected BIGINT(10) NOT NULL DEFAULT 0,
    customrules LONGTEXT COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_courcompdefa_mod2_fk FOREIGN KEY (module) REFERENCES mdl_modules (id),
CONSTRAINT mdl_courcompdefa_cou2_fk FOREIGN KEY (course) REFERENCES mdl_course (id)
, UNIQUE KEY mdl_courcompdefa_coumod2_uix (course, module)
, KEY mdl_courcompdefa_mod4_ix (module)
, KEY mdl_courcompdefa_cou4_ix (course)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Default settings for activities completion'; CREATE TABLE mdl_analytics_models (
    id BIGINT(10) NOT NULL auto_increment,
    enabled TINYINT(1) NOT NULL DEFAULT 0,
    trained TINYINT(1) NOT NULL DEFAULT 0,
    name VARCHAR(1333) COLLATE utf8mb4_unicode_ci,
    target VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    indicators LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    timesplitting VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    predictionsprocessor VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    version BIGINT(10) NOT NULL,
    timecreated BIGINT(10),
    timemodified BIGINT(10) NOT NULL,
    usermodified BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_analmode_enatra2_ix (enabled, trained)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Analytic models.'; CREATE TABLE mdl_analytics_models_log (
    id BIGINT(10) NOT NULL auto_increment,
    modelid BIGINT(10) NOT NULL,
    version BIGINT(10) NOT NULL,
    evaluationmode VARCHAR(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    target VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    indicators LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    timesplitting VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    score NUMERIC(10,5) NOT NULL DEFAULT 0,
    info LONGTEXT COLLATE utf8mb4_unicode_ci,
    dir LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    timecreated BIGINT(10) NOT NULL,
    usermodified BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_analmodelog_mod2_fk FOREIGN KEY (modelid) REFERENCES mdl_analytics_models (id)
, KEY mdl_analmodelog_mod4_ix (modelid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Analytic models changes during evaluation.'; CREATE TABLE mdl_analytics_predictions (
    id BIGINT(10) NOT NULL auto_increment,
    modelid BIGINT(10) NOT NULL,
    contextid BIGINT(10) NOT NULL,
    sampleid BIGINT(10) NOT NULL,
    rangeindex MEDIUMINT(5) NOT NULL,
    prediction NUMERIC(10,2) NOT NULL,
    predictionscore NUMERIC(10,5) NOT NULL,
    calculations LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    timecreated BIGINT(10) NOT NULL DEFAULT 0,
    timestart BIGINT(10),
    timeend BIGINT(10),
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_analpred_mod2_fk FOREIGN KEY (modelid) REFERENCES mdl_analytics_models (id),
CONSTRAINT mdl_analpred_con2_fk FOREIGN KEY (contextid) REFERENCES mdl_context (id)
, KEY mdl_analpred_modcon2_ix (modelid, contextid)
, KEY mdl_analpred_mod4_ix (modelid)
, KEY mdl_analpred_con4_ix (contextid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Predictions'; CREATE TABLE mdl_analytics_train_samples (
    id BIGINT(10) NOT NULL auto_increment,
    modelid BIGINT(10) NOT NULL,
    analysableid BIGINT(10) NOT NULL,
    timesplitting VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    sampleids LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    timecreated BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_analtraisamp_mod2_fk FOREIGN KEY (modelid) REFERENCES mdl_analytics_models (id)
, KEY mdl_analtraisamp_modanatim2_ix (modelid, analysableid, timesplitting)
, KEY mdl_analtraisamp_mod4_ix (modelid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Samples used for training'; CREATE TABLE mdl_analytics_predict_samples (
    id BIGINT(10) NOT NULL auto_increment,
    modelid BIGINT(10) NOT NULL,
    analysableid BIGINT(10) NOT NULL,
    timesplitting VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    rangeindex BIGINT(10) NOT NULL,
    sampleids LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    timecreated BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_analpredsamp_mod2_fk FOREIGN KEY (modelid) REFERENCES mdl_analytics_models (id)
, KEY mdl_analpredsamp_modanatim2_ix (modelid, analysableid, timesplitting, rangeindex)
, KEY mdl_analpredsamp_mod4_ix (modelid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Samples already used for predictions.'; CREATE TABLE mdl_analytics_used_files (
    id BIGINT(10) NOT NULL auto_increment,
    modelid BIGINT(10) NOT NULL DEFAULT 0,
    fileid BIGINT(10) NOT NULL DEFAULT 0,
    action VARCHAR(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    time BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_analusedfile_mod2_fk FOREIGN KEY (modelid) REFERENCES mdl_analytics_models (id),
CONSTRAINT mdl_analusedfile_fil2_fk FOREIGN KEY (fileid) REFERENCES mdl_files (id)
, KEY mdl_analusedfile_modactfil2_ix (modelid, action, fileid)
, KEY mdl_analusedfile_mod4_ix (modelid)
, KEY mdl_analusedfile_fil4_ix (fileid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Files that have already been used for training and predictio'; CREATE TABLE mdl_analytics_indicator_calc (
    id BIGINT(10) NOT NULL auto_increment,
    starttime BIGINT(10) NOT NULL,
    endtime BIGINT(10) NOT NULL,
    contextid BIGINT(10) NOT NULL,
    sampleorigin VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    sampleid BIGINT(10) NOT NULL,
    indicator VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    value NUMERIC(10,2),
    timecreated BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_analindicalc_con2_fk FOREIGN KEY (contextid) REFERENCES mdl_context (id)
, KEY mdl_analindicalc_staendcon2_ix (starttime, endtime, contextid)
, KEY mdl_analindicalc_con4_ix (contextid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stored indicator calculations'; CREATE TABLE mdl_analytics_prediction_actions (
    id BIGINT(10) NOT NULL auto_increment,
    predictionid BIGINT(10) NOT NULL,
    userid BIGINT(10) NOT NULL,
    actionname VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    timecreated BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_analpredacti_pre2_fk FOREIGN KEY (predictionid) REFERENCES mdl_analytics_predictions (id),
CONSTRAINT mdl_analpredacti_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id)
, KEY mdl_analpredacti_preuseact2_ix (predictionid, userid, actionname)
, KEY mdl_analpredacti_pre4_ix (predictionid)
, KEY mdl_analpredacti_use4_ix (userid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Register of user actions over predictions.'; CREATE TABLE mdl_oauth2_access_token (
    id BIGINT(10) NOT NULL auto_increment,
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
    usermodified BIGINT(10) NOT NULL,
    issuerid BIGINT(10) NOT NULL,
    token LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    expires BIGINT(10) NOT NULL,
    scope LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_oautaccetoke_iss_fk FOREIGN KEY (issuerid) REFERENCES mdl_oauth2_issuer (id)
, UNIQUE KEY mdl_oautaccetoke_iss2_uix (issuerid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stores access tokens for system accounts in order to be able'; CREATE TABLE mdl_analytics_used_analysables (
    id BIGINT(10) NOT NULL auto_increment,
    modelid BIGINT(10) NOT NULL,
    action VARCHAR(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    analysableid BIGINT(10) NOT NULL,
    firstanalysis BIGINT(10) NOT NULL,
    timeanalysed BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_analusedanal_mod2_fk FOREIGN KEY (modelid) REFERENCES mdl_analytics_models (id)
, KEY mdl_analusedanal_modact2_ix (modelid, action)
, KEY mdl_analusedanal_mod4_ix (modelid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='List of analysables used by each model'; CREATE TABLE mdl_search_index_requests (
    id BIGINT(10) NOT NULL auto_increment,
    contextid BIGINT(10) NOT NULL,
    searcharea VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    timerequested BIGINT(10) NOT NULL,
    partialarea VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    partialtime BIGINT(10) NOT NULL,
    indexpriority BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_searinderequ_con2_fk FOREIGN KEY (contextid) REFERENCES mdl_context (id)
, KEY mdl_searinderequ_indtim2_ix (indexpriority, timerequested)
, KEY mdl_searinderequ_con4_ix (contextid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Records requests for (re)indexing of specific contexts. Entr'; CREATE TABLE mdl_favourite (
    id BIGINT(10) NOT NULL auto_increment,
    component VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    itemtype VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    itemid BIGINT(10) NOT NULL,
    contextid BIGINT(10) NOT NULL,
    userid BIGINT(10) NOT NULL,
    ordering BIGINT(10),
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_favo_con2_fk FOREIGN KEY (contextid) REFERENCES mdl_context (id),
CONSTRAINT mdl_favo_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id)
, UNIQUE KEY mdl_favo_comiteiteconuse2_uix (component, itemtype, itemid, contextid, userid)
, KEY mdl_favo_con4_ix (contextid)
, KEY mdl_favo_use4_ix (userid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stores the relationship between an arbitrary item (itemtype,'; CREATE TABLE mdl_customfield_category (
    id BIGINT(10) NOT NULL auto_increment,
    name VARCHAR(400) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    description LONGTEXT COLLATE utf8mb4_unicode_ci,
    descriptionformat BIGINT(10),
    sortorder BIGINT(10),
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
    component VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    area VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    itemid BIGINT(10) NOT NULL DEFAULT 0,
    contextid BIGINT(10),
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_custcate_con2_fk FOREIGN KEY (contextid) REFERENCES mdl_context (id)
, KEY mdl_custcate_comareitesor2_ix (component, area, itemid, sortorder)
, KEY mdl_custcate_con4_ix (contextid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='core_customfield category table'; CREATE TABLE mdl_customfield_field (
    id BIGINT(10) NOT NULL auto_increment,
    shortname VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    name VARCHAR(400) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    type VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    description LONGTEXT COLLATE utf8mb4_unicode_ci,
    descriptionformat BIGINT(10),
    sortorder BIGINT(10),
    categoryid BIGINT(10),
    configdata LONGTEXT COLLATE utf8mb4_unicode_ci,
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_custfiel_cat2_fk FOREIGN KEY (categoryid) REFERENCES mdl_customfield_category (id)
, KEY mdl_custfiel_catsor2_ix (categoryid, sortorder)
, KEY mdl_custfiel_cat4_ix (categoryid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='core_customfield field table'; CREATE TABLE mdl_customfield_data (
    id BIGINT(10) NOT NULL auto_increment,
    fieldid BIGINT(10) NOT NULL,
    instanceid BIGINT(10) NOT NULL,
    intvalue BIGINT(10),
    decvalue NUMERIC(10,5),
    shortcharvalue VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    charvalue VARCHAR(1333) COLLATE utf8mb4_unicode_ci,
    value LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    valueformat BIGINT(10) NOT NULL,
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
    contextid BIGINT(10),
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_custdata_fie2_fk FOREIGN KEY (fieldid) REFERENCES mdl_customfield_field (id),
CONSTRAINT mdl_custdata_con2_fk FOREIGN KEY (contextid) REFERENCES mdl_context (id)
, UNIQUE KEY mdl_custdata_insfie2_uix (instanceid, fieldid)
, KEY mdl_custdata_fieint2_ix (fieldid, intvalue)
, KEY mdl_custdata_fiesho2_ix (fieldid, shortcharvalue)
, KEY mdl_custdata_fiedec2_ix (fieldid, decvalue)
, KEY mdl_custdata_fie4_ix (fieldid)
, KEY mdl_custdata_con4_ix (contextid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='core_customfield data table'; CREATE TABLE mdl_auth_oauth2_linked_login (
    id BIGINT(10) NOT NULL auto_increment,
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
    usermodified BIGINT(10) NOT NULL,
    userid BIGINT(10) NOT NULL,
    issuerid BIGINT(10) NOT NULL,
    username VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    email LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    confirmtoken VARCHAR(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    confirmtokenexpires BIGINT(10),
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_authoautlinklogi_use3_fk FOREIGN KEY (usermodified) REFERENCES mdl_user (id),
CONSTRAINT mdl_authoautlinklogi_use4_fk FOREIGN KEY (userid) REFERENCES mdl_user (id),
CONSTRAINT mdl_authoautlinklogi_iss2_fk FOREIGN KEY (issuerid) REFERENCES mdl_oauth2_issuer (id)
, KEY mdl_authoautlinklogi_issus2_ix (issuerid, username)
, KEY mdl_authoautlinklogi_use6_ix (usermodified)
, KEY mdl_authoautlinklogi_use8_ix (userid)
, KEY mdl_authoautlinklogi_iss4_ix (issuerid)
, UNIQUE KEY mdl_authoautlinklogi_usei2_uix (userid, issuerid, username)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Accounts linked to a users Moodle account.'; CREATE TABLE mdl_block_community (
    id BIGINT(10) NOT NULL auto_increment,
    userid BIGINT(10) NOT NULL,
    coursename VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    coursedescription LONGTEXT COLLATE utf8mb4_unicode_ci,
    courseurl VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    imageurl VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
CONSTRAINT  PRIMARY KEY (id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Community block'; CREATE TABLE mdl_block_recent_activity (
    id BIGINT(10) NOT NULL auto_increment,
    courseid BIGINT(10) NOT NULL,
    cmid BIGINT(10) NOT NULL,
    timecreated BIGINT(10) NOT NULL,
    userid BIGINT(10) NOT NULL,
    action TINYINT(1) NOT NULL,
    modname VARCHAR(20) COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_blocreceacti_coutim2_ix (courseid, timecreated)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Recent activity block'; CREATE TABLE mdl_block_recentlyaccesseditems (
    id BIGINT(10) NOT NULL auto_increment,
    courseid BIGINT(10) NOT NULL,
    cmid BIGINT(10) NOT NULL,
    userid BIGINT(10) NOT NULL,
    timeaccess BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_blocrece_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id),
CONSTRAINT mdl_blocrece_cou2_fk FOREIGN KEY (courseid) REFERENCES mdl_course (id),
CONSTRAINT mdl_blocrece_cmi2_fk FOREIGN KEY (cmid) REFERENCES mdl_course_modules (id)
, UNIQUE KEY mdl_blocrece_usecoucmi2_uix (userid, courseid, cmid)
, KEY mdl_blocrece_use4_ix (userid)
, KEY mdl_blocrece_cou4_ix (courseid)
, KEY mdl_blocrece_cmi4_ix (cmid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Most recently accessed items accessed by a user'; CREATE TABLE mdl_block_rss_client (
    id BIGINT(10) NOT NULL auto_increment,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    title LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    preferredtitle VARCHAR(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    description LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    shared TINYINT(2) NOT NULL DEFAULT 0,
    url VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    skiptime BIGINT(10) NOT NULL DEFAULT 0,
    skipuntil BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Remote news feed information. Contains the news feed id, the'; CREATE TABLE mdl_enrol_flatfile (
    id BIGINT(10) NOT NULL auto_increment,
    action VARCHAR(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    roleid BIGINT(10) NOT NULL,
    userid BIGINT(10) NOT NULL,
    courseid BIGINT(10) NOT NULL,
    timestart BIGINT(10) NOT NULL DEFAULT 0,
    timeend BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_enroflat_cou2_fk FOREIGN KEY (courseid) REFERENCES mdl_course (id),
CONSTRAINT mdl_enroflat_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id),
CONSTRAINT mdl_enroflat_rol2_fk FOREIGN KEY (roleid) REFERENCES mdl_role (id)
, KEY mdl_enroflat_cou4_ix (courseid)
, KEY mdl_enroflat_use4_ix (userid)
, KEY mdl_enroflat_rol4_ix (roleid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='enrol_flatfile table retrofitted from MySQL'; CREATE TABLE mdl_enrol_lti_tools (
    id BIGINT(10) NOT NULL auto_increment,
    enrolid BIGINT(10) NOT NULL,
    contextid BIGINT(10) NOT NULL,
    institution VARCHAR(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    lang VARCHAR(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'en',
    timezone VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '99',
    maxenrolled BIGINT(10) NOT NULL DEFAULT 0,
    maildisplay TINYINT(2) NOT NULL DEFAULT 2,
    city VARCHAR(120) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    country VARCHAR(2) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    gradesync TINYINT(1) NOT NULL DEFAULT 0,
    gradesynccompletion TINYINT(1) NOT NULL DEFAULT 0,
    membersync TINYINT(1) NOT NULL DEFAULT 0,
    membersyncmode TINYINT(1) NOT NULL DEFAULT 0,
    roleinstructor BIGINT(10) NOT NULL,
    rolelearner BIGINT(10) NOT NULL,
    secret LONGTEXT COLLATE utf8mb4_unicode_ci,
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_enroltitool_enr2_fk FOREIGN KEY (enrolid) REFERENCES mdl_enrol (id),
CONSTRAINT mdl_enroltitool_con2_fk FOREIGN KEY (contextid) REFERENCES mdl_context (id)
, KEY mdl_enroltitool_enr4_ix (enrolid)
, KEY mdl_enroltitool_con4_ix (contextid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='List of tools provided to the remote system'; CREATE TABLE mdl_enrol_lti_users (
    id BIGINT(10) NOT NULL auto_increment,
    userid BIGINT(10) NOT NULL,
    toolid BIGINT(10) NOT NULL,
    serviceurl LONGTEXT COLLATE utf8mb4_unicode_ci,
    sourceid LONGTEXT COLLATE utf8mb4_unicode_ci,
    consumerkey LONGTEXT COLLATE utf8mb4_unicode_ci,
    consumersecret LONGTEXT COLLATE utf8mb4_unicode_ci,
    membershipsurl LONGTEXT COLLATE utf8mb4_unicode_ci,
    membershipsid LONGTEXT COLLATE utf8mb4_unicode_ci,
    lastgrade NUMERIC(10,5),
    lastaccess BIGINT(10),
    timecreated BIGINT(10),
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_enroltiuser_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id),
CONSTRAINT mdl_enroltiuser_too2_fk FOREIGN KEY (toolid) REFERENCES mdl_enrol_lti_tools (id)
, KEY mdl_enroltiuser_use4_ix (userid)
, KEY mdl_enroltiuser_too4_ix (toolid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='User access log and gradeback data'; CREATE TABLE mdl_enrol_lti_lti2_consumer (
    id BIGINT(11) NOT NULL auto_increment,
    name VARCHAR(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    consumerkey256 VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    consumerkey LONGTEXT COLLATE utf8mb4_unicode_ci,
    secret VARCHAR(1024) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    ltiversion VARCHAR(10) COLLATE utf8mb4_unicode_ci,
    consumername VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    consumerversion VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    consumerguid VARCHAR(1024) COLLATE utf8mb4_unicode_ci,
    profile LONGTEXT COLLATE utf8mb4_unicode_ci,
    toolproxy LONGTEXT COLLATE utf8mb4_unicode_ci,
    settings LONGTEXT COLLATE utf8mb4_unicode_ci,
    protected TINYINT(1) NOT NULL,
    enabled TINYINT(1) NOT NULL,
    enablefrom BIGINT(10),
    enableuntil BIGINT(10),
    lastaccess BIGINT(10),
    created BIGINT(10) NOT NULL,
    updated BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY mdl_enroltilti2cons_con2_uix (consumerkey256)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='LTI consumers interacting with moodle'; CREATE TABLE mdl_enrol_lti_lti2_tool_proxy (
    id BIGINT(11) NOT NULL auto_increment,
    toolproxykey VARCHAR(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    consumerid BIGINT(11) NOT NULL,
    toolproxy LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    created BIGINT(10) NOT NULL,
    updated BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_enroltilti2toolprox_co2_fk FOREIGN KEY (consumerid) REFERENCES mdl_enrol_lti_lti2_consumer (id)
, UNIQUE KEY mdl_enroltilti2toolprox_t2_uix (toolproxykey)
, KEY mdl_enroltilti2toolprox_co4_ix (consumerid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='A tool proxy between moodle and a consumer'; CREATE TABLE mdl_enrol_lti_lti2_context (
    id BIGINT(11) NOT NULL auto_increment,
    consumerid BIGINT(11) NOT NULL,
    lticontextkey VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    type VARCHAR(100) COLLATE utf8mb4_unicode_ci,
    settings LONGTEXT COLLATE utf8mb4_unicode_ci,
    created BIGINT(10) NOT NULL,
    updated BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_enroltilti2cont_con2_fk FOREIGN KEY (consumerid) REFERENCES mdl_enrol_lti_lti2_consumer (id)
, KEY mdl_enroltilti2cont_con4_ix (consumerid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Information about a specific LTI contexts from the consumers'; CREATE TABLE mdl_enrol_lti_lti2_nonce (
    id BIGINT(11) NOT NULL auto_increment,
    consumerid BIGINT(11) NOT NULL,
    value VARCHAR(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    expires BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_enroltilti2nonc_con2_fk FOREIGN KEY (consumerid) REFERENCES mdl_enrol_lti_lti2_consumer (id)
, KEY mdl_enroltilti2nonc_con4_ix (consumerid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Nonce used for authentication between moodle and a consumer'; CREATE TABLE mdl_enrol_lti_lti2_resource_link (
    id BIGINT(11) NOT NULL auto_increment,
    contextid BIGINT(11),
    consumerid BIGINT(11),
    ltiresourcelinkkey VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    settings LONGTEXT COLLATE utf8mb4_unicode_ci,
    primaryresourcelinkid BIGINT(11),
    shareapproved TINYINT(1),
    created BIGINT(10) NOT NULL,
    updated BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_enroltilti2resolink_co3_fk FOREIGN KEY (contextid) REFERENCES mdl_enrol_lti_lti2_context (id),
CONSTRAINT mdl_enroltilti2resolink_pr2_fk FOREIGN KEY (primaryresourcelinkid) REFERENCES mdl_enrol_lti_lti2_resource_link (id),
CONSTRAINT mdl_enroltilti2resolink_co4_fk FOREIGN KEY (consumerid) REFERENCES mdl_enrol_lti_lti2_consumer (id)
, KEY mdl_enroltilti2resolink_co6_ix (contextid)
, KEY mdl_enroltilti2resolink_pr4_ix (primaryresourcelinkid)
, KEY mdl_enroltilti2resolink_co8_ix (consumerid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Link from the consumer to the tool'; CREATE TABLE mdl_enrol_lti_lti2_share_key (
    id BIGINT(11) NOT NULL auto_increment,
    sharekey VARCHAR(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    resourcelinkid BIGINT(11) NOT NULL,
    autoapprove TINYINT(1) NOT NULL,
    expires BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_enroltilti2sharkey_res_fk FOREIGN KEY (resourcelinkid) REFERENCES mdl_enrol_lti_lti2_resource_link (id)
, UNIQUE KEY mdl_enroltilti2sharkey_sh2_uix (sharekey)
, UNIQUE KEY mdl_enroltilti2sharkey_re2_uix (resourcelinkid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Resource link share key'; CREATE TABLE mdl_enrol_lti_lti2_user_result (
    id BIGINT(11) NOT NULL auto_increment,
    resourcelinkid BIGINT(11) NOT NULL,
    ltiuserkey VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    ltiresultsourcedid VARCHAR(1024) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    created BIGINT(10) NOT NULL,
    updated BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_enroltilti2userresu_re2_fk FOREIGN KEY (resourcelinkid) REFERENCES mdl_enrol_lti_lti2_resource_link (id)
, KEY mdl_enroltilti2userresu_re4_ix (resourcelinkid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Results for each user for each resource link'; CREATE TABLE mdl_enrol_lti_tool_consumer_map (
    id BIGINT(10) NOT NULL auto_increment,
    toolid BIGINT(11) NOT NULL,
    consumerid BIGINT(11) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_enroltitoolconsmap_too2_fk FOREIGN KEY (toolid) REFERENCES mdl_enrol_lti_tools (id),
CONSTRAINT mdl_enroltitoolconsmap_con2_fk FOREIGN KEY (consumerid) REFERENCES mdl_enrol_lti_lti2_consumer (id)
, KEY mdl_enroltitoolconsmap_too4_ix (toolid)
, KEY mdl_enroltitoolconsmap_con4_ix (consumerid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Table that maps the published tool to tool consumers.'; CREATE TABLE mdl_enrol_paypal (
    id BIGINT(10) NOT NULL auto_increment,
    business VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    receiver_email VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    receiver_id VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    item_name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    courseid BIGINT(10) NOT NULL DEFAULT 0,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    instanceid BIGINT(10) NOT NULL DEFAULT 0,
    memo VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    tax VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    option_name1 VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    option_selection1_x VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    option_name2 VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    option_selection2_x VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    payment_status VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    pending_reason VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    reason_code VARCHAR(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    txn_id VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    parent_txn_id VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    payment_type VARCHAR(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    timeupdated BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_enropayp_cou2_fk FOREIGN KEY (courseid) REFERENCES mdl_course (id),
CONSTRAINT mdl_enropayp_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id),
CONSTRAINT mdl_enropayp_ins2_fk FOREIGN KEY (instanceid) REFERENCES mdl_enrol (id)
, KEY mdl_enropayp_bus2_ix (business)
, KEY mdl_enropayp_rec2_ix (receiver_email)
, KEY mdl_enropayp_cou4_ix (courseid)
, KEY mdl_enropayp_use4_ix (userid)
, KEY mdl_enropayp_ins4_ix (instanceid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Holds all known information about PayPal transactions'; CREATE TABLE mdl_local_commentbank (
    id BIGINT(10) NOT NULL auto_increment,
    commenttext LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    contextlevel BIGINT(10),
    instanceid BIGINT(10),
    authoredby BIGINT(10),
    timemodified BIGINT(10),
    timecreated BIGINT(10),
    updatedby BIGINT(10),
CONSTRAINT  PRIMARY KEY (id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Comments that can be re-used in other modules'; CREATE TABLE mdl_local_metadata (
    id BIGINT(10) NOT NULL auto_increment,
    instanceid BIGINT(10) NOT NULL DEFAULT 0,
    fieldid BIGINT(10) NOT NULL DEFAULT 0,
    data LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    dataformat TINYINT(2) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY mdl_locameta_insfie2_uix (instanceid, fieldid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Default comment for local_metadata, please edit me'; CREATE TABLE mdl_local_metadata_field (
    id BIGINT(10) NOT NULL auto_increment,
    contextlevel SMALLINT(4) NOT NULL DEFAULT 0,
    shortname VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'shortname',
    name LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    datatype VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    description LONGTEXT COLLATE utf8mb4_unicode_ci,
    descriptionformat TINYINT(2) NOT NULL DEFAULT 0,
    categoryid BIGINT(10) NOT NULL DEFAULT 0,
    sortorder BIGINT(10) NOT NULL DEFAULT 0,
    required TINYINT(2) NOT NULL DEFAULT 0,
    locked TINYINT(2) NOT NULL DEFAULT 0,
    visible SMALLINT(4) NOT NULL DEFAULT 0,
    forceunique TINYINT(2) NOT NULL DEFAULT 0,
    signup TINYINT(2) NOT NULL DEFAULT 0,
    defaultdata LONGTEXT COLLATE utf8mb4_unicode_ci,
    defaultdataformat TINYINT(2) NOT NULL DEFAULT 0,
    param1 LONGTEXT COLLATE utf8mb4_unicode_ci,
    param2 LONGTEXT COLLATE utf8mb4_unicode_ci,
    param3 LONGTEXT COLLATE utf8mb4_unicode_ci,
    param4 LONGTEXT COLLATE utf8mb4_unicode_ci,
    param5 LONGTEXT COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_locametafiel_con2_ix (contextlevel)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Custom fields defined for Moodle contexts.'; CREATE TABLE mdl_local_metadata_category (
    id BIGINT(10) NOT NULL auto_increment,
    contextlevel SMALLINT(4) NOT NULL DEFAULT 0,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    sortorder BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_locametacate_con2_ix (contextlevel)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Context field categories'; CREATE TABLE mdl_local_moderation (
    id BIGINT(10) NOT NULL auto_increment,
    messageid BIGINT(10),
    reason VARCHAR(25) COLLATE utf8mb4_unicode_ci,
    flagtext BIGINT(10),
    isapproved TINYINT(1),
    timecreated BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_locamode_mes2_fk FOREIGN KEY (messageid) REFERENCES mdl_messages (id)
, KEY mdl_locamode_mes4_ix (messageid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='message moderation queue'; CREATE TABLE mdl_local_moderation_flagtext (
    id BIGINT(10) NOT NULL auto_increment,
    flagtext VARCHAR(500) COLLATE utf8mb4_unicode_ci,
    usermodified BIGINT(10) NOT NULL DEFAULT 0,
    timecreated BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_locamodeflag_use2_fk FOREIGN KEY (usermodified) REFERENCES mdl_user (id)
, KEY mdl_locamodeflag_use4_ix (usermodified)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Text that triggers message flagging'; CREATE TABLE mdl_adaptivequiz (
    id BIGINT(10) NOT NULL auto_increment,
    course BIGINT(10) NOT NULL DEFAULT 0,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    intro LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    introformat SMALLINT(4) NOT NULL DEFAULT 0,
    attempts TINYINT(2) NOT NULL DEFAULT 0,
    password VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    browsersecurity TINYINT(1) NOT NULL DEFAULT 0,
    attemptfeedback LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    attemptfeedbackformat TINYINT(2) NOT NULL DEFAULT 0,
    highestlevel SMALLINT(3) NOT NULL DEFAULT 0,
    lowestlevel SMALLINT(3) NOT NULL DEFAULT 0,
    minimumquestions SMALLINT(3) NOT NULL DEFAULT 0,
    maximumquestions SMALLINT(3) NOT NULL DEFAULT 0,
    standarderror NUMERIC(10,5) NOT NULL DEFAULT 0.0,
    startinglevel SMALLINT(3) NOT NULL DEFAULT 0,
    grademethod SMALLINT(3) NOT NULL DEFAULT 0,
    timecreated BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_adap_cou2_fk FOREIGN KEY (course) REFERENCES mdl_course (id)
, KEY mdl_adap_cou4_ix (course)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Adaptive quiz instances table'; CREATE TABLE mdl_adaptivequiz_question (
    id BIGINT(10) NOT NULL auto_increment,
    instance BIGINT(10) NOT NULL DEFAULT 0,
    questioncategory BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_adapques_ins2_fk FOREIGN KEY (instance) REFERENCES mdl_adaptivequiz (id),
CONSTRAINT mdl_adapques_que2_fk FOREIGN KEY (questioncategory) REFERENCES mdl_question_categories (id)
, KEY mdl_adapques_ins4_ix (instance)
, KEY mdl_adapques_que4_ix (questioncategory)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='An association table for activity instance and question cate'; CREATE TABLE mdl_adaptivequiz_attempt (
    id BIGINT(10) NOT NULL auto_increment,
    instance BIGINT(10) NOT NULL DEFAULT 0,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    uniqueid BIGINT(10) NOT NULL DEFAULT 0,
    attemptstate VARCHAR(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    attemptstopcriteria VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    questionsattempted BIGINT(10) NOT NULL DEFAULT 0,
    difficultysum NUMERIC(10,7) NOT NULL DEFAULT 0.0,
    standarderror NUMERIC(10,5) NOT NULL DEFAULT 0.0,
    measure NUMERIC(10,5) NOT NULL DEFAULT 0.0,
    timecreated BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_adapatte_ins2_fk FOREIGN KEY (instance) REFERENCES mdl_adaptivequiz (id),
CONSTRAINT mdl_adapatte_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id),
CONSTRAINT mdl_adapatte_uni2_fk FOREIGN KEY (uniqueid) REFERENCES mdl_question_usages (id)
, KEY mdl_adapatte_insuse2_ix (instance, userid)
, KEY mdl_adapatte_ins4_ix (instance)
, KEY mdl_adapatte_use4_ix (userid)
, KEY mdl_adapatte_uni4_ix (uniqueid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Logging of attempts'; CREATE TABLE mdl_assign (
    id BIGINT(10) NOT NULL auto_increment,
    course BIGINT(10) NOT NULL DEFAULT 0,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    intro LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    introformat SMALLINT(4) NOT NULL DEFAULT 0,
    alwaysshowdescription TINYINT(2) NOT NULL DEFAULT 0,
    nosubmissions TINYINT(2) NOT NULL DEFAULT 0,
    submissiondrafts TINYINT(2) NOT NULL DEFAULT 0,
    sendnotifications TINYINT(2) NOT NULL DEFAULT 0,
    sendlatenotifications TINYINT(2) NOT NULL DEFAULT 0,
    duedate BIGINT(10) NOT NULL DEFAULT 0,
    allowsubmissionsfromdate BIGINT(10) NOT NULL DEFAULT 0,
    grade BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
    requiresubmissionstatement TINYINT(2) NOT NULL DEFAULT 0,
    completionsubmit TINYINT(2) NOT NULL DEFAULT 0,
    cutoffdate BIGINT(10) NOT NULL DEFAULT 0,
    gradingduedate BIGINT(10) NOT NULL DEFAULT 0,
    teamsubmission TINYINT(2) NOT NULL DEFAULT 0,
    requireallteammemberssubmit TINYINT(2) NOT NULL DEFAULT 0,
    teamsubmissiongroupingid BIGINT(10) NOT NULL DEFAULT 0,
    blindmarking TINYINT(2) NOT NULL DEFAULT 0,
    hidegrader TINYINT(2) NOT NULL DEFAULT 0,
    revealidentities TINYINT(2) NOT NULL DEFAULT 0,
    attemptreopenmethod VARCHAR(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'none',
    maxattempts MEDIUMINT(6) NOT NULL DEFAULT -1,
    markingworkflow TINYINT(2) NOT NULL DEFAULT 0,
    markingallocation TINYINT(2) NOT NULL DEFAULT 0,
    sendstudentnotifications TINYINT(2) NOT NULL DEFAULT 1,
    preventsubmissionnotingroup TINYINT(2) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_assi_cou2_ix (course)
, KEY mdl_assi_tea2_ix (teamsubmissiongroupingid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='This table saves information about an instance of mod_assign'; CREATE TABLE mdl_assign_submission (
    id BIGINT(10) NOT NULL auto_increment,
    assignment BIGINT(10) NOT NULL DEFAULT 0,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    timecreated BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
    status VARCHAR(10) COLLATE utf8mb4_unicode_ci,
    groupid BIGINT(10) NOT NULL DEFAULT 0,
    attemptnumber BIGINT(10) NOT NULL DEFAULT 0,
    latest TINYINT(2) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_assisubm_ass2_fk FOREIGN KEY (assignment) REFERENCES mdl_assign (id)
, KEY mdl_assisubm_use2_ix (userid)
, KEY mdl_assisubm_att2_ix (attemptnumber)
, UNIQUE KEY mdl_assisubm_assusegroatt2_uix (assignment, userid, groupid, attemptnumber)
, KEY mdl_assisubm_assusegrolat2_ix (assignment, userid, groupid, latest)
, KEY mdl_assisubm_ass4_ix (assignment)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='This table keeps information about student interactions with'; CREATE TABLE mdl_assign_grades (
    id BIGINT(10) NOT NULL auto_increment,
    assignment BIGINT(10) NOT NULL DEFAULT 0,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    timecreated BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
    grader BIGINT(10) NOT NULL DEFAULT 0,
    grade NUMERIC(10,5) DEFAULT 0,
    attemptnumber BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_assigrad_ass2_fk FOREIGN KEY (assignment) REFERENCES mdl_assign (id)
, KEY mdl_assigrad_use2_ix (userid)
, KEY mdl_assigrad_att2_ix (attemptnumber)
, UNIQUE KEY mdl_assigrad_assuseatt2_uix (assignment, userid, attemptnumber)
, KEY mdl_assigrad_ass4_ix (assignment)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Grading information about a single assignment submission.'; CREATE TABLE mdl_assign_plugin_config (
    id BIGINT(10) NOT NULL auto_increment,
    assignment BIGINT(10) NOT NULL DEFAULT 0,
    plugin VARCHAR(28) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    subtype VARCHAR(28) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    name VARCHAR(28) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    value LONGTEXT COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_assiplugconf_ass2_fk FOREIGN KEY (assignment) REFERENCES mdl_assign (id)
, KEY mdl_assiplugconf_plu2_ix (plugin)
, KEY mdl_assiplugconf_sub2_ix (subtype)
, KEY mdl_assiplugconf_nam2_ix (name)
, KEY mdl_assiplugconf_ass4_ix (assignment)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Config data for an instance of a plugin in an assignment.'; CREATE TABLE mdl_assign_user_mapping (
    id BIGINT(10) NOT NULL auto_increment,
    assignment BIGINT(10) NOT NULL DEFAULT 0,
    userid BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_assiusermapp_ass2_fk FOREIGN KEY (assignment) REFERENCES mdl_assign (id),
CONSTRAINT mdl_assiusermapp_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id)
, KEY mdl_assiusermapp_ass4_ix (assignment)
, KEY mdl_assiusermapp_use4_ix (userid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Map an assignment specific id number to a user'; CREATE TABLE mdl_assign_user_flags (
    id BIGINT(10) NOT NULL auto_increment,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    assignment BIGINT(10) NOT NULL DEFAULT 0,
    locked BIGINT(10) NOT NULL DEFAULT 0,
    mailed SMALLINT(4) NOT NULL DEFAULT 0,
    extensionduedate BIGINT(10) NOT NULL DEFAULT 0,
    workflowstate VARCHAR(20) COLLATE utf8mb4_unicode_ci,
    allocatedmarker BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_assiuserflag_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id),
CONSTRAINT mdl_assiuserflag_ass2_fk FOREIGN KEY (assignment) REFERENCES mdl_assign (id)
, KEY mdl_assiuserflag_mai2_ix (mailed)
, KEY mdl_assiuserflag_use4_ix (userid)
, KEY mdl_assiuserflag_ass4_ix (assignment)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='List of flags that can be set for a single user in a single '; CREATE TABLE mdl_assign_overrides (
    id BIGINT(10) NOT NULL auto_increment,
    assignid BIGINT(10) NOT NULL DEFAULT 0,
    groupid BIGINT(10),
    userid BIGINT(10),
    sortorder BIGINT(10),
    allowsubmissionsfromdate BIGINT(10),
    duedate BIGINT(10),
    cutoffdate BIGINT(10),
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_assiover_ass2_fk FOREIGN KEY (assignid) REFERENCES mdl_assign (id),
CONSTRAINT mdl_assiover_gro2_fk FOREIGN KEY (groupid) REFERENCES mdl_groups (id),
CONSTRAINT mdl_assiover_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id)
, KEY mdl_assiover_ass4_ix (assignid)
, KEY mdl_assiover_gro4_ix (groupid)
, KEY mdl_assiover_use4_ix (userid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='The overrides to assign settings.'; CREATE TABLE mdl_assignment (
    id BIGINT(10) NOT NULL auto_increment,
    course BIGINT(10) NOT NULL DEFAULT 0,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    intro LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    introformat SMALLINT(4) NOT NULL DEFAULT 0,
    assignmenttype VARCHAR(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    resubmit TINYINT(2) NOT NULL DEFAULT 0,
    preventlate TINYINT(2) NOT NULL DEFAULT 0,
    emailteachers TINYINT(2) NOT NULL DEFAULT 0,
    var1 BIGINT(10) DEFAULT 0,
    var2 BIGINT(10) DEFAULT 0,
    var3 BIGINT(10) DEFAULT 0,
    var4 BIGINT(10) DEFAULT 0,
    var5 BIGINT(10) DEFAULT 0,
    maxbytes BIGINT(10) NOT NULL DEFAULT 100000,
    timedue BIGINT(10) NOT NULL DEFAULT 0,
    timeavailable BIGINT(10) NOT NULL DEFAULT 0,
    grade BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_assi_cou3_ix (course)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Defines assignments'; CREATE TABLE mdl_assignment_submissions (
    id BIGINT(10) NOT NULL auto_increment,
    assignment BIGINT(10) NOT NULL DEFAULT 0,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    timecreated BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
    numfiles BIGINT(10) NOT NULL DEFAULT 0,
    data1 LONGTEXT COLLATE utf8mb4_unicode_ci,
    data2 LONGTEXT COLLATE utf8mb4_unicode_ci,
    grade BIGINT(11) NOT NULL DEFAULT 0,
    submissioncomment LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    format SMALLINT(4) NOT NULL DEFAULT 0,
    teacher BIGINT(10) NOT NULL DEFAULT 0,
    timemarked BIGINT(10) NOT NULL DEFAULT 0,
    mailed TINYINT(1) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_assisubm_ass6_fk FOREIGN KEY (assignment) REFERENCES mdl_assignment (id)
, KEY mdl_assisubm_use3_ix (userid)
, KEY mdl_assisubm_mai2_ix (mailed)
, KEY mdl_assisubm_tim2_ix (timemarked)
, KEY mdl_assisubm_ass8_ix (assignment)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Info about submitted assignments'; CREATE TABLE mdl_assignment_upgrade (
    id BIGINT(10) NOT NULL auto_increment,
    oldcmid BIGINT(10) NOT NULL DEFAULT 0,
    oldinstance BIGINT(10) NOT NULL DEFAULT 0,
    newcmid BIGINT(10) NOT NULL DEFAULT 0,
    newinstance BIGINT(10) NOT NULL DEFAULT 0,
    timecreated BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_assiupgr_old3_ix (oldcmid)
, KEY mdl_assiupgr_old4_ix (oldinstance)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Info about upgraded assignments'; CREATE TABLE mdl_book (
    id BIGINT(10) NOT NULL auto_increment,
    course BIGINT(10) NOT NULL DEFAULT 0,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    intro LONGTEXT COLLATE utf8mb4_unicode_ci,
    introformat SMALLINT(4) NOT NULL DEFAULT 0,
    numbering SMALLINT(4) NOT NULL DEFAULT 0,
    navstyle SMALLINT(4) NOT NULL DEFAULT 1,
    customtitles TINYINT(2) NOT NULL DEFAULT 0,
    revision BIGINT(10) NOT NULL DEFAULT 0,
    timecreated BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Defines book'; CREATE TABLE mdl_book_chapters (
    id BIGINT(10) NOT NULL auto_increment,
    bookid BIGINT(10) NOT NULL DEFAULT 0,
    pagenum BIGINT(10) NOT NULL DEFAULT 0,
    subchapter BIGINT(10) NOT NULL DEFAULT 0,
    title VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    content LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    contentformat SMALLINT(4) NOT NULL DEFAULT 0,
    hidden TINYINT(2) NOT NULL DEFAULT 0,
    timecreated BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
    importsrc VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
CONSTRAINT  PRIMARY KEY (id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Defines book_chapters'; CREATE TABLE mdl_capquiz (
    id BIGINT(10) NOT NULL auto_increment,
    course BIGINT(10) NOT NULL DEFAULT 0,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    intro LONGTEXT COLLATE utf8mb4_unicode_ci,
    introformat SMALLINT(4) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
    timecreated BIGINT(10) NOT NULL DEFAULT 0,
    published TINYINT(2) NOT NULL,
    default_user_rating SMALLINT(3) NOT NULL DEFAULT 1200,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_capq_cou2_fk FOREIGN KEY (course) REFERENCES mdl_course (id)
, KEY mdl_capq_cou4_ix (course)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Table from which sessions are created.'; CREATE TABLE mdl_capquiz_question_list (
    id BIGINT(10) NOT NULL auto_increment,
    capquiz_id BIGINT(11),
    question_usage_id BIGINT(10),
    title VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    author BIGINT(11) NOT NULL,
    description VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    level_1_rating BIGINT(10) NOT NULL DEFAULT 1300,
    level_2_rating BIGINT(10) NOT NULL DEFAULT 1450,
    level_3_rating BIGINT(10) NOT NULL DEFAULT 1600,
    level_4_rating BIGINT(10) NOT NULL DEFAULT 1800,
    level_5_rating BIGINT(10) NOT NULL DEFAULT 2000,
    is_template TINYINT(2) NOT NULL DEFAULT 0,
    time_created BIGINT(10) NOT NULL DEFAULT 0,
    time_modified BIGINT(10) NOT NULL DEFAULT 0,
    default_question_rating SMALLINT(3) NOT NULL DEFAULT 600,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_capqqueslist_cap_fk FOREIGN KEY (capquiz_id) REFERENCES mdl_capquiz (id),
CONSTRAINT mdl_capqqueslist_que_fk FOREIGN KEY (question_usage_id) REFERENCES mdl_question_usages (id),
CONSTRAINT mdl_capqqueslist_aut2_fk FOREIGN KEY (author) REFERENCES mdl_user (id)
, UNIQUE KEY mdl_capqqueslist_cap2_uix (capquiz_id)
, UNIQUE KEY mdl_capqqueslist_que2_uix (question_usage_id)
, KEY mdl_capqqueslist_aut4_ix (author)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='An ordered list of questions used by a CapQuiz assignment.'; CREATE TABLE mdl_capquiz_question (
    id BIGINT(10) NOT NULL auto_increment,
    question_id BIGINT(11) NOT NULL,
    question_list_id BIGINT(11) NOT NULL,
    rating DOUBLE(11, 0) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_capqques_que3_fk FOREIGN KEY (question_id) REFERENCES mdl_question (id),
CONSTRAINT mdl_capqques_que4_fk FOREIGN KEY (question_list_id) REFERENCES mdl_capquiz_question_list (id)
, KEY mdl_capqques_que6_ix (question_id)
, KEY mdl_capqques_que8_ix (question_list_id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Table holding a references to a question and the question li'; CREATE TABLE mdl_capquiz_user (
    id BIGINT(10) NOT NULL auto_increment,
    user_id BIGINT(11) NOT NULL,
    capquiz_id BIGINT(11) NOT NULL,
    rating DOUBLE(11, 0) NOT NULL DEFAULT 0,
    highest_level BIGINT(11) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_capquser_use2_fk FOREIGN KEY (user_id) REFERENCES mdl_user (id),
CONSTRAINT mdl_capquser_cap2_fk FOREIGN KEY (capquiz_id) REFERENCES mdl_capquiz (id)
, KEY mdl_capquser_use4_ix (user_id)
, KEY mdl_capquser_cap4_ix (capquiz_id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='User table'; CREATE TABLE mdl_capquiz_attempt (
    id BIGINT(10) NOT NULL auto_increment,
    slot BIGINT(11) NOT NULL,
    user_id BIGINT(11) NOT NULL,
    question_id BIGINT(11) NOT NULL,
    reviewed TINYINT(2) NOT NULL DEFAULT 0,
    answered TINYINT(2) NOT NULL DEFAULT 0,
    time_answered BIGINT(10) NOT NULL DEFAULT 0,
    time_reviewed BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_capqatte_use2_fk FOREIGN KEY (user_id) REFERENCES mdl_user (id),
CONSTRAINT mdl_capqatte_que2_fk FOREIGN KEY (question_id) REFERENCES mdl_capquiz_question (id)
, KEY mdl_capqatte_use4_ix (user_id)
, KEY mdl_capqatte_que4_ix (question_id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Attempt table'; CREATE TABLE mdl_capquiz_question_selection (
    id BIGINT(10) NOT NULL auto_increment,
    capquiz_id BIGINT(11) NOT NULL,
    strategy LONGTEXT COLLATE utf8mb4_unicode_ci,
    configuration LONGTEXT COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_capqquessele_cap2_fk FOREIGN KEY (capquiz_id) REFERENCES mdl_capquiz (id)
, KEY mdl_capqquessele_cap4_ix (capquiz_id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Question selection table.'; CREATE TABLE mdl_capquiz_rating_system (
    id BIGINT(10) NOT NULL auto_increment,
    capquiz_id BIGINT(11) NOT NULL,
    rating_system LONGTEXT COLLATE utf8mb4_unicode_ci,
    configuration LONGTEXT COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_capqratisyst_cap2_fk FOREIGN KEY (capquiz_id) REFERENCES mdl_capquiz (id)
, KEY mdl_capqratisyst_cap4_ix (capquiz_id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Rating system table'; CREATE TABLE mdl_chat (
    id BIGINT(10) NOT NULL auto_increment,
    course BIGINT(10) NOT NULL DEFAULT 0,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    intro LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    introformat SMALLINT(4) NOT NULL DEFAULT 0,
    keepdays BIGINT(11) NOT NULL DEFAULT 0,
    studentlogs SMALLINT(4) NOT NULL DEFAULT 0,
    chattime BIGINT(10) NOT NULL DEFAULT 0,
    schedule SMALLINT(4) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_chat_cou2_ix (course)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Each of these is a chat room'; CREATE TABLE mdl_chat_messages (
    id BIGINT(10) NOT NULL auto_increment,
    chatid BIGINT(10) NOT NULL DEFAULT 0,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    groupid BIGINT(10) NOT NULL DEFAULT 0,
    issystem TINYINT(1) NOT NULL DEFAULT 0,
    message LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    timestamp BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_chatmess_cha2_fk FOREIGN KEY (chatid) REFERENCES mdl_chat (id)
, KEY mdl_chatmess_use2_ix (userid)
, KEY mdl_chatmess_gro2_ix (groupid)
, KEY mdl_chatmess_timcha2_ix (timestamp, chatid)
, KEY mdl_chatmess_cha4_ix (chatid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stores all the actual chat messages'; CREATE TABLE mdl_chat_messages_current (
    id BIGINT(10) NOT NULL auto_increment,
    chatid BIGINT(10) NOT NULL DEFAULT 0,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    groupid BIGINT(10) NOT NULL DEFAULT 0,
    issystem TINYINT(1) NOT NULL DEFAULT 0,
    message LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    timestamp BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_chatmesscurr_cha2_fk FOREIGN KEY (chatid) REFERENCES mdl_chat (id)
, KEY mdl_chatmesscurr_use2_ix (userid)
, KEY mdl_chatmesscurr_gro2_ix (groupid)
, KEY mdl_chatmesscurr_timcha2_ix (timestamp, chatid)
, KEY mdl_chatmesscurr_cha4_ix (chatid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stores current session'; CREATE TABLE mdl_chat_users (
    id BIGINT(10) NOT NULL auto_increment,
    chatid BIGINT(11) NOT NULL DEFAULT 0,
    userid BIGINT(11) NOT NULL DEFAULT 0,
    groupid BIGINT(11) NOT NULL DEFAULT 0,
    version VARCHAR(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    ip VARCHAR(45) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    firstping BIGINT(10) NOT NULL DEFAULT 0,
    lastping BIGINT(10) NOT NULL DEFAULT 0,
    lastmessageping BIGINT(10) NOT NULL DEFAULT 0,
    sid VARCHAR(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    course BIGINT(10) NOT NULL DEFAULT 0,
    lang VARCHAR(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_chatuser_cha2_fk FOREIGN KEY (chatid) REFERENCES mdl_chat (id)
, KEY mdl_chatuser_use2_ix (userid)
, KEY mdl_chatuser_las2_ix (lastping)
, KEY mdl_chatuser_gro2_ix (groupid)
, KEY mdl_chatuser_cha4_ix (chatid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Keeps track of which users are in which chat rooms'; CREATE TABLE mdl_choice (
    id BIGINT(10) NOT NULL auto_increment,
    course BIGINT(10) NOT NULL DEFAULT 0,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    intro LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    introformat SMALLINT(4) NOT NULL DEFAULT 0,
    publish TINYINT(2) NOT NULL DEFAULT 0,
    showresults TINYINT(2) NOT NULL DEFAULT 0,
    display SMALLINT(4) NOT NULL DEFAULT 0,
    allowupdate TINYINT(2) NOT NULL DEFAULT 0,
    allowmultiple TINYINT(2) NOT NULL DEFAULT 0,
    showunanswered TINYINT(2) NOT NULL DEFAULT 0,
    includeinactive TINYINT(2) NOT NULL DEFAULT 1,
    limitanswers TINYINT(2) NOT NULL DEFAULT 0,
    timeopen BIGINT(10) NOT NULL DEFAULT 0,
    timeclose BIGINT(10) NOT NULL DEFAULT 0,
    showpreview TINYINT(2) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
    completionsubmit TINYINT(1) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_choi_cou2_ix (course)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Available choices are stored here'; CREATE TABLE mdl_choice_options (
    id BIGINT(10) NOT NULL auto_increment,
    choiceid BIGINT(10) NOT NULL DEFAULT 0,
    text LONGTEXT COLLATE utf8mb4_unicode_ci,
    maxanswers BIGINT(10) DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_choiopti_cho2_fk FOREIGN KEY (choiceid) REFERENCES mdl_choice (id)
, KEY mdl_choiopti_cho4_ix (choiceid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='available options to choice'; CREATE TABLE mdl_choice_answers (
    id BIGINT(10) NOT NULL auto_increment,
    choiceid BIGINT(10) NOT NULL DEFAULT 0,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    optionid BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_choiansw_cho2_fk FOREIGN KEY (choiceid) REFERENCES mdl_choice (id),
CONSTRAINT mdl_choiansw_opt2_fk FOREIGN KEY (optionid) REFERENCES mdl_choice_options (id)
, KEY mdl_choiansw_use2_ix (userid)
, KEY mdl_choiansw_cho4_ix (choiceid)
, KEY mdl_choiansw_opt4_ix (optionid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='choices performed by users'; CREATE TABLE mdl_data (
    id BIGINT(10) NOT NULL auto_increment,
    course BIGINT(10) NOT NULL DEFAULT 0,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    intro LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    introformat SMALLINT(4) NOT NULL DEFAULT 0,
    comments SMALLINT(4) NOT NULL DEFAULT 0,
    timeavailablefrom BIGINT(10) NOT NULL DEFAULT 0,
    timeavailableto BIGINT(10) NOT NULL DEFAULT 0,
    timeviewfrom BIGINT(10) NOT NULL DEFAULT 0,
    timeviewto BIGINT(10) NOT NULL DEFAULT 0,
    requiredentries INT(8) NOT NULL DEFAULT 0,
    requiredentriestoview INT(8) NOT NULL DEFAULT 0,
    maxentries INT(8) NOT NULL DEFAULT 0,
    rssarticles SMALLINT(4) NOT NULL DEFAULT 0,
    singletemplate LONGTEXT COLLATE utf8mb4_unicode_ci,
    listtemplate LONGTEXT COLLATE utf8mb4_unicode_ci,
    listtemplateheader LONGTEXT COLLATE utf8mb4_unicode_ci,
    listtemplatefooter LONGTEXT COLLATE utf8mb4_unicode_ci,
    addtemplate LONGTEXT COLLATE utf8mb4_unicode_ci,
    rsstemplate LONGTEXT COLLATE utf8mb4_unicode_ci,
    rsstitletemplate LONGTEXT COLLATE utf8mb4_unicode_ci,
    csstemplate LONGTEXT COLLATE utf8mb4_unicode_ci,
    jstemplate LONGTEXT COLLATE utf8mb4_unicode_ci,
    asearchtemplate LONGTEXT COLLATE utf8mb4_unicode_ci,
    approval SMALLINT(4) NOT NULL DEFAULT 0,
    manageapproved SMALLINT(4) NOT NULL DEFAULT 1,
    scale BIGINT(10) NOT NULL DEFAULT 0,
    assessed BIGINT(10) NOT NULL DEFAULT 0,
    assesstimestart BIGINT(10) NOT NULL DEFAULT 0,
    assesstimefinish BIGINT(10) NOT NULL DEFAULT 0,
    defaultsort BIGINT(10) NOT NULL DEFAULT 0,
    defaultsortdir SMALLINT(4) NOT NULL DEFAULT 0,
    editany SMALLINT(4) NOT NULL DEFAULT 0,
    notification BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
    config LONGTEXT COLLATE utf8mb4_unicode_ci,
    completionentries BIGINT(10) DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_data_cou2_ix (course)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='all database activities'; CREATE TABLE mdl_data_fields (
    id BIGINT(10) NOT NULL auto_increment,
    dataid BIGINT(10) NOT NULL DEFAULT 0,
    type VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    description LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    required TINYINT(1) NOT NULL DEFAULT 0,
    param1 LONGTEXT COLLATE utf8mb4_unicode_ci,
    param2 LONGTEXT COLLATE utf8mb4_unicode_ci,
    param3 LONGTEXT COLLATE utf8mb4_unicode_ci,
    param4 LONGTEXT COLLATE utf8mb4_unicode_ci,
    param5 LONGTEXT COLLATE utf8mb4_unicode_ci,
    param6 LONGTEXT COLLATE utf8mb4_unicode_ci,
    param7 LONGTEXT COLLATE utf8mb4_unicode_ci,
    param8 LONGTEXT COLLATE utf8mb4_unicode_ci,
    param9 LONGTEXT COLLATE utf8mb4_unicode_ci,
    param10 LONGTEXT COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_datafiel_dat2_fk FOREIGN KEY (dataid) REFERENCES mdl_data (id)
, KEY mdl_datafiel_typdat2_ix (type, dataid)
, KEY mdl_datafiel_dat4_ix (dataid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='every field available'; CREATE TABLE mdl_data_records (
    id BIGINT(10) NOT NULL auto_increment,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    groupid BIGINT(10) NOT NULL DEFAULT 0,
    dataid BIGINT(10) NOT NULL DEFAULT 0,
    timecreated BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
    approved SMALLINT(4) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_datareco_dat2_fk FOREIGN KEY (dataid) REFERENCES mdl_data (id)
, KEY mdl_datareco_dat4_ix (dataid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='every record introduced'; CREATE TABLE mdl_data_content (
    id BIGINT(10) NOT NULL auto_increment,
    fieldid BIGINT(10) NOT NULL DEFAULT 0,
    recordid BIGINT(10) NOT NULL DEFAULT 0,
    content LONGTEXT COLLATE utf8mb4_unicode_ci,
    content1 LONGTEXT COLLATE utf8mb4_unicode_ci,
    content2 LONGTEXT COLLATE utf8mb4_unicode_ci,
    content3 LONGTEXT COLLATE utf8mb4_unicode_ci,
    content4 LONGTEXT COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_datacont_rec2_fk FOREIGN KEY (recordid) REFERENCES mdl_data_records (id),
CONSTRAINT mdl_datacont_fie2_fk FOREIGN KEY (fieldid) REFERENCES mdl_data_fields (id)
, KEY mdl_datacont_rec4_ix (recordid)
, KEY mdl_datacont_fie4_ix (fieldid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='the content introduced in each record/fields'; CREATE TABLE mdl_feedback (
    id BIGINT(10) NOT NULL auto_increment,
    course BIGINT(10) NOT NULL DEFAULT 0,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    intro LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    introformat SMALLINT(4) NOT NULL DEFAULT 0,
    anonymous TINYINT(1) NOT NULL DEFAULT 1,
    email_notification TINYINT(1) NOT NULL DEFAULT 1,
    multiple_submit TINYINT(1) NOT NULL DEFAULT 1,
    autonumbering TINYINT(1) NOT NULL DEFAULT 1,
    site_after_submit VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    page_after_submit LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    page_after_submitformat TINYINT(2) NOT NULL DEFAULT 0,
    publish_stats TINYINT(1) NOT NULL DEFAULT 0,
    timeopen BIGINT(10) NOT NULL DEFAULT 0,
    timeclose BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
    completionsubmit TINYINT(1) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_feed_cou2_ix (course)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='all feedbacks'; CREATE TABLE mdl_feedback_template (
    id BIGINT(10) NOT NULL auto_increment,
    course BIGINT(10) NOT NULL DEFAULT 0,
    ispublic TINYINT(1) NOT NULL DEFAULT 0,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_feedtemp_cou2_ix (course)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='templates of feedbackstructures'; CREATE TABLE mdl_feedback_item (
    id BIGINT(10) NOT NULL auto_increment,
    feedback BIGINT(10) NOT NULL DEFAULT 0,
    template BIGINT(10) NOT NULL DEFAULT 0,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    label VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    presentation LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    typ VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    hasvalue TINYINT(1) NOT NULL DEFAULT 0,
    position SMALLINT(3) NOT NULL DEFAULT 0,
    required TINYINT(1) NOT NULL DEFAULT 0,
    dependitem BIGINT(10) NOT NULL DEFAULT 0,
    dependvalue VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    options VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_feeditem_fee2_fk FOREIGN KEY (feedback) REFERENCES mdl_feedback (id),
CONSTRAINT mdl_feeditem_tem2_fk FOREIGN KEY (template) REFERENCES mdl_feedback_template (id)
, KEY mdl_feeditem_fee4_ix (feedback)
, KEY mdl_feeditem_tem4_ix (template)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='feedback_items'; CREATE TABLE mdl_feedback_completed (
    id BIGINT(10) NOT NULL auto_increment,
    feedback BIGINT(10) NOT NULL DEFAULT 0,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
    random_response BIGINT(10) NOT NULL DEFAULT 0,
    anonymous_response TINYINT(1) NOT NULL DEFAULT 0,
    courseid BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_feedcomp_fee3_fk FOREIGN KEY (feedback) REFERENCES mdl_feedback (id)
, KEY mdl_feedcomp_use2_ix (userid)
, KEY mdl_feedcomp_fee5_ix (feedback)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='filled out feedback'; CREATE TABLE mdl_feedback_completedtmp (
    id BIGINT(10) NOT NULL auto_increment,
    feedback BIGINT(10) NOT NULL DEFAULT 0,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    guestid VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
    random_response BIGINT(10) NOT NULL DEFAULT 0,
    anonymous_response TINYINT(1) NOT NULL DEFAULT 0,
    courseid BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_feedcomp_fee6_fk FOREIGN KEY (feedback) REFERENCES mdl_feedback (id)
, KEY mdl_feedcomp_use3_ix (userid)
, KEY mdl_feedcomp_fee8_ix (feedback)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='filled out feedback'; CREATE TABLE mdl_feedback_value (
    id BIGINT(10) NOT NULL auto_increment,
    course_id BIGINT(10) NOT NULL DEFAULT 0,
    item BIGINT(10) NOT NULL DEFAULT 0,
    completed BIGINT(10) NOT NULL DEFAULT 0,
    tmp_completed BIGINT(10) NOT NULL DEFAULT 0,
    value LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_feedvalu_ite3_fk FOREIGN KEY (item) REFERENCES mdl_feedback_item (id)
, KEY mdl_feedvalu_cou2_ix (course_id)
, UNIQUE KEY mdl_feedvalu_comitecou2_uix (completed, item, course_id)
, KEY mdl_feedvalu_ite5_ix (item)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='values of the completeds'; CREATE TABLE mdl_feedback_valuetmp (
    id BIGINT(10) NOT NULL auto_increment,
    course_id BIGINT(10) NOT NULL DEFAULT 0,
    item BIGINT(10) NOT NULL DEFAULT 0,
    completed BIGINT(10) NOT NULL DEFAULT 0,
    tmp_completed BIGINT(10) NOT NULL DEFAULT 0,
    value LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_feedvalu_ite6_fk FOREIGN KEY (item) REFERENCES mdl_feedback_item (id)
, KEY mdl_feedvalu_cou3_ix (course_id)
, UNIQUE KEY mdl_feedvalu_comitecou3_uix (completed, item, course_id)
, KEY mdl_feedvalu_ite8_ix (item)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='values of the completedstmp'; CREATE TABLE mdl_feedback_sitecourse_map (
    id BIGINT(10) NOT NULL auto_increment,
    feedbackid BIGINT(10) NOT NULL DEFAULT 0,
    courseid BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_feedsitemap_fee2_fk FOREIGN KEY (feedbackid) REFERENCES mdl_feedback (id)
, KEY mdl_feedsitemap_cou2_ix (courseid)
, KEY mdl_feedsitemap_fee4_ix (feedbackid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='feedback sitecourse map'; CREATE TABLE mdl_folder (
    id BIGINT(10) NOT NULL auto_increment,
    course BIGINT(10) NOT NULL DEFAULT 0,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    intro LONGTEXT COLLATE utf8mb4_unicode_ci,
    introformat SMALLINT(4) NOT NULL DEFAULT 0,
    revision BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
    display SMALLINT(4) NOT NULL DEFAULT 0,
    showexpanded TINYINT(1) NOT NULL DEFAULT 1,
    showdownloadfolder TINYINT(1) NOT NULL DEFAULT 1,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_fold_cou2_ix (course)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='each record is one folder resource'; CREATE TABLE mdl_forum (
    id BIGINT(10) NOT NULL auto_increment,
    course BIGINT(10) NOT NULL DEFAULT 0,
    type VARCHAR(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'general',
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    intro LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    introformat SMALLINT(4) NOT NULL DEFAULT 0,
    duedate BIGINT(10) NOT NULL DEFAULT 0,
    cutoffdate BIGINT(10) NOT NULL DEFAULT 0,
    assessed BIGINT(10) NOT NULL DEFAULT 0,
    assesstimestart BIGINT(10) NOT NULL DEFAULT 0,
    assesstimefinish BIGINT(10) NOT NULL DEFAULT 0,
    scale BIGINT(10) NOT NULL DEFAULT 0,
    maxbytes BIGINT(10) NOT NULL DEFAULT 0,
    maxattachments BIGINT(10) NOT NULL DEFAULT 1,
    forcesubscribe TINYINT(1) NOT NULL DEFAULT 0,
    trackingtype TINYINT(2) NOT NULL DEFAULT 1,
    rsstype TINYINT(2) NOT NULL DEFAULT 0,
    rssarticles TINYINT(2) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
    warnafter BIGINT(10) NOT NULL DEFAULT 0,
    blockafter BIGINT(10) NOT NULL DEFAULT 0,
    blockperiod BIGINT(10) NOT NULL DEFAULT 0,
    completiondiscussions INT(9) NOT NULL DEFAULT 0,
    completionreplies INT(9) NOT NULL DEFAULT 0,
    completionposts INT(9) NOT NULL DEFAULT 0,
    displaywordcount TINYINT(1) NOT NULL DEFAULT 0,
    lockdiscussionafter BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_foru_cou2_ix (course)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Forums contain and structure discussion'; CREATE TABLE mdl_forum_discussions (
    id BIGINT(10) NOT NULL auto_increment,
    course BIGINT(10) NOT NULL DEFAULT 0,
    forum BIGINT(10) NOT NULL DEFAULT 0,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    firstpost BIGINT(10) NOT NULL DEFAULT 0,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    groupid BIGINT(10) NOT NULL DEFAULT -1,
    assessed TINYINT(1) NOT NULL DEFAULT 1,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
    usermodified BIGINT(10) NOT NULL DEFAULT 0,
    timestart BIGINT(10) NOT NULL DEFAULT 0,
    timeend BIGINT(10) NOT NULL DEFAULT 0,
    pinned TINYINT(1) NOT NULL DEFAULT 0,
    timelocked BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_forudisc_for2_fk FOREIGN KEY (forum) REFERENCES mdl_forum (id)
, KEY mdl_forudisc_use2_ix (userid)
, KEY mdl_forudisc_cou2_ix (course)
, KEY mdl_forudisc_for4_ix (forum)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Forums are composed of discussions'; CREATE TABLE mdl_forum_posts (
    id BIGINT(10) NOT NULL auto_increment,
    discussion BIGINT(10) NOT NULL DEFAULT 0,
    parent BIGINT(10) NOT NULL DEFAULT 0,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    created BIGINT(10) NOT NULL DEFAULT 0,
    modified BIGINT(10) NOT NULL DEFAULT 0,
    mailed TINYINT(2) NOT NULL DEFAULT 0,
    subject VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    message LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    messageformat TINYINT(2) NOT NULL DEFAULT 0,
    messagetrust TINYINT(2) NOT NULL DEFAULT 0,
    attachment VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    totalscore SMALLINT(4) NOT NULL DEFAULT 0,
    mailnow BIGINT(10) NOT NULL DEFAULT 0,
    deleted TINYINT(1) NOT NULL DEFAULT 0,
    privatereplyto BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_forupost_dis2_fk FOREIGN KEY (discussion) REFERENCES mdl_forum_discussions (id),
CONSTRAINT mdl_forupost_par2_fk FOREIGN KEY (parent) REFERENCES mdl_forum_posts (id)
, KEY mdl_forupost_use2_ix (userid)
, KEY mdl_forupost_cre2_ix (created)
, KEY mdl_forupost_mai2_ix (mailed)
, KEY mdl_forupost_dis4_ix (discussion)
, KEY mdl_forupost_par4_ix (parent)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='All posts are stored in this table'; CREATE TABLE mdl_forum_queue (
    id BIGINT(10) NOT NULL auto_increment,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    discussionid BIGINT(10) NOT NULL DEFAULT 0,
    postid BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_foruqueu_dis2_fk FOREIGN KEY (discussionid) REFERENCES mdl_forum_discussions (id),
CONSTRAINT mdl_foruqueu_pos2_fk FOREIGN KEY (postid) REFERENCES mdl_forum_posts (id)
, KEY mdl_foruqueu_use2_ix (userid)
, KEY mdl_foruqueu_dis4_ix (discussionid)
, KEY mdl_foruqueu_pos4_ix (postid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='For keeping track of posts that will be mailed in digest for'; CREATE TABLE mdl_forum_subscriptions (
    id BIGINT(10) NOT NULL auto_increment,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    forum BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_forusubs_for2_fk FOREIGN KEY (forum) REFERENCES mdl_forum (id)
, KEY mdl_forusubs_use2_ix (userid)
, KEY mdl_forusubs_for4_ix (forum)
, UNIQUE KEY mdl_forusubs_usefor2_uix (userid, forum)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Keeps track of who is subscribed to what forum'; CREATE TABLE mdl_forum_digests (
    id BIGINT(10) NOT NULL auto_increment,
    userid BIGINT(10) NOT NULL,
    forum BIGINT(10) NOT NULL,
    maildigest TINYINT(1) NOT NULL DEFAULT -1,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_forudige_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id),
CONSTRAINT mdl_forudige_for2_fk FOREIGN KEY (forum) REFERENCES mdl_forum (id)
, KEY mdl_forudige_use4_ix (userid)
, KEY mdl_forudige_for4_ix (forum)
, UNIQUE KEY mdl_forudige_forusemai2_uix (forum, userid, maildigest)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Keeps track of user mail delivery preferences for each forum'; CREATE TABLE mdl_forum_read (
    id BIGINT(10) NOT NULL auto_increment,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    forumid BIGINT(10) NOT NULL DEFAULT 0,
    discussionid BIGINT(10) NOT NULL DEFAULT 0,
    postid BIGINT(10) NOT NULL DEFAULT 0,
    firstread BIGINT(10) NOT NULL DEFAULT 0,
    lastread BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_foruread_usefor2_ix (userid, forumid)
, KEY mdl_foruread_usedis2_ix (userid, discussionid)
, KEY mdl_foruread_posuse2_ix (postid, userid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Tracks each users read posts'; CREATE TABLE mdl_forum_track_prefs (
    id BIGINT(10) NOT NULL auto_increment,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    forumid BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_forutracpref_usefor2_ix (userid, forumid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Tracks each users untracked forums'; CREATE TABLE mdl_forum_discussion_subs (
    id BIGINT(10) NOT NULL auto_increment,
    forum BIGINT(10) NOT NULL,
    userid BIGINT(10) NOT NULL,
    discussion BIGINT(10) NOT NULL,
    preference BIGINT(10) NOT NULL DEFAULT 1,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_forudiscsubs_for2_fk FOREIGN KEY (forum) REFERENCES mdl_forum (id),
CONSTRAINT mdl_forudiscsubs_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id),
CONSTRAINT mdl_forudiscsubs_dis2_fk FOREIGN KEY (discussion) REFERENCES mdl_forum_discussions (id)
, KEY mdl_forudiscsubs_for4_ix (forum)
, KEY mdl_forudiscsubs_use4_ix (userid)
, KEY mdl_forudiscsubs_dis4_ix (discussion)
, UNIQUE KEY mdl_forudiscsubs_usedis2_uix (userid, discussion)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Users may choose to subscribe and unsubscribe from specific '; CREATE TABLE mdl_glossary (
    id BIGINT(10) NOT NULL auto_increment,
    course BIGINT(10) NOT NULL DEFAULT 0,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    intro LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    introformat SMALLINT(4) NOT NULL DEFAULT 0,
    allowduplicatedentries TINYINT(2) NOT NULL DEFAULT 0,
    displayformat VARCHAR(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'dictionary',
    mainglossary TINYINT(2) NOT NULL DEFAULT 0,
    showspecial TINYINT(2) NOT NULL DEFAULT 1,
    showalphabet TINYINT(2) NOT NULL DEFAULT 1,
    showall TINYINT(2) NOT NULL DEFAULT 1,
    allowcomments TINYINT(2) NOT NULL DEFAULT 0,
    allowprintview TINYINT(2) NOT NULL DEFAULT 1,
    usedynalink TINYINT(2) NOT NULL DEFAULT 1,
    defaultapproval TINYINT(2) NOT NULL DEFAULT 1,
    approvaldisplayformat VARCHAR(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'default',
    globalglossary TINYINT(2) NOT NULL DEFAULT 0,
    entbypage SMALLINT(3) NOT NULL DEFAULT 10,
    editalways TINYINT(2) NOT NULL DEFAULT 0,
    rsstype TINYINT(2) NOT NULL DEFAULT 0,
    rssarticles TINYINT(2) NOT NULL DEFAULT 0,
    assessed BIGINT(10) NOT NULL DEFAULT 0,
    assesstimestart BIGINT(10) NOT NULL DEFAULT 0,
    assesstimefinish BIGINT(10) NOT NULL DEFAULT 0,
    scale BIGINT(10) NOT NULL DEFAULT 0,
    timecreated BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
    completionentries INT(9) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_glos_cou2_ix (course)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='all glossaries'; CREATE TABLE mdl_glossary_entries (
    id BIGINT(10) NOT NULL auto_increment,
    glossaryid BIGINT(10) NOT NULL DEFAULT 0,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    concept VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    definition LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    definitionformat TINYINT(2) NOT NULL DEFAULT 0,
    definitiontrust TINYINT(2) NOT NULL DEFAULT 0,
    attachment VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    timecreated BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
    teacherentry TINYINT(2) NOT NULL DEFAULT 0,
    sourceglossaryid BIGINT(10) NOT NULL DEFAULT 0,
    usedynalink TINYINT(2) NOT NULL DEFAULT 1,
    casesensitive TINYINT(2) NOT NULL DEFAULT 0,
    fullmatch TINYINT(2) NOT NULL DEFAULT 1,
    approved TINYINT(2) NOT NULL DEFAULT 1,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_glosentr_glo2_fk FOREIGN KEY (glossaryid) REFERENCES mdl_glossary (id)
, KEY mdl_glosentr_use2_ix (userid)
, KEY mdl_glosentr_con2_ix (concept)
, KEY mdl_glosentr_glo4_ix (glossaryid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='all glossary entries'; CREATE TABLE mdl_glossary_alias (
    id BIGINT(10) NOT NULL auto_increment,
    entryid BIGINT(10) NOT NULL DEFAULT 0,
    alias VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_glosalia_ent2_fk FOREIGN KEY (entryid) REFERENCES mdl_glossary_entries (id)
, KEY mdl_glosalia_ent4_ix (entryid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='entries alias'; CREATE TABLE mdl_glossary_categories (
    id BIGINT(10) NOT NULL auto_increment,
    glossaryid BIGINT(10) NOT NULL DEFAULT 0,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    usedynalink TINYINT(2) NOT NULL DEFAULT 1,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_gloscate_glo2_fk FOREIGN KEY (glossaryid) REFERENCES mdl_glossary (id)
, KEY mdl_gloscate_glo4_ix (glossaryid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='all categories for glossary entries'; CREATE TABLE mdl_glossary_entries_categories (
    id BIGINT(10) NOT NULL auto_increment,
    categoryid BIGINT(10) NOT NULL DEFAULT 0,
    entryid BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_glosentrcate_cat2_fk FOREIGN KEY (categoryid) REFERENCES mdl_glossary_categories (id),
CONSTRAINT mdl_glosentrcate_ent2_fk FOREIGN KEY (entryid) REFERENCES mdl_glossary_entries (id)
, KEY mdl_glosentrcate_cat4_ix (categoryid)
, KEY mdl_glosentrcate_ent4_ix (entryid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='categories of each glossary entry'; CREATE TABLE mdl_glossary_formats (
    id BIGINT(10) NOT NULL auto_increment,
    name VARCHAR(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    popupformatname VARCHAR(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    visible TINYINT(2) NOT NULL DEFAULT 1,
    showgroup TINYINT(2) NOT NULL DEFAULT 1,
    showtabs VARCHAR(100) COLLATE utf8mb4_unicode_ci,
    defaultmode VARCHAR(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    defaulthook VARCHAR(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    sortkey VARCHAR(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    sortorder VARCHAR(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
CONSTRAINT  PRIMARY KEY (id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Setting of the display formats'; CREATE TABLE mdl_imscp (
    id BIGINT(10) NOT NULL auto_increment,
    course BIGINT(10) NOT NULL DEFAULT 0,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    intro LONGTEXT COLLATE utf8mb4_unicode_ci,
    introformat SMALLINT(4) NOT NULL DEFAULT 0,
    revision BIGINT(10) NOT NULL DEFAULT 0,
    keepold BIGINT(10) NOT NULL DEFAULT -1,
    structure LONGTEXT COLLATE utf8mb4_unicode_ci,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_imsc_cou2_ix (course)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='each record is one imscp resource'; CREATE TABLE mdl_label (
    id BIGINT(10) NOT NULL auto_increment,
    course BIGINT(10) NOT NULL DEFAULT 0,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    intro LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    introformat SMALLINT(4) DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_labe_cou2_ix (course)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Defines labels'; CREATE TABLE mdl_lesson (
    id BIGINT(10) NOT NULL auto_increment,
    course BIGINT(10) NOT NULL DEFAULT 0,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    intro LONGTEXT COLLATE utf8mb4_unicode_ci,
    introformat SMALLINT(4) NOT NULL DEFAULT 0,
    practice SMALLINT(3) NOT NULL DEFAULT 0,
    modattempts SMALLINT(3) NOT NULL DEFAULT 0,
    usepassword SMALLINT(3) NOT NULL DEFAULT 0,
    password VARCHAR(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    dependency BIGINT(10) NOT NULL DEFAULT 0,
    conditions LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    grade BIGINT(10) NOT NULL DEFAULT 0,
    custom SMALLINT(3) NOT NULL DEFAULT 0,
    ongoing SMALLINT(3) NOT NULL DEFAULT 0,
    usemaxgrade SMALLINT(3) NOT NULL DEFAULT 0,
    maxanswers SMALLINT(3) NOT NULL DEFAULT 4,
    maxattempts SMALLINT(3) NOT NULL DEFAULT 5,
    review SMALLINT(3) NOT NULL DEFAULT 0,
    nextpagedefault SMALLINT(3) NOT NULL DEFAULT 0,
    feedback SMALLINT(3) NOT NULL DEFAULT 1,
    minquestions SMALLINT(3) NOT NULL DEFAULT 0,
    maxpages SMALLINT(3) NOT NULL DEFAULT 0,
    timelimit BIGINT(10) NOT NULL DEFAULT 0,
    retake SMALLINT(3) NOT NULL DEFAULT 1,
    activitylink BIGINT(10) NOT NULL DEFAULT 0,
    mediafile VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    mediaheight BIGINT(10) NOT NULL DEFAULT 100,
    mediawidth BIGINT(10) NOT NULL DEFAULT 650,
    mediaclose SMALLINT(3) NOT NULL DEFAULT 0,
    slideshow SMALLINT(3) NOT NULL DEFAULT 0,
    width BIGINT(10) NOT NULL DEFAULT 640,
    height BIGINT(10) NOT NULL DEFAULT 480,
    bgcolor VARCHAR(7) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '#FFFFFF',
    displayleft SMALLINT(3) NOT NULL DEFAULT 0,
    displayleftif SMALLINT(3) NOT NULL DEFAULT 0,
    progressbar SMALLINT(3) NOT NULL DEFAULT 0,
    available BIGINT(10) NOT NULL DEFAULT 0,
    deadline BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
    completionendreached TINYINT(1) DEFAULT 0,
    completiontimespent BIGINT(11) DEFAULT 0,
    allowofflineattempts TINYINT(1) DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_less_cou2_ix (course)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Defines lesson'; CREATE TABLE mdl_lesson_pages (
    id BIGINT(10) NOT NULL auto_increment,
    lessonid BIGINT(10) NOT NULL DEFAULT 0,
    prevpageid BIGINT(10) NOT NULL DEFAULT 0,
    nextpageid BIGINT(10) NOT NULL DEFAULT 0,
    qtype SMALLINT(3) NOT NULL DEFAULT 0,
    qoption SMALLINT(3) NOT NULL DEFAULT 0,
    layout SMALLINT(3) NOT NULL DEFAULT 1,
    display SMALLINT(3) NOT NULL DEFAULT 1,
    timecreated BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
    title VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    contents LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    contentsformat TINYINT(2) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_lesspage_les2_fk FOREIGN KEY (lessonid) REFERENCES mdl_lesson (id)
, KEY mdl_lesspage_les4_ix (lessonid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Defines lesson_pages'; CREATE TABLE mdl_lesson_answers (
    id BIGINT(10) NOT NULL auto_increment,
    lessonid BIGINT(10) NOT NULL DEFAULT 0,
    pageid BIGINT(10) NOT NULL DEFAULT 0,
    jumpto BIGINT(11) NOT NULL DEFAULT 0,
    grade SMALLINT(4) NOT NULL DEFAULT 0,
    score BIGINT(10) NOT NULL DEFAULT 0,
    flags SMALLINT(3) NOT NULL DEFAULT 0,
    timecreated BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
    answer LONGTEXT COLLATE utf8mb4_unicode_ci,
    answerformat TINYINT(2) NOT NULL DEFAULT 0,
    response LONGTEXT COLLATE utf8mb4_unicode_ci,
    responseformat TINYINT(2) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_lessansw_les2_fk FOREIGN KEY (lessonid) REFERENCES mdl_lesson (id),
CONSTRAINT mdl_lessansw_pag2_fk FOREIGN KEY (pageid) REFERENCES mdl_lesson_pages (id)
, KEY mdl_lessansw_les4_ix (lessonid)
, KEY mdl_lessansw_pag4_ix (pageid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Defines lesson_answers'; CREATE TABLE mdl_lesson_attempts (
    id BIGINT(10) NOT NULL auto_increment,
    lessonid BIGINT(10) NOT NULL DEFAULT 0,
    pageid BIGINT(10) NOT NULL DEFAULT 0,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    answerid BIGINT(10) NOT NULL DEFAULT 0,
    retry SMALLINT(3) NOT NULL DEFAULT 0,
    correct BIGINT(10) NOT NULL DEFAULT 0,
    useranswer LONGTEXT COLLATE utf8mb4_unicode_ci,
    timeseen BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_lessatte_les2_fk FOREIGN KEY (lessonid) REFERENCES mdl_lesson (id),
CONSTRAINT mdl_lessatte_pag2_fk FOREIGN KEY (pageid) REFERENCES mdl_lesson_pages (id),
CONSTRAINT mdl_lessatte_ans2_fk FOREIGN KEY (answerid) REFERENCES mdl_lesson_answers (id)
, KEY mdl_lessatte_use2_ix (userid)
, KEY mdl_lessatte_les4_ix (lessonid)
, KEY mdl_lessatte_pag4_ix (pageid)
, KEY mdl_lessatte_ans4_ix (answerid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Defines lesson_attempts'; CREATE TABLE mdl_lesson_grades (
    id BIGINT(10) NOT NULL auto_increment,
    lessonid BIGINT(10) NOT NULL DEFAULT 0,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    grade DOUBLE NOT NULL DEFAULT 0,
    late SMALLINT(3) NOT NULL DEFAULT 0,
    completed BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_lessgrad_les2_fk FOREIGN KEY (lessonid) REFERENCES mdl_lesson (id)
, KEY mdl_lessgrad_use2_ix (userid)
, KEY mdl_lessgrad_les4_ix (lessonid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Defines lesson_grades'; CREATE TABLE mdl_lesson_timer (
    id BIGINT(10) NOT NULL auto_increment,
    lessonid BIGINT(10) NOT NULL DEFAULT 0,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    starttime BIGINT(10) NOT NULL DEFAULT 0,
    lessontime BIGINT(10) NOT NULL DEFAULT 0,
    completed TINYINT(1) DEFAULT 0,
    timemodifiedoffline BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_lesstime_les2_fk FOREIGN KEY (lessonid) REFERENCES mdl_lesson (id)
, KEY mdl_lesstime_use2_ix (userid)
, KEY mdl_lesstime_les4_ix (lessonid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='lesson timer for each lesson'; CREATE TABLE mdl_lesson_branch (
    id BIGINT(10) NOT NULL auto_increment,
    lessonid BIGINT(10) NOT NULL DEFAULT 0,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    pageid BIGINT(10) NOT NULL DEFAULT 0,
    retry BIGINT(10) NOT NULL DEFAULT 0,
    flag SMALLINT(3) NOT NULL DEFAULT 0,
    timeseen BIGINT(10) NOT NULL DEFAULT 0,
    nextpageid BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_lessbran_les2_fk FOREIGN KEY (lessonid) REFERENCES mdl_lesson (id),
CONSTRAINT mdl_lessbran_pag2_fk FOREIGN KEY (pageid) REFERENCES mdl_lesson_pages (id)
, KEY mdl_lessbran_use2_ix (userid)
, KEY mdl_lessbran_les4_ix (lessonid)
, KEY mdl_lessbran_pag4_ix (pageid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='branches for each lesson/user'; CREATE TABLE mdl_lesson_overrides (
    id BIGINT(10) NOT NULL auto_increment,
    lessonid BIGINT(10) NOT NULL DEFAULT 0,
    groupid BIGINT(10),
    userid BIGINT(10),
    available BIGINT(10),
    deadline BIGINT(10),
    timelimit BIGINT(10),
    review SMALLINT(3),
    maxattempts SMALLINT(3),
    retake SMALLINT(3),
    password VARCHAR(32) COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_lessover_les2_fk FOREIGN KEY (lessonid) REFERENCES mdl_lesson (id),
CONSTRAINT mdl_lessover_gro2_fk FOREIGN KEY (groupid) REFERENCES mdl_groups (id),
CONSTRAINT mdl_lessover_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id)
, KEY mdl_lessover_les4_ix (lessonid)
, KEY mdl_lessover_gro4_ix (groupid)
, KEY mdl_lessover_use4_ix (userid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='The overrides to lesson settings.'; CREATE TABLE mdl_lightboxgallery (
    id BIGINT(10) NOT NULL auto_increment,
    course BIGINT(10) NOT NULL DEFAULT 0,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    perpage SMALLINT(3) NOT NULL DEFAULT 0,
    perrow TINYINT(2) NOT NULL DEFAULT 0,
    comments TINYINT(1) NOT NULL DEFAULT 0,
    ispublic TINYINT(1) NOT NULL DEFAULT 0,
    rss TINYINT(1) NOT NULL DEFAULT 0,
    autoresize TINYINT(1) NOT NULL DEFAULT 0,
    resize TINYINT(1) NOT NULL DEFAULT 0,
    extinfo TINYINT(1) NOT NULL DEFAULT 0,
    captionfull TINYINT(1) NOT NULL DEFAULT 0,
    captionpos TINYINT(1) NOT NULL DEFAULT 0,
    intro LONGTEXT COLLATE utf8mb4_unicode_ci,
    introformat SMALLINT(4) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_ligh_cou2_ix (course)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Defines lightboxgallery activities'; CREATE TABLE mdl_lightboxgallery_comments (
    id BIGINT(10) NOT NULL auto_increment,
    gallery BIGINT(10) NOT NULL DEFAULT 0,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    commenttext LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_lighcomm_gal2_ix (gallery)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Contains comments attached to lightboxgallery resources'; CREATE TABLE mdl_lightboxgallery_image_meta (
    id BIGINT(10) NOT NULL auto_increment,
    gallery BIGINT(10) NOT NULL DEFAULT 0,
    image VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    metatype VARCHAR(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'caption',
    description LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_lighimagmeta_gal2_ix (gallery)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Meta data linked to gallery images'; CREATE TABLE mdl_lti (
    id BIGINT(10) NOT NULL auto_increment,
    course BIGINT(10) NOT NULL DEFAULT 0,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    intro LONGTEXT COLLATE utf8mb4_unicode_ci,
    introformat SMALLINT(4) DEFAULT 0,
    timecreated BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
    typeid BIGINT(10),
    toolurl LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    securetoolurl LONGTEXT COLLATE utf8mb4_unicode_ci,
    instructorchoicesendname TINYINT(1),
    instructorchoicesendemailaddr TINYINT(1),
    instructorchoiceallowroster TINYINT(1),
    instructorchoiceallowsetting TINYINT(1),
    instructorcustomparameters VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    instructorchoiceacceptgrades TINYINT(1),
    grade BIGINT(10) NOT NULL DEFAULT 100,
    launchcontainer TINYINT(2) NOT NULL DEFAULT 1,
    resourcekey VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    password VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    debuglaunch TINYINT(1) NOT NULL DEFAULT 0,
    showtitlelaunch TINYINT(1) NOT NULL DEFAULT 0,
    showdescriptionlaunch TINYINT(1) NOT NULL DEFAULT 0,
    servicesalt VARCHAR(40) COLLATE utf8mb4_unicode_ci,
    icon LONGTEXT COLLATE utf8mb4_unicode_ci,
    secureicon LONGTEXT COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_lti_cou2_ix (course)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='This table contains Basic LTI activities instances'; CREATE TABLE mdl_lti_tool_proxies (
    id BIGINT(10) NOT NULL auto_increment,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Tool Provider',
    regurl LONGTEXT COLLATE utf8mb4_unicode_ci,
    state TINYINT(2) NOT NULL DEFAULT 1,
    guid VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    secret VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    vendorcode VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    capabilityoffered LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    serviceoffered LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    toolproxy LONGTEXT COLLATE utf8mb4_unicode_ci,
    createdby BIGINT(10) NOT NULL,
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY mdl_ltitoolprox_gui2_uix (guid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='LTI tool proxy registrations'; CREATE TABLE mdl_lti_types (
    id BIGINT(10) NOT NULL auto_increment,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'basiclti Activity',
    baseurl LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    tooldomain VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    state TINYINT(2) NOT NULL DEFAULT 2,
    course BIGINT(10) NOT NULL,
    coursevisible TINYINT(1) NOT NULL DEFAULT 0,
    ltiversion VARCHAR(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    clientid VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    toolproxyid BIGINT(10),
    enabledcapability LONGTEXT COLLATE utf8mb4_unicode_ci,
    parameter LONGTEXT COLLATE utf8mb4_unicode_ci,
    icon LONGTEXT COLLATE utf8mb4_unicode_ci,
    secureicon LONGTEXT COLLATE utf8mb4_unicode_ci,
    createdby BIGINT(10) NOT NULL,
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
    description LONGTEXT COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_ltitype_cou2_ix (course)
, KEY mdl_ltitype_too2_ix (tooldomain)
, UNIQUE KEY mdl_ltitype_cli2_uix (clientid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Basic LTI pre-configured activities'; CREATE TABLE mdl_lti_types_config (
    id BIGINT(10) NOT NULL auto_increment,
    typeid BIGINT(10) NOT NULL,
    name VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    value LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_ltitypeconf_typ2_ix (typeid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Basic LTI types configuration'; CREATE TABLE mdl_lti_tool_settings (
    id BIGINT(10) NOT NULL auto_increment,
    toolproxyid BIGINT(10) NOT NULL,
    typeid BIGINT(10),
    course BIGINT(10),
    coursemoduleid BIGINT(10),
    settings LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_ltitoolsett_too2_fk FOREIGN KEY (toolproxyid) REFERENCES mdl_lti_tool_proxies (id),
CONSTRAINT mdl_ltitoolsett_typ2_fk FOREIGN KEY (typeid) REFERENCES mdl_lti_types (id),
CONSTRAINT mdl_ltitoolsett_cou3_fk FOREIGN KEY (course) REFERENCES mdl_course (id),
CONSTRAINT mdl_ltitoolsett_cou4_fk FOREIGN KEY (coursemoduleid) REFERENCES mdl_lti (id)
, KEY mdl_ltitoolsett_too4_ix (toolproxyid)
, KEY mdl_ltitoolsett_typ4_ix (typeid)
, KEY mdl_ltitoolsett_cou6_ix (course)
, KEY mdl_ltitoolsett_cou8_ix (coursemoduleid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='LTI tool setting values'; CREATE TABLE mdl_lti_submission (
    id BIGINT(10) NOT NULL auto_increment,
    ltiid BIGINT(10) NOT NULL,
    userid BIGINT(10) NOT NULL,
    datesubmitted BIGINT(10) NOT NULL,
    dateupdated BIGINT(10) NOT NULL,
    gradepercent NUMERIC(10,5) NOT NULL,
    originalgrade NUMERIC(10,5) NOT NULL,
    launchid BIGINT(10) NOT NULL,
    state TINYINT(2) NOT NULL,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_ltisubm_lti2_ix (ltiid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Keeps track of individual submissions for LTI activities.'; CREATE TABLE mdl_lti_access_tokens (
    id BIGINT(10) NOT NULL auto_increment,
    typeid BIGINT(10) NOT NULL,
    scope LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    token VARCHAR(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    validuntil BIGINT(10) NOT NULL,
    timecreated BIGINT(10) NOT NULL,
    lastaccess BIGINT(10),
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_ltiaccetoke_typ2_fk FOREIGN KEY (typeid) REFERENCES mdl_lti_types (id)
, UNIQUE KEY mdl_ltiaccetoke_tok2_uix (token)
, KEY mdl_ltiaccetoke_typ4_ix (typeid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Security tokens for accessing of LTI services'; CREATE TABLE mdl_page (
    id BIGINT(10) NOT NULL auto_increment,
    course BIGINT(10) NOT NULL DEFAULT 0,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    intro LONGTEXT COLLATE utf8mb4_unicode_ci,
    introformat SMALLINT(4) NOT NULL DEFAULT 0,
    content LONGTEXT COLLATE utf8mb4_unicode_ci,
    contentformat SMALLINT(4) NOT NULL DEFAULT 0,
    legacyfiles SMALLINT(4) NOT NULL DEFAULT 0,
    legacyfileslast BIGINT(10),
    display SMALLINT(4) NOT NULL DEFAULT 0,
    displayoptions LONGTEXT COLLATE utf8mb4_unicode_ci,
    revision BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_page_cou2_ix (course)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Each record is one page and its config data'; CREATE TABLE mdl_qpractice (
    id BIGINT(10) NOT NULL auto_increment,
    course BIGINT(10) NOT NULL,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    intro LONGTEXT COLLATE utf8mb4_unicode_ci,
    topcategory BIGINT(10),
    introformat SMALLINT(4) NOT NULL DEFAULT 0,
    behaviour VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_qpra_cou2_ix (course)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Default comment for qpractice, please edit me'; CREATE TABLE mdl_qpractice_session (
    id BIGINT(10) NOT NULL auto_increment,
    qpracticeid BIGINT(10) NOT NULL,
    questionusageid BIGINT(10) NOT NULL,
    userid BIGINT(10) NOT NULL,
    categoryid BIGINT(10) NOT NULL,
    typeofpractice VARCHAR(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    time BIGINT(10),
    goalpercentage BIGINT(10),
    noofquestions BIGINT(10),
    practicedate BIGINT(10) NOT NULL,
    status VARCHAR(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'inprogress',
    totalnoofquestions BIGINT(20) NOT NULL DEFAULT 0,
    totalnoofquestionsright BIGINT(20) NOT NULL DEFAULT 0,
    marksobtained NUMERIC(10,2) NOT NULL DEFAULT 0,
    totalmarks NUMERIC(10,2) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_qprasess_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id),
CONSTRAINT mdl_qprasess_que2_fk FOREIGN KEY (questionusageid) REFERENCES mdl_question_usages (id),
CONSTRAINT mdl_qprasess_qpr2_fk FOREIGN KEY (qpracticeid) REFERENCES mdl_qpractice (id),
CONSTRAINT mdl_qprasess_cat2_fk FOREIGN KEY (categoryid) REFERENCES mdl_question_categories (id)
, KEY mdl_qprasess_use4_ix (userid)
, KEY mdl_qprasess_que4_ix (questionusageid)
, KEY mdl_qprasess_qpr4_ix (qpracticeid)
, KEY mdl_qprasess_cat4_ix (categoryid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Default comment for the table, please edit me'; CREATE TABLE mdl_qr_categories (
    id BIGINT(10) NOT NULL auto_increment,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    info LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    infoformat TINYINT(2) NOT NULL DEFAULT 0,
    stamp VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    parent BIGINT(10) NOT NULL DEFAULT 0,
    sortorder BIGINT(10) NOT NULL DEFAULT 999,
CONSTRAINT  PRIMARY KEY (id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Categories are for grouping quizzes'; CREATE TABLE mdl_qr_quiz_list (
    id BIGINT(10) NOT NULL auto_increment,
    category BIGINT(10),
    quiz BIGINT(10),
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_qrquizlist_qui2_fk FOREIGN KEY (quiz) REFERENCES mdl_quiz (id)
, KEY mdl_qrquizlist_qui4_ix (quiz)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Default comment for the table, please edit me'; CREATE TABLE mdl_qr_user_groups (
    id BIGINT(10) NOT NULL auto_increment,
    groupid BIGINT(10),
    qrquiz BIGINT(10),
CONSTRAINT  PRIMARY KEY (id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Default comment for the table, please edit me'; CREATE TABLE mdl_quiz (
    id BIGINT(10) NOT NULL auto_increment,
    course BIGINT(10) NOT NULL DEFAULT 0,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    intro LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    introformat SMALLINT(4) NOT NULL DEFAULT 0,
    timeopen BIGINT(10) NOT NULL DEFAULT 0,
    timeclose BIGINT(10) NOT NULL DEFAULT 0,
    timelimit BIGINT(10) NOT NULL DEFAULT 0,
    overduehandling VARCHAR(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'autoabandon',
    graceperiod BIGINT(10) NOT NULL DEFAULT 0,
    preferredbehaviour VARCHAR(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    canredoquestions SMALLINT(4) NOT NULL DEFAULT 0,
    attempts MEDIUMINT(6) NOT NULL DEFAULT 0,
    attemptonlast SMALLINT(4) NOT NULL DEFAULT 0,
    grademethod SMALLINT(4) NOT NULL DEFAULT 1,
    decimalpoints SMALLINT(4) NOT NULL DEFAULT 2,
    questiondecimalpoints SMALLINT(4) NOT NULL DEFAULT -1,
    reviewattempt MEDIUMINT(6) NOT NULL DEFAULT 0,
    reviewcorrectness MEDIUMINT(6) NOT NULL DEFAULT 0,
    reviewmarks MEDIUMINT(6) NOT NULL DEFAULT 0,
    reviewspecificfeedback MEDIUMINT(6) NOT NULL DEFAULT 0,
    reviewgeneralfeedback MEDIUMINT(6) NOT NULL DEFAULT 0,
    reviewrightanswer MEDIUMINT(6) NOT NULL DEFAULT 0,
    reviewoverallfeedback MEDIUMINT(6) NOT NULL DEFAULT 0,
    questionsperpage BIGINT(10) NOT NULL DEFAULT 0,
    navmethod VARCHAR(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'free',
    shuffleanswers SMALLINT(4) NOT NULL DEFAULT 0,
    sumgrades NUMERIC(10,5) NOT NULL DEFAULT 0,
    grade NUMERIC(10,5) NOT NULL DEFAULT 0,
    timecreated BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
    password VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    subnet VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    browsersecurity VARCHAR(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    delay1 BIGINT(10) NOT NULL DEFAULT 0,
    delay2 BIGINT(10) NOT NULL DEFAULT 0,
    showuserpicture SMALLINT(4) NOT NULL DEFAULT 0,
    showblocks SMALLINT(4) NOT NULL DEFAULT 0,
    completionattemptsexhausted TINYINT(1) DEFAULT 0,
    completionpass TINYINT(1) DEFAULT 0,
    allowofflineattempts TINYINT(1) DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_quiz_cou2_ix (course)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='The settings for each quiz.'; CREATE TABLE mdl_quiz_slots (
    id BIGINT(10) NOT NULL auto_increment,
    slot BIGINT(10) NOT NULL,
    quizid BIGINT(10) NOT NULL DEFAULT 0,
    page BIGINT(10) NOT NULL,
    requireprevious SMALLINT(4) NOT NULL DEFAULT 0,
    questionid BIGINT(10) NOT NULL DEFAULT 0,
    questioncategoryid BIGINT(10),
    includingsubcategories SMALLINT(4),
    maxmark NUMERIC(12,7) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_quizslot_qui2_fk FOREIGN KEY (quizid) REFERENCES mdl_quiz (id),
CONSTRAINT mdl_quizslot_que3_fk FOREIGN KEY (questionid) REFERENCES mdl_question (id),
CONSTRAINT mdl_quizslot_que4_fk FOREIGN KEY (questioncategoryid) REFERENCES mdl_question_categories (id)
, UNIQUE KEY mdl_quizslot_quislo2_uix (quizid, slot)
, KEY mdl_quizslot_qui4_ix (quizid)
, KEY mdl_quizslot_que6_ix (questionid)
, KEY mdl_quizslot_que8_ix (questioncategoryid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stores the question used in a quiz, with the order, and for '; CREATE TABLE mdl_quiz_sections (
    id BIGINT(10) NOT NULL auto_increment,
    quizid BIGINT(10) NOT NULL,
    firstslot BIGINT(10) NOT NULL,
    heading VARCHAR(1333) COLLATE utf8mb4_unicode_ci,
    shufflequestions SMALLINT(4) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_quizsect_qui2_fk FOREIGN KEY (quizid) REFERENCES mdl_quiz (id)
, UNIQUE KEY mdl_quizsect_quifir2_uix (quizid, firstslot)
, KEY mdl_quizsect_qui4_ix (quizid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stores sections of a quiz with section name (heading), from '; CREATE TABLE mdl_quiz_feedback (
    id BIGINT(10) NOT NULL auto_increment,
    quizid BIGINT(10) NOT NULL DEFAULT 0,
    feedbacktext LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    feedbacktextformat TINYINT(2) NOT NULL DEFAULT 0,
    mingrade NUMERIC(10,5) NOT NULL DEFAULT 0,
    maxgrade NUMERIC(10,5) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_quizfeed_qui2_fk FOREIGN KEY (quizid) REFERENCES mdl_quiz (id)
, KEY mdl_quizfeed_qui4_ix (quizid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Feedback given to students based on which grade band their o'; CREATE TABLE mdl_quiz_overrides (
    id BIGINT(10) NOT NULL auto_increment,
    quiz BIGINT(10) NOT NULL DEFAULT 0,
    groupid BIGINT(10),
    userid BIGINT(10),
    timeopen BIGINT(10),
    timeclose BIGINT(10),
    timelimit BIGINT(10),
    attempts MEDIUMINT(6),
    password VARCHAR(255) COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_quizover_qui2_fk FOREIGN KEY (quiz) REFERENCES mdl_quiz (id),
CONSTRAINT mdl_quizover_gro2_fk FOREIGN KEY (groupid) REFERENCES mdl_groups (id),
CONSTRAINT mdl_quizover_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id)
, KEY mdl_quizover_qui4_ix (quiz)
, KEY mdl_quizover_gro4_ix (groupid)
, KEY mdl_quizover_use4_ix (userid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='The overrides to quiz settings on a per-user and per-group b'; CREATE TABLE mdl_quiz_attempts (
    id BIGINT(10) NOT NULL auto_increment,
    quiz BIGINT(10) NOT NULL DEFAULT 0,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    attempt MEDIUMINT(6) NOT NULL DEFAULT 0,
    uniqueid BIGINT(10) NOT NULL DEFAULT 0,
    layout LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    currentpage BIGINT(10) NOT NULL DEFAULT 0,
    preview SMALLINT(3) NOT NULL DEFAULT 0,
    state VARCHAR(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'inprogress',
    timestart BIGINT(10) NOT NULL DEFAULT 0,
    timefinish BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
    timemodifiedoffline BIGINT(10) NOT NULL DEFAULT 0,
    timecheckstate BIGINT(10) DEFAULT 0,
    sumgrades NUMERIC(10,5),
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_quizatte_qui2_fk FOREIGN KEY (quiz) REFERENCES mdl_quiz (id),
CONSTRAINT mdl_quizatte_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id),
CONSTRAINT mdl_quizatte_uni_fk FOREIGN KEY (uniqueid) REFERENCES mdl_question_usages (id)
, UNIQUE KEY mdl_quizatte_quiuseatt2_uix (quiz, userid, attempt)
, KEY mdl_quizatte_statim2_ix (state, timecheckstate)
, KEY mdl_quizatte_qui4_ix (quiz)
, KEY mdl_quizatte_use4_ix (userid)
, UNIQUE KEY mdl_quizatte_uni2_uix (uniqueid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stores users attempts at quizzes.'; CREATE TABLE mdl_quiz_grades (
    id BIGINT(10) NOT NULL auto_increment,
    quiz BIGINT(10) NOT NULL DEFAULT 0,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    grade NUMERIC(10,5) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_quizgrad_qui2_fk FOREIGN KEY (quiz) REFERENCES mdl_quiz (id)
, KEY mdl_quizgrad_use2_ix (userid)
, KEY mdl_quizgrad_qui4_ix (quiz)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stores the overall grade for each user on the quiz, based on'; CREATE TABLE mdl_quiz_reports (
    id BIGINT(10) NOT NULL auto_increment,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    displayorder BIGINT(10) NOT NULL,
    capability VARCHAR(255) COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY mdl_quizrepo_nam2_uix (name)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Lists all the installed quiz reports and their display order'; CREATE TABLE mdl_quiz_slot_tags (
    id BIGINT(10) NOT NULL auto_increment,
    slotid BIGINT(10),
    tagid BIGINT(10),
    tagname VARCHAR(255) COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_quizslottags_slo2_fk FOREIGN KEY (slotid) REFERENCES mdl_quiz_slots (id),
CONSTRAINT mdl_quizslottags_tag2_fk FOREIGN KEY (tagid) REFERENCES mdl_tag (id)
, KEY mdl_quizslottags_slo4_ix (slotid)
, KEY mdl_quizslottags_tag4_ix (tagid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stores data about the tags that a question must have so that'; CREATE TABLE mdl_resource (
    id BIGINT(10) NOT NULL auto_increment,
    course BIGINT(10) NOT NULL DEFAULT 0,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    intro LONGTEXT COLLATE utf8mb4_unicode_ci,
    introformat SMALLINT(4) NOT NULL DEFAULT 0,
    tobemigrated SMALLINT(4) NOT NULL DEFAULT 0,
    legacyfiles SMALLINT(4) NOT NULL DEFAULT 0,
    legacyfileslast BIGINT(10),
    display SMALLINT(4) NOT NULL DEFAULT 0,
    displayoptions LONGTEXT COLLATE utf8mb4_unicode_ci,
    filterfiles SMALLINT(4) NOT NULL DEFAULT 0,
    revision BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_reso_cou2_ix (course)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Each record is one resource and its config data'; CREATE TABLE mdl_resource_old (
    id BIGINT(10) NOT NULL auto_increment,
    course BIGINT(10) NOT NULL DEFAULT 0,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    type VARCHAR(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    reference VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    intro LONGTEXT COLLATE utf8mb4_unicode_ci,
    introformat SMALLINT(4) NOT NULL DEFAULT 0,
    alltext LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    popup LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    options VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
    oldid BIGINT(10) NOT NULL,
    cmid BIGINT(10),
    newmodule VARCHAR(50) COLLATE utf8mb4_unicode_ci,
    newid BIGINT(10),
    migrated BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY mdl_resoold_old2_uix (oldid)
, KEY mdl_resoold_cmi2_ix (cmid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='backup of all old resource instances from 1.9'; CREATE TABLE mdl_scorm (
    id BIGINT(10) NOT NULL auto_increment,
    course BIGINT(10) NOT NULL DEFAULT 0,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    scormtype VARCHAR(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'local',
    reference VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    intro LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    introformat SMALLINT(4) NOT NULL DEFAULT 0,
    version VARCHAR(9) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    maxgrade DOUBLE NOT NULL DEFAULT 0,
    grademethod TINYINT(2) NOT NULL DEFAULT 0,
    whatgrade BIGINT(10) NOT NULL DEFAULT 0,
    maxattempt BIGINT(10) NOT NULL DEFAULT 1,
    forcecompleted TINYINT(1) NOT NULL DEFAULT 0,
    forcenewattempt TINYINT(1) NOT NULL DEFAULT 0,
    lastattemptlock TINYINT(1) NOT NULL DEFAULT 0,
    masteryoverride TINYINT(1) NOT NULL DEFAULT 1,
    displayattemptstatus TINYINT(1) NOT NULL DEFAULT 1,
    displaycoursestructure TINYINT(1) NOT NULL DEFAULT 0,
    updatefreq TINYINT(1) NOT NULL DEFAULT 0,
    sha1hash VARCHAR(40) COLLATE utf8mb4_unicode_ci,
    md5hash VARCHAR(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    revision BIGINT(10) NOT NULL DEFAULT 0,
    launch BIGINT(10) NOT NULL DEFAULT 0,
    skipview TINYINT(1) NOT NULL DEFAULT 1,
    hidebrowse TINYINT(1) NOT NULL DEFAULT 0,
    hidetoc TINYINT(1) NOT NULL DEFAULT 0,
    nav TINYINT(1) NOT NULL DEFAULT 1,
    navpositionleft BIGINT(10) DEFAULT -100,
    navpositiontop BIGINT(10) DEFAULT -100,
    auto TINYINT(1) NOT NULL DEFAULT 0,
    popup TINYINT(1) NOT NULL DEFAULT 0,
    options VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    width BIGINT(10) NOT NULL DEFAULT 100,
    height BIGINT(10) NOT NULL DEFAULT 600,
    timeopen BIGINT(10) NOT NULL DEFAULT 0,
    timeclose BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
    completionstatusrequired TINYINT(1),
    completionscorerequired BIGINT(10),
    completionstatusallscos TINYINT(1),
    displayactivityname SMALLINT(4) NOT NULL DEFAULT 1,
    autocommit TINYINT(1) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_scor_cou2_ix (course)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='each table is one SCORM module and its configuration'; CREATE TABLE mdl_scorm_scoes (
    id BIGINT(10) NOT NULL auto_increment,
    scorm BIGINT(10) NOT NULL DEFAULT 0,
    manifest VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    organization VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    parent VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    identifier VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    launch LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    scormtype VARCHAR(5) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    title VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    sortorder BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_scorscoe_sco2_fk FOREIGN KEY (scorm) REFERENCES mdl_scorm (id)
, KEY mdl_scorscoe_sco4_ix (scorm)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='each SCO part of the SCORM module'; CREATE TABLE mdl_scorm_scoes_data (
    id BIGINT(10) NOT NULL auto_increment,
    scoid BIGINT(10) NOT NULL DEFAULT 0,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    value LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_scorscoedata_sco2_fk FOREIGN KEY (scoid) REFERENCES mdl_scorm_scoes (id)
, KEY mdl_scorscoedata_sco4_ix (scoid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Contains variable data get from packages'; CREATE TABLE mdl_scorm_scoes_track (
    id BIGINT(10) NOT NULL auto_increment,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    scormid BIGINT(10) NOT NULL DEFAULT 0,
    scoid BIGINT(10) NOT NULL DEFAULT 0,
    attempt BIGINT(10) NOT NULL DEFAULT 1,
    element VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    value LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_scorscoetrac_sco3_fk FOREIGN KEY (scormid) REFERENCES mdl_scorm (id),
CONSTRAINT mdl_scorscoetrac_sco4_fk FOREIGN KEY (scoid) REFERENCES mdl_scorm_scoes (id)
, UNIQUE KEY mdl_scorscoetrac_usescosc2_uix (userid, scormid, scoid, attempt, element)
, KEY mdl_scorscoetrac_use2_ix (userid)
, KEY mdl_scorscoetrac_sco6_ix (scormid)
, KEY mdl_scorscoetrac_sco8_ix (scoid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='to track SCOes'; CREATE TABLE mdl_scorm_seq_objective (
    id BIGINT(10) NOT NULL auto_increment,
    scoid BIGINT(10) NOT NULL DEFAULT 0,
    primaryobj TINYINT(1) NOT NULL DEFAULT 0,
    objectiveid VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    satisfiedbymeasure TINYINT(1) NOT NULL DEFAULT 1,
    minnormalizedmeasure FLOAT(11,4) NOT NULL DEFAULT 0.0000,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_scorseqobje_sco2_fk FOREIGN KEY (scoid) REFERENCES mdl_scorm_scoes (id)
, UNIQUE KEY mdl_scorseqobje_scoid2_uix (scoid, id)
, KEY mdl_scorseqobje_sco4_ix (scoid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='SCORM2004 objective description'; CREATE TABLE mdl_scorm_seq_mapinfo (
    id BIGINT(10) NOT NULL auto_increment,
    scoid BIGINT(10) NOT NULL DEFAULT 0,
    objectiveid BIGINT(10) NOT NULL DEFAULT 0,
    targetobjectiveid BIGINT(10) NOT NULL DEFAULT 0,
    readsatisfiedstatus TINYINT(1) NOT NULL DEFAULT 1,
    readnormalizedmeasure TINYINT(1) NOT NULL DEFAULT 1,
    writesatisfiedstatus TINYINT(1) NOT NULL DEFAULT 0,
    writenormalizedmeasure TINYINT(1) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_scorseqmapi_sco2_fk FOREIGN KEY (scoid) REFERENCES mdl_scorm_scoes (id),
CONSTRAINT mdl_scorseqmapi_obj2_fk FOREIGN KEY (objectiveid) REFERENCES mdl_scorm_seq_objective (id)
, UNIQUE KEY mdl_scorseqmapi_scoidobj2_uix (scoid, id, objectiveid)
, KEY mdl_scorseqmapi_sco4_ix (scoid)
, KEY mdl_scorseqmapi_obj4_ix (objectiveid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='SCORM2004 objective mapinfo description'; CREATE TABLE mdl_scorm_seq_ruleconds (
    id BIGINT(10) NOT NULL auto_increment,
    scoid BIGINT(10) NOT NULL DEFAULT 0,
    conditioncombination VARCHAR(3) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'all',
    ruletype TINYINT(2) NOT NULL DEFAULT 0,
    action VARCHAR(25) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_scorseqrule_sco3_fk FOREIGN KEY (scoid) REFERENCES mdl_scorm_scoes (id)
, UNIQUE KEY mdl_scorseqrule_scoid2_uix (scoid, id)
, KEY mdl_scorseqrule_sco5_ix (scoid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='SCORM2004 rule conditions'; CREATE TABLE mdl_scorm_seq_rulecond (
    id BIGINT(10) NOT NULL auto_increment,
    scoid BIGINT(10) NOT NULL DEFAULT 0,
    ruleconditionsid BIGINT(10) NOT NULL DEFAULT 0,
    refrencedobjective VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    measurethreshold FLOAT(11,4) NOT NULL DEFAULT 0.0000,
    operator VARCHAR(5) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'noOp',
    cond VARCHAR(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'always',
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_scorseqrule_sco6_fk FOREIGN KEY (scoid) REFERENCES mdl_scorm_scoes (id),
CONSTRAINT mdl_scorseqrule_rul2_fk FOREIGN KEY (ruleconditionsid) REFERENCES mdl_scorm_seq_ruleconds (id)
, UNIQUE KEY mdl_scorseqrule_idscorul2_uix (id, scoid, ruleconditionsid)
, KEY mdl_scorseqrule_sco8_ix (scoid)
, KEY mdl_scorseqrule_rul4_ix (ruleconditionsid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='SCORM2004 rule condition'; CREATE TABLE mdl_scorm_seq_rolluprule (
    id BIGINT(10) NOT NULL auto_increment,
    scoid BIGINT(10) NOT NULL DEFAULT 0,
    childactivityset VARCHAR(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    minimumcount BIGINT(10) NOT NULL DEFAULT 0,
    minimumpercent FLOAT(11,4) NOT NULL DEFAULT 0.0000,
    conditioncombination VARCHAR(3) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'all',
    action VARCHAR(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_scorseqroll_sco3_fk FOREIGN KEY (scoid) REFERENCES mdl_scorm_scoes (id)
, UNIQUE KEY mdl_scorseqroll_scoid2_uix (scoid, id)
, KEY mdl_scorseqroll_sco5_ix (scoid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='SCORM2004 sequencing rule'; CREATE TABLE mdl_scorm_seq_rolluprulecond (
    id BIGINT(10) NOT NULL auto_increment,
    scoid BIGINT(10) NOT NULL DEFAULT 0,
    rollupruleid BIGINT(10) NOT NULL DEFAULT 0,
    operator VARCHAR(5) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'noOp',
    cond VARCHAR(25) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_scorseqroll_sco6_fk FOREIGN KEY (scoid) REFERENCES mdl_scorm_scoes (id),
CONSTRAINT mdl_scorseqroll_rol2_fk FOREIGN KEY (rollupruleid) REFERENCES mdl_scorm_seq_rolluprule (id)
, UNIQUE KEY mdl_scorseqroll_scorolid2_uix (scoid, rollupruleid, id)
, KEY mdl_scorseqroll_sco8_ix (scoid)
, KEY mdl_scorseqroll_rol4_ix (rollupruleid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='SCORM2004 sequencing rule'; CREATE TABLE mdl_scorm_aicc_session (
    id BIGINT(10) NOT NULL auto_increment,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    scormid BIGINT(10) NOT NULL DEFAULT 0,
    hacpsession VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    scoid BIGINT(10) DEFAULT 0,
    scormmode VARCHAR(50) COLLATE utf8mb4_unicode_ci,
    scormstatus VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    attempt BIGINT(10),
    lessonstatus VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    sessiontime VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    timecreated BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_scoraiccsess_sco2_fk FOREIGN KEY (scormid) REFERENCES mdl_scorm (id),
CONSTRAINT mdl_scoraiccsess_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id)
, KEY mdl_scoraiccsess_sco4_ix (scormid)
, KEY mdl_scoraiccsess_use4_ix (userid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Used by AICC HACP to store session information'; CREATE TABLE mdl_survey (
    id BIGINT(10) NOT NULL auto_increment,
    course BIGINT(10) NOT NULL DEFAULT 0,
    template BIGINT(10) NOT NULL DEFAULT 0,
    days MEDIUMINT(6) NOT NULL DEFAULT 0,
    timecreated BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    intro LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    introformat SMALLINT(4) NOT NULL DEFAULT 0,
    questions VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    completionsubmit TINYINT(1) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_surv_cou2_ix (course)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Each record is one SURVEY module with its configuration'; CREATE TABLE mdl_survey_questions (
    id BIGINT(10) NOT NULL auto_increment,
    text VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    shorttext VARCHAR(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    multi VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    intro VARCHAR(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    type SMALLINT(3) NOT NULL DEFAULT 0,
    options LONGTEXT COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='the questions conforming one survey'; CREATE TABLE mdl_survey_answers (
    id BIGINT(10) NOT NULL auto_increment,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    survey BIGINT(10) NOT NULL DEFAULT 0,
    question BIGINT(10) NOT NULL DEFAULT 0,
    time BIGINT(10) NOT NULL DEFAULT 0,
    answer1 LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    answer2 LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_survansw_sur2_fk FOREIGN KEY (survey) REFERENCES mdl_survey (id),
CONSTRAINT mdl_survansw_que2_fk FOREIGN KEY (question) REFERENCES mdl_survey_questions (id)
, KEY mdl_survansw_use2_ix (userid)
, KEY mdl_survansw_sur4_ix (survey)
, KEY mdl_survansw_que4_ix (question)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='the answers to each questions filled by the users'; CREATE TABLE mdl_survey_analysis (
    id BIGINT(10) NOT NULL auto_increment,
    survey BIGINT(10) NOT NULL DEFAULT 0,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    notes LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_survanal_sur2_fk FOREIGN KEY (survey) REFERENCES mdl_survey (id)
, KEY mdl_survanal_use2_ix (userid)
, KEY mdl_survanal_sur4_ix (survey)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='text about each survey submission'; CREATE TABLE mdl_url (
    id BIGINT(10) NOT NULL auto_increment,
    course BIGINT(10) NOT NULL DEFAULT 0,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    intro LONGTEXT COLLATE utf8mb4_unicode_ci,
    introformat SMALLINT(4) NOT NULL DEFAULT 0,
    externalurl LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    display SMALLINT(4) NOT NULL DEFAULT 0,
    displayoptions LONGTEXT COLLATE utf8mb4_unicode_ci,
    parameters LONGTEXT COLLATE utf8mb4_unicode_ci,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_url_cou2_ix (course)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='each record is one url resource'; CREATE TABLE mdl_wiki (
    id BIGINT(10) NOT NULL auto_increment,
    course BIGINT(10) NOT NULL DEFAULT 0,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Wiki',
    intro LONGTEXT COLLATE utf8mb4_unicode_ci,
    introformat SMALLINT(4) NOT NULL DEFAULT 0,
    timecreated BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
    firstpagetitle VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'First Page',
    wikimode VARCHAR(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'collaborative',
    defaultformat VARCHAR(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'creole',
    forceformat TINYINT(1) NOT NULL DEFAULT 1,
    editbegin BIGINT(10) NOT NULL DEFAULT 0,
    editend BIGINT(10) DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_wiki_cou2_ix (course)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stores Wiki activity configuration'; CREATE TABLE mdl_wiki_subwikis (
    id BIGINT(10) NOT NULL auto_increment,
    wikiid BIGINT(10) NOT NULL DEFAULT 0,
    groupid BIGINT(10) NOT NULL DEFAULT 0,
    userid BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_wikisubw_wik2_fk FOREIGN KEY (wikiid) REFERENCES mdl_wiki (id)
, KEY mdl_wikisubw_wik4_ix (wikiid)
, UNIQUE KEY mdl_wikisubw_wikgrouse2_uix (wikiid, groupid, userid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stores subwiki instances'; CREATE TABLE mdl_wiki_pages (
    id BIGINT(10) NOT NULL auto_increment,
    subwikiid BIGINT(10) NOT NULL DEFAULT 0,
    title VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'title',
    cachedcontent LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    timecreated BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
    timerendered BIGINT(10) NOT NULL DEFAULT 0,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    pageviews BIGINT(10) NOT NULL DEFAULT 0,
    readonly TINYINT(1) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_wikipage_sub2_fk FOREIGN KEY (subwikiid) REFERENCES mdl_wiki_subwikis (id)
, UNIQUE KEY mdl_wikipage_subtituse2_uix (subwikiid, title, userid)
, KEY mdl_wikipage_sub4_ix (subwikiid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stores wiki pages'; CREATE TABLE mdl_wiki_versions (
    id BIGINT(10) NOT NULL auto_increment,
    pageid BIGINT(10) NOT NULL DEFAULT 0,
    content LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    contentformat VARCHAR(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'creole',
    version MEDIUMINT(5) NOT NULL DEFAULT 0,
    timecreated BIGINT(10) NOT NULL DEFAULT 0,
    userid BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_wikivers_pag2_fk FOREIGN KEY (pageid) REFERENCES mdl_wiki_pages (id)
, KEY mdl_wikivers_pag4_ix (pageid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stores wiki page history'; CREATE TABLE mdl_wiki_synonyms (
    id BIGINT(10) NOT NULL auto_increment,
    subwikiid BIGINT(10) NOT NULL DEFAULT 0,
    pageid BIGINT(10) NOT NULL DEFAULT 0,
    pagesynonym VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Pagesynonym',
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY mdl_wikisyno_pagpag2_uix (pageid, pagesynonym)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stores wiki pages synonyms'; CREATE TABLE mdl_wiki_links (
    id BIGINT(10) NOT NULL auto_increment,
    subwikiid BIGINT(10) NOT NULL DEFAULT 0,
    frompageid BIGINT(10) NOT NULL DEFAULT 0,
    topageid BIGINT(10) NOT NULL DEFAULT 0,
    tomissingpage VARCHAR(255) COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_wikilink_fro2_fk FOREIGN KEY (frompageid) REFERENCES mdl_wiki_pages (id),
CONSTRAINT mdl_wikilink_sub2_fk FOREIGN KEY (subwikiid) REFERENCES mdl_wiki_subwikis (id)
, KEY mdl_wikilink_fro4_ix (frompageid)
, KEY mdl_wikilink_sub4_ix (subwikiid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Page wiki links'; CREATE TABLE mdl_wiki_locks (
    id BIGINT(10) NOT NULL auto_increment,
    pageid BIGINT(10) NOT NULL DEFAULT 0,
    sectionname VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    lockedat BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Manages page locks'; CREATE TABLE mdl_workshop (
    id BIGINT(10) NOT NULL auto_increment,
    course BIGINT(10) NOT NULL,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    intro LONGTEXT COLLATE utf8mb4_unicode_ci,
    introformat SMALLINT(3) NOT NULL DEFAULT 0,
    instructauthors LONGTEXT COLLATE utf8mb4_unicode_ci,
    instructauthorsformat SMALLINT(3) NOT NULL DEFAULT 0,
    instructreviewers LONGTEXT COLLATE utf8mb4_unicode_ci,
    instructreviewersformat SMALLINT(3) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL,
    phase SMALLINT(3) DEFAULT 0,
    useexamples TINYINT(2) DEFAULT 0,
    usepeerassessment TINYINT(2) DEFAULT 0,
    useselfassessment TINYINT(2) DEFAULT 0,
    grade NUMERIC(10,5) DEFAULT 80,
    gradinggrade NUMERIC(10,5) DEFAULT 20,
    strategy VARCHAR(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    evaluation VARCHAR(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    gradedecimals SMALLINT(3) DEFAULT 0,
    submissiontypetext TINYINT(1) NOT NULL DEFAULT 1,
    submissiontypefile TINYINT(1) NOT NULL DEFAULT 1,
    nattachments SMALLINT(3) DEFAULT 1,
    submissionfiletypes VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    latesubmissions TINYINT(2) DEFAULT 0,
    maxbytes BIGINT(10) DEFAULT 100000,
    examplesmode SMALLINT(3) DEFAULT 0,
    submissionstart BIGINT(10) DEFAULT 0,
    submissionend BIGINT(10) DEFAULT 0,
    assessmentstart BIGINT(10) DEFAULT 0,
    assessmentend BIGINT(10) DEFAULT 0,
    phaseswitchassessment TINYINT(2) NOT NULL DEFAULT 0,
    conclusion LONGTEXT COLLATE utf8mb4_unicode_ci,
    conclusionformat SMALLINT(3) NOT NULL DEFAULT 1,
    overallfeedbackmode SMALLINT(3) DEFAULT 1,
    overallfeedbackfiles SMALLINT(3) DEFAULT 0,
    overallfeedbackfiletypes VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    overallfeedbackmaxbytes BIGINT(10) DEFAULT 100000,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_work_cou2_fk FOREIGN KEY (course) REFERENCES mdl_course (id)
, KEY mdl_work_cou4_ix (course)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='This table keeps information about the module instances and '; CREATE TABLE mdl_workshop_submissions (
    id BIGINT(10) NOT NULL auto_increment,
    workshopid BIGINT(10) NOT NULL,
    example TINYINT(2) DEFAULT 0,
    authorid BIGINT(10) NOT NULL,
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
    title VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    content LONGTEXT COLLATE utf8mb4_unicode_ci,
    contentformat SMALLINT(3) NOT NULL DEFAULT 0,
    contenttrust SMALLINT(3) NOT NULL DEFAULT 0,
    attachment TINYINT(2) DEFAULT 0,
    grade NUMERIC(10,5),
    gradeover NUMERIC(10,5),
    gradeoverby BIGINT(10),
    feedbackauthor LONGTEXT COLLATE utf8mb4_unicode_ci,
    feedbackauthorformat SMALLINT(3) DEFAULT 0,
    timegraded BIGINT(10),
    published TINYINT(2) DEFAULT 0,
    late TINYINT(2) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_worksubm_wor2_fk FOREIGN KEY (workshopid) REFERENCES mdl_workshop (id),
CONSTRAINT mdl_worksubm_gra2_fk FOREIGN KEY (gradeoverby) REFERENCES mdl_user (id),
CONSTRAINT mdl_worksubm_aut2_fk FOREIGN KEY (authorid) REFERENCES mdl_user (id)
, KEY mdl_worksubm_wor4_ix (workshopid)
, KEY mdl_worksubm_gra4_ix (gradeoverby)
, KEY mdl_worksubm_aut4_ix (authorid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Info about the submission and the aggregation of the grade f'; CREATE TABLE mdl_workshop_assessments (
    id BIGINT(10) NOT NULL auto_increment,
    submissionid BIGINT(10) NOT NULL,
    reviewerid BIGINT(10) NOT NULL,
    weight BIGINT(10) NOT NULL DEFAULT 1,
    timecreated BIGINT(10) DEFAULT 0,
    timemodified BIGINT(10) DEFAULT 0,
    grade NUMERIC(10,5),
    gradinggrade NUMERIC(10,5),
    gradinggradeover NUMERIC(10,5),
    gradinggradeoverby BIGINT(10),
    feedbackauthor LONGTEXT COLLATE utf8mb4_unicode_ci,
    feedbackauthorformat SMALLINT(3) DEFAULT 0,
    feedbackauthorattachment SMALLINT(3) DEFAULT 0,
    feedbackreviewer LONGTEXT COLLATE utf8mb4_unicode_ci,
    feedbackreviewerformat SMALLINT(3) DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_workasse_sub2_fk FOREIGN KEY (submissionid) REFERENCES mdl_workshop_submissions (id),
CONSTRAINT mdl_workasse_gra2_fk FOREIGN KEY (gradinggradeoverby) REFERENCES mdl_user (id),
CONSTRAINT mdl_workasse_rev2_fk FOREIGN KEY (reviewerid) REFERENCES mdl_user (id)
, KEY mdl_workasse_sub4_ix (submissionid)
, KEY mdl_workasse_gra4_ix (gradinggradeoverby)
, KEY mdl_workasse_rev4_ix (reviewerid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Info about the made assessment and automatically calculated '; CREATE TABLE mdl_workshop_grades (
    id BIGINT(10) NOT NULL auto_increment,
    assessmentid BIGINT(10) NOT NULL,
    strategy VARCHAR(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    dimensionid BIGINT(10) NOT NULL,
    grade NUMERIC(10,5) NOT NULL,
    peercomment LONGTEXT COLLATE utf8mb4_unicode_ci,
    peercommentformat SMALLINT(3) DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_workgrad_ass2_fk FOREIGN KEY (assessmentid) REFERENCES mdl_workshop_assessments (id)
, KEY mdl_workgrad_ass4_ix (assessmentid)
, UNIQUE KEY mdl_workgrad_assstrdim2_uix (assessmentid, strategy, dimensionid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='How the reviewers filled-up the grading forms, given grades '; CREATE TABLE mdl_workshop_aggregations (
    id BIGINT(10) NOT NULL auto_increment,
    workshopid BIGINT(10) NOT NULL,
    userid BIGINT(10) NOT NULL,
    gradinggrade NUMERIC(10,5),
    timegraded BIGINT(10),
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_workaggr_wor2_fk FOREIGN KEY (workshopid) REFERENCES mdl_workshop (id),
CONSTRAINT mdl_workaggr_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id)
, KEY mdl_workaggr_wor4_ix (workshopid)
, KEY mdl_workaggr_use4_ix (userid)
, UNIQUE KEY mdl_workaggr_woruse2_uix (workshopid, userid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Aggregated grades for assessment are stored here. The aggreg'; CREATE TABLE mdl_portfolio_mahara_queue (
    id BIGINT(10) NOT NULL auto_increment,
    transferid BIGINT(10) NOT NULL,
    token VARCHAR(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_portmahaqueu_tra2_fk FOREIGN KEY (transferid) REFERENCES mdl_portfolio_tempdata (id)
, KEY mdl_portmahaqueu_tok2_ix (token)
, KEY mdl_portmahaqueu_tra4_ix (transferid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='maps mahara tokens to transfer ids'; CREATE TABLE mdl_repository_onedrive_access (
    id BIGINT(10) NOT NULL auto_increment,
    timemodified BIGINT(10) NOT NULL,
    timecreated BIGINT(10) NOT NULL,
    usermodified BIGINT(10) NOT NULL,
    permissionid VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    itemid VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_repoonedacce_use2_fk FOREIGN KEY (usermodified) REFERENCES mdl_user (id)
, KEY mdl_repoonedacce_use4_ix (usermodified)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='List of temporary access grants.'; CREATE TABLE mdl_tool_cohortroles (
    id BIGINT(10) NOT NULL auto_increment,
    cohortid BIGINT(10) NOT NULL,
    roleid BIGINT(10) NOT NULL,
    userid BIGINT(10) NOT NULL,
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
    usermodified BIGINT(10),
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY mdl_toolcoho_cohroluse2_uix (cohortid, roleid, userid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Mapping of users to cohort role assignments.'; CREATE TABLE mdl_tool_customlang (
    id BIGINT(10) NOT NULL auto_increment,
    lang VARCHAR(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    componentid BIGINT(10) NOT NULL,
    stringid VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    original LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    master LONGTEXT COLLATE utf8mb4_unicode_ci,
    local LONGTEXT COLLATE utf8mb4_unicode_ci,
    timemodified BIGINT(10) NOT NULL,
    timecustomized BIGINT(10),
    outdated SMALLINT(3) DEFAULT 0,
    modified SMALLINT(3) DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_toolcust_com2_fk FOREIGN KEY (componentid) REFERENCES mdl_tool_customlang_components (id)
, UNIQUE KEY mdl_toolcust_lancomstr2_uix (lang, componentid, stringid)
, KEY mdl_toolcust_com4_ix (componentid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Contains the working checkout of all strings and their custo'; CREATE TABLE mdl_tool_customlang_components (
    id BIGINT(10) NOT NULL auto_increment,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    version VARCHAR(255) COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Contains the list of all installed plugins that provide thei'; CREATE TABLE mdl_tool_dataprivacy_request (
    id BIGINT(10) NOT NULL auto_increment,
    type BIGINT(10) NOT NULL DEFAULT 0,
    comments LONGTEXT COLLATE utf8mb4_unicode_ci,
    commentsformat TINYINT(2) NOT NULL DEFAULT 0,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    requestedby BIGINT(10) NOT NULL DEFAULT 0,
    status TINYINT(2) NOT NULL DEFAULT 0,
    dpo BIGINT(10) DEFAULT 0,
    dpocomment LONGTEXT COLLATE utf8mb4_unicode_ci,
    dpocommentformat TINYINT(2) NOT NULL DEFAULT 0,
    usermodified BIGINT(10) NOT NULL DEFAULT 0,
    timecreated BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
    creationmethod BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_tooldatarequ_use3_fk FOREIGN KEY (userid) REFERENCES mdl_user (id),
CONSTRAINT mdl_tooldatarequ_req2_fk FOREIGN KEY (requestedby) REFERENCES mdl_user (id),
CONSTRAINT mdl_tooldatarequ_dpo2_fk FOREIGN KEY (dpo) REFERENCES mdl_user (id),
CONSTRAINT mdl_tooldatarequ_use4_fk FOREIGN KEY (usermodified) REFERENCES mdl_user (id)
, KEY mdl_tooldatarequ_use6_ix (userid)
, KEY mdl_tooldatarequ_req4_ix (requestedby)
, KEY mdl_tooldatarequ_dpo4_ix (dpo)
, KEY mdl_tooldatarequ_use8_ix (usermodified)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Table for data requests'; CREATE TABLE mdl_tool_dataprivacy_purpose (
    id BIGINT(10) NOT NULL auto_increment,
    name VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    description LONGTEXT COLLATE utf8mb4_unicode_ci,
    descriptionformat TINYINT(1),
    lawfulbases LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    sensitivedatareasons LONGTEXT COLLATE utf8mb4_unicode_ci,
    retentionperiod VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    protected TINYINT(1),
    usermodified BIGINT(10) NOT NULL,
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Data purposes'; CREATE TABLE mdl_tool_dataprivacy_category (
    id BIGINT(10) NOT NULL auto_increment,
    name VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    description LONGTEXT COLLATE utf8mb4_unicode_ci,
    descriptionformat TINYINT(1),
    usermodified BIGINT(10) NOT NULL,
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Data categories'; CREATE TABLE mdl_tool_dataprivacy_ctxinstance (
    id BIGINT(10) NOT NULL auto_increment,
    contextid BIGINT(10) NOT NULL,
    purposeid BIGINT(10),
    categoryid BIGINT(10),
    usermodified BIGINT(10) NOT NULL,
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_tooldatactxi_con_fk FOREIGN KEY (contextid) REFERENCES mdl_context (id),
CONSTRAINT mdl_tooldatactxi_pur2_fk FOREIGN KEY (purposeid) REFERENCES mdl_tool_dataprivacy_purpose (id),
CONSTRAINT mdl_tooldatactxi_cat2_fk FOREIGN KEY (categoryid) REFERENCES mdl_tool_dataprivacy_category (id)
, UNIQUE KEY mdl_tooldatactxi_con2_uix (contextid)
, KEY mdl_tooldatactxi_pur4_ix (purposeid)
, KEY mdl_tooldatactxi_cat4_ix (categoryid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Default comment for the table, please edit me'; CREATE TABLE mdl_tool_dataprivacy_ctxlevel (
    id BIGINT(10) NOT NULL auto_increment,
    contextlevel SMALLINT(3) NOT NULL,
    purposeid BIGINT(10),
    categoryid BIGINT(10),
    usermodified BIGINT(10) NOT NULL,
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_tooldatactxl_cat2_fk FOREIGN KEY (categoryid) REFERENCES mdl_tool_dataprivacy_category (id),
CONSTRAINT mdl_tooldatactxl_pur2_fk FOREIGN KEY (purposeid) REFERENCES mdl_tool_dataprivacy_purpose (id)
, UNIQUE KEY mdl_tooldatactxl_con2_uix (contextlevel)
, KEY mdl_tooldatactxl_cat4_ix (categoryid)
, KEY mdl_tooldatactxl_pur4_ix (purposeid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Default comment for the table, please edit me'; CREATE TABLE mdl_tool_dataprivacy_ctxexpired (
    id BIGINT(10) NOT NULL auto_increment,
    contextid BIGINT(10) NOT NULL,
    unexpiredroles LONGTEXT COLLATE utf8mb4_unicode_ci,
    expiredroles LONGTEXT COLLATE utf8mb4_unicode_ci,
    defaultexpired TINYINT(1) NOT NULL,
    status TINYINT(2) NOT NULL DEFAULT 0,
    usermodified BIGINT(10) NOT NULL,
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_tooldatactxe_con_fk FOREIGN KEY (contextid) REFERENCES mdl_context (id)
, UNIQUE KEY mdl_tooldatactxe_con2_uix (contextid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Default comment for the table, please edit me'; CREATE TABLE mdl_tool_dataprivacy_purposerole (
    id BIGINT(10) NOT NULL auto_increment,
    purposeid BIGINT(10) NOT NULL,
    roleid BIGINT(10) NOT NULL,
    lawfulbases LONGTEXT COLLATE utf8mb4_unicode_ci,
    sensitivedatareasons LONGTEXT COLLATE utf8mb4_unicode_ci,
    retentionperiod VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    protected TINYINT(1),
    usermodified BIGINT(10) NOT NULL,
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_tooldatapurp_pur2_fk FOREIGN KEY (purposeid) REFERENCES mdl_tool_dataprivacy_purpose (id),
CONSTRAINT mdl_tooldatapurp_rol2_fk FOREIGN KEY (roleid) REFERENCES mdl_role (id)
, UNIQUE KEY mdl_tooldatapurp_purrol2_uix (purposeid, roleid)
, KEY mdl_tooldatapurp_pur4_ix (purposeid)
, KEY mdl_tooldatapurp_rol4_ix (roleid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Data purpose overrides for a specific role'; CREATE TABLE mdl_tool_monitor_rules (
    id BIGINT(10) NOT NULL auto_increment,
    description LONGTEXT COLLATE utf8mb4_unicode_ci,
    descriptionformat TINYINT(1) NOT NULL,
    name VARCHAR(254) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    userid BIGINT(10) NOT NULL,
    courseid BIGINT(10) NOT NULL,
    plugin VARCHAR(254) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    eventname VARCHAR(254) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    template LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    templateformat TINYINT(1) NOT NULL,
    frequency SMALLINT(4) NOT NULL,
    timewindow MEDIUMINT(5) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
    timecreated BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_toolmonirule_couuse2_ix (courseid, userid)
, KEY mdl_toolmonirule_eve2_ix (eventname)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Table to store rules'; CREATE TABLE mdl_tool_monitor_subscriptions (
    id BIGINT(10) NOT NULL auto_increment,
    courseid BIGINT(10) NOT NULL,
    ruleid BIGINT(10) NOT NULL,
    cmid BIGINT(10) NOT NULL,
    userid BIGINT(10) NOT NULL,
    timecreated BIGINT(10) NOT NULL,
    lastnotificationsent BIGINT(10) NOT NULL DEFAULT 0,
    inactivedate BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_toolmonisubs_rul2_fk FOREIGN KEY (ruleid) REFERENCES mdl_tool_monitor_rules (id)
, KEY mdl_toolmonisubs_couuse2_ix (courseid, userid)
, KEY mdl_toolmonisubs_rul4_ix (ruleid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Table to store user subscriptions to various rules'; CREATE TABLE mdl_tool_monitor_history (
    id BIGINT(10) NOT NULL auto_increment,
    sid BIGINT(10) NOT NULL,
    userid BIGINT(10) NOT NULL,
    timesent BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_toolmonihist_sid2_fk FOREIGN KEY (sid) REFERENCES mdl_tool_monitor_subscriptions (id)
, UNIQUE KEY mdl_toolmonihist_siduseti2_uix (sid, userid, timesent)
, KEY mdl_toolmonihist_sid4_ix (sid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Table to store history of message notifications sent'; CREATE TABLE mdl_tool_monitor_events (
    id BIGINT(10) NOT NULL auto_increment,
    eventname VARCHAR(254) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    contextid BIGINT(10) NOT NULL,
    contextlevel BIGINT(10) NOT NULL,
    contextinstanceid BIGINT(10) NOT NULL,
    link VARCHAR(254) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    courseid BIGINT(10) NOT NULL,
    timecreated BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='A table that keeps a log of events related to subscriptions'; CREATE TABLE mdl_tool_policy (
    id BIGINT(10) NOT NULL auto_increment,
    sortorder MEDIUMINT(5) NOT NULL DEFAULT 999,
    currentversionid BIGINT(10),
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_toolpoli_cur2_fk FOREIGN KEY (currentversionid) REFERENCES mdl_tool_policy_versions (id)
, KEY mdl_toolpoli_cur4_ix (currentversionid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Contains the list of policy documents defined on the site.'; CREATE TABLE mdl_tool_policy_versions (
    id BIGINT(10) NOT NULL auto_increment,
    name VARCHAR(1333) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    type SMALLINT(3) NOT NULL DEFAULT 0,
    audience SMALLINT(3) NOT NULL DEFAULT 0,
    archived SMALLINT(3) NOT NULL DEFAULT 0,
    usermodified BIGINT(10) NOT NULL,
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
    policyid BIGINT(10) NOT NULL,
    agreementstyle SMALLINT(3) NOT NULL DEFAULT 0,
    optional SMALLINT(3) NOT NULL DEFAULT 0,
    revision VARCHAR(1333) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    summary LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    summaryformat SMALLINT(3) NOT NULL,
    content LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    contentformat SMALLINT(3) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_toolpolivers_use2_fk FOREIGN KEY (usermodified) REFERENCES mdl_user (id),
CONSTRAINT mdl_toolpolivers_pol2_fk FOREIGN KEY (policyid) REFERENCES mdl_tool_policy (id)
, KEY mdl_toolpolivers_use4_ix (usermodified)
, KEY mdl_toolpolivers_pol4_ix (policyid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Holds versions of the policy documents'; CREATE TABLE mdl_tool_policy_acceptances (
    id BIGINT(10) NOT NULL auto_increment,
    policyversionid BIGINT(10) NOT NULL,
    userid BIGINT(10) NOT NULL,
    status TINYINT(1),
    lang VARCHAR(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    usermodified BIGINT(10) NOT NULL,
    timecreated BIGINT(10) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
    note LONGTEXT COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_toolpoliacce_pol2_fk FOREIGN KEY (policyversionid) REFERENCES mdl_tool_policy_versions (id),
CONSTRAINT mdl_toolpoliacce_use3_fk FOREIGN KEY (userid) REFERENCES mdl_user (id),
CONSTRAINT mdl_toolpoliacce_use4_fk FOREIGN KEY (usermodified) REFERENCES mdl_user (id)
, KEY mdl_toolpoliacce_pol4_ix (policyversionid)
, KEY mdl_toolpoliacce_use6_ix (userid)
, KEY mdl_toolpoliacce_use8_ix (usermodified)
, UNIQUE KEY mdl_toolpoliacce_poluse2_uix (policyversionid, userid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Tracks users accepting the policy versions'; CREATE TABLE mdl_tool_recyclebin_course (
    id BIGINT(10) NOT NULL auto_increment,
    courseid BIGINT(10) NOT NULL,
    section BIGINT(10) NOT NULL,
    module BIGINT(10) NOT NULL,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    timecreated BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_toolrecycour_cou2_fk FOREIGN KEY (courseid) REFERENCES mdl_course (id)
, KEY mdl_toolrecycour_tim2_ix (timecreated)
, KEY mdl_toolrecycour_cou4_ix (courseid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='A list of items in the course recycle bin'; CREATE TABLE mdl_tool_recyclebin_category (
    id BIGINT(10) NOT NULL auto_increment,
    categoryid BIGINT(10) NOT NULL,
    shortname VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    fullname VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    timecreated BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_toolrecycate_cat2_fk FOREIGN KEY (categoryid) REFERENCES mdl_course_categories (id)
, KEY mdl_toolrecycate_tim2_ix (timecreated)
, KEY mdl_toolrecycate_cat4_ix (categoryid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='A list of items in the category recycle bin'; CREATE TABLE mdl_tool_usertours_tours (
    id BIGINT(10) NOT NULL auto_increment,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    description LONGTEXT COLLATE utf8mb4_unicode_ci,
    pathmatch VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    enabled TINYINT(1) NOT NULL DEFAULT 0,
    sortorder BIGINT(10) NOT NULL DEFAULT 0,
    configdata LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
CONSTRAINT  PRIMARY KEY (id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='List of tours'; CREATE TABLE mdl_tool_usertours_steps (
    id BIGINT(10) NOT NULL auto_increment,
    tourid BIGINT(10) NOT NULL,
    title LONGTEXT COLLATE utf8mb4_unicode_ci,
    content LONGTEXT COLLATE utf8mb4_unicode_ci,
    targettype TINYINT(2) NOT NULL,
    targetvalue LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    sortorder BIGINT(10) NOT NULL DEFAULT 0,
    configdata LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_tooluserstep_tou2_fk FOREIGN KEY (tourid) REFERENCES mdl_tool_usertours_tours (id)
, KEY mdl_tooluserstep_tousor2_ix (tourid, sortorder)
, KEY mdl_tooluserstep_tou4_ix (tourid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Steps in an tour'; CREATE TABLE mdl_editor_atto_autosave (
    id BIGINT(10) NOT NULL auto_increment,
    elementid VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    contextid BIGINT(10) NOT NULL,
    pagehash VARCHAR(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    userid BIGINT(10) NOT NULL,
    drafttext LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    draftid BIGINT(10),
    pageinstance VARCHAR(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY mdl_editattoauto_eleconus2_uix (elementid, contextid, userid, pagehash)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Draft text that is auto-saved every 5 seconds while an edito'; CREATE TABLE mdl_message_airnotifier_devices (
    id BIGINT(10) NOT NULL auto_increment,
    userdeviceid BIGINT(10) NOT NULL,
    enable TINYINT(1) NOT NULL DEFAULT 1,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_messairndevi_use_fk FOREIGN KEY (userdeviceid) REFERENCES mdl_user_devices (id)
, UNIQUE KEY mdl_messairndevi_use2_uix (userdeviceid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Store information about the devices registered in Airnotifie'; CREATE TABLE mdl_message_email_messages (
    id BIGINT(10) NOT NULL auto_increment,
    useridto BIGINT(10) NOT NULL,
    conversationid BIGINT(10) NOT NULL,
    messageid BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_messemaimess_use2_fk FOREIGN KEY (useridto) REFERENCES mdl_user (id),
CONSTRAINT mdl_messemaimess_con2_fk FOREIGN KEY (conversationid) REFERENCES mdl_message_conversations (id),
CONSTRAINT mdl_messemaimess_mes2_fk FOREIGN KEY (messageid) REFERENCES mdl_messages (id)
, KEY mdl_messemaimess_use4_ix (useridto)
, KEY mdl_messemaimess_con4_ix (conversationid)
, KEY mdl_messemaimess_mes4_ix (messageid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Keeps track of what emails to send in an email digest'; CREATE TABLE mdl_message_popup (
    id BIGINT(10) NOT NULL auto_increment,
    messageid BIGINT(10) NOT NULL,
    isread TINYINT(1) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY mdl_messpopu_mesisr2_uix (messageid, isread)
, KEY mdl_messpopu_isr2_ix (isread)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Keep state of notifications for the popup message processor'; CREATE TABLE mdl_message_popup_notifications (
    id BIGINT(10) NOT NULL auto_increment,
    notificationid BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_messpopunoti_not2_fk FOREIGN KEY (notificationid) REFERENCES mdl_notifications (id)
, KEY mdl_messpopunoti_not4_ix (notificationid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='List of notifications to display in the message output popup'; CREATE TABLE mdl_mnetservice_enrol_courses (
    id BIGINT(10) NOT NULL auto_increment,
    hostid BIGINT(10) NOT NULL,
    remoteid BIGINT(10) NOT NULL,
    categoryid BIGINT(10) NOT NULL,
    categoryname VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    sortorder BIGINT(10) NOT NULL DEFAULT 0,
    fullname VARCHAR(254) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    shortname VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    idnumber VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    summary LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    summaryformat SMALLINT(3) DEFAULT 0,
    startdate BIGINT(10) NOT NULL,
    roleid BIGINT(10) NOT NULL,
    rolename VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY mdl_mnetenrocour_hosrem2_uix (hostid, remoteid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Caches the information fetched via XML-RPC about courses on '; CREATE TABLE mdl_mnetservice_enrol_enrolments (
    id BIGINT(10) NOT NULL auto_increment,
    hostid BIGINT(10) NOT NULL,
    userid BIGINT(10) NOT NULL,
    remotecourseid BIGINT(10) NOT NULL,
    rolename VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    enroltime BIGINT(10) NOT NULL DEFAULT 0,
    enroltype VARCHAR(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_mnetenroenro_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id),
CONSTRAINT mdl_mnetenroenro_hos2_fk FOREIGN KEY (hostid) REFERENCES mdl_mnet_host (id)
, KEY mdl_mnetenroenro_use4_ix (userid)
, KEY mdl_mnetenroenro_hos4_ix (hostid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Caches the information about enrolments of our local users i'; CREATE TABLE mdl_qtype_algebra_options (
    id BIGINT(10) NOT NULL auto_increment,
    questionid BIGINT(10) NOT NULL DEFAULT 0,
    compareby VARCHAR(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'evaluated',
    nchecks BIGINT(10) NOT NULL DEFAULT 10,
    tolerance DOUBLE NOT NULL,
    disallow LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    allowedfuncs LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    answerprefix LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_qtypalgeopti_que2_fk FOREIGN KEY (questionid) REFERENCES mdl_question (id)
, KEY mdl_qtypalgeopti_que4_ix (questionid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Options for algebra questions'; CREATE TABLE mdl_qtype_algebra_variables (
    id BIGINT(10) NOT NULL auto_increment,
    questionid BIGINT(10) NOT NULL DEFAULT 0,
    name VARCHAR(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    min VARCHAR(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '-',
    max VARCHAR(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '-',
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_qtypalgevari_que2_fk FOREIGN KEY (questionid) REFERENCES mdl_question (id)
, KEY mdl_qtypalgevari_que4_ix (questionid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Variables for algebra questions'; CREATE TABLE mdl_question_calculated (
    id BIGINT(10) NOT NULL auto_increment,
    question BIGINT(10) NOT NULL DEFAULT 0,
    answer BIGINT(10) NOT NULL DEFAULT 0,
    tolerance VARCHAR(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0.0',
    tolerancetype BIGINT(10) NOT NULL DEFAULT 1,
    correctanswerlength BIGINT(10) NOT NULL DEFAULT 2,
    correctanswerformat BIGINT(10) NOT NULL DEFAULT 2,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_quescalc_que2_fk FOREIGN KEY (question) REFERENCES mdl_question (id)
, KEY mdl_quescalc_ans2_ix (answer)
, KEY mdl_quescalc_que4_ix (question)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Options for questions of type calculated'; CREATE TABLE mdl_question_calculated_options (
    id BIGINT(10) NOT NULL auto_increment,
    question BIGINT(10) NOT NULL DEFAULT 0,
    synchronize TINYINT(2) NOT NULL DEFAULT 0,
    single SMALLINT(4) NOT NULL DEFAULT 0,
    shuffleanswers SMALLINT(4) NOT NULL DEFAULT 0,
    correctfeedback LONGTEXT COLLATE utf8mb4_unicode_ci,
    correctfeedbackformat TINYINT(2) NOT NULL DEFAULT 0,
    partiallycorrectfeedback LONGTEXT COLLATE utf8mb4_unicode_ci,
    partiallycorrectfeedbackformat TINYINT(2) NOT NULL DEFAULT 0,
    incorrectfeedback LONGTEXT COLLATE utf8mb4_unicode_ci,
    incorrectfeedbackformat TINYINT(2) NOT NULL DEFAULT 0,
    answernumbering VARCHAR(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'abc',
    shownumcorrect TINYINT(2) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_quescalcopti_que2_fk FOREIGN KEY (question) REFERENCES mdl_question (id)
, KEY mdl_quescalcopti_que4_ix (question)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Options for questions of type calculated'; CREATE TABLE mdl_question_dataset_definitions (
    id BIGINT(10) NOT NULL auto_increment,
    category BIGINT(10) NOT NULL DEFAULT 0,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    type BIGINT(10) NOT NULL DEFAULT 0,
    options VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    itemcount BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_quesdatadefi_cat2_fk FOREIGN KEY (category) REFERENCES mdl_question_categories (id)
, KEY mdl_quesdatadefi_cat4_ix (category)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Organises and stores properties for dataset items'; CREATE TABLE mdl_question_dataset_items (
    id BIGINT(10) NOT NULL auto_increment,
    definition BIGINT(10) NOT NULL DEFAULT 0,
    itemnumber BIGINT(10) NOT NULL DEFAULT 0,
    value VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_quesdataitem_def2_ix (definition)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Individual dataset items'; CREATE TABLE mdl_question_datasets (
    id BIGINT(10) NOT NULL auto_increment,
    question BIGINT(10) NOT NULL DEFAULT 0,
    datasetdefinition BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_quesdata_que2_fk FOREIGN KEY (question) REFERENCES mdl_question (id),
CONSTRAINT mdl_quesdata_dat2_fk FOREIGN KEY (datasetdefinition) REFERENCES mdl_question_dataset_definitions (id)
, KEY mdl_quesdata_quedat2_ix (question, datasetdefinition)
, KEY mdl_quesdata_que4_ix (question)
, KEY mdl_quesdata_dat4_ix (datasetdefinition)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Many-many relation between questions and dataset definitions'; CREATE TABLE mdl_qtype_ddimageortext (
    id BIGINT(10) NOT NULL auto_increment,
    questionid BIGINT(10) NOT NULL DEFAULT 0,
    shuffleanswers SMALLINT(4) NOT NULL DEFAULT 1,
    correctfeedback LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    correctfeedbackformat TINYINT(2) NOT NULL DEFAULT 0,
    partiallycorrectfeedback LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    partiallycorrectfeedbackformat TINYINT(2) NOT NULL DEFAULT 0,
    incorrectfeedback LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    incorrectfeedbackformat TINYINT(2) NOT NULL DEFAULT 0,
    shownumcorrect TINYINT(2) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_qtypddim_que2_fk FOREIGN KEY (questionid) REFERENCES mdl_question (id)
, KEY mdl_qtypddim_que4_ix (questionid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Defines drag and drop (text or images onto a background imag'; CREATE TABLE mdl_qtype_ddimageortext_drops (
    id BIGINT(10) NOT NULL auto_increment,
    questionid BIGINT(10) NOT NULL DEFAULT 0,
    no BIGINT(10) NOT NULL DEFAULT 0,
    xleft BIGINT(10) NOT NULL DEFAULT 0,
    ytop BIGINT(10) NOT NULL DEFAULT 0,
    choice BIGINT(10) NOT NULL DEFAULT 0,
    label LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_qtypddimdrop_que2_fk FOREIGN KEY (questionid) REFERENCES mdl_question (id)
, KEY mdl_qtypddimdrop_que4_ix (questionid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Drop boxes'; CREATE TABLE mdl_qtype_ddimageortext_drags (
    id BIGINT(10) NOT NULL auto_increment,
    questionid BIGINT(10) NOT NULL DEFAULT 0,
    no BIGINT(10) NOT NULL DEFAULT 0,
    draggroup BIGINT(10) NOT NULL DEFAULT 0,
    infinite SMALLINT(4) NOT NULL DEFAULT 0,
    label LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_qtypddimdrag_que2_fk FOREIGN KEY (questionid) REFERENCES mdl_question (id)
, KEY mdl_qtypddimdrag_que4_ix (questionid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Images to drag. Actual file names are not stored here we use'; CREATE TABLE mdl_qtype_ddmarker (
    id BIGINT(10) NOT NULL auto_increment,
    questionid BIGINT(10) NOT NULL DEFAULT 0,
    shuffleanswers SMALLINT(4) NOT NULL DEFAULT 1,
    correctfeedback LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    correctfeedbackformat TINYINT(2) NOT NULL DEFAULT 0,
    partiallycorrectfeedback LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    partiallycorrectfeedbackformat TINYINT(2) NOT NULL DEFAULT 0,
    incorrectfeedback LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    incorrectfeedbackformat TINYINT(2) NOT NULL DEFAULT 0,
    shownumcorrect TINYINT(2) NOT NULL DEFAULT 0,
    showmisplaced SMALLINT(4) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_qtypddma_que2_fk FOREIGN KEY (questionid) REFERENCES mdl_question (id)
, KEY mdl_qtypddma_que4_ix (questionid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Defines drag and drop (text or images onto a background imag'; CREATE TABLE mdl_qtype_ddmarker_drops (
    id BIGINT(10) NOT NULL auto_increment,
    questionid BIGINT(10) NOT NULL DEFAULT 0,
    no BIGINT(10) NOT NULL DEFAULT 0,
    shape VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    coords LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    choice BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_qtypddmadrop_que2_fk FOREIGN KEY (questionid) REFERENCES mdl_question (id)
, KEY mdl_qtypddmadrop_que4_ix (questionid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='drop regions'; CREATE TABLE mdl_qtype_ddmarker_drags (
    id BIGINT(10) NOT NULL auto_increment,
    questionid BIGINT(10) NOT NULL DEFAULT 0,
    no BIGINT(10) NOT NULL DEFAULT 0,
    label LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    infinite SMALLINT(4) NOT NULL DEFAULT 0,
    noofdrags BIGINT(10) NOT NULL DEFAULT 1,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_qtypddmadrag_que2_fk FOREIGN KEY (questionid) REFERENCES mdl_question (id)
, KEY mdl_qtypddmadrag_que4_ix (questionid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Labels for markers to drag.'; CREATE TABLE mdl_question_ddwtos (
    id BIGINT(10) NOT NULL auto_increment,
    questionid BIGINT(10) NOT NULL DEFAULT 0,
    shuffleanswers SMALLINT(4) NOT NULL DEFAULT 1,
    correctfeedback LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    correctfeedbackformat TINYINT(2) NOT NULL DEFAULT 0,
    partiallycorrectfeedback LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    partiallycorrectfeedbackformat TINYINT(2) NOT NULL DEFAULT 0,
    incorrectfeedback LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    incorrectfeedbackformat TINYINT(2) NOT NULL DEFAULT 0,
    shownumcorrect TINYINT(2) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_quesddwt_que2_fk FOREIGN KEY (questionid) REFERENCES mdl_question (id)
, KEY mdl_quesddwt_que4_ix (questionid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Defines drag and drop (words into sentences) questions'; CREATE TABLE mdl_qtype_essay_options (
    id BIGINT(10) NOT NULL auto_increment,
    questionid BIGINT(10) NOT NULL,
    responseformat VARCHAR(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'editor',
    responserequired TINYINT(2) NOT NULL DEFAULT 1,
    responsefieldlines SMALLINT(4) NOT NULL DEFAULT 15,
    attachments SMALLINT(4) NOT NULL DEFAULT 0,
    attachmentsrequired SMALLINT(4) NOT NULL DEFAULT 0,
    graderinfo LONGTEXT COLLATE utf8mb4_unicode_ci,
    graderinfoformat SMALLINT(4) NOT NULL DEFAULT 0,
    responsetemplate LONGTEXT COLLATE utf8mb4_unicode_ci,
    responsetemplateformat SMALLINT(4) NOT NULL DEFAULT 0,
    filetypeslist LONGTEXT COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_qtypessaopti_que_fk FOREIGN KEY (questionid) REFERENCES mdl_question (id)
, UNIQUE KEY mdl_qtypessaopti_que2_uix (questionid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Extra options for essay questions.'; CREATE TABLE mdl_question_gapfill (
    id BIGINT(10) NOT NULL auto_increment,
    question BIGINT(10) NOT NULL DEFAULT 0,
    answerdisplay VARCHAR(20) COLLATE utf8mb4_unicode_ci,
    delimitchars VARCHAR(2) COLLATE utf8mb4_unicode_ci DEFAULT '[]',
    casesensitive TINYINT(1) DEFAULT 0,
    noduplicates TINYINT(1) DEFAULT 0,
    disableregex TINYINT(1) DEFAULT 0,
    fixedgapsize TINYINT(1) DEFAULT 1,
    optionsaftertext TINYINT(1) DEFAULT 0,
    letterhints TINYINT(1) DEFAULT 0,
    correctfeedback LONGTEXT COLLATE utf8mb4_unicode_ci,
    correctfeedbackformat TINYINT(2) DEFAULT 0,
    partiallycorrectfeedback LONGTEXT COLLATE utf8mb4_unicode_ci,
    partiallycorrectfeedbackformat TINYINT(2) DEFAULT 0,
    incorrectfeedback LONGTEXT COLLATE utf8mb4_unicode_ci,
    incorrectfeedbackformat TINYINT(2) DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_quesgapf_que2_fk FOREIGN KEY (question) REFERENCES mdl_question (id)
, KEY mdl_quesgapf_que4_ix (question)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Options for gapfill questions'; CREATE TABLE mdl_question_gapfill_settings (
    id BIGINT(10) NOT NULL auto_increment,
    question BIGINT(10),
    itemid LONGTEXT COLLATE utf8mb4_unicode_ci,
    gaptext LONGTEXT COLLATE utf8mb4_unicode_ci,
    correctfeedback LONGTEXT COLLATE utf8mb4_unicode_ci,
    incorrectfeedback LONGTEXT COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_quesgapfsett_que2_fk FOREIGN KEY (question) REFERENCES mdl_question (id)
, KEY mdl_quesgapfsett_que4_ix (question)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='per gap settings for the gapfill question type'; CREATE TABLE mdl_question_gapselect (
    id BIGINT(10) NOT NULL auto_increment,
    questionid BIGINT(10) NOT NULL DEFAULT 0,
    shuffleanswers SMALLINT(4) NOT NULL DEFAULT 1,
    correctfeedback LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    correctfeedbackformat TINYINT(2) NOT NULL DEFAULT 0,
    partiallycorrectfeedback LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    partiallycorrectfeedbackformat TINYINT(2) NOT NULL DEFAULT 0,
    incorrectfeedback LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    incorrectfeedbackformat TINYINT(2) NOT NULL DEFAULT 0,
    shownumcorrect TINYINT(2) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_quesgaps_que2_fk FOREIGN KEY (questionid) REFERENCES mdl_question (id)
, KEY mdl_quesgaps_que4_ix (questionid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Defines select missing words questions'; CREATE TABLE mdl_question_imageselect (
    id BIGINT(10) NOT NULL auto_increment,
    questionid BIGINT(10) NOT NULL DEFAULT 0,
    correctfeedback LONGTEXT COLLATE utf8mb4_unicode_ci,
    correctfeedbackformat TINYINT(2) DEFAULT 0,
    partiallycorrectfeedback LONGTEXT COLLATE utf8mb4_unicode_ci,
    partiallycorrectfeedbackformat TINYINT(2) DEFAULT 0,
    incorrectfeedback LONGTEXT COLLATE utf8mb4_unicode_ci,
    incorrectfeedbackformat TINYINT(2) DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_quesimag_que2_fk FOREIGN KEY (questionid) REFERENCES mdl_question (id)
, KEY mdl_quesimag_que4_ix (questionid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='options for the overall question'; CREATE TABLE mdl_question_imageselect_images (
    id BIGINT(10) NOT NULL auto_increment,
    questionid BIGINT(10) NOT NULL DEFAULT 0,
    no BIGINT(10) NOT NULL DEFAULT 0,
    infinite SMALLINT(4) NOT NULL DEFAULT 0,
    label LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_quesimagimag_que2_fk FOREIGN KEY (questionid) REFERENCES mdl_question (id)
, KEY mdl_quesimagimag_que4_ix (questionid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Images to select. Actual file names are not stored here we u'; CREATE TABLE mdl_qtype_match_options (
    id BIGINT(10) NOT NULL auto_increment,
    questionid BIGINT(10) NOT NULL DEFAULT 0,
    shuffleanswers SMALLINT(4) NOT NULL DEFAULT 1,
    correctfeedback LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    correctfeedbackformat TINYINT(2) NOT NULL DEFAULT 0,
    partiallycorrectfeedback LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    partiallycorrectfeedbackformat TINYINT(2) NOT NULL DEFAULT 0,
    incorrectfeedback LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    incorrectfeedbackformat TINYINT(2) NOT NULL DEFAULT 0,
    shownumcorrect TINYINT(2) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_qtypmatcopti_que_fk FOREIGN KEY (questionid) REFERENCES mdl_question (id)
, UNIQUE KEY mdl_qtypmatcopti_que2_uix (questionid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Defines the question-type specific options for matching ques'; CREATE TABLE mdl_qtype_match_subquestions (
    id BIGINT(10) NOT NULL auto_increment,
    questionid BIGINT(10) NOT NULL DEFAULT 0,
    questiontext LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    questiontextformat TINYINT(2) NOT NULL DEFAULT 0,
    answertext VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_qtypmatcsubq_que2_fk FOREIGN KEY (questionid) REFERENCES mdl_question (id)
, KEY mdl_qtypmatcsubq_que4_ix (questionid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='The subquestions that make up a matching question'; CREATE TABLE mdl_question_multianswer (
    id BIGINT(10) NOT NULL auto_increment,
    question BIGINT(10) NOT NULL DEFAULT 0,
    sequence LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_quesmult_que2_fk FOREIGN KEY (question) REFERENCES mdl_question (id)
, KEY mdl_quesmult_que4_ix (question)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Options for multianswer questions'; CREATE TABLE mdl_qtype_multichoice_options (
    id BIGINT(10) NOT NULL auto_increment,
    questionid BIGINT(10) NOT NULL DEFAULT 0,
    layout SMALLINT(4) NOT NULL DEFAULT 0,
    single SMALLINT(4) NOT NULL DEFAULT 0,
    shuffleanswers SMALLINT(4) NOT NULL DEFAULT 1,
    correctfeedback LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    correctfeedbackformat TINYINT(2) NOT NULL DEFAULT 0,
    partiallycorrectfeedback LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    partiallycorrectfeedbackformat TINYINT(2) NOT NULL DEFAULT 0,
    incorrectfeedback LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    incorrectfeedbackformat TINYINT(2) NOT NULL DEFAULT 0,
    answernumbering VARCHAR(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'abc',
    shownumcorrect TINYINT(2) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_qtypmultopti_que_fk FOREIGN KEY (questionid) REFERENCES mdl_question (id)
, UNIQUE KEY mdl_qtypmultopti_que2_uix (questionid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Options for multiple choice questions'; CREATE TABLE mdl_question_numerical (
    id BIGINT(10) NOT NULL auto_increment,
    question BIGINT(10) NOT NULL DEFAULT 0,
    answer BIGINT(10) NOT NULL DEFAULT 0,
    tolerance VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0.0',
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_quesnume_que2_fk FOREIGN KEY (question) REFERENCES mdl_question (id)
, KEY mdl_quesnume_ans2_ix (answer)
, KEY mdl_quesnume_que4_ix (question)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Options for numerical questions.'; CREATE TABLE mdl_question_numerical_options (
    id BIGINT(10) NOT NULL auto_increment,
    question BIGINT(10) NOT NULL DEFAULT 0,
    showunits SMALLINT(4) NOT NULL DEFAULT 0,
    unitsleft SMALLINT(4) NOT NULL DEFAULT 0,
    unitgradingtype SMALLINT(4) NOT NULL DEFAULT 0,
    unitpenalty NUMERIC(12,7) NOT NULL DEFAULT 0.1,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_quesnumeopti_que2_fk FOREIGN KEY (question) REFERENCES mdl_question (id)
, KEY mdl_quesnumeopti_que4_ix (question)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Options for questions of type numerical This table is also u'; CREATE TABLE mdl_question_numerical_units (
    id BIGINT(10) NOT NULL auto_increment,
    question BIGINT(10) NOT NULL DEFAULT 0,
    multiplier NUMERIC(38,19) NOT NULL DEFAULT 1.00000000000000000000,
    unit VARCHAR(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_quesnumeunit_que2_fk FOREIGN KEY (question) REFERENCES mdl_question (id)
, UNIQUE KEY mdl_quesnumeunit_queuni2_uix (question, unit)
, KEY mdl_quesnumeunit_que4_ix (question)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Optional unit options for numerical questions. This table is'; CREATE TABLE mdl_qtype_randomsamatch_options (
    id BIGINT(10) NOT NULL auto_increment,
    questionid BIGINT(10) NOT NULL DEFAULT 0,
    choose BIGINT(10) NOT NULL DEFAULT 4,
    subcats TINYINT(2) NOT NULL DEFAULT 1,
    correctfeedback LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    correctfeedbackformat TINYINT(2) NOT NULL DEFAULT 0,
    partiallycorrectfeedback LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    partiallycorrectfeedbackformat TINYINT(2) NOT NULL DEFAULT 0,
    incorrectfeedback LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    incorrectfeedbackformat TINYINT(2) NOT NULL DEFAULT 0,
    shownumcorrect TINYINT(2) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_qtyprandopti_que_fk FOREIGN KEY (questionid) REFERENCES mdl_question (id)
, UNIQUE KEY mdl_qtyprandopti_que2_uix (questionid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Info about a random short-answer matching question'; CREATE TABLE mdl_qtype_shortanswer_options (
    id BIGINT(10) NOT NULL auto_increment,
    questionid BIGINT(10) NOT NULL DEFAULT 0,
    usecase TINYINT(2) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_qtypshoropti_que_fk FOREIGN KEY (questionid) REFERENCES mdl_question (id)
, UNIQUE KEY mdl_qtypshoropti_que2_uix (questionid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Options for short answer questions'; CREATE TABLE mdl_question_truefalse (
    id BIGINT(10) NOT NULL auto_increment,
    question BIGINT(10) NOT NULL DEFAULT 0,
    trueanswer BIGINT(10) NOT NULL DEFAULT 0,
    falseanswer BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_questrue_que2_fk FOREIGN KEY (question) REFERENCES mdl_question (id)
, KEY mdl_questrue_que4_ix (question)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Options for True-False questions'; CREATE TABLE mdl_question_wordselect (
    id BIGINT(10) NOT NULL auto_increment,
    questionid BIGINT(10) NOT NULL DEFAULT 0,
    introduction LONGTEXT COLLATE utf8mb4_unicode_ci,
    delimitchars VARCHAR(2) COLLATE utf8mb4_unicode_ci DEFAULT '[]',
    wordpenalty NUMERIC(12,7) NOT NULL DEFAULT 1.0000000,
    correctfeedback LONGTEXT COLLATE utf8mb4_unicode_ci,
    correctfeedbackformat TINYINT(2) DEFAULT 0,
    partiallycorrectfeedback LONGTEXT COLLATE utf8mb4_unicode_ci,
    partiallycorrectfeedbackformat TINYINT(2) DEFAULT 0,
    incorrectfeedback LONGTEXT COLLATE utf8mb4_unicode_ci,
    incorrectfeedbackformat TINYINT(2) DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_quesword_que2_fk FOREIGN KEY (questionid) REFERENCES mdl_question (id)
, KEY mdl_quesword_que4_ix (questionid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Options for wordselect questions'; CREATE TABLE mdl_search_simpledb_index (
    id BIGINT(10) NOT NULL auto_increment,
    docid VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    itemid BIGINT(10) NOT NULL,
    title LONGTEXT COLLATE utf8mb4_unicode_ci,
    content LONGTEXT COLLATE utf8mb4_unicode_ci,
    contextid BIGINT(10) NOT NULL,
    areaid VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    type TINYINT(1) NOT NULL,
    courseid BIGINT(10) NOT NULL,
    owneruserid BIGINT(10),
    modified BIGINT(10) NOT NULL,
    userid BIGINT(10),
    description1 LONGTEXT COLLATE utf8mb4_unicode_ci,
    description2 LONGTEXT COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id)
, KEY mdl_searsimpinde_owncon2_ix (owneruserid, contextid)
, UNIQUE KEY mdl_searsimpinde_doc2_uix (docid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='search_simpledb table containing the index data.'; CREATE TABLE mdl_gradingform_guide_criteria (
    id BIGINT(10) NOT NULL auto_increment,
    definitionid BIGINT(10) NOT NULL,
    sortorder BIGINT(10) NOT NULL,
    shortname VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    description LONGTEXT COLLATE utf8mb4_unicode_ci,
    descriptionformat TINYINT(2),
    descriptionmarkers LONGTEXT COLLATE utf8mb4_unicode_ci,
    descriptionmarkersformat TINYINT(2),
    maxscore NUMERIC(10,5) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_gradguidcrit_def2_fk FOREIGN KEY (definitionid) REFERENCES mdl_grading_definitions (id)
, KEY mdl_gradguidcrit_def4_ix (definitionid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stores the rows of the criteria grid.'; CREATE TABLE mdl_gradingform_guide_fillings (
    id BIGINT(10) NOT NULL auto_increment,
    instanceid BIGINT(10) NOT NULL,
    criterionid BIGINT(10) NOT NULL,
    remark LONGTEXT COLLATE utf8mb4_unicode_ci,
    remarkformat TINYINT(2),
    score NUMERIC(10,5) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_gradguidfill_ins2_fk FOREIGN KEY (instanceid) REFERENCES mdl_grading_instances (id),
CONSTRAINT mdl_gradguidfill_cri2_fk FOREIGN KEY (criterionid) REFERENCES mdl_gradingform_guide_criteria (id)
, KEY mdl_gradguidfill_ins4_ix (instanceid)
, KEY mdl_gradguidfill_cri4_ix (criterionid)
, UNIQUE KEY mdl_gradguidfill_inscri2_uix (instanceid, criterionid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stores the data of how the guide is filled by a particular r'; CREATE TABLE mdl_gradingform_guide_comments (
    id BIGINT(10) NOT NULL auto_increment,
    definitionid BIGINT(10) NOT NULL,
    sortorder BIGINT(10) NOT NULL,
    description LONGTEXT COLLATE utf8mb4_unicode_ci,
    descriptionformat TINYINT(2),
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_gradguidcomm_def2_fk FOREIGN KEY (definitionid) REFERENCES mdl_grading_definitions (id)
, KEY mdl_gradguidcomm_def4_ix (definitionid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='frequently used comments used in marking guide'; CREATE TABLE mdl_gradingform_pfrbric_criteria (
    id BIGINT(10) NOT NULL auto_increment,
    definitionid BIGINT(10) NOT NULL,
    sortorder BIGINT(10) NOT NULL,
    description LONGTEXT COLLATE utf8mb4_unicode_ci,
    descriptionformat TINYINT(2),
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_gradpfrbcrit_def2_fk FOREIGN KEY (definitionid) REFERENCES mdl_grading_definitions (id)
, KEY mdl_gradpfrbcrit_def4_ix (definitionid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stores the rows of the rubric grid.'; CREATE TABLE mdl_gradingform_pfrbric_levels (
    id BIGINT(10) NOT NULL auto_increment,
    criterionid BIGINT(10) NOT NULL,
    definition LONGTEXT COLLATE utf8mb4_unicode_ci,
    definitionformat BIGINT(10),
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_gradpfrbleve_cri2_fk FOREIGN KEY (criterionid) REFERENCES mdl_gradingform_pfrbric_criteria (id)
, KEY mdl_gradpfrbleve_cri4_ix (criterionid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stores the columns of the rubric grid.'; CREATE TABLE mdl_gradingform_pfrbric_fillings (
    id BIGINT(10) NOT NULL auto_increment,
    instanceid BIGINT(10) NOT NULL,
    criterionid BIGINT(10) NOT NULL,
    levelid BIGINT(10),
    remark LONGTEXT COLLATE utf8mb4_unicode_ci,
    remarkformat TINYINT(2),
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_gradpfrbfill_ins2_fk FOREIGN KEY (instanceid) REFERENCES mdl_grading_instances (id),
CONSTRAINT mdl_gradpfrbfill_cri2_fk FOREIGN KEY (criterionid) REFERENCES mdl_gradingform_pfrbric_criteria (id)
, KEY mdl_gradpfrbfill_lev2_ix (levelid)
, KEY mdl_gradpfrbfill_ins4_ix (instanceid)
, KEY mdl_gradpfrbfill_cri4_ix (criterionid)
, UNIQUE KEY mdl_gradpfrbfill_inscri2_uix (instanceid, criterionid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stores the data of how the rubric is filled by a particular '; CREATE TABLE mdl_gradingform_pfrbric_grades (
    id BIGINT(10) NOT NULL auto_increment,
    instanceid BIGINT(10) NOT NULL,
    grade BIGINT(10) NOT NULL,
    explanation VARCHAR(256) COLLATE utf8mb4_unicode_ci,
    authoredby BIGINT(10),
    timemodified BIGINT(10),
    timecreated BIGINT(10),
    updatedby BIGINT(10),
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_gradpfrbgrad_ins2_fk FOREIGN KEY (instanceid) REFERENCES mdl_grading_instances (id)
, KEY mdl_gradpfrbgrad_ins4_ix (instanceid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stores the grade assigned to the grading instance'; CREATE TABLE mdl_gradingform_rubric_criteria (
    id BIGINT(10) NOT NULL auto_increment,
    definitionid BIGINT(10) NOT NULL,
    sortorder BIGINT(10) NOT NULL,
    description LONGTEXT COLLATE utf8mb4_unicode_ci,
    descriptionformat TINYINT(2),
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_gradrubrcrit_def2_fk FOREIGN KEY (definitionid) REFERENCES mdl_grading_definitions (id)
, KEY mdl_gradrubrcrit_def4_ix (definitionid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stores the rows of the rubric grid.'; CREATE TABLE mdl_gradingform_rubric_levels (
    id BIGINT(10) NOT NULL auto_increment,
    criterionid BIGINT(10) NOT NULL,
    score NUMERIC(10,5) NOT NULL,
    definition LONGTEXT COLLATE utf8mb4_unicode_ci,
    definitionformat BIGINT(10),
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_gradrubrleve_cri2_fk FOREIGN KEY (criterionid) REFERENCES mdl_gradingform_rubric_criteria (id)
, KEY mdl_gradrubrleve_cri4_ix (criterionid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stores the columns of the rubric grid.'; CREATE TABLE mdl_gradingform_rubric_fillings (
    id BIGINT(10) NOT NULL auto_increment,
    instanceid BIGINT(10) NOT NULL,
    criterionid BIGINT(10) NOT NULL,
    levelid BIGINT(10),
    remark LONGTEXT COLLATE utf8mb4_unicode_ci,
    remarkformat TINYINT(2),
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_gradrubrfill_ins2_fk FOREIGN KEY (instanceid) REFERENCES mdl_grading_instances (id),
CONSTRAINT mdl_gradrubrfill_cri2_fk FOREIGN KEY (criterionid) REFERENCES mdl_gradingform_rubric_criteria (id)
, KEY mdl_gradrubrfill_lev2_ix (levelid)
, KEY mdl_gradrubrfill_ins4_ix (instanceid)
, KEY mdl_gradrubrfill_cri4_ix (criterionid)
, UNIQUE KEY mdl_gradrubrfill_inscri2_uix (instanceid, criterionid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stores the data of how the rubric is filled by a particular '; CREATE TABLE mdl_assignfeedback_comments (
    id BIGINT(10) NOT NULL auto_increment,
    assignment BIGINT(10) NOT NULL DEFAULT 0,
    grade BIGINT(10) NOT NULL DEFAULT 0,
    commenttext LONGTEXT COLLATE utf8mb4_unicode_ci,
    commentformat SMALLINT(4) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_assicomm_ass2_fk FOREIGN KEY (assignment) REFERENCES mdl_assign (id),
CONSTRAINT mdl_assicomm_gra2_fk FOREIGN KEY (grade) REFERENCES mdl_assign_grades (id)
, KEY mdl_assicomm_ass4_ix (assignment)
, KEY mdl_assicomm_gra4_ix (grade)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Text feedback for submitted assignments'; CREATE TABLE mdl_assignfeedback_editpdf_cmnt (
    id BIGINT(10) NOT NULL auto_increment,
    gradeid BIGINT(10) NOT NULL DEFAULT 0,
    x BIGINT(10) DEFAULT 0,
    y BIGINT(10) DEFAULT 0,
    width BIGINT(10) DEFAULT 120,
    rawtext LONGTEXT COLLATE utf8mb4_unicode_ci,
    pageno BIGINT(10) NOT NULL DEFAULT 0,
    colour VARCHAR(10) COLLATE utf8mb4_unicode_ci DEFAULT 'black',
    draft TINYINT(2) NOT NULL DEFAULT 1,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_assieditcmnt_gra2_fk FOREIGN KEY (gradeid) REFERENCES mdl_assign_grades (id)
, KEY mdl_assieditcmnt_grapag2_ix (gradeid, pageno)
, KEY mdl_assieditcmnt_gra4_ix (gradeid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stores comments added to pdfs'; CREATE TABLE mdl_assignfeedback_editpdf_annot (
    id BIGINT(10) NOT NULL auto_increment,
    gradeid BIGINT(10) NOT NULL DEFAULT 0,
    pageno BIGINT(10) NOT NULL DEFAULT 0,
    x BIGINT(10) DEFAULT 0,
    y BIGINT(10) DEFAULT 0,
    endx BIGINT(10) DEFAULT 0,
    endy BIGINT(10) DEFAULT 0,
    path LONGTEXT COLLATE utf8mb4_unicode_ci,
    type VARCHAR(10) COLLATE utf8mb4_unicode_ci DEFAULT 'line',
    colour VARCHAR(10) COLLATE utf8mb4_unicode_ci DEFAULT 'black',
    draft TINYINT(2) NOT NULL DEFAULT 1,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_assieditanno_gra2_fk FOREIGN KEY (gradeid) REFERENCES mdl_assign_grades (id)
, KEY mdl_assieditanno_grapag2_ix (gradeid, pageno)
, KEY mdl_assieditanno_gra4_ix (gradeid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='stores annotations added to pdfs submitted by students'; CREATE TABLE mdl_assignfeedback_editpdf_quick (
    id BIGINT(10) NOT NULL auto_increment,
    userid BIGINT(10) NOT NULL DEFAULT 0,
    rawtext LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    width BIGINT(10) NOT NULL DEFAULT 120,
    colour VARCHAR(10) COLLATE utf8mb4_unicode_ci DEFAULT 'yellow',
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_assieditquic_use2_fk FOREIGN KEY (userid) REFERENCES mdl_user (id)
, KEY mdl_assieditquic_use4_ix (userid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stores teacher specified quicklist comments'; CREATE TABLE mdl_assignfeedback_editpdf_queue (
    id BIGINT(10) NOT NULL auto_increment,
    submissionid BIGINT(10) NOT NULL,
    submissionattempt BIGINT(10) NOT NULL,
    attemptedconversions BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY mdl_assieditqueu_subsub2_uix (submissionid, submissionattempt)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Queue for processing.'; CREATE TABLE mdl_assignfeedback_editpdf_rot (
    id BIGINT(10) NOT NULL auto_increment,
    gradeid BIGINT(10) NOT NULL DEFAULT 0,
    pageno BIGINT(10) NOT NULL DEFAULT 0,
    pathnamehash LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    isrotated TINYINT(1) NOT NULL DEFAULT 0,
    degree BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_assieditrot_gra2_fk FOREIGN KEY (gradeid) REFERENCES mdl_assign_grades (id)
, UNIQUE KEY mdl_assieditrot_grapag2_uix (gradeid, pageno)
, KEY mdl_assieditrot_gra4_ix (gradeid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stores rotation information of a page.'; CREATE TABLE mdl_assignfeedback_file (
    id BIGINT(10) NOT NULL auto_increment,
    assignment BIGINT(10) NOT NULL DEFAULT 0,
    grade BIGINT(10) NOT NULL DEFAULT 0,
    numfiles BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_assifile_ass2_fk FOREIGN KEY (assignment) REFERENCES mdl_assign (id),
CONSTRAINT mdl_assifile_gra2_fk FOREIGN KEY (grade) REFERENCES mdl_assign_grades (id)
, KEY mdl_assifile_ass4_ix (assignment)
, KEY mdl_assifile_gra4_ix (grade)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stores info about the number of files submitted by a student'; CREATE TABLE mdl_assignfeedback_structured (
    id BIGINT(10) NOT NULL auto_increment,
    assignment BIGINT(10) NOT NULL DEFAULT 0,
    grade BIGINT(10) NOT NULL DEFAULT 0,
    criterion SMALLINT(3) NOT NULL DEFAULT 0,
    commenttext LONGTEXT COLLATE utf8mb4_unicode_ci,
    commentformat TINYINT(1) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_assistru_ass2_fk FOREIGN KEY (assignment) REFERENCES mdl_assign (id),
CONSTRAINT mdl_assistru_gra2_fk FOREIGN KEY (grade) REFERENCES mdl_assign_grades (id)
, KEY mdl_assistru_ass4_ix (assignment)
, KEY mdl_assistru_gra4_ix (grade)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Structured feedback for submitted assignments'; CREATE TABLE mdl_assignfeedback_structured_cs (
    id BIGINT(10) NOT NULL auto_increment,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    name_lc VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    criteria LONGTEXT COLLATE utf8mb4_unicode_ci,
    owner BIGINT(10) NOT NULL DEFAULT 0,
    shared TINYINT(1) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_assistrucs_own2_fk FOREIGN KEY (owner) REFERENCES mdl_user (id)
, KEY mdl_assistrucs_nam2_ix (name_lc)
, KEY mdl_assistrucs_own4_ix (owner)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Structured feedback saved criteria sets'; CREATE TABLE mdl_assignsubmission_file (
    id BIGINT(10) NOT NULL auto_increment,
    assignment BIGINT(10) NOT NULL DEFAULT 0,
    submission BIGINT(10) NOT NULL DEFAULT 0,
    numfiles BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_assifile_ass6_fk FOREIGN KEY (assignment) REFERENCES mdl_assign (id),
CONSTRAINT mdl_assifile_sub2_fk FOREIGN KEY (submission) REFERENCES mdl_assign_submission (id)
, KEY mdl_assifile_ass8_ix (assignment)
, KEY mdl_assifile_sub4_ix (submission)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Info about file submissions for assignments'; CREATE TABLE mdl_assignsubmission_onlinetext (
    id BIGINT(10) NOT NULL auto_increment,
    assignment BIGINT(10) NOT NULL DEFAULT 0,
    submission BIGINT(10) NOT NULL DEFAULT 0,
    onlinetext LONGTEXT COLLATE utf8mb4_unicode_ci,
    onlineformat SMALLINT(4) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_assionli_ass2_fk FOREIGN KEY (assignment) REFERENCES mdl_assign (id),
CONSTRAINT mdl_assionli_sub2_fk FOREIGN KEY (submission) REFERENCES mdl_assign_submission (id)
, KEY mdl_assionli_ass4_ix (assignment)
, KEY mdl_assionli_sub4_ix (submission)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Info about onlinetext submission'; CREATE TABLE mdl_ltiservice_gradebookservices (
    id BIGINT(10) NOT NULL auto_increment,
    gradeitemid BIGINT(10) NOT NULL,
    courseid BIGINT(10) NOT NULL,
    toolproxyid BIGINT(10),
    typeid BIGINT(10),
    baseurl LONGTEXT COLLATE utf8mb4_unicode_ci,
    ltilinkid BIGINT(10),
    tag VARCHAR(255) COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_ltisgrad_lti2_fk FOREIGN KEY (ltilinkid) REFERENCES mdl_lti (id),
CONSTRAINT mdl_ltisgrad_gracou2_fk FOREIGN KEY (gradeitemid, courseid) REFERENCES mdl_grade_items (id, courseid)
, KEY mdl_ltisgrad_lti4_ix (ltilinkid)
, KEY mdl_ltisgrad_gracou4_ix (gradeitemid, courseid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='This file records the grade items created by the LTI Gradebo'; CREATE TABLE mdl_quiz_overview_regrades (
    id BIGINT(10) NOT NULL auto_increment,
    questionusageid BIGINT(10) NOT NULL,
    slot BIGINT(10) NOT NULL,
    newfraction NUMERIC(12,7),
    oldfraction NUMERIC(12,7),
    regraded SMALLINT(4) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_quizoverregr_queslo2_fk FOREIGN KEY (questionusageid, slot) REFERENCES mdl_question_attempts (questionusageid, slot)
, KEY mdl_quizoverregr_queslo4_ix (questionusageid, slot)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='This table records which question attempts need regrading an'; CREATE TABLE mdl_quiz_statistics (
    id BIGINT(10) NOT NULL auto_increment,
    hashcode VARCHAR(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    whichattempts SMALLINT(4) NOT NULL,
    timemodified BIGINT(10) NOT NULL,
    firstattemptscount BIGINT(10) NOT NULL,
    highestattemptscount BIGINT(10) NOT NULL,
    lastattemptscount BIGINT(10) NOT NULL,
    allattemptscount BIGINT(10) NOT NULL,
    firstattemptsavg NUMERIC(15,5),
    highestattemptsavg NUMERIC(15,5),
    lastattemptsavg NUMERIC(15,5),
    allattemptsavg NUMERIC(15,5),
    median NUMERIC(15,5),
    standarddeviation NUMERIC(15,5),
    skewness NUMERIC(15,10),
    kurtosis NUMERIC(15,5),
    cic NUMERIC(15,10),
    errorratio NUMERIC(15,10),
    standarderror NUMERIC(15,10),
CONSTRAINT  PRIMARY KEY (id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='table to cache results from analysis done in statistics repo'; CREATE TABLE mdl_workshopallocation_scheduled (
    id BIGINT(10) NOT NULL auto_increment,
    workshopid BIGINT(10) NOT NULL,
    enabled TINYINT(2) NOT NULL DEFAULT 0,
    submissionend BIGINT(10) NOT NULL,
    timeallocated BIGINT(10),
    settings LONGTEXT COLLATE utf8mb4_unicode_ci,
    resultstatus BIGINT(10),
    resultmessage VARCHAR(1333) COLLATE utf8mb4_unicode_ci,
    resultlog LONGTEXT COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_worksche_wor_fk FOREIGN KEY (workshopid) REFERENCES mdl_workshop (id)
, UNIQUE KEY mdl_worksche_wor2_uix (workshopid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Stores the allocation settings for the scheduled allocator'; CREATE TABLE mdl_workshopeval_best_settings (
    id BIGINT(10) NOT NULL auto_increment,
    workshopid BIGINT(10) NOT NULL,
    comparison SMALLINT(3) DEFAULT 5,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_workbestsett_wor_fk FOREIGN KEY (workshopid) REFERENCES mdl_workshop (id)
, UNIQUE KEY mdl_workbestsett_wor2_uix (workshopid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Settings for the grading evaluation subplugin Comparison wit'; CREATE TABLE mdl_workshopform_accumulative (
    id BIGINT(10) NOT NULL auto_increment,
    workshopid BIGINT(10) NOT NULL,
    sort BIGINT(10) DEFAULT 0,
    description LONGTEXT COLLATE utf8mb4_unicode_ci,
    descriptionformat SMALLINT(3) DEFAULT 0,
    grade BIGINT(10) NOT NULL,
    weight MEDIUMINT(5) DEFAULT 1,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_workaccu_wor2_fk FOREIGN KEY (workshopid) REFERENCES mdl_workshop (id)
, KEY mdl_workaccu_wor4_ix (workshopid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='The assessment dimensions definitions of Accumulative gradin'; CREATE TABLE mdl_workshopform_comments (
    id BIGINT(10) NOT NULL auto_increment,
    workshopid BIGINT(10) NOT NULL,
    sort BIGINT(10) DEFAULT 0,
    description LONGTEXT COLLATE utf8mb4_unicode_ci,
    descriptionformat SMALLINT(3) DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_workcomm_wor2_fk FOREIGN KEY (workshopid) REFERENCES mdl_workshop (id)
, KEY mdl_workcomm_wor4_ix (workshopid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='The assessment dimensions definitions of Comments strategy f'; CREATE TABLE mdl_workshopform_numerrors (
    id BIGINT(10) NOT NULL auto_increment,
    workshopid BIGINT(10) NOT NULL,
    sort BIGINT(10) DEFAULT 0,
    description LONGTEXT COLLATE utf8mb4_unicode_ci,
    descriptionformat SMALLINT(3) DEFAULT 0,
    descriptiontrust BIGINT(10),
    grade0 VARCHAR(50) COLLATE utf8mb4_unicode_ci,
    grade1 VARCHAR(50) COLLATE utf8mb4_unicode_ci,
    weight MEDIUMINT(5) DEFAULT 1,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_worknume_wor2_fk FOREIGN KEY (workshopid) REFERENCES mdl_workshop (id)
, KEY mdl_worknume_wor4_ix (workshopid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='The assessment dimensions definitions of Number of errors gr'; CREATE TABLE mdl_workshopform_numerrors_map (
    id BIGINT(10) NOT NULL auto_increment,
    workshopid BIGINT(10) NOT NULL,
    nonegative BIGINT(10) NOT NULL,
    grade NUMERIC(10,5) NOT NULL,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_worknumemap_wor2_fk FOREIGN KEY (workshopid) REFERENCES mdl_workshop (id)
, KEY mdl_worknumemap_wor4_ix (workshopid)
, UNIQUE KEY mdl_worknumemap_wornon2_uix (workshopid, nonegative)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='This maps the number of errors to a percentual grade for sub'; CREATE TABLE mdl_workshopform_rubric (
    id BIGINT(10) NOT NULL auto_increment,
    workshopid BIGINT(10) NOT NULL,
    sort BIGINT(10) DEFAULT 0,
    description LONGTEXT COLLATE utf8mb4_unicode_ci,
    descriptionformat SMALLINT(3) DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_workrubr_wor2_fk FOREIGN KEY (workshopid) REFERENCES mdl_workshop (id)
, KEY mdl_workrubr_wor4_ix (workshopid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='The assessment dimensions definitions of Rubric grading stra'; CREATE TABLE mdl_workshopform_rubric_levels (
    id BIGINT(10) NOT NULL auto_increment,
    dimensionid BIGINT(10) NOT NULL,
    grade NUMERIC(10,5) NOT NULL,
    definition LONGTEXT COLLATE utf8mb4_unicode_ci,
    definitionformat SMALLINT(3) DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_workrubrleve_dim2_fk FOREIGN KEY (dimensionid) REFERENCES mdl_workshopform_rubric (id)
, KEY mdl_workrubrleve_dim4_ix (dimensionid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='The definition of rubric rating scales'; CREATE TABLE mdl_workshopform_rubric_config (
    id BIGINT(10) NOT NULL auto_increment,
    workshopid BIGINT(10) NOT NULL,
    layout VARCHAR(30) COLLATE utf8mb4_unicode_ci DEFAULT 'list',
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY mdl_workrubrconf_wor2_uix (workshopid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Configuration table for the Rubric grading strategy'; CREATE TABLE mdl_logstore_standard_log (
    id BIGINT(10) NOT NULL auto_increment,
    eventname VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    component VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    action VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    target VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    objecttable VARCHAR(50) COLLATE utf8mb4_unicode_ci,
    objectid BIGINT(10),
    crud VARCHAR(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    edulevel TINYINT(1) NOT NULL,
    contextid BIGINT(10) NOT NULL,
    contextlevel BIGINT(10) NOT NULL,
    contextinstanceid BIGINT(10) NOT NULL,
    userid BIGINT(10) NOT NULL,
    courseid BIGINT(10),
    relateduserid BIGINT(10),
    anonymous TINYINT(1) NOT NULL DEFAULT 0,
    other LONGTEXT COLLATE utf8mb4_unicode_ci,
    timecreated BIGINT(10) NOT NULL,
    origin VARCHAR(10) COLLATE utf8mb4_unicode_ci,
    ip VARCHAR(45) COLLATE utf8mb4_unicode_ci,
    realuserid BIGINT(10),
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT mdl_logsstanlog_con2_fk FOREIGN KEY (contextid) REFERENCES mdl_context (id)
, KEY mdl_logsstanlog_tim2_ix (timecreated)
, KEY mdl_logsstanlog_couanotim2_ix (courseid, anonymous, timecreated)
, KEY mdl_logsstanlog_useconconc2_ix (userid, contextlevel, contextinstanceid, crud, edulevel, timecreated)
, KEY mdl_logsstanlog_con4_ix (contextid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Standard log table'