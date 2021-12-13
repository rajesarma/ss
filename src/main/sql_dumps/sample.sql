--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: hibernate_sequence; Type: SEQUENCE; Schema: public; Owner: sample
--

CREATE SEQUENCE hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hibernate_sequence OWNER TO sample;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: products; Type: TABLE; Schema: public; Owner: sample; Tablespace: 
--

CREATE TABLE products (
    correlation_id character varying(100),
    created_date date
);


ALTER TABLE public.products OWNER TO sample;

--
-- Name: recruitment_designation_mst; Type: TABLE; Schema: public; Owner: sample; Tablespace: 
--

CREATE TABLE recruitment_designation_mst (
    designation_id integer NOT NULL,
    designation_name character varying(100)
);


ALTER TABLE public.recruitment_designation_mst OWNER TO sample;

--
-- Name: recruitment_experience_level; Type: TABLE; Schema: public; Owner: sample; Tablespace: 
--

CREATE TABLE recruitment_experience_level (
    exp_id integer NOT NULL,
    experience character varying(500)
);


ALTER TABLE public.recruitment_experience_level OWNER TO sample;

--
-- Name: recruitment_job_post_master; Type: TABLE; Schema: public; Owner: sample; Tablespace: 
--

CREATE TABLE recruitment_job_post_master (
    id integer NOT NULL,
    job_id character varying(25) NOT NULL,
    posted_by_id_emp_id integer,
    designation_id integer,
    experience_level integer,
    location character varying(100),
    brief_description character varying(1000),
    last_date_to_apply date,
    to_mail_id character varying(500),
    qualifications character varying(100),
    other_details character varying(1000),
    salary numeric(15,0),
    entered_date timestamp without time zone DEFAULT now(),
    is_active boolean DEFAULT true,
    deactivated_date timestamp without time zone
);


ALTER TABLE public.recruitment_job_post_master OWNER TO sample;

--
-- Name: recruitment_job_post_master_id_seq; Type: SEQUENCE; Schema: public; Owner: sample
--

CREATE SEQUENCE recruitment_job_post_master_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.recruitment_job_post_master_id_seq OWNER TO sample;

--
-- Name: recruitment_job_post_master_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sample
--

ALTER SEQUENCE recruitment_job_post_master_id_seq OWNED BY recruitment_job_post_master.id;


--
-- Name: recruitment_job_post_roles; Type: TABLE; Schema: public; Owner: sample; Tablespace: 
--

CREATE TABLE recruitment_job_post_roles (
    id integer NOT NULL,
    job_id character varying(25) NOT NULL,
    role_responsibility character varying(500)
);


ALTER TABLE public.recruitment_job_post_roles OWNER TO sample;

--
-- Name: recruitment_job_post_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: sample
--

CREATE SEQUENCE recruitment_job_post_roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.recruitment_job_post_roles_id_seq OWNER TO sample;

--
-- Name: recruitment_job_post_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sample
--

ALTER SEQUENCE recruitment_job_post_roles_id_seq OWNED BY recruitment_job_post_roles.id;


--
-- Name: recruitment_job_post_skillset; Type: TABLE; Schema: public; Owner: sample; Tablespace: 
--

CREATE TABLE recruitment_job_post_skillset (
    id integer NOT NULL,
    job_id character varying(25) NOT NULL,
    skill character varying(500)
);


ALTER TABLE public.recruitment_job_post_skillset OWNER TO sample;

--
-- Name: recruitment_job_post_skillset_id_seq; Type: SEQUENCE; Schema: public; Owner: sample
--

CREATE SEQUENCE recruitment_job_post_skillset_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.recruitment_job_post_skillset_id_seq OWNER TO sample;

--
-- Name: recruitment_job_post_skillset_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sample
--

ALTER SEQUENCE recruitment_job_post_skillset_id_seq OWNED BY recruitment_job_post_skillset.id;


--
-- Name: recruitment_qualifications; Type: TABLE; Schema: public; Owner: sample; Tablespace: 
--

CREATE TABLE recruitment_qualifications (
    qualification_id integer NOT NULL,
    qualification character varying(100)
);


ALTER TABLE public.recruitment_qualifications OWNER TO sample;

--
-- Name: recruitment_skill; Type: TABLE; Schema: public; Owner: sample; Tablespace: 
--

CREATE TABLE recruitment_skill (
    skill_id integer NOT NULL,
    skill_type_id integer,
    skill character varying(50),
    id bigint NOT NULL
);


ALTER TABLE public.recruitment_skill OWNER TO sample;

--
-- Name: recruitment_skill_skill_id_seq; Type: SEQUENCE; Schema: public; Owner: sample
--

CREATE SEQUENCE recruitment_skill_skill_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.recruitment_skill_skill_id_seq OWNER TO sample;

--
-- Name: recruitment_skill_skill_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sample
--

ALTER SEQUENCE recruitment_skill_skill_id_seq OWNED BY recruitment_skill.skill_id;


--
-- Name: recruitment_skill_type; Type: TABLE; Schema: public; Owner: sample; Tablespace: 
--

CREATE TABLE recruitment_skill_type (
    skill_type_id integer NOT NULL,
    skill_type character varying(50),
    id bigint NOT NULL
);


ALTER TABLE public.recruitment_skill_type OWNER TO sample;

--
-- Name: recruitment_skill_type_skill_type_id_seq; Type: SEQUENCE; Schema: public; Owner: sample
--

CREATE SEQUENCE recruitment_skill_type_skill_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.recruitment_skill_type_skill_type_id_seq OWNER TO sample;

--
-- Name: recruitment_skill_type_skill_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sample
--

ALTER SEQUENCE recruitment_skill_type_skill_type_id_seq OWNED BY recruitment_skill_type.skill_type_id;


--
-- Name: recruitment_user; Type: TABLE; Schema: public; Owner: sample; Tablespace: 
--

CREATE TABLE recruitment_user (
    id integer NOT NULL,
    user_id character varying(50) NOT NULL,
    first_name character varying(100),
    is_active character(1) DEFAULT 'Y'::bpchar,
    created_on timestamp without time zone,
    gender character(1),
    mobile character varying(10),
    alternate_no character varying(10),
    email character varying(50),
    address character varying(500),
    dob date,
    photo bytea,
    resume bytea,
    father_name character varying(100),
    marital_status character(1),
    updated_on timestamp without time zone,
    last_login timestamp without time zone,
    shortlisted_flag boolean,
    shortlisted_date date,
    interview_scheduled_date date,
    interview_attended_flag boolean,
    selected_status boolean,
    selected_date date,
    offer_letter_generated boolean,
    offer_letter_generated_date date,
    photo_name character varying(500),
    resume_name character varying(500),
    aadhar character varying(12),
    postal_code character varying(100),
    sms_notification_active character(1) DEFAULT 'Y'::bpchar,
    email_notification_active character(1) DEFAULT 'Y'::bpchar,
    last_name character varying(100),
    stage integer DEFAULT 0
);


ALTER TABLE public.recruitment_user OWNER TO sample;

--
-- Name: recruitment_user_experiences; Type: TABLE; Schema: public; Owner: sample; Tablespace: 
--

CREATE TABLE recruitment_user_experiences (
    id integer NOT NULL,
    user_id character varying(50) NOT NULL,
    company character varying(100),
    from_date date,
    to_date date,
    exp_months integer,
    designation character varying(50),
    job_location character varying(100),
    is_current_job character(1) DEFAULT 'N'::bpchar
);


ALTER TABLE public.recruitment_user_experiences OWNER TO sample;

--
-- Name: recruitment_user_experiences_id_seq; Type: SEQUENCE; Schema: public; Owner: sample
--

CREATE SEQUENCE recruitment_user_experiences_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.recruitment_user_experiences_id_seq OWNER TO sample;

--
-- Name: recruitment_user_experiences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sample
--

ALTER SEQUENCE recruitment_user_experiences_id_seq OWNED BY recruitment_user_experiences.id;


--
-- Name: recruitment_user_id_seq; Type: SEQUENCE; Schema: public; Owner: sample
--

CREATE SEQUENCE recruitment_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.recruitment_user_id_seq OWNER TO sample;

--
-- Name: recruitment_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sample
--

ALTER SEQUENCE recruitment_user_id_seq OWNED BY recruitment_user.id;


--
-- Name: recruitment_user_log; Type: TABLE; Schema: public; Owner: sample; Tablespace: 
--

CREATE TABLE recruitment_user_log (
    id integer NOT NULL,
    user_id character varying(50) NOT NULL,
    login_time timestamp without time zone,
    logout_time timestamp without time zone,
    ipaddress character varying(50),
    hostname character varying(50),
    role_id integer
);


ALTER TABLE public.recruitment_user_log OWNER TO sample;

--
-- Name: recruitment_user_log_id_seq; Type: SEQUENCE; Schema: public; Owner: sample
--

CREATE SEQUENCE recruitment_user_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.recruitment_user_log_id_seq OWNER TO sample;

--
-- Name: recruitment_user_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sample
--

ALTER SEQUENCE recruitment_user_log_id_seq OWNED BY recruitment_user_log.id;


--
-- Name: recruitment_user_qualifications; Type: TABLE; Schema: public; Owner: sample; Tablespace: 
--

CREATE TABLE recruitment_user_qualifications (
    id integer NOT NULL,
    user_id character varying(50) NOT NULL,
    qualification character varying(100),
    percentage numeric(10,2),
    board_university character varying(100),
    specialization character varying(50),
    institute_name character varying(50),
    start_date date,
    completion_date date
);


ALTER TABLE public.recruitment_user_qualifications OWNER TO sample;

--
-- Name: recruitment_user_qualifications_id_seq; Type: SEQUENCE; Schema: public; Owner: sample
--

CREATE SEQUENCE recruitment_user_qualifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.recruitment_user_qualifications_id_seq OWNER TO sample;

--
-- Name: recruitment_user_qualifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sample
--

ALTER SEQUENCE recruitment_user_qualifications_id_seq OWNED BY recruitment_user_qualifications.id;


--
-- Name: recruitment_user_skills; Type: TABLE; Schema: public; Owner: sample; Tablespace: 
--

CREATE TABLE recruitment_user_skills (
    id integer NOT NULL,
    user_id character varying(50),
    skill_id integer,
    skill_level integer NOT NULL,
    exp_months integer
);


ALTER TABLE public.recruitment_user_skills OWNER TO sample;

--
-- Name: recruitment_user_skills_id_seq; Type: SEQUENCE; Schema: public; Owner: sample
--

CREATE SEQUENCE recruitment_user_skills_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.recruitment_user_skills_id_seq OWNER TO sample;

--
-- Name: recruitment_user_skills_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sample
--

ALTER SEQUENCE recruitment_user_skills_id_seq OWNED BY recruitment_user_skills.id;


--
-- Name: recruitment_users_jobs; Type: TABLE; Schema: public; Owner: sample; Tablespace: 
--

CREATE TABLE recruitment_users_jobs (
    id integer NOT NULL,
    user_id character varying(50) NOT NULL,
    job_id character varying(50) NOT NULL,
    applied_date timestamp without time zone,
    applied_flag boolean,
    ignored_flag boolean,
    ignored_date timestamp without time zone,
    selected_flag boolean,
    selected_date timestamp without time zone
);


ALTER TABLE public.recruitment_users_jobs OWNER TO sample;

--
-- Name: recruitment_users_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: sample
--

CREATE SEQUENCE recruitment_users_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.recruitment_users_jobs_id_seq OWNER TO sample;

--
-- Name: recruitment_users_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sample
--

ALTER SEQUENCE recruitment_users_jobs_id_seq OWNED BY recruitment_users_jobs.id;


--
-- Name: role_services; Type: TABLE; Schema: public; Owner: sample; Tablespace: 
--

CREATE TABLE role_services (
    role_id integer,
    service_id integer
);


ALTER TABLE public.role_services OWNER TO sample;

--
-- Name: roles; Type: TABLE; Schema: public; Owner: sample; Tablespace: 
--

CREATE TABLE roles (
    role_id integer NOT NULL,
    role_name character varying(100) DEFAULT NULL::character varying
);


ALTER TABLE public.roles OWNER TO sample;

--
-- Name: roles_role_id_seq; Type: SEQUENCE; Schema: public; Owner: sample
--

CREATE SEQUENCE roles_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_role_id_seq OWNER TO sample;

--
-- Name: roles_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sample
--

ALTER SEQUENCE roles_role_id_seq OWNED BY roles.role_id;


--
-- Name: services; Type: TABLE; Schema: public; Owner: sample; Tablespace: 
--

CREATE TABLE services (
    service_id integer NOT NULL,
    service_url character varying(100),
    service_name character varying(25),
    disabled boolean,
    parent_id integer,
    display_order integer,
    menu_display boolean,
    has_childs boolean
);


ALTER TABLE public.services OWNER TO sample;

--
-- Name: services_service_id_seq; Type: SEQUENCE; Schema: public; Owner: sample
--

CREATE SEQUENCE services_service_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.services_service_id_seq OWNER TO sample;

--
-- Name: services_service_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sample
--

ALTER SEQUENCE services_service_id_seq OWNED BY services.service_id;


--
-- Name: user_details; Type: TABLE; Schema: public; Owner: sample; Tablespace: 
--

CREATE TABLE user_details (
    id integer NOT NULL,
    user_id integer NOT NULL,
    dob date,
    address character varying(300),
    is_acrive boolean,
    short_name character varying(100),
    gender character(1),
    mother_name character varying(100),
    father_name character varying(100),
    mother_tongue character varying(100),
    phc character(1),
    blood_group character varying(100),
    marital_status character varying(100),
    spouse_name character varying(100),
    marks_of_identity1 character varying(200),
    marks_of_identity2 character varying(200),
    person_mobile character varying(25),
    person_phone_std character varying(25),
    office_mobile character varying(25),
    office_phone_std character varying(25),
    person_mail character varying(40),
    office_mail character varying(40),
    state character varying(100),
    city character varying(100),
    postal_code character varying(100),
    permanent_address character varying(300),
    permanent_state character varying(100),
    permanent_city character varying(100),
    permanent_postal_code character varying(100),
    emergency_contact_person character varying(100),
    emergency_relation character varying(100),
    emergency_phone_no1 character varying(25),
    emergency_phone_no2 character varying(25),
    emergency_address character varying(300),
    aadhar_no character varying(25),
    pan_no character varying(25),
    passport_no character varying(25),
    photo_path character varying(300),
    bank_name character varying(200),
    branch_name character varying(200),
    ifsc_code character varying(25),
    account_no character varying(25)
);


ALTER TABLE public.user_details OWNER TO sample;

--
-- Name: user_details_id_seq; Type: SEQUENCE; Schema: public; Owner: sample
--

CREATE SEQUENCE user_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_details_id_seq OWNER TO sample;

--
-- Name: user_details_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sample
--

ALTER SEQUENCE user_details_id_seq OWNED BY user_details.id;


--
-- Name: user_role_id_mapping; Type: TABLE; Schema: public; Owner: sample; Tablespace: 
--

CREATE TABLE user_role_id_mapping (
    user_id bigint NOT NULL,
    role_id integer NOT NULL,
    id bigint NOT NULL
);


ALTER TABLE public.user_role_id_mapping OWNER TO sample;

--
-- Name: user_roles; Type: TABLE; Schema: public; Owner: sample; Tablespace: 
--

CREATE TABLE user_roles (
    user_id bigint,
    role_id integer
);


ALTER TABLE public.user_roles OWNER TO sample;

--
-- Name: users; Type: TABLE; Schema: public; Owner: sample; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    user_name character varying(100) DEFAULT NULL::character varying,
    password character varying(100) DEFAULT NULL::character varying,
    disabled boolean DEFAULT false,
    user_desc character varying(100) DEFAULT NULL::character varying,
    email character varying(100) DEFAULT NULL::character varying,
    last_login timestamp without time zone,
    failed_login_attempts bigint,
    last_password_change timestamp without time zone
);


ALTER TABLE public.users OWNER TO sample;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: sample
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO sample;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sample
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sample
--

ALTER TABLE ONLY recruitment_job_post_master ALTER COLUMN id SET DEFAULT nextval('recruitment_job_post_master_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sample
--

ALTER TABLE ONLY recruitment_job_post_roles ALTER COLUMN id SET DEFAULT nextval('recruitment_job_post_roles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sample
--

ALTER TABLE ONLY recruitment_job_post_skillset ALTER COLUMN id SET DEFAULT nextval('recruitment_job_post_skillset_id_seq'::regclass);


--
-- Name: skill_id; Type: DEFAULT; Schema: public; Owner: sample
--

ALTER TABLE ONLY recruitment_skill ALTER COLUMN skill_id SET DEFAULT nextval('recruitment_skill_skill_id_seq'::regclass);


--
-- Name: skill_type_id; Type: DEFAULT; Schema: public; Owner: sample
--

ALTER TABLE ONLY recruitment_skill_type ALTER COLUMN skill_type_id SET DEFAULT nextval('recruitment_skill_type_skill_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sample
--

ALTER TABLE ONLY recruitment_user ALTER COLUMN id SET DEFAULT nextval('recruitment_user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sample
--

ALTER TABLE ONLY recruitment_user_experiences ALTER COLUMN id SET DEFAULT nextval('recruitment_user_experiences_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sample
--

ALTER TABLE ONLY recruitment_user_log ALTER COLUMN id SET DEFAULT nextval('recruitment_user_log_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sample
--

ALTER TABLE ONLY recruitment_user_qualifications ALTER COLUMN id SET DEFAULT nextval('recruitment_user_qualifications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sample
--

ALTER TABLE ONLY recruitment_user_skills ALTER COLUMN id SET DEFAULT nextval('recruitment_user_skills_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sample
--

ALTER TABLE ONLY recruitment_users_jobs ALTER COLUMN id SET DEFAULT nextval('recruitment_users_jobs_id_seq'::regclass);


--
-- Name: role_id; Type: DEFAULT; Schema: public; Owner: sample
--

ALTER TABLE ONLY roles ALTER COLUMN role_id SET DEFAULT nextval('roles_role_id_seq'::regclass);


--
-- Name: service_id; Type: DEFAULT; Schema: public; Owner: sample
--

ALTER TABLE ONLY services ALTER COLUMN service_id SET DEFAULT nextval('services_service_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sample
--

ALTER TABLE ONLY user_details ALTER COLUMN id SET DEFAULT nextval('user_details_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: sample
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: hibernate_sequence; Type: SEQUENCE SET; Schema: public; Owner: sample
--

SELECT pg_catalog.setval('hibernate_sequence', 24, true);


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: sample
--

COPY products (correlation_id, created_date) FROM stdin;
ABC1	2021-10-01
ABC2	2021-10-01
ABC1	2021-10-02
ABC1	2021-10-03
ABC3	2021-10-01
ABC4	2021-10-02
ABC4	2021-10-03
ABC1	2021-10-01
ABC5	2021-10-02
ABC5	2021-10-03
\.


--
-- Data for Name: recruitment_designation_mst; Type: TABLE DATA; Schema: public; Owner: sample
--

COPY recruitment_designation_mst (designation_id, designation_name) FROM stdin;
1	Accountant
2	Accounts Officer
3	Addl Director General
4	Addl. Director General(F,P&G)
5	Admin Service
6	Advisor
7	Assistant Librarian
8	Assistant Manager 
9	Assistant Manager - Data Centre
10	Associate Director
11	Asst. Manager
12	Asst. Security Officer
13	Asst.Manager(Admin)
14	Asst.Manager(HR)
15	Asst.Security Officer
16	Business Analyst
17	Business Development Manager
18	Chief Executive Officer
19	Client Login
20	Consulatant
21	Consultant- Public Finance(Fiscal Cell)
22	Consultant-MEPMA
23	Consultant-QA
24	Consultant-URBAN
25	Core Team Member
26	Data Analyst
27	Data Entry Operator
28	Database Administrator
29	Database Architect
30	Director
31	Director General
32	District Resource Person
33	Driver
34	Electrician
35	Gardener 
36	Graphic Designer
37	Help Desk Associate
38	House Keeping
39	Intern
40	Internal Auditor
41	IT Associate
42	Knowledge Manager
43	Knowledge Manager (Knowledge)
44	Knowledge Manager (MDRG)
45	Knowledge Manager-RTI&Social Accountability
46	Legal Consultant
47	Manager
48	Manager (Admin)
49	Manager (Central File repository)
50	Manager (HR)
51	Manager (KR)
52	Manager HR
53	Manager(A&HR)
54	Manager(Admin)
55	Manager(Admin) (Core Group)
56	Manager(Admin) (Operational & Administration)
57	Network Administrator
58	Network Engineer
59	Office Assistant
60	Office Executive
61	Office Executive (Core Group)
62	Oracle DBA
63	PA to DG
64	Plumber
65	Program Manager
66	Program Manager(GRG)
67	Project Assistant
68	Project Leader
69	Project Leader (eDevelopment)
70	Project Leader (eGov1)
71	Project Leader (eGovernance)
72	Project Manager
73	Project Manager (eDevelopment)
74	Project Manager(Cloud Computing)
75	Project Manager(eGov1)
76	Project Manager(ePass)
77	Project Manager(mGov)
78	Project Manager-ORPS1
79	Public Relation Officer
80	Research Associate
81	Research Associate (Evaluation Research Group)
82	Research Officer
83	Research Officer (Knowledge)
84	Security Guard
85	Senior Software Tester
86	Senior Technical Consultant
87	Software Developer
88	Sr. Knowledge Manager
89	Sr. Knowledge Manager (GRG)
90	Sr. Knowledge Manager (Knowledge)
91	Sr. Knowledge Manager (UMRG)
92	Sr. Knowledge Manager(GRG)
93	Sr. Manager(F&A,Contracts)
94	Sr. Manager(F&A,Contracts)(Administration)
95	Sr. Project Manager
96	Sr. Software Developer
97	Sr. Software Developer (15)
98	Sr. Stenographer
99	Sr. System Adminstrator
100	Sr.Knowledge Manager
101	State Co-ordinator
102	System Adminstrator
103	System Analyst
104	System Integrator 
105	System Support Engineer
106	Team Leader
107	Technical Consultant
108	Test Engineer
109	Test Engineer-1
110	Tester
111	Trainee Network Engineer
112	Trainee Software Developer
113	Trainee Software Tester
114	Training Coordinator
115	Web Designer
\.


--
-- Data for Name: recruitment_experience_level; Type: TABLE DATA; Schema: public; Owner: sample
--

COPY recruitment_experience_level (exp_id, experience) FROM stdin;
1	0-1 years
2	1-2 years
3	2-3 years
4	3-4 years
5	4-5 years
6	5-6 years
7	6-7 years
8	7-8 years
9	8-9 years
10	9-10 years
11	10-11 years
12	11-12 years
\.


--
-- Data for Name: recruitment_job_post_master; Type: TABLE DATA; Schema: public; Owner: sample
--

COPY recruitment_job_post_master (id, job_id, posted_by_id_emp_id, designation_id, experience_level, location, brief_description, last_date_to_apply, to_mail_id, qualifications, other_details, salary, entered_date, is_active, deactivated_date) FROM stdin;
\.


--
-- Name: recruitment_job_post_master_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sample
--

SELECT pg_catalog.setval('recruitment_job_post_master_id_seq', 1, false);


--
-- Data for Name: recruitment_job_post_roles; Type: TABLE DATA; Schema: public; Owner: sample
--

COPY recruitment_job_post_roles (id, job_id, role_responsibility) FROM stdin;
\.


--
-- Name: recruitment_job_post_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sample
--

SELECT pg_catalog.setval('recruitment_job_post_roles_id_seq', 1, false);


--
-- Data for Name: recruitment_job_post_skillset; Type: TABLE DATA; Schema: public; Owner: sample
--

COPY recruitment_job_post_skillset (id, job_id, skill) FROM stdin;
\.


--
-- Name: recruitment_job_post_skillset_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sample
--

SELECT pg_catalog.setval('recruitment_job_post_skillset_id_seq', 1, false);


--
-- Data for Name: recruitment_qualifications; Type: TABLE DATA; Schema: public; Owner: sample
--

COPY recruitment_qualifications (qualification_id, qualification) FROM stdin;
1	SSC / 10th Class
2	Intermediate
3	B.Tech / B.E
4	B.Sc. / B.Com. / B.A
5	M.Tech / M.E
6	M.Sc. / M.com. / M.A
8	M.Phil
7	M.C.A
9	Phd.
10	Other
\.


--
-- Data for Name: recruitment_skill; Type: TABLE DATA; Schema: public; Owner: sample
--

COPY recruitment_skill (skill_id, skill_type_id, skill, id) FROM stdin;
\.


--
-- Name: recruitment_skill_skill_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sample
--

SELECT pg_catalog.setval('recruitment_skill_skill_id_seq', 1, false);


--
-- Data for Name: recruitment_skill_type; Type: TABLE DATA; Schema: public; Owner: sample
--

COPY recruitment_skill_type (skill_type_id, skill_type, id) FROM stdin;
\.


--
-- Name: recruitment_skill_type_skill_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sample
--

SELECT pg_catalog.setval('recruitment_skill_type_skill_type_id_seq', 1, false);


--
-- Data for Name: recruitment_user; Type: TABLE DATA; Schema: public; Owner: sample
--

COPY recruitment_user (id, user_id, first_name, is_active, created_on, gender, mobile, alternate_no, email, address, dob, photo, resume, father_name, marital_status, updated_on, last_login, shortlisted_flag, shortlisted_date, interview_scheduled_date, interview_attended_flag, selected_status, selected_date, offer_letter_generated, offer_letter_generated_date, photo_name, resume_name, aadhar, postal_code, sms_notification_active, email_notification_active, last_name, stage) FROM stdin;
2	SAMPLE000002	Sridhar	A	2021-12-01 00:23:46.148	M	9595959555	9866489944	f@d.com	tyestr	1982-08-01	\\xffd8ffe000104a46494600010101012c012c0000ffdb004300080606070605080707070909080a0c140d0c0b0b0c1912130f141d1a1f1e1d1a1c1c20242e2720222c231c1c2837292c30313434341f27393d38323c2e333432ffdb0043010909090c0b0c180d0d1832211c213232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232ffc00011080162011803012200021101031101ffc4001f0000010501010101010100000000000000000102030405060708090a0bffc400b5100002010303020403050504040000017d01020300041105122131410613516107227114328191a1082342b1c11552d1f02433627282090a161718191a25262728292a3435363738393a434445464748494a535455565758595a636465666768696a737475767778797a838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae1e2e3e4e5e6e7e8e9eaf1f2f3f4f5f6f7f8f9faffc4001f0100030101010101010101010000000000000102030405060708090a0bffc400b51100020102040403040705040400010277000102031104052131061241510761711322328108144291a1b1c109233352f0156272d10a162434e125f11718191a262728292a35363738393a434445464748494a535455565758595a636465666768696a737475767778797a82838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae2e3e4e5e6e7e8e9eaf2f3f4f5f6f7f8f9faffda000c03010002110311003f00f7fa697029d50b704d034ae3fcc1e947983d2a2a282b9512f98293cd1e95152f6a07ca893cd1e9479a3d2a2a4a03951379a3d28f347a54229680e544be60f4a3cc1e95151485ca897cc1479a2a2269281f2a27f307a1a4f356a1cd253172a27f3451e68a833c528a03951379a28f3454068a07ca89fcd14be68a80519a03951379ab479a2a0a334072a2c79828f305400d2e6817293ef1eb46f150d14072936f149bc5454501ca89b7ad2798b51514072a26dc28de2a1cd029872a2c76a290741452205a85bad4d50b75a0a88da4a71a6f7a0b0a3a514b9a0069e948294d18e2800a5a4c52d001477a29a81803b882727f2a0053452d25000690d3a98cc06493400a4f1476a89a640339cf19ac76f16e8ab76d6afa8dba4c8406469002a4f4c8a57406ee68cf155e3b98e540e8c194f420e41a9448a475a603fad148181a507bd000681d68a2801452e693b52d002d140a2800a28a28012968a5a006d28a314a3ad30261d05140e94523216a16eb535427ad054469eb450693b532c43d69d494669005141a4a005345251400ea424525349a0076454725c47129677550064963815c4f8dfe26e91e0f06db02f7533d2d22700a8f573cedfa7535e03e29f1d6bde2b902eab79fe8c092b6b00d910e9dbab74ead9fc2a5cac2b9ee9af7c61f0d68f39812696fa51d45a20700ff00bc481faf6ae0f5cf8e37f2b30d22c23854f19baf9ff4047f3af2359bf745003d7803a0a6fdecfad4393b0b5b9b179e2dd76ee52f36b37e723185b86518fa03cf071cf3592d71b98bb1dcc4e4b1e493ef55d8f6148830bcf38a9d47637b4bf15eb3a4bb8d3f54ba815fef46b292a73d7e53c77aed6c3e34f8920454ba8ecae4a10096464257df0719f7c579497da411d7d69f24bcef27935576163e91d2be33e857765135e17b3b96708d1b02ca3fdadc07ddfaff00f5ebbed3b59b4d4ed85cd9dc47340c70248db2a7f1af8bd6e085cf35afa4788b50d2e48df4fbd9ad8a36edb1b90ac7dc74355719f65ac818714fed5e41e02f8aa356963d375768a3bd6e16638449382703d0f15eb51c991cf5ab0261f5a502980d381a00776a290734b40051451400514514c028a282680275e828a17ee8a29190b50b75353544dd4d054461a4a752629dcb1a69053a8c5201b4b9a28c50018a41d6979a3140084f1ef5e21f13fe2b5dd9decfa07876e3c968be4bbbd5009071f7109e84773dbb57a17c44f158f09f85ae2f2239bd947956ab9eae4819fc01cfe15f28ee3b70c4b313c927963dc9ace52277164919e4691cb4923b65a4762c4fd49e4d2ecdcb920f14abb5502b0dc4f391da9ed31f31738c01824545c12188881b938e3d2a262a72a38c77a700c5b70e86919486200e3b9a5763b9587eed4e46450cc5d7a6d14e703046735149b9368618c8cd55ee311867b7148012a06338a4f318939a92227e6e94f541a80c6e008c534128c4e3bd29701815eb417dc09340f72d4372d1488c8ec8ea432b2f5523a1af6ef879f15dae665d3bc47791a484ed86ea44da1faf0c4700f4eb8cd7832b64f3daac453e30a33ef4d3b12f43eda8a5122020820d4c39af30f845e313aee83f60ba9435f58fc8fc60b21276b7e5c7d457a72904558d0fa5a414b4c028a4a5a0028a28a005a43c8a33484d004e8308076028a54fba28a0c87542dd6a6a85bad054443494a69a682828cd0693bd031693341349400a4d231e38a5c552d57518f49d32e75094feeeda332b7d00a4c4cf9bfe2d788df5ff0017dc5ac45bec7a6136f1f3d5f8de7f3007e06b800aa36e739356a69a4bd90cd2b979ae099e5627ab37cc7f53509f297249e4564d88493cb320f2f7041eb50be4e493c558451e59665183d334d1b58fafa0a8b85c8338418279a5fe1e73536c0a33814c65cae3b53b9562101719233e9508c966ce6aded0783d00a68897b535241b154c4723e5a524861b454e14b1c014f16e4aed23a7b51cd6dc69365120ed271ce69e4820295c0f5ad05d2ae1c03e5b053c8c8eb504d6cd18cb8c6285522c6e325ba2b155507d69b92a9c75cf3536016ce474e9eb4c203714ee2e9a9d4782b5b7d0fc47657a976f6d11711dc48bc8d87fbc0f60706beb5b57dd1a9dcadc751d0d7c4e1428f2f9c11cd7d4ff000c35e1af7836c6724f9b1a98a5c9cfcca48fe401ab8b11dd0c53a9a29d56014672718a314b400514514c04a51451cd1602c2fdd1450bf745148c85a85aa6a85bad054469a4a53494162514525002e38a4c514668001d2bccbe356a1343e0c92ce22512e1d44af8e0a865f97ea7f9035e9a2bc9fe38099b40b4c1c42b3e49c724e38e6a65b099e0323b203b7f1aa3bb6c99619f5ab523a8e3d6a9b062e3eb595812658f31a41cfddf415341c0dc41cf6e2b5fc37a5c77b3812723b8aefe1f03e9aff36c604f3d6b9aa5750763ae9e19cd5ee799450cb390047c138e7a56c43e1bbd90945b66c9e30463f9d7aa69de1ab1b550cb103b3eee4735b765a343182db002c727deb2f6d396c6cb0d08ee788b784eff006e5606fa63bd538b4a76dcd8c2a9c67ae4f7c57d0571a4a491ed45c7159ba7f84608a65964453b136aae381cf5a71a93d989d083d4f38d2be1ecd34f9b98dd57191db15d759f816c6df04c4a54638eb9fad7791d9a29c63a0a91e2555c002895dee691b4764709a8e856d1a7eee1008e9c579af883449b70020fbcd818af6fba55c1cf7ac2bbb089b965048e726b0527095d1a4a0a71b33c0aeaca6841f30608aaab0b6c2c3a77aedbc5fa735add92a998d8ee15c848eea72315e8d29a9c6e797520e326887b0dc4935efbf01489344be186530cfb4e790c08c8c7a5782498e31cf7e2bdd7e01a48d63aacca1b619114fcdc6707b7afbd6d03347b60e94e069a3a53aac61de968a514c031494b4530128ef45145c0b0bf745142fdd14523216a16eb53542dd682a23690d1de9282c4a3b529a4ed400514668a005af37f8d56e26f023911ef65b98b1c741bc64fb74c7e35e8f556fece1beb730cf1ac899076b0c8c8e693133e2f9885720819fe555946fce0726b57c49a74da3eb379653ab168e77009fe25dc706b36d94cd7291af5638ac1e8ae3826f43adf072bfda38e0704d7ac5a302aa09ae2fc3fa62585b29206f6ea6bb3d3e30ccb935e4d4939cf43d9a71e4824cd8808e001c56a4499008aaf6d6a0015a9140a17835b420d113921b1ae3af4a9011e94bb3f2a708f815aa4cc8691c5559b8f7abed171551906f3965fc6934c6998b788e412a39ac4943331f3493ed5d5dc08db2a1d49ac2beb7099391cd613835b1b4248e4bc4b602f6c1b6282e9c807bfd2bc7274314ee8c3183c8af73be3b1707a5798f8c3485b7985f42a446cd87f4cfad6b869d9f2b39b154f4e6473ab12bd7d19f0534b8ec7c1497011d67ba95da50c7a80c42e3db6e2be768219ef6782d2d632d35c48228d57b92715f63693a6c3a469b6f6300f9208c203dce3bd7a705a1c091a4bd2969a3a53aac05a5a4a280145149453016928c51401617ee8a285fba28a4642d42dd6a6a85bad054469a6d3a9b4160692968a004a5345250028a4345417972b67672dcb722352d8f5a99c946376095f43c83e3b7864cfa35aebd6902eeb390adc151cf96d819f7e71fad78ff83ac85df892003042ab39fc057a75e2ea1e2bd3ae99eeee229ae59d47efd8c722eec6197a638e95c97c35b276bbbcba74c6d554031d09ce4571cab29d36d6875c283a7512674f7b756da444d7776e4451f455eac7d07bd601f12ebde77db3ec8f15b39fdd2e3a0fad76379a6a5d4f19963de14e47a0a6ea5e2ad37c3f18b6706594e3f731ae4f6ebf9fd6b8e8cba25a9d5522deb739d97c71e2986351059bc6bddcdbb373f5e956347f881afc97256721a22ad8fdde3071c73f5a9f51f1a7882d6448a2f0eac00dbbdd0170f83e527de6c718c7e7ed458eb3a9ea50dd5d5c68e91a5b7966674c3aa075dea491c8c8c1f6ae892928dec73d3945cad73acf0e78ea3be9d2caf1592eb19e14ed6f520ff4aec9ef951a3c23306ee074ae074b8ad6e8acfe408e41cf4191ef9f4aee2d02bc0b839c56519b91d328a5a943c55ad5e6956067b289252bd54e738af3fb3f136b3a8dc79f244cb1f754e838ce41af48d5511d304035c56a373f6005218d1727ef30c807b0007527d29393bb428c74b9c6ccfe2a96fa692d96edb736700920669cd2f8b5a268ae2195d47237f057f11d6b4afbc47e22b2d4ff00b3edb4997cc1325b8f3e48e3cc8d18900c76f94e7934967e2af10c9e1c875f934d5b8d36566567858318cab630cbf787d46462ba396a25aa3994a0de8ca0be22d462315aeaf65222918f38afeb9e9d6aceb7a78bef0edd26dde766e5fa8e456d69da8d9f896c85c40a55b24153d54ff855dfb28583cb93183c1e3b573b7695cea70fddb8b3cb7e1e3b5af8b6cf504b3fb58b525b6138519520127b6335f4f683ad41aed81b9854a15728e84e7691ef5e13e03d323b57d663087cdb59d54b1ff9e64647ea0d7abf81e26b7bed4635ff0054fb2403debb69d56ea72f4391d25ecb9ba9db0a5a4ed4015d6728b4b494bde810a6928a298052f7a4a28b81617ee8a285fba28a4642d40dd6a7a85bad054469a4a5229282c4a3341a4a0028a3b51de801464565788a3926d0ee9231925391ed9e6b569922ab21523208c1159d58f341a45425cb24cf28f0fc515ad85badc2e1020475ef9c9cd72de0485574eba954e44b7721cfb06c0fd2ba1f1216d3ac2fd1010229c2123f8413d6b1bc151f95a188f3cacf28271fed9af2612fddc933d592bcd48ec21b65922381cd723a96837116ad1dfda8ccf1b6e19aee6c972a2ae9b10df36da718f54272b3d4e17c49a55b78bec2d8ea36f2dbdeda82b1cf172086c120a9ea38ad1f0eb59f84b43934dd22df7bcefe64d35c364b9e9d00e80700574cd6883a8155cd8c658b0419f5c569cf3b5ae4f241bbd8c1b7b468153042aaeec46830a0139c01e82ba6d2dc8b7aa0d6e11b26a7b59b12103a56117691b3d512dfc9963935833c4c9a85b5f2a44e6dc928ae0e013df8f6ad8ba70d2fcdc66a2580b74e455c5bbe82d91c9f8afc33a5f8b7581aac8b2d9debaaadc3458759428001c1c608031f955bb87fb0e831683a2d8496f651a90aecdb89c9c927df24d7531dac6319419a95ace338c0ad5ca4d6acc946117748e3bc3ba37f66a00dcb1e49ad6bd400715b42c42aeec5656a0bb54835954d0d14aece47419974ff001aeaf6f2300b7d141201e9b372ff005af51f08c586bb7f42abfcebc96e22924f1942ca1b0b002c5475f98f15ebfe0f904b6d74e070641fcaba70b2e69dfc8e7ad150a5a1d2514b9141af40f3c414b45071400b9a3ad20a2980528a4a51480b0bf745140e828a0c85ed511eb52f6a84f5a454469a4a5269299621a4a752500149de9693bd002f6a434bda92860799f8a2d02f88eea2949105d2ab37a741fd4560681a645a4dbbdbc72f98a6567ddf53c0fcabd1fc53a27dbe3176aaccd146c1d5080c475e09ae2bec4d691a948192dce15242c1839c67839e6bc6a94a54e4fb1e9d1aaa504afa9d0589031c715b918491315cd58b9d8a735bf692640e6ae9bb8e6895ed54f6e2a17856343c5686415acbd4e5654dab553492260db76316f67459766727bd5cb0b42e9bc2f5ae7b5af10693a27922fda44f373891632c063b9c7415d5687abda5ce9914d6f2c72c2e32ae841045674e09eacd672695914f50b674e48e950d84cad26dc8c8ab3e24f12e97a7428da85dc36eadc2973c9fa0ea7f0acad3b51d2b55b55bad36e1664ce372823f4201aae5b3bad898caeacf73a75855c0c015325a2e391552c262c429ed5aa0fcbc1ada293339368a7701513a5729ab1e48ae9af9fe43835c7ea526f940cf4ae7ac694915e07110621465be5ddb735de783a0f2b46dc41cbc87f1c71581a0e922f6c03b4170c6594a8955d4220007273c9e73d057790c490c6b1c6a15146001dabb70d45d3bb673626aa97ba8978a3228a2bace30a28ed4828017345145300a5149914a2901607dda285fba28a0c85a84f5a9aa16eb41511bde929690d05852639a5a280108a0d04d277a0028ef4668a00194329520107a83587e27b213e85279680340448800e8075fd335b99a6b2aba95619523041f4acea439e2d151972b4cf34b394a918e86b7ec5f91cd625e5a1d2f5396d4fdd53943eaa7a7f855cb7b8d8464d79317caf53d4bf32ba3a179822649e2a85c4d1ba12c474aa5a85eac16ad2313b5464d7926afe35d5756984560af1c20edf939663c55eb222ea3ea771a9ea765a6cad25cb8f2f93c8dd5574ef1068f7b2182ca78ed88380bb762b1ebc76cf5ae16e740d5f528ff0079709bff00b8ce78adcd3bc056f0ac1326a32c77b1e5b2c81909c63a7e34e30496acae6a8dec6e5f6b7e1e18fb6496b758e41910385ed919ad3b06b49086b73188cf2046028af3b97e1d5d08c11a9c4d20625b7210a467f3f5a8fcdd77c3f10500346b92761dc1474154e2ba3129c97c48f6ab795154608e2b462ba052bc42cbc717d0ec69812a0e324e320f415e8da2eb51ea56cb34472a7a8cf43e946b112b4f6366fe7dc0f38ae5af1c659f19c56c5e4d90706abe8962753d7a142bfb987f7b2fd0741f89c7eb5108ba9348a93e48dcee745b23a7e8d6b6cc30ea997c7f789c9fd4d688fd2931cf2681d6bd63cb6f51d49da945277a620145028a005a4a283d68016947b536945032cafdd1450bf74514188b50375a9ea16a0a88da4a5a4a0b03498a3bd1d2800a4a0d140075a28cf1450018a4a28ef8ef480e13c7729b7d674f6c7cb242f93feeb2ff00f1559f04caea083cd3bc4daa5a78974f8355d38992d6d6ee6b359c0f964e14965f6dca467be2b1ed6768ced27f1af22be951a3d3c3bbd34696b101d5347b9b3598c465429e62f55f7ae4e0f095b5be9ed6de7c81b6e04918da735d546e1cf269d34419005158a9cad636e557b9ccc7a1cec1059dd9571d55d7756c5ae9fabc0374ab149d81524669e2078240ea48fa5698f10288c4536c247e15d10717b9a7376461dd5aeb0f1bac5146188f979c8cfbd65cfa15fb2b7daae501c72ab19e7f5aec63f11c310608132dc7cc2b3a667bb7f30b67fa5549c7a0b993dd1ca2f863ced35e0925569245e494c639c8adff000e69c745d2e3b767def966761ea49c7e9815a70dbaedc9149361178ac5b66768dee865cce1236208cd767e0fb38e1d0d2ec60c977fbc66f604851f97f3af38bb94b8247a575ba7f89a0f0ee9de0eb0be511dbea714912cecd811ba8531e7d9b247d48aecc1add9c98a76491ddd1499c707ad19aed388751499a280034504d276a7601c0f34520e9466801453a9a0d2d032cafdd1450bf74514188b50b75a9aa16eb41511a69b9a534941619e2909a0d250029a33c51da9a68017341a4dc00ac7d7bc4da3f86ad967d635086d15ff00d5ab1cbc9feea8e4f5ed48573677002bcbfe2e78e9345d265f0fd84c7fb52f63c4ae8706de13d493d998640fceb9ad7fe39de5c3797e1cd3d6da2079babd019d87b20381f893f4af27babcb8d42f2e6f2ea792e2eae18bcb2c872cec7fce31da95c972b9f41781745fb57c12d3ac913f78f1bdcc7ea4999d87e98158aa034408fc2bbdf86ac8df0e7c3c50823ec280e3d4673fae6b2fc5da0b69f70faa5ba96b390e66551fea5bfbdfee9efe87dba70e32937efc4ecc25551f71f539d8a6d98cf515a909f3541ac6750c370fceaee9f7811846fd2b863a9e83d0d74b40f8c8e2acc7a441f7b60cd431de20232c315a905d46c9d4574538a7b99ca4ca8da440fd50647ad45269d1c6300015a82e5304551b8b95c1e6ae7148952666c88b1291d05645dce0e556addf5d0390bc9ac83b8c8a8aad24b21da88832cc7d00ac926d977ea4d69a6cbaadec3a7c190f39f99f1f717f889fc3f5c56dfc6ad26de7f870f3aa606993c12458eaa0b88ce3f06fd2ba9f0af878e8f6cf3dd6d6bd9f05c8e88a3a28fa679f53f85657c62213e146ba4f758547d4cc807f3af4e8d3f671b753ccc454e7968796f863e316b1a358c363a8da45a9c1170933ca5260be84e086c7ae3a577da2fc66f0aea8de5de4b71a4cbe9789f27fdf6b91f9e2be74673bb3dea295c8391ce7d6b539d367d9d69796f7d6b1dd5a4f15c5bc83292c4e1d587b11c54dbabe3bd1f5bd4745916eb4abeb8b0941cee85b01cffb4bd1baf706bd4fc3bf1caea3511788b4e172a08ff4ab201580f568c9c1fc08fa505291ee5da8ac8d13c4ba3f88a069b48d460bb54c17546c3a67fbca791f8d6aeecd055c7d0693771466818a2969b9a703401697ee8fa5142fdd1f4a283216a06a9ea06ea682a221a69a534c2691429a693464556bebeb5d36cdef2fae62b6b58f979a670aabf89a02e59c8aa1abeb5a6e8762d7baa5ec3696c38df2b6327d00ea4fb0af2df157c6d862492d7c3369e74b9c0bdba5c458f554eaddfae07d6bc7753d5f51d6b507bdd4ef26bcb93fc52b6428f451d147b0c504b91e97e2af8d9a85e87b6f0d43f6180120de4ea1a671eaa87213bf5c9fa5792dcdcdc5d5c19ae6e26b99dbef4d3c86473ff023934aec41e9c1a6e33da9f291711bee0c673de9c980452a9072bb69a41ddec28e51367d25f04ef45c7c39b5b55396b19e681bdb2e5c7e8e2bd2368742ae01523041e95e17f01751f2f51d6f4b25b6cd145751a9e9952cae47e053f2af774e94add0d2fa1e7faf7841ecf75de951b4901397b55e4a7ba7a8f6fcbd2b950aae03c6d907a115ed95cfeb5e18b7d4b33c1882ef1c381f2b7fbc3bfd7ad7157c2dfde81d743156f76679bf9922a63a8f5a60bf9edf942c47a5694da7dcdacc62b981a2907507907dc1ee298d6a08e578ae2bc968775a2f54541acdcede11a9cd7b34a3918cd4ff006651d1688acaeaf6e96d6ca0f3676e719c2a0fef31ec3fc8cd5c5ca4ec852518abb29b6f9258e28d5a59e53b63893ef39ebc7e55e81e17f0a8d241bbbd649af9c761f2c43d17dfd4d5cd03c336da2c3bd889af5c7ef6e18727d947f0afb7e79adee95e8d1a2a0aef73cead5dcfdd8ec211815e63f1d2fc5b7c3f4b5e73797b0c7c7a292e73ff007c57a7d7877ed01745eebc3d62adf2aacf72e07afc8aa7f56adce66789b8f9f23bd44e8dd71c5593d7a73498dca78aab5c8b95704704fd2a685b0074a47538ce2a3cf3e98a56b145fb7bcb9b2bc8eeecee25b6b98ce52685ca30fc476f6e95ea3e1bf8dba8d9c621f10d9fdbd0600b9b6c24a07fb4bf75bf0c7e35e4ca73cf5a5c9cd5584a563eb2d07c5ba1f8963dda46a505cb050cd103b644ff00790f22b6b7f6af8d63b86864de8cd1b8e8e84ab0fa11c8aedb45f8b1e29d1d2389aee3d4605ff9677abb9b1e81c7cdf9e6a6c5a9773e95cd381af36d07e32f87354c26a026d2a6f59c6e8cff00c0d7a0fa815e876b7505ddbc7736d34734120ca491b06561ec45162d3b9a4bf747d28a45fb83e9452331d5031e6a7acfbfbdb5d36d25bcbdb88adada21979656daabf52682a24a58553bfd42d34cb37bcbfba86d6d531ba699c228fc4d795f89fe36db46b25b7862d4dcc9d05f5ca95887baa7de6fc703eb5e45aa6afa8eb97af79aa5f4d793b1ce656f957d957a28fa0a2cc4e47b078a7e355a5a79b6be1bb6177381c5ece08847fbabf79bbfa0fad78f6b3afeabe20bb6bad5efe6bb909f9558e113fdd41f2afe02b398b1c9cf0299b0e719aa4886ee2b166039cd290074a4d842e3bd29c6d627b53b585719315da08e58f18a7f97b6318f4eb55cfcf3a8cf03ad597cbe594607a50b5d44d91221ce69e54819a704c8eb8a7942307238f5a690b63aef861a89d37e21686e5b09348f6cfe98743ffb304fcabea6518af8d2d6e9b4f962bf88e64b6713803d54e71fa57d91148b2a2c88432380ca47706a59a45e84d4514548cab75690dec0d0cc8191863dff00035cacfe1c916e5a2b59e2942f556601901e9915a1e24d79ec23fb2d93afdb5c7df6c30847a91dc9ec3ffd4788b4f12ebba5cd33c9670dd97fe266d9249e997e4773c63bd61521097c48de94e705a33a78bc2b7cf3ed96586288104b2e5988ee00e31f5ae974fd3ad74d87c9b68c2027258f2cc724f24f27afe15e69a27c46d66d7579478874bf2748940613c73894da9e73bb805d4e47207183d457abab2ba86521948c82390455538422bdd26ad49cbe21f451456a6415f33fc63d45b50f88f790e331d85bc56cb8f523cc6ffd0c7e55f4bd7c7fe23d40eade21d5b520722e6f65753fec86dabff8ea8a715764c9e862f3927141c9618e286e3a9a14639ce6b4448bb78c1aab2aec983763573a9eb51ca998bb1f4a4d0212161806a5c0ea2ab42d93b4f18f6a9ce738078aa40d0326ee7151ed20f4a980e3ad2eda1a1263149504763eb5ada2788355f0f5d8b9d26fa5b67ee80e637ff790fca7f2acc45ddf2e3258f1537902390a96521491c743516d4b4cfaa3e1f6bd77e26f0469fabdf88bed53f9ab2794a429292ba640c9c6428345677c1e50bf0b7480082375c1e3febe24a2a0a3a4f126a33691e19d5353b754796d2d259d164ced2caa48ce39c71dabe5ad77c47aaf882e5ae757bf96e9db04464e228c8fee2741fcfdebe97f1fff00c93bf127fd832e3ff45b57ca4e0b60fb5090991b39ce71516589a976e4818dd9ed47caa4e4715691047b8e3a51efd3146edc781481801d39aa485715f823ad42cf8539e952b1ddd88c554bb9231b634c9cd293e8344d0a332ef23ad58da5533da991865897d29ce49155d2c26f51a992473c54b8c8ce7a54481b80054aa4a1c63afad213649180e183721b835f52fc39d54eb1e02d26e9dc34a91182423fbd19287ff41cfe35f2dc436aeecd7b77c0dd60bdb6ada1bbafee0a5d4207f75f21bf22a0ff00c0854c8b833d8bb5676b3aada685a45dea97cfb2dada33239ee71d00f524e001ea6b42b97f1a69875cd15f4dc651c8661d890723f5e7f2acdbb2344aecf0eb3f144babdfbdeddcbe5ea73b6f94a8c0f6519fe1518001ec2bafb1d6848a23bc5009cfef157e53f51daa86b3f0b674f0834f6485f58b6732a8071e7212329f50391eff005ae2343f12b46ab1dc9674e7e73d473dea12b9adeda1ea575683c9f32121d48ce3fc2a2f873e311a7788a5f095e4a4dace77e9ae41223620b3c24fa1e4afa723d05625b6aa6188bc0fe6dbb7263cf5fa1ec6b5adbc2b6daf69967ac5912258667cede0ee07f42292567740d731ed34567e97786eed15a4c79abc38f7f5ad0ad4c9ab19facdf2e99a25f5f31005bc0f267dc02457c7880ad9428472b1a83f957d1df193594d3fc0ef601bfd235399204507076021e43ff7ca91ff000215f3948e7cde0715703396e42e9d3d0f34221c11529e49e28e40e4715689647b4e292552180c638cd3b90691cee3cfa53625b94d89498376ef56633b86ef5a85c6e52b8a6452143b0f6a84ec5bd5173a1c9a424e78a40dbf07b53d0e0f4ad3a11e43a2768f850bbb39c904e29ca771c77a737ca9b48c13fca92303774a491573e9cf84ebb3e19e8e307a4c79ff00aecf4527c266ddf0cb4724938f3864fb4ce28ac1ee59a7e3f247c3bf1211ff0040cb8ffd16d5f2911f27af15f567c40ff9275e24ff00b06dc7fe8b35f2bb639aa88a444382181a411091f970a0f734e2001c734a00e98fc6b42772bb28049cd1c608c751533a640c11cd3485db8cf34ae162a39118233dbd6aac43ceb92e73f28a9e790c53075557c1c60f22886328993c96e4d4ad5dc6f44591cc47072734d42c38279a41c700629fb49e3bd592381f9b2319a500b1fe669620401b8669f8e381409b0c12ad8e8382735d57803559343f1e6897a0b2db4921b4b83d8a4830327d982b7e15ca608fc6b57c3a627f1269b15c03e4bdc05623a8e0ed3ff7d6da996d62a1ab3eba66dabc727b531610012c324f5a7478650d9ce6a4accd76285ca8575238af07f17f84ed6efc4da9c9a53796c260301728ec55723db0d919af7abc04edaf2ab9852dfc67ab3264c5e70283d09505bf526b37a3345a9e751e8be20d2d0cad0ac7186c1532a90d938e99fc6bd63e134b34da46a71cf12c616e55b60903104ae0f1d8702b93d52f7edf3992220db45c467fbe7bb7f87ff5eb43e156ae1bc69abd9a93e5dc5945247e998d98123fefb1445eba89ab1ea732ff00674df6951fbb3f7c0ee2b555d5d03290548c822a19a213db3211d4553b5dfa7d888dc96c138cf6abd84d5cf19f8d77a2efc41651754b48a444e7f89b6173fa28fc2bc9d9724d7a27c5c2078aecd07cccb6ad239cf42ec31ffa0579f2e7774ab86c62f46c4c1c0f4a46e99a909fca9ac0019cfe15a124049ebd053411f8d4832c4f1bb8fcaa020eee0d02192139c7ad45346cc3728e40e6a5dac48cd46ce79553f5a865a62db3e463d2ad8ce4153cfb5538e2239cf5ab484818ad23b0a561db8b3fcc49a913961cd3636cf5ed53aa8ec2a90ada1f4d7c271b7e19e903febb7fe8e7a297e14e0fc34d1cfb4bff00a35e8ae67b9aa343c7a8d27c3ef11228249d3a7000193feacd7caec7e5f9718f715f58f8bffe44ad77fec1f71ffa2dabe4bea83046315502640171ce714e0b9c93d290641eb4161ea33deac91d242f108cbc6ea197721652370e991ea38355a770885863239a9848d9c67701c0aa73c6ce70dc11d854bbd8699027997123332f00e491560f00555025b7cf702ac24eb3ae0f0c2883d2c125d414f26a451c679a69040e680c76f35a124c0a81c1ce29e3a54099ce6a42c7ae78a09b0e21b1c1a0c92c31f9d09fdec643ae3d54e47ea0527246734e07e5fe6290e2ec7d75e1ed4a1d5b45b6bc82459239577065208ad5ed5e5ff04b506b8f09cb6523866b394a0e7a296661fa115ea1dab266eca97d22c50191ba2f27e95e1bab5fcad23c449135cb1795871b413d3f1af61f145c8b5d12e65270a88493e82be7fd53515b5496edce6591b08bfc87d05612d64689da241aeea46283ec509f99800d8fe11e95adf0bbccb6f1a69f74c08826325a0620e0b3465bafd571f522b95d2ac6e75bd4046ad9dc774b21fe11fe7a57a96916b0d95fe911431ed8e1ba8f685edf3609fd4d696b688495cf5f8cfca2b37549305507735a4846dac6bc3e65fc683d6890d1f3efc4bba6b9f883aaf076dbac36ebf846ac7f5735c901819eb5ade24bd4bff13eaf74a49f36f65ffc74ec18fc1456690046001cfa9ad63b1cf2d5911f51d4d348241e4d3fa1a631e0e0d5086a978a40e98efd46474c5376b119c7d682c7b1a562c508cd302b484952a9f7b3d7d2923b60a72dd6a68d82f040fad4848278a49751bd86051d874a070c734bd3273cd0496ec2ac9b0a83049ef52ab63a0cf15103823269eac011834c67d39f08df77c30d1b9070261c7b4ce28a8fe0ff00fc92ed2b9cfef2ebff004a25a2b99ee686ef8d54b7817c40abf78e9b7007fdfb6af93d58305206548e95f5a78bf3ff00085ebb8ebfd9f718ff00bf6d5f23c4d22c48c79217920d54497b8fc966c28e298c006627ad37cc258e0f5a8db3bb3bab427a0f32e7daa30c37939e7ad348f9aa58a3cf6e943b0b5b0c619e48e298f6ca3051b049ab0785c6de0542ee5b851923a54bd46ae44b395fddc832dd2a7182b93d6a25870d963927bd28055c13c8f4a681a6c9f3b47a50320714dde4b6e3c9273484e7a714f726cd13a90c0669d94c9c0c7a544b9db8a7e30b9cd02d4f5df8117a46b1ad5896e1a186651ef9707ff65af733d2be67f8457c6c7e2558a16c25ec32db9f4c85de3ff403f9d7d307a5652dcd96c70df12e4c785a58b71512cf0a920e380e1bff0065af9d2feea4d4b50c4285f90b1a0fe2ff00f5d7b5fc6fbf7b4f0adb448c43dcdeac60fb052c7f963f1af38f0568e327569d07cdc5b823a750cdf8f6ac92d6e6c8e9740d1e3d174f58f833360caf8ea7d3e8335d359c42031dc4d80c1d5b9fe000d4365079844ac3e45fba3d6b375dbf13e6da163e4c6434aca786208217e831cfe54efa95aee7b28e10fb5731aadf2d925edeb9c25ac0f2927b6066ba5320788b8e8466bccbe245e983c0bae943f3ce896e3fe072a29fd09a25b91d19e030bbbc29239cbb0dcd9f53c9fd6ac799918a63600a5546ca81d58d7424733119b1513b038c75a9246e70f9e38fa546401cd31098e3a528e99c52e782734dcfcbc503e81853918a0295e71951d7146334f525558763d690d0021b918229acbdc5358a0946de29e5d50316e71d3d29a6166263628661c1e94e8f96cf155c4a6439ede95621cf18a13b8ec7d33f077fe497693ff5d2e7ff004a25a28f83bff24b748ffae973ff00a512d158b2ce87c5dff226ebb8ff00a07cff00fa2dabe4605826dcf1b79afae3c6033e0ad7874ff8975c7fe8b6af90771f949e323a554497b884e0d272453988ef4c2ddb3d6ac943d4679a9439452738350ac98c29a6ca4f152d948944a64383d3d69c91850429e4f5a8a0915a32a40dd9eb5203cd0841c8392734840dbd2948e297786e3a63bd30231d69412ddba527e1cd293b4714c9b92e790694924545b8900548afc62988bba46a8da36af61aaa9e6cee12638fee8386ff00c749afb173c67b57c5728df6f2479fbea457d6de0ed506b5e0bd2351073e75aa163fed0183fa8359c8d2079e7c68b36d49bc3d62848125d4cee4738558c64ffe3d8fc4566da5b07548221e5a22f6fe115d7fc432be66984805b32e3ff1cae74bc5a5e9ed2ccdf37538ee7a003f31583674242eaba97d9e15b4b660b33af3b7fe59afafe3dab8af12ea2ba768d3a42d895e160a0755e0f3572eafc5a4535edd15677e4e3d7b01ed5c815b9d76f8c28bba697200c70063bfb538ab89b6f447d4ba6cde7683673139df6d1b67eaa0d7927c54b9dbe158e039c5d5f20ffbe417ff00d9457a7680be4f83b4e8cb96f2ece342c7a9c281fd2bc73e2b5c7fa1e81067969ae26fc9517ff67aa4bdf4899691679bb1ce0fad2972c304f4181484ff001534119cfad741cc213c7228037291ed9a1867a5285e0e78a07e646785038a4c0ce29cd81c76a418e0e290d075a4df839a767048038cd41336c523d6861a84677c8cd44ec7000a58178152bc79427a81de93d1157b95532a055fb7765040c0cf39aa5f286257a55c808c7ad1160cfa67e0f9ddf0c34b3d7325d73ff6f32d149f078e7e16e927fe9a5d7fe944b456651d078c38f056bdff0060eb8ffd16d5f20391b5339c8e6bebdf199dbe06f101e78d36e3a7fd736af8f1e40ea8c14631c81427625ad6e480fcdf5a4c7e54884103029d9e0f15a080601e78a1cfe54d278e9d682d9500d2b5c110abf9720f426aeaba93cd519c639152dbb6f8cf3c8a507d0a7a965df2781499c8e05223e1b2403529914b0e98ef5648cce5bd297029cea8586d231488a09c0f5a1310dc82d4a71da9ce0038c7e54aa0114c9003a0afa23e09df8b8f87496b9f9acaea6848cf405bcc1fa3d7cef9e4115ebdf02f500973afe9dbf86105d22e3bfcc8dfc92a27b1707a9d978be3f3b52b0727e4892538c7725467f4ae0351be5bebb6239820c84e7827b9fe95d3fc41d47cbb9b3b4898f9b3c4ec4a8fb881b07e84f41f8fa5797ebfa9fd9adfec909c3b8c363f857d2b996a747319fac6a66f6e48524c119c201dfdebb7f0a68674db333cea3ed728c91fdc1d85737e0ad185ec8750b840d04671103fc4dc827e82bd1ed6213b9527e44fbdee7b0ad1e8ac248ed344977f84a1382311baf3ecc47f4af12f8a52eed4f458bb476b2b9f6dcea3ff0065af60d36e57fb1678958318dd9081d89e71f91af10f8872b3f8cde1ce560b48571ee72c7ff421447e3154d11cc09760c0c63b8eb9e734d1ce0f4c52753ce29ddb19fceba4e71ad9ec6901273fad3db009c106985b1ed49808c38e29a411d3ad1f5a09c1f6a402a3b23e54f383d464723155263ba50bfad4e5b0bbbb555889790b9a4f72932cc6c1783d289dc946c03db1cd2819edc542f199a4099c293dfa0a52d8711b19c9e7f3ab11c817819f7aaec81187cd9f7f5a993af4a94ec51f507c1c39f85ba49f592e7ff4a25a293e0d1cfc2ad1c818cbdcff00e944945203a0f192eff03ebeb9c674eb8ffd16d5f1d2c78b7524e4902bed1d674f3ab6877fa6897c93776f241e66dddb37a95ce32338cf4cd78e9fd9eae0a051e2d8f8ff00a867ff006da5616b73c4a1563c5582853a8ea38af644fd9eee94e7fe12c8c7fdc34fff001da947ecfd72083ff096c7c7fd42ff00fb6d527a034788952091405af6c1fb3e5c0cff00c55711fae987ff008f527fc33e5ce7fe46c8c7fdc30fff001da77158f14788943c75a82206294039c74af73ff867eba0303c5711fae987ff008ed44ffb3ddd9208f14407fee1e47fed5a4f7b8d23c71938c8a154919af681f002f3660f8a60cffd838fff001da4ff0085037c3a789edbff0005edff00c76ab990ac78d18ce383527cd8e3a7715ec3ff000a0afb03fe2a7b61ff0070f6ff00e3b47fc283bf1d3c4d6bf8e9edff00c768e642e53c77daa451e95eb83e016a5bb3ff0009259ffe00b7ff001ca77fc284d480ff009192d33ff5e0dffc729f32172b3c819580e0f15d97c29be6b2f88b61183f25f4335b37d766f5fd531f8d756df01b5523fe462b1ffc027ffe3957744f82faae8fe20d33543afd9c82cae56628b68ca580e08ceff426a64d3438c6cccbf1d6aa89776b7079d96eca07a9f30d79ad9d9dcebdab8857716725a4907f02fad7b27883e0feabac5c5bc91ebb6aa225917125b31cee72c3a37618157bc39f0964d12d24f3753864b994e64912120103a0196e958c62d2d77364d231ecacd60b78ad2d902228c281fc22af5eddc7a5da288d7748dc44a4fde3ea7d87535d65a7825adc316be56763c9f2bb0ce00e7deb3ee7e1f5e5e5e3dc3ea908e708a213855f4ebd7d69b4d8f991cd6857e6db4e9207725e5b92493fc4cc064d79978c1d64f1debadf782ceb18e7fbb1a2ff004af5e87e17eb11ea2f336b36860fb4c52a2085b2aabd475ea6b16ffe09eaf7bab5fde9d6ec47da677940303e40249c1e7d31550d257644ddd1e3db0924e2868d81c9af5c3f02f59c7cbad69e0fbc0ffe34d6f815ad1271ade9f8f785ff00c6b5e6465cacf22643d8530ab13d6bd7ff00e145eb5b7fe42fa713fee38a60f813adf3ff00136d3c7e0ffe147321f2b3c8c8c714854edce2bd70fc0ad740e354d349f7de3ff65a69f815af9e3fb474bc7fbd27ff001347320b33c7ae032a63a668850af26bd75fe03ebef282751d2ca81c7cd275ff00be6947c0af108ff97fd2b1ff005d241ffb254df5b8eda1e4d924f038a6ccef819c0edc0af5aff8513e23ff009ffd27fefe49ff00c4542ff023c4edf76fb473f59651ff00b4e86ee091e4e54156ddf7bb11daa5585fca0dfc3d8d7a7ffc286f1667fe3f744ffbff002fff001ba53f023c5bb0017da271d8cf2fff001ba828f4df8319ff008551a367aeeb9ffd28928ad6f0068179e17f05d8e8f7ed03dcc0d333b40c593e795dc60900f461da8a6074f4514500149451400b451450014514500145145001451450014514500149451400b45145001451450014514500145145001451450014868a280168a28a0028a28a0028a28a0028a28a00ffd9	\N	Sr Sridhar	\N	2021-12-01 00:23:46.148	2021-12-01 00:23:46.148	\N	\N	\N	\N	\N	\N	\N	\N	RAJ1.JPG	\N	666666666666	\N	Y	Y	\N	0
3	SAMPLE000003	Lakshmi Rajeswara Rao	A	2021-12-07 22:24:49.871	M	9866489944	9944994499	dd@dd.com	Test	1982-08-01	\N	\N	Seeta Rama Prasad	\N	2021-12-07 22:24:49.871	2021-12-07 22:24:49.871	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	442323232333		A	A	\N	0
4	SAMPLE000004	Lakshmi Rajeswara Rao	A	2021-12-07 22:29:02.446	M	9866489944	9944994499	dd@dd.com	Test	1982-08-01	\N	\N	Seeta Rama Prasad	\N	2021-12-07 22:29:02.446	2021-12-07 22:29:02.446	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	442323232333		A	A	\N	0
5	SAMPLE000005	Lakshmi Rajeswara Rao	A	2021-12-07 22:29:05.429	M	9866489944	9944994499	dd@dd.com	Test	1982-08-01	\N	\N	Seeta Rama Prasad	\N	2021-12-07 22:29:05.429	2021-12-07 22:29:05.429	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	442323232333		A	A	\N	0
6	SAMPLE000006	Test	A	2021-12-11 23:14:15.646	M	\N	\N	raje@gmail.com	\N	\N	\N	\N	\N	\N	2021-12-11 23:14:15.647	2021-12-11 23:14:15.646	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	A	Register	0
7	SAMPLE000007	Test	A	2021-12-12 23:42:18.909	M	\N	\N	fdf@g.com	\N	\N	\N	\N	\N	\N	2021-12-12 23:42:18.909	2021-12-12 23:42:18.909	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	A	A	TT	\N
1	SAMPLE000001	Lakshmi Rajeswara	A	\N	M	9866489944	9944994499	dd@dd.com	Test	\N	\N	\N	Seeta Rama Prasad	\N	2021-12-13 20:53:59.072	2021-12-13 20:53:59.072	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	442323232333		A	A	Rao	\N
\.


--
-- Data for Name: recruitment_user_experiences; Type: TABLE DATA; Schema: public; Owner: sample
--

COPY recruitment_user_experiences (id, user_id, company, from_date, to_date, exp_months, designation, job_location, is_current_job) FROM stdin;
45	SAMPLE000002	Testcom	2001-01-01	2002-02-02	2	\N	\N	N
46	SAMPLE000002	JJ	2002-02-02	2003-03-03	4	\N	\N	N
65	SAMPLE000001	Testcom	2005-08-31	2008-12-15	37	Test Desig	Test Location	Y
66	SAMPLE000001	Testcom	2005-08-31	2008-12-15	39			Y
67	SAMPLE000001	TT	2001-11-11	2002-12-12	34			Y
68	SAMPLE000001	FF	2010-10-10	2018-08-08	31			Y
69	SAMPLE000001	GG	2009-09-09	2010-10-10	29			Y
70	SAMPLE000001	II	2007-07-07	2008-08-08	27			Y
\.


--
-- Name: recruitment_user_experiences_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sample
--

SELECT pg_catalog.setval('recruitment_user_experiences_id_seq', 70, true);


--
-- Name: recruitment_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sample
--

SELECT pg_catalog.setval('recruitment_user_id_seq', 100000, true);


--
-- Data for Name: recruitment_user_log; Type: TABLE DATA; Schema: public; Owner: sample
--

COPY recruitment_user_log (id, user_id, login_time, logout_time, ipaddress, hostname, role_id) FROM stdin;
\.


--
-- Name: recruitment_user_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sample
--

SELECT pg_catalog.setval('recruitment_user_log_id_seq', 1, false);


--
-- Data for Name: recruitment_user_qualifications; Type: TABLE DATA; Schema: public; Owner: sample
--

COPY recruitment_user_qualifications (id, user_id, qualification, percentage, board_university, specialization, institute_name, start_date, completion_date) FROM stdin;
4	SAMPLE000002	Qly	90.00	Osmania	\N	\N	\N	\N
32	SAMPLE000001	ff	60.00	JJ	ff	dd	\N	\N
33	SAMPLE000001	Qly	90.00	Osmania			\N	\N
34	SAMPLE000001	Qlyy	80.00	JNTUH			\N	\N
35	SAMPLE000001	Qlyyy	70.00	JNTUK			\N	\N
36	SAMPLE000001	QL	40.00	hh	ff	cc	\N	\N
\.


--
-- Name: recruitment_user_qualifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sample
--

SELECT pg_catalog.setval('recruitment_user_qualifications_id_seq', 36, true);


--
-- Data for Name: recruitment_user_skills; Type: TABLE DATA; Schema: public; Owner: sample
--

COPY recruitment_user_skills (id, user_id, skill_id, skill_level, exp_months) FROM stdin;
\.


--
-- Name: recruitment_user_skills_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sample
--

SELECT pg_catalog.setval('recruitment_user_skills_id_seq', 1, false);


--
-- Data for Name: recruitment_users_jobs; Type: TABLE DATA; Schema: public; Owner: sample
--

COPY recruitment_users_jobs (id, user_id, job_id, applied_date, applied_flag, ignored_flag, ignored_date, selected_flag, selected_date) FROM stdin;
\.


--
-- Name: recruitment_users_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sample
--

SELECT pg_catalog.setval('recruitment_users_jobs_id_seq', 1, false);


--
-- Data for Name: role_services; Type: TABLE DATA; Schema: public; Owner: sample
--

COPY role_services (role_id, service_id) FROM stdin;
1	1
1	15
1	16
1	17
1	18
1	28
1	29
1	91
1	92
1	93
9	1
9	15
9	18
9	91
9	92
9	93
9	94
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: sample
--

COPY roles (role_id, role_name) FROM stdin;
1	Admin
2	User
9	Job Seeker
\.


--
-- Name: roles_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sample
--

SELECT pg_catalog.setval('roles_role_id_seq', 1, false);


--
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: sample
--

COPY services (service_id, service_url, service_name, disabled, parent_id, display_order, menu_display, has_childs) FROM stdin;
16	/home	Admin Services	f	0	6	t	t
17	/admin/user/add	User Creation	f	16	1	t	f
15	/logout	Log Out	f	0	10	t	f
23	/home	Management Reports	f	0	6	t	t
28	/admin/usersList	Users List	f	16	3	t	f
37	/management/managementDashboard	Management Dashboard	f	23	38	t	f
29	/super/roleServices	Role Services Mapping	f	16	4	t	f
18	/changePassword	Change Password	f	16	2	t	f
92	/recruitment/compiler	Compiler Test	f	91	3	t	f
93	/recruitment/jobSeeker	Registration	f	91	1	t	f
94	/recruitment/jobSeekerPreferences	Registration Preferences	f	91	2	f	f
91	/home	Recruitment	f	0	9	t	t
22	/management/managementReport	Management Report	f	23	41	t	f
1	/home	Home	f	0	1	t	f
\.


--
-- Name: services_service_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sample
--

SELECT pg_catalog.setval('services_service_id_seq', 1, false);


--
-- Data for Name: user_details; Type: TABLE DATA; Schema: public; Owner: sample
--

COPY user_details (id, user_id, dob, address, is_acrive, short_name, gender, mother_name, father_name, mother_tongue, phc, blood_group, marital_status, spouse_name, marks_of_identity1, marks_of_identity2, person_mobile, person_phone_std, office_mobile, office_phone_std, person_mail, office_mail, state, city, postal_code, permanent_address, permanent_state, permanent_city, permanent_postal_code, emergency_contact_person, emergency_relation, emergency_phone_no1, emergency_phone_no2, emergency_address, aadhar_no, pan_no, passport_no, photo_path, bank_name, branch_name, ifsc_code, account_no) FROM stdin;
\.


--
-- Name: user_details_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sample
--

SELECT pg_catalog.setval('user_details_id_seq', 1, false);


--
-- Data for Name: user_role_id_mapping; Type: TABLE DATA; Schema: public; Owner: sample
--

COPY user_role_id_mapping (user_id, role_id, id) FROM stdin;
\.


--
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: sample
--

COPY user_roles (user_id, role_id) FROM stdin;
13	9
14	9
15	9
16	9
17	9
23	9
24	9
1	1
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: sample
--

COPY users (id, user_name, password, disabled, user_desc, email, last_login, failed_login_attempts, last_password_change) FROM stdin;
2	management	$2a$10$/Vq9fiMAIpZj7yd8MO46I.V0G0scg3wEuLNhoy91kyCqol1dNeNFG	f	Management Login	\N	2019-08-02 04:55:09	0	2019-05-03 05:32:11
4	super	$2a$10$WvPD/76KaGt3Bny6OXdRTeXBI6GThwE.eeqFXLODkb58yBLKuITgm	f	Supervizor Login	\N	2019-06-03 04:55:26	0	\N
1	admin	$2a$10$2ywcf.uWfZtKiH8cdWS7/.0UD1mXSgXFqf6VjMdqmcer1RGhk8rBq	f	Admin User	\N	2021-12-11 21:05:04.123	0	2019-05-02 13:00:00
16	SAMPLE000004	$2a$10$XaGREVjSVkhIm4GPLn6ByOgi9RYZtr8gQh04HlRX5JCOd6NZQZy5i	f	JJ	rdd@g.com	2021-11-30 22:21:12.068	0	\N
17	SAMPLE000005	$2a$10$g3BzyDAkzSa4CxWy.SLzS.3r1TszqUjDdtuTXBEziqpl48QhkD0LO	f	Ramu	d@g.com	2021-11-30 22:45:52.115	0	\N
23	SAMPLE000006	$2a$10$I0a82/TFHZ3GUe9W0/l0u.cynQxY6Dq0qVfiCQXYHspYDbvRDFHGS	f	Test Register	raje@gmail.com	2021-12-11 23:18:20.862	0	\N
24	SAMPLE000007	$2a$10$AbgzpYE5dG4CQEfpkTpGR.VXWeZ9npXl/YVZ8U1zNM.7t2gP0dx.u	f	Test TT	fdf@g.com	\N	\N	\N
13	SAMPLE000001	$2a$10$B4pd6f.lWsXBmD59fvPjo.wIveIMgoFYfLFJrutt7GqN/UrwmeAey	f	Lakshmi Rajeswara Rao tttesting	dd@dd.com	2021-12-13 21:25:30.029	0	2021-11-30 16:15:35.134
14	SAMPLE000002	$2a$10$Sb7nUXt8uNl0fZ72onKGa.e7vQsO2vbtuF3tmG/77.CDAO3N2RXXC	f	Lakshmi Rajeswara Rao	rdd@g.com	2021-12-13 21:35:32.146	0	2021-11-29 18:44:49.385
15	SAMPLE000003	$2a$10$BzqsIT/gCXu1EBgtDQF1N.M34yyXYzpuCnPCBzZGrCWUFv13/QaaG	f	Jyothirmayee	j@g.com	2021-11-30 18:12:00.157	0	\N
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sample
--

SELECT pg_catalog.setval('users_id_seq', 1, false);


--
-- Name: recruitment_designation_mst_pkey; Type: CONSTRAINT; Schema: public; Owner: sample; Tablespace: 
--

ALTER TABLE ONLY recruitment_designation_mst
    ADD CONSTRAINT recruitment_designation_mst_pkey PRIMARY KEY (designation_id);


--
-- Name: recruitment_experience_level_pkey; Type: CONSTRAINT; Schema: public; Owner: sample; Tablespace: 
--

ALTER TABLE ONLY recruitment_experience_level
    ADD CONSTRAINT recruitment_experience_level_pkey PRIMARY KEY (exp_id);


--
-- Name: recruitment_job_post_master_pkey; Type: CONSTRAINT; Schema: public; Owner: sample; Tablespace: 
--

ALTER TABLE ONLY recruitment_job_post_master
    ADD CONSTRAINT recruitment_job_post_master_pkey PRIMARY KEY (job_id);


--
-- Name: recruitment_qualifications_pkey; Type: CONSTRAINT; Schema: public; Owner: sample; Tablespace: 
--

ALTER TABLE ONLY recruitment_qualifications
    ADD CONSTRAINT recruitment_qualifications_pkey PRIMARY KEY (qualification_id);


--
-- Name: recruitment_skill_pkey; Type: CONSTRAINT; Schema: public; Owner: sample; Tablespace: 
--

ALTER TABLE ONLY recruitment_skill
    ADD CONSTRAINT recruitment_skill_pkey PRIMARY KEY (skill_id);


--
-- Name: recruitment_skill_type_pkey; Type: CONSTRAINT; Schema: public; Owner: sample; Tablespace: 
--

ALTER TABLE ONLY recruitment_skill_type
    ADD CONSTRAINT recruitment_skill_type_pkey PRIMARY KEY (skill_type_id);


--
-- Name: recruitment_user_experiences_pkey; Type: CONSTRAINT; Schema: public; Owner: sample; Tablespace: 
--

ALTER TABLE ONLY recruitment_user_experiences
    ADD CONSTRAINT recruitment_user_experiences_pkey PRIMARY KEY (id);


--
-- Name: recruitment_user_qualifications_pkey; Type: CONSTRAINT; Schema: public; Owner: sample; Tablespace: 
--

ALTER TABLE ONLY recruitment_user_qualifications
    ADD CONSTRAINT recruitment_user_qualifications_pkey PRIMARY KEY (id);


--
-- Name: recruitment_user_skills_pkey; Type: CONSTRAINT; Schema: public; Owner: sample; Tablespace: 
--

ALTER TABLE ONLY recruitment_user_skills
    ADD CONSTRAINT recruitment_user_skills_pkey PRIMARY KEY (id);


--
-- Name: recruitment_users_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: sample; Tablespace: 
--

ALTER TABLE ONLY recruitment_users_jobs
    ADD CONSTRAINT recruitment_users_jobs_pkey PRIMARY KEY (id);


--
-- Name: recruitment_users_pkey; Type: CONSTRAINT; Schema: public; Owner: sample; Tablespace: 
--

ALTER TABLE ONLY recruitment_user
    ADD CONSTRAINT recruitment_users_pkey PRIMARY KEY (user_id);


--
-- Name: role_services_role_id_service_id_key; Type: CONSTRAINT; Schema: public; Owner: sample; Tablespace: 
--

ALTER TABLE ONLY role_services
    ADD CONSTRAINT role_services_role_id_service_id_key UNIQUE (role_id, service_id);


--
-- Name: roles_pkey; Type: CONSTRAINT; Schema: public; Owner: sample; Tablespace: 
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (role_id);


--
-- Name: services_pkey; Type: CONSTRAINT; Schema: public; Owner: sample; Tablespace: 
--

ALTER TABLE ONLY services
    ADD CONSTRAINT services_pkey PRIMARY KEY (service_id);


--
-- Name: uk_1h3n0g7ripnxdhwsngyn9ey2o; Type: CONSTRAINT; Schema: public; Owner: sample; Tablespace: 
--

ALTER TABLE ONLY recruitment_user
    ADD CONSTRAINT uk_1h3n0g7ripnxdhwsngyn9ey2o UNIQUE (user_id);


--
-- Name: user_details_pkey; Type: CONSTRAINT; Schema: public; Owner: sample; Tablespace: 
--

ALTER TABLE ONLY user_details
    ADD CONSTRAINT user_details_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: sample; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users_unique; Type: CONSTRAINT; Schema: public; Owner: sample; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_unique UNIQUE (user_name);


--
-- Name: job_did_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sample
--

ALTER TABLE ONLY recruitment_job_post_master
    ADD CONSTRAINT job_did_fkey FOREIGN KEY (designation_id) REFERENCES recruitment_designation_mst(designation_id);


--
-- Name: job_expid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sample
--

ALTER TABLE ONLY recruitment_job_post_master
    ADD CONSTRAINT job_expid_fkey FOREIGN KEY (experience_level) REFERENCES recruitment_experience_level(exp_id);


--
-- Name: jobid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sample
--

ALTER TABLE ONLY recruitment_job_post_roles
    ADD CONSTRAINT jobid_fkey FOREIGN KEY (job_id) REFERENCES recruitment_job_post_master(job_id);


--
-- Name: jobid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sample
--

ALTER TABLE ONLY recruitment_job_post_skillset
    ADD CONSTRAINT jobid_fkey FOREIGN KEY (job_id) REFERENCES recruitment_job_post_master(job_id);


--
-- Name: jopb_empid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sample
--

ALTER TABLE ONLY recruitment_job_post_master
    ADD CONSTRAINT jopb_empid_fkey FOREIGN KEY (posted_by_id_emp_id) REFERENCES users(id);


--
-- Name: recruitment_skill_skill_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sample
--

ALTER TABLE ONLY recruitment_skill
    ADD CONSTRAINT recruitment_skill_skill_type_id_fkey FOREIGN KEY (skill_type_id) REFERENCES recruitment_skill_type(skill_type_id);


--
-- Name: recruitment_user_skills_skill_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sample
--

ALTER TABLE ONLY recruitment_user_skills
    ADD CONSTRAINT recruitment_user_skills_skill_id_fkey FOREIGN KEY (skill_id) REFERENCES recruitment_skill(skill_id);


--
-- Name: recruitment_user_skills_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sample
--

ALTER TABLE ONLY recruitment_user_skills
    ADD CONSTRAINT recruitment_user_skills_user_id_fkey FOREIGN KEY (user_id) REFERENCES recruitment_user(user_id);


--
-- Name: role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sample
--

ALTER TABLE ONLY user_role_id_mapping
    ADD CONSTRAINT role_id_fkey FOREIGN KEY (role_id) REFERENCES roles(role_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: role_services_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sample
--

ALTER TABLE ONLY role_services
    ADD CONSTRAINT role_services_role_id_fkey FOREIGN KEY (role_id) REFERENCES roles(role_id);


--
-- Name: role_services_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sample
--

ALTER TABLE ONLY role_services
    ADD CONSTRAINT role_services_service_id_fkey FOREIGN KEY (service_id) REFERENCES services(service_id);


--
-- Name: uj_jobid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sample
--

ALTER TABLE ONLY recruitment_users_jobs
    ADD CONSTRAINT uj_jobid_fkey FOREIGN KEY (job_id) REFERENCES recruitment_job_post_master(job_id);


--
-- Name: uj_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sample
--

ALTER TABLE ONLY recruitment_users_jobs
    ADD CONSTRAINT uj_userid_fkey FOREIGN KEY (user_id) REFERENCES recruitment_user(user_id);


--
-- Name: ul_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sample
--

ALTER TABLE ONLY recruitment_user_log
    ADD CONSTRAINT ul_userid_fkey FOREIGN KEY (user_id) REFERENCES recruitment_user(user_id);


--
-- Name: ur_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sample
--

ALTER TABLE ONLY recruitment_user_qualifications
    ADD CONSTRAINT ur_userid_fkey FOREIGN KEY (user_id) REFERENCES recruitment_user(user_id);


--
-- Name: ur_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sample
--

ALTER TABLE ONLY recruitment_user_experiences
    ADD CONSTRAINT ur_userid_fkey FOREIGN KEY (user_id) REFERENCES recruitment_user(user_id);


--
-- Name: user_details_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sample
--

ALTER TABLE ONLY user_details
    ADD CONSTRAINT user_details_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sample
--

ALTER TABLE ONLY user_role_id_mapping
    ADD CONSTRAINT user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_roles_ibfk_1; Type: FK CONSTRAINT; Schema: public; Owner: sample
--

ALTER TABLE ONLY user_roles
    ADD CONSTRAINT user_roles_ibfk_1 FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_roles_ibfk_2; Type: FK CONSTRAINT; Schema: public; Owner: sample
--

ALTER TABLE ONLY user_roles
    ADD CONSTRAINT user_roles_ibfk_2 FOREIGN KEY (role_id) REFERENCES roles(role_id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

