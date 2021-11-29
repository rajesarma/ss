-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               PostgreSQL 9.3.11, compiled by Visual C++ build 1600, 64-bit
-- Server OS:                    
-- HeidiSQL Version:             10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES  */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table public.roles
CREATE TABLE IF NOT EXISTS "roles" (
	"role_id" INTEGER NOT NULL DEFAULT nextval('roles_role_id_seq'::regclass) COMMENT E'',
	"role_name" CHARACTER VARYING(100) NULL DEFAULT NULL::character varying COMMENT E'',
	PRIMARY KEY ("role_id")
);

-- Dumping data for table public.roles: 0 rows
/*!40000 ALTER TABLE "roles" DISABLE KEYS */;
INSERT INTO "roles" ("role_id", "role_name") VALUES
	(1, E'Admin'),
	(2, E'User'),
	(9, E'Job Seeker');
/*!40000 ALTER TABLE "roles" ENABLE KEYS */;

-- Dumping structure for table public.role_services
CREATE TABLE IF NOT EXISTS "role_services" (
	"role_id" INTEGER NULL DEFAULT NULL COMMENT E'',
	"service_id" INTEGER NULL DEFAULT NULL COMMENT E'',
	UNIQUE KEY ("service_id")
);

-- Dumping data for table public.role_services: 10 rows
/*!40000 ALTER TABLE "role_services" DISABLE KEYS */;
INSERT INTO "role_services" ("role_id", "service_id") VALUES
	(1, 1),
	(1, 15),
	(1, 16),
	(1, 17),
	(1, 18),
	(1, 28),
	(1, 29),
	(1, 91),
	(1, 92),
	(1, 93);
/*!40000 ALTER TABLE "role_services" ENABLE KEYS */;

-- Dumping structure for table public.services
CREATE TABLE IF NOT EXISTS "services" (
	"service_id" INTEGER NOT NULL DEFAULT nextval('services_service_id_seq'::regclass) COMMENT E'',
	"service_url" CHARACTER VARYING(100) NULL DEFAULT NULL COMMENT E'',
	"service_name" CHARACTER VARYING(25) NULL DEFAULT NULL COMMENT E'',
	"disabled" BOOLEAN NULL DEFAULT NULL COMMENT E'',
	"parent_id" INTEGER NULL DEFAULT NULL COMMENT E'',
	"display_order" INTEGER NULL DEFAULT NULL COMMENT E'',
	"menu_display" BOOLEAN NULL DEFAULT NULL COMMENT E'',
	PRIMARY KEY ("service_id")
);

-- Dumping data for table public.services: 0 rows
/*!40000 ALTER TABLE "services" DISABLE KEYS */;
INSERT INTO "services" ("service_id", "service_url", "service_name", "disabled", "parent_id", "display_order", "menu_display") VALUES
	(1, E'/home', E'Home', E'false', 0, 1, E'true'),
	(15, E'/logout', E'Log Out', E'false', 0, 10, E'true'),
	(16, E'/home', E'Admin Services', E'false', 0, 6, E'true'),
	(17, E'/admin/user/add', E'User Creation', E'false', 16, 1, E'true'),
	(18, E'/changePassword', E'Change Password', E'false', 16, 2, E'true'),
	(22, E'/management/managementReport', E'Management Report', E'false', 23, 41, E'true'),
	(23, E'/home', E'Management Reports', E'false', 0, 6, E'true'),
	(28, E'/admin/usersList', E'Users List', E'false', 16, 3, E'true'),
	(29, E'/super/roleServices', E'Role Services Mapping', E'false', 16, 4, E'true'),
	(37, E'/management/managementDashboard', E'Management Dashboard', E'false', 23, 38, E'true'),
	(91, E'/home', E'Recruitment', E'false', 0, 9, E'true'),
	(92, E'/recruitment/compiler', E'Compiler Test', E'false', 91, 1, E'true'),
	(93, E'/recruitment/jobSeeker', E'Job Seeker', E'false', 91, 2, E'true');
/*!40000 ALTER TABLE "services" ENABLE KEYS */;

-- Dumping structure for table public.users
CREATE TABLE IF NOT EXISTS "users" (
	"id" INTEGER NOT NULL DEFAULT nextval('users_id_seq'::regclass) COMMENT E'',
	"user_name" CHARACTER VARYING(100) NULL DEFAULT NULL::character varying COMMENT E'',
	"password" CHARACTER VARYING(100) NULL DEFAULT NULL::character varying COMMENT E'',
	"disabled" BOOLEAN NULL DEFAULT false COMMENT E'',
	"user_desc" CHARACTER VARYING(100) NULL DEFAULT NULL::character varying COMMENT E'',
	"email" CHARACTER VARYING(100) NULL DEFAULT NULL::character varying COMMENT E'',
	"last_login" TIMESTAMP WITHOUT TIME ZONE NULL DEFAULT NULL COMMENT E'',
	"failed_login_attempts" BIGINT NULL DEFAULT NULL COMMENT E'',
	"last_password_change" TIMESTAMP WITHOUT TIME ZONE NULL DEFAULT NULL COMMENT E'',
	PRIMARY KEY ("id"),
	UNIQUE KEY ("user_name")
);

-- Dumping data for table public.users: 3 rows
/*!40000 ALTER TABLE "users" DISABLE KEYS */;
INSERT INTO "users" ("id", "user_name", "password", "disabled", "user_desc", "email", "last_login", "failed_login_attempts", "last_password_change") VALUES
	(2, E'management', E'$2a$10$/Vq9fiMAIpZj7yd8MO46I.V0G0scg3wEuLNhoy91kyCqol1dNeNFG', E'false', E'Management Login', NULL, E'2019-08-02 04:55:09', 0, E'2019-05-03 05:32:11'),
	(4, E'super', E'$2a$10$WvPD/76KaGt3Bny6OXdRTeXBI6GThwE.eeqFXLODkb58yBLKuITgm', E'false', E'Supervizor Login', NULL, E'2019-06-03 04:55:26', 0, NULL),
	(1, E'admin', E'$2a$10$2ywcf.uWfZtKiH8cdWS7/.0UD1mXSgXFqf6VjMdqmcer1RGhk8rBq', E'false', E'Admin User', NULL, E'2021-11-20 13:43:22.728', 0, E'2019-05-02 13:00:00');
/*!40000 ALTER TABLE "users" ENABLE KEYS */;

-- Dumping structure for table public.user_details
CREATE TABLE IF NOT EXISTS "user_details" (
	"id" INTEGER NOT NULL DEFAULT nextval('user_details_id_seq'::regclass) COMMENT E'',
	"user_id" INTEGER NOT NULL COMMENT E'',
	"dob" DATE NULL DEFAULT NULL COMMENT E'',
	"address" CHARACTER VARYING(300) NULL DEFAULT NULL COMMENT E'',
	"is_acrive" BOOLEAN NULL DEFAULT NULL COMMENT E'',
	"short_name" CHARACTER VARYING(100) NULL DEFAULT NULL COMMENT E'',
	"gender" CHARACTER(1) NULL DEFAULT NULL COMMENT E'',
	"mother_name" CHARACTER VARYING(100) NULL DEFAULT NULL COMMENT E'',
	"father_name" CHARACTER VARYING(100) NULL DEFAULT NULL COMMENT E'',
	"mother_tongue" CHARACTER VARYING(100) NULL DEFAULT NULL COMMENT E'',
	"phc" CHARACTER(1) NULL DEFAULT NULL COMMENT E'',
	"blood_group" CHARACTER VARYING(100) NULL DEFAULT NULL COMMENT E'',
	"marital_status" CHARACTER VARYING(100) NULL DEFAULT NULL COMMENT E'',
	"spouse_name" CHARACTER VARYING(100) NULL DEFAULT NULL COMMENT E'',
	"marks_of_identity1" CHARACTER VARYING(200) NULL DEFAULT NULL COMMENT E'',
	"marks_of_identity2" CHARACTER VARYING(200) NULL DEFAULT NULL COMMENT E'',
	"person_mobile" CHARACTER VARYING(25) NULL DEFAULT NULL COMMENT E'',
	"person_phone_std" CHARACTER VARYING(25) NULL DEFAULT NULL COMMENT E'',
	"office_mobile" CHARACTER VARYING(25) NULL DEFAULT NULL COMMENT E'',
	"office_phone_std" CHARACTER VARYING(25) NULL DEFAULT NULL COMMENT E'',
	"person_mail" CHARACTER VARYING(40) NULL DEFAULT NULL COMMENT E'',
	"office_mail" CHARACTER VARYING(40) NULL DEFAULT NULL COMMENT E'',
	"state" CHARACTER VARYING(100) NULL DEFAULT NULL COMMENT E'',
	"city" CHARACTER VARYING(100) NULL DEFAULT NULL COMMENT E'',
	"postal_code" CHARACTER VARYING(100) NULL DEFAULT NULL COMMENT E'',
	"permanent_address" CHARACTER VARYING(300) NULL DEFAULT NULL COMMENT E'',
	"permanent_state" CHARACTER VARYING(100) NULL DEFAULT NULL COMMENT E'',
	"permanent_city" CHARACTER VARYING(100) NULL DEFAULT NULL COMMENT E'',
	"permanent_postal_code" CHARACTER VARYING(100) NULL DEFAULT NULL COMMENT E'',
	"emergency_contact_person" CHARACTER VARYING(100) NULL DEFAULT NULL COMMENT E'',
	"emergency_relation" CHARACTER VARYING(100) NULL DEFAULT NULL COMMENT E'',
	"emergency_phone_no1" CHARACTER VARYING(25) NULL DEFAULT NULL COMMENT E'',
	"emergency_phone_no2" CHARACTER VARYING(25) NULL DEFAULT NULL COMMENT E'',
	"emergency_address" CHARACTER VARYING(300) NULL DEFAULT NULL COMMENT E'',
	"aadhar_no" CHARACTER VARYING(25) NULL DEFAULT NULL COMMENT E'',
	"pan_no" CHARACTER VARYING(25) NULL DEFAULT NULL COMMENT E'',
	"passport_no" CHARACTER VARYING(25) NULL DEFAULT NULL COMMENT E'',
	"photo_path" CHARACTER VARYING(300) NULL DEFAULT NULL COMMENT E'',
	"bank_name" CHARACTER VARYING(200) NULL DEFAULT NULL COMMENT E'',
	"branch_name" CHARACTER VARYING(200) NULL DEFAULT NULL COMMENT E'',
	"ifsc_code" CHARACTER VARYING(25) NULL DEFAULT NULL COMMENT E'',
	"account_no" CHARACTER VARYING(25) NULL DEFAULT NULL COMMENT E'',
	PRIMARY KEY ("id")
);

-- Dumping data for table public.user_details: 0 rows
/*!40000 ALTER TABLE "user_details" DISABLE KEYS */;
/*!40000 ALTER TABLE "user_details" ENABLE KEYS */;

-- Dumping structure for table public.user_roles
CREATE TABLE IF NOT EXISTS "user_roles" (
	"user_id" BIGINT NULL DEFAULT NULL COMMENT E'',
	"role_id" INTEGER NULL DEFAULT NULL COMMENT E''
);

-- Dumping data for table public.user_roles: 1 rows
/*!40000 ALTER TABLE "user_roles" DISABLE KEYS */;
INSERT INTO "user_roles" ("user_id", "role_id") VALUES
	(1, 1);
/*!40000 ALTER TABLE "user_roles" ENABLE KEYS */;

-- Dumping structure for table public.user_role_id_mapping
CREATE TABLE IF NOT EXISTS "user_role_id_mapping" (
	"user_id" BIGINT NOT NULL COMMENT E'',
	"role_id" INTEGER NOT NULL COMMENT E'',
	"id" BIGINT NOT NULL COMMENT E''
);

-- Dumping data for table public.user_role_id_mapping: 0 rows
/*!40000 ALTER TABLE "user_role_id_mapping" DISABLE KEYS */;
/*!40000 ALTER TABLE "user_role_id_mapping" ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
