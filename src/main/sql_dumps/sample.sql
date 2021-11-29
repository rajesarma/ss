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
-- Name: recruitment_district_master; Type: TABLE; Schema: public; Owner: sample; Tablespace: 
--

CREATE TABLE recruitment_district_master (
    district_id integer NOT NULL,
    district_name character varying(100),
    state_id integer
);


ALTER TABLE public.recruitment_district_master OWNER TO sample;

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
-- Name: recruitment_sms_track_list; Type: TABLE; Schema: public; Owner: sample; Tablespace: 
--

CREATE TABLE recruitment_sms_track_list (
    id bigint NOT NULL,
    mobile_no character varying(50) NOT NULL,
    sms_text character varying(1000) NOT NULL,
    response_code character varying(200) NOT NULL,
    sent_date timestamp without time zone NOT NULL
);


ALTER TABLE public.recruitment_sms_track_list OWNER TO sample;

--
-- Name: recruitment_state_master; Type: TABLE; Schema: public; Owner: sample; Tablespace: 
--

CREATE TABLE recruitment_state_master (
    state_id integer NOT NULL,
    state_name character varying(100)
);


ALTER TABLE public.recruitment_state_master OWNER TO sample;

--
-- Name: recruitment_user; Type: TABLE; Schema: public; Owner: sample; Tablespace: 
--

CREATE TABLE recruitment_user (
    id integer NOT NULL,
    user_id character varying(50) NOT NULL,
    full_name character varying(100),
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
    aadhar character varying(12)
);


ALTER TABLE public.recruitment_user OWNER TO sample;

--
-- Name: recruitment_user_experiences; Type: TABLE; Schema: public; Owner: sample; Tablespace: 
--

CREATE TABLE recruitment_user_experiences (
    id integer NOT NULL,
    user_id character varying(50) NOT NULL,
    company character varying(100),
    experience_month numeric(10,0),
    from_date date,
    to_date date
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
    state_id integer
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
    menu_display boolean
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

SELECT pg_catalog.setval('hibernate_sequence', 14, true);


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
-- Data for Name: recruitment_district_master; Type: TABLE DATA; Schema: public; Owner: sample
--

COPY recruitment_district_master (district_id, district_name, state_id) FROM stdin;
17	MEDAK	2
10	CHITTOOR	1
11	YSR KADAPA	1
23	NALGONDA	2
22	KHAMMAM	2
8	PRAKASAM	1
5	WEST GODAVARI	1
15	RANGA REDDY	2
14	MAHABUBNAGAR	2
20	KARIMNAGAR	2
3	VISAKHAPATNAM	1
1	SRIKAKULAM	1
12	ANANTAPUR	1
19	ADILABAD	2
9	SPSR NELLORE	1
18	NIZAMABAD	2
4	EAST GODAVARI	1
7	GUNTUR	1
21	WARANGAL	2
13	KURNOOL	1
6	KRISHNA	1
16	HYDERABAD	2
2	VIZIANAGARAM	1
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
-- Data for Name: recruitment_sms_track_list; Type: TABLE DATA; Schema: public; Owner: sample
--

COPY recruitment_sms_track_list (id, mobile_no, sms_text, response_code, sent_date) FROM stdin;
\.


--
-- Data for Name: recruitment_state_master; Type: TABLE DATA; Schema: public; Owner: sample
--

COPY recruitment_state_master (state_id, state_name) FROM stdin;
1	Andhra Pradesh
2	Telangana
\.


--
-- Data for Name: recruitment_user; Type: TABLE DATA; Schema: public; Owner: sample
--

COPY recruitment_user (id, user_id, full_name, is_active, created_on, gender, mobile, alternate_no, email, address, dob, photo, resume, father_name, marital_status, updated_on, last_login, shortlisted_flag, shortlisted_date, interview_scheduled_date, interview_attended_flag, selected_status, selected_date, offer_letter_generated, offer_letter_generated_date, photo_name, resume_name, aadhar) FROM stdin;
1	SAMPLE000001	Lakshmi Rajeswara Rao	A	2021-11-29 18:09:03.725	M	9866489944	9944994499	dd@dd.com	Test	1982-08-01	\N	\N	Seeta Rama Prasad	\N	2021-11-29 18:09:03.725	2021-11-29 18:09:03.725	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	442323232333
2	SAMPLE000002	Lakshmi Rajeswara Rao	A	2021-11-29 18:43:58.425	M	4444444444	4444444444	rdd@g.com	Test	1982-08-01	\N	\N	Seeta Rama Prasad	\N	2021-11-29 18:43:58.425	2021-11-29 18:43:58.425	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	999999999999
\.


--
-- Data for Name: recruitment_user_experiences; Type: TABLE DATA; Schema: public; Owner: sample
--

COPY recruitment_user_experiences (id, user_id, company, experience_month, from_date, to_date) FROM stdin;
\.


--
-- Name: recruitment_user_experiences_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sample
--

SELECT pg_catalog.setval('recruitment_user_experiences_id_seq', 1, false);


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

COPY recruitment_user_qualifications (id, user_id, qualification, percentage, board_university, state_id) FROM stdin;
\.


--
-- Name: recruitment_user_qualifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sample
--

SELECT pg_catalog.setval('recruitment_user_qualifications_id_seq', 1, false);


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

COPY services (service_id, service_url, service_name, disabled, parent_id, display_order, menu_display) FROM stdin;
1	/home	Home	f	0	1	t
15	/logout	Log Out	f	0	10	t
16	/home	Admin Services	f	0	6	t
17	/admin/user/add	User Creation	f	16	1	t
18	/changePassword	Change Password	f	16	2	t
22	/management/managementReport	Management Report	f	23	41	t
23	/home	Management Reports	f	0	6	t
28	/admin/usersList	Users List	f	16	3	t
29	/super/roleServices	Role Services Mapping	f	16	4	t
37	/management/managementDashboard	Management Dashboard	f	23	38	t
91	/home	Recruitment	f	0	9	t
92	/recruitment/compiler	Compiler Test	f	91	3	t
93	/recruitment/jobSeeker	Registration	f	91	1	t
94	/recruitment/jobSeekerPreferences	Registration Preferences	f	91	2	f
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
1	1
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: sample
--

COPY users (id, user_name, password, disabled, user_desc, email, last_login, failed_login_attempts, last_password_change) FROM stdin;
2	management	$2a$10$/Vq9fiMAIpZj7yd8MO46I.V0G0scg3wEuLNhoy91kyCqol1dNeNFG	f	Management Login	\N	2019-08-02 04:55:09	0	2019-05-03 05:32:11
4	super	$2a$10$WvPD/76KaGt3Bny6OXdRTeXBI6GThwE.eeqFXLODkb58yBLKuITgm	f	Supervizor Login	\N	2019-06-03 04:55:26	0	\N
13	SAMPLE000001	$2a$10$fzNoZcaBx63CsMyPoxUuCOjccLZDeLhuZH3EC492uMtQn/Zl7giHS	f	Lakshmi Rajeswara Rao	dd@dd.com	2021-11-29 18:09:23.078	0	\N
1	admin	$2a$10$2ywcf.uWfZtKiH8cdWS7/.0UD1mXSgXFqf6VjMdqmcer1RGhk8rBq	f	Admin User	\N	2021-11-29 21:47:46.366	0	2019-05-02 13:00:00
14	SAMPLE000002	$2a$10$Sb7nUXt8uNl0fZ72onKGa.e7vQsO2vbtuF3tmG/77.CDAO3N2RXXC	f	Lakshmi Rajeswara Rao	rdd@g.com	2021-11-29 23:51:35.275	0	2021-11-29 18:44:49.385
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
-- Name: recruitment_district_master_pkey; Type: CONSTRAINT; Schema: public; Owner: sample; Tablespace: 
--

ALTER TABLE ONLY recruitment_district_master
    ADD CONSTRAINT recruitment_district_master_pkey PRIMARY KEY (district_id);


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
-- Name: recruitment_sms_track_list_pkey; Type: CONSTRAINT; Schema: public; Owner: sample; Tablespace: 
--

ALTER TABLE ONLY recruitment_sms_track_list
    ADD CONSTRAINT recruitment_sms_track_list_pkey PRIMARY KEY (id);


--
-- Name: recruitment_state_master_pkey; Type: CONSTRAINT; Schema: public; Owner: sample; Tablespace: 
--

ALTER TABLE ONLY recruitment_state_master
    ADD CONSTRAINT recruitment_state_master_pkey PRIMARY KEY (state_id);


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
-- Name: sms_sent_index; Type: INDEX; Schema: public; Owner: sample; Tablespace: 
--

CREATE INDEX sms_sent_index ON recruitment_sms_track_list USING btree (id, sent_date, response_code);


--
-- Name: dm_stateid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sample
--

ALTER TABLE ONLY recruitment_district_master
    ADD CONSTRAINT dm_stateid_fkey FOREIGN KEY (state_id) REFERENCES recruitment_state_master(state_id);


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
-- Name: ur_state_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sample
--

ALTER TABLE ONLY recruitment_user_qualifications
    ADD CONSTRAINT ur_state_id_fkey FOREIGN KEY (state_id) REFERENCES recruitment_state_master(state_id);


--
-- Name: ur_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sample
--

ALTER TABLE ONLY recruitment_user_experiences
    ADD CONSTRAINT ur_userid_fkey FOREIGN KEY (user_id) REFERENCES recruitment_user(user_id);


--
-- Name: ur_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sample
--

ALTER TABLE ONLY recruitment_user_qualifications
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

