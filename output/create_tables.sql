/* Moodle version 2020110902 Release 3.10.2 (Build: 20210308) SQL code */
SET FOREIGN_KEY_CHECKS=0;
;
CREATE TABLE questionnaire (
    id BIGINT(10) NOT NULL auto_increment,
    course BIGINT(10) NOT NULL DEFAULT 0,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    intro LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    introformat SMALLINT(4) NOT NULL DEFAULT 0,
    qtype BIGINT(10) NOT NULL DEFAULT 0,
    respondenttype VARCHAR(9) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'fullname',
    resp_eligible VARCHAR(8) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'all',
    resp_view TINYINT(2) NOT NULL DEFAULT 0,
    notifications TINYINT(1) NOT NULL DEFAULT 0,
    opendate BIGINT(10) NOT NULL DEFAULT 0,
    closedate BIGINT(10) NOT NULL DEFAULT 0,
    resume TINYINT(2) NOT NULL DEFAULT 0,
    navigate TINYINT(2) NOT NULL DEFAULT 0,
    grade BIGINT(10) NOT NULL DEFAULT 0,
    sid BIGINT(10) NOT NULL DEFAULT 0,
    timemodified BIGINT(10) NOT NULL DEFAULT 0,
    completionsubmit TINYINT(1) NOT NULL DEFAULT 0,
    autonum TINYINT(1) NOT NULL DEFAULT 3,
    progressbar TINYINT(1) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT ques_sid2_fk FOREIGN KEY (sid) REFERENCES questionnaire_survey (id),
CONSTRAINT ques_cou2_fk FOREIGN KEY (course) REFERENCES course (id)
, KEY ques_res2_ix (resp_view)
, KEY ques_sid4_ix (sid)
, KEY ques_cou4_ix (course)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Main questionnaire table.';
CREATE TABLE questionnaire_survey (
    id BIGINT(10) NOT NULL auto_increment,
    name VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    courseid BIGINT(10),
    realm VARCHAR(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    status BIGINT(10) NOT NULL DEFAULT 0,
    title VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    email VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    subtitle LONGTEXT COLLATE utf8mb4_unicode_ci,
    info LONGTEXT COLLATE utf8mb4_unicode_ci,
    theme VARCHAR(64) COLLATE utf8mb4_unicode_ci,
    thanks_page VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    thank_head VARCHAR(255) COLLATE utf8mb4_unicode_ci,
    thank_body LONGTEXT COLLATE utf8mb4_unicode_ci,
    feedbacksections TINYINT(2) DEFAULT 0,
    feedbacknotes LONGTEXT COLLATE utf8mb4_unicode_ci,
    feedbackscores TINYINT(1) DEFAULT 0,
    chart_type VARCHAR(64) COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT quessurv_cou2_fk FOREIGN KEY (courseid) REFERENCES course (id)
, KEY quessurv_nam2_ix (name)
, KEY quessurv_cou4_ix (courseid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='questionnaire_survey table retrofitted from MySQL';
CREATE TABLE questionnaire_question (
    id BIGINT(10) NOT NULL auto_increment,
    surveyid BIGINT(10) NOT NULL DEFAULT 0,
    name VARCHAR(30) COLLATE utf8mb4_unicode_ci,
    type_id BIGINT(10) NOT NULL DEFAULT 0,
    result_id BIGINT(10),
    length BIGINT(10) NOT NULL DEFAULT 0,
    precise BIGINT(10) NOT NULL DEFAULT 0,
    position BIGINT(10) NOT NULL DEFAULT 0,
    content LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    required VARCHAR(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'n',
    deleted VARCHAR(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'n',
    extradata LONGTEXT COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id)
, KEY quesques_surdel2_ix (surveyid, deleted)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='questionnaire_question table retrofitted from MySQL';
CREATE TABLE questionnaire_quest_choice (
    id BIGINT(10) NOT NULL auto_increment,
    question_id BIGINT(10) NOT NULL DEFAULT 0,
    content LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
    value LONGTEXT COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT quesqueschoi_que2_fk FOREIGN KEY (question_id) REFERENCES questionnaire_question (id)
, KEY quesqueschoi_que4_ix (question_id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='questionnaire_quest_choice table retrofitted from MySQL';
CREATE TABLE questionnaire_question_type (
    id BIGINT(10) NOT NULL auto_increment,
    typeid BIGINT(10) NOT NULL DEFAULT 0,
    type VARCHAR(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
    has_choices VARCHAR(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'y',
    response_table VARCHAR(32) COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id)
, UNIQUE KEY quesquestype_typ2_uix (typeid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='questionnaire_question_type table retrofitted from MySQL';
CREATE TABLE questionnaire_response (
    id BIGINT(10) NOT NULL auto_increment,
    questionnaireid BIGINT(10) NOT NULL DEFAULT 0,
    submitted BIGINT(10) NOT NULL DEFAULT 0,
    complete VARCHAR(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'n',
    grade BIGINT(10) NOT NULL DEFAULT 0,
    userid BIGINT(10),
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT quesresp_que2_fk FOREIGN KEY (questionnaireid) REFERENCES questionnaire (id)
, KEY quesresp_que4_ix (questionnaireid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='questionnaire_response table retrofitted from MySQL';
CREATE TABLE questionnaire_response_bool (
    id BIGINT(10) NOT NULL auto_increment,
    response_id BIGINT(10) NOT NULL DEFAULT 0,
    question_id BIGINT(10) NOT NULL DEFAULT 0,
    choice_id VARCHAR(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'y',
CONSTRAINT  PRIMARY KEY (id)
, KEY quesrespbool_resque2_ix (response_id, question_id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='questionnaire_response_bool table retrofitted from MySQL';
CREATE TABLE questionnaire_response_date (
    id BIGINT(10) NOT NULL auto_increment,
    response_id BIGINT(10) NOT NULL DEFAULT 0,
    question_id BIGINT(10) NOT NULL DEFAULT 0,
    response LONGTEXT COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id)
, KEY quesrespdate_resque2_ix (response_id, question_id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='questionnaire_response_date table retrofitted from MySQL';
CREATE TABLE questionnaire_resp_multiple (
    id BIGINT(10) NOT NULL auto_increment,
    response_id BIGINT(10) NOT NULL DEFAULT 0,
    question_id BIGINT(10) NOT NULL DEFAULT 0,
    choice_id BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, KEY quesrespmult_resquecho2_ix (response_id, question_id, choice_id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='questionnaire_resp_multiple table retrofitted from MySQL';
CREATE TABLE questionnaire_response_other (
    id BIGINT(10) NOT NULL auto_increment,
    response_id BIGINT(10) NOT NULL DEFAULT 0,
    question_id BIGINT(10) NOT NULL DEFAULT 0,
    choice_id BIGINT(10) NOT NULL DEFAULT 0,
    response LONGTEXT COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id)
, KEY quesrespothe_resquecho2_ix (response_id, question_id, choice_id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='questionnaire_response_other table retrofitted from MySQL';
CREATE TABLE questionnaire_response_rank (
    id BIGINT(10) NOT NULL auto_increment,
    response_id BIGINT(10) NOT NULL DEFAULT 0,
    question_id BIGINT(10) NOT NULL DEFAULT 0,
    choice_id BIGINT(10) NOT NULL DEFAULT 0,
    rankvalue BIGINT(11) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, KEY quesresprank_resquecho2_ix (response_id, question_id, choice_id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='questionnaire_response_rank table retrofitted from MySQL';
CREATE TABLE questionnaire_resp_single (
    id BIGINT(10) NOT NULL auto_increment,
    response_id BIGINT(10) NOT NULL DEFAULT 0,
    question_id BIGINT(10) NOT NULL DEFAULT 0,
    choice_id BIGINT(10) NOT NULL DEFAULT 0,
CONSTRAINT  PRIMARY KEY (id)
, KEY quesrespsing_resque2_ix (response_id, question_id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='questionnaire_resp_single table retrofitted from MySQL';
CREATE TABLE questionnaire_response_text (
    id BIGINT(10) NOT NULL auto_increment,
    response_id BIGINT(10) NOT NULL DEFAULT 0,
    question_id BIGINT(10) NOT NULL DEFAULT 0,
    response LONGTEXT COLLATE utf8mb4_unicode_ci,
CONSTRAINT  PRIMARY KEY (id)
, KEY quesresptext_resque2_ix (response_id, question_id)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='questionnaire_response_text table retrofitted from MySQL';
CREATE TABLE questionnaire_fb_sections (
    id BIGINT(10) NOT NULL auto_increment,
    surveyid BIGINT(10) NOT NULL DEFAULT 0,
    section TINYINT(2),
    scorecalculation LONGTEXT COLLATE utf8mb4_unicode_ci,
    sectionlabel VARCHAR(50) COLLATE utf8mb4_unicode_ci,
    sectionheading LONGTEXT COLLATE utf8mb4_unicode_ci,
    sectionheadingformat TINYINT(2) DEFAULT 1,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT quesfbsect_sur2_fk FOREIGN KEY (surveyid) REFERENCES questionnaire_survey (id)
, KEY quesfbsect_sur4_ix (surveyid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='questionnaire_fb_sections table retrofitted from MySQL';
CREATE TABLE questionnaire_feedback (
    id BIGINT(10) NOT NULL auto_increment,
    sectionid BIGINT(10) NOT NULL DEFAULT 0,
    feedbacklabel VARCHAR(50) COLLATE utf8mb4_unicode_ci,
    feedbacktext LONGTEXT COLLATE utf8mb4_unicode_ci,
    feedbacktextformat TINYINT(2) DEFAULT 1,
    minscore NUMERIC(10,5) DEFAULT 0.00000,
    maxscore NUMERIC(10,5) DEFAULT 101.00000,
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT quesfeed_sec2_fk FOREIGN KEY (sectionid) REFERENCES questionnaire_fb_sections (id)
, KEY quesfeed_sec4_ix (sectionid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='questionnaire_feedback table retrofitted from MySQL';
CREATE TABLE questionnaire_dependency (
    id BIGINT(10) NOT NULL auto_increment,
    questionid BIGINT(10) NOT NULL DEFAULT 0,
    surveyid BIGINT(10) NOT NULL,
    dependquestionid BIGINT(10) NOT NULL DEFAULT 0,
    dependchoiceid BIGINT(10) NOT NULL DEFAULT 0,
    dependlogic TINYINT(2) NOT NULL DEFAULT 0,
    dependandor VARCHAR(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
CONSTRAINT  PRIMARY KEY (id),
CONSTRAINT quesdepe_que2_fk FOREIGN KEY (questionid) REFERENCES questionnaire_question (id),
CONSTRAINT quesdepe_sur2_fk FOREIGN KEY (surveyid) REFERENCES questionnaire_survey (id)
, KEY quesdepe_que4_ix (questionid)
, KEY quesdepe_sur4_ix (surveyid)
)
 ENGINE = InnoDB
 DEFAULT COLLATE = utf8mb4_unicode_ci ROW_FORMAT=Compressed
 COMMENT='Holds the combined dependencies per question to navigate in '