-- MySQL dump 10.13  Distrib 5.7.33, for Linux (x86_64)
--
-- Host: localhost    Database: edxapp
-- ------------------------------------------------------
-- Server version	5.7.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `announcements_announcement`
--

DROP TABLE IF EXISTS `announcements_announcement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `announcements_announcement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(1000) NOT NULL,
  `active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `announcements_announcement`
--

LOCK TABLES `announcements_announcement` WRITE;
/*!40000 ALTER TABLE `announcements_announcement` DISABLE KEYS */;
/*!40000 ALTER TABLE `announcements_announcement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_admin_apiaccessconfig`
--

DROP TABLE IF EXISTS `api_admin_apiaccessconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api_admin_apiaccessconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `api_admin_apiaccessconfig_changed_by_id_d2f4cd88_fk_auth_user_id` (`changed_by_id`),
  CONSTRAINT `api_admin_apiaccessconfig_changed_by_id_d2f4cd88_fk_auth_user_id` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_admin_apiaccessconfig`
--

LOCK TABLES `api_admin_apiaccessconfig` WRITE;
/*!40000 ALTER TABLE `api_admin_apiaccessconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `api_admin_apiaccessconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_admin_apiaccessrequest`
--

DROP TABLE IF EXISTS `api_admin_apiaccessrequest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api_admin_apiaccessrequest` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `status` varchar(255) NOT NULL,
  `website` varchar(200) NOT NULL,
  `reason` longtext NOT NULL,
  `user_id` int(11) NOT NULL,
  `company_address` varchar(255) NOT NULL,
  `company_name` varchar(255) NOT NULL,
  `contacted` tinyint(1) NOT NULL,
  `site_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `api_admin_apiaccessrequest_user_id_eb0cc217_uniq` (`user_id`),
  KEY `api_admin_apiaccessrequest_status_f8039aea` (`status`),
  KEY `api_admin_apiaccessrequest_site_id_b78f5161_fk_django_site_id` (`site_id`),
  CONSTRAINT `api_admin_apiaccessrequest_site_id_b78f5161_fk_django_site_id` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`),
  CONSTRAINT `api_admin_apiaccessrequest_user_id_eb0cc217_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_admin_apiaccessrequest`
--

LOCK TABLES `api_admin_apiaccessrequest` WRITE;
/*!40000 ALTER TABLE `api_admin_apiaccessrequest` DISABLE KEYS */;
/*!40000 ALTER TABLE `api_admin_apiaccessrequest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assessment_assessment`
--

DROP TABLE IF EXISTS `assessment_assessment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assessment_assessment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `submission_uuid` varchar(128) NOT NULL,
  `scored_at` datetime(6) NOT NULL,
  `scorer_id` varchar(40) NOT NULL,
  `score_type` varchar(2) NOT NULL,
  `feedback` longtext NOT NULL,
  `rubric_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `assessment_assessment_submission_uuid_cf5817c5` (`submission_uuid`),
  KEY `assessment_assessment_scored_at_a1a213d6` (`scored_at`),
  KEY `assessment_assessment_scorer_id_ad1a38cb` (`scorer_id`),
  KEY `assessment_assessment_rubric_id_2ed0d5db_fk_assessment_rubric_id` (`rubric_id`),
  CONSTRAINT `assessment_assessment_rubric_id_2ed0d5db_fk_assessment_rubric_id` FOREIGN KEY (`rubric_id`) REFERENCES `assessment_rubric` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assessment_assessment`
--

LOCK TABLES `assessment_assessment` WRITE;
/*!40000 ALTER TABLE `assessment_assessment` DISABLE KEYS */;
/*!40000 ALTER TABLE `assessment_assessment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assessment_assessmentfeedback`
--

DROP TABLE IF EXISTS `assessment_assessmentfeedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assessment_assessmentfeedback` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `submission_uuid` varchar(128) NOT NULL,
  `feedback_text` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `submission_uuid` (`submission_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assessment_assessmentfeedback`
--

LOCK TABLES `assessment_assessmentfeedback` WRITE;
/*!40000 ALTER TABLE `assessment_assessmentfeedback` DISABLE KEYS */;
/*!40000 ALTER TABLE `assessment_assessmentfeedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assessment_assessmentfeedback_assessments`
--

DROP TABLE IF EXISTS `assessment_assessmentfeedback_assessments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assessment_assessmentfeedback_assessments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assessmentfeedback_id` int(11) NOT NULL,
  `assessment_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `assessment_assessmentfee_assessmentfeedback_id_as_f8246578_uniq` (`assessmentfeedback_id`,`assessment_id`),
  KEY `assessment_assessmen_assessment_id_033f1121_fk_assessmen` (`assessment_id`),
  CONSTRAINT `assessment_assessmen_assessment_id_033f1121_fk_assessmen` FOREIGN KEY (`assessment_id`) REFERENCES `assessment_assessment` (`id`),
  CONSTRAINT `assessment_assessmen_assessmentfeedback_i_6634a3b4_fk_assessmen` FOREIGN KEY (`assessmentfeedback_id`) REFERENCES `assessment_assessmentfeedback` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assessment_assessmentfeedback_assessments`
--

LOCK TABLES `assessment_assessmentfeedback_assessments` WRITE;
/*!40000 ALTER TABLE `assessment_assessmentfeedback_assessments` DISABLE KEYS */;
/*!40000 ALTER TABLE `assessment_assessmentfeedback_assessments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assessment_assessmentfeedback_options`
--

DROP TABLE IF EXISTS `assessment_assessmentfeedback_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assessment_assessmentfeedback_options` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assessmentfeedback_id` int(11) NOT NULL,
  `assessmentfeedbackoption_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `assessment_assessmentfee_assessmentfeedback_id_as_4e554cc7_uniq` (`assessmentfeedback_id`,`assessmentfeedbackoption_id`),
  KEY `assessment_assessmen_assessmentfeedbackop_a9af45f6_fk_assessmen` (`assessmentfeedbackoption_id`),
  CONSTRAINT `assessment_assessmen_assessmentfeedback_i_004e1bf0_fk_assessmen` FOREIGN KEY (`assessmentfeedback_id`) REFERENCES `assessment_assessmentfeedback` (`id`),
  CONSTRAINT `assessment_assessmen_assessmentfeedbackop_a9af45f6_fk_assessmen` FOREIGN KEY (`assessmentfeedbackoption_id`) REFERENCES `assessment_assessmentfeedbackoption` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assessment_assessmentfeedback_options`
--

LOCK TABLES `assessment_assessmentfeedback_options` WRITE;
/*!40000 ALTER TABLE `assessment_assessmentfeedback_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `assessment_assessmentfeedback_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assessment_assessmentfeedbackoption`
--

DROP TABLE IF EXISTS `assessment_assessmentfeedbackoption`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assessment_assessmentfeedbackoption` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `text` (`text`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assessment_assessmentfeedbackoption`
--

LOCK TABLES `assessment_assessmentfeedbackoption` WRITE;
/*!40000 ALTER TABLE `assessment_assessmentfeedbackoption` DISABLE KEYS */;
/*!40000 ALTER TABLE `assessment_assessmentfeedbackoption` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assessment_assessmentpart`
--

DROP TABLE IF EXISTS `assessment_assessmentpart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assessment_assessmentpart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `feedback` longtext NOT NULL,
  `assessment_id` int(11) NOT NULL,
  `criterion_id` int(11) NOT NULL,
  `option_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `assessment_assessmen_assessment_id_de1999cd_fk_assessmen` (`assessment_id`),
  KEY `assessment_assessmen_criterion_id_5bc40925_fk_assessmen` (`criterion_id`),
  KEY `assessment_assessmen_option_id_dd35c2c5_fk_assessmen` (`option_id`),
  CONSTRAINT `assessment_assessmen_assessment_id_de1999cd_fk_assessmen` FOREIGN KEY (`assessment_id`) REFERENCES `assessment_assessment` (`id`),
  CONSTRAINT `assessment_assessmen_criterion_id_5bc40925_fk_assessmen` FOREIGN KEY (`criterion_id`) REFERENCES `assessment_criterion` (`id`),
  CONSTRAINT `assessment_assessmen_option_id_dd35c2c5_fk_assessmen` FOREIGN KEY (`option_id`) REFERENCES `assessment_criterionoption` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assessment_assessmentpart`
--

LOCK TABLES `assessment_assessmentpart` WRITE;
/*!40000 ALTER TABLE `assessment_assessmentpart` DISABLE KEYS */;
/*!40000 ALTER TABLE `assessment_assessmentpart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assessment_criterion`
--

DROP TABLE IF EXISTS `assessment_criterion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assessment_criterion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `label` varchar(100) NOT NULL,
  `order_num` int(10) unsigned NOT NULL,
  `prompt` longtext NOT NULL,
  `rubric_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `assessment_criterion_rubric_id_fe236962_fk_assessment_rubric_id` (`rubric_id`),
  CONSTRAINT `assessment_criterion_rubric_id_fe236962_fk_assessment_rubric_id` FOREIGN KEY (`rubric_id`) REFERENCES `assessment_rubric` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assessment_criterion`
--

LOCK TABLES `assessment_criterion` WRITE;
/*!40000 ALTER TABLE `assessment_criterion` DISABLE KEYS */;
/*!40000 ALTER TABLE `assessment_criterion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assessment_criterionoption`
--

DROP TABLE IF EXISTS `assessment_criterionoption`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assessment_criterionoption` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_num` int(10) unsigned NOT NULL,
  `points` int(10) unsigned NOT NULL,
  `name` varchar(100) NOT NULL,
  `label` varchar(100) NOT NULL,
  `explanation` longtext NOT NULL,
  `criterion_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `assessment_criterion_criterion_id_53928be7_fk_assessmen` (`criterion_id`),
  CONSTRAINT `assessment_criterion_criterion_id_53928be7_fk_assessmen` FOREIGN KEY (`criterion_id`) REFERENCES `assessment_criterion` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assessment_criterionoption`
--

LOCK TABLES `assessment_criterionoption` WRITE;
/*!40000 ALTER TABLE `assessment_criterionoption` DISABLE KEYS */;
/*!40000 ALTER TABLE `assessment_criterionoption` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assessment_historicalsharedfileupload`
--

DROP TABLE IF EXISTS `assessment_historicalsharedfileupload`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assessment_historicalsharedfileupload` (
  `id` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `team_id` varchar(255) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `item_id` varchar(255) NOT NULL,
  `owner_id` varchar(255) NOT NULL,
  `file_key` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `size` bigint(20) NOT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`history_id`),
  KEY `assessment_historica_history_user_id_28fa87d9_fk_auth_user` (`history_user_id`),
  KEY `assessment_historicalsharedfileupload_id_34052991` (`id`),
  KEY `assessment_historicalsharedfileupload_team_id_e32268e1` (`team_id`),
  KEY `assessment_historicalsharedfileupload_course_id_7fd70b9d` (`course_id`),
  KEY `assessment_historicalsharedfileupload_item_id_b7bca199` (`item_id`),
  KEY `assessment_historicalsharedfileupload_owner_id_09b09e30` (`owner_id`),
  KEY `assessment_historicalsharedfileupload_file_key_03fbd3e7` (`file_key`),
  CONSTRAINT `assessment_historica_history_user_id_28fa87d9_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assessment_historicalsharedfileupload`
--

LOCK TABLES `assessment_historicalsharedfileupload` WRITE;
/*!40000 ALTER TABLE `assessment_historicalsharedfileupload` DISABLE KEYS */;
/*!40000 ALTER TABLE `assessment_historicalsharedfileupload` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assessment_peerworkflow`
--

DROP TABLE IF EXISTS `assessment_peerworkflow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assessment_peerworkflow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` varchar(40) NOT NULL,
  `item_id` varchar(128) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `submission_uuid` varchar(128) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `completed_at` datetime(6) DEFAULT NULL,
  `grading_completed_at` datetime(6) DEFAULT NULL,
  `cancelled_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `submission_uuid` (`submission_uuid`),
  KEY `assessment_peerworkflow_student_id_9382ae54` (`student_id`),
  KEY `assessment_peerworkflow_item_id_c17d799e` (`item_id`),
  KEY `assessment_peerworkflow_course_id_875599e3` (`course_id`),
  KEY `assessment_peerworkflow_created_at_b8aaf4a5` (`created_at`),
  KEY `assessment_peerworkflow_completed_at_681f19e1` (`completed_at`),
  KEY `assessment_peerworkflow_grading_completed_at_33e2560c` (`grading_completed_at`),
  KEY `assessment_peerworkflow_cancelled_at_0e258929` (`cancelled_at`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assessment_peerworkflow`
--

LOCK TABLES `assessment_peerworkflow` WRITE;
/*!40000 ALTER TABLE `assessment_peerworkflow` DISABLE KEYS */;
/*!40000 ALTER TABLE `assessment_peerworkflow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assessment_peerworkflowitem`
--

DROP TABLE IF EXISTS `assessment_peerworkflowitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assessment_peerworkflowitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `submission_uuid` varchar(128) NOT NULL,
  `started_at` datetime(6) NOT NULL,
  `scored` tinyint(1) NOT NULL,
  `assessment_id` int(11) DEFAULT NULL,
  `author_id` int(11) NOT NULL,
  `scorer_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `assessment_peerworkf_assessment_id_27f9ef1f_fk_assessmen` (`assessment_id`),
  KEY `assessment_peerworkf_author_id_0e3ed804_fk_assessmen` (`author_id`),
  KEY `assessment_peerworkf_scorer_id_27e47cd4_fk_assessmen` (`scorer_id`),
  KEY `assessment_peerworkflowitem_submission_uuid_edd446aa` (`submission_uuid`),
  KEY `assessment_peerworkflowitem_started_at_8644e7a0` (`started_at`),
  CONSTRAINT `assessment_peerworkf_assessment_id_27f9ef1f_fk_assessmen` FOREIGN KEY (`assessment_id`) REFERENCES `assessment_assessment` (`id`),
  CONSTRAINT `assessment_peerworkf_author_id_0e3ed804_fk_assessmen` FOREIGN KEY (`author_id`) REFERENCES `assessment_peerworkflow` (`id`),
  CONSTRAINT `assessment_peerworkf_scorer_id_27e47cd4_fk_assessmen` FOREIGN KEY (`scorer_id`) REFERENCES `assessment_peerworkflow` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assessment_peerworkflowitem`
--

LOCK TABLES `assessment_peerworkflowitem` WRITE;
/*!40000 ALTER TABLE `assessment_peerworkflowitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `assessment_peerworkflowitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assessment_rubric`
--

DROP TABLE IF EXISTS `assessment_rubric`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assessment_rubric` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content_hash` varchar(40) NOT NULL,
  `structure_hash` varchar(40) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_hash` (`content_hash`),
  KEY `assessment_rubric_structure_hash_fb456373` (`structure_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assessment_rubric`
--

LOCK TABLES `assessment_rubric` WRITE;
/*!40000 ALTER TABLE `assessment_rubric` DISABLE KEYS */;
/*!40000 ALTER TABLE `assessment_rubric` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assessment_sharedfileupload`
--

DROP TABLE IF EXISTS `assessment_sharedfileupload`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assessment_sharedfileupload` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `team_id` varchar(255) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `item_id` varchar(255) NOT NULL,
  `owner_id` varchar(255) NOT NULL,
  `file_key` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `size` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `file_key` (`file_key`),
  KEY `assessment_sharedfileupload_team_id_dbdd3cb7` (`team_id`),
  KEY `assessment_sharedfileupload_course_id_73edb775` (`course_id`),
  KEY `assessment_sharedfileupload_item_id_b471d0c9` (`item_id`),
  KEY `assessment_sharedfileupload_owner_id_f4d7fe4f` (`owner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assessment_sharedfileupload`
--

LOCK TABLES `assessment_sharedfileupload` WRITE;
/*!40000 ALTER TABLE `assessment_sharedfileupload` DISABLE KEYS */;
/*!40000 ALTER TABLE `assessment_sharedfileupload` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assessment_staffworkflow`
--

DROP TABLE IF EXISTS `assessment_staffworkflow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assessment_staffworkflow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `scorer_id` varchar(40) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `item_id` varchar(128) NOT NULL,
  `submission_uuid` varchar(128) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `grading_completed_at` datetime(6) DEFAULT NULL,
  `grading_started_at` datetime(6) DEFAULT NULL,
  `cancelled_at` datetime(6) DEFAULT NULL,
  `assessment` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `submission_uuid` (`submission_uuid`),
  KEY `assessment_staffworkflow_scorer_id_ae799ebc` (`scorer_id`),
  KEY `assessment_staffworkflow_course_id_3f18693d` (`course_id`),
  KEY `assessment_staffworkflow_item_id_4fa3697b` (`item_id`),
  KEY `assessment_staffworkflow_created_at_a253bc02` (`created_at`),
  KEY `assessment_staffworkflow_grading_completed_at_acd0199f` (`grading_completed_at`),
  KEY `assessment_staffworkflow_grading_started_at_90f99005` (`grading_started_at`),
  KEY `assessment_staffworkflow_cancelled_at_bc8f93d5` (`cancelled_at`),
  KEY `assessment_staffworkflow_assessment_7c1dcc5d` (`assessment`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assessment_staffworkflow`
--

LOCK TABLES `assessment_staffworkflow` WRITE;
/*!40000 ALTER TABLE `assessment_staffworkflow` DISABLE KEYS */;
/*!40000 ALTER TABLE `assessment_staffworkflow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assessment_studenttrainingworkflow`
--

DROP TABLE IF EXISTS `assessment_studenttrainingworkflow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assessment_studenttrainingworkflow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `submission_uuid` varchar(128) NOT NULL,
  `student_id` varchar(40) NOT NULL,
  `item_id` varchar(128) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `submission_uuid` (`submission_uuid`),
  KEY `assessment_studenttrainingworkflow_student_id_ea8fdfa8` (`student_id`),
  KEY `assessment_studenttrainingworkflow_item_id_f5812a25` (`item_id`),
  KEY `assessment_studenttrainingworkflow_course_id_a14d6cde` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assessment_studenttrainingworkflow`
--

LOCK TABLES `assessment_studenttrainingworkflow` WRITE;
/*!40000 ALTER TABLE `assessment_studenttrainingworkflow` DISABLE KEYS */;
/*!40000 ALTER TABLE `assessment_studenttrainingworkflow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assessment_studenttrainingworkflowitem`
--

DROP TABLE IF EXISTS `assessment_studenttrainingworkflowitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assessment_studenttrainingworkflowitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_num` int(10) unsigned NOT NULL,
  `started_at` datetime(6) NOT NULL,
  `completed_at` datetime(6) DEFAULT NULL,
  `training_example_id` int(11) NOT NULL,
  `workflow_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `assessment_studenttraini_workflow_id_order_num_1ab60238_uniq` (`workflow_id`,`order_num`),
  KEY `assessment_studenttr_training_example_id_881dddbd_fk_assessmen` (`training_example_id`),
  CONSTRAINT `assessment_studenttr_training_example_id_881dddbd_fk_assessmen` FOREIGN KEY (`training_example_id`) REFERENCES `assessment_trainingexample` (`id`),
  CONSTRAINT `assessment_studenttr_workflow_id_a75a9a2e_fk_assessmen` FOREIGN KEY (`workflow_id`) REFERENCES `assessment_studenttrainingworkflow` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assessment_studenttrainingworkflowitem`
--

LOCK TABLES `assessment_studenttrainingworkflowitem` WRITE;
/*!40000 ALTER TABLE `assessment_studenttrainingworkflowitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `assessment_studenttrainingworkflowitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assessment_teamstaffworkflow`
--

DROP TABLE IF EXISTS `assessment_teamstaffworkflow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assessment_teamstaffworkflow` (
  `staffworkflow_ptr_id` int(11) NOT NULL,
  `team_submission_uuid` varchar(128) NOT NULL,
  PRIMARY KEY (`staffworkflow_ptr_id`),
  UNIQUE KEY `team_submission_uuid` (`team_submission_uuid`),
  CONSTRAINT `assessment_teamstaff_staffworkflow_ptr_id_e55a780c_fk_assessmen` FOREIGN KEY (`staffworkflow_ptr_id`) REFERENCES `assessment_staffworkflow` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assessment_teamstaffworkflow`
--

LOCK TABLES `assessment_teamstaffworkflow` WRITE;
/*!40000 ALTER TABLE `assessment_teamstaffworkflow` DISABLE KEYS */;
/*!40000 ALTER TABLE `assessment_teamstaffworkflow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assessment_trainingexample`
--

DROP TABLE IF EXISTS `assessment_trainingexample`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assessment_trainingexample` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `raw_answer` longtext NOT NULL,
  `content_hash` varchar(40) NOT NULL,
  `rubric_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_hash` (`content_hash`),
  KEY `assessment_traininge_rubric_id_cfb4afc3_fk_assessmen` (`rubric_id`),
  CONSTRAINT `assessment_traininge_rubric_id_cfb4afc3_fk_assessmen` FOREIGN KEY (`rubric_id`) REFERENCES `assessment_rubric` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assessment_trainingexample`
--

LOCK TABLES `assessment_trainingexample` WRITE;
/*!40000 ALTER TABLE `assessment_trainingexample` DISABLE KEYS */;
/*!40000 ALTER TABLE `assessment_trainingexample` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assessment_trainingexample_options_selected`
--

DROP TABLE IF EXISTS `assessment_trainingexample_options_selected`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assessment_trainingexample_options_selected` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trainingexample_id` int(11) NOT NULL,
  `criterionoption_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `assessment_trainingexamp_trainingexample_id_crite_4b6b8b90_uniq` (`trainingexample_id`,`criterionoption_id`),
  KEY `assessment_traininge_criterionoption_id_de6716f1_fk_assessmen` (`criterionoption_id`),
  CONSTRAINT `assessment_traininge_criterionoption_id_de6716f1_fk_assessmen` FOREIGN KEY (`criterionoption_id`) REFERENCES `assessment_criterionoption` (`id`),
  CONSTRAINT `assessment_traininge_trainingexample_id_7a04b572_fk_assessmen` FOREIGN KEY (`trainingexample_id`) REFERENCES `assessment_trainingexample` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assessment_trainingexample_options_selected`
--

LOCK TABLES `assessment_trainingexample_options_selected` WRITE;
/*!40000 ALTER TABLE `assessment_trainingexample_options_selected` DISABLE KEYS */;
/*!40000 ALTER TABLE `assessment_trainingexample_options_selected` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_accountrecovery`
--

DROP TABLE IF EXISTS `auth_accountrecovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_accountrecovery` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `secondary_email` varchar(254) NOT NULL,
  `user_id` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `secondary_email` (`secondary_email`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `auth_accountrecovery_user_id_0c61e73c_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_accountrecovery`
--

LOCK TABLES `auth_accountrecovery` WRITE;
/*!40000 ALTER TABLE `auth_accountrecovery` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_accountrecovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (1,'API Access Request Approvers');
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1649 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add permission',2,'add_permission'),(2,'Can change permission',2,'change_permission'),(3,'Can delete permission',2,'delete_permission'),(4,'Can view permission',2,'view_permission'),(5,'Can add group',3,'add_group'),(6,'Can change group',3,'change_group'),(7,'Can delete group',3,'delete_group'),(8,'Can view group',3,'view_group'),(9,'Can add user',4,'add_user'),(10,'Can change user',4,'change_user'),(11,'Can delete user',4,'delete_user'),(12,'Can view user',4,'view_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can view content type',5,'view_contenttype'),(17,'Can add redirect',6,'add_redirect'),(18,'Can change redirect',6,'change_redirect'),(19,'Can delete redirect',6,'delete_redirect'),(20,'Can view redirect',6,'view_redirect'),(21,'Can add session',7,'add_session'),(22,'Can change session',7,'change_session'),(23,'Can delete session',7,'delete_session'),(24,'Can view session',7,'view_session'),(25,'Can add site',8,'add_site'),(26,'Can change site',8,'change_site'),(27,'Can delete site',8,'delete_site'),(28,'Can view site',8,'view_site'),(29,'Can add task result',9,'add_taskresult'),(30,'Can change task result',9,'change_taskresult'),(31,'Can delete task result',9,'delete_taskresult'),(32,'Can view task result',9,'view_taskresult'),(33,'Can add chord counter',10,'add_chordcounter'),(34,'Can change chord counter',10,'change_chordcounter'),(35,'Can delete chord counter',10,'delete_chordcounter'),(36,'Can view chord counter',10,'view_chordcounter'),(37,'Can add Flag',11,'add_flag'),(38,'Can change Flag',11,'change_flag'),(39,'Can delete Flag',11,'delete_flag'),(40,'Can view Flag',11,'view_flag'),(41,'Can add Sample',12,'add_sample'),(42,'Can change Sample',12,'change_sample'),(43,'Can delete Sample',12,'delete_sample'),(44,'Can view Sample',12,'view_sample'),(45,'Can add Switch',13,'add_switch'),(46,'Can change Switch',13,'change_switch'),(47,'Can delete Switch',13,'delete_switch'),(48,'Can view Switch',13,'view_switch'),(49,'Can add course message',14,'add_coursemessage'),(50,'Can change course message',14,'change_coursemessage'),(51,'Can delete course message',14,'delete_coursemessage'),(52,'Can view course message',14,'view_coursemessage'),(53,'Can add global status message',15,'add_globalstatusmessage'),(54,'Can change global status message',15,'change_globalstatusmessage'),(55,'Can delete global status message',15,'delete_globalstatusmessage'),(56,'Can view global status message',15,'view_globalstatusmessage'),(57,'Can add asset base url config',16,'add_assetbaseurlconfig'),(58,'Can change asset base url config',16,'change_assetbaseurlconfig'),(59,'Can delete asset base url config',16,'delete_assetbaseurlconfig'),(60,'Can view asset base url config',16,'view_assetbaseurlconfig'),(61,'Can add asset excluded extensions config',17,'add_assetexcludedextensionsconfig'),(62,'Can change asset excluded extensions config',17,'change_assetexcludedextensionsconfig'),(63,'Can delete asset excluded extensions config',17,'delete_assetexcludedextensionsconfig'),(64,'Can view asset excluded extensions config',17,'view_assetexcludedextensionsconfig'),(65,'Can add course asset cache ttl config',18,'add_courseassetcachettlconfig'),(66,'Can change course asset cache ttl config',18,'change_courseassetcachettlconfig'),(67,'Can delete course asset cache ttl config',18,'delete_courseassetcachettlconfig'),(68,'Can view course asset cache ttl config',18,'view_courseassetcachettlconfig'),(69,'Can add cdn user agents config',19,'add_cdnuseragentsconfig'),(70,'Can change cdn user agents config',19,'change_cdnuseragentsconfig'),(71,'Can delete cdn user agents config',19,'delete_cdnuseragentsconfig'),(72,'Can view cdn user agents config',19,'view_cdnuseragentsconfig'),(73,'Can add site configuration',20,'add_siteconfiguration'),(74,'Can change site configuration',20,'change_siteconfiguration'),(75,'Can delete site configuration',20,'delete_siteconfiguration'),(76,'Can view site configuration',20,'view_siteconfiguration'),(77,'Can add site configuration history',21,'add_siteconfigurationhistory'),(78,'Can change site configuration history',21,'change_siteconfigurationhistory'),(79,'Can delete site configuration history',21,'delete_siteconfigurationhistory'),(80,'Can view site configuration history',21,'view_siteconfigurationhistory'),(81,'Can add course hls playback enabled flag',22,'add_coursehlsplaybackenabledflag'),(82,'Can change course hls playback enabled flag',22,'change_coursehlsplaybackenabledflag'),(83,'Can delete course hls playback enabled flag',22,'delete_coursehlsplaybackenabledflag'),(84,'Can view course hls playback enabled flag',22,'view_coursehlsplaybackenabledflag'),(85,'Can add hls playback enabled flag',23,'add_hlsplaybackenabledflag'),(86,'Can change hls playback enabled flag',23,'change_hlsplaybackenabledflag'),(87,'Can delete hls playback enabled flag',23,'delete_hlsplaybackenabledflag'),(88,'Can view hls playback enabled flag',23,'view_hlsplaybackenabledflag'),(89,'Can add course video transcript enabled flag',24,'add_coursevideotranscriptenabledflag'),(90,'Can change course video transcript enabled flag',24,'change_coursevideotranscriptenabledflag'),(91,'Can delete course video transcript enabled flag',24,'delete_coursevideotranscriptenabledflag'),(92,'Can view course video transcript enabled flag',24,'view_coursevideotranscriptenabledflag'),(93,'Can add video transcript enabled flag',25,'add_videotranscriptenabledflag'),(94,'Can change video transcript enabled flag',25,'change_videotranscriptenabledflag'),(95,'Can delete video transcript enabled flag',25,'delete_videotranscriptenabledflag'),(96,'Can view video transcript enabled flag',25,'view_videotranscriptenabledflag'),(97,'Can add transcript migration setting',26,'add_transcriptmigrationsetting'),(98,'Can change transcript migration setting',26,'change_transcriptmigrationsetting'),(99,'Can delete transcript migration setting',26,'delete_transcriptmigrationsetting'),(100,'Can view transcript migration setting',26,'view_transcriptmigrationsetting'),(101,'Can add migration enqueued course',27,'add_migrationenqueuedcourse'),(102,'Can change migration enqueued course',27,'change_migrationenqueuedcourse'),(103,'Can delete migration enqueued course',27,'delete_migrationenqueuedcourse'),(104,'Can view migration enqueued course',27,'view_migrationenqueuedcourse'),(105,'Can add updated course videos',28,'add_updatedcoursevideos'),(106,'Can change updated course videos',28,'change_updatedcoursevideos'),(107,'Can delete updated course videos',28,'delete_updatedcoursevideos'),(108,'Can view updated course videos',28,'view_updatedcoursevideos'),(109,'Can add video thumbnail setting',29,'add_videothumbnailsetting'),(110,'Can change video thumbnail setting',29,'change_videothumbnailsetting'),(111,'Can delete video thumbnail setting',29,'delete_videothumbnailsetting'),(112,'Can view video thumbnail setting',29,'view_videothumbnailsetting'),(113,'Can add course youtube blocked flag',30,'add_courseyoutubeblockedflag'),(114,'Can change course youtube blocked flag',30,'change_courseyoutubeblockedflag'),(115,'Can delete course youtube blocked flag',30,'delete_courseyoutubeblockedflag'),(116,'Can view course youtube blocked flag',30,'view_courseyoutubeblockedflag'),(117,'Can add course video uploads enabled by default',31,'add_coursevideouploadsenabledbydefault'),(118,'Can change course video uploads enabled by default',31,'change_coursevideouploadsenabledbydefault'),(119,'Can delete course video uploads enabled by default',31,'delete_coursevideouploadsenabledbydefault'),(120,'Can view course video uploads enabled by default',31,'view_coursevideouploadsenabledbydefault'),(121,'Can add video uploads enabled by default',32,'add_videouploadsenabledbydefault'),(122,'Can change video uploads enabled by default',32,'change_videouploadsenabledbydefault'),(123,'Can delete video uploads enabled by default',32,'delete_videouploadsenabledbydefault'),(124,'Can view video uploads enabled by default',32,'view_videouploadsenabledbydefault'),(125,'Can add vem pipeline integration',33,'add_vempipelineintegration'),(126,'Can change vem pipeline integration',33,'change_vempipelineintegration'),(127,'Can delete vem pipeline integration',33,'delete_vempipelineintegration'),(128,'Can view vem pipeline integration',33,'view_vempipelineintegration'),(129,'Can add offline computed grade',34,'add_offlinecomputedgrade'),(130,'Can change offline computed grade',34,'change_offlinecomputedgrade'),(131,'Can delete offline computed grade',34,'delete_offlinecomputedgrade'),(132,'Can view offline computed grade',34,'view_offlinecomputedgrade'),(133,'Can add offline computed grade log',35,'add_offlinecomputedgradelog'),(134,'Can change offline computed grade log',35,'change_offlinecomputedgradelog'),(135,'Can delete offline computed grade log',35,'delete_offlinecomputedgradelog'),(136,'Can view offline computed grade log',35,'view_offlinecomputedgradelog'),(137,'Can add student field override',36,'add_studentfieldoverride'),(138,'Can change student field override',36,'change_studentfieldoverride'),(139,'Can delete student field override',36,'delete_studentfieldoverride'),(140,'Can view student field override',36,'view_studentfieldoverride'),(141,'Can add student module',37,'add_studentmodule'),(142,'Can change student module',37,'change_studentmodule'),(143,'Can delete student module',37,'delete_studentmodule'),(144,'Can view student module',37,'view_studentmodule'),(145,'Can add student module history',38,'add_studentmodulehistory'),(146,'Can change student module history',38,'change_studentmodulehistory'),(147,'Can delete student module history',38,'delete_studentmodulehistory'),(148,'Can view student module history',38,'view_studentmodulehistory'),(149,'Can add x module student info field',39,'add_xmodulestudentinfofield'),(150,'Can change x module student info field',39,'change_xmodulestudentinfofield'),(151,'Can delete x module student info field',39,'delete_xmodulestudentinfofield'),(152,'Can view x module student info field',39,'view_xmodulestudentinfofield'),(153,'Can add x module student prefs field',40,'add_xmodulestudentprefsfield'),(154,'Can change x module student prefs field',40,'change_xmodulestudentprefsfield'),(155,'Can delete x module student prefs field',40,'delete_xmodulestudentprefsfield'),(156,'Can view x module student prefs field',40,'view_xmodulestudentprefsfield'),(157,'Can add x module user state summary field',41,'add_xmoduleuserstatesummaryfield'),(158,'Can change x module user state summary field',41,'change_xmoduleuserstatesummaryfield'),(159,'Can delete x module user state summary field',41,'delete_xmoduleuserstatesummaryfield'),(160,'Can view x module user state summary field',41,'view_xmoduleuserstatesummaryfield'),(161,'Can add course dynamic upgrade deadline configuration',42,'add_coursedynamicupgradedeadlineconfiguration'),(162,'Can change course dynamic upgrade deadline configuration',42,'change_coursedynamicupgradedeadlineconfiguration'),(163,'Can delete course dynamic upgrade deadline configuration',42,'delete_coursedynamicupgradedeadlineconfiguration'),(164,'Can view course dynamic upgrade deadline configuration',42,'view_coursedynamicupgradedeadlineconfiguration'),(165,'Can add dynamic upgrade deadline configuration',43,'add_dynamicupgradedeadlineconfiguration'),(166,'Can change dynamic upgrade deadline configuration',43,'change_dynamicupgradedeadlineconfiguration'),(167,'Can delete dynamic upgrade deadline configuration',43,'delete_dynamicupgradedeadlineconfiguration'),(168,'Can view dynamic upgrade deadline configuration',43,'view_dynamicupgradedeadlineconfiguration'),(169,'Can add org dynamic upgrade deadline configuration',44,'add_orgdynamicupgradedeadlineconfiguration'),(170,'Can change org dynamic upgrade deadline configuration',44,'change_orgdynamicupgradedeadlineconfiguration'),(171,'Can delete org dynamic upgrade deadline configuration',44,'delete_orgdynamicupgradedeadlineconfiguration'),(172,'Can view org dynamic upgrade deadline configuration',44,'view_orgdynamicupgradedeadlineconfiguration'),(173,'Can add student module history extended',45,'add_studentmodulehistoryextended'),(174,'Can change student module history extended',45,'change_studentmodulehistoryextended'),(175,'Can delete student module history extended',45,'delete_studentmodulehistoryextended'),(176,'Can view student module history extended',45,'view_studentmodulehistoryextended'),(177,'Can add anonymous user id',46,'add_anonymoususerid'),(178,'Can change anonymous user id',46,'change_anonymoususerid'),(179,'Can delete anonymous user id',46,'delete_anonymoususerid'),(180,'Can view anonymous user id',46,'view_anonymoususerid'),(181,'Can add course access role',47,'add_courseaccessrole'),(182,'Can change course access role',47,'change_courseaccessrole'),(183,'Can delete course access role',47,'delete_courseaccessrole'),(184,'Can view course access role',47,'view_courseaccessrole'),(185,'Can add course enrollment',48,'add_courseenrollment'),(186,'Can change course enrollment',48,'change_courseenrollment'),(187,'Can delete course enrollment',48,'delete_courseenrollment'),(188,'Can view course enrollment',48,'view_courseenrollment'),(189,'Can add course enrollment allowed',49,'add_courseenrollmentallowed'),(190,'Can change course enrollment allowed',49,'change_courseenrollmentallowed'),(191,'Can delete course enrollment allowed',49,'delete_courseenrollmentallowed'),(192,'Can view course enrollment allowed',49,'view_courseenrollmentallowed'),(193,'Can add course enrollment attribute',50,'add_courseenrollmentattribute'),(194,'Can change course enrollment attribute',50,'change_courseenrollmentattribute'),(195,'Can delete course enrollment attribute',50,'delete_courseenrollmentattribute'),(196,'Can view course enrollment attribute',50,'view_courseenrollmentattribute'),(197,'Can add dashboard configuration',51,'add_dashboardconfiguration'),(198,'Can change dashboard configuration',51,'change_dashboardconfiguration'),(199,'Can delete dashboard configuration',51,'delete_dashboardconfiguration'),(200,'Can view dashboard configuration',51,'view_dashboardconfiguration'),(201,'Can add enrollment refund configuration',52,'add_enrollmentrefundconfiguration'),(202,'Can change enrollment refund configuration',52,'change_enrollmentrefundconfiguration'),(203,'Can delete enrollment refund configuration',52,'delete_enrollmentrefundconfiguration'),(204,'Can view enrollment refund configuration',52,'view_enrollmentrefundconfiguration'),(205,'Can add entrance exam configuration',53,'add_entranceexamconfiguration'),(206,'Can change entrance exam configuration',53,'change_entranceexamconfiguration'),(207,'Can delete entrance exam configuration',53,'delete_entranceexamconfiguration'),(208,'Can view entrance exam configuration',53,'view_entranceexamconfiguration'),(209,'Can add language proficiency',54,'add_languageproficiency'),(210,'Can change language proficiency',54,'change_languageproficiency'),(211,'Can delete language proficiency',54,'delete_languageproficiency'),(212,'Can view language proficiency',54,'view_languageproficiency'),(213,'Can add linked in add to profile configuration',55,'add_linkedinaddtoprofileconfiguration'),(214,'Can change linked in add to profile configuration',55,'change_linkedinaddtoprofileconfiguration'),(215,'Can delete linked in add to profile configuration',55,'delete_linkedinaddtoprofileconfiguration'),(216,'Can view linked in add to profile configuration',55,'view_linkedinaddtoprofileconfiguration'),(217,'Can add Login Failure',56,'add_loginfailures'),(218,'Can change Login Failure',56,'change_loginfailures'),(219,'Can delete Login Failure',56,'delete_loginfailures'),(220,'Can view Login Failure',56,'view_loginfailures'),(221,'Can add manual enrollment audit',57,'add_manualenrollmentaudit'),(222,'Can change manual enrollment audit',57,'change_manualenrollmentaudit'),(223,'Can delete manual enrollment audit',57,'delete_manualenrollmentaudit'),(224,'Can view manual enrollment audit',57,'view_manualenrollmentaudit'),(225,'Can add pending email change',58,'add_pendingemailchange'),(226,'Can change pending email change',58,'change_pendingemailchange'),(227,'Can delete pending email change',58,'delete_pendingemailchange'),(228,'Can view pending email change',58,'view_pendingemailchange'),(229,'Can add pending name change',59,'add_pendingnamechange'),(230,'Can change pending name change',59,'change_pendingnamechange'),(231,'Can delete pending name change',59,'delete_pendingnamechange'),(232,'Can view pending name change',59,'view_pendingnamechange'),(233,'Can add registration',60,'add_registration'),(234,'Can change registration',60,'change_registration'),(235,'Can delete registration',60,'delete_registration'),(236,'Can view registration',60,'view_registration'),(237,'Can add user profile',61,'add_userprofile'),(238,'Can change user profile',61,'change_userprofile'),(239,'Can delete user profile',61,'delete_userprofile'),(240,'Can view user profile',61,'view_userprofile'),(241,'Can deactivate, but NOT delete users',61,'can_deactivate_users'),(242,'Can add user signup source',62,'add_usersignupsource'),(243,'Can change user signup source',62,'change_usersignupsource'),(244,'Can delete user signup source',62,'delete_usersignupsource'),(245,'Can view user signup source',62,'view_usersignupsource'),(246,'Can add user standing',63,'add_userstanding'),(247,'Can change user standing',63,'change_userstanding'),(248,'Can delete user standing',63,'delete_userstanding'),(249,'Can view user standing',63,'view_userstanding'),(250,'Can add user test group',64,'add_usertestgroup'),(251,'Can change user test group',64,'change_usertestgroup'),(252,'Can delete user test group',64,'delete_usertestgroup'),(253,'Can view user test group',64,'view_usertestgroup'),(254,'Can add user attribute',65,'add_userattribute'),(255,'Can change user attribute',65,'change_userattribute'),(256,'Can delete user attribute',65,'delete_userattribute'),(257,'Can view user attribute',65,'view_userattribute'),(258,'Can add registration cookie configuration',66,'add_registrationcookieconfiguration'),(259,'Can change registration cookie configuration',66,'change_registrationcookieconfiguration'),(260,'Can delete registration cookie configuration',66,'delete_registrationcookieconfiguration'),(261,'Can view registration cookie configuration',66,'view_registrationcookieconfiguration'),(262,'Can add social link',67,'add_sociallink'),(263,'Can change social link',67,'change_sociallink'),(264,'Can delete social link',67,'delete_sociallink'),(265,'Can view social link',67,'view_sociallink'),(266,'Can add account recovery',68,'add_accountrecovery'),(267,'Can change account recovery',68,'change_accountrecovery'),(268,'Can delete account recovery',68,'delete_accountrecovery'),(269,'Can view account recovery',68,'view_accountrecovery'),(270,'Can add pending secondary email change',69,'add_pendingsecondaryemailchange'),(271,'Can change pending secondary email change',69,'change_pendingsecondaryemailchange'),(272,'Can delete pending secondary email change',69,'delete_pendingsecondaryemailchange'),(273,'Can view pending secondary email change',69,'view_pendingsecondaryemailchange'),(274,'Can add historical course enrollment',70,'add_historicalcourseenrollment'),(275,'Can change historical course enrollment',70,'change_historicalcourseenrollment'),(276,'Can delete historical course enrollment',70,'delete_historicalcourseenrollment'),(277,'Can view historical course enrollment',70,'view_historicalcourseenrollment'),(278,'Can add bulk unenroll configuration',71,'add_bulkunenrollconfiguration'),(279,'Can change bulk unenroll configuration',71,'change_bulkunenrollconfiguration'),(280,'Can delete bulk unenroll configuration',71,'delete_bulkunenrollconfiguration'),(281,'Can view bulk unenroll configuration',71,'view_bulkunenrollconfiguration'),(282,'Can add fbe enrollment exclusion',72,'add_fbeenrollmentexclusion'),(283,'Can change fbe enrollment exclusion',72,'change_fbeenrollmentexclusion'),(284,'Can delete fbe enrollment exclusion',72,'delete_fbeenrollmentexclusion'),(285,'Can view fbe enrollment exclusion',72,'view_fbeenrollmentexclusion'),(286,'Can add allowed auth user',73,'add_allowedauthuser'),(287,'Can change allowed auth user',73,'change_allowedauthuser'),(288,'Can delete allowed auth user',73,'delete_allowedauthuser'),(289,'Can view allowed auth user',73,'view_allowedauthuser'),(290,'Can add historical manual enrollment audit',74,'add_historicalmanualenrollmentaudit'),(291,'Can change historical manual enrollment audit',74,'change_historicalmanualenrollmentaudit'),(292,'Can delete historical manual enrollment audit',74,'delete_historicalmanualenrollmentaudit'),(293,'Can view historical manual enrollment audit',74,'view_historicalmanualenrollmentaudit'),(294,'Can add account recovery configuration',75,'add_accountrecoveryconfiguration'),(295,'Can change account recovery configuration',75,'change_accountrecoveryconfiguration'),(296,'Can delete account recovery configuration',75,'delete_accountrecoveryconfiguration'),(297,'Can view account recovery configuration',75,'view_accountrecoveryconfiguration'),(298,'Can add course enrollment celebration',76,'add_courseenrollmentcelebration'),(299,'Can change course enrollment celebration',76,'change_courseenrollmentcelebration'),(300,'Can delete course enrollment celebration',76,'delete_courseenrollmentcelebration'),(301,'Can view course enrollment celebration',76,'view_courseenrollmentcelebration'),(302,'Can add bulk change enrollment configuration',77,'add_bulkchangeenrollmentconfiguration'),(303,'Can change bulk change enrollment configuration',77,'change_bulkchangeenrollmentconfiguration'),(304,'Can delete bulk change enrollment configuration',77,'delete_bulkchangeenrollmentconfiguration'),(305,'Can view bulk change enrollment configuration',77,'view_bulkchangeenrollmentconfiguration'),(306,'Can add user password toggle history',78,'add_userpasswordtogglehistory'),(307,'Can change user password toggle history',78,'change_userpasswordtogglehistory'),(308,'Can delete user password toggle history',78,'delete_userpasswordtogglehistory'),(309,'Can view user password toggle history',78,'view_userpasswordtogglehistory'),(310,'Can add user celebration',79,'add_usercelebration'),(311,'Can change user celebration',79,'change_usercelebration'),(312,'Can delete user celebration',79,'delete_usercelebration'),(313,'Can view user celebration',79,'view_usercelebration'),(314,'Can add rate limit configuration',80,'add_ratelimitconfiguration'),(315,'Can change rate limit configuration',80,'change_ratelimitconfiguration'),(316,'Can delete rate limit configuration',80,'delete_ratelimitconfiguration'),(317,'Can view rate limit configuration',80,'view_ratelimitconfiguration'),(318,'Can add certificate generation configuration',81,'add_certificategenerationconfiguration'),(319,'Can change certificate generation configuration',81,'change_certificategenerationconfiguration'),(320,'Can delete certificate generation configuration',81,'delete_certificategenerationconfiguration'),(321,'Can view certificate generation configuration',81,'view_certificategenerationconfiguration'),(322,'Can add certificate generation course setting',82,'add_certificategenerationcoursesetting'),(323,'Can change certificate generation course setting',82,'change_certificategenerationcoursesetting'),(324,'Can delete certificate generation course setting',82,'delete_certificategenerationcoursesetting'),(325,'Can view certificate generation course setting',82,'view_certificategenerationcoursesetting'),(326,'Can add certificate html view configuration',83,'add_certificatehtmlviewconfiguration'),(327,'Can change certificate html view configuration',83,'change_certificatehtmlviewconfiguration'),(328,'Can delete certificate html view configuration',83,'delete_certificatehtmlviewconfiguration'),(329,'Can view certificate html view configuration',83,'view_certificatehtmlviewconfiguration'),(330,'Can add certificate template',84,'add_certificatetemplate'),(331,'Can change certificate template',84,'change_certificatetemplate'),(332,'Can delete certificate template',84,'delete_certificatetemplate'),(333,'Can view certificate template',84,'view_certificatetemplate'),(334,'Can add certificate template asset',85,'add_certificatetemplateasset'),(335,'Can change certificate template asset',85,'change_certificatetemplateasset'),(336,'Can delete certificate template asset',85,'delete_certificatetemplateasset'),(337,'Can view certificate template asset',85,'view_certificatetemplateasset'),(338,'Can add certificate whitelist',86,'add_certificatewhitelist'),(339,'Can change certificate whitelist',86,'change_certificatewhitelist'),(340,'Can delete certificate whitelist',86,'delete_certificatewhitelist'),(341,'Can view certificate whitelist',86,'view_certificatewhitelist'),(342,'Can add example certificate',87,'add_examplecertificate'),(343,'Can change example certificate',87,'change_examplecertificate'),(344,'Can delete example certificate',87,'delete_examplecertificate'),(345,'Can view example certificate',87,'view_examplecertificate'),(346,'Can add example certificate set',88,'add_examplecertificateset'),(347,'Can change example certificate set',88,'change_examplecertificateset'),(348,'Can delete example certificate set',88,'delete_examplecertificateset'),(349,'Can view example certificate set',88,'view_examplecertificateset'),(350,'Can add generated certificate',89,'add_generatedcertificate'),(351,'Can change generated certificate',89,'change_generatedcertificate'),(352,'Can delete generated certificate',89,'delete_generatedcertificate'),(353,'Can view generated certificate',89,'view_generatedcertificate'),(354,'Can add certificate generation history',90,'add_certificategenerationhistory'),(355,'Can change certificate generation history',90,'change_certificategenerationhistory'),(356,'Can delete certificate generation history',90,'delete_certificategenerationhistory'),(357,'Can view certificate generation history',90,'view_certificategenerationhistory'),(358,'Can add certificate invalidation',91,'add_certificateinvalidation'),(359,'Can change certificate invalidation',91,'change_certificateinvalidation'),(360,'Can delete certificate invalidation',91,'delete_certificateinvalidation'),(361,'Can view certificate invalidation',91,'view_certificateinvalidation'),(362,'Can add historical generated certificate',92,'add_historicalgeneratedcertificate'),(363,'Can change historical generated certificate',92,'change_historicalgeneratedcertificate'),(364,'Can delete historical generated certificate',92,'delete_historicalgeneratedcertificate'),(365,'Can view historical generated certificate',92,'view_historicalgeneratedcertificate'),(366,'Can add historical certificate invalidation',93,'add_historicalcertificateinvalidation'),(367,'Can change historical certificate invalidation',93,'change_historicalcertificateinvalidation'),(368,'Can delete historical certificate invalidation',93,'delete_historicalcertificateinvalidation'),(369,'Can view historical certificate invalidation',93,'view_historicalcertificateinvalidation'),(370,'Can add cert_allowlist_generation argument',94,'add_allowlistgenerationconfiguration'),(371,'Can change cert_allowlist_generation argument',94,'change_allowlistgenerationconfiguration'),(372,'Can delete cert_allowlist_generation argument',94,'delete_allowlistgenerationconfiguration'),(373,'Can view cert_allowlist_generation argument',94,'view_allowlistgenerationconfiguration'),(374,'Can add instructor task',95,'add_instructortask'),(375,'Can change instructor task',95,'change_instructortask'),(376,'Can delete instructor task',95,'delete_instructortask'),(377,'Can view instructor task',95,'view_instructortask'),(378,'Can add grade report setting',96,'add_gradereportsetting'),(379,'Can change grade report setting',96,'change_gradereportsetting'),(380,'Can delete grade report setting',96,'delete_gradereportsetting'),(381,'Can view grade report setting',96,'view_gradereportsetting'),(382,'Can add cohort membership',97,'add_cohortmembership'),(383,'Can change cohort membership',97,'change_cohortmembership'),(384,'Can delete cohort membership',97,'delete_cohortmembership'),(385,'Can view cohort membership',97,'view_cohortmembership'),(386,'Can add course cohort',98,'add_coursecohort'),(387,'Can change course cohort',98,'change_coursecohort'),(388,'Can delete course cohort',98,'delete_coursecohort'),(389,'Can view course cohort',98,'view_coursecohort'),(390,'Can add course cohorts settings',99,'add_coursecohortssettings'),(391,'Can change course cohorts settings',99,'change_coursecohortssettings'),(392,'Can delete course cohorts settings',99,'delete_coursecohortssettings'),(393,'Can view course cohorts settings',99,'view_coursecohortssettings'),(394,'Can add course user group',100,'add_courseusergroup'),(395,'Can change course user group',100,'change_courseusergroup'),(396,'Can delete course user group',100,'delete_courseusergroup'),(397,'Can view course user group',100,'view_courseusergroup'),(398,'Can add course user group partition group',101,'add_courseusergrouppartitiongroup'),(399,'Can change course user group partition group',101,'change_courseusergrouppartitiongroup'),(400,'Can delete course user group partition group',101,'delete_courseusergrouppartitiongroup'),(401,'Can view course user group partition group',101,'view_courseusergrouppartitiongroup'),(402,'Can add unregistered learner cohort assignments',102,'add_unregisteredlearnercohortassignments'),(403,'Can change unregistered learner cohort assignments',102,'change_unregisteredlearnercohortassignments'),(404,'Can delete unregistered learner cohort assignments',102,'delete_unregisteredlearnercohortassignments'),(405,'Can view unregistered learner cohort assignments',102,'view_unregisteredlearnercohortassignments'),(406,'Can add course authorization',103,'add_courseauthorization'),(407,'Can change course authorization',103,'change_courseauthorization'),(408,'Can delete course authorization',103,'delete_courseauthorization'),(409,'Can view course authorization',103,'view_courseauthorization'),(410,'Can add course email',104,'add_courseemail'),(411,'Can change course email',104,'change_courseemail'),(412,'Can delete course email',104,'delete_courseemail'),(413,'Can view course email',104,'view_courseemail'),(414,'Can add course email template',105,'add_courseemailtemplate'),(415,'Can change course email template',105,'change_courseemailtemplate'),(416,'Can delete course email template',105,'delete_courseemailtemplate'),(417,'Can view course email template',105,'view_courseemailtemplate'),(418,'Can add optout',106,'add_optout'),(419,'Can change optout',106,'change_optout'),(420,'Can delete optout',106,'delete_optout'),(421,'Can view optout',106,'view_optout'),(422,'Can add bulk email flag',107,'add_bulkemailflag'),(423,'Can change bulk email flag',107,'change_bulkemailflag'),(424,'Can delete bulk email flag',107,'delete_bulkemailflag'),(425,'Can view bulk email flag',107,'view_bulkemailflag'),(426,'Can add target',108,'add_target'),(427,'Can change target',108,'change_target'),(428,'Can delete target',108,'delete_target'),(429,'Can view target',108,'view_target'),(430,'Can add cohort target',109,'add_cohorttarget'),(431,'Can change cohort target',109,'change_cohorttarget'),(432,'Can delete cohort target',109,'delete_cohorttarget'),(433,'Can view cohort target',109,'view_cohorttarget'),(434,'Can add course mode target',110,'add_coursemodetarget'),(435,'Can change course mode target',110,'change_coursemodetarget'),(436,'Can delete course mode target',110,'delete_coursemodetarget'),(437,'Can view course mode target',110,'view_coursemodetarget'),(438,'Can add branding api config',111,'add_brandingapiconfig'),(439,'Can change branding api config',111,'change_brandingapiconfig'),(440,'Can delete branding api config',111,'delete_brandingapiconfig'),(441,'Can view branding api config',111,'view_brandingapiconfig'),(442,'Can add branding info config',112,'add_brandinginfoconfig'),(443,'Can change branding info config',112,'change_brandinginfoconfig'),(444,'Can delete branding info config',112,'delete_brandinginfoconfig'),(445,'Can view branding info config',112,'view_brandinginfoconfig'),(446,'Can add application',113,'add_application'),(447,'Can change application',113,'change_application'),(448,'Can delete application',113,'delete_application'),(449,'Can view application',113,'view_application'),(450,'Can add access token',114,'add_accesstoken'),(451,'Can change access token',114,'change_accesstoken'),(452,'Can delete access token',114,'delete_accesstoken'),(453,'Can view access token',114,'view_accesstoken'),(454,'Can add grant',115,'add_grant'),(455,'Can change grant',115,'change_grant'),(456,'Can delete grant',115,'delete_grant'),(457,'Can view grant',115,'view_grant'),(458,'Can add refresh token',116,'add_refreshtoken'),(459,'Can change refresh token',116,'change_refreshtoken'),(460,'Can delete refresh token',116,'delete_refreshtoken'),(461,'Can view refresh token',116,'view_refreshtoken'),(462,'Can add restricted application',117,'add_restrictedapplication'),(463,'Can change restricted application',117,'change_restrictedapplication'),(464,'Can delete restricted application',117,'delete_restrictedapplication'),(465,'Can view restricted application',117,'view_restrictedapplication'),(466,'Can add application access',118,'add_applicationaccess'),(467,'Can change application access',118,'change_applicationaccess'),(468,'Can delete application access',118,'delete_applicationaccess'),(469,'Can view application access',118,'view_applicationaccess'),(470,'Can add application organization',119,'add_applicationorganization'),(471,'Can change application organization',119,'change_applicationorganization'),(472,'Can delete application organization',119,'delete_applicationorganization'),(473,'Can view application organization',119,'view_applicationorganization'),(474,'Can add SAML Provider Data',120,'add_samlproviderdata'),(475,'Can change SAML Provider Data',120,'change_samlproviderdata'),(476,'Can delete SAML Provider Data',120,'delete_samlproviderdata'),(477,'Can view SAML Provider Data',120,'view_samlproviderdata'),(478,'Can add SAML Configuration',121,'add_samlconfiguration'),(479,'Can change SAML Configuration',121,'change_samlconfiguration'),(480,'Can delete SAML Configuration',121,'delete_samlconfiguration'),(481,'Can view SAML Configuration',121,'view_samlconfiguration'),(482,'Can add Provider Configuration (OAuth)',122,'add_oauth2providerconfig'),(483,'Can change Provider Configuration (OAuth)',122,'change_oauth2providerconfig'),(484,'Can delete Provider Configuration (OAuth)',122,'delete_oauth2providerconfig'),(485,'Can view Provider Configuration (OAuth)',122,'view_oauth2providerconfig'),(486,'Can add Provider Configuration (LTI)',123,'add_ltiproviderconfig'),(487,'Can change Provider Configuration (LTI)',123,'change_ltiproviderconfig'),(488,'Can delete Provider Configuration (LTI)',123,'delete_ltiproviderconfig'),(489,'Can view Provider Configuration (LTI)',123,'view_ltiproviderconfig'),(490,'Can add Provider Configuration (SAML IdP)',124,'add_samlproviderconfig'),(491,'Can change Provider Configuration (SAML IdP)',124,'change_samlproviderconfig'),(492,'Can delete Provider Configuration (SAML IdP)',124,'delete_samlproviderconfig'),(493,'Can view Provider Configuration (SAML IdP)',124,'view_samlproviderconfig'),(494,'Can add system wide role',125,'add_systemwiderole'),(495,'Can change system wide role',125,'change_systemwiderole'),(496,'Can delete system wide role',125,'delete_systemwiderole'),(497,'Can view system wide role',125,'view_systemwiderole'),(498,'Can add system wide role assignment',126,'add_systemwideroleassignment'),(499,'Can change system wide role assignment',126,'change_systemwideroleassignment'),(500,'Can delete system wide role assignment',126,'delete_systemwideroleassignment'),(501,'Can view system wide role assignment',126,'view_systemwideroleassignment'),(502,'Can add article',127,'add_article'),(503,'Can change article',127,'change_article'),(504,'Can delete article',127,'delete_article'),(505,'Can view article',127,'view_article'),(506,'Can edit all articles and lock/unlock/restore',127,'moderate'),(507,'Can change ownership of any article',127,'assign'),(508,'Can assign permissions to other users',127,'grant'),(509,'Can add Article for object',128,'add_articleforobject'),(510,'Can change Article for object',128,'change_articleforobject'),(511,'Can delete Article for object',128,'delete_articleforobject'),(512,'Can view Article for object',128,'view_articleforobject'),(513,'Can add article plugin',129,'add_articleplugin'),(514,'Can change article plugin',129,'change_articleplugin'),(515,'Can delete article plugin',129,'delete_articleplugin'),(516,'Can view article plugin',129,'view_articleplugin'),(517,'Can add article revision',130,'add_articlerevision'),(518,'Can change article revision',130,'change_articlerevision'),(519,'Can delete article revision',130,'delete_articlerevision'),(520,'Can view article revision',130,'view_articlerevision'),(521,'Can add reusable plugin',131,'add_reusableplugin'),(522,'Can change reusable plugin',131,'change_reusableplugin'),(523,'Can delete reusable plugin',131,'delete_reusableplugin'),(524,'Can view reusable plugin',131,'view_reusableplugin'),(525,'Can add revision plugin',132,'add_revisionplugin'),(526,'Can change revision plugin',132,'change_revisionplugin'),(527,'Can delete revision plugin',132,'delete_revisionplugin'),(528,'Can view revision plugin',132,'view_revisionplugin'),(529,'Can add revision plugin revision',133,'add_revisionpluginrevision'),(530,'Can change revision plugin revision',133,'change_revisionpluginrevision'),(531,'Can delete revision plugin revision',133,'delete_revisionpluginrevision'),(532,'Can view revision plugin revision',133,'view_revisionpluginrevision'),(533,'Can add simple plugin',134,'add_simpleplugin'),(534,'Can change simple plugin',134,'change_simpleplugin'),(535,'Can delete simple plugin',134,'delete_simpleplugin'),(536,'Can view simple plugin',134,'view_simpleplugin'),(537,'Can add URL path',135,'add_urlpath'),(538,'Can change URL path',135,'change_urlpath'),(539,'Can delete URL path',135,'delete_urlpath'),(540,'Can view URL path',135,'view_urlpath'),(541,'Can add notification',136,'add_notification'),(542,'Can change notification',136,'change_notification'),(543,'Can delete notification',136,'delete_notification'),(544,'Can view notification',136,'view_notification'),(545,'Can add type',137,'add_notificationtype'),(546,'Can change type',137,'change_notificationtype'),(547,'Can delete type',137,'delete_notificationtype'),(548,'Can view type',137,'view_notificationtype'),(549,'Can add settings',138,'add_settings'),(550,'Can change settings',138,'change_settings'),(551,'Can delete settings',138,'delete_settings'),(552,'Can view settings',138,'view_settings'),(553,'Can add subscription',139,'add_subscription'),(554,'Can change subscription',139,'change_subscription'),(555,'Can delete subscription',139,'delete_subscription'),(556,'Can view subscription',139,'view_subscription'),(557,'Can add log entry',140,'add_logentry'),(558,'Can change log entry',140,'change_logentry'),(559,'Can delete log entry',140,'delete_logentry'),(560,'Can view log entry',140,'view_logentry'),(561,'Can add permission',141,'add_permission'),(562,'Can change permission',141,'change_permission'),(563,'Can delete permission',141,'delete_permission'),(564,'Can view permission',141,'view_permission'),(565,'Can add role',142,'add_role'),(566,'Can change role',142,'change_role'),(567,'Can delete role',142,'delete_role'),(568,'Can view role',142,'view_role'),(569,'Can add forums config',143,'add_forumsconfig'),(570,'Can change forums config',143,'change_forumsconfig'),(571,'Can delete forums config',143,'delete_forumsconfig'),(572,'Can view forums config',143,'view_forumsconfig'),(573,'Can add course discussion settings',144,'add_coursediscussionsettings'),(574,'Can change course discussion settings',144,'change_coursediscussionsettings'),(575,'Can delete course discussion settings',144,'delete_coursediscussionsettings'),(576,'Can view course discussion settings',144,'view_coursediscussionsettings'),(577,'Can add discussions id mapping',145,'add_discussionsidmapping'),(578,'Can change discussions id mapping',145,'change_discussionsidmapping'),(579,'Can delete discussions id mapping',145,'delete_discussionsidmapping'),(580,'Can view discussions id mapping',145,'view_discussionsidmapping'),(581,'Can add splash config',146,'add_splashconfig'),(582,'Can change splash config',146,'change_splashconfig'),(583,'Can delete splash config',146,'delete_splashconfig'),(584,'Can view splash config',146,'view_splashconfig'),(585,'Can add user course tag',147,'add_usercoursetag'),(586,'Can change user course tag',147,'change_usercoursetag'),(587,'Can delete user course tag',147,'delete_usercoursetag'),(588,'Can view user course tag',147,'view_usercoursetag'),(589,'Can add user org tag',148,'add_userorgtag'),(590,'Can change user org tag',148,'change_userorgtag'),(591,'Can delete user org tag',148,'delete_userorgtag'),(592,'Can view user org tag',148,'view_userorgtag'),(593,'Can add user preference',149,'add_userpreference'),(594,'Can change user preference',149,'change_userpreference'),(595,'Can delete user preference',149,'delete_userpreference'),(596,'Can view user preference',149,'view_userpreference'),(597,'Can add retirement state',150,'add_retirementstate'),(598,'Can change retirement state',150,'change_retirementstate'),(599,'Can delete retirement state',150,'delete_retirementstate'),(600,'Can view retirement state',150,'view_retirementstate'),(601,'Can add User Retirement Status',151,'add_userretirementstatus'),(602,'Can change User Retirement Status',151,'change_userretirementstatus'),(603,'Can delete User Retirement Status',151,'delete_userretirementstatus'),(604,'Can view User Retirement Status',151,'view_userretirementstatus'),(605,'Can add User Retirement Request',152,'add_userretirementrequest'),(606,'Can change User Retirement Request',152,'change_userretirementrequest'),(607,'Can delete User Retirement Request',152,'delete_userretirementrequest'),(608,'Can view User Retirement Request',152,'view_userretirementrequest'),(609,'Can add User Retirement Reporting Status',153,'add_userretirementpartnerreportingstatus'),(610,'Can change User Retirement Reporting Status',153,'change_userretirementpartnerreportingstatus'),(611,'Can delete User Retirement Reporting Status',153,'delete_userretirementpartnerreportingstatus'),(612,'Can view User Retirement Reporting Status',153,'view_userretirementpartnerreportingstatus'),(613,'Can add course mode',154,'add_coursemode'),(614,'Can change course mode',154,'change_coursemode'),(615,'Can delete course mode',154,'delete_coursemode'),(616,'Can view course mode',154,'view_coursemode'),(617,'Can add course modes archive',155,'add_coursemodesarchive'),(618,'Can change course modes archive',155,'change_coursemodesarchive'),(619,'Can delete course modes archive',155,'delete_coursemodesarchive'),(620,'Can view course modes archive',155,'view_coursemodesarchive'),(621,'Can add course mode expiration config',156,'add_coursemodeexpirationconfig'),(622,'Can change course mode expiration config',156,'change_coursemodeexpirationconfig'),(623,'Can delete course mode expiration config',156,'delete_coursemodeexpirationconfig'),(624,'Can view course mode expiration config',156,'view_coursemodeexpirationconfig'),(625,'Can add historical course mode',157,'add_historicalcoursemode'),(626,'Can change historical course mode',157,'change_historicalcoursemode'),(627,'Can delete historical course mode',157,'delete_historicalcoursemode'),(628,'Can view historical course mode',157,'view_historicalcoursemode'),(629,'Can add course entitlement',158,'add_courseentitlement'),(630,'Can change course entitlement',158,'change_courseentitlement'),(631,'Can delete course entitlement',158,'delete_courseentitlement'),(632,'Can view course entitlement',158,'view_courseentitlement'),(633,'Can add course entitlement policy',159,'add_courseentitlementpolicy'),(634,'Can change course entitlement policy',159,'change_courseentitlementpolicy'),(635,'Can delete course entitlement policy',159,'delete_courseentitlementpolicy'),(636,'Can view course entitlement policy',159,'view_courseentitlementpolicy'),(637,'Can add course entitlement support detail',160,'add_courseentitlementsupportdetail'),(638,'Can change course entitlement support detail',160,'change_courseentitlementsupportdetail'),(639,'Can delete course entitlement support detail',160,'delete_courseentitlementsupportdetail'),(640,'Can view course entitlement support detail',160,'view_courseentitlementsupportdetail'),(641,'Can add historical course entitlement',161,'add_historicalcourseentitlement'),(642,'Can change historical course entitlement',161,'change_historicalcourseentitlement'),(643,'Can delete historical course entitlement',161,'delete_historicalcourseentitlement'),(644,'Can view historical course entitlement',161,'view_historicalcourseentitlement'),(645,'Can add historical course entitlement support detail',162,'add_historicalcourseentitlementsupportdetail'),(646,'Can change historical course entitlement support detail',162,'change_historicalcourseentitlementsupportdetail'),(647,'Can delete historical course entitlement support detail',162,'delete_historicalcourseentitlementsupportdetail'),(648,'Can view historical course entitlement support detail',162,'view_historicalcourseentitlementsupportdetail'),(649,'Can add software secure photo verification',163,'add_softwaresecurephotoverification'),(650,'Can change software secure photo verification',163,'change_softwaresecurephotoverification'),(651,'Can delete software secure photo verification',163,'delete_softwaresecurephotoverification'),(652,'Can view software secure photo verification',163,'view_softwaresecurephotoverification'),(653,'Can add verification deadline',164,'add_verificationdeadline'),(654,'Can change verification deadline',164,'change_verificationdeadline'),(655,'Can delete verification deadline',164,'delete_verificationdeadline'),(656,'Can view verification deadline',164,'view_verificationdeadline'),(657,'Can add sso verification',165,'add_ssoverification'),(658,'Can change sso verification',165,'change_ssoverification'),(659,'Can delete sso verification',165,'delete_ssoverification'),(660,'Can view sso verification',165,'view_ssoverification'),(661,'Can add manual verification',166,'add_manualverification'),(662,'Can change manual verification',166,'change_manualverification'),(663,'Can delete manual verification',166,'delete_manualverification'),(664,'Can view manual verification',166,'view_manualverification'),(665,'Can add sspv retry student argument',167,'add_sspverificationretryconfig'),(666,'Can change sspv retry student argument',167,'change_sspverificationretryconfig'),(667,'Can delete sspv retry student argument',167,'delete_sspverificationretryconfig'),(668,'Can view sspv retry student argument',167,'view_sspverificationretryconfig'),(669,'Can add dark lang config',168,'add_darklangconfig'),(670,'Can change dark lang config',168,'change_darklangconfig'),(671,'Can delete dark lang config',168,'delete_darklangconfig'),(672,'Can view dark lang config',168,'view_darklangconfig'),(673,'Can add whitelisted rss url',169,'add_whitelistedrssurl'),(674,'Can change whitelisted rss url',169,'change_whitelistedrssurl'),(675,'Can delete whitelisted rss url',169,'delete_whitelistedrssurl'),(676,'Can view whitelisted rss url',169,'view_whitelistedrssurl'),(677,'Can add country',170,'add_country'),(678,'Can change country',170,'change_country'),(679,'Can delete country',170,'delete_country'),(680,'Can view country',170,'view_country'),(681,'Can add country access rule',171,'add_countryaccessrule'),(682,'Can change country access rule',171,'change_countryaccessrule'),(683,'Can delete country access rule',171,'delete_countryaccessrule'),(684,'Can view country access rule',171,'view_countryaccessrule'),(685,'Can add course access rule history',172,'add_courseaccessrulehistory'),(686,'Can change course access rule history',172,'change_courseaccessrulehistory'),(687,'Can delete course access rule history',172,'delete_courseaccessrulehistory'),(688,'Can view course access rule history',172,'view_courseaccessrulehistory'),(689,'Can add embargoed course',173,'add_embargoedcourse'),(690,'Can change embargoed course',173,'change_embargoedcourse'),(691,'Can delete embargoed course',173,'delete_embargoedcourse'),(692,'Can view embargoed course',173,'view_embargoedcourse'),(693,'Can add embargoed state',174,'add_embargoedstate'),(694,'Can change embargoed state',174,'change_embargoedstate'),(695,'Can delete embargoed state',174,'delete_embargoedstate'),(696,'Can view embargoed state',174,'view_embargoedstate'),(697,'Can add ip filter',175,'add_ipfilter'),(698,'Can change ip filter',175,'change_ipfilter'),(699,'Can delete ip filter',175,'delete_ipfilter'),(700,'Can view ip filter',175,'view_ipfilter'),(701,'Can add restricted course',176,'add_restrictedcourse'),(702,'Can change restricted course',176,'change_restrictedcourse'),(703,'Can delete restricted course',176,'delete_restrictedcourse'),(704,'Can view restricted course',176,'view_restrictedcourse'),(705,'Can add course rerun state',177,'add_coursererunstate'),(706,'Can change course rerun state',177,'change_coursererunstate'),(707,'Can delete course rerun state',177,'delete_coursererunstate'),(708,'Can view course rerun state',177,'view_coursererunstate'),(709,'Can add mobile api config',178,'add_mobileapiconfig'),(710,'Can change mobile api config',178,'change_mobileapiconfig'),(711,'Can delete mobile api config',178,'delete_mobileapiconfig'),(712,'Can view mobile api config',178,'view_mobileapiconfig'),(713,'Can add app version config',179,'add_appversionconfig'),(714,'Can change app version config',179,'change_appversionconfig'),(715,'Can delete app version config',179,'delete_appversionconfig'),(716,'Can view app version config',179,'view_appversionconfig'),(717,'Can add ignore mobile available flag config',180,'add_ignoremobileavailableflagconfig'),(718,'Can change ignore mobile available flag config',180,'change_ignoremobileavailableflagconfig'),(719,'Can delete ignore mobile available flag config',180,'delete_ignoremobileavailableflagconfig'),(720,'Can view ignore mobile available flag config',180,'view_ignoremobileavailableflagconfig'),(721,'Can add association',181,'add_association'),(722,'Can change association',181,'change_association'),(723,'Can delete association',181,'delete_association'),(724,'Can view association',181,'view_association'),(725,'Can add code',182,'add_code'),(726,'Can change code',182,'change_code'),(727,'Can delete code',182,'delete_code'),(728,'Can view code',182,'view_code'),(729,'Can add nonce',183,'add_nonce'),(730,'Can change nonce',183,'change_nonce'),(731,'Can delete nonce',183,'delete_nonce'),(732,'Can view nonce',183,'view_nonce'),(733,'Can add user social auth',184,'add_usersocialauth'),(734,'Can change user social auth',184,'change_usersocialauth'),(735,'Can delete user social auth',184,'delete_usersocialauth'),(736,'Can view user social auth',184,'view_usersocialauth'),(737,'Can add partial',185,'add_partial'),(738,'Can change partial',185,'change_partial'),(739,'Can delete partial',185,'delete_partial'),(740,'Can view partial',185,'view_partial'),(741,'Can add survey answer',186,'add_surveyanswer'),(742,'Can change survey answer',186,'change_surveyanswer'),(743,'Can delete survey answer',186,'delete_surveyanswer'),(744,'Can view survey answer',186,'view_surveyanswer'),(745,'Can add survey form',187,'add_surveyform'),(746,'Can change survey form',187,'change_surveyform'),(747,'Can delete survey form',187,'delete_surveyform'),(748,'Can view survey form',187,'view_surveyform'),(749,'Can add x block asides config',188,'add_xblockasidesconfig'),(750,'Can change x block asides config',188,'change_xblockasidesconfig'),(751,'Can delete x block asides config',188,'delete_xblockasidesconfig'),(752,'Can view x block asides config',188,'view_xblockasidesconfig'),(753,'Can add score',189,'add_score'),(754,'Can change score',189,'change_score'),(755,'Can delete score',189,'delete_score'),(756,'Can view score',189,'view_score'),(757,'Can add student item',190,'add_studentitem'),(758,'Can change student item',190,'change_studentitem'),(759,'Can delete student item',190,'delete_studentitem'),(760,'Can view student item',190,'view_studentitem'),(761,'Can add submission',191,'add_submission'),(762,'Can change submission',191,'change_submission'),(763,'Can delete submission',191,'delete_submission'),(764,'Can view submission',191,'view_submission'),(765,'Can add score summary',192,'add_scoresummary'),(766,'Can change score summary',192,'change_scoresummary'),(767,'Can delete score summary',192,'delete_scoresummary'),(768,'Can view score summary',192,'view_scoresummary'),(769,'Can add score annotation',193,'add_scoreannotation'),(770,'Can change score annotation',193,'change_scoreannotation'),(771,'Can delete score annotation',193,'delete_scoreannotation'),(772,'Can view score annotation',193,'view_scoreannotation'),(773,'Can add team submission',194,'add_teamsubmission'),(774,'Can change team submission',194,'change_teamsubmission'),(775,'Can delete team submission',194,'delete_teamsubmission'),(776,'Can view team submission',194,'view_teamsubmission'),(777,'Can add assessment',195,'add_assessment'),(778,'Can change assessment',195,'change_assessment'),(779,'Can delete assessment',195,'delete_assessment'),(780,'Can view assessment',195,'view_assessment'),(781,'Can add assessment feedback',196,'add_assessmentfeedback'),(782,'Can change assessment feedback',196,'change_assessmentfeedback'),(783,'Can delete assessment feedback',196,'delete_assessmentfeedback'),(784,'Can view assessment feedback',196,'view_assessmentfeedback'),(785,'Can add assessment feedback option',197,'add_assessmentfeedbackoption'),(786,'Can change assessment feedback option',197,'change_assessmentfeedbackoption'),(787,'Can delete assessment feedback option',197,'delete_assessmentfeedbackoption'),(788,'Can view assessment feedback option',197,'view_assessmentfeedbackoption'),(789,'Can add assessment part',198,'add_assessmentpart'),(790,'Can change assessment part',198,'change_assessmentpart'),(791,'Can delete assessment part',198,'delete_assessmentpart'),(792,'Can view assessment part',198,'view_assessmentpart'),(793,'Can add criterion',199,'add_criterion'),(794,'Can change criterion',199,'change_criterion'),(795,'Can delete criterion',199,'delete_criterion'),(796,'Can view criterion',199,'view_criterion'),(797,'Can add criterion option',200,'add_criterionoption'),(798,'Can change criterion option',200,'change_criterionoption'),(799,'Can delete criterion option',200,'delete_criterionoption'),(800,'Can view criterion option',200,'view_criterionoption'),(801,'Can add peer workflow',201,'add_peerworkflow'),(802,'Can change peer workflow',201,'change_peerworkflow'),(803,'Can delete peer workflow',201,'delete_peerworkflow'),(804,'Can view peer workflow',201,'view_peerworkflow'),(805,'Can add peer workflow item',202,'add_peerworkflowitem'),(806,'Can change peer workflow item',202,'change_peerworkflowitem'),(807,'Can delete peer workflow item',202,'delete_peerworkflowitem'),(808,'Can view peer workflow item',202,'view_peerworkflowitem'),(809,'Can add rubric',203,'add_rubric'),(810,'Can change rubric',203,'change_rubric'),(811,'Can delete rubric',203,'delete_rubric'),(812,'Can view rubric',203,'view_rubric'),(813,'Can add student training workflow',204,'add_studenttrainingworkflow'),(814,'Can change student training workflow',204,'change_studenttrainingworkflow'),(815,'Can delete student training workflow',204,'delete_studenttrainingworkflow'),(816,'Can view student training workflow',204,'view_studenttrainingworkflow'),(817,'Can add student training workflow item',205,'add_studenttrainingworkflowitem'),(818,'Can change student training workflow item',205,'change_studenttrainingworkflowitem'),(819,'Can delete student training workflow item',205,'delete_studenttrainingworkflowitem'),(820,'Can view student training workflow item',205,'view_studenttrainingworkflowitem'),(821,'Can add training example',206,'add_trainingexample'),(822,'Can change training example',206,'change_trainingexample'),(823,'Can delete training example',206,'delete_trainingexample'),(824,'Can view training example',206,'view_trainingexample'),(825,'Can add staff workflow',207,'add_staffworkflow'),(826,'Can change staff workflow',207,'change_staffworkflow'),(827,'Can delete staff workflow',207,'delete_staffworkflow'),(828,'Can view staff workflow',207,'view_staffworkflow'),(829,'Can add historical shared file upload',208,'add_historicalsharedfileupload'),(830,'Can change historical shared file upload',208,'change_historicalsharedfileupload'),(831,'Can delete historical shared file upload',208,'delete_historicalsharedfileupload'),(832,'Can view historical shared file upload',208,'view_historicalsharedfileupload'),(833,'Can add shared file upload',209,'add_sharedfileupload'),(834,'Can change shared file upload',209,'change_sharedfileupload'),(835,'Can delete shared file upload',209,'delete_sharedfileupload'),(836,'Can view shared file upload',209,'view_sharedfileupload'),(837,'Can add team staff workflow',210,'add_teamstaffworkflow'),(838,'Can change team staff workflow',210,'change_teamstaffworkflow'),(839,'Can delete team staff workflow',210,'delete_teamstaffworkflow'),(840,'Can view team staff workflow',210,'view_teamstaffworkflow'),(841,'Can add assessment workflow',211,'add_assessmentworkflow'),(842,'Can change assessment workflow',211,'change_assessmentworkflow'),(843,'Can delete assessment workflow',211,'delete_assessmentworkflow'),(844,'Can view assessment workflow',211,'view_assessmentworkflow'),(845,'Can add assessment workflow cancellation',212,'add_assessmentworkflowcancellation'),(846,'Can change assessment workflow cancellation',212,'change_assessmentworkflowcancellation'),(847,'Can delete assessment workflow cancellation',212,'delete_assessmentworkflowcancellation'),(848,'Can view assessment workflow cancellation',212,'view_assessmentworkflowcancellation'),(849,'Can add assessment workflow step',213,'add_assessmentworkflowstep'),(850,'Can change assessment workflow step',213,'change_assessmentworkflowstep'),(851,'Can delete assessment workflow step',213,'delete_assessmentworkflowstep'),(852,'Can view assessment workflow step',213,'view_assessmentworkflowstep'),(853,'Can add team assessment workflow',214,'add_teamassessmentworkflow'),(854,'Can change team assessment workflow',214,'change_teamassessmentworkflow'),(855,'Can delete team assessment workflow',214,'delete_teamassessmentworkflow'),(856,'Can view team assessment workflow',214,'view_teamassessmentworkflow'),(857,'Can add profile',215,'add_profile'),(858,'Can change profile',215,'change_profile'),(859,'Can delete profile',215,'delete_profile'),(860,'Can view profile',215,'view_profile'),(861,'Can add video',216,'add_video'),(862,'Can change video',216,'change_video'),(863,'Can delete video',216,'delete_video'),(864,'Can view video',216,'view_video'),(865,'Can add encoded video',217,'add_encodedvideo'),(866,'Can change encoded video',217,'change_encodedvideo'),(867,'Can delete encoded video',217,'delete_encodedvideo'),(868,'Can view encoded video',217,'view_encodedvideo'),(869,'Can add course video',218,'add_coursevideo'),(870,'Can change course video',218,'change_coursevideo'),(871,'Can delete course video',218,'delete_coursevideo'),(872,'Can view course video',218,'view_coursevideo'),(873,'Can add video image',219,'add_videoimage'),(874,'Can change video image',219,'change_videoimage'),(875,'Can delete video image',219,'delete_videoimage'),(876,'Can view video image',219,'view_videoimage'),(877,'Can add transcript preference',220,'add_transcriptpreference'),(878,'Can change transcript preference',220,'change_transcriptpreference'),(879,'Can delete transcript preference',220,'delete_transcriptpreference'),(880,'Can view transcript preference',220,'view_transcriptpreference'),(881,'Can add video transcript',221,'add_videotranscript'),(882,'Can change video transcript',221,'change_videotranscript'),(883,'Can delete video transcript',221,'delete_videotranscript'),(884,'Can view video transcript',221,'view_videotranscript'),(885,'Can add third party transcript credentials state',222,'add_thirdpartytranscriptcredentialsstate'),(886,'Can change third party transcript credentials state',222,'change_thirdpartytranscriptcredentialsstate'),(887,'Can delete third party transcript credentials state',222,'delete_thirdpartytranscriptcredentialsstate'),(888,'Can view third party transcript credentials state',222,'view_thirdpartytranscriptcredentialsstate'),(889,'Can add course overview',223,'add_courseoverview'),(890,'Can change course overview',223,'change_courseoverview'),(891,'Can delete course overview',223,'delete_courseoverview'),(892,'Can view course overview',223,'view_courseoverview'),(893,'Can add course overview tab',224,'add_courseoverviewtab'),(894,'Can change course overview tab',224,'change_courseoverviewtab'),(895,'Can delete course overview tab',224,'delete_courseoverviewtab'),(896,'Can view course overview tab',224,'view_courseoverviewtab'),(897,'Can add course overview image set',225,'add_courseoverviewimageset'),(898,'Can change course overview image set',225,'change_courseoverviewimageset'),(899,'Can delete course overview image set',225,'delete_courseoverviewimageset'),(900,'Can view course overview image set',225,'view_courseoverviewimageset'),(901,'Can add course overview image config',226,'add_courseoverviewimageconfig'),(902,'Can change course overview image config',226,'change_courseoverviewimageconfig'),(903,'Can delete course overview image config',226,'delete_courseoverviewimageconfig'),(904,'Can view course overview image config',226,'view_courseoverviewimageconfig'),(905,'Can add historical course overview',227,'add_historicalcourseoverview'),(906,'Can change historical course overview',227,'change_historicalcourseoverview'),(907,'Can delete historical course overview',227,'delete_historicalcourseoverview'),(908,'Can view historical course overview',227,'view_historicalcourseoverview'),(909,'Can add simulate_publish argument',228,'add_simulatecoursepublishconfig'),(910,'Can change simulate_publish argument',228,'change_simulatecoursepublishconfig'),(911,'Can delete simulate_publish argument',228,'delete_simulatecoursepublishconfig'),(912,'Can view simulate_publish argument',228,'view_simulatecoursepublishconfig'),(913,'Can add block structure configuration',229,'add_blockstructureconfiguration'),(914,'Can change block structure configuration',229,'change_blockstructureconfiguration'),(915,'Can delete block structure configuration',229,'delete_blockstructureconfiguration'),(916,'Can view block structure configuration',229,'view_blockstructureconfiguration'),(917,'Can add block structure model',230,'add_blockstructuremodel'),(918,'Can change block structure model',230,'change_blockstructuremodel'),(919,'Can delete block structure model',230,'delete_blockstructuremodel'),(920,'Can view block structure model',230,'view_blockstructuremodel'),(921,'Can add x domain proxy configuration',231,'add_xdomainproxyconfiguration'),(922,'Can change x domain proxy configuration',231,'change_xdomainproxyconfiguration'),(923,'Can delete x domain proxy configuration',231,'delete_xdomainproxyconfiguration'),(924,'Can view x domain proxy configuration',231,'view_xdomainproxyconfiguration'),(925,'Can add commerce configuration',232,'add_commerceconfiguration'),(926,'Can change commerce configuration',232,'change_commerceconfiguration'),(927,'Can delete commerce configuration',232,'delete_commerceconfiguration'),(928,'Can view commerce configuration',232,'view_commerceconfiguration'),(929,'Can add credit course',233,'add_creditcourse'),(930,'Can change credit course',233,'change_creditcourse'),(931,'Can delete credit course',233,'delete_creditcourse'),(932,'Can view credit course',233,'view_creditcourse'),(933,'Can add credit eligibility',234,'add_crediteligibility'),(934,'Can change credit eligibility',234,'change_crediteligibility'),(935,'Can delete credit eligibility',234,'delete_crediteligibility'),(936,'Can view credit eligibility',234,'view_crediteligibility'),(937,'Can add credit provider',235,'add_creditprovider'),(938,'Can change credit provider',235,'change_creditprovider'),(939,'Can delete credit provider',235,'delete_creditprovider'),(940,'Can view credit provider',235,'view_creditprovider'),(941,'Can add credit request',236,'add_creditrequest'),(942,'Can change credit request',236,'change_creditrequest'),(943,'Can delete credit request',236,'delete_creditrequest'),(944,'Can view credit request',236,'view_creditrequest'),(945,'Can add credit requirement',237,'add_creditrequirement'),(946,'Can change credit requirement',237,'change_creditrequirement'),(947,'Can delete credit requirement',237,'delete_creditrequirement'),(948,'Can view credit requirement',237,'view_creditrequirement'),(949,'Can add credit requirement status',238,'add_creditrequirementstatus'),(950,'Can change credit requirement status',238,'change_creditrequirementstatus'),(951,'Can delete credit requirement status',238,'delete_creditrequirementstatus'),(952,'Can view credit requirement status',238,'view_creditrequirementstatus'),(953,'Can add credit config',239,'add_creditconfig'),(954,'Can change credit config',239,'change_creditconfig'),(955,'Can delete credit config',239,'delete_creditconfig'),(956,'Can view credit config',239,'view_creditconfig'),(957,'Can add course team',240,'add_courseteam'),(958,'Can change course team',240,'change_courseteam'),(959,'Can delete course team',240,'delete_courseteam'),(960,'Can view course team',240,'view_courseteam'),(961,'Can add course team membership',241,'add_courseteammembership'),(962,'Can change course team membership',241,'change_courseteammembership'),(963,'Can delete course team membership',241,'delete_courseteammembership'),(964,'Can view course team membership',241,'view_courseteammembership'),(965,'Can add x block configuration',242,'add_xblockconfiguration'),(966,'Can change x block configuration',242,'change_xblockconfiguration'),(967,'Can delete x block configuration',242,'delete_xblockconfiguration'),(968,'Can view x block configuration',242,'view_xblockconfiguration'),(969,'Can add x block studio configuration',243,'add_xblockstudioconfiguration'),(970,'Can change x block studio configuration',243,'change_xblockstudioconfiguration'),(971,'Can delete x block studio configuration',243,'delete_xblockstudioconfiguration'),(972,'Can view x block studio configuration',243,'view_xblockstudioconfiguration'),(973,'Can add x block studio configuration flag',244,'add_xblockstudioconfigurationflag'),(974,'Can change x block studio configuration flag',244,'change_xblockstudioconfigurationflag'),(975,'Can delete x block studio configuration flag',244,'delete_xblockstudioconfigurationflag'),(976,'Can view x block studio configuration flag',244,'view_xblockstudioconfigurationflag'),(977,'Can add programs api config',245,'add_programsapiconfig'),(978,'Can change programs api config',245,'change_programsapiconfig'),(979,'Can delete programs api config',245,'delete_programsapiconfig'),(980,'Can view programs api config',245,'view_programsapiconfig'),(981,'Can add backpopulate_program_credentials argument',246,'add_customprogramsconfig'),(982,'Can change backpopulate_program_credentials argument',246,'change_customprogramsconfig'),(983,'Can delete backpopulate_program_credentials argument',246,'delete_customprogramsconfig'),(984,'Can view backpopulate_program_credentials argument',246,'view_customprogramsconfig'),(985,'Can add catalog integration',247,'add_catalogintegration'),(986,'Can change catalog integration',247,'change_catalogintegration'),(987,'Can delete catalog integration',247,'delete_catalogintegration'),(988,'Can view catalog integration',247,'view_catalogintegration'),(989,'Can add self paced configuration',248,'add_selfpacedconfiguration'),(990,'Can change self paced configuration',248,'change_selfpacedconfiguration'),(991,'Can delete self paced configuration',248,'delete_selfpacedconfiguration'),(992,'Can view self paced configuration',248,'view_selfpacedconfiguration'),(993,'Can add kv store',249,'add_kvstore'),(994,'Can change kv store',249,'change_kvstore'),(995,'Can delete kv store',249,'delete_kvstore'),(996,'Can view kv store',249,'view_kvstore'),(997,'Can add course content milestone',250,'add_coursecontentmilestone'),(998,'Can change course content milestone',250,'change_coursecontentmilestone'),(999,'Can delete course content milestone',250,'delete_coursecontentmilestone'),(1000,'Can view course content milestone',250,'view_coursecontentmilestone'),(1001,'Can add course milestone',251,'add_coursemilestone'),(1002,'Can change course milestone',251,'change_coursemilestone'),(1003,'Can delete course milestone',251,'delete_coursemilestone'),(1004,'Can view course milestone',251,'view_coursemilestone'),(1005,'Can add milestone',252,'add_milestone'),(1006,'Can change milestone',252,'change_milestone'),(1007,'Can delete milestone',252,'delete_milestone'),(1008,'Can view milestone',252,'view_milestone'),(1009,'Can add milestone relationship type',253,'add_milestonerelationshiptype'),(1010,'Can change milestone relationship type',253,'change_milestonerelationshiptype'),(1011,'Can delete milestone relationship type',253,'delete_milestonerelationshiptype'),(1012,'Can view milestone relationship type',253,'view_milestonerelationshiptype'),(1013,'Can add user milestone',254,'add_usermilestone'),(1014,'Can change user milestone',254,'change_usermilestone'),(1015,'Can delete user milestone',254,'delete_usermilestone'),(1016,'Can view user milestone',254,'view_usermilestone'),(1017,'Can add api access request',1,'add_apiaccessrequest'),(1018,'Can change api access request',1,'change_apiaccessrequest'),(1019,'Can delete api access request',1,'delete_apiaccessrequest'),(1020,'Can view api access request',1,'view_apiaccessrequest'),(1021,'Can add api access config',255,'add_apiaccessconfig'),(1022,'Can change api access config',255,'change_apiaccessconfig'),(1023,'Can delete api access config',255,'delete_apiaccessconfig'),(1024,'Can view api access config',255,'view_apiaccessconfig'),(1025,'Can add catalog',256,'add_catalog'),(1026,'Can change catalog',256,'change_catalog'),(1027,'Can delete catalog',256,'delete_catalog'),(1028,'Can view catalog',256,'view_catalog'),(1029,'Can add verified track cohorted course',257,'add_verifiedtrackcohortedcourse'),(1030,'Can change verified track cohorted course',257,'change_verifiedtrackcohortedcourse'),(1031,'Can delete verified track cohorted course',257,'delete_verifiedtrackcohortedcourse'),(1032,'Can view verified track cohorted course',257,'view_verifiedtrackcohortedcourse'),(1033,'Can add migrate verified track cohorts setting',258,'add_migrateverifiedtrackcohortssetting'),(1034,'Can change migrate verified track cohorts setting',258,'change_migrateverifiedtrackcohortssetting'),(1035,'Can delete migrate verified track cohorts setting',258,'delete_migrateverifiedtrackcohortssetting'),(1036,'Can view migrate verified track cohorts setting',258,'view_migrateverifiedtrackcohortssetting'),(1037,'Can add badge assertion',259,'add_badgeassertion'),(1038,'Can change badge assertion',259,'change_badgeassertion'),(1039,'Can delete badge assertion',259,'delete_badgeassertion'),(1040,'Can view badge assertion',259,'view_badgeassertion'),(1041,'Can add badge class',260,'add_badgeclass'),(1042,'Can change badge class',260,'change_badgeclass'),(1043,'Can delete badge class',260,'delete_badgeclass'),(1044,'Can view badge class',260,'view_badgeclass'),(1045,'Can add course complete image configuration',261,'add_coursecompleteimageconfiguration'),(1046,'Can change course complete image configuration',261,'change_coursecompleteimageconfiguration'),(1047,'Can delete course complete image configuration',261,'delete_coursecompleteimageconfiguration'),(1048,'Can view course complete image configuration',261,'view_coursecompleteimageconfiguration'),(1049,'Can add course event badges configuration',262,'add_courseeventbadgesconfiguration'),(1050,'Can change course event badges configuration',262,'change_courseeventbadgesconfiguration'),(1051,'Can delete course event badges configuration',262,'delete_courseeventbadgesconfiguration'),(1052,'Can view course event badges configuration',262,'view_courseeventbadgesconfiguration'),(1053,'Can add email marketing configuration',263,'add_emailmarketingconfiguration'),(1054,'Can change email marketing configuration',263,'change_emailmarketingconfiguration'),(1055,'Can delete email marketing configuration',263,'delete_emailmarketingconfiguration'),(1056,'Can view email marketing configuration',263,'view_emailmarketingconfiguration'),(1057,'Can add failed task',264,'add_failedtask'),(1058,'Can change failed task',264,'change_failedtask'),(1059,'Can delete failed task',264,'delete_failedtask'),(1060,'Can view failed task',264,'view_failedtask'),(1061,'Can add crawlers config',265,'add_crawlersconfig'),(1062,'Can change crawlers config',265,'change_crawlersconfig'),(1063,'Can delete crawlers config',265,'delete_crawlersconfig'),(1064,'Can view crawlers config',265,'view_crawlersconfig'),(1065,'Can add Waffle flag course override',266,'add_waffleflagcourseoverridemodel'),(1066,'Can change Waffle flag course override',266,'change_waffleflagcourseoverridemodel'),(1067,'Can delete Waffle flag course override',266,'delete_waffleflagcourseoverridemodel'),(1068,'Can view Waffle flag course override',266,'view_waffleflagcourseoverridemodel'),(1069,'Can add course goal',267,'add_coursegoal'),(1070,'Can change course goal',267,'change_coursegoal'),(1071,'Can delete course goal',267,'delete_coursegoal'),(1072,'Can view course goal',267,'view_coursegoal'),(1073,'Can add historical user calendar sync config',268,'add_historicalusercalendarsyncconfig'),(1074,'Can change historical user calendar sync config',268,'change_historicalusercalendarsyncconfig'),(1075,'Can delete historical user calendar sync config',268,'delete_historicalusercalendarsyncconfig'),(1076,'Can view historical user calendar sync config',268,'view_historicalusercalendarsyncconfig'),(1077,'Can add user calendar sync config',269,'add_usercalendarsyncconfig'),(1078,'Can change user calendar sync config',269,'change_usercalendarsyncconfig'),(1079,'Can delete user calendar sync config',269,'delete_usercalendarsyncconfig'),(1080,'Can view user calendar sync config',269,'view_usercalendarsyncconfig'),(1081,'Can add course duration limit config',270,'add_coursedurationlimitconfig'),(1082,'Can change course duration limit config',270,'change_coursedurationlimitconfig'),(1083,'Can delete course duration limit config',270,'delete_coursedurationlimitconfig'),(1084,'Can view course duration limit config',270,'view_coursedurationlimitconfig'),(1085,'Can add content type gating config',271,'add_contenttypegatingconfig'),(1086,'Can change content type gating config',271,'change_contenttypegatingconfig'),(1087,'Can delete content type gating config',271,'delete_contenttypegatingconfig'),(1088,'Can view content type gating config',271,'view_contenttypegatingconfig'),(1089,'Can add discount restriction config',272,'add_discountrestrictionconfig'),(1090,'Can change discount restriction config',272,'change_discountrestrictionconfig'),(1091,'Can delete discount restriction config',272,'delete_discountrestrictionconfig'),(1092,'Can view discount restriction config',272,'view_discountrestrictionconfig'),(1093,'Can add discount percentage config',273,'add_discountpercentageconfig'),(1094,'Can change discount percentage config',273,'change_discountpercentageconfig'),(1095,'Can delete discount percentage config',273,'delete_discountpercentageconfig'),(1096,'Can view discount percentage config',273,'view_discountpercentageconfig'),(1097,'Can add Experiment Data',274,'add_experimentdata'),(1098,'Can change Experiment Data',274,'change_experimentdata'),(1099,'Can delete Experiment Data',274,'delete_experimentdata'),(1100,'Can view Experiment Data',274,'view_experimentdata'),(1101,'Can add Experiment Key-Value Pair',275,'add_experimentkeyvalue'),(1102,'Can change Experiment Key-Value Pair',275,'change_experimentkeyvalue'),(1103,'Can delete Experiment Key-Value Pair',275,'delete_experimentkeyvalue'),(1104,'Can view Experiment Key-Value Pair',275,'view_experimentkeyvalue'),(1105,'Can add historical Experiment Key-Value Pair',276,'add_historicalexperimentkeyvalue'),(1106,'Can change historical Experiment Key-Value Pair',276,'change_historicalexperimentkeyvalue'),(1107,'Can delete historical Experiment Key-Value Pair',276,'delete_historicalexperimentkeyvalue'),(1108,'Can view historical Experiment Key-Value Pair',276,'view_historicalexperimentkeyvalue'),(1109,'Can add self paced relative dates config',277,'add_selfpacedrelativedatesconfig'),(1110,'Can change self paced relative dates config',277,'change_selfpacedrelativedatesconfig'),(1111,'Can delete self paced relative dates config',277,'delete_selfpacedrelativedatesconfig'),(1112,'Can view self paced relative dates config',277,'view_selfpacedrelativedatesconfig'),(1113,'Can add external id',278,'add_externalid'),(1114,'Can change external id',278,'change_externalid'),(1115,'Can delete external id',278,'delete_externalid'),(1116,'Can view external id',278,'view_externalid'),(1117,'Can add external id type',279,'add_externalidtype'),(1118,'Can change external id type',279,'change_externalidtype'),(1119,'Can delete external id type',279,'delete_externalidtype'),(1120,'Can view external id type',279,'view_externalidtype'),(1121,'Can add historical external id',280,'add_historicalexternalid'),(1122,'Can change historical external id',280,'change_historicalexternalid'),(1123,'Can delete historical external id',280,'delete_historicalexternalid'),(1124,'Can view historical external id',280,'view_historicalexternalid'),(1125,'Can add historical external id type',281,'add_historicalexternalidtype'),(1126,'Can change historical external id type',281,'change_historicalexternalidtype'),(1127,'Can delete historical external id type',281,'delete_historicalexternalidtype'),(1128,'Can view historical external id type',281,'view_historicalexternalidtype'),(1129,'Can add user demographic',282,'add_userdemographics'),(1130,'Can change user demographic',282,'change_userdemographics'),(1131,'Can delete user demographic',282,'delete_userdemographics'),(1132,'Can view user demographic',282,'view_userdemographics'),(1133,'Can add historical user demographic',283,'add_historicaluserdemographics'),(1134,'Can change historical user demographic',283,'change_historicaluserdemographics'),(1135,'Can delete historical user demographic',283,'delete_historicaluserdemographics'),(1136,'Can view historical user demographic',283,'view_historicaluserdemographics'),(1137,'Can add Schedule',284,'add_schedule'),(1138,'Can change Schedule',284,'change_schedule'),(1139,'Can delete Schedule',284,'delete_schedule'),(1140,'Can view Schedule',284,'view_schedule'),(1141,'Can add schedule config',285,'add_scheduleconfig'),(1142,'Can change schedule config',285,'change_scheduleconfig'),(1143,'Can delete schedule config',285,'delete_scheduleconfig'),(1144,'Can view schedule config',285,'view_scheduleconfig'),(1145,'Can add schedule experience',286,'add_scheduleexperience'),(1146,'Can change schedule experience',286,'change_scheduleexperience'),(1147,'Can delete schedule experience',286,'delete_scheduleexperience'),(1148,'Can view schedule experience',286,'view_scheduleexperience'),(1149,'Can add historical Schedule',287,'add_historicalschedule'),(1150,'Can change historical Schedule',287,'change_historicalschedule'),(1151,'Can delete historical Schedule',287,'delete_historicalschedule'),(1152,'Can view historical Schedule',287,'view_historicalschedule'),(1153,'Can add course section',288,'add_coursesection'),(1154,'Can change course section',288,'change_coursesection'),(1155,'Can delete course section',288,'delete_coursesection'),(1156,'Can view course section',288,'view_coursesection'),(1157,'Can add Course Sequence',289,'add_coursesectionsequence'),(1158,'Can change Course Sequence',289,'change_coursesectionsequence'),(1159,'Can delete Course Sequence',289,'delete_coursesectionsequence'),(1160,'Can view Course Sequence',289,'view_coursesectionsequence'),(1161,'Can add learning context',290,'add_learningcontext'),(1162,'Can change learning context',290,'change_learningcontext'),(1163,'Can delete learning context',290,'delete_learningcontext'),(1164,'Can view learning context',290,'view_learningcontext'),(1165,'Can add learning sequence',291,'add_learningsequence'),(1166,'Can change learning sequence',291,'change_learningsequence'),(1167,'Can delete learning sequence',291,'delete_learningsequence'),(1168,'Can view learning sequence',291,'view_learningsequence'),(1169,'Can add Course',292,'add_coursecontext'),(1170,'Can change Course',292,'change_coursecontext'),(1171,'Can delete Course',292,'delete_coursecontext'),(1172,'Can view Course',292,'view_coursecontext'),(1173,'Can add course sequence exam',293,'add_coursesequenceexam'),(1174,'Can change course sequence exam',293,'change_coursesequenceexam'),(1175,'Can delete course sequence exam',293,'delete_coursesequenceexam'),(1176,'Can view course sequence exam',293,'view_coursesequenceexam'),(1177,'Can add publish report',294,'add_publishreport'),(1178,'Can change publish report',294,'change_publishreport'),(1179,'Can delete publish report',294,'delete_publishreport'),(1180,'Can view publish report',294,'view_publishreport'),(1181,'Can add content error',295,'add_contenterror'),(1182,'Can change content error',295,'change_contenterror'),(1183,'Can delete content error',295,'delete_contenterror'),(1184,'Can view content error',295,'view_contenterror'),(1185,'Can add Router Configuration',296,'add_routerconfiguration'),(1186,'Can change Router Configuration',296,'change_routerconfiguration'),(1187,'Can delete Router Configuration',296,'delete_routerconfiguration'),(1188,'Can view Router Configuration',296,'view_routerconfiguration'),(1189,'Can add organization',297,'add_organization'),(1190,'Can change organization',297,'change_organization'),(1191,'Can delete organization',297,'delete_organization'),(1192,'Can view organization',297,'view_organization'),(1193,'Can add Link Course',298,'add_organizationcourse'),(1194,'Can change Link Course',298,'change_organizationcourse'),(1195,'Can delete Link Course',298,'delete_organizationcourse'),(1196,'Can view Link Course',298,'view_organizationcourse'),(1197,'Can add historical organization',299,'add_historicalorganization'),(1198,'Can change historical organization',299,'change_historicalorganization'),(1199,'Can delete historical organization',299,'delete_historicalorganization'),(1200,'Can view historical organization',299,'view_historicalorganization'),(1201,'Can add historical Link Course',300,'add_historicalorganizationcourse'),(1202,'Can change historical Link Course',300,'change_historicalorganizationcourse'),(1203,'Can delete historical Link Course',300,'delete_historicalorganizationcourse'),(1204,'Can view historical Link Course',300,'view_historicalorganizationcourse'),(1205,'Can add user task artifact',301,'add_usertaskartifact'),(1206,'Can change user task artifact',301,'change_usertaskartifact'),(1207,'Can delete user task artifact',301,'delete_usertaskartifact'),(1208,'Can view user task artifact',301,'view_usertaskartifact'),(1209,'Can add user task status',302,'add_usertaskstatus'),(1210,'Can change user task status',302,'change_usertaskstatus'),(1211,'Can delete user task status',302,'delete_usertaskstatus'),(1212,'Can view user task status',302,'view_usertaskstatus'),(1213,'Can add enrollment notification email template',303,'add_enrollmentnotificationemailtemplate'),(1214,'Can change enrollment notification email template',303,'change_enrollmentnotificationemailtemplate'),(1215,'Can delete enrollment notification email template',303,'delete_enrollmentnotificationemailtemplate'),(1216,'Can view enrollment notification email template',303,'view_enrollmentnotificationemailtemplate'),(1217,'Can add Enterprise Catalog Query',304,'add_enterprisecatalogquery'),(1218,'Can change Enterprise Catalog Query',304,'change_enterprisecatalogquery'),(1219,'Can delete Enterprise Catalog Query',304,'delete_enterprisecatalogquery'),(1220,'Can view Enterprise Catalog Query',304,'view_enterprisecatalogquery'),(1221,'Can add enterprise course enrollment',305,'add_enterprisecourseenrollment'),(1222,'Can change enterprise course enrollment',305,'change_enterprisecourseenrollment'),(1223,'Can delete enterprise course enrollment',305,'delete_enterprisecourseenrollment'),(1224,'Can view enterprise course enrollment',305,'view_enterprisecourseenrollment'),(1225,'Can add Enterprise Customer',306,'add_enterprisecustomer'),(1226,'Can change Enterprise Customer',306,'change_enterprisecustomer'),(1227,'Can delete Enterprise Customer',306,'delete_enterprisecustomer'),(1228,'Can view Enterprise Customer',306,'view_enterprisecustomer'),(1229,'Can add Branding Configuration',307,'add_enterprisecustomerbrandingconfiguration'),(1230,'Can change Branding Configuration',307,'change_enterprisecustomerbrandingconfiguration'),(1231,'Can delete Branding Configuration',307,'delete_enterprisecustomerbrandingconfiguration'),(1232,'Can view Branding Configuration',307,'view_enterprisecustomerbrandingconfiguration'),(1233,'Can add Enterprise Customer Catalog',308,'add_enterprisecustomercatalog'),(1234,'Can change Enterprise Customer Catalog',308,'change_enterprisecustomercatalog'),(1235,'Can delete Enterprise Customer Catalog',308,'delete_enterprisecustomercatalog'),(1236,'Can view Enterprise Customer Catalog',308,'view_enterprisecustomercatalog'),(1237,'Can add enterprise customer identity provider',309,'add_enterprisecustomeridentityprovider'),(1238,'Can change enterprise customer identity provider',309,'change_enterprisecustomeridentityprovider'),(1239,'Can delete enterprise customer identity provider',309,'delete_enterprisecustomeridentityprovider'),(1240,'Can view enterprise customer identity provider',309,'view_enterprisecustomeridentityprovider'),(1241,'Can add enterprise customer reporting configuration',310,'add_enterprisecustomerreportingconfiguration'),(1242,'Can change enterprise customer reporting configuration',310,'change_enterprisecustomerreportingconfiguration'),(1243,'Can delete enterprise customer reporting configuration',310,'delete_enterprisecustomerreportingconfiguration'),(1244,'Can view enterprise customer reporting configuration',310,'view_enterprisecustomerreportingconfiguration'),(1245,'Can add Enterprise Customer Type',311,'add_enterprisecustomertype'),(1246,'Can change Enterprise Customer Type',311,'change_enterprisecustomertype'),(1247,'Can delete Enterprise Customer Type',311,'delete_enterprisecustomertype'),(1248,'Can view Enterprise Customer Type',311,'view_enterprisecustomertype'),(1249,'Can add Enterprise Customer Learner',312,'add_enterprisecustomeruser'),(1250,'Can change Enterprise Customer Learner',312,'change_enterprisecustomeruser'),(1251,'Can delete Enterprise Customer Learner',312,'delete_enterprisecustomeruser'),(1252,'Can view Enterprise Customer Learner',312,'view_enterprisecustomeruser'),(1253,'Can add enterprise enrollment source',313,'add_enterpriseenrollmentsource'),(1254,'Can change enterprise enrollment source',313,'change_enterpriseenrollmentsource'),(1255,'Can delete enterprise enrollment source',313,'delete_enterpriseenrollmentsource'),(1256,'Can view enterprise enrollment source',313,'view_enterpriseenrollmentsource'),(1257,'Can add enterprise feature role',314,'add_enterprisefeaturerole'),(1258,'Can change enterprise feature role',314,'change_enterprisefeaturerole'),(1259,'Can delete enterprise feature role',314,'delete_enterprisefeaturerole'),(1260,'Can view enterprise feature role',314,'view_enterprisefeaturerole'),(1261,'Can add enterprise feature user role assignment',315,'add_enterprisefeatureuserroleassignment'),(1262,'Can change enterprise feature user role assignment',315,'change_enterprisefeatureuserroleassignment'),(1263,'Can delete enterprise feature user role assignment',315,'delete_enterprisefeatureuserroleassignment'),(1264,'Can view enterprise feature user role assignment',315,'view_enterprisefeatureuserroleassignment'),(1265,'Can add historical enrollment notification email template',316,'add_historicalenrollmentnotificationemailtemplate'),(1266,'Can change historical enrollment notification email template',316,'change_historicalenrollmentnotificationemailtemplate'),(1267,'Can delete historical enrollment notification email template',316,'delete_historicalenrollmentnotificationemailtemplate'),(1268,'Can view historical enrollment notification email template',316,'view_historicalenrollmentnotificationemailtemplate'),(1269,'Can add historical enterprise course enrollment',317,'add_historicalenterprisecourseenrollment'),(1270,'Can change historical enterprise course enrollment',317,'change_historicalenterprisecourseenrollment'),(1271,'Can delete historical enterprise course enrollment',317,'delete_historicalenterprisecourseenrollment'),(1272,'Can view historical enterprise course enrollment',317,'view_historicalenterprisecourseenrollment'),(1273,'Can add historical Enterprise Customer',318,'add_historicalenterprisecustomer'),(1274,'Can change historical Enterprise Customer',318,'change_historicalenterprisecustomer'),(1275,'Can delete historical Enterprise Customer',318,'delete_historicalenterprisecustomer'),(1276,'Can view historical Enterprise Customer',318,'view_historicalenterprisecustomer'),(1277,'Can add historical Enterprise Customer Catalog',319,'add_historicalenterprisecustomercatalog'),(1278,'Can change historical Enterprise Customer Catalog',319,'change_historicalenterprisecustomercatalog'),(1279,'Can delete historical Enterprise Customer Catalog',319,'delete_historicalenterprisecustomercatalog'),(1280,'Can view historical Enterprise Customer Catalog',319,'view_historicalenterprisecustomercatalog'),(1281,'Can add historical pending enrollment',320,'add_historicalpendingenrollment'),(1282,'Can change historical pending enrollment',320,'change_historicalpendingenrollment'),(1283,'Can delete historical pending enrollment',320,'delete_historicalpendingenrollment'),(1284,'Can view historical pending enrollment',320,'view_historicalpendingenrollment'),(1285,'Can add historical pending enterprise customer user',321,'add_historicalpendingenterprisecustomeruser'),(1286,'Can change historical pending enterprise customer user',321,'change_historicalpendingenterprisecustomeruser'),(1287,'Can delete historical pending enterprise customer user',321,'delete_historicalpendingenterprisecustomeruser'),(1288,'Can view historical pending enterprise customer user',321,'view_historicalpendingenterprisecustomeruser'),(1289,'Can add pending enrollment',322,'add_pendingenrollment'),(1290,'Can change pending enrollment',322,'change_pendingenrollment'),(1291,'Can delete pending enrollment',322,'delete_pendingenrollment'),(1292,'Can view pending enrollment',322,'view_pendingenrollment'),(1293,'Can add pending enterprise customer user',323,'add_pendingenterprisecustomeruser'),(1294,'Can change pending enterprise customer user',323,'change_pendingenterprisecustomeruser'),(1295,'Can delete pending enterprise customer user',323,'delete_pendingenterprisecustomeruser'),(1296,'Can view pending enterprise customer user',323,'view_pendingenterprisecustomeruser'),(1297,'Can add system wide enterprise role',324,'add_systemwideenterpriserole'),(1298,'Can change system wide enterprise role',324,'change_systemwideenterpriserole'),(1299,'Can delete system wide enterprise role',324,'delete_systemwideenterpriserole'),(1300,'Can view system wide enterprise role',324,'view_systemwideenterpriserole'),(1301,'Can add system wide enterprise user role assignment',325,'add_systemwideenterpriseuserroleassignment'),(1302,'Can change system wide enterprise user role assignment',325,'change_systemwideenterpriseuserroleassignment'),(1303,'Can delete system wide enterprise user role assignment',325,'delete_systemwideenterpriseuserroleassignment'),(1304,'Can view system wide enterprise user role assignment',325,'view_systemwideenterpriseuserroleassignment'),(1305,'Can add licensed enterprise course enrollment',326,'add_licensedenterprisecourseenrollment'),(1306,'Can change licensed enterprise course enrollment',326,'change_licensedenterprisecourseenrollment'),(1307,'Can delete licensed enterprise course enrollment',326,'delete_licensedenterprisecourseenrollment'),(1308,'Can view licensed enterprise course enrollment',326,'view_licensedenterprisecourseenrollment'),(1309,'Can add historical licensed enterprise course enrollment',327,'add_historicallicensedenterprisecourseenrollment'),(1310,'Can change historical licensed enterprise course enrollment',327,'change_historicallicensedenterprisecourseenrollment'),(1311,'Can delete historical licensed enterprise course enrollment',327,'delete_historicallicensedenterprisecourseenrollment'),(1312,'Can view historical licensed enterprise course enrollment',327,'view_historicallicensedenterprisecourseenrollment'),(1313,'Can add historical pending enterprise customer admin user',328,'add_historicalpendingenterprisecustomeradminuser'),(1314,'Can change historical pending enterprise customer admin user',328,'change_historicalpendingenterprisecustomeradminuser'),(1315,'Can delete historical pending enterprise customer admin user',328,'delete_historicalpendingenterprisecustomeradminuser'),(1316,'Can view historical pending enterprise customer admin user',328,'view_historicalpendingenterprisecustomeradminuser'),(1317,'Can add pending enterprise customer admin user',329,'add_pendingenterprisecustomeradminuser'),(1318,'Can change pending enterprise customer admin user',329,'change_pendingenterprisecustomeradminuser'),(1319,'Can delete pending enterprise customer admin user',329,'delete_pendingenterprisecustomeradminuser'),(1320,'Can view pending enterprise customer admin user',329,'view_pendingenterprisecustomeradminuser'),(1321,'Can add historical enterprise analytics user',330,'add_historicalenterpriseanalyticsuser'),(1322,'Can change historical enterprise analytics user',330,'change_historicalenterpriseanalyticsuser'),(1323,'Can delete historical enterprise analytics user',330,'delete_historicalenterpriseanalyticsuser'),(1324,'Can view historical enterprise analytics user',330,'view_historicalenterpriseanalyticsuser'),(1325,'Can add enterprise analytics user',331,'add_enterpriseanalyticsuser'),(1326,'Can change enterprise analytics user',331,'change_enterpriseanalyticsuser'),(1327,'Can delete enterprise analytics user',331,'delete_enterpriseanalyticsuser'),(1328,'Can view enterprise analytics user',331,'view_enterpriseanalyticsuser'),(1329,'Can add update role assignments with customers config',332,'add_updateroleassignmentswithcustomersconfig'),(1330,'Can change update role assignments with customers config',332,'change_updateroleassignmentswithcustomersconfig'),(1331,'Can delete update role assignments with customers config',332,'delete_updateroleassignmentswithcustomersconfig'),(1332,'Can view update role assignments with customers config',332,'view_updateroleassignmentswithcustomersconfig'),(1333,'Can add Data Sharing Consent Record',333,'add_datasharingconsent'),(1334,'Can change Data Sharing Consent Record',333,'change_datasharingconsent'),(1335,'Can delete Data Sharing Consent Record',333,'delete_datasharingconsent'),(1336,'Can view Data Sharing Consent Record',333,'view_datasharingconsent'),(1337,'Can add historical Data Sharing Consent Record',334,'add_historicaldatasharingconsent'),(1338,'Can change historical Data Sharing Consent Record',334,'change_historicaldatasharingconsent'),(1339,'Can delete historical Data Sharing Consent Record',334,'delete_historicaldatasharingconsent'),(1340,'Can view historical Data Sharing Consent Record',334,'view_historicaldatasharingconsent'),(1341,'Can add data sharing consent text overrides',335,'add_datasharingconsenttextoverrides'),(1342,'Can change data sharing consent text overrides',335,'change_datasharingconsenttextoverrides'),(1343,'Can delete data sharing consent text overrides',335,'delete_datasharingconsenttextoverrides'),(1344,'Can view data sharing consent text overrides',335,'view_datasharingconsenttextoverrides'),(1345,'Can add learner data transmission audit',336,'add_learnerdatatransmissionaudit'),(1346,'Can change learner data transmission audit',336,'change_learnerdatatransmissionaudit'),(1347,'Can delete learner data transmission audit',336,'delete_learnerdatatransmissionaudit'),(1348,'Can view learner data transmission audit',336,'view_learnerdatatransmissionaudit'),(1349,'Can add content metadata item transmission',337,'add_contentmetadataitemtransmission'),(1350,'Can change content metadata item transmission',337,'change_contentmetadataitemtransmission'),(1351,'Can delete content metadata item transmission',337,'delete_contentmetadataitemtransmission'),(1352,'Can view content metadata item transmission',337,'view_contentmetadataitemtransmission'),(1353,'Can add degreed enterprise customer configuration',338,'add_degreedenterprisecustomerconfiguration'),(1354,'Can change degreed enterprise customer configuration',338,'change_degreedenterprisecustomerconfiguration'),(1355,'Can delete degreed enterprise customer configuration',338,'delete_degreedenterprisecustomerconfiguration'),(1356,'Can view degreed enterprise customer configuration',338,'view_degreedenterprisecustomerconfiguration'),(1357,'Can add degreed global configuration',339,'add_degreedglobalconfiguration'),(1358,'Can change degreed global configuration',339,'change_degreedglobalconfiguration'),(1359,'Can delete degreed global configuration',339,'delete_degreedglobalconfiguration'),(1360,'Can view degreed global configuration',339,'view_degreedglobalconfiguration'),(1361,'Can add degreed learner data transmission audit',340,'add_degreedlearnerdatatransmissionaudit'),(1362,'Can change degreed learner data transmission audit',340,'change_degreedlearnerdatatransmissionaudit'),(1363,'Can delete degreed learner data transmission audit',340,'delete_degreedlearnerdatatransmissionaudit'),(1364,'Can view degreed learner data transmission audit',340,'view_degreedlearnerdatatransmissionaudit'),(1365,'Can add historical degreed enterprise customer configuration',341,'add_historicaldegreedenterprisecustomerconfiguration'),(1366,'Can change historical degreed enterprise customer configuration',341,'change_historicaldegreedenterprisecustomerconfiguration'),(1367,'Can delete historical degreed enterprise customer configuration',341,'delete_historicaldegreedenterprisecustomerconfiguration'),(1368,'Can view historical degreed enterprise customer configuration',341,'view_historicaldegreedenterprisecustomerconfiguration'),(1369,'Can add sap success factors learner data transmission audit',342,'add_sapsuccessfactorslearnerdatatransmissionaudit'),(1370,'Can change sap success factors learner data transmission audit',342,'change_sapsuccessfactorslearnerdatatransmissionaudit'),(1371,'Can delete sap success factors learner data transmission audit',342,'delete_sapsuccessfactorslearnerdatatransmissionaudit'),(1372,'Can view sap success factors learner data transmission audit',342,'view_sapsuccessfactorslearnerdatatransmissionaudit'),(1373,'Can add sap success factors global configuration',343,'add_sapsuccessfactorsglobalconfiguration'),(1374,'Can change sap success factors global configuration',343,'change_sapsuccessfactorsglobalconfiguration'),(1375,'Can delete sap success factors global configuration',343,'delete_sapsuccessfactorsglobalconfiguration'),(1376,'Can view sap success factors global configuration',343,'view_sapsuccessfactorsglobalconfiguration'),(1377,'Can add sap success factors enterprise customer configuration',344,'add_sapsuccessfactorsenterprisecustomerconfiguration'),(1378,'Can change sap success factors enterprise customer configuration',344,'change_sapsuccessfactorsenterprisecustomerconfiguration'),(1379,'Can delete sap success factors enterprise customer configuration',344,'delete_sapsuccessfactorsenterprisecustomerconfiguration'),(1380,'Can view sap success factors enterprise customer configuration',344,'view_sapsuccessfactorsenterprisecustomerconfiguration'),(1381,'Can add cornerstone enterprise customer configuration',345,'add_cornerstoneenterprisecustomerconfiguration'),(1382,'Can change cornerstone enterprise customer configuration',345,'change_cornerstoneenterprisecustomerconfiguration'),(1383,'Can delete cornerstone enterprise customer configuration',345,'delete_cornerstoneenterprisecustomerconfiguration'),(1384,'Can view cornerstone enterprise customer configuration',345,'view_cornerstoneenterprisecustomerconfiguration'),(1385,'Can add cornerstone global configuration',346,'add_cornerstoneglobalconfiguration'),(1386,'Can change cornerstone global configuration',346,'change_cornerstoneglobalconfiguration'),(1387,'Can delete cornerstone global configuration',346,'delete_cornerstoneglobalconfiguration'),(1388,'Can view cornerstone global configuration',346,'view_cornerstoneglobalconfiguration'),(1389,'Can add cornerstone learner data transmission audit',347,'add_cornerstonelearnerdatatransmissionaudit'),(1390,'Can change cornerstone learner data transmission audit',347,'change_cornerstonelearnerdatatransmissionaudit'),(1391,'Can delete cornerstone learner data transmission audit',347,'delete_cornerstonelearnerdatatransmissionaudit'),(1392,'Can view cornerstone learner data transmission audit',347,'view_cornerstonelearnerdatatransmissionaudit'),(1393,'Can add historical cornerstone enterprise customer configuration',348,'add_historicalcornerstoneenterprisecustomerconfiguration'),(1394,'Can change historical cornerstone enterprise customer configuration',348,'change_historicalcornerstoneenterprisecustomerconfiguration'),(1395,'Can delete historical cornerstone enterprise customer configuration',348,'delete_historicalcornerstoneenterprisecustomerconfiguration'),(1396,'Can view historical cornerstone enterprise customer configuration',348,'view_historicalcornerstoneenterprisecustomerconfiguration'),(1397,'Can add xapilrs configuration',349,'add_xapilrsconfiguration'),(1398,'Can change xapilrs configuration',349,'change_xapilrsconfiguration'),(1399,'Can delete xapilrs configuration',349,'delete_xapilrsconfiguration'),(1400,'Can view xapilrs configuration',349,'view_xapilrsconfiguration'),(1401,'Can add xapi learner data transmission audit',350,'add_xapilearnerdatatransmissionaudit'),(1402,'Can change xapi learner data transmission audit',350,'change_xapilearnerdatatransmissionaudit'),(1403,'Can delete xapi learner data transmission audit',350,'delete_xapilearnerdatatransmissionaudit'),(1404,'Can view xapi learner data transmission audit',350,'view_xapilearnerdatatransmissionaudit'),(1405,'Can add historical blackboard enterprise customer configuration',351,'add_historicalblackboardenterprisecustomerconfiguration'),(1406,'Can change historical blackboard enterprise customer configuration',351,'change_historicalblackboardenterprisecustomerconfiguration'),(1407,'Can delete historical blackboard enterprise customer configuration',351,'delete_historicalblackboardenterprisecustomerconfiguration'),(1408,'Can view historical blackboard enterprise customer configuration',351,'view_historicalblackboardenterprisecustomerconfiguration'),(1409,'Can add blackboard enterprise customer configuration',352,'add_blackboardenterprisecustomerconfiguration'),(1410,'Can change blackboard enterprise customer configuration',352,'change_blackboardenterprisecustomerconfiguration'),(1411,'Can delete blackboard enterprise customer configuration',352,'delete_blackboardenterprisecustomerconfiguration'),(1412,'Can view blackboard enterprise customer configuration',352,'view_blackboardenterprisecustomerconfiguration'),(1413,'Can add blackboard learner data transmission audit',353,'add_blackboardlearnerdatatransmissionaudit'),(1414,'Can change blackboard learner data transmission audit',353,'change_blackboardlearnerdatatransmissionaudit'),(1415,'Can delete blackboard learner data transmission audit',353,'delete_blackboardlearnerdatatransmissionaudit'),(1416,'Can view blackboard learner data transmission audit',353,'view_blackboardlearnerdatatransmissionaudit'),(1417,'Can add blackboard learner assessment data transmission audit',354,'add_blackboardlearnerassessmentdatatransmissionaudit'),(1418,'Can change blackboard learner assessment data transmission audit',354,'change_blackboardlearnerassessmentdatatransmissionaudit'),(1419,'Can delete blackboard learner assessment data transmission audit',354,'delete_blackboardlearnerassessmentdatatransmissionaudit'),(1420,'Can view blackboard learner assessment data transmission audit',354,'view_blackboardlearnerassessmentdatatransmissionaudit'),(1421,'Can add historical canvas enterprise customer configuration',355,'add_historicalcanvasenterprisecustomerconfiguration'),(1422,'Can change historical canvas enterprise customer configuration',355,'change_historicalcanvasenterprisecustomerconfiguration'),(1423,'Can delete historical canvas enterprise customer configuration',355,'delete_historicalcanvasenterprisecustomerconfiguration'),(1424,'Can view historical canvas enterprise customer configuration',355,'view_historicalcanvasenterprisecustomerconfiguration'),(1425,'Can add canvas enterprise customer configuration',356,'add_canvasenterprisecustomerconfiguration'),(1426,'Can change canvas enterprise customer configuration',356,'change_canvasenterprisecustomerconfiguration'),(1427,'Can delete canvas enterprise customer configuration',356,'delete_canvasenterprisecustomerconfiguration'),(1428,'Can view canvas enterprise customer configuration',356,'view_canvasenterprisecustomerconfiguration'),(1429,'Can add canvas learner data transmission audit',357,'add_canvaslearnerdatatransmissionaudit'),(1430,'Can change canvas learner data transmission audit',357,'change_canvaslearnerdatatransmissionaudit'),(1431,'Can delete canvas learner data transmission audit',357,'delete_canvaslearnerdatatransmissionaudit'),(1432,'Can view canvas learner data transmission audit',357,'view_canvaslearnerdatatransmissionaudit'),(1433,'Can add canvas learner assessment data transmission audit',358,'add_canvaslearnerassessmentdatatransmissionaudit'),(1434,'Can change canvas learner assessment data transmission audit',358,'change_canvaslearnerassessmentdatatransmissionaudit'),(1435,'Can delete canvas learner assessment data transmission audit',358,'delete_canvaslearnerassessmentdatatransmissionaudit'),(1436,'Can view canvas learner assessment data transmission audit',358,'view_canvaslearnerassessmentdatatransmissionaudit'),(1437,'Can add moodle enterprise customer configuration',359,'add_moodleenterprisecustomerconfiguration'),(1438,'Can change moodle enterprise customer configuration',359,'change_moodleenterprisecustomerconfiguration'),(1439,'Can delete moodle enterprise customer configuration',359,'delete_moodleenterprisecustomerconfiguration'),(1440,'Can view moodle enterprise customer configuration',359,'view_moodleenterprisecustomerconfiguration'),(1441,'Can add historical moodle enterprise customer configuration',360,'add_historicalmoodleenterprisecustomerconfiguration'),(1442,'Can change historical moodle enterprise customer configuration',360,'change_historicalmoodleenterprisecustomerconfiguration'),(1443,'Can delete historical moodle enterprise customer configuration',360,'delete_historicalmoodleenterprisecustomerconfiguration'),(1444,'Can view historical moodle enterprise customer configuration',360,'view_historicalmoodleenterprisecustomerconfiguration'),(1445,'Can add moodle learner data transmission audit',361,'add_moodlelearnerdatatransmissionaudit'),(1446,'Can change moodle learner data transmission audit',361,'change_moodlelearnerdatatransmissionaudit'),(1447,'Can delete moodle learner data transmission audit',361,'delete_moodlelearnerdatatransmissionaudit'),(1448,'Can view moodle learner data transmission audit',361,'view_moodlelearnerdatatransmissionaudit'),(1449,'Can add announcement',362,'add_announcement'),(1450,'Can change announcement',362,'change_announcement'),(1451,'Can delete announcement',362,'delete_announcement'),(1452,'Can view announcement',362,'view_announcement'),(1453,'Can add bookmark',363,'add_bookmark'),(1454,'Can change bookmark',363,'change_bookmark'),(1455,'Can delete bookmark',363,'delete_bookmark'),(1456,'Can view bookmark',363,'view_bookmark'),(1457,'Can add x block cache',364,'add_xblockcache'),(1458,'Can change x block cache',364,'change_xblockcache'),(1459,'Can delete x block cache',364,'delete_xblockcache'),(1460,'Can view x block cache',364,'view_xblockcache'),(1461,'Can add content library',365,'add_contentlibrary'),(1462,'Can change content library',365,'change_contentlibrary'),(1463,'Can delete content library',365,'delete_contentlibrary'),(1464,'Can view content library',365,'view_contentlibrary'),(1465,'Can add content library permission',366,'add_contentlibrarypermission'),(1466,'Can change content library permission',366,'change_contentlibrarypermission'),(1467,'Can delete content library permission',366,'delete_contentlibrarypermission'),(1468,'Can view content library permission',366,'view_contentlibrarypermission'),(1469,'Can add credentials api config',367,'add_credentialsapiconfig'),(1470,'Can change credentials api config',367,'change_credentialsapiconfig'),(1471,'Can delete credentials api config',367,'delete_credentialsapiconfig'),(1472,'Can view credentials api config',367,'view_credentialsapiconfig'),(1473,'Can add notify_credentials argument',368,'add_notifycredentialsconfig'),(1474,'Can change notify_credentials argument',368,'change_notifycredentialsconfig'),(1475,'Can delete notify_credentials argument',368,'delete_notifycredentialsconfig'),(1476,'Can view notify_credentials argument',368,'view_notifycredentialsconfig'),(1477,'Can add historical discussions configuration',369,'add_historicaldiscussionsconfiguration'),(1478,'Can change historical discussions configuration',369,'change_historicaldiscussionsconfiguration'),(1479,'Can delete historical discussions configuration',369,'delete_historicaldiscussionsconfiguration'),(1480,'Can view historical discussions configuration',369,'view_historicaldiscussionsconfiguration'),(1481,'Can add discussions configuration',370,'add_discussionsconfiguration'),(1482,'Can change discussions configuration',370,'change_discussionsconfiguration'),(1483,'Can delete discussions configuration',370,'delete_discussionsconfiguration'),(1484,'Can view discussions configuration',370,'view_discussionsconfiguration'),(1485,'Can add provider filter',371,'add_providerfilter'),(1486,'Can change provider filter',371,'change_providerfilter'),(1487,'Can delete provider filter',371,'delete_providerfilter'),(1488,'Can view provider filter',371,'view_providerfilter'),(1489,'Can add persistent subsection grade',372,'add_persistentsubsectiongrade'),(1490,'Can change persistent subsection grade',372,'change_persistentsubsectiongrade'),(1491,'Can delete persistent subsection grade',372,'delete_persistentsubsectiongrade'),(1492,'Can view persistent subsection grade',372,'view_persistentsubsectiongrade'),(1493,'Can add visible blocks',373,'add_visibleblocks'),(1494,'Can change visible blocks',373,'change_visibleblocks'),(1495,'Can delete visible blocks',373,'delete_visibleblocks'),(1496,'Can view visible blocks',373,'view_visibleblocks'),(1497,'Can add course persistent grades flag',374,'add_coursepersistentgradesflag'),(1498,'Can change course persistent grades flag',374,'change_coursepersistentgradesflag'),(1499,'Can delete course persistent grades flag',374,'delete_coursepersistentgradesflag'),(1500,'Can view course persistent grades flag',374,'view_coursepersistentgradesflag'),(1501,'Can add persistent grades enabled flag',375,'add_persistentgradesenabledflag'),(1502,'Can change persistent grades enabled flag',375,'change_persistentgradesenabledflag'),(1503,'Can delete persistent grades enabled flag',375,'delete_persistentgradesenabledflag'),(1504,'Can view persistent grades enabled flag',375,'view_persistentgradesenabledflag'),(1505,'Can add persistent course grade',376,'add_persistentcoursegrade'),(1506,'Can change persistent course grade',376,'change_persistentcoursegrade'),(1507,'Can delete persistent course grade',376,'delete_persistentcoursegrade'),(1508,'Can view persistent course grade',376,'view_persistentcoursegrade'),(1509,'Can add compute grades setting',377,'add_computegradessetting'),(1510,'Can change compute grades setting',377,'change_computegradessetting'),(1511,'Can delete compute grades setting',377,'delete_computegradessetting'),(1512,'Can view compute grades setting',377,'view_computegradessetting'),(1513,'Can add persistent subsection grade override',378,'add_persistentsubsectiongradeoverride'),(1514,'Can change persistent subsection grade override',378,'change_persistentsubsectiongradeoverride'),(1515,'Can delete persistent subsection grade override',378,'delete_persistentsubsectiongradeoverride'),(1516,'Can view persistent subsection grade override',378,'view_persistentsubsectiongradeoverride'),(1517,'Can add historical persistent subsection grade override',379,'add_historicalpersistentsubsectiongradeoverride'),(1518,'Can change historical persistent subsection grade override',379,'change_historicalpersistentsubsectiongradeoverride'),(1519,'Can delete historical persistent subsection grade override',379,'delete_historicalpersistentsubsectiongradeoverride'),(1520,'Can view historical persistent subsection grade override',379,'view_historicalpersistentsubsectiongradeoverride'),(1521,'Can add historical program enrollment',380,'add_historicalprogramenrollment'),(1522,'Can change historical program enrollment',380,'change_historicalprogramenrollment'),(1523,'Can delete historical program enrollment',380,'delete_historicalprogramenrollment'),(1524,'Can view historical program enrollment',380,'view_historicalprogramenrollment'),(1525,'Can add program enrollment',381,'add_programenrollment'),(1526,'Can change program enrollment',381,'change_programenrollment'),(1527,'Can delete program enrollment',381,'delete_programenrollment'),(1528,'Can view program enrollment',381,'view_programenrollment'),(1529,'Can add historical program course enrollment',382,'add_historicalprogramcourseenrollment'),(1530,'Can change historical program course enrollment',382,'change_historicalprogramcourseenrollment'),(1531,'Can delete historical program course enrollment',382,'delete_historicalprogramcourseenrollment'),(1532,'Can view historical program course enrollment',382,'view_historicalprogramcourseenrollment'),(1533,'Can add program course enrollment',383,'add_programcourseenrollment'),(1534,'Can change program course enrollment',383,'change_programcourseenrollment'),(1535,'Can delete program course enrollment',383,'delete_programcourseenrollment'),(1536,'Can view program course enrollment',383,'view_programcourseenrollment'),(1537,'Can add course access role assignment',384,'add_courseaccessroleassignment'),(1538,'Can change course access role assignment',384,'change_courseaccessroleassignment'),(1539,'Can delete course access role assignment',384,'delete_courseaccessroleassignment'),(1540,'Can view course access role assignment',384,'view_courseaccessroleassignment'),(1541,'Can add site theme',385,'add_sitetheme'),(1542,'Can change site theme',385,'change_sitetheme'),(1543,'Can delete site theme',385,'delete_sitetheme'),(1544,'Can view site theme',385,'view_sitetheme'),(1545,'Can add csv operation',386,'add_csvoperation'),(1546,'Can change csv operation',386,'change_csvoperation'),(1547,'Can delete csv operation',386,'delete_csvoperation'),(1548,'Can view csv operation',386,'view_csvoperation'),(1549,'Can add lti configuration',387,'add_lticonfiguration'),(1550,'Can change lti configuration',387,'change_lticonfiguration'),(1551,'Can delete lti configuration',387,'delete_lticonfiguration'),(1552,'Can view lti configuration',387,'view_lticonfiguration'),(1553,'Can add lti ags line item',388,'add_ltiagslineitem'),(1554,'Can change lti ags line item',388,'change_ltiagslineitem'),(1555,'Can delete lti ags line item',388,'delete_ltiagslineitem'),(1556,'Can view lti ags line item',388,'view_ltiagslineitem'),(1557,'Can add lti ags score',389,'add_ltiagsscore'),(1558,'Can change lti ags score',389,'change_ltiagsscore'),(1559,'Can delete lti ags score',389,'delete_ltiagsscore'),(1560,'Can view lti ags score',389,'view_ltiagsscore'),(1561,'Can add lti dl content item',390,'add_ltidlcontentitem'),(1562,'Can change lti dl content item',390,'change_ltidlcontentitem'),(1563,'Can delete lti dl content item',390,'delete_ltidlcontentitem'),(1564,'Can view lti dl content item',390,'view_ltidlcontentitem'),(1565,'Can add content date',391,'add_contentdate'),(1566,'Can change content date',391,'change_contentdate'),(1567,'Can delete content date',391,'delete_contentdate'),(1568,'Can view content date',391,'view_contentdate'),(1569,'Can add date policy',392,'add_datepolicy'),(1570,'Can change date policy',392,'change_datepolicy'),(1571,'Can delete date policy',392,'delete_datepolicy'),(1572,'Can view date policy',392,'view_datepolicy'),(1573,'Can add user date',393,'add_userdate'),(1574,'Can change user date',393,'change_userdate'),(1575,'Can delete user date',393,'delete_userdate'),(1576,'Can view user date',393,'view_userdate'),(1577,'Can add proctored exam',394,'add_proctoredexam'),(1578,'Can change proctored exam',394,'change_proctoredexam'),(1579,'Can delete proctored exam',394,'delete_proctoredexam'),(1580,'Can view proctored exam',394,'view_proctoredexam'),(1581,'Can add Proctored exam review policy',395,'add_proctoredexamreviewpolicy'),(1582,'Can change Proctored exam review policy',395,'change_proctoredexamreviewpolicy'),(1583,'Can delete Proctored exam review policy',395,'delete_proctoredexamreviewpolicy'),(1584,'Can view Proctored exam review policy',395,'view_proctoredexamreviewpolicy'),(1585,'Can add proctored exam review policy history',396,'add_proctoredexamreviewpolicyhistory'),(1586,'Can change proctored exam review policy history',396,'change_proctoredexamreviewpolicyhistory'),(1587,'Can delete proctored exam review policy history',396,'delete_proctoredexamreviewpolicyhistory'),(1588,'Can view proctored exam review policy history',396,'view_proctoredexamreviewpolicyhistory'),(1589,'Can add proctored exam software secure comment',397,'add_proctoredexamsoftwaresecurecomment'),(1590,'Can change proctored exam software secure comment',397,'change_proctoredexamsoftwaresecurecomment'),(1591,'Can delete proctored exam software secure comment',397,'delete_proctoredexamsoftwaresecurecomment'),(1592,'Can view proctored exam software secure comment',397,'view_proctoredexamsoftwaresecurecomment'),(1593,'Can add Proctored exam software secure review',398,'add_proctoredexamsoftwaresecurereview'),(1594,'Can change Proctored exam software secure review',398,'change_proctoredexamsoftwaresecurereview'),(1595,'Can delete Proctored exam software secure review',398,'delete_proctoredexamsoftwaresecurereview'),(1596,'Can view Proctored exam software secure review',398,'view_proctoredexamsoftwaresecurereview'),(1597,'Can add Proctored exam review archive',399,'add_proctoredexamsoftwaresecurereviewhistory'),(1598,'Can change Proctored exam review archive',399,'change_proctoredexamsoftwaresecurereviewhistory'),(1599,'Can delete Proctored exam review archive',399,'delete_proctoredexamsoftwaresecurereviewhistory'),(1600,'Can view Proctored exam review archive',399,'view_proctoredexamsoftwaresecurereviewhistory'),(1601,'Can add proctored allowance',400,'add_proctoredexamstudentallowance'),(1602,'Can change proctored allowance',400,'change_proctoredexamstudentallowance'),(1603,'Can delete proctored allowance',400,'delete_proctoredexamstudentallowance'),(1604,'Can view proctored allowance',400,'view_proctoredexamstudentallowance'),(1605,'Can add proctored allowance history',401,'add_proctoredexamstudentallowancehistory'),(1606,'Can change proctored allowance history',401,'change_proctoredexamstudentallowancehistory'),(1607,'Can delete proctored allowance history',401,'delete_proctoredexamstudentallowancehistory'),(1608,'Can view proctored allowance history',401,'view_proctoredexamstudentallowancehistory'),(1609,'Can add proctored exam attempt',402,'add_proctoredexamstudentattempt'),(1610,'Can change proctored exam attempt',402,'change_proctoredexamstudentattempt'),(1611,'Can delete proctored exam attempt',402,'delete_proctoredexamstudentattempt'),(1612,'Can view proctored exam attempt',402,'view_proctoredexamstudentattempt'),(1613,'Can add proctored exam attempt history',403,'add_proctoredexamstudentattempthistory'),(1614,'Can change proctored exam attempt history',403,'change_proctoredexamstudentattempthistory'),(1615,'Can delete proctored exam attempt history',403,'delete_proctoredexamstudentattempthistory'),(1616,'Can view proctored exam attempt history',403,'view_proctoredexamstudentattempthistory'),(1617,'Can add block completion',404,'add_blockcompletion'),(1618,'Can change block completion',404,'change_blockcompletion'),(1619,'Can delete block completion',404,'delete_blockcompletion'),(1620,'Can view block completion',404,'view_blockcompletion'),(1621,'Can add score overrider',405,'add_scoreoverrider'),(1622,'Can change score overrider',405,'change_scoreoverrider'),(1623,'Can delete score overrider',405,'delete_scoreoverrider'),(1624,'Can view score overrider',405,'view_scoreoverrider'),(1625,'Can add video upload config',406,'add_videouploadconfig'),(1626,'Can change video upload config',406,'change_videouploadconfig'),(1627,'Can delete video upload config',406,'delete_videouploadconfig'),(1628,'Can view video upload config',406,'view_videouploadconfig'),(1629,'Can add course creator',407,'add_coursecreator'),(1630,'Can change course creator',407,'change_coursecreator'),(1631,'Can delete course creator',407,'delete_coursecreator'),(1632,'Can view course creator',407,'view_coursecreator'),(1633,'Can add studio config',408,'add_studioconfig'),(1634,'Can change studio config',408,'change_studioconfig'),(1635,'Can delete studio config',408,'delete_studioconfig'),(1636,'Can view studio config',408,'view_studioconfig'),(1637,'Can add course edit lti fields enabled flag',409,'add_courseeditltifieldsenabledflag'),(1638,'Can change course edit lti fields enabled flag',409,'change_courseeditltifieldsenabledflag'),(1639,'Can delete course edit lti fields enabled flag',409,'delete_courseeditltifieldsenabledflag'),(1640,'Can view course edit lti fields enabled flag',409,'view_courseeditltifieldsenabledflag'),(1641,'Can add available tag value',410,'add_tagavailablevalues'),(1642,'Can change available tag value',410,'change_tagavailablevalues'),(1643,'Can delete available tag value',410,'delete_tagavailablevalues'),(1644,'Can view available tag value',410,'view_tagavailablevalues'),(1645,'Can add tag category',411,'add_tagcategories'),(1646,'Can change tag category',411,'change_tagcategories'),(1647,'Can delete tag category',411,'delete_tagcategories'),(1648,'Can view tag category',411,'view_tagcategories');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_registration`
--

DROP TABLE IF EXISTS `auth_registration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_registration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `activation_key` varchar(32) NOT NULL,
  `user_id` int(11) NOT NULL,
  `activation_timestamp` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `activation_key` (`activation_key`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `auth_registration_user_id_f99bc297_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_registration`
--

LOCK TABLES `auth_registration` WRITE;
/*!40000 ALTER TABLE `auth_registration` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_registration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'!OpjJAAfHBHzEEBmymiVnYQjd8vyzDGw18cIUUlBu',NULL,0,'ecommerce_worker','','','ecommerce_worker@example.com',0,1,'2021-03-24 08:05:33.955608'),(2,'!9Gr2JXVI3vsth1GSOvtYk8drZKIzL6RluvVSiWK9',NULL,0,'login_service_user','','','login_service_user@fake.email',0,1,'2021-03-24 08:07:14.548213');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_userprofile`
--

DROP TABLE IF EXISTS `auth_userprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_userprofile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `meta` longtext NOT NULL,
  `courseware` varchar(255) NOT NULL,
  `language` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `year_of_birth` int(11) DEFAULT NULL,
  `gender` varchar(6) DEFAULT NULL,
  `level_of_education` varchar(6) DEFAULT NULL,
  `mailing_address` longtext,
  `city` longtext,
  `country` varchar(2) DEFAULT NULL,
  `goals` longtext,
  `allow_certificate` tinyint(1) NOT NULL,
  `bio` varchar(3000) DEFAULT NULL,
  `profile_image_uploaded_at` datetime(6) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `phone_number` varchar(50) DEFAULT NULL,
  `state` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `auth_userprofile_name_50909f10` (`name`),
  KEY `auth_userprofile_language_8948d814` (`language`),
  KEY `auth_userprofile_location_ca92e4f6` (`location`),
  KEY `auth_userprofile_year_of_birth_6559b9a5` (`year_of_birth`),
  KEY `auth_userprofile_gender_44a122fb` (`gender`),
  KEY `auth_userprofile_level_of_education_93927e04` (`level_of_education`),
  CONSTRAINT `auth_userprofile_user_id_62634b27_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_userprofile`
--

LOCK TABLES `auth_userprofile` WRITE;
/*!40000 ALTER TABLE `auth_userprofile` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_userprofile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `badges_badgeassertion`
--

DROP TABLE IF EXISTS `badges_badgeassertion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `badges_badgeassertion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data` longtext NOT NULL,
  `backend` varchar(50) NOT NULL,
  `image_url` varchar(200) NOT NULL,
  `assertion_url` varchar(200) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `created` datetime(6) NOT NULL,
  `badge_class_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `badges_badgeassertion_created_d098832e` (`created`),
  KEY `badges_badgeassertio_badge_class_id_902ac30e_fk_badges_ba` (`badge_class_id`),
  KEY `badges_badgeassertion_user_id_13665630_fk_auth_user_id` (`user_id`),
  CONSTRAINT `badges_badgeassertio_badge_class_id_902ac30e_fk_badges_ba` FOREIGN KEY (`badge_class_id`) REFERENCES `badges_badgeclass` (`id`),
  CONSTRAINT `badges_badgeassertion_user_id_13665630_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `badges_badgeassertion`
--

LOCK TABLES `badges_badgeassertion` WRITE;
/*!40000 ALTER TABLE `badges_badgeassertion` DISABLE KEYS */;
/*!40000 ALTER TABLE `badges_badgeassertion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `badges_badgeclass`
--

DROP TABLE IF EXISTS `badges_badgeclass`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `badges_badgeclass` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `slug` varchar(255) NOT NULL,
  `issuing_component` varchar(50) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `criteria` longtext NOT NULL,
  `mode` varchar(100) NOT NULL,
  `image` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `badges_badgeclass_slug_issuing_component_course_id_92cd3912_uniq` (`slug`,`issuing_component`,`course_id`),
  KEY `badges_badgeclass_slug_5f420f6f` (`slug`),
  KEY `badges_badgeclass_issuing_component_85b6d93d` (`issuing_component`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `badges_badgeclass`
--

LOCK TABLES `badges_badgeclass` WRITE;
/*!40000 ALTER TABLE `badges_badgeclass` DISABLE KEYS */;
/*!40000 ALTER TABLE `badges_badgeclass` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `badges_coursecompleteimageconfiguration`
--

DROP TABLE IF EXISTS `badges_coursecompleteimageconfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `badges_coursecompleteimageconfiguration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mode` varchar(125) NOT NULL,
  `icon` varchar(100) NOT NULL,
  `default` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mode` (`mode`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `badges_coursecompleteimageconfiguration`
--

LOCK TABLES `badges_coursecompleteimageconfiguration` WRITE;
/*!40000 ALTER TABLE `badges_coursecompleteimageconfiguration` DISABLE KEYS */;
INSERT INTO `badges_coursecompleteimageconfiguration` VALUES (1,'honor','badges/badges/honor.png',0),(2,'verified','badges/badges/verified.png',0),(3,'professional','badges/badges/professional.png',0);
/*!40000 ALTER TABLE `badges_coursecompleteimageconfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `badges_courseeventbadgesconfiguration`
--

DROP TABLE IF EXISTS `badges_courseeventbadgesconfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `badges_courseeventbadgesconfiguration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `courses_completed` longtext NOT NULL,
  `courses_enrolled` longtext NOT NULL,
  `course_groups` longtext NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `badges_courseeventba_changed_by_id_db04ed01_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `badges_courseeventba_changed_by_id_db04ed01_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `badges_courseeventbadgesconfiguration`
--

LOCK TABLES `badges_courseeventbadgesconfiguration` WRITE;
/*!40000 ALTER TABLE `badges_courseeventbadgesconfiguration` DISABLE KEYS */;
/*!40000 ALTER TABLE `badges_courseeventbadgesconfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blackboard_blackboardenterprisecustomerconfiguration`
--

DROP TABLE IF EXISTS `blackboard_blackboardenterprisecustomerconfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blackboard_blackboardenterprisecustomerconfiguration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `transmission_chunk_size` int(11) NOT NULL,
  `channel_worker_username` varchar(255) DEFAULT NULL,
  `catalogs_to_transmit` longtext,
  `client_id` varchar(255) DEFAULT NULL,
  `client_secret` varchar(255) DEFAULT NULL,
  `blackboard_base_url` varchar(255) DEFAULT NULL,
  `refresh_token` varchar(255) NOT NULL,
  `enterprise_customer_id` char(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `enterprise_customer_id` (`enterprise_customer_id`),
  CONSTRAINT `blackboard_blackboar_enterprise_customer__39f883b0_fk_enterpris` FOREIGN KEY (`enterprise_customer_id`) REFERENCES `enterprise_enterprisecustomer` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blackboard_blackboardenterprisecustomerconfiguration`
--

LOCK TABLES `blackboard_blackboardenterprisecustomerconfiguration` WRITE;
/*!40000 ALTER TABLE `blackboard_blackboardenterprisecustomerconfiguration` DISABLE KEYS */;
/*!40000 ALTER TABLE `blackboard_blackboardenterprisecustomerconfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blackboard_blackboardlearnerassessmentdatatransmissionaudit`
--

DROP TABLE IF EXISTS `blackboard_blackboardlearnerassessmentdatatransmissionaudit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blackboard_blackboardlearnerassessmentdatatransmissionaudit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `blackboard_user_email` varchar(255) NOT NULL,
  `enterprise_course_enrollment_id` int(10) unsigned NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `subsection_id` varchar(255) NOT NULL,
  `grade_point_score` double NOT NULL,
  `grade_points_possible` double NOT NULL,
  `grade` double NOT NULL,
  `subsection_name` varchar(255) NOT NULL,
  `status` varchar(100) NOT NULL,
  `error_message` longtext NOT NULL,
  `created` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `blackboard_blackboardlearne_enterprise_course_enrollmen_4d99c86b` (`enterprise_course_enrollment_id`),
  KEY `blackboard_blackboardlearne_subsection_id_6ddb999b` (`subsection_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blackboard_blackboardlearnerassessmentdatatransmissionaudit`
--

LOCK TABLES `blackboard_blackboardlearnerassessmentdatatransmissionaudit` WRITE;
/*!40000 ALTER TABLE `blackboard_blackboardlearnerassessmentdatatransmissionaudit` DISABLE KEYS */;
/*!40000 ALTER TABLE `blackboard_blackboardlearnerassessmentdatatransmissionaudit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blackboard_blackboardlearnerdatatransmissionaudit`
--

DROP TABLE IF EXISTS `blackboard_blackboardlearnerdatatransmissionaudit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blackboard_blackboardlearnerdatatransmissionaudit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `blackboard_user_email` varchar(255) NOT NULL,
  `completed_timestamp` varchar(10) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `course_completed` tinyint(1) NOT NULL,
  `enterprise_course_enrollment_id` int(10) unsigned NOT NULL,
  `grade` decimal(3,2) DEFAULT NULL,
  `total_hours` double DEFAULT NULL,
  `created` datetime(6) NOT NULL,
  `error_message` longtext NOT NULL,
  `status` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `blackboard_blackboardlearne_enterprise_course_enrollmen_941ea543` (`enterprise_course_enrollment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blackboard_blackboardlearnerdatatransmissionaudit`
--

LOCK TABLES `blackboard_blackboardlearnerdatatransmissionaudit` WRITE;
/*!40000 ALTER TABLE `blackboard_blackboardlearnerdatatransmissionaudit` DISABLE KEYS */;
/*!40000 ALTER TABLE `blackboard_blackboardlearnerdatatransmissionaudit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blackboard_historicalblackboardenterprisecustomerconfiguration`
--

DROP TABLE IF EXISTS `blackboard_historicalblackboardenterprisecustomerconfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blackboard_historicalblackboardenterprisecustomerconfiguration` (
  `id` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `transmission_chunk_size` int(11) NOT NULL,
  `channel_worker_username` varchar(255) DEFAULT NULL,
  `catalogs_to_transmit` longtext,
  `client_id` varchar(255) DEFAULT NULL,
  `client_secret` varchar(255) DEFAULT NULL,
  `blackboard_base_url` varchar(255) DEFAULT NULL,
  `refresh_token` varchar(255) NOT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `enterprise_customer_id` char(32) DEFAULT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `blackboard_historica_history_user_id_099f295b_fk_auth_user` (`history_user_id`),
  KEY `blackboard_historicalblackb_id_7675c06f` (`id`),
  KEY `blackboard_historicalblackb_enterprise_customer_id_b9053e9a` (`enterprise_customer_id`),
  CONSTRAINT `blackboard_historica_history_user_id_099f295b_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blackboard_historicalblackboardenterprisecustomerconfiguration`
--

LOCK TABLES `blackboard_historicalblackboardenterprisecustomerconfiguration` WRITE;
/*!40000 ALTER TABLE `blackboard_historicalblackboardenterprisecustomerconfiguration` DISABLE KEYS */;
/*!40000 ALTER TABLE `blackboard_historicalblackboardenterprisecustomerconfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `block_structure`
--

DROP TABLE IF EXISTS `block_structure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `block_structure` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `data_usage_key` varchar(255) NOT NULL,
  `data_version` varchar(255) DEFAULT NULL,
  `data_edit_timestamp` datetime(6) DEFAULT NULL,
  `transformers_schema_version` varchar(255) NOT NULL,
  `block_structure_schema_version` varchar(255) NOT NULL,
  `data` varchar(500) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `data_usage_key` (`data_usage_key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `block_structure`
--

LOCK TABLES `block_structure` WRITE;
/*!40000 ALTER TABLE `block_structure` DISABLE KEYS */;
/*!40000 ALTER TABLE `block_structure` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `block_structure_config`
--

DROP TABLE IF EXISTS `block_structure_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `block_structure_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `num_versions_to_keep` int(11) DEFAULT NULL,
  `cache_timeout_in_seconds` int(11) DEFAULT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `block_structure_config_changed_by_id_45af0b10_fk_auth_user_id` (`changed_by_id`),
  CONSTRAINT `block_structure_config_changed_by_id_45af0b10_fk_auth_user_id` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `block_structure_config`
--

LOCK TABLES `block_structure_config` WRITE;
/*!40000 ALTER TABLE `block_structure_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `block_structure_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookmarks_bookmark`
--

DROP TABLE IF EXISTS `bookmarks_bookmark`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bookmarks_bookmark` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `course_key` varchar(255) NOT NULL,
  `usage_key` varchar(255) NOT NULL,
  `path` longtext NOT NULL,
  `user_id` int(11) NOT NULL,
  `xblock_cache_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `bookmarks_bookmark_user_id_usage_key_61eac24b_uniq` (`user_id`,`usage_key`),
  KEY `bookmarks_bookmark_course_key_46609583` (`course_key`),
  KEY `bookmarks_bookmark_usage_key_d07927c9` (`usage_key`),
  KEY `bookmarks_bookmark_xblock_cache_id_808a7639_fk_bookmarks` (`xblock_cache_id`),
  CONSTRAINT `bookmarks_bookmark_user_id_a26bf17c_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `bookmarks_bookmark_xblock_cache_id_808a7639_fk_bookmarks` FOREIGN KEY (`xblock_cache_id`) REFERENCES `bookmarks_xblockcache` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookmarks_bookmark`
--

LOCK TABLES `bookmarks_bookmark` WRITE;
/*!40000 ALTER TABLE `bookmarks_bookmark` DISABLE KEYS */;
/*!40000 ALTER TABLE `bookmarks_bookmark` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookmarks_xblockcache`
--

DROP TABLE IF EXISTS `bookmarks_xblockcache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bookmarks_xblockcache` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `course_key` varchar(255) NOT NULL,
  `usage_key` varchar(255) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  `paths` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `usage_key` (`usage_key`),
  KEY `bookmarks_xblockcache_course_key_5297fa77` (`course_key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookmarks_xblockcache`
--

LOCK TABLES `bookmarks_xblockcache` WRITE;
/*!40000 ALTER TABLE `bookmarks_xblockcache` DISABLE KEYS */;
/*!40000 ALTER TABLE `bookmarks_xblockcache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branding_brandingapiconfig`
--

DROP TABLE IF EXISTS `branding_brandingapiconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `branding_brandingapiconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `branding_brandingapi_changed_by_id_bab2730f_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `branding_brandingapi_changed_by_id_bab2730f_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branding_brandingapiconfig`
--

LOCK TABLES `branding_brandingapiconfig` WRITE;
/*!40000 ALTER TABLE `branding_brandingapiconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `branding_brandingapiconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branding_brandinginfoconfig`
--

DROP TABLE IF EXISTS `branding_brandinginfoconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `branding_brandinginfoconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `configuration` longtext NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `branding_brandinginf_changed_by_id_616dd172_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `branding_brandinginf_changed_by_id_616dd172_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branding_brandinginfoconfig`
--

LOCK TABLES `branding_brandinginfoconfig` WRITE;
/*!40000 ALTER TABLE `branding_brandinginfoconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `branding_brandinginfoconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bulk_email_bulkemailflag`
--

DROP TABLE IF EXISTS `bulk_email_bulkemailflag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bulk_email_bulkemailflag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `require_course_email_auth` tinyint(1) NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bulk_email_bulkemailflag_changed_by_id_c510754b_fk_auth_user_id` (`changed_by_id`),
  CONSTRAINT `bulk_email_bulkemailflag_changed_by_id_c510754b_fk_auth_user_id` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bulk_email_bulkemailflag`
--

LOCK TABLES `bulk_email_bulkemailflag` WRITE;
/*!40000 ALTER TABLE `bulk_email_bulkemailflag` DISABLE KEYS */;
/*!40000 ALTER TABLE `bulk_email_bulkemailflag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bulk_email_cohorttarget`
--

DROP TABLE IF EXISTS `bulk_email_cohorttarget`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bulk_email_cohorttarget` (
  `target_ptr_id` int(11) NOT NULL,
  `cohort_id` int(11) NOT NULL,
  PRIMARY KEY (`target_ptr_id`),
  KEY `bulk_email_cohorttar_cohort_id_096f39c9_fk_course_gr` (`cohort_id`),
  CONSTRAINT `bulk_email_cohorttar_cohort_id_096f39c9_fk_course_gr` FOREIGN KEY (`cohort_id`) REFERENCES `course_groups_courseusergroup` (`id`),
  CONSTRAINT `bulk_email_cohorttar_target_ptr_id_7e1a1a40_fk_bulk_emai` FOREIGN KEY (`target_ptr_id`) REFERENCES `bulk_email_target` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bulk_email_cohorttarget`
--

LOCK TABLES `bulk_email_cohorttarget` WRITE;
/*!40000 ALTER TABLE `bulk_email_cohorttarget` DISABLE KEYS */;
/*!40000 ALTER TABLE `bulk_email_cohorttarget` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bulk_email_courseauthorization`
--

DROP TABLE IF EXISTS `bulk_email_courseauthorization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bulk_email_courseauthorization` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` varchar(255) NOT NULL,
  `email_enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `course_id` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bulk_email_courseauthorization`
--

LOCK TABLES `bulk_email_courseauthorization` WRITE;
/*!40000 ALTER TABLE `bulk_email_courseauthorization` DISABLE KEYS */;
/*!40000 ALTER TABLE `bulk_email_courseauthorization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bulk_email_courseemail`
--

DROP TABLE IF EXISTS `bulk_email_courseemail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bulk_email_courseemail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `slug` varchar(128) NOT NULL,
  `subject` varchar(128) NOT NULL,
  `html_message` longtext,
  `text_message` longtext,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `to_option` varchar(64) NOT NULL,
  `template_name` varchar(255) DEFAULT NULL,
  `from_addr` varchar(255) DEFAULT NULL,
  `sender_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bulk_email_courseemail_sender_id_865f6979_fk_auth_user_id` (`sender_id`),
  KEY `bulk_email_courseemail_slug_bd25801f` (`slug`),
  KEY `bulk_email_courseemail_course_id_b7b8a9a2` (`course_id`),
  CONSTRAINT `bulk_email_courseemail_sender_id_865f6979_fk_auth_user_id` FOREIGN KEY (`sender_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bulk_email_courseemail`
--

LOCK TABLES `bulk_email_courseemail` WRITE;
/*!40000 ALTER TABLE `bulk_email_courseemail` DISABLE KEYS */;
/*!40000 ALTER TABLE `bulk_email_courseemail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bulk_email_courseemail_targets`
--

DROP TABLE IF EXISTS `bulk_email_courseemail_targets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bulk_email_courseemail_targets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `courseemail_id` int(11) NOT NULL,
  `target_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `bulk_email_courseemail_t_courseemail_id_target_id_e0440acc_uniq` (`courseemail_id`,`target_id`),
  KEY `bulk_email_courseema_target_id_52b11fa9_fk_bulk_emai` (`target_id`),
  CONSTRAINT `bulk_email_courseema_courseemail_id_83f5bdcd_fk_bulk_emai` FOREIGN KEY (`courseemail_id`) REFERENCES `bulk_email_courseemail` (`id`),
  CONSTRAINT `bulk_email_courseema_target_id_52b11fa9_fk_bulk_emai` FOREIGN KEY (`target_id`) REFERENCES `bulk_email_target` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bulk_email_courseemail_targets`
--

LOCK TABLES `bulk_email_courseemail_targets` WRITE;
/*!40000 ALTER TABLE `bulk_email_courseemail_targets` DISABLE KEYS */;
/*!40000 ALTER TABLE `bulk_email_courseemail_targets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bulk_email_courseemailtemplate`
--

DROP TABLE IF EXISTS `bulk_email_courseemailtemplate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bulk_email_courseemailtemplate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `html_template` longtext,
  `plain_template` longtext,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bulk_email_courseemailtemplate`
--

LOCK TABLES `bulk_email_courseemailtemplate` WRITE;
/*!40000 ALTER TABLE `bulk_email_courseemailtemplate` DISABLE KEYS */;
INSERT INTO `bulk_email_courseemailtemplate` VALUES (1,'<!DOCTYPE html PUBLIC \'-//W3C//DTD XHTML 1.0 Transitional//EN\' \'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\'><html xmlns:fb=\'http://www.facebook.com/2008/fbml\' xmlns:og=\'http://opengraph.org/schema/\'> <head><meta property=\'og:title\' content=\'Update from {course_title}\'/><meta property=\'fb:page_id\' content=\'43929265776\' />        <meta http-equiv=\'Content-Type\' content=\'text/html; charset=UTF-8\'>        <title>Update from {course_title}</title>                    </head>        <body leftmargin=\'0\' marginwidth=\'0\' topmargin=\'0\' marginheight=\'0\' offset=\'0\' style=\'margin: 0;padding: 0;background-color: #ffffff;\'>        <center>            <table align=\'center\' border=\'0\' cellpadding=\'0\' cellspacing=\'0\' height=\'100%\' width=\'100%\' id=\'bodyTable\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;margin: 0;padding: 0;background-color: #ffffff;height: 100% !important;width: 100% !important;\'>                <tr>                   <td align=\'center\' valign=\'top\' id=\'bodyCell\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;margin: 0;padding: 0;border-top: 0;height: 100% !important;width: 100% !important;\'>                        <!-- BEGIN TEMPLATE // -->                        <table border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'100%\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                            <tr>                                <td align=\'center\' valign=\'top\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                                    <!-- BEGIN PREHEADER // -->                                    <table border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'100%\' id=\'templatePreheader\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;background-color: #fcfcfc;border-top: 0;border-bottom: 0;\'>                                        <tr>                                        <td align=\'center\' valign=\'top\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                                                <table border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'600\' class=\'templateContainer\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                                                    <tr>                                                        <td valign=\'top\' class=\'preheaderContainer\' style=\'padding-top: 9px;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'><table border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'100%\' class=\'mcnTextBlock\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>    <tbody class=\'mcnTextBlockOuter\'>        <tr>            <td valign=\'top\' class=\'mcnTextBlockInner\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                                <table align=\'left\' border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'366\' class=\'mcnTextContentContainer\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                    <tbody><tr>                                                <td valign=\'top\' class=\'mcnTextContent\' style=\'padding-top: 9px;padding-left: 18px;padding-bottom: 9px;padding-right: 0;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;color: #606060;font-family: Helvetica;font-size: 11px;line-height: 125%;text-align: left;\'>                                                    <br>                        </td>                    </tr>                </tbody></table>                            </td>        </tr>    </tbody></table></td>                                                    </tr>                                                </table>                                            </td>                                                                                    </tr>                                    </table>                                    <!-- // END PREHEADER -->                                </td>                            </tr>                            <tr>                                <td align=\'center\' valign=\'top\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                                    <!-- BEGIN HEADER // -->                                    <table border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'100%\' id=\'templateHeader\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;background-color: #fcfcfc;border-top: 0;border-bottom: 0;\'>                                        <tr>                                            <td align=\'center\' valign=\'top\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                                                <table border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'600\' class=\'templateContainer\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                                                    <tr>                                                        <td valign=\'top\' class=\'headerContainer\' style=\'padding-top: 10px;padding-right: 18px;padding-bottom: 10px;padding-left: 18px;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'><table border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'100%\' class=\'mcnImageBlock\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>    <tbody class=\'mcnImageBlockOuter\'>            <tr>                <td valign=\'top\' style=\'padding: 9px;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\' class=\'mcnImageBlockInner\'>                    <table align=\'left\' width=\'100%\' border=\'0\' cellpadding=\'0\' cellspacing=\'0\' class=\'mcnImageContentContainer\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                        <tbody><tr>                            <td class=\'mcnImageContent\' valign=\'top\' style=\'padding-right: 9px;padding-left: 9px;padding-top: 0;padding-bottom: 0;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                                                                    <a href=\'http://edx.org\' title=\'\' class=\'\' target=\'_self\' style=\'word-wrap: break-word !important;\'>                                        <img align=\'left\' alt=\'edX\' src=\'http://courses.edx.org/static/images/bulk_email/edXHeaderImage.jpg\' width=\'564.0000152587891\' style=\'max-width: 600px;padding-bottom: 0;display: inline !important;vertical-align: bottom;border: 0;line-height: 100%;outline: none;text-decoration: none;height: auto !important;\' class=\'mcnImage\'>                                    </a>                                                            </td>                        </tr>                    </tbody></table>                </td>            </tr>    </tbody></table><table border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'100%\' class=\'mcnTextBlock\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>    <tbody class=\'mcnTextBlockOuter\'>        <tr>            <td valign=\'top\' class=\'mcnTextBlockInner\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                                <table align=\'left\' border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'599\' class=\'mcnTextContentContainer\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                    <tbody><tr>                                                <td valign=\'top\' class=\'mcnTextContent\' style=\'padding-top: 9px;padding-right: 18px;padding-bottom: 9px;padding-left: 18px;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;color: #606060;font-family: Helvetica;font-size: 15px;line-height: 150%;text-align: left;\'>                                                    <div style=\'text-align: right;\'><span style=\'font-size:11px;\'><span style=\'color:#00a0e3;\'>Connect with edX:</span></span> &nbsp;<a href=\'http://facebook.com/edxonline\' target=\'_blank\' style=\'color: #6DC6DD;font-weight: normal;text-decoration: underline;word-wrap: break-word !important;\'><img align=\'none\' height=\'16\' src=\'http://courses.edx.org/static/images/bulk_email/FacebookIcon.png\' style=\'width: 16px;height: 16px;border: 0;line-height: 100%;outline: none;text-decoration: none;\' width=\'16\'></a>&nbsp;&nbsp;<a href=\'http://twitter.com/edxonline\' target=\'_blank\' style=\'color: #6DC6DD;font-weight: normal;text-decoration: underline;word-wrap: break-word !important;\'><img align=\'none\' height=\'16\' src=\'http://courses.edx.org/static/images/bulk_email/TwitterIcon.png\' style=\'width: 16px;height: 16px;border: 0;line-height: 100%;outline: none;text-decoration: none;\' width=\'16\'></a>&nbsp;&nbsp;<a href=\'https://plus.google.com/108235383044095082735\' target=\'_blank\' style=\'color: #6DC6DD;font-weight: normal;text-decoration: underline;word-wrap: break-word !important;\'><img align=\'none\' height=\'16\' src=\'http://courses.edx.org/static/images/bulk_email/GooglePlusIcon.png\' style=\'width: 16px;height: 16px;border: 0;line-height: 100%;outline: none;text-decoration: none;\' width=\'16\'></a>&nbsp;&nbsp;<a href=\'http://www.meetup.com/edX-Communities/\' target=\'_blank\' style=\'color: #6DC6DD;font-weight: normal;text-decoration: underline;word-wrap: break-word !important;\'><img align=\'none\' height=\'16\' src=\'http://courses.edx.org/static/images/bulk_email/MeetupIcon.png\' style=\'width: 16px;height: 16px;border: 0;line-height: 100%;outline: none;text-decoration: none;\' width=\'16\'></a></div>                        </td>                    </tr>                </tbody></table>                            </td>        </tr>    </tbody></table></td>                                                    </tr>                                                </table>                                            </td>                                        </tr>                                    </table>                                    <!-- // END HEADER -->                                </td>                            </tr>                            <tr>                                <td align=\'center\' valign=\'top\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                                    <!-- BEGIN BODY // -->                                    <table border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'100%\' id=\'templateBody\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;background-color: #fcfcfc;border-top: 0;border-bottom: 0;\'>                                        <tr>                                            <td align=\'center\' valign=\'top\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                                                <table border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'600\' class=\'templateContainer\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                                                    <tr>                                                        <td valign=\'top\' class=\'bodyContainer\' style=\'padding-top: 10px;padding-right: 18px;padding-bottom: 10px;padding-left: 18px;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'><table border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'100%\' class=\'mcnCaptionBlock\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>    <tbody class=\'mcnCaptionBlockOuter\'>        <tr>            <td class=\'mcnCaptionBlockInner\' valign=\'top\' style=\'padding: 9px;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                <table border=\'0\' cellpadding=\'0\' cellspacing=\'0\' class=\'mcnCaptionLeftContentOuter\' width=\'100%\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>    <tbody><tr>        <td valign=\'top\' class=\'mcnCaptionLeftContentInner\' style=\'padding: 0 9px;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>            <table align=\'right\' border=\'0\' cellpadding=\'0\' cellspacing=\'0\' class=\'mcnCaptionLeftImageContentContainer\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                <tbody><tr>                    <td class=\'mcnCaptionLeftImageContent\' valign=\'top\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                                                                    <img alt=\'\' src=\'{course_image_url}\' width=\'176\' style=\'max-width: 180px;border: 0;line-height: 100%;outline: none;text-decoration: none;vertical-align: bottom;height: auto !important;\' class=\'mcnImage\'>                                                                </td>                </tr>            </tbody></table>            <table class=\'mcnCaptionLeftTextContentContainer\' align=\'left\' border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'352\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                <tbody><tr>                    <td valign=\'top\' class=\'mcnTextContent\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;color: #606060;font-family: Helvetica;font-size: 14px;line-height: 150%;text-align: left;\'>                        <h3 class=\'null\' style=\'display: block;font-family: Helvetica;font-size: 18px;font-style: normal;font-weight: bold;line-height: 125%;letter-spacing: -.5px;margin: 0;text-align: left;color: #606060 !important;\'><strong style=\'font-size: 22px;\'>{course_title}</strong><br></h3><br>                    </td>                </tr>            </tbody></table>        </td>    </tr></tbody></table>            </td>        </tr>    </tbody></table><table border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'100%\' class=\'mcnTextBlock\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>    <tbody class=\'mcnTextBlockOuter\'>        <tr>            <td valign=\'top\' class=\'mcnTextBlockInner\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                                <table align=\'left\' border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'600\' class=\'mcnTextContentContainer\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                    <tbody><tr>                                                <td valign=\'top\' class=\'mcnTextContent\' style=\'padding-top: 9px;padding-right: 18px;padding-bottom: 9px;padding-left: 18px;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;color: #606060;font-family: Helvetica;font-size: 14px;line-height: 150%;text-align: left;\'>                        {{message_body}}                        </td>                    </tr>                </tbody></table>                            </td>        </tr>    </tbody></table><table border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'100%\' class=\'mcnDividerBlock\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>    <tbody class=\'mcnDividerBlockOuter\'>        <tr>            <td class=\'mcnDividerBlockInner\' style=\'padding: 18px 18px 3px;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                <table class=\'mcnDividerContent\' border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'100%\' style=\'border-top-width: 1px;border-top-style: solid;border-top-color: #666666;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                    <tbody><tr>                        <td style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                            <span></span>                        </td>                    </tr>                </tbody></table>            </td>        </tr>    </tbody></table><table border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'100%\' class=\'mcnTextBlock\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>    <tbody class=\'mcnTextBlockOuter\'>        <tr>            <td valign=\'top\' class=\'mcnTextBlockInner\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                                <table align=\'left\' border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'600\' class=\'mcnTextContentContainer\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                    <tbody><tr>                                                <td valign=\'top\' class=\'mcnTextContent\' style=\'padding-top: 9px;padding-right: 18px;padding-bottom: 9px;padding-left: 18px;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;color: #606060;font-family: Helvetica;font-size: 14px;line-height: 150%;text-align: left;\'>                                                    <div style=\'text-align: right;\'><a href=\'http://facebook.com/edxonline\' target=\'_blank\' style=\'color: #2f73bc;font-weight: normal;text-decoration: underline;word-wrap: break-word !important;\'><img align=\'none\' height=\'16\' src=\'http://courses.edx.org/static/images/bulk_email/FacebookIcon.png\' style=\'width: 16px;height: 16px;border: 0;line-height: 100%;outline: none;text-decoration: none;\' width=\'16\'></a>&nbsp;&nbsp;<a href=\'http://twitter.com/edxonline\' target=\'_blank\' style=\'color: #2f73bc;font-weight: normal;text-decoration: underline;word-wrap: break-word !important;\'><img align=\'none\' height=\'16\' src=\'http://courses.edx.org/static/images/bulk_email/TwitterIcon.png\' style=\'width: 16px;height: 16px;border: 0;line-height: 100%;outline: none;text-decoration: none;\' width=\'16\'></a>&nbsp;&nbsp;<a href=\'https://plus.google.com/108235383044095082735\' target=\'_blank\' style=\'color: #2f73bc;font-weight: normal;text-decoration: underline;word-wrap: break-word !important;\'><img align=\'none\' height=\'16\' src=\'http://courses.edx.org/static/images/bulk_email/GooglePlusIcon.png\' style=\'width: 16px;height: 16px;border: 0;line-height: 100%;outline: none;text-decoration: none;\' width=\'16\'></a>&nbsp; &nbsp;<a href=\'http://www.meetup.com/edX-Communities/\' target=\'_blank\' style=\'color: #2f73bc;font-weight: normal;text-decoration: underline;word-wrap: break-word !important;\'><img align=\'none\' height=\'16\' src=\'http://courses.edx.org/static/images/bulk_email/MeetupIcon.png\' style=\'width: 16px;height: 16px;border: 0;line-height: 100%;outline: none;text-decoration: none;\' width=\'16\'></a></div>                        </td>                    </tr>                </tbody></table>                            </td>        </tr>    </tbody></table></td>                                                    </tr>                                                </table>                                            </td>                                        </tr>                                    </table>                                    <!-- // END BODY -->                                </td>                            </tr>                            <tr>                                <td align=\'center\' valign=\'top\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                                    <!-- BEGIN FOOTER // -->                                    <table border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'100%\' id=\'templateFooter\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;background-color: #9FCFE8;border-top: 0;border-bottom: 0;\'>                                        <tr>                                            <td align=\'center\' valign=\'top\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                                                <table border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'600\' class=\'templateContainer\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                                                    <tr>                                                        <td valign=\'top\' class=\'footerContainer\' style=\'padding-top: 10px;padding-right: 18px;padding-bottom: 10px;padding-left: 18px;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'><table border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'100%\' class=\'mcnTextBlock\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>    <tbody class=\'mcnTextBlockOuter\'>        <tr>            <td valign=\'top\' class=\'mcnTextBlockInner\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                                <table align=\'left\' border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'600\' class=\'mcnTextContentContainer\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                    <tbody><tr>                                                <td valign=\'top\' class=\'mcnTextContent\' style=\'padding-top: 9px;padding-right: 18px;padding-bottom: 9px;padding-left: 18px;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;color: #f2f2f2;font-family: Helvetica;font-size: 11px;line-height: 125%;text-align: left;\'>                                                    <em>Copyright © 2013 edX, All rights reserved.</em><br><br><br>  <b>Our mailing address is:</b><br>  edX<br>  11 Cambridge Center, Suite 101<br>  Cambridge, MA, USA 02142<br><br><br>This email was automatically sent from {platform_name}. <br>You are receiving this email at address {email} because you are enrolled in <a href=\'{course_url}\'>{course_title}</a>.<br>To stop receiving email like this, update your course email settings <a href=\'{email_settings_url}\'>here</a>. <br><br><a href=\'{unsubscribe_link}\'>unsubscribe</a>                        </td>                    </tr>                </tbody></table>                            </td>        </tr>    </tbody></table></td>                                                    </tr>                                                </table>                                            </td>                                        </tr>                                    </table>                                    <!-- // END FOOTER -->                                </td>                            </tr>                        </table>                        <!-- // END TEMPLATE -->                    </td>                </tr>            </table>        </center>    </body>    </body> </html>','{course_title}\n\n{{message_body}}\r\n----\r\nCopyright 2013 edX, All rights reserved.\r\n----\r\nConnect with edX:\r\nFacebook (http://facebook.com/edxonline)\r\nTwitter (http://twitter.com/edxonline)\r\nGoogle+ (https://plus.google.com/108235383044095082735)\r\nMeetup (http://www.meetup.com/edX-Communities/)\r\n----\r\nThis email was automatically sent from {platform_name}.\r\nYou are receiving this email at address {email} because you are enrolled in {course_title}\r\n(URL: {course_url} ).\r\nTo stop receiving email like this, update your course email settings at {email_settings_url}.\r\n{unsubscribe_link}\r\n',NULL),(2,'<!DOCTYPE html PUBLIC \'-//W3C//DTD XHTML 1.0 Transitional//EN\' \'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\'><html xmlns:fb=\'http://www.facebook.com/2008/fbml\' xmlns:og=\'http://opengraph.org/schema/\'> <head><meta property=\'og:title\' content=\'Update from {course_title}\'/><meta property=\'fb:page_id\' content=\'43929265776\' />        <meta http-equiv=\'Content-Type\' content=\'text/html; charset=UTF-8\'>        THIS IS A BRANDED HTML TEMPLATE <title>Update from {course_title}</title>                    </head>        <body leftmargin=\'0\' marginwidth=\'0\' topmargin=\'0\' marginheight=\'0\' offset=\'0\' style=\'margin: 0;padding: 0;background-color: #ffffff;\'>        <center>            <table align=\'center\' border=\'0\' cellpadding=\'0\' cellspacing=\'0\' height=\'100%\' width=\'100%\' id=\'bodyTable\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;margin: 0;padding: 0;background-color: #ffffff;height: 100% !important;width: 100% !important;\'>                <tr>                   <td align=\'center\' valign=\'top\' id=\'bodyCell\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;margin: 0;padding: 0;border-top: 0;height: 100% !important;width: 100% !important;\'>                        <!-- BEGIN TEMPLATE // -->                        <table border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'100%\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                            <tr>                                <td align=\'center\' valign=\'top\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                                    <!-- BEGIN PREHEADER // -->                                    <table border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'100%\' id=\'templatePreheader\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;background-color: #fcfcfc;border-top: 0;border-bottom: 0;\'>                                        <tr>                                        <td align=\'center\' valign=\'top\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                                                <table border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'600\' class=\'templateContainer\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                                                    <tr>                                                        <td valign=\'top\' class=\'preheaderContainer\' style=\'padding-top: 9px;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'><table border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'100%\' class=\'mcnTextBlock\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>    <tbody class=\'mcnTextBlockOuter\'>        <tr>            <td valign=\'top\' class=\'mcnTextBlockInner\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                                <table align=\'left\' border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'366\' class=\'mcnTextContentContainer\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                    <tbody><tr>                                                <td valign=\'top\' class=\'mcnTextContent\' style=\'padding-top: 9px;padding-left: 18px;padding-bottom: 9px;padding-right: 0;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;color: #606060;font-family: Helvetica;font-size: 11px;line-height: 125%;text-align: left;\'>                                                    <br>                        </td>                    </tr>                </tbody></table>                            </td>        </tr>    </tbody></table></td>                                                    </tr>                                                </table>                                            </td>                                                                                    </tr>                                    </table>                                    <!-- // END PREHEADER -->                                </td>                            </tr>                            <tr>                                <td align=\'center\' valign=\'top\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                                    <!-- BEGIN HEADER // -->                                    <table border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'100%\' id=\'templateHeader\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;background-color: #fcfcfc;border-top: 0;border-bottom: 0;\'>                                        <tr>                                            <td align=\'center\' valign=\'top\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                                                <table border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'600\' class=\'templateContainer\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                                                    <tr>                                                        <td valign=\'top\' class=\'headerContainer\' style=\'padding-top: 10px;padding-right: 18px;padding-bottom: 10px;padding-left: 18px;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'><table border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'100%\' class=\'mcnImageBlock\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>    <tbody class=\'mcnImageBlockOuter\'>            <tr>                <td valign=\'top\' style=\'padding: 9px;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\' class=\'mcnImageBlockInner\'>                    <table align=\'left\' width=\'100%\' border=\'0\' cellpadding=\'0\' cellspacing=\'0\' class=\'mcnImageContentContainer\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                        <tbody><tr>                            <td class=\'mcnImageContent\' valign=\'top\' style=\'padding-right: 9px;padding-left: 9px;padding-top: 0;padding-bottom: 0;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                                                                    <a href=\'http://edx.org\' title=\'\' class=\'\' target=\'_self\' style=\'word-wrap: break-word !important;\'>                                        <img align=\'left\' alt=\'edX\' src=\'http://courses.edx.org/static/images/bulk_email/edXHeaderImage.jpg\' width=\'564.0000152587891\' style=\'max-width: 600px;padding-bottom: 0;display: inline !important;vertical-align: bottom;border: 0;line-height: 100%;outline: none;text-decoration: none;height: auto !important;\' class=\'mcnImage\'>                                    </a>                                                            </td>                        </tr>                    </tbody></table>                </td>            </tr>    </tbody></table><table border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'100%\' class=\'mcnTextBlock\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>    <tbody class=\'mcnTextBlockOuter\'>        <tr>            <td valign=\'top\' class=\'mcnTextBlockInner\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                                <table align=\'left\' border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'599\' class=\'mcnTextContentContainer\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                    <tbody><tr>                                                <td valign=\'top\' class=\'mcnTextContent\' style=\'padding-top: 9px;padding-right: 18px;padding-bottom: 9px;padding-left: 18px;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;color: #606060;font-family: Helvetica;font-size: 15px;line-height: 150%;text-align: left;\'>                                                    <div style=\'text-align: right;\'><span style=\'font-size:11px;\'><span style=\'color:#00a0e3;\'>Connect with edX:</span></span> &nbsp;<a href=\'http://facebook.com/edxonline\' target=\'_blank\' style=\'color: #6DC6DD;font-weight: normal;text-decoration: underline;word-wrap: break-word !important;\'><img align=\'none\' height=\'16\' src=\'http://courses.edx.org/static/images/bulk_email/FacebookIcon.png\' style=\'width: 16px;height: 16px;border: 0;line-height: 100%;outline: none;text-decoration: none;\' width=\'16\'></a>&nbsp;&nbsp;<a href=\'http://twitter.com/edxonline\' target=\'_blank\' style=\'color: #6DC6DD;font-weight: normal;text-decoration: underline;word-wrap: break-word !important;\'><img align=\'none\' height=\'16\' src=\'http://courses.edx.org/static/images/bulk_email/TwitterIcon.png\' style=\'width: 16px;height: 16px;border: 0;line-height: 100%;outline: none;text-decoration: none;\' width=\'16\'></a>&nbsp;&nbsp;<a href=\'https://plus.google.com/108235383044095082735\' target=\'_blank\' style=\'color: #6DC6DD;font-weight: normal;text-decoration: underline;word-wrap: break-word !important;\'><img align=\'none\' height=\'16\' src=\'http://courses.edx.org/static/images/bulk_email/GooglePlusIcon.png\' style=\'width: 16px;height: 16px;border: 0;line-height: 100%;outline: none;text-decoration: none;\' width=\'16\'></a>&nbsp;&nbsp;<a href=\'http://www.meetup.com/edX-Communities/\' target=\'_blank\' style=\'color: #6DC6DD;font-weight: normal;text-decoration: underline;word-wrap: break-word !important;\'><img align=\'none\' height=\'16\' src=\'http://courses.edx.org/static/images/bulk_email/MeetupIcon.png\' style=\'width: 16px;height: 16px;border: 0;line-height: 100%;outline: none;text-decoration: none;\' width=\'16\'></a></div>                        </td>                    </tr>                </tbody></table>                            </td>        </tr>    </tbody></table></td>                                                    </tr>                                                </table>                                            </td>                                        </tr>                                    </table>                                    <!-- // END HEADER -->                                </td>                            </tr>                            <tr>                                <td align=\'center\' valign=\'top\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                                    <!-- BEGIN BODY // -->                                    <table border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'100%\' id=\'templateBody\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;background-color: #fcfcfc;border-top: 0;border-bottom: 0;\'>                                        <tr>                                            <td align=\'center\' valign=\'top\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                                                <table border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'600\' class=\'templateContainer\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                                                    <tr>                                                        <td valign=\'top\' class=\'bodyContainer\' style=\'padding-top: 10px;padding-right: 18px;padding-bottom: 10px;padding-left: 18px;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'><table border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'100%\' class=\'mcnCaptionBlock\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>    <tbody class=\'mcnCaptionBlockOuter\'>        <tr>            <td class=\'mcnCaptionBlockInner\' valign=\'top\' style=\'padding: 9px;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                <table border=\'0\' cellpadding=\'0\' cellspacing=\'0\' class=\'mcnCaptionLeftContentOuter\' width=\'100%\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>    <tbody><tr>        <td valign=\'top\' class=\'mcnCaptionLeftContentInner\' style=\'padding: 0 9px;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>            <table align=\'right\' border=\'0\' cellpadding=\'0\' cellspacing=\'0\' class=\'mcnCaptionLeftImageContentContainer\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                <tbody><tr>                    <td class=\'mcnCaptionLeftImageContent\' valign=\'top\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                                                                    <img alt=\'\' src=\'{course_image_url}\' width=\'176\' style=\'max-width: 180px;border: 0;line-height: 100%;outline: none;text-decoration: none;vertical-align: bottom;height: auto !important;\' class=\'mcnImage\'>                                                                </td>                </tr>            </tbody></table>            <table class=\'mcnCaptionLeftTextContentContainer\' align=\'left\' border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'352\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                <tbody><tr>                    <td valign=\'top\' class=\'mcnTextContent\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;color: #606060;font-family: Helvetica;font-size: 14px;line-height: 150%;text-align: left;\'>                        <h3 class=\'null\' style=\'display: block;font-family: Helvetica;font-size: 18px;font-style: normal;font-weight: bold;line-height: 125%;letter-spacing: -.5px;margin: 0;text-align: left;color: #606060 !important;\'><strong style=\'font-size: 22px;\'>{course_title}</strong><br></h3><br>                    </td>                </tr>            </tbody></table>        </td>    </tr></tbody></table>            </td>        </tr>    </tbody></table><table border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'100%\' class=\'mcnTextBlock\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>    <tbody class=\'mcnTextBlockOuter\'>        <tr>            <td valign=\'top\' class=\'mcnTextBlockInner\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                                <table align=\'left\' border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'600\' class=\'mcnTextContentContainer\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                    <tbody><tr>                                                <td valign=\'top\' class=\'mcnTextContent\' style=\'padding-top: 9px;padding-right: 18px;padding-bottom: 9px;padding-left: 18px;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;color: #606060;font-family: Helvetica;font-size: 14px;line-height: 150%;text-align: left;\'>                        {{message_body}}                        </td>                    </tr>                </tbody></table>                            </td>        </tr>    </tbody></table><table border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'100%\' class=\'mcnDividerBlock\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>    <tbody class=\'mcnDividerBlockOuter\'>        <tr>            <td class=\'mcnDividerBlockInner\' style=\'padding: 18px 18px 3px;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                <table class=\'mcnDividerContent\' border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'100%\' style=\'border-top-width: 1px;border-top-style: solid;border-top-color: #666666;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                    <tbody><tr>                        <td style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                            <span></span>                        </td>                    </tr>                </tbody></table>            </td>        </tr>    </tbody></table><table border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'100%\' class=\'mcnTextBlock\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>    <tbody class=\'mcnTextBlockOuter\'>        <tr>            <td valign=\'top\' class=\'mcnTextBlockInner\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                                <table align=\'left\' border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'600\' class=\'mcnTextContentContainer\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                    <tbody><tr>                                                <td valign=\'top\' class=\'mcnTextContent\' style=\'padding-top: 9px;padding-right: 18px;padding-bottom: 9px;padding-left: 18px;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;color: #606060;font-family: Helvetica;font-size: 14px;line-height: 150%;text-align: left;\'>                                                    <div style=\'text-align: right;\'><a href=\'http://facebook.com/edxonline\' target=\'_blank\' style=\'color: #2f73bc;font-weight: normal;text-decoration: underline;word-wrap: break-word !important;\'><img align=\'none\' height=\'16\' src=\'http://courses.edx.org/static/images/bulk_email/FacebookIcon.png\' style=\'width: 16px;height: 16px;border: 0;line-height: 100%;outline: none;text-decoration: none;\' width=\'16\'></a>&nbsp;&nbsp;<a href=\'http://twitter.com/edxonline\' target=\'_blank\' style=\'color: #2f73bc;font-weight: normal;text-decoration: underline;word-wrap: break-word !important;\'><img align=\'none\' height=\'16\' src=\'http://courses.edx.org/static/images/bulk_email/TwitterIcon.png\' style=\'width: 16px;height: 16px;border: 0;line-height: 100%;outline: none;text-decoration: none;\' width=\'16\'></a>&nbsp;&nbsp;<a href=\'https://plus.google.com/108235383044095082735\' target=\'_blank\' style=\'color: #2f73bc;font-weight: normal;text-decoration: underline;word-wrap: break-word !important;\'><img align=\'none\' height=\'16\' src=\'http://courses.edx.org/static/images/bulk_email/GooglePlusIcon.png\' style=\'width: 16px;height: 16px;border: 0;line-height: 100%;outline: none;text-decoration: none;\' width=\'16\'></a>&nbsp; &nbsp;<a href=\'http://www.meetup.com/edX-Communities/\' target=\'_blank\' style=\'color: #2f73bc;font-weight: normal;text-decoration: underline;word-wrap: break-word !important;\'><img align=\'none\' height=\'16\' src=\'http://courses.edx.org/static/images/bulk_email/MeetupIcon.png\' style=\'width: 16px;height: 16px;border: 0;line-height: 100%;outline: none;text-decoration: none;\' width=\'16\'></a></div>                        </td>                    </tr>                </tbody></table>                            </td>        </tr>    </tbody></table></td>                                                    </tr>                                                </table>                                            </td>                                        </tr>                                    </table>                                    <!-- // END BODY -->                                </td>                            </tr>                            <tr>                                <td align=\'center\' valign=\'top\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                                    <!-- BEGIN FOOTER // -->                                    <table border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'100%\' id=\'templateFooter\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;background-color: #9FCFE8;border-top: 0;border-bottom: 0;\'>                                        <tr>                                            <td align=\'center\' valign=\'top\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                                                <table border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'600\' class=\'templateContainer\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                                                    <tr>                                                        <td valign=\'top\' class=\'footerContainer\' style=\'padding-top: 10px;padding-right: 18px;padding-bottom: 10px;padding-left: 18px;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'><table border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'100%\' class=\'mcnTextBlock\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>    <tbody class=\'mcnTextBlockOuter\'>        <tr>            <td valign=\'top\' class=\'mcnTextBlockInner\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                                <table align=\'left\' border=\'0\' cellpadding=\'0\' cellspacing=\'0\' width=\'600\' class=\'mcnTextContentContainer\' style=\'border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;\'>                    <tbody><tr>                                                <td valign=\'top\' class=\'mcnTextContent\' style=\'padding-top: 9px;padding-right: 18px;padding-bottom: 9px;padding-left: 18px;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;color: #f2f2f2;font-family: Helvetica;font-size: 11px;line-height: 125%;text-align: left;\'>                                                    <em>Copyright © 2013 edX, All rights reserved.</em><br><br><br>  <b>Our mailing address is:</b><br>  edX<br>  11 Cambridge Center, Suite 101<br>  Cambridge, MA, USA 02142<br><br><br>This email was automatically sent from {platform_name}. <br>You are receiving this email at address {email} because you are enrolled in <a href=\'{course_url}\'>{course_title}</a>.<br>To stop receiving email like this, update your course email settings <a href=\'{email_settings_url}\'>here</a>. <br><br><a href=\'{unsubscribe_link}\'>unsubscribe</a>                        </td>                    </tr>                </tbody></table>                            </td>        </tr>    </tbody></table></td>                                                    </tr>                                                </table>                                            </td>                                        </tr>                                    </table>                                    <!-- // END FOOTER -->                                </td>                            </tr>                        </table>                        <!-- // END TEMPLATE -->                    </td>                </tr>            </table>        </center>    </body>    </body> </html>','THIS IS A BRANDED TEXT TEMPLATE. {course_title}\n\n{{message_body}}\r\n----\r\nCopyright 2013 edX, All rights reserved.\r\n----\r\nConnect with edX:\r\nFacebook (http://facebook.com/edxonline)\r\nTwitter (http://twitter.com/edxonline)\r\nGoogle+ (https://plus.google.com/108235383044095082735)\r\nMeetup (http://www.meetup.com/edX-Communities/)\r\n----\r\nThis email was automatically sent from {platform_name}.\r\nYou are receiving this email at address {email} because you are enrolled in {course_title}\r\n(URL: {course_url} ).\r\nTo stop receiving email like this, update your course email settings at {email_settings_url}.\r\n{unsubscribe_link}\r\n','branded.template');
/*!40000 ALTER TABLE `bulk_email_courseemailtemplate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bulk_email_coursemodetarget`
--

DROP TABLE IF EXISTS `bulk_email_coursemodetarget`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bulk_email_coursemodetarget` (
  `target_ptr_id` int(11) NOT NULL,
  `track_id` int(11) NOT NULL,
  PRIMARY KEY (`target_ptr_id`),
  KEY `bulk_email_coursemod_track_id_2b68bb43_fk_course_mo` (`track_id`),
  CONSTRAINT `bulk_email_coursemod_target_ptr_id_f2f054ce_fk_bulk_emai` FOREIGN KEY (`target_ptr_id`) REFERENCES `bulk_email_target` (`id`),
  CONSTRAINT `bulk_email_coursemod_track_id_2b68bb43_fk_course_mo` FOREIGN KEY (`track_id`) REFERENCES `course_modes_coursemode` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bulk_email_coursemodetarget`
--

LOCK TABLES `bulk_email_coursemodetarget` WRITE;
/*!40000 ALTER TABLE `bulk_email_coursemodetarget` DISABLE KEYS */;
/*!40000 ALTER TABLE `bulk_email_coursemodetarget` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bulk_email_optout`
--

DROP TABLE IF EXISTS `bulk_email_optout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bulk_email_optout` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` varchar(255) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `bulk_email_optout_user_id_course_id_e0e2d6a6_uniq` (`user_id`,`course_id`),
  KEY `bulk_email_optout_course_id_5c5836a8` (`course_id`),
  CONSTRAINT `bulk_email_optout_user_id_ff6223d6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bulk_email_optout`
--

LOCK TABLES `bulk_email_optout` WRITE;
/*!40000 ALTER TABLE `bulk_email_optout` DISABLE KEYS */;
/*!40000 ALTER TABLE `bulk_email_optout` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bulk_email_target`
--

DROP TABLE IF EXISTS `bulk_email_target`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bulk_email_target` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `target_type` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bulk_email_target`
--

LOCK TABLES `bulk_email_target` WRITE;
/*!40000 ALTER TABLE `bulk_email_target` DISABLE KEYS */;
/*!40000 ALTER TABLE `bulk_email_target` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bulk_grades_scoreoverrider`
--

DROP TABLE IF EXISTS `bulk_grades_scoreoverrider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bulk_grades_scoreoverrider` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `modified` datetime(6) NOT NULL,
  `created` datetime(6) NOT NULL,
  `module_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `bulk_grades_scoreove_module_id_33617068_fk_coursewar` (`module_id`),
  KEY `bulk_grades_scoreoverrider_user_id_9768d9f6_fk_auth_user_id` (`user_id`),
  KEY `bulk_grades_scoreoverrider_created_2d9c74a5` (`created`),
  CONSTRAINT `bulk_grades_scoreoverrider_user_id_9768d9f6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bulk_grades_scoreoverrider`
--

LOCK TABLES `bulk_grades_scoreoverrider` WRITE;
/*!40000 ALTER TABLE `bulk_grades_scoreoverrider` DISABLE KEYS */;
/*!40000 ALTER TABLE `bulk_grades_scoreoverrider` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calendar_sync_historicalusercalendarsyncconfig`
--

DROP TABLE IF EXISTS `calendar_sync_historicalusercalendarsyncconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calendar_sync_historicalusercalendarsyncconfig` (
  `id` int(11) NOT NULL,
  `course_key` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `ics_sequence` int(11) NOT NULL,
  PRIMARY KEY (`history_id`),
  KEY `calendar_sync_histor_history_user_id_e696e2d5_fk_auth_user` (`history_user_id`),
  KEY `calendar_sync_historicalusercalendarsyncconfig_id_2b36f9ae` (`id`),
  KEY `calendar_sync_historicaluse_course_key_0f40c91a` (`course_key`),
  KEY `calendar_sync_historicalusercalendarsyncconfig_user_id_c2855120` (`user_id`),
  CONSTRAINT `calendar_sync_histor_history_user_id_e696e2d5_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendar_sync_historicalusercalendarsyncconfig`
--

LOCK TABLES `calendar_sync_historicalusercalendarsyncconfig` WRITE;
/*!40000 ALTER TABLE `calendar_sync_historicalusercalendarsyncconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `calendar_sync_historicalusercalendarsyncconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calendar_sync_usercalendarsyncconfig`
--

DROP TABLE IF EXISTS `calendar_sync_usercalendarsyncconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calendar_sync_usercalendarsyncconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_key` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `user_id` int(11) NOT NULL,
  `ics_sequence` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `calendar_sync_usercalend_user_id_course_key_57c343ab_uniq` (`user_id`,`course_key`),
  KEY `calendar_sync_usercalendarsyncconfig_course_key_86657ca7` (`course_key`),
  CONSTRAINT `calendar_sync_userca_user_id_5dd14ead_fk_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendar_sync_usercalendarsyncconfig`
--

LOCK TABLES `calendar_sync_usercalendarsyncconfig` WRITE;
/*!40000 ALTER TABLE `calendar_sync_usercalendarsyncconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `calendar_sync_usercalendarsyncconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `canvas_canvasenterprisecustomerconfiguration`
--

DROP TABLE IF EXISTS `canvas_canvasenterprisecustomerconfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `canvas_canvasenterprisecustomerconfiguration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `transmission_chunk_size` int(11) NOT NULL,
  `channel_worker_username` varchar(255) DEFAULT NULL,
  `catalogs_to_transmit` longtext,
  `client_id` varchar(255) DEFAULT NULL,
  `client_secret` varchar(255) DEFAULT NULL,
  `canvas_account_id` bigint(20) DEFAULT NULL,
  `canvas_base_url` varchar(255) DEFAULT NULL,
  `enterprise_customer_id` char(32) NOT NULL,
  `refresh_token` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `enterprise_customer_id` (`enterprise_customer_id`),
  CONSTRAINT `canvas_canvasenterpr_enterprise_customer__b2e73393_fk_enterpris` FOREIGN KEY (`enterprise_customer_id`) REFERENCES `enterprise_enterprisecustomer` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `canvas_canvasenterprisecustomerconfiguration`
--

LOCK TABLES `canvas_canvasenterprisecustomerconfiguration` WRITE;
/*!40000 ALTER TABLE `canvas_canvasenterprisecustomerconfiguration` DISABLE KEYS */;
/*!40000 ALTER TABLE `canvas_canvasenterprisecustomerconfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `canvas_canvaslearnerassessmentdatatransmissionaudit`
--

DROP TABLE IF EXISTS `canvas_canvaslearnerassessmentdatatransmissionaudit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `canvas_canvaslearnerassessmentdatatransmissionaudit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `canvas_user_email` varchar(255) NOT NULL,
  `enterprise_course_enrollment_id` int(10) unsigned NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `subsection_id` varchar(255) NOT NULL,
  `grade_point_score` double NOT NULL,
  `grade_points_possible` double NOT NULL,
  `grade` double NOT NULL,
  `subsection_name` varchar(255) NOT NULL,
  `status` varchar(100) NOT NULL,
  `error_message` longtext NOT NULL,
  `created` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `canvas_canvaslearnerassessm_enterprise_course_enrollmen_d9dba2b4` (`enterprise_course_enrollment_id`),
  KEY `canvas_canvaslearnerassessm_subsection_id_b3450f75` (`subsection_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `canvas_canvaslearnerassessmentdatatransmissionaudit`
--

LOCK TABLES `canvas_canvaslearnerassessmentdatatransmissionaudit` WRITE;
/*!40000 ALTER TABLE `canvas_canvaslearnerassessmentdatatransmissionaudit` DISABLE KEYS */;
/*!40000 ALTER TABLE `canvas_canvaslearnerassessmentdatatransmissionaudit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `canvas_canvaslearnerdatatransmissionaudit`
--

DROP TABLE IF EXISTS `canvas_canvaslearnerdatatransmissionaudit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `canvas_canvaslearnerdatatransmissionaudit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `canvas_user_email` varchar(255) NOT NULL,
  `enterprise_course_enrollment_id` int(10) unsigned NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `course_completed` tinyint(1) NOT NULL,
  `completed_timestamp` varchar(10) NOT NULL,
  `status` varchar(100) NOT NULL,
  `error_message` longtext NOT NULL,
  `created` datetime(6) NOT NULL,
  `grade` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `canvas_canvaslearnerdatatra_enterprise_course_enrollmen_c2a9800c` (`enterprise_course_enrollment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `canvas_canvaslearnerdatatransmissionaudit`
--

LOCK TABLES `canvas_canvaslearnerdatatransmissionaudit` WRITE;
/*!40000 ALTER TABLE `canvas_canvaslearnerdatatransmissionaudit` DISABLE KEYS */;
/*!40000 ALTER TABLE `canvas_canvaslearnerdatatransmissionaudit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `canvas_historicalcanvasenterprisecustomerconfiguration`
--

DROP TABLE IF EXISTS `canvas_historicalcanvasenterprisecustomerconfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `canvas_historicalcanvasenterprisecustomerconfiguration` (
  `id` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `transmission_chunk_size` int(11) NOT NULL,
  `channel_worker_username` varchar(255) DEFAULT NULL,
  `catalogs_to_transmit` longtext,
  `client_id` varchar(255) DEFAULT NULL,
  `client_secret` varchar(255) DEFAULT NULL,
  `canvas_account_id` bigint(20) DEFAULT NULL,
  `canvas_base_url` varchar(255) DEFAULT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `enterprise_customer_id` char(32) DEFAULT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  `refresh_token` varchar(255) NOT NULL,
  PRIMARY KEY (`history_id`),
  KEY `canvas_historicalcan_history_user_id_615fc2a2_fk_auth_user` (`history_user_id`),
  KEY `canvas_historicalcanvasente_id_8769e0b6` (`id`),
  KEY `canvas_historicalcanvasente_enterprise_customer_id_8bd0d3ec` (`enterprise_customer_id`),
  CONSTRAINT `canvas_historicalcan_history_user_id_615fc2a2_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `canvas_historicalcanvasenterprisecustomerconfiguration`
--

LOCK TABLES `canvas_historicalcanvasenterprisecustomerconfiguration` WRITE;
/*!40000 ALTER TABLE `canvas_historicalcanvasenterprisecustomerconfiguration` DISABLE KEYS */;
/*!40000 ALTER TABLE `canvas_historicalcanvasenterprisecustomerconfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catalog_catalogintegration`
--

DROP TABLE IF EXISTS `catalog_catalogintegration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalog_catalogintegration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `internal_api_url` varchar(200) NOT NULL,
  `cache_ttl` int(10) unsigned NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  `service_username` varchar(100) NOT NULL,
  `page_size` int(10) unsigned NOT NULL,
  `long_term_cache_ttl` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `catalog_cataloginteg_changed_by_id_cde406de_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `catalog_cataloginteg_changed_by_id_cde406de_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalog_catalogintegration`
--

LOCK TABLES `catalog_catalogintegration` WRITE;
/*!40000 ALTER TABLE `catalog_catalogintegration` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalog_catalogintegration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `celery_utils_failedtask`
--

DROP TABLE IF EXISTS `celery_utils_failedtask`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `celery_utils_failedtask` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `task_name` varchar(255) NOT NULL,
  `task_id` varchar(255) NOT NULL,
  `args` longtext NOT NULL,
  `kwargs` longtext NOT NULL,
  `exc` varchar(255) NOT NULL,
  `datetime_resolved` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `celery_utils_failedtask_task_name_exc_efb8c9be_idx` (`task_name`,`exc`),
  KEY `celery_utils_failedtask_task_id_37af0933` (`task_id`),
  KEY `celery_utils_failedtask_datetime_resolved_8160e407` (`datetime_resolved`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `celery_utils_failedtask`
--

LOCK TABLES `celery_utils_failedtask` WRITE;
/*!40000 ALTER TABLE `celery_utils_failedtask` DISABLE KEYS */;
/*!40000 ALTER TABLE `celery_utils_failedtask` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `certificates_allowlistgenerationconfiguration`
--

DROP TABLE IF EXISTS `certificates_allowlistgenerationconfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `certificates_allowlistgenerationconfiguration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `arguments` longtext NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `certificates_allowli_changed_by_id_8c30e04b_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `certificates_allowli_changed_by_id_8c30e04b_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certificates_allowlistgenerationconfiguration`
--

LOCK TABLES `certificates_allowlistgenerationconfiguration` WRITE;
/*!40000 ALTER TABLE `certificates_allowlistgenerationconfiguration` DISABLE KEYS */;
/*!40000 ALTER TABLE `certificates_allowlistgenerationconfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `certificates_certificategenerationconfiguration`
--

DROP TABLE IF EXISTS `certificates_certificategenerationconfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `certificates_certificategenerationconfiguration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `certificates_certifi_changed_by_id_a6d06e99_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `certificates_certifi_changed_by_id_a6d06e99_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certificates_certificategenerationconfiguration`
--

LOCK TABLES `certificates_certificategenerationconfiguration` WRITE;
/*!40000 ALTER TABLE `certificates_certificategenerationconfiguration` DISABLE KEYS */;
/*!40000 ALTER TABLE `certificates_certificategenerationconfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `certificates_certificategenerationcoursesetting`
--

DROP TABLE IF EXISTS `certificates_certificategenerationcoursesetting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `certificates_certificategenerationcoursesetting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `course_key` varchar(255) NOT NULL,
  `language_specific_templates_enabled` tinyint(1) NOT NULL,
  `self_generation_enabled` tinyint(1) NOT NULL,
  `include_hours_of_effort` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `certificates_certificategen_course_key_dd10af41` (`course_key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certificates_certificategenerationcoursesetting`
--

LOCK TABLES `certificates_certificategenerationcoursesetting` WRITE;
/*!40000 ALTER TABLE `certificates_certificategenerationcoursesetting` DISABLE KEYS */;
/*!40000 ALTER TABLE `certificates_certificategenerationcoursesetting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `certificates_certificategenerationhistory`
--

DROP TABLE IF EXISTS `certificates_certificategenerationhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `certificates_certificategenerationhistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `is_regeneration` tinyint(1) NOT NULL,
  `generated_by_id` int(11) NOT NULL,
  `instructor_task_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `certificates_certifi_generated_by_id_e9d4b7f2_fk_auth_user` (`generated_by_id`),
  KEY `certificates_certifi_instructor_task_id_8f7176a6_fk_instructo` (`instructor_task_id`),
  CONSTRAINT `certificates_certifi_generated_by_id_e9d4b7f2_fk_auth_user` FOREIGN KEY (`generated_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `certificates_certifi_instructor_task_id_8f7176a6_fk_instructo` FOREIGN KEY (`instructor_task_id`) REFERENCES `instructor_task_instructortask` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certificates_certificategenerationhistory`
--

LOCK TABLES `certificates_certificategenerationhistory` WRITE;
/*!40000 ALTER TABLE `certificates_certificategenerationhistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `certificates_certificategenerationhistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `certificates_certificatehtmlviewconfiguration`
--

DROP TABLE IF EXISTS `certificates_certificatehtmlviewconfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `certificates_certificatehtmlviewconfiguration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `configuration` longtext NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `certificates_certifi_changed_by_id_bcf656f2_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `certificates_certifi_changed_by_id_bcf656f2_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certificates_certificatehtmlviewconfiguration`
--

LOCK TABLES `certificates_certificatehtmlviewconfiguration` WRITE;
/*!40000 ALTER TABLE `certificates_certificatehtmlviewconfiguration` DISABLE KEYS */;
INSERT INTO `certificates_certificatehtmlviewconfiguration` VALUES (1,'2021-03-24 08:05:18.007710',0,'{\"default\": {\"accomplishment_class_append\": \"accomplishment-certificate\", \"platform_name\": \"Your Platform Name Here\", \"company_about_url\": \"http://www.example.com/about-us\", \"company_privacy_url\": \"http://www.example.com/privacy-policy\", \"company_tos_url\": \"http://www.example.com/terms-service\", \"company_verified_certificate_url\": \"http://www.example.com/verified-certificate\", \"logo_src\": \"/static/certificates/images/logo.png\", \"logo_url\": \"http://www.example.com\"}, \"honor\": {\"certificate_type\": \"Honor Code\", \"certificate_title\": \"Certificate of Achievement\"}, \"verified\": {\"certificate_type\": \"Verified\", \"certificate_title\": \"Verified Certificate of Achievement\"}}',NULL);
/*!40000 ALTER TABLE `certificates_certificatehtmlviewconfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `certificates_certificateinvalidation`
--

DROP TABLE IF EXISTS `certificates_certificateinvalidation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `certificates_certificateinvalidation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `notes` longtext,
  `active` tinyint(1) NOT NULL,
  `generated_certificate_id` int(11) NOT NULL,
  `invalidated_by_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `certificates_certifi_generated_certificat_31bed498_fk_certifica` (`generated_certificate_id`),
  KEY `certificates_certifi_invalidated_by_id_e3c101f1_fk_auth_user` (`invalidated_by_id`),
  CONSTRAINT `certificates_certifi_generated_certificat_31bed498_fk_certifica` FOREIGN KEY (`generated_certificate_id`) REFERENCES `certificates_generatedcertificate` (`id`),
  CONSTRAINT `certificates_certifi_invalidated_by_id_e3c101f1_fk_auth_user` FOREIGN KEY (`invalidated_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certificates_certificateinvalidation`
--

LOCK TABLES `certificates_certificateinvalidation` WRITE;
/*!40000 ALTER TABLE `certificates_certificateinvalidation` DISABLE KEYS */;
/*!40000 ALTER TABLE `certificates_certificateinvalidation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `certificates_certificatetemplate`
--

DROP TABLE IF EXISTS `certificates_certificatetemplate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `certificates_certificatetemplate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `template` longtext NOT NULL,
  `organization_id` int(11) DEFAULT NULL,
  `course_key` varchar(255) DEFAULT NULL,
  `mode` varchar(125) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `language` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `certificates_certificate_organization_id_course_k_88e26c0d_uniq` (`organization_id`,`course_key`,`mode`,`language`),
  KEY `certificates_certificatetemplate_organization_id_030a747d` (`organization_id`),
  KEY `certificates_certificatetemplate_course_key_9a6a823d` (`course_key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certificates_certificatetemplate`
--

LOCK TABLES `certificates_certificatetemplate` WRITE;
/*!40000 ALTER TABLE `certificates_certificatetemplate` DISABLE KEYS */;
/*!40000 ALTER TABLE `certificates_certificatetemplate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `certificates_certificatetemplateasset`
--

DROP TABLE IF EXISTS `certificates_certificatetemplateasset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `certificates_certificatetemplateasset` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `asset` varchar(255) NOT NULL,
  `asset_slug` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `asset_slug` (`asset_slug`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certificates_certificatetemplateasset`
--

LOCK TABLES `certificates_certificatetemplateasset` WRITE;
/*!40000 ALTER TABLE `certificates_certificatetemplateasset` DISABLE KEYS */;
/*!40000 ALTER TABLE `certificates_certificatetemplateasset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `certificates_certificatewhitelist`
--

DROP TABLE IF EXISTS `certificates_certificatewhitelist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `certificates_certificatewhitelist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` varchar(255) NOT NULL,
  `whitelist` tinyint(1) NOT NULL,
  `created` datetime(6) NOT NULL,
  `notes` longtext,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `certificates_certificate_course_id_user_id_da2af91a_uniq` (`course_id`,`user_id`),
  KEY `certificates_certifi_user_id_c2ab1b7c_fk_auth_user` (`user_id`),
  CONSTRAINT `certificates_certifi_user_id_c2ab1b7c_fk_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certificates_certificatewhitelist`
--

LOCK TABLES `certificates_certificatewhitelist` WRITE;
/*!40000 ALTER TABLE `certificates_certificatewhitelist` DISABLE KEYS */;
/*!40000 ALTER TABLE `certificates_certificatewhitelist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `certificates_examplecertificate`
--

DROP TABLE IF EXISTS `certificates_examplecertificate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `certificates_examplecertificate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `description` varchar(255) NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `access_key` varchar(255) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `template` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `error_reason` longtext,
  `download_url` varchar(255) DEFAULT NULL,
  `example_cert_set_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `certificates_examplecertificate_access_key_8b745a5d` (`access_key`),
  KEY `certificates_example_example_cert_set_id_7e660917_fk_certifica` (`example_cert_set_id`),
  CONSTRAINT `certificates_example_example_cert_set_id_7e660917_fk_certifica` FOREIGN KEY (`example_cert_set_id`) REFERENCES `certificates_examplecertificateset` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certificates_examplecertificate`
--

LOCK TABLES `certificates_examplecertificate` WRITE;
/*!40000 ALTER TABLE `certificates_examplecertificate` DISABLE KEYS */;
/*!40000 ALTER TABLE `certificates_examplecertificate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `certificates_examplecertificateset`
--

DROP TABLE IF EXISTS `certificates_examplecertificateset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `certificates_examplecertificateset` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `course_key` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `certificates_examplecertificateset_course_key_16497ee9` (`course_key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certificates_examplecertificateset`
--

LOCK TABLES `certificates_examplecertificateset` WRITE;
/*!40000 ALTER TABLE `certificates_examplecertificateset` DISABLE KEYS */;
/*!40000 ALTER TABLE `certificates_examplecertificateset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `certificates_generatedcertificate`
--

DROP TABLE IF EXISTS `certificates_generatedcertificate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `certificates_generatedcertificate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` varchar(255) NOT NULL,
  `verify_uuid` varchar(32) NOT NULL,
  `download_uuid` varchar(32) NOT NULL,
  `download_url` varchar(128) NOT NULL,
  `grade` varchar(5) NOT NULL,
  `key` varchar(32) NOT NULL,
  `distinction` tinyint(1) NOT NULL,
  `status` varchar(32) NOT NULL,
  `mode` varchar(32) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_date` datetime(6) NOT NULL,
  `modified_date` datetime(6) NOT NULL,
  `error_reason` varchar(512) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `certificates_generatedce_user_id_course_id_fc1bb3ee_uniq` (`user_id`,`course_id`),
  KEY `certificates_generatedcertificate_verify_uuid_97405316` (`verify_uuid`),
  CONSTRAINT `certificates_generat_user_id_54119d22_fk_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certificates_generatedcertificate`
--

LOCK TABLES `certificates_generatedcertificate` WRITE;
/*!40000 ALTER TABLE `certificates_generatedcertificate` DISABLE KEYS */;
/*!40000 ALTER TABLE `certificates_generatedcertificate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `certificates_historicalcertificateinvalidation`
--

DROP TABLE IF EXISTS `certificates_historicalcertificateinvalidation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `certificates_historicalcertificateinvalidation` (
  `id` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `notes` longtext,
  `active` tinyint(1) NOT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `generated_certificate_id` int(11) DEFAULT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  `invalidated_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `certificates_histori_history_user_id_67c7d840_fk_auth_user` (`history_user_id`),
  KEY `certificates_historicalcertificateinvalidation_id_fae092a9` (`id`),
  KEY `certificates_historicalcert_generated_certificate_id_35f5becb` (`generated_certificate_id`),
  KEY `certificates_historicalcert_invalidated_by_id_5f2eff10` (`invalidated_by_id`),
  CONSTRAINT `certificates_histori_history_user_id_67c7d840_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certificates_historicalcertificateinvalidation`
--

LOCK TABLES `certificates_historicalcertificateinvalidation` WRITE;
/*!40000 ALTER TABLE `certificates_historicalcertificateinvalidation` DISABLE KEYS */;
/*!40000 ALTER TABLE `certificates_historicalcertificateinvalidation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `certificates_historicalgeneratedcertificate`
--

DROP TABLE IF EXISTS `certificates_historicalgeneratedcertificate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `certificates_historicalgeneratedcertificate` (
  `id` int(11) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `verify_uuid` varchar(32) NOT NULL,
  `download_uuid` varchar(32) NOT NULL,
  `download_url` varchar(128) NOT NULL,
  `grade` varchar(5) NOT NULL,
  `key` varchar(32) NOT NULL,
  `distinction` tinyint(1) NOT NULL,
  `status` varchar(32) NOT NULL,
  `mode` varchar(32) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_date` datetime(6) NOT NULL,
  `modified_date` datetime(6) NOT NULL,
  `error_reason` varchar(512) NOT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `certificates_histori_history_user_id_1b53bb5f_fk_auth_user` (`history_user_id`),
  KEY `certificates_historicalgeneratedcertificate_id_269c8929` (`id`),
  KEY `certificates_historicalgeneratedcertificate_verify_uuid_783d764e` (`verify_uuid`),
  KEY `certificates_historicalgeneratedcertificate_user_id_e7970938` (`user_id`),
  CONSTRAINT `certificates_histori_history_user_id_1b53bb5f_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certificates_historicalgeneratedcertificate`
--

LOCK TABLES `certificates_historicalgeneratedcertificate` WRITE;
/*!40000 ALTER TABLE `certificates_historicalgeneratedcertificate` DISABLE KEYS */;
/*!40000 ALTER TABLE `certificates_historicalgeneratedcertificate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commerce_commerceconfiguration`
--

DROP TABLE IF EXISTS `commerce_commerceconfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_commerceconfiguration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `checkout_on_ecommerce_service` tinyint(1) NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  `cache_ttl` int(10) unsigned NOT NULL,
  `receipt_page` varchar(255) NOT NULL,
  `enable_automatic_refund_approval` tinyint(1) NOT NULL,
  `basket_checkout_page` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `commerce_commercecon_changed_by_id_2c9a6f14_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `commerce_commercecon_changed_by_id_2c9a6f14_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commerce_commerceconfiguration`
--

LOCK TABLES `commerce_commerceconfiguration` WRITE;
/*!40000 ALTER TABLE `commerce_commerceconfiguration` DISABLE KEYS */;
/*!40000 ALTER TABLE `commerce_commerceconfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `completion_blockcompletion`
--

DROP TABLE IF EXISTS `completion_blockcompletion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `completion_blockcompletion` (
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `course_key` varchar(255) NOT NULL,
  `block_key` varchar(255) NOT NULL,
  `block_type` varchar(64) NOT NULL,
  `completion` double NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `completion_blockcompleti_course_key_block_key_use_b15bac54_uniq` (`course_key`,`block_key`,`user_id`),
  KEY `completion_blockcompletio_user_id_course_key_modifi_ed54291e_idx` (`user_id`,`course_key`,`modified`),
  KEY `completion_blockcompletio_course_key_block_type_use_0f0d4d2d_idx` (`course_key`,`block_type`,`user_id`),
  CONSTRAINT `completion_blockcompletion_user_id_20994c23_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `completion_blockcompletion`
--

LOCK TABLES `completion_blockcompletion` WRITE;
/*!40000 ALTER TABLE `completion_blockcompletion` DISABLE KEYS */;
/*!40000 ALTER TABLE `completion_blockcompletion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consent_datasharingconsent`
--

DROP TABLE IF EXISTS `consent_datasharingconsent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `consent_datasharingconsent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `username` varchar(255) NOT NULL,
  `granted` tinyint(1) DEFAULT NULL,
  `course_id` varchar(255) NOT NULL,
  `enterprise_customer_id` char(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `consent_datasharingconse_enterprise_customer_id_u_8bdd34e4_uniq` (`enterprise_customer_id`,`username`,`course_id`),
  CONSTRAINT `consent_datasharingc_enterprise_customer__f46c6b77_fk_enterpris` FOREIGN KEY (`enterprise_customer_id`) REFERENCES `enterprise_enterprisecustomer` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consent_datasharingconsent`
--

LOCK TABLES `consent_datasharingconsent` WRITE;
/*!40000 ALTER TABLE `consent_datasharingconsent` DISABLE KEYS */;
/*!40000 ALTER TABLE `consent_datasharingconsent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consent_datasharingconsenttextoverrides`
--

DROP TABLE IF EXISTS `consent_datasharingconsenttextoverrides`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `consent_datasharingconsenttextoverrides` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `page_title` varchar(255) NOT NULL,
  `left_sidebar_text` longtext,
  `top_paragraph` longtext,
  `agreement_text` longtext,
  `continue_text` varchar(255) NOT NULL,
  `abort_text` varchar(255) NOT NULL,
  `policy_dropdown_header` varchar(255) DEFAULT NULL,
  `policy_paragraph` longtext,
  `confirmation_modal_header` varchar(255) NOT NULL,
  `confirmation_modal_text` longtext NOT NULL,
  `modal_affirm_decline_text` varchar(255) NOT NULL,
  `modal_abort_decline_text` varchar(255) NOT NULL,
  `declined_notification_title` longtext NOT NULL,
  `declined_notification_message` longtext NOT NULL,
  `published` tinyint(1) NOT NULL,
  `enterprise_customer_id` char(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `enterprise_customer_id` (`enterprise_customer_id`),
  CONSTRAINT `consent_datasharingc_enterprise_customer__b979dfc1_fk_enterpris` FOREIGN KEY (`enterprise_customer_id`) REFERENCES `enterprise_enterprisecustomer` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consent_datasharingconsenttextoverrides`
--

LOCK TABLES `consent_datasharingconsenttextoverrides` WRITE;
/*!40000 ALTER TABLE `consent_datasharingconsenttextoverrides` DISABLE KEYS */;
/*!40000 ALTER TABLE `consent_datasharingconsenttextoverrides` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consent_historicaldatasharingconsent`
--

DROP TABLE IF EXISTS `consent_historicaldatasharingconsent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `consent_historicaldatasharingconsent` (
  `id` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `username` varchar(255) NOT NULL,
  `granted` tinyint(1) DEFAULT NULL,
  `course_id` varchar(255) NOT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_type` varchar(1) NOT NULL,
  `enterprise_customer_id` char(32) DEFAULT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `consent_historicalda_history_user_id_08d7bf89_fk_auth_user` (`history_user_id`),
  KEY `consent_historicaldatasharingconsent_id_69bef37e` (`id`),
  KEY `consent_historicaldatashari_enterprise_customer_id_35c184bf` (`enterprise_customer_id`),
  CONSTRAINT `consent_historicalda_history_user_id_08d7bf89_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consent_historicaldatasharingconsent`
--

LOCK TABLES `consent_historicaldatasharingconsent` WRITE;
/*!40000 ALTER TABLE `consent_historicaldatasharingconsent` DISABLE KEYS */;
/*!40000 ALTER TABLE `consent_historicaldatasharingconsent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `content_libraries_contentlibrary`
--

DROP TABLE IF EXISTS `content_libraries_contentlibrary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `content_libraries_contentlibrary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `slug` varchar(50) NOT NULL,
  `bundle_uuid` char(32) NOT NULL,
  `allow_public_learning` tinyint(1) NOT NULL,
  `allow_public_read` tinyint(1) NOT NULL,
  `org_id` int(11) NOT NULL,
  `type` varchar(25) NOT NULL,
  `license` varchar(25) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `bundle_uuid` (`bundle_uuid`),
  UNIQUE KEY `content_libraries_contentlibrary_org_id_slug_2b964108_uniq` (`org_id`,`slug`),
  KEY `content_libraries_contentlibrary_slug_30d5507f` (`slug`),
  CONSTRAINT `content_libraries_co_org_id_b945a402_fk_organizat` FOREIGN KEY (`org_id`) REFERENCES `organizations_organization` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content_libraries_contentlibrary`
--

LOCK TABLES `content_libraries_contentlibrary` WRITE;
/*!40000 ALTER TABLE `content_libraries_contentlibrary` DISABLE KEYS */;
/*!40000 ALTER TABLE `content_libraries_contentlibrary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `content_libraries_contentlibrarypermission`
--

DROP TABLE IF EXISTS `content_libraries_contentlibrarypermission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `content_libraries_contentlibrarypermission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `access_level` varchar(30) NOT NULL,
  `library_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_libraries_conten_library_id_user_id_81babe29_uniq` (`library_id`,`user_id`),
  UNIQUE KEY `content_libraries_conten_library_id_group_id_3ecc38b9_uniq` (`library_id`,`group_id`),
  KEY `content_libraries_co_user_id_b071c54d_fk_auth_user` (`user_id`),
  KEY `content_libraries_co_group_id_c2a4b6a1_fk_auth_grou` (`group_id`),
  CONSTRAINT `content_libraries_co_group_id_c2a4b6a1_fk_auth_grou` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `content_libraries_co_library_id_51247096_fk_content_l` FOREIGN KEY (`library_id`) REFERENCES `content_libraries_contentlibrary` (`id`),
  CONSTRAINT `content_libraries_co_user_id_b071c54d_fk_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content_libraries_contentlibrarypermission`
--

LOCK TABLES `content_libraries_contentlibrarypermission` WRITE;
/*!40000 ALTER TABLE `content_libraries_contentlibrarypermission` DISABLE KEYS */;
/*!40000 ALTER TABLE `content_libraries_contentlibrarypermission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `content_type_gating_contenttypegatingconfig`
--

DROP TABLE IF EXISTS `content_type_gating_contenttypegatingconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `content_type_gating_contenttypegatingconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `org` varchar(255) DEFAULT NULL,
  `enabled_as_of` datetime(6) DEFAULT NULL,
  `studio_override_enabled` tinyint(1) DEFAULT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  `course_id` varchar(255) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `org_course` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `content_type_gating__changed_by_id_e1754c4b_fk_auth_user` (`changed_by_id`),
  KEY `content_type_gating_contenttypegatingconfig_org_043e72a9` (`org`),
  KEY `content_typ_site_id_e91576_idx` (`site_id`,`org`,`course_id`),
  KEY `content_type_gating__course_id_f19cc50d_fk_course_ov` (`course_id`),
  KEY `content_typ_site_id_650310_idx` (`site_id`,`org`,`org_course`,`course_id`),
  KEY `content_type_gating_contenttypegatingconfig_org_course_70742f9e` (`org_course`),
  CONSTRAINT `content_type_gating__changed_by_id_e1754c4b_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `content_type_gating__course_id_f19cc50d_fk_course_ov` FOREIGN KEY (`course_id`) REFERENCES `course_overviews_courseoverview` (`id`),
  CONSTRAINT `content_type_gating__site_id_c9f3bc6a_fk_django_si` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content_type_gating_contenttypegatingconfig`
--

LOCK TABLES `content_type_gating_contenttypegatingconfig` WRITE;
/*!40000 ALTER TABLE `content_type_gating_contenttypegatingconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `content_type_gating_contenttypegatingconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contentserver_cdnuseragentsconfig`
--

DROP TABLE IF EXISTS `contentserver_cdnuseragentsconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contentserver_cdnuseragentsconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `cdn_user_agents` longtext NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `contentserver_cdnuse_changed_by_id_19d8cb94_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `contentserver_cdnuse_changed_by_id_19d8cb94_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contentserver_cdnuseragentsconfig`
--

LOCK TABLES `contentserver_cdnuseragentsconfig` WRITE;
/*!40000 ALTER TABLE `contentserver_cdnuseragentsconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `contentserver_cdnuseragentsconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contentserver_courseassetcachettlconfig`
--

DROP TABLE IF EXISTS `contentserver_courseassetcachettlconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contentserver_courseassetcachettlconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `cache_ttl` int(10) unsigned NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `contentserver_course_changed_by_id_a9213047_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `contentserver_course_changed_by_id_a9213047_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contentserver_courseassetcachettlconfig`
--

LOCK TABLES `contentserver_courseassetcachettlconfig` WRITE;
/*!40000 ALTER TABLE `contentserver_courseassetcachettlconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `contentserver_courseassetcachettlconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contentstore_videouploadconfig`
--

DROP TABLE IF EXISTS `contentstore_videouploadconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contentstore_videouploadconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `profile_whitelist` longtext NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `contentstore_videoup_changed_by_id_e7352cb2_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `contentstore_videoup_changed_by_id_e7352cb2_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contentstore_videouploadconfig`
--

LOCK TABLES `contentstore_videouploadconfig` WRITE;
/*!40000 ALTER TABLE `contentstore_videouploadconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `contentstore_videouploadconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cornerstone_cornerstoneenterprisecustomerconfiguration`
--

DROP TABLE IF EXISTS `cornerstone_cornerstoneenterprisecustomerconfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cornerstone_cornerstoneenterprisecustomerconfiguration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `transmission_chunk_size` int(11) NOT NULL,
  `cornerstone_base_url` varchar(255) NOT NULL,
  `enterprise_customer_id` char(32) NOT NULL,
  `channel_worker_username` varchar(255) DEFAULT NULL,
  `catalogs_to_transmit` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `enterprise_customer_id` (`enterprise_customer_id`),
  CONSTRAINT `cornerstone_cornerst_enterprise_customer__5b56887b_fk_enterpris` FOREIGN KEY (`enterprise_customer_id`) REFERENCES `enterprise_enterprisecustomer` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cornerstone_cornerstoneenterprisecustomerconfiguration`
--

LOCK TABLES `cornerstone_cornerstoneenterprisecustomerconfiguration` WRITE;
/*!40000 ALTER TABLE `cornerstone_cornerstoneenterprisecustomerconfiguration` DISABLE KEYS */;
/*!40000 ALTER TABLE `cornerstone_cornerstoneenterprisecustomerconfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cornerstone_cornerstoneglobalconfiguration`
--

DROP TABLE IF EXISTS `cornerstone_cornerstoneglobalconfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cornerstone_cornerstoneglobalconfiguration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `completion_status_api_path` varchar(255) NOT NULL,
  `oauth_api_path` varchar(255) NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  `subject_mapping` longtext NOT NULL,
  `key` varchar(255) NOT NULL,
  `secret` varchar(255) NOT NULL,
  `languages` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cornerstone_cornerst_changed_by_id_117db502_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `cornerstone_cornerst_changed_by_id_117db502_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cornerstone_cornerstoneglobalconfiguration`
--

LOCK TABLES `cornerstone_cornerstoneglobalconfiguration` WRITE;
/*!40000 ALTER TABLE `cornerstone_cornerstoneglobalconfiguration` DISABLE KEYS */;
/*!40000 ALTER TABLE `cornerstone_cornerstoneglobalconfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cornerstone_cornerstonelearnerdatatransmissionaudit`
--

DROP TABLE IF EXISTS `cornerstone_cornerstonelearnerdatatransmissionaudit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cornerstone_cornerstonelearnerdatatransmissionaudit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `user_guid` varchar(255) NOT NULL,
  `enterprise_course_enrollment_id` int(10) unsigned DEFAULT NULL,
  `course_id` varchar(255) NOT NULL,
  `session_token` varchar(255) NOT NULL,
  `callback_url` varchar(255) NOT NULL,
  `subdomain` varchar(255) NOT NULL,
  `course_completed` tinyint(1) NOT NULL,
  `completed_timestamp` datetime(6) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `error_message` longtext,
  `user_id` int(11) NOT NULL,
  `grade` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cornerstone_cornerstonel_user_id_course_id_c975cc5f_uniq` (`user_id`,`course_id`),
  KEY `cornerstone_cornerstonelear_enterprise_course_enrollmen_e3b05dac` (`enterprise_course_enrollment_id`),
  CONSTRAINT `cornerstone_cornerst_user_id_43bd15bf_fk_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cornerstone_cornerstonelearnerdatatransmissionaudit`
--

LOCK TABLES `cornerstone_cornerstonelearnerdatatransmissionaudit` WRITE;
/*!40000 ALTER TABLE `cornerstone_cornerstonelearnerdatatransmissionaudit` DISABLE KEYS */;
/*!40000 ALTER TABLE `cornerstone_cornerstonelearnerdatatransmissionaudit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cornerstone_historicalcornerstoneenterprisecustomerconfiguration`
--

DROP TABLE IF EXISTS `cornerstone_historicalcornerstoneenterprisecustomerconfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cornerstone_historicalcornerstoneenterprisecustomerconfiguration` (
  `id` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `transmission_chunk_size` int(11) NOT NULL,
  `cornerstone_base_url` varchar(255) NOT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `enterprise_customer_id` char(32) DEFAULT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  `channel_worker_username` varchar(255) DEFAULT NULL,
  `catalogs_to_transmit` longtext,
  PRIMARY KEY (`history_id`),
  KEY `cornerstone_historic_history_user_id_1ded83c5_fk_auth_user` (`history_user_id`),
  KEY `cornerstone_historicalcorne_id_513efd93` (`id`),
  KEY `cornerstone_historicalcorne_enterprise_customer_id_7f1c53b1` (`enterprise_customer_id`),
  CONSTRAINT `cornerstone_historic_history_user_id_1ded83c5_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cornerstone_historicalcornerstoneenterprisecustomerconfiguration`
--

LOCK TABLES `cornerstone_historicalcornerstoneenterprisecustomerconfiguration` WRITE;
/*!40000 ALTER TABLE `cornerstone_historicalcornerstoneenterprisecustomerconfiguration` DISABLE KEYS */;
/*!40000 ALTER TABLE `cornerstone_historicalcornerstoneenterprisecustomerconfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cors_csrf_xdomainproxyconfiguration`
--

DROP TABLE IF EXISTS `cors_csrf_xdomainproxyconfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cors_csrf_xdomainproxyconfiguration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `whitelist` longtext NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cors_csrf_xdomainpro_changed_by_id_b8e97ec3_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `cors_csrf_xdomainpro_changed_by_id_b8e97ec3_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cors_csrf_xdomainproxyconfiguration`
--

LOCK TABLES `cors_csrf_xdomainproxyconfiguration` WRITE;
/*!40000 ALTER TABLE `cors_csrf_xdomainproxyconfiguration` DISABLE KEYS */;
/*!40000 ALTER TABLE `cors_csrf_xdomainproxyconfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_action_state_coursererunstate`
--

DROP TABLE IF EXISTS `course_action_state_coursererunstate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_action_state_coursererunstate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_time` datetime(6) NOT NULL,
  `updated_time` datetime(6) NOT NULL,
  `course_key` varchar(255) NOT NULL,
  `action` varchar(100) NOT NULL,
  `state` varchar(50) NOT NULL,
  `should_display` tinyint(1) NOT NULL,
  `message` varchar(1000) NOT NULL,
  `source_course_key` varchar(255) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  `created_user_id` int(11) DEFAULT NULL,
  `updated_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `course_action_state_cour_course_key_action_2a8434fb_uniq` (`course_key`,`action`),
  KEY `course_action_state__created_user_id_5373c218_fk_auth_user` (`created_user_id`),
  KEY `course_action_state__updated_user_id_3689fe4b_fk_auth_user` (`updated_user_id`),
  KEY `course_action_state_coursererunstate_course_key_f87bef79` (`course_key`),
  KEY `course_action_state_coursererunstate_action_149773f1` (`action`),
  KEY `course_action_state_coursererunstate_source_course_key_b5037317` (`source_course_key`),
  CONSTRAINT `course_action_state__created_user_id_5373c218_fk_auth_user` FOREIGN KEY (`created_user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `course_action_state__updated_user_id_3689fe4b_fk_auth_user` FOREIGN KEY (`updated_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_action_state_coursererunstate`
--

LOCK TABLES `course_action_state_coursererunstate` WRITE;
/*!40000 ALTER TABLE `course_action_state_coursererunstate` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_action_state_coursererunstate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_creators_coursecreator`
--

DROP TABLE IF EXISTS `course_creators_coursecreator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_creators_coursecreator` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `state_changed` datetime(6) NOT NULL,
  `state` varchar(24) NOT NULL,
  `note` varchar(512) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `course_creators_coursecreator_user_id_e4da548d_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_creators_coursecreator`
--

LOCK TABLES `course_creators_coursecreator` WRITE;
/*!40000 ALTER TABLE `course_creators_coursecreator` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_creators_coursecreator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_date_signals_selfpacedrelativedatesconfig`
--

DROP TABLE IF EXISTS `course_date_signals_selfpacedrelativedatesconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_date_signals_selfpacedrelativedatesconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `org` varchar(255) DEFAULT NULL,
  `org_course` varchar(255) DEFAULT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  `course_id` varchar(255) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `course_date_site_id_a44836_idx` (`site_id`,`org`,`course_id`),
  KEY `course_date_site_id_c0164a_idx` (`site_id`,`org`,`org_course`,`course_id`),
  KEY `course_date_signals__changed_by_id_5f8228f2_fk_auth_user` (`changed_by_id`),
  KEY `course_date_signals__course_id_361d8ca8_fk_course_ov` (`course_id`),
  KEY `course_date_signals_selfpacedrelativedatesconfig_org_9c13e820` (`org`),
  KEY `course_date_signals_selfpac_org_course_b7041c4f` (`org_course`),
  CONSTRAINT `course_date_signals__changed_by_id_5f8228f2_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `course_date_signals__course_id_361d8ca8_fk_course_ov` FOREIGN KEY (`course_id`) REFERENCES `course_overviews_courseoverview` (`id`),
  CONSTRAINT `course_date_signals__site_id_29483878_fk_django_si` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_date_signals_selfpacedrelativedatesconfig`
--

LOCK TABLES `course_date_signals_selfpacedrelativedatesconfig` WRITE;
/*!40000 ALTER TABLE `course_date_signals_selfpacedrelativedatesconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_date_signals_selfpacedrelativedatesconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_duration_limits_coursedurationlimitconfig`
--

DROP TABLE IF EXISTS `course_duration_limits_coursedurationlimitconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_duration_limits_coursedurationlimitconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `org` varchar(255) DEFAULT NULL,
  `enabled_as_of` datetime(6) DEFAULT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  `course_id` varchar(255) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `org_course` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `course_duration_limi_changed_by_id_f320fd76_fk_auth_user` (`changed_by_id`),
  KEY `course_duration_limits_coursedurationlimitconfig_org_c2cc0091` (`org`),
  KEY `course_dura_site_id_424016_idx` (`site_id`,`org`,`course_id`),
  KEY `course_duration_limi_course_id_97b7a8e9_fk_course_ov` (`course_id`),
  KEY `course_dura_site_id_b5bbcd_idx` (`site_id`,`org`,`org_course`,`course_id`),
  KEY `course_duration_limits_cour_org_course_bcd05764` (`org_course`),
  CONSTRAINT `course_duration_limi_changed_by_id_f320fd76_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `course_duration_limi_course_id_97b7a8e9_fk_course_ov` FOREIGN KEY (`course_id`) REFERENCES `course_overviews_courseoverview` (`id`),
  CONSTRAINT `course_duration_limi_site_id_cb492296_fk_django_si` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_duration_limits_coursedurationlimitconfig`
--

LOCK TABLES `course_duration_limits_coursedurationlimitconfig` WRITE;
/*!40000 ALTER TABLE `course_duration_limits_coursedurationlimitconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_duration_limits_coursedurationlimitconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_goals_coursegoal`
--

DROP TABLE IF EXISTS `course_goals_coursegoal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_goals_coursegoal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_key` varchar(255) NOT NULL,
  `goal_key` varchar(100) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `course_goals_coursegoal_user_id_course_key_052bc0d3_uniq` (`user_id`,`course_key`),
  KEY `course_goals_coursegoal_course_key_5585ca51` (`course_key`),
  CONSTRAINT `course_goals_coursegoal_user_id_0a07e3db_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_goals_coursegoal`
--

LOCK TABLES `course_goals_coursegoal` WRITE;
/*!40000 ALTER TABLE `course_goals_coursegoal` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_goals_coursegoal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_groups_cohortmembership`
--

DROP TABLE IF EXISTS `course_groups_cohortmembership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_groups_cohortmembership` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` varchar(255) NOT NULL,
  `course_user_group_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `course_groups_cohortmembership_user_id_course_id_c247eb7f_uniq` (`user_id`,`course_id`),
  KEY `course_groups_cohort_course_user_group_id_6ea50b45_fk_course_gr` (`course_user_group_id`),
  CONSTRAINT `course_groups_cohort_course_user_group_id_6ea50b45_fk_course_gr` FOREIGN KEY (`course_user_group_id`) REFERENCES `course_groups_courseusergroup` (`id`),
  CONSTRAINT `course_groups_cohortmembership_user_id_aae5b8e7_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_groups_cohortmembership`
--

LOCK TABLES `course_groups_cohortmembership` WRITE;
/*!40000 ALTER TABLE `course_groups_cohortmembership` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_groups_cohortmembership` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_groups_coursecohort`
--

DROP TABLE IF EXISTS `course_groups_coursecohort`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_groups_coursecohort` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assignment_type` varchar(20) NOT NULL,
  `course_user_group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `course_user_group_id` (`course_user_group_id`),
  CONSTRAINT `course_groups_course_course_user_group_id_ec5703ee_fk_course_gr` FOREIGN KEY (`course_user_group_id`) REFERENCES `course_groups_courseusergroup` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_groups_coursecohort`
--

LOCK TABLES `course_groups_coursecohort` WRITE;
/*!40000 ALTER TABLE `course_groups_coursecohort` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_groups_coursecohort` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_groups_coursecohortssettings`
--

DROP TABLE IF EXISTS `course_groups_coursecohortssettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_groups_coursecohortssettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_cohorted` tinyint(1) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `cohorted_discussions` longtext,
  `always_cohort_inline_discussions` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `course_id` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_groups_coursecohortssettings`
--

LOCK TABLES `course_groups_coursecohortssettings` WRITE;
/*!40000 ALTER TABLE `course_groups_coursecohortssettings` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_groups_coursecohortssettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_groups_courseusergroup`
--

DROP TABLE IF EXISTS `course_groups_courseusergroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_groups_courseusergroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `group_type` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `course_groups_courseusergroup_name_course_id_b767231d_uniq` (`name`,`course_id`),
  KEY `course_groups_courseusergroup_course_id_902aea4c` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_groups_courseusergroup`
--

LOCK TABLES `course_groups_courseusergroup` WRITE;
/*!40000 ALTER TABLE `course_groups_courseusergroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_groups_courseusergroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_groups_courseusergroup_users`
--

DROP TABLE IF EXISTS `course_groups_courseusergroup_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_groups_courseusergroup_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `courseusergroup_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `course_groups_courseuser_courseusergroup_id_user__694e8c30_uniq` (`courseusergroup_id`,`user_id`),
  KEY `course_groups_course_user_id_28aff981_fk_auth_user` (`user_id`),
  CONSTRAINT `course_groups_course_courseusergroup_id_26a7966f_fk_course_gr` FOREIGN KEY (`courseusergroup_id`) REFERENCES `course_groups_courseusergroup` (`id`),
  CONSTRAINT `course_groups_course_user_id_28aff981_fk_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_groups_courseusergroup_users`
--

LOCK TABLES `course_groups_courseusergroup_users` WRITE;
/*!40000 ALTER TABLE `course_groups_courseusergroup_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_groups_courseusergroup_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_groups_courseusergrouppartitiongroup`
--

DROP TABLE IF EXISTS `course_groups_courseusergrouppartitiongroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_groups_courseusergrouppartitiongroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `partition_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `course_user_group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `course_user_group_id` (`course_user_group_id`),
  CONSTRAINT `course_groups_course_course_user_group_id_6032d512_fk_course_gr` FOREIGN KEY (`course_user_group_id`) REFERENCES `course_groups_courseusergroup` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_groups_courseusergrouppartitiongroup`
--

LOCK TABLES `course_groups_courseusergrouppartitiongroup` WRITE;
/*!40000 ALTER TABLE `course_groups_courseusergrouppartitiongroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_groups_courseusergrouppartitiongroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_groups_unregisteredlearnercohortassignments`
--

DROP TABLE IF EXISTS `course_groups_unregisteredlearnercohortassignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_groups_unregisteredlearnercohortassignments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `course_user_group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `course_groups_unregister_course_id_email_81a9d1db_uniq` (`course_id`,`email`),
  KEY `course_groups_unregi_course_user_group_id_c1c8a247_fk_course_gr` (`course_user_group_id`),
  KEY `course_groups_unregisteredl_email_05d0e40e` (`email`),
  CONSTRAINT `course_groups_unregi_course_user_group_id_c1c8a247_fk_course_gr` FOREIGN KEY (`course_user_group_id`) REFERENCES `course_groups_courseusergroup` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_groups_unregisteredlearnercohortassignments`
--

LOCK TABLES `course_groups_unregisteredlearnercohortassignments` WRITE;
/*!40000 ALTER TABLE `course_groups_unregisteredlearnercohortassignments` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_groups_unregisteredlearnercohortassignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_modes_coursemode`
--

DROP TABLE IF EXISTS `course_modes_coursemode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_modes_coursemode` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` varchar(255) NOT NULL,
  `mode_slug` varchar(100) NOT NULL,
  `mode_display_name` varchar(255) NOT NULL,
  `min_price` int(11) NOT NULL,
  `currency` varchar(8) NOT NULL,
  `expiration_datetime` datetime(6) DEFAULT NULL,
  `expiration_date` date DEFAULT NULL,
  `suggested_prices` varchar(255) NOT NULL,
  `description` longtext,
  `sku` varchar(255) DEFAULT NULL,
  `expiration_datetime_is_explicit` tinyint(1) NOT NULL,
  `bulk_sku` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `course_modes_coursemode_course_id_mode_slug_curr_56f8e675_uniq` (`course_id`,`mode_slug`,`currency`),
  KEY `course_modes_coursemode_course_id_3daf3b9d` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_modes_coursemode`
--

LOCK TABLES `course_modes_coursemode` WRITE;
/*!40000 ALTER TABLE `course_modes_coursemode` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_modes_coursemode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_modes_coursemodeexpirationconfig`
--

DROP TABLE IF EXISTS `course_modes_coursemodeexpirationconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_modes_coursemodeexpirationconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `verification_window` bigint(20) NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `course_modes_coursem_changed_by_id_208463ee_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `course_modes_coursem_changed_by_id_208463ee_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_modes_coursemodeexpirationconfig`
--

LOCK TABLES `course_modes_coursemodeexpirationconfig` WRITE;
/*!40000 ALTER TABLE `course_modes_coursemodeexpirationconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_modes_coursemodeexpirationconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_modes_coursemodesarchive`
--

DROP TABLE IF EXISTS `course_modes_coursemodesarchive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_modes_coursemodesarchive` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` varchar(255) NOT NULL,
  `mode_slug` varchar(100) NOT NULL,
  `mode_display_name` varchar(255) NOT NULL,
  `min_price` int(11) NOT NULL,
  `suggested_prices` varchar(255) NOT NULL,
  `currency` varchar(8) NOT NULL,
  `expiration_date` date DEFAULT NULL,
  `expiration_datetime` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `course_modes_coursemodesarchive_course_id_f67bbd35` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_modes_coursemodesarchive`
--

LOCK TABLES `course_modes_coursemodesarchive` WRITE;
/*!40000 ALTER TABLE `course_modes_coursemodesarchive` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_modes_coursemodesarchive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_modes_historicalcoursemode`
--

DROP TABLE IF EXISTS `course_modes_historicalcoursemode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_modes_historicalcoursemode` (
  `id` int(11) NOT NULL,
  `mode_slug` varchar(100) NOT NULL,
  `mode_display_name` varchar(255) NOT NULL,
  `min_price` int(11) NOT NULL,
  `currency` varchar(8) NOT NULL,
  `expiration_datetime` datetime(6) DEFAULT NULL,
  `expiration_datetime_is_explicit` tinyint(1) NOT NULL,
  `expiration_date` date DEFAULT NULL,
  `suggested_prices` varchar(255) NOT NULL,
  `description` longtext,
  `sku` varchar(255) DEFAULT NULL,
  `bulk_sku` varchar(255) DEFAULT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `course_id` varchar(255) DEFAULT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `course_modes_histori_history_user_id_d92d6b6e_fk_auth_user` (`history_user_id`),
  KEY `course_modes_historicalcoursemode_id_14918a77` (`id`),
  KEY `course_modes_historicalcoursemode_course_id_e8de13cd` (`course_id`),
  CONSTRAINT `course_modes_histori_history_user_id_d92d6b6e_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_modes_historicalcoursemode`
--

LOCK TABLES `course_modes_historicalcoursemode` WRITE;
/*!40000 ALTER TABLE `course_modes_historicalcoursemode` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_modes_historicalcoursemode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_overviews_courseoverview`
--

DROP TABLE IF EXISTS `course_overviews_courseoverview`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_overviews_courseoverview` (
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `version` int(11) NOT NULL,
  `id` varchar(255) NOT NULL,
  `_location` varchar(255) NOT NULL,
  `display_name` longtext,
  `display_number_with_default` longtext NOT NULL,
  `display_org_with_default` longtext NOT NULL,
  `start` datetime(6) DEFAULT NULL,
  `end` datetime(6) DEFAULT NULL,
  `advertised_start` longtext,
  `course_image_url` longtext NOT NULL,
  `social_sharing_url` longtext,
  `end_of_course_survey_url` longtext,
  `certificates_display_behavior` longtext,
  `certificates_show_before_end` tinyint(1) NOT NULL,
  `cert_html_view_enabled` tinyint(1) NOT NULL,
  `has_any_active_web_certificate` tinyint(1) NOT NULL,
  `cert_name_short` longtext NOT NULL,
  `cert_name_long` longtext NOT NULL,
  `lowest_passing_grade` decimal(5,2) DEFAULT NULL,
  `days_early_for_beta` double DEFAULT NULL,
  `mobile_available` tinyint(1) NOT NULL,
  `visible_to_staff_only` tinyint(1) NOT NULL,
  `_pre_requisite_courses_json` longtext NOT NULL,
  `enrollment_start` datetime(6) DEFAULT NULL,
  `enrollment_end` datetime(6) DEFAULT NULL,
  `enrollment_domain` longtext,
  `invitation_only` tinyint(1) NOT NULL,
  `max_student_enrollments_allowed` int(11) DEFAULT NULL,
  `announcement` datetime(6) DEFAULT NULL,
  `catalog_visibility` longtext,
  `course_video_url` longtext,
  `effort` longtext,
  `short_description` longtext,
  `org` longtext NOT NULL,
  `self_paced` tinyint(1) NOT NULL,
  `marketing_url` longtext,
  `eligible_for_financial_aid` tinyint(1) NOT NULL,
  `language` longtext,
  `certificate_available_date` datetime(6) DEFAULT NULL,
  `end_date` datetime(6) DEFAULT NULL,
  `start_date` datetime(6) DEFAULT NULL,
  `banner_image_url` longtext NOT NULL,
  `has_highlights` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_overviews_courseoverview`
--

LOCK TABLES `course_overviews_courseoverview` WRITE;
/*!40000 ALTER TABLE `course_overviews_courseoverview` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_overviews_courseoverview` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_overviews_courseoverviewimageconfig`
--

DROP TABLE IF EXISTS `course_overviews_courseoverviewimageconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_overviews_courseoverviewimageconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `small_width` int(11) NOT NULL,
  `small_height` int(11) NOT NULL,
  `large_width` int(11) NOT NULL,
  `large_height` int(11) NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `course_overviews_cou_changed_by_id_b60ae39a_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `course_overviews_cou_changed_by_id_b60ae39a_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_overviews_courseoverviewimageconfig`
--

LOCK TABLES `course_overviews_courseoverviewimageconfig` WRITE;
/*!40000 ALTER TABLE `course_overviews_courseoverviewimageconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_overviews_courseoverviewimageconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_overviews_courseoverviewimageset`
--

DROP TABLE IF EXISTS `course_overviews_courseoverviewimageset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_overviews_courseoverviewimageset` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `small_url` longtext NOT NULL,
  `large_url` longtext NOT NULL,
  `course_overview_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `course_overview_id` (`course_overview_id`),
  CONSTRAINT `course_overviews_cou_course_overview_id_ef7aa548_fk_course_ov` FOREIGN KEY (`course_overview_id`) REFERENCES `course_overviews_courseoverview` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_overviews_courseoverviewimageset`
--

LOCK TABLES `course_overviews_courseoverviewimageset` WRITE;
/*!40000 ALTER TABLE `course_overviews_courseoverviewimageset` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_overviews_courseoverviewimageset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_overviews_courseoverviewtab`
--

DROP TABLE IF EXISTS `course_overviews_courseoverviewtab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_overviews_courseoverviewtab` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tab_id` varchar(50) NOT NULL,
  `course_overview_id` varchar(255) NOT NULL,
  `course_staff_only` tinyint(1) NOT NULL,
  `name` longtext,
  `type` varchar(50) DEFAULT NULL,
  `url_slug` longtext,
  `link` longtext,
  `is_hidden` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `course_overviews_cou_course_overview_id_71fa6321_fk_course_ov` (`course_overview_id`),
  CONSTRAINT `course_overviews_cou_course_overview_id_71fa6321_fk_course_ov` FOREIGN KEY (`course_overview_id`) REFERENCES `course_overviews_courseoverview` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_overviews_courseoverviewtab`
--

LOCK TABLES `course_overviews_courseoverviewtab` WRITE;
/*!40000 ALTER TABLE `course_overviews_courseoverviewtab` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_overviews_courseoverviewtab` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_overviews_historicalcourseoverview`
--

DROP TABLE IF EXISTS `course_overviews_historicalcourseoverview`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_overviews_historicalcourseoverview` (
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `version` int(11) NOT NULL,
  `id` varchar(255) NOT NULL,
  `_location` varchar(255) NOT NULL,
  `org` longtext NOT NULL,
  `display_name` longtext,
  `display_number_with_default` longtext NOT NULL,
  `display_org_with_default` longtext NOT NULL,
  `start` datetime(6) DEFAULT NULL,
  `end` datetime(6) DEFAULT NULL,
  `advertised_start` longtext,
  `announcement` datetime(6) DEFAULT NULL,
  `course_image_url` longtext NOT NULL,
  `social_sharing_url` longtext,
  `end_of_course_survey_url` longtext,
  `certificates_display_behavior` longtext,
  `certificates_show_before_end` tinyint(1) NOT NULL,
  `cert_html_view_enabled` tinyint(1) NOT NULL,
  `has_any_active_web_certificate` tinyint(1) NOT NULL,
  `cert_name_short` longtext NOT NULL,
  `cert_name_long` longtext NOT NULL,
  `certificate_available_date` datetime(6) DEFAULT NULL,
  `lowest_passing_grade` decimal(5,2) DEFAULT NULL,
  `days_early_for_beta` double DEFAULT NULL,
  `mobile_available` tinyint(1) NOT NULL,
  `visible_to_staff_only` tinyint(1) NOT NULL,
  `_pre_requisite_courses_json` longtext NOT NULL,
  `enrollment_start` datetime(6) DEFAULT NULL,
  `enrollment_end` datetime(6) DEFAULT NULL,
  `enrollment_domain` longtext,
  `invitation_only` tinyint(1) NOT NULL,
  `max_student_enrollments_allowed` int(11) DEFAULT NULL,
  `catalog_visibility` longtext,
  `short_description` longtext,
  `course_video_url` longtext,
  `effort` longtext,
  `self_paced` tinyint(1) NOT NULL,
  `marketing_url` longtext,
  `eligible_for_financial_aid` tinyint(1) NOT NULL,
  `language` longtext,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  `end_date` datetime(6) DEFAULT NULL,
  `start_date` datetime(6) DEFAULT NULL,
  `banner_image_url` longtext NOT NULL,
  `has_highlights` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `course_overviews_his_history_user_id_e21063d9_fk_auth_user` (`history_user_id`),
  KEY `course_overviews_historicalcourseoverview_id_647043f0` (`id`),
  CONSTRAINT `course_overviews_his_history_user_id_e21063d9_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_overviews_historicalcourseoverview`
--

LOCK TABLES `course_overviews_historicalcourseoverview` WRITE;
/*!40000 ALTER TABLE `course_overviews_historicalcourseoverview` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_overviews_historicalcourseoverview` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_overviews_simulatecoursepublishconfig`
--

DROP TABLE IF EXISTS `course_overviews_simulatecoursepublishconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_overviews_simulatecoursepublishconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `arguments` longtext NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `course_overviews_sim_changed_by_id_3413c118_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `course_overviews_sim_changed_by_id_3413c118_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_overviews_simulatecoursepublishconfig`
--

LOCK TABLES `course_overviews_simulatecoursepublishconfig` WRITE;
/*!40000 ALTER TABLE `course_overviews_simulatecoursepublishconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_overviews_simulatecoursepublishconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courseware_coursedynamicupgradedeadlineconfiguration`
--

DROP TABLE IF EXISTS `courseware_coursedynamicupgradedeadlineconfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courseware_coursedynamicupgradedeadlineconfiguration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `deadline_days` smallint(5) unsigned NOT NULL,
  `opt_out` tinyint(1) NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `courseware_coursedyn_changed_by_id_2c4efc3a_fk_auth_user` (`changed_by_id`),
  KEY `courseware_coursedynamicupg_course_id_60b88041` (`course_id`),
  CONSTRAINT `courseware_coursedyn_changed_by_id_2c4efc3a_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courseware_coursedynamicupgradedeadlineconfiguration`
--

LOCK TABLES `courseware_coursedynamicupgradedeadlineconfiguration` WRITE;
/*!40000 ALTER TABLE `courseware_coursedynamicupgradedeadlineconfiguration` DISABLE KEYS */;
/*!40000 ALTER TABLE `courseware_coursedynamicupgradedeadlineconfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courseware_dynamicupgradedeadlineconfiguration`
--

DROP TABLE IF EXISTS `courseware_dynamicupgradedeadlineconfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courseware_dynamicupgradedeadlineconfiguration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `deadline_days` smallint(5) unsigned NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `courseware_dynamicup_changed_by_id_6a450e2c_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `courseware_dynamicup_changed_by_id_6a450e2c_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courseware_dynamicupgradedeadlineconfiguration`
--

LOCK TABLES `courseware_dynamicupgradedeadlineconfiguration` WRITE;
/*!40000 ALTER TABLE `courseware_dynamicupgradedeadlineconfiguration` DISABLE KEYS */;
/*!40000 ALTER TABLE `courseware_dynamicupgradedeadlineconfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courseware_offlinecomputedgrade`
--

DROP TABLE IF EXISTS `courseware_offlinecomputedgrade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courseware_offlinecomputedgrade` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` varchar(255) NOT NULL,
  `created` datetime(6) DEFAULT NULL,
  `updated` datetime(6) NOT NULL,
  `gradeset` longtext,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `courseware_offlinecomputedgrade_user_id_course_id_18dfd343_uniq` (`user_id`,`course_id`),
  KEY `courseware_offlinecomputedgrade_course_id_03e21ba7` (`course_id`),
  KEY `courseware_offlinecomputedgrade_created_b5bca47f` (`created`),
  KEY `courseware_offlinecomputedgrade_updated_6f3faff6` (`updated`),
  CONSTRAINT `courseware_offlinecomputedgrade_user_id_14864cea_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courseware_offlinecomputedgrade`
--

LOCK TABLES `courseware_offlinecomputedgrade` WRITE;
/*!40000 ALTER TABLE `courseware_offlinecomputedgrade` DISABLE KEYS */;
/*!40000 ALTER TABLE `courseware_offlinecomputedgrade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courseware_offlinecomputedgradelog`
--

DROP TABLE IF EXISTS `courseware_offlinecomputedgradelog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courseware_offlinecomputedgradelog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` varchar(255) NOT NULL,
  `created` datetime(6) DEFAULT NULL,
  `seconds` int(11) NOT NULL,
  `nstudents` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `courseware_offlinecomputedgradelog_course_id_1014e127` (`course_id`),
  KEY `courseware_offlinecomputedgradelog_created_33076a1a` (`created`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courseware_offlinecomputedgradelog`
--

LOCK TABLES `courseware_offlinecomputedgradelog` WRITE;
/*!40000 ALTER TABLE `courseware_offlinecomputedgradelog` DISABLE KEYS */;
/*!40000 ALTER TABLE `courseware_offlinecomputedgradelog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courseware_orgdynamicupgradedeadlineconfiguration`
--

DROP TABLE IF EXISTS `courseware_orgdynamicupgradedeadlineconfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courseware_orgdynamicupgradedeadlineconfiguration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `org_id` varchar(255) NOT NULL,
  `deadline_days` smallint(5) unsigned NOT NULL,
  `opt_out` tinyint(1) NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `courseware_orgdynami_changed_by_id_b557a1ea_fk_auth_user` (`changed_by_id`),
  KEY `courseware_orgdynamicupgrad_org_id_85d3cbe4` (`org_id`),
  CONSTRAINT `courseware_orgdynami_changed_by_id_b557a1ea_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courseware_orgdynamicupgradedeadlineconfiguration`
--

LOCK TABLES `courseware_orgdynamicupgradedeadlineconfiguration` WRITE;
/*!40000 ALTER TABLE `courseware_orgdynamicupgradedeadlineconfiguration` DISABLE KEYS */;
/*!40000 ALTER TABLE `courseware_orgdynamicupgradedeadlineconfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courseware_studentfieldoverride`
--

DROP TABLE IF EXISTS `courseware_studentfieldoverride`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courseware_studentfieldoverride` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `field` varchar(255) NOT NULL,
  `value` longtext NOT NULL,
  `student_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `courseware_studentfieldo_course_id_field_location_a1f7da25_uniq` (`course_id`,`field`,`location`,`student_id`),
  KEY `courseware_studentfi_student_id_7a972765_fk_auth_user` (`student_id`),
  KEY `courseware_studentfieldoverride_course_id_7ca0051c` (`course_id`),
  KEY `courseware_studentfieldoverride_location_95ad5047` (`location`),
  CONSTRAINT `courseware_studentfi_student_id_7a972765_fk_auth_user` FOREIGN KEY (`student_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courseware_studentfieldoverride`
--

LOCK TABLES `courseware_studentfieldoverride` WRITE;
/*!40000 ALTER TABLE `courseware_studentfieldoverride` DISABLE KEYS */;
/*!40000 ALTER TABLE `courseware_studentfieldoverride` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courseware_studentmodule`
--

DROP TABLE IF EXISTS `courseware_studentmodule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courseware_studentmodule` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `module_type` varchar(32) NOT NULL,
  `module_id` varchar(255) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `state` longtext,
  `grade` double DEFAULT NULL,
  `max_grade` double DEFAULT NULL,
  `done` varchar(8) NOT NULL,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `student_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `courseware_studentmodule_student_id_module_id_cou_48e8deef_uniq` (`student_id`,`module_id`,`course_id`),
  KEY `courseware_studentmodule_module_type_f4f8863f` (`module_type`),
  KEY `courseware_studentmodule_course_id_0637cb49` (`course_id`),
  KEY `courseware_studentmodule_grade_adac1ba7` (`grade`),
  KEY `courseware_studentmodule_created_9976b4ad` (`created`),
  KEY `courseware_studentmodule_modified_f6a0b0cc` (`modified`),
  KEY `courseware_stats` (`module_id`,`grade`,`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courseware_studentmodule`
--

LOCK TABLES `courseware_studentmodule` WRITE;
/*!40000 ALTER TABLE `courseware_studentmodule` DISABLE KEYS */;
/*!40000 ALTER TABLE `courseware_studentmodule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courseware_studentmodulehistory`
--

DROP TABLE IF EXISTS `courseware_studentmodulehistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courseware_studentmodulehistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(255) DEFAULT NULL,
  `created` datetime(6) NOT NULL,
  `state` longtext,
  `grade` double DEFAULT NULL,
  `max_grade` double DEFAULT NULL,
  `student_module_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `courseware_studentmo_student_module_id_6efc64cf_fk_coursewar` (`student_module_id`),
  KEY `courseware_studentmodulehistory_version_d3823ad1` (`version`),
  KEY `courseware_studentmodulehistory_created_19cb94d2` (`created`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courseware_studentmodulehistory`
--

LOCK TABLES `courseware_studentmodulehistory` WRITE;
/*!40000 ALTER TABLE `courseware_studentmodulehistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `courseware_studentmodulehistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courseware_xmodulestudentinfofield`
--

DROP TABLE IF EXISTS `courseware_xmodulestudentinfofield`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courseware_xmodulestudentinfofield` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `field_name` varchar(64) NOT NULL,
  `value` longtext NOT NULL,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `student_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `courseware_xmodulestuden_student_id_field_name_2f3a4ee8_uniq` (`student_id`,`field_name`),
  KEY `courseware_xmodulestudentinfofield_field_name_191b762e` (`field_name`),
  KEY `courseware_xmodulestudentinfofield_created_beada63d` (`created`),
  KEY `courseware_xmodulestudentinfofield_modified_b53f9c88` (`modified`),
  CONSTRAINT `courseware_xmodulest_student_id_b78d39b4_fk_auth_user` FOREIGN KEY (`student_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courseware_xmodulestudentinfofield`
--

LOCK TABLES `courseware_xmodulestudentinfofield` WRITE;
/*!40000 ALTER TABLE `courseware_xmodulestudentinfofield` DISABLE KEYS */;
/*!40000 ALTER TABLE `courseware_xmodulestudentinfofield` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courseware_xmodulestudentprefsfield`
--

DROP TABLE IF EXISTS `courseware_xmodulestudentprefsfield`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courseware_xmodulestudentprefsfield` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `field_name` varchar(64) NOT NULL,
  `value` longtext NOT NULL,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `module_type` varchar(64) NOT NULL,
  `student_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `courseware_xmodulestuden_student_id_module_type_f_1c218850_uniq` (`student_id`,`module_type`,`field_name`),
  KEY `courseware_xmodulestudentprefsfield_field_name_68d5e66e` (`field_name`),
  KEY `courseware_xmodulestudentprefsfield_created_16090241` (`created`),
  KEY `courseware_xmodulestudentprefsfield_modified_5b4e5525` (`modified`),
  KEY `courseware_xmodulestudentprefsfield_module_type_45b994b9` (`module_type`),
  CONSTRAINT `courseware_xmodulest_student_id_3c60ec8a_fk_auth_user` FOREIGN KEY (`student_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courseware_xmodulestudentprefsfield`
--

LOCK TABLES `courseware_xmodulestudentprefsfield` WRITE;
/*!40000 ALTER TABLE `courseware_xmodulestudentprefsfield` DISABLE KEYS */;
/*!40000 ALTER TABLE `courseware_xmodulestudentprefsfield` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courseware_xmoduleuserstatesummaryfield`
--

DROP TABLE IF EXISTS `courseware_xmoduleuserstatesummaryfield`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courseware_xmoduleuserstatesummaryfield` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `field_name` varchar(64) NOT NULL,
  `value` longtext NOT NULL,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `usage_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `courseware_xmoduleuserst_usage_id_field_name_e4e34c44_uniq` (`usage_id`,`field_name`),
  KEY `courseware_xmoduleuserstatesummaryfield_field_name_395cd2a6` (`field_name`),
  KEY `courseware_xmoduleuserstatesummaryfield_created_57d773a1` (`created`),
  KEY `courseware_xmoduleuserstatesummaryfield_modified_b4277a5d` (`modified`),
  KEY `courseware_xmoduleuserstatesummaryfield_usage_id_9f239d1f` (`usage_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courseware_xmoduleuserstatesummaryfield`
--

LOCK TABLES `courseware_xmoduleuserstatesummaryfield` WRITE;
/*!40000 ALTER TABLE `courseware_xmoduleuserstatesummaryfield` DISABLE KEYS */;
/*!40000 ALTER TABLE `courseware_xmoduleuserstatesummaryfield` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crawlers_crawlersconfig`
--

DROP TABLE IF EXISTS `crawlers_crawlersconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `crawlers_crawlersconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `known_user_agents` longtext NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `crawlers_crawlersconfig_changed_by_id_544af924_fk_auth_user_id` (`changed_by_id`),
  CONSTRAINT `crawlers_crawlersconfig_changed_by_id_544af924_fk_auth_user_id` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crawlers_crawlersconfig`
--

LOCK TABLES `crawlers_crawlersconfig` WRITE;
/*!40000 ALTER TABLE `crawlers_crawlersconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `crawlers_crawlersconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credentials_credentialsapiconfig`
--

DROP TABLE IF EXISTS `credentials_credentialsapiconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `credentials_credentialsapiconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `internal_service_url` varchar(200) NOT NULL,
  `public_service_url` varchar(200) NOT NULL,
  `enable_learner_issuance` tinyint(1) NOT NULL,
  `enable_studio_authoring` tinyint(1) NOT NULL,
  `cache_ttl` int(10) unsigned NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `credentials_credenti_changed_by_id_9e145a81_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `credentials_credenti_changed_by_id_9e145a81_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credentials_credentialsapiconfig`
--

LOCK TABLES `credentials_credentialsapiconfig` WRITE;
/*!40000 ALTER TABLE `credentials_credentialsapiconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `credentials_credentialsapiconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credentials_notifycredentialsconfig`
--

DROP TABLE IF EXISTS `credentials_notifycredentialsconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `credentials_notifycredentialsconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `arguments` longtext NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `credentials_notifycr_changed_by_id_e31cde0e_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `credentials_notifycr_changed_by_id_e31cde0e_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credentials_notifycredentialsconfig`
--

LOCK TABLES `credentials_notifycredentialsconfig` WRITE;
/*!40000 ALTER TABLE `credentials_notifycredentialsconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `credentials_notifycredentialsconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credit_creditconfig`
--

DROP TABLE IF EXISTS `credit_creditconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `credit_creditconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `cache_ttl` int(10) unsigned NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `credit_creditconfig_changed_by_id_72e1eca9_fk_auth_user_id` (`changed_by_id`),
  CONSTRAINT `credit_creditconfig_changed_by_id_72e1eca9_fk_auth_user_id` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credit_creditconfig`
--

LOCK TABLES `credit_creditconfig` WRITE;
/*!40000 ALTER TABLE `credit_creditconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `credit_creditconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credit_creditcourse`
--

DROP TABLE IF EXISTS `credit_creditcourse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `credit_creditcourse` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_key` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `course_key` (`course_key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credit_creditcourse`
--

LOCK TABLES `credit_creditcourse` WRITE;
/*!40000 ALTER TABLE `credit_creditcourse` DISABLE KEYS */;
/*!40000 ALTER TABLE `credit_creditcourse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credit_crediteligibility`
--

DROP TABLE IF EXISTS `credit_crediteligibility`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `credit_crediteligibility` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `username` varchar(255) NOT NULL,
  `deadline` datetime(6) NOT NULL,
  `course_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `credit_crediteligibility_username_course_id_7906b4c1_uniq` (`username`,`course_id`),
  KEY `credit_crediteligibi_course_id_d86f481f_fk_credit_cr` (`course_id`),
  KEY `credit_crediteligibility_username_4c275fb5` (`username`),
  CONSTRAINT `credit_crediteligibi_course_id_d86f481f_fk_credit_cr` FOREIGN KEY (`course_id`) REFERENCES `credit_creditcourse` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credit_crediteligibility`
--

LOCK TABLES `credit_crediteligibility` WRITE;
/*!40000 ALTER TABLE `credit_crediteligibility` DISABLE KEYS */;
/*!40000 ALTER TABLE `credit_crediteligibility` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credit_creditprovider`
--

DROP TABLE IF EXISTS `credit_creditprovider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `credit_creditprovider` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `provider_id` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  `enable_integration` tinyint(1) NOT NULL,
  `provider_url` varchar(200) NOT NULL,
  `provider_status_url` varchar(200) NOT NULL,
  `provider_description` longtext NOT NULL,
  `fulfillment_instructions` longtext,
  `eligibility_email_message` longtext NOT NULL,
  `receipt_email_message` longtext NOT NULL,
  `thumbnail_url` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `provider_id` (`provider_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credit_creditprovider`
--

LOCK TABLES `credit_creditprovider` WRITE;
/*!40000 ALTER TABLE `credit_creditprovider` DISABLE KEYS */;
/*!40000 ALTER TABLE `credit_creditprovider` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credit_creditrequest`
--

DROP TABLE IF EXISTS `credit_creditrequest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `credit_creditrequest` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `uuid` varchar(32) NOT NULL,
  `username` varchar(255) NOT NULL,
  `parameters` longtext NOT NULL,
  `status` varchar(255) NOT NULL,
  `course_id` int(11) NOT NULL,
  `provider_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `credit_creditrequest_username_course_id_provi_3b019afe_uniq` (`username`,`course_id`,`provider_id`),
  KEY `credit_creditrequest_course_id_5478ceaf_fk_credit_cr` (`course_id`),
  KEY `credit_creditrequest_provider_id_5465ab8b_fk_credit_cr` (`provider_id`),
  KEY `credit_creditrequest_username_bd5623e4` (`username`),
  CONSTRAINT `credit_creditrequest_course_id_5478ceaf_fk_credit_cr` FOREIGN KEY (`course_id`) REFERENCES `credit_creditcourse` (`id`),
  CONSTRAINT `credit_creditrequest_provider_id_5465ab8b_fk_credit_cr` FOREIGN KEY (`provider_id`) REFERENCES `credit_creditprovider` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credit_creditrequest`
--

LOCK TABLES `credit_creditrequest` WRITE;
/*!40000 ALTER TABLE `credit_creditrequest` DISABLE KEYS */;
/*!40000 ALTER TABLE `credit_creditrequest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credit_creditrequirement`
--

DROP TABLE IF EXISTS `credit_creditrequirement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `credit_creditrequirement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `namespace` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  `criteria` longtext NOT NULL,
  `active` tinyint(1) NOT NULL,
  `course_id` int(11) NOT NULL,
  `sort_value` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `credit_creditrequirement_namespace_name_course_id_87c301e6_uniq` (`namespace`,`name`,`course_id`),
  KEY `credit_creditrequire_course_id_b6aa812a_fk_credit_cr` (`course_id`),
  CONSTRAINT `credit_creditrequire_course_id_b6aa812a_fk_credit_cr` FOREIGN KEY (`course_id`) REFERENCES `credit_creditcourse` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credit_creditrequirement`
--

LOCK TABLES `credit_creditrequirement` WRITE;
/*!40000 ALTER TABLE `credit_creditrequirement` DISABLE KEYS */;
/*!40000 ALTER TABLE `credit_creditrequirement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credit_creditrequirementstatus`
--

DROP TABLE IF EXISTS `credit_creditrequirementstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `credit_creditrequirementstatus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `username` varchar(255) NOT NULL,
  `status` varchar(32) NOT NULL,
  `reason` longtext NOT NULL,
  `requirement_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `credit_creditrequirement_username_requirement_id_f761eba5_uniq` (`username`,`requirement_id`),
  KEY `credit_creditrequire_requirement_id_cde25c76_fk_credit_cr` (`requirement_id`),
  KEY `credit_creditrequirementstatus_username_4c2511ed` (`username`),
  CONSTRAINT `credit_creditrequire_requirement_id_cde25c76_fk_credit_cr` FOREIGN KEY (`requirement_id`) REFERENCES `credit_creditrequirement` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credit_creditrequirementstatus`
--

LOCK TABLES `credit_creditrequirementstatus` WRITE;
/*!40000 ALTER TABLE `credit_creditrequirementstatus` DISABLE KEYS */;
/*!40000 ALTER TABLE `credit_creditrequirementstatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dark_lang_darklangconfig`
--

DROP TABLE IF EXISTS `dark_lang_darklangconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dark_lang_darklangconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `released_languages` longtext NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  `beta_languages` longtext NOT NULL,
  `enable_beta_languages` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dark_lang_darklangconfig_changed_by_id_9a7df899_fk_auth_user_id` (`changed_by_id`),
  CONSTRAINT `dark_lang_darklangconfig_changed_by_id_9a7df899_fk_auth_user_id` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dark_lang_darklangconfig`
--

LOCK TABLES `dark_lang_darklangconfig` WRITE;
/*!40000 ALTER TABLE `dark_lang_darklangconfig` DISABLE KEYS */;
INSERT INTO `dark_lang_darklangconfig` VALUES (1,'2021-03-24 08:05:53.449163',1,'',NULL,'',0);
/*!40000 ALTER TABLE `dark_lang_darklangconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `degreed_degreedenterprisecustomerconfiguration`
--

DROP TABLE IF EXISTS `degreed_degreedenterprisecustomerconfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `degreed_degreedenterprisecustomerconfiguration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `key` varchar(255) NOT NULL,
  `secret` varchar(255) NOT NULL,
  `degreed_company_id` varchar(255) NOT NULL,
  `enterprise_customer_id` char(32) NOT NULL,
  `transmission_chunk_size` int(11) NOT NULL,
  `degreed_base_url` varchar(255) NOT NULL,
  `degreed_user_id` varchar(255) NOT NULL,
  `degreed_user_password` varchar(255) NOT NULL,
  `provider_id` varchar(100) NOT NULL,
  `channel_worker_username` varchar(255) DEFAULT NULL,
  `catalogs_to_transmit` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `enterprise_customer_id` (`enterprise_customer_id`),
  CONSTRAINT `degreed_degreedenter_enterprise_customer__86f16a0d_fk_enterpris` FOREIGN KEY (`enterprise_customer_id`) REFERENCES `enterprise_enterprisecustomer` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `degreed_degreedenterprisecustomerconfiguration`
--

LOCK TABLES `degreed_degreedenterprisecustomerconfiguration` WRITE;
/*!40000 ALTER TABLE `degreed_degreedenterprisecustomerconfiguration` DISABLE KEYS */;
/*!40000 ALTER TABLE `degreed_degreedenterprisecustomerconfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `degreed_degreedglobalconfiguration`
--

DROP TABLE IF EXISTS `degreed_degreedglobalconfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `degreed_degreedglobalconfiguration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `completion_status_api_path` varchar(255) NOT NULL,
  `course_api_path` varchar(255) NOT NULL,
  `oauth_api_path` varchar(255) NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `degreed_degreedgloba_changed_by_id_00a8a7be_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `degreed_degreedgloba_changed_by_id_00a8a7be_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `degreed_degreedglobalconfiguration`
--

LOCK TABLES `degreed_degreedglobalconfiguration` WRITE;
/*!40000 ALTER TABLE `degreed_degreedglobalconfiguration` DISABLE KEYS */;
/*!40000 ALTER TABLE `degreed_degreedglobalconfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `degreed_degreedlearnerdatatransmissionaudit`
--

DROP TABLE IF EXISTS `degreed_degreedlearnerdatatransmissionaudit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `degreed_degreedlearnerdatatransmissionaudit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `degreed_user_email` varchar(255) NOT NULL,
  `enterprise_course_enrollment_id` int(10) unsigned NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `course_completed` tinyint(1) NOT NULL,
  `completed_timestamp` varchar(10) NOT NULL,
  `status` varchar(100) NOT NULL,
  `error_message` longtext NOT NULL,
  `created` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `degreed_degreedlearnerdatat_enterprise_course_enrollmen_2b4fe278` (`enterprise_course_enrollment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `degreed_degreedlearnerdatatransmissionaudit`
--

LOCK TABLES `degreed_degreedlearnerdatatransmissionaudit` WRITE;
/*!40000 ALTER TABLE `degreed_degreedlearnerdatatransmissionaudit` DISABLE KEYS */;
/*!40000 ALTER TABLE `degreed_degreedlearnerdatatransmissionaudit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `degreed_historicaldegreedenterprisecustomerconfiguration`
--

DROP TABLE IF EXISTS `degreed_historicaldegreedenterprisecustomerconfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `degreed_historicaldegreedenterprisecustomerconfiguration` (
  `id` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `key` varchar(255) NOT NULL,
  `secret` varchar(255) NOT NULL,
  `degreed_company_id` varchar(255) NOT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `enterprise_customer_id` char(32) DEFAULT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  `transmission_chunk_size` int(11) NOT NULL,
  `degreed_base_url` varchar(255) NOT NULL,
  `degreed_user_id` varchar(255) NOT NULL,
  `degreed_user_password` varchar(255) NOT NULL,
  `provider_id` varchar(100) NOT NULL,
  `channel_worker_username` varchar(255) DEFAULT NULL,
  `catalogs_to_transmit` longtext,
  PRIMARY KEY (`history_id`),
  KEY `degreed_historicalde_history_user_id_5b4776d8_fk_auth_user` (`history_user_id`),
  KEY `degreed_historicaldegreeden_id_756f1445` (`id`),
  KEY `degreed_historicaldegreeden_enterprise_customer_id_12129e6f` (`enterprise_customer_id`),
  CONSTRAINT `degreed_historicalde_history_user_id_5b4776d8_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `degreed_historicaldegreedenterprisecustomerconfiguration`
--

LOCK TABLES `degreed_historicaldegreedenterprisecustomerconfiguration` WRITE;
/*!40000 ALTER TABLE `degreed_historicaldegreedenterprisecustomerconfiguration` DISABLE KEYS */;
/*!40000 ALTER TABLE `degreed_historicaldegreedenterprisecustomerconfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `demographics_historicaluserdemographics`
--

DROP TABLE IF EXISTS `demographics_historicaluserdemographics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `demographics_historicaluserdemographics` (
  `id` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `show_call_to_action` tinyint(1) NOT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `demographics_histori_history_user_id_a05d5af3_fk_auth_user` (`history_user_id`),
  KEY `demographics_historicaluserdemographics_id_7a2d6c8f` (`id`),
  KEY `demographics_historicaluserdemographics_user_id_4fb8f26b` (`user_id`),
  CONSTRAINT `demographics_histori_history_user_id_a05d5af3_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `demographics_historicaluserdemographics`
--

LOCK TABLES `demographics_historicaluserdemographics` WRITE;
/*!40000 ALTER TABLE `demographics_historicaluserdemographics` DISABLE KEYS */;
/*!40000 ALTER TABLE `demographics_historicaluserdemographics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `demographics_userdemographics`
--

DROP TABLE IF EXISTS `demographics_userdemographics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `demographics_userdemographics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `show_call_to_action` tinyint(1) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `demographics_userdemographics_user_id_e435d5d5_uniq` (`user_id`),
  CONSTRAINT `demographics_userdemographics_user_id_e435d5d5_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `demographics_userdemographics`
--

LOCK TABLES `demographics_userdemographics` WRITE;
/*!40000 ALTER TABLE `demographics_userdemographics` DISABLE KEYS */;
/*!40000 ALTER TABLE `demographics_userdemographics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discounts_discountpercentageconfig`
--

DROP TABLE IF EXISTS `discounts_discountpercentageconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `discounts_discountpercentageconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `org` varchar(255) DEFAULT NULL,
  `org_course` varchar(255) DEFAULT NULL,
  `percentage` int(10) unsigned NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  `course_id` varchar(255) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `discounts_d_site_id_f87020_idx` (`site_id`,`org`,`course_id`),
  KEY `discounts_d_site_id_9fe8d6_idx` (`site_id`,`org`,`org_course`,`course_id`),
  KEY `discounts_discountpe_changed_by_id_b00d7aa3_fk_auth_user` (`changed_by_id`),
  KEY `discounts_discountpe_course_id_19913d92_fk_course_ov` (`course_id`),
  KEY `discounts_discountpercentageconfig_org_294e22dd` (`org`),
  KEY `discounts_discountpercentageconfig_org_course_31d0939e` (`org_course`),
  CONSTRAINT `discounts_discountpe_changed_by_id_b00d7aa3_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `discounts_discountpe_course_id_19913d92_fk_course_ov` FOREIGN KEY (`course_id`) REFERENCES `course_overviews_courseoverview` (`id`),
  CONSTRAINT `discounts_discountpe_site_id_b103a2af_fk_django_si` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discounts_discountpercentageconfig`
--

LOCK TABLES `discounts_discountpercentageconfig` WRITE;
/*!40000 ALTER TABLE `discounts_discountpercentageconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `discounts_discountpercentageconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discounts_discountrestrictionconfig`
--

DROP TABLE IF EXISTS `discounts_discountrestrictionconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `discounts_discountrestrictionconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `org` varchar(255) DEFAULT NULL,
  `org_course` varchar(255) DEFAULT NULL,
  `disabled` tinyint(1) DEFAULT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  `course_id` varchar(255) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `discounts_d_site_id_d67da3_idx` (`site_id`,`org`,`course_id`),
  KEY `discounts_d_site_id_f83727_idx` (`site_id`,`org`,`org_course`,`course_id`),
  KEY `discounts_discountre_changed_by_id_f18a5c1b_fk_auth_user` (`changed_by_id`),
  KEY `discounts_discountre_course_id_d7f6674b_fk_course_ov` (`course_id`),
  KEY `discounts_discountrestrictionconfig_org_010f786f` (`org`),
  KEY `discounts_discountrestrictionconfig_org_course_bb36b3cd` (`org_course`),
  CONSTRAINT `discounts_discountre_changed_by_id_f18a5c1b_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `discounts_discountre_course_id_d7f6674b_fk_course_ov` FOREIGN KEY (`course_id`) REFERENCES `course_overviews_courseoverview` (`id`),
  CONSTRAINT `discounts_discountre_site_id_3f4c1be6_fk_django_si` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discounts_discountrestrictionconfig`
--

LOCK TABLES `discounts_discountrestrictionconfig` WRITE;
/*!40000 ALTER TABLE `discounts_discountrestrictionconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `discounts_discountrestrictionconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discussions_discussionsconfiguration`
--

DROP TABLE IF EXISTS `discussions_discussionsconfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `discussions_discussionsconfiguration` (
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `context_key` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `plugin_configuration` longtext NOT NULL,
  `provider_type` varchar(100) NOT NULL,
  `lti_configuration_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`context_key`),
  KEY `discussions_discussi_lti_configuration_id_7088d266_fk_lti_consu` (`lti_configuration_id`),
  CONSTRAINT `discussions_discussi_lti_configuration_id_7088d266_fk_lti_consu` FOREIGN KEY (`lti_configuration_id`) REFERENCES `lti_consumer_lticonfiguration` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discussions_discussionsconfiguration`
--

LOCK TABLES `discussions_discussionsconfiguration` WRITE;
/*!40000 ALTER TABLE `discussions_discussionsconfiguration` DISABLE KEYS */;
/*!40000 ALTER TABLE `discussions_discussionsconfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discussions_historicaldiscussionsconfiguration`
--

DROP TABLE IF EXISTS `discussions_historicaldiscussionsconfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `discussions_historicaldiscussionsconfiguration` (
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `context_key` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `plugin_configuration` longtext NOT NULL,
  `provider_type` varchar(100) NOT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  `lti_configuration_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `discussions_historic_history_user_id_df7ddb62_fk_auth_user` (`history_user_id`),
  KEY `discussions_historicaldiscu_context_key_7c3bca39` (`context_key`),
  KEY `discussions_historicaldiscu_lti_configuration_id_a6693472` (`lti_configuration_id`),
  CONSTRAINT `discussions_historic_history_user_id_df7ddb62_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discussions_historicaldiscussionsconfiguration`
--

LOCK TABLES `discussions_historicaldiscussionsconfiguration` WRITE;
/*!40000 ALTER TABLE `discussions_historicaldiscussionsconfiguration` DISABLE KEYS */;
/*!40000 ALTER TABLE `discussions_historicaldiscussionsconfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discussions_providerfilter`
--

DROP TABLE IF EXISTS `discussions_providerfilter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `discussions_providerfilter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `org` varchar(255) DEFAULT NULL,
  `org_course` varchar(255) DEFAULT NULL,
  `allow` varchar(63) NOT NULL,
  `deny` varchar(63) NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  `course_id` varchar(255) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `discussions_site_id_48e4b2_idx` (`site_id`,`org`,`course_id`),
  KEY `discussions_site_id_0f23d5_idx` (`site_id`,`org`,`org_course`,`course_id`),
  KEY `discussions_provider_changed_by_id_771ce4d3_fk_auth_user` (`changed_by_id`),
  KEY `discussions_provider_course_id_7b7d915c_fk_course_ov` (`course_id`),
  KEY `discussions_providerfilter_org_c5365456` (`org`),
  KEY `discussions_providerfilter_org_course_7b77bd87` (`org_course`),
  CONSTRAINT `discussions_provider_changed_by_id_771ce4d3_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `discussions_provider_course_id_7b7d915c_fk_course_ov` FOREIGN KEY (`course_id`) REFERENCES `course_overviews_courseoverview` (`id`),
  CONSTRAINT `discussions_providerfilter_site_id_9c77a203_fk_django_site_id` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discussions_providerfilter`
--

LOCK TABLES `discussions_providerfilter` WRITE;
/*!40000 ALTER TABLE `discussions_providerfilter` DISABLE KEYS */;
/*!40000 ALTER TABLE `discussions_providerfilter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_celery_results_chordcounter`
--

DROP TABLE IF EXISTS `django_celery_results_chordcounter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_celery_results_chordcounter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` varchar(255) NOT NULL,
  `sub_tasks` longtext NOT NULL,
  `count` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_celery_results_chordcounter`
--

LOCK TABLES `django_celery_results_chordcounter` WRITE;
/*!40000 ALTER TABLE `django_celery_results_chordcounter` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_celery_results_chordcounter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_celery_results_taskresult`
--

DROP TABLE IF EXISTS `django_celery_results_taskresult`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_celery_results_taskresult` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` varchar(255) NOT NULL,
  `status` varchar(50) NOT NULL,
  `content_type` varchar(128) NOT NULL,
  `content_encoding` varchar(64) NOT NULL,
  `result` longtext,
  `date_done` datetime(6) NOT NULL,
  `traceback` longtext,
  `meta` longtext,
  `task_args` longtext,
  `task_kwargs` longtext,
  `task_name` varchar(255) DEFAULT NULL,
  `worker` varchar(100) DEFAULT NULL,
  `date_created` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `task_id` (`task_id`),
  KEY `django_celery_results_taskresult_date_done_49edada6` (`date_done`),
  KEY `django_celery_results_taskresult_status_cbbed23a` (`status`),
  KEY `django_celery_results_taskresult_task_name_90987df3` (`task_name`),
  KEY `django_celery_results_taskresult_worker_f8711389` (`worker`),
  KEY `django_celery_results_taskresult_date_created_099f3424` (`date_created`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_celery_results_taskresult`
--

LOCK TABLES `django_celery_results_taskresult` WRITE;
/*!40000 ALTER TABLE `django_celery_results_taskresult` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_celery_results_taskresult` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_comment_client_permission`
--

DROP TABLE IF EXISTS `django_comment_client_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_comment_client_permission` (
  `name` varchar(30) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_comment_client_permission`
--

LOCK TABLES `django_comment_client_permission` WRITE;
/*!40000 ALTER TABLE `django_comment_client_permission` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_comment_client_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_comment_client_permission_roles`
--

DROP TABLE IF EXISTS `django_comment_client_permission_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_comment_client_permission_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permission_id` varchar(30) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_comment_client_pe_permission_id_role_id_d3680ec3_uniq` (`permission_id`,`role_id`),
  KEY `django_comment_clien_role_id_d2cb08a2_fk_django_co` (`role_id`),
  CONSTRAINT `django_comment_clien_permission_id_f9f47fd2_fk_django_co` FOREIGN KEY (`permission_id`) REFERENCES `django_comment_client_permission` (`name`),
  CONSTRAINT `django_comment_clien_role_id_d2cb08a2_fk_django_co` FOREIGN KEY (`role_id`) REFERENCES `django_comment_client_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_comment_client_permission_roles`
--

LOCK TABLES `django_comment_client_permission_roles` WRITE;
/*!40000 ALTER TABLE `django_comment_client_permission_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_comment_client_permission_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_comment_client_role`
--

DROP TABLE IF EXISTS `django_comment_client_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_comment_client_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_comment_client_role_course_id_08a9c1d1` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_comment_client_role`
--

LOCK TABLES `django_comment_client_role` WRITE;
/*!40000 ALTER TABLE `django_comment_client_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_comment_client_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_comment_client_role_users`
--

DROP TABLE IF EXISTS `django_comment_client_role_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_comment_client_role_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_comment_client_role_users_role_id_user_id_93ab4289_uniq` (`role_id`,`user_id`),
  KEY `dcc_role_users_user_role_idx` (`user_id`,`role_id`),
  CONSTRAINT `django_comment_clien_role_id_baec77f6_fk_django_co` FOREIGN KEY (`role_id`) REFERENCES `django_comment_client_role` (`id`),
  CONSTRAINT `django_comment_clien_user_id_5d7991df_fk_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_comment_client_role_users`
--

LOCK TABLES `django_comment_client_role_users` WRITE;
/*!40000 ALTER TABLE `django_comment_client_role_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_comment_client_role_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_comment_common_coursediscussionsettings`
--

DROP TABLE IF EXISTS `django_comment_common_coursediscussionsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_comment_common_coursediscussionsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` varchar(255) NOT NULL,
  `always_divide_inline_discussions` tinyint(1) NOT NULL,
  `divided_discussions` longtext,
  `division_scheme` varchar(20) NOT NULL,
  `discussions_id_map` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `course_id` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_comment_common_coursediscussionsettings`
--

LOCK TABLES `django_comment_common_coursediscussionsettings` WRITE;
/*!40000 ALTER TABLE `django_comment_common_coursediscussionsettings` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_comment_common_coursediscussionsettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_comment_common_discussionsidmapping`
--

DROP TABLE IF EXISTS `django_comment_common_discussionsidmapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_comment_common_discussionsidmapping` (
  `course_id` varchar(255) NOT NULL,
  `mapping` longtext NOT NULL,
  PRIMARY KEY (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_comment_common_discussionsidmapping`
--

LOCK TABLES `django_comment_common_discussionsidmapping` WRITE;
/*!40000 ALTER TABLE `django_comment_common_discussionsidmapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_comment_common_discussionsidmapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_comment_common_forumsconfig`
--

DROP TABLE IF EXISTS `django_comment_common_forumsconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_comment_common_forumsconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `connection_timeout` double NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `django_comment_commo_changed_by_id_9292e296_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `django_comment_commo_changed_by_id_9292e296_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_comment_common_forumsconfig`
--

LOCK TABLES `django_comment_common_forumsconfig` WRITE;
/*!40000 ALTER TABLE `django_comment_common_forumsconfig` DISABLE KEYS */;
INSERT INTO `django_comment_common_forumsconfig` VALUES (1,'2021-03-24 08:06:01.827601',1,5,NULL);
/*!40000 ALTER TABLE `django_comment_common_forumsconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=412 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (140,'admin','logentry'),(362,'announcements','announcement'),(255,'api_admin','apiaccessconfig'),(1,'api_admin','apiaccessrequest'),(256,'api_admin','catalog'),(195,'assessment','assessment'),(196,'assessment','assessmentfeedback'),(197,'assessment','assessmentfeedbackoption'),(198,'assessment','assessmentpart'),(199,'assessment','criterion'),(200,'assessment','criterionoption'),(208,'assessment','historicalsharedfileupload'),(201,'assessment','peerworkflow'),(202,'assessment','peerworkflowitem'),(203,'assessment','rubric'),(209,'assessment','sharedfileupload'),(207,'assessment','staffworkflow'),(204,'assessment','studenttrainingworkflow'),(205,'assessment','studenttrainingworkflowitem'),(210,'assessment','teamstaffworkflow'),(206,'assessment','trainingexample'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(259,'badges','badgeassertion'),(260,'badges','badgeclass'),(261,'badges','coursecompleteimageconfiguration'),(262,'badges','courseeventbadgesconfiguration'),(352,'blackboard','blackboardenterprisecustomerconfiguration'),(354,'blackboard','blackboardlearnerassessmentdatatransmissionaudit'),(353,'blackboard','blackboardlearnerdatatransmissionaudit'),(351,'blackboard','historicalblackboardenterprisecustomerconfiguration'),(229,'block_structure','blockstructureconfiguration'),(230,'block_structure','blockstructuremodel'),(363,'bookmarks','bookmark'),(364,'bookmarks','xblockcache'),(111,'branding','brandingapiconfig'),(112,'branding','brandinginfoconfig'),(107,'bulk_email','bulkemailflag'),(109,'bulk_email','cohorttarget'),(103,'bulk_email','courseauthorization'),(104,'bulk_email','courseemail'),(105,'bulk_email','courseemailtemplate'),(110,'bulk_email','coursemodetarget'),(106,'bulk_email','optout'),(108,'bulk_email','target'),(405,'bulk_grades','scoreoverrider'),(268,'calendar_sync','historicalusercalendarsyncconfig'),(269,'calendar_sync','usercalendarsyncconfig'),(356,'canvas','canvasenterprisecustomerconfiguration'),(358,'canvas','canvaslearnerassessmentdatatransmissionaudit'),(357,'canvas','canvaslearnerdatatransmissionaudit'),(355,'canvas','historicalcanvasenterprisecustomerconfiguration'),(247,'catalog','catalogintegration'),(264,'celery_utils','failedtask'),(94,'certificates','allowlistgenerationconfiguration'),(81,'certificates','certificategenerationconfiguration'),(82,'certificates','certificategenerationcoursesetting'),(90,'certificates','certificategenerationhistory'),(83,'certificates','certificatehtmlviewconfiguration'),(91,'certificates','certificateinvalidation'),(84,'certificates','certificatetemplate'),(85,'certificates','certificatetemplateasset'),(86,'certificates','certificatewhitelist'),(87,'certificates','examplecertificate'),(88,'certificates','examplecertificateset'),(89,'certificates','generatedcertificate'),(93,'certificates','historicalcertificateinvalidation'),(92,'certificates','historicalgeneratedcertificate'),(232,'commerce','commerceconfiguration'),(404,'completion','blockcompletion'),(333,'consent','datasharingconsent'),(335,'consent','datasharingconsenttextoverrides'),(334,'consent','historicaldatasharingconsent'),(19,'contentserver','cdnuseragentsconfig'),(18,'contentserver','courseassetcachettlconfig'),(406,'contentstore','videouploadconfig'),(5,'contenttypes','contenttype'),(365,'content_libraries','contentlibrary'),(366,'content_libraries','contentlibrarypermission'),(271,'content_type_gating','contenttypegatingconfig'),(345,'cornerstone','cornerstoneenterprisecustomerconfiguration'),(346,'cornerstone','cornerstoneglobalconfiguration'),(347,'cornerstone','cornerstonelearnerdatatransmissionaudit'),(348,'cornerstone','historicalcornerstoneenterprisecustomerconfiguration'),(231,'cors_csrf','xdomainproxyconfiguration'),(42,'courseware','coursedynamicupgradedeadlineconfiguration'),(43,'courseware','dynamicupgradedeadlineconfiguration'),(34,'courseware','offlinecomputedgrade'),(35,'courseware','offlinecomputedgradelog'),(44,'courseware','orgdynamicupgradedeadlineconfiguration'),(36,'courseware','studentfieldoverride'),(37,'courseware','studentmodule'),(38,'courseware','studentmodulehistory'),(39,'courseware','xmodulestudentinfofield'),(40,'courseware','xmodulestudentprefsfield'),(41,'courseware','xmoduleuserstatesummaryfield'),(45,'coursewarehistoryextended','studentmodulehistoryextended'),(177,'course_action_state','coursererunstate'),(407,'course_creators','coursecreator'),(277,'course_date_signals','selfpacedrelativedatesconfig'),(270,'course_duration_limits','coursedurationlimitconfig'),(267,'course_goals','coursegoal'),(97,'course_groups','cohortmembership'),(98,'course_groups','coursecohort'),(99,'course_groups','coursecohortssettings'),(100,'course_groups','courseusergroup'),(101,'course_groups','courseusergrouppartitiongroup'),(102,'course_groups','unregisteredlearnercohortassignments'),(154,'course_modes','coursemode'),(156,'course_modes','coursemodeexpirationconfig'),(155,'course_modes','coursemodesarchive'),(157,'course_modes','historicalcoursemode'),(223,'course_overviews','courseoverview'),(226,'course_overviews','courseoverviewimageconfig'),(225,'course_overviews','courseoverviewimageset'),(224,'course_overviews','courseoverviewtab'),(227,'course_overviews','historicalcourseoverview'),(228,'course_overviews','simulatecoursepublishconfig'),(265,'crawlers','crawlersconfig'),(367,'credentials','credentialsapiconfig'),(368,'credentials','notifycredentialsconfig'),(239,'credit','creditconfig'),(233,'credit','creditcourse'),(234,'credit','crediteligibility'),(235,'credit','creditprovider'),(236,'credit','creditrequest'),(237,'credit','creditrequirement'),(238,'credit','creditrequirementstatus'),(168,'dark_lang','darklangconfig'),(338,'degreed','degreedenterprisecustomerconfiguration'),(339,'degreed','degreedglobalconfiguration'),(340,'degreed','degreedlearnerdatatransmissionaudit'),(341,'degreed','historicaldegreedenterprisecustomerconfiguration'),(283,'demographics','historicaluserdemographics'),(282,'demographics','userdemographics'),(273,'discounts','discountpercentageconfig'),(272,'discounts','discountrestrictionconfig'),(370,'discussions','discussionsconfiguration'),(369,'discussions','historicaldiscussionsconfiguration'),(371,'discussions','providerfilter'),(10,'django_celery_results','chordcounter'),(9,'django_celery_results','taskresult'),(144,'django_comment_common','coursediscussionsettings'),(145,'django_comment_common','discussionsidmapping'),(143,'django_comment_common','forumsconfig'),(141,'django_comment_common','permission'),(142,'django_comment_common','role'),(136,'django_notify','notification'),(137,'django_notify','notificationtype'),(138,'django_notify','settings'),(139,'django_notify','subscription'),(218,'edxval','coursevideo'),(217,'edxval','encodedvideo'),(215,'edxval','profile'),(222,'edxval','thirdpartytranscriptcredentialsstate'),(220,'edxval','transcriptpreference'),(216,'edxval','video'),(219,'edxval','videoimage'),(221,'edxval','videotranscript'),(394,'edx_proctoring','proctoredexam'),(395,'edx_proctoring','proctoredexamreviewpolicy'),(396,'edx_proctoring','proctoredexamreviewpolicyhistory'),(397,'edx_proctoring','proctoredexamsoftwaresecurecomment'),(398,'edx_proctoring','proctoredexamsoftwaresecurereview'),(399,'edx_proctoring','proctoredexamsoftwaresecurereviewhistory'),(400,'edx_proctoring','proctoredexamstudentallowance'),(401,'edx_proctoring','proctoredexamstudentallowancehistory'),(402,'edx_proctoring','proctoredexamstudentattempt'),(403,'edx_proctoring','proctoredexamstudentattempthistory'),(391,'edx_when','contentdate'),(392,'edx_when','datepolicy'),(393,'edx_when','userdate'),(263,'email_marketing','emailmarketingconfiguration'),(170,'embargo','country'),(171,'embargo','countryaccessrule'),(172,'embargo','courseaccessrulehistory'),(173,'embargo','embargoedcourse'),(174,'embargo','embargoedstate'),(175,'embargo','ipfilter'),(176,'embargo','restrictedcourse'),(303,'enterprise','enrollmentnotificationemailtemplate'),(331,'enterprise','enterpriseanalyticsuser'),(304,'enterprise','enterprisecatalogquery'),(305,'enterprise','enterprisecourseenrollment'),(306,'enterprise','enterprisecustomer'),(307,'enterprise','enterprisecustomerbrandingconfiguration'),(308,'enterprise','enterprisecustomercatalog'),(309,'enterprise','enterprisecustomeridentityprovider'),(310,'enterprise','enterprisecustomerreportingconfiguration'),(311,'enterprise','enterprisecustomertype'),(312,'enterprise','enterprisecustomeruser'),(313,'enterprise','enterpriseenrollmentsource'),(314,'enterprise','enterprisefeaturerole'),(315,'enterprise','enterprisefeatureuserroleassignment'),(316,'enterprise','historicalenrollmentnotificationemailtemplate'),(330,'enterprise','historicalenterpriseanalyticsuser'),(317,'enterprise','historicalenterprisecourseenrollment'),(318,'enterprise','historicalenterprisecustomer'),(319,'enterprise','historicalenterprisecustomercatalog'),(327,'enterprise','historicallicensedenterprisecourseenrollment'),(320,'enterprise','historicalpendingenrollment'),(328,'enterprise','historicalpendingenterprisecustomeradminuser'),(321,'enterprise','historicalpendingenterprisecustomeruser'),(326,'enterprise','licensedenterprisecourseenrollment'),(322,'enterprise','pendingenrollment'),(329,'enterprise','pendingenterprisecustomeradminuser'),(323,'enterprise','pendingenterprisecustomeruser'),(324,'enterprise','systemwideenterpriserole'),(325,'enterprise','systemwideenterpriseuserroleassignment'),(332,'enterprise','updateroleassignmentswithcustomersconfig'),(158,'entitlements','courseentitlement'),(159,'entitlements','courseentitlementpolicy'),(160,'entitlements','courseentitlementsupportdetail'),(161,'entitlements','historicalcourseentitlement'),(162,'entitlements','historicalcourseentitlementsupportdetail'),(296,'event_routing_backends','routerconfiguration'),(274,'experiments','experimentdata'),(275,'experiments','experimentkeyvalue'),(276,'experiments','historicalexperimentkeyvalue'),(278,'external_user_ids','externalid'),(279,'external_user_ids','externalidtype'),(280,'external_user_ids','historicalexternalid'),(281,'external_user_ids','historicalexternalidtype'),(377,'grades','computegradessetting'),(374,'grades','coursepersistentgradesflag'),(379,'grades','historicalpersistentsubsectiongradeoverride'),(376,'grades','persistentcoursegrade'),(375,'grades','persistentgradesenabledflag'),(372,'grades','persistentsubsectiongrade'),(378,'grades','persistentsubsectiongradeoverride'),(373,'grades','visibleblocks'),(96,'instructor_task','gradereportsetting'),(95,'instructor_task','instructortask'),(337,'integrated_channel','contentmetadataitemtransmission'),(336,'integrated_channel','learnerdatatransmissionaudit'),(295,'learning_sequences','contenterror'),(292,'learning_sequences','coursecontext'),(288,'learning_sequences','coursesection'),(289,'learning_sequences','coursesectionsequence'),(293,'learning_sequences','coursesequenceexam'),(290,'learning_sequences','learningcontext'),(291,'learning_sequences','learningsequence'),(294,'learning_sequences','publishreport'),(188,'lms_xblock','xblockasidesconfig'),(388,'lti_consumer','ltiagslineitem'),(389,'lti_consumer','ltiagsscore'),(387,'lti_consumer','lticonfiguration'),(390,'lti_consumer','ltidlcontentitem'),(250,'milestones','coursecontentmilestone'),(251,'milestones','coursemilestone'),(252,'milestones','milestone'),(253,'milestones','milestonerelationshiptype'),(254,'milestones','usermilestone'),(179,'mobile_api','appversionconfig'),(180,'mobile_api','ignoremobileavailableflagconfig'),(178,'mobile_api','mobileapiconfig'),(360,'moodle','historicalmoodleenterprisecustomerconfiguration'),(359,'moodle','moodleenterprisecustomerconfiguration'),(361,'moodle','moodlelearnerdatatransmissionaudit'),(114,'oauth2_provider','accesstoken'),(113,'oauth2_provider','application'),(115,'oauth2_provider','grant'),(116,'oauth2_provider','refreshtoken'),(118,'oauth_dispatch','applicationaccess'),(119,'oauth_dispatch','applicationorganization'),(117,'oauth_dispatch','restrictedapplication'),(299,'organizations','historicalorganization'),(300,'organizations','historicalorganizationcourse'),(297,'organizations','organization'),(298,'organizations','organizationcourse'),(246,'programs','customprogramsconfig'),(245,'programs','programsapiconfig'),(384,'program_enrollments','courseaccessroleassignment'),(382,'program_enrollments','historicalprogramcourseenrollment'),(380,'program_enrollments','historicalprogramenrollment'),(383,'program_enrollments','programcourseenrollment'),(381,'program_enrollments','programenrollment'),(6,'redirects','redirect'),(169,'rss_proxy','whitelistedrssurl'),(344,'sap_success_factors','sapsuccessfactorsenterprisecustomerconfiguration'),(343,'sap_success_factors','sapsuccessfactorsglobalconfiguration'),(342,'sap_success_factors','sapsuccessfactorslearnerdatatransmissionaudit'),(287,'schedules','historicalschedule'),(284,'schedules','schedule'),(285,'schedules','scheduleconfig'),(286,'schedules','scheduleexperience'),(248,'self_paced','selfpacedconfiguration'),(7,'sessions','session'),(8,'sites','site'),(20,'site_configuration','siteconfiguration'),(21,'site_configuration','siteconfigurationhistory'),(181,'social_django','association'),(182,'social_django','code'),(183,'social_django','nonce'),(185,'social_django','partial'),(184,'social_django','usersocialauth'),(146,'splash','splashconfig'),(16,'static_replace','assetbaseurlconfig'),(17,'static_replace','assetexcludedextensionsconfig'),(14,'status','coursemessage'),(15,'status','globalstatusmessage'),(68,'student','accountrecovery'),(75,'student','accountrecoveryconfiguration'),(73,'student','allowedauthuser'),(46,'student','anonymoususerid'),(77,'student','bulkchangeenrollmentconfiguration'),(71,'student','bulkunenrollconfiguration'),(47,'student','courseaccessrole'),(48,'student','courseenrollment'),(49,'student','courseenrollmentallowed'),(50,'student','courseenrollmentattribute'),(76,'student','courseenrollmentcelebration'),(51,'student','dashboardconfiguration'),(52,'student','enrollmentrefundconfiguration'),(53,'student','entranceexamconfiguration'),(72,'student','fbeenrollmentexclusion'),(70,'student','historicalcourseenrollment'),(74,'student','historicalmanualenrollmentaudit'),(54,'student','languageproficiency'),(55,'student','linkedinaddtoprofileconfiguration'),(56,'student','loginfailures'),(57,'student','manualenrollmentaudit'),(58,'student','pendingemailchange'),(59,'student','pendingnamechange'),(69,'student','pendingsecondaryemailchange'),(60,'student','registration'),(66,'student','registrationcookieconfiguration'),(67,'student','sociallink'),(65,'student','userattribute'),(79,'student','usercelebration'),(78,'student','userpasswordtogglehistory'),(61,'student','userprofile'),(62,'student','usersignupsource'),(63,'student','userstanding'),(64,'student','usertestgroup'),(189,'submissions','score'),(193,'submissions','scoreannotation'),(192,'submissions','scoresummary'),(190,'submissions','studentitem'),(191,'submissions','submission'),(194,'submissions','teamsubmission'),(386,'super_csv','csvoperation'),(186,'survey','surveyanswer'),(187,'survey','surveyform'),(125,'system_wide_roles','systemwiderole'),(126,'system_wide_roles','systemwideroleassignment'),(410,'tagging','tagavailablevalues'),(411,'tagging','tagcategories'),(240,'teams','courseteam'),(241,'teams','courseteammembership'),(385,'theming','sitetheme'),(123,'third_party_auth','ltiproviderconfig'),(122,'third_party_auth','oauth2providerconfig'),(121,'third_party_auth','samlconfiguration'),(124,'third_party_auth','samlproviderconfig'),(120,'third_party_auth','samlproviderdata'),(249,'thumbnail','kvstore'),(150,'user_api','retirementstate'),(147,'user_api','usercoursetag'),(148,'user_api','userorgtag'),(149,'user_api','userpreference'),(153,'user_api','userretirementpartnerreportingstatus'),(152,'user_api','userretirementrequest'),(151,'user_api','userretirementstatus'),(301,'user_tasks','usertaskartifact'),(302,'user_tasks','usertaskstatus'),(80,'util','ratelimitconfiguration'),(258,'verified_track_content','migrateverifiedtrackcohortssetting'),(257,'verified_track_content','verifiedtrackcohortedcourse'),(166,'verify_student','manualverification'),(163,'verify_student','softwaresecurephotoverification'),(165,'verify_student','ssoverification'),(167,'verify_student','sspverificationretryconfig'),(164,'verify_student','verificationdeadline'),(22,'video_config','coursehlsplaybackenabledflag'),(24,'video_config','coursevideotranscriptenabledflag'),(30,'video_config','courseyoutubeblockedflag'),(23,'video_config','hlsplaybackenabledflag'),(27,'video_config','migrationenqueuedcourse'),(26,'video_config','transcriptmigrationsetting'),(28,'video_config','updatedcoursevideos'),(29,'video_config','videothumbnailsetting'),(25,'video_config','videotranscriptenabledflag'),(31,'video_pipeline','coursevideouploadsenabledbydefault'),(33,'video_pipeline','vempipelineintegration'),(32,'video_pipeline','videouploadsenabledbydefault'),(11,'waffle','flag'),(12,'waffle','sample'),(13,'waffle','switch'),(266,'waffle_utils','waffleflagcourseoverridemodel'),(127,'wiki','article'),(128,'wiki','articleforobject'),(129,'wiki','articleplugin'),(130,'wiki','articlerevision'),(131,'wiki','reusableplugin'),(132,'wiki','revisionplugin'),(133,'wiki','revisionpluginrevision'),(134,'wiki','simpleplugin'),(135,'wiki','urlpath'),(211,'workflow','assessmentworkflow'),(212,'workflow','assessmentworkflowcancellation'),(213,'workflow','assessmentworkflowstep'),(214,'workflow','teamassessmentworkflow'),(350,'xapi','xapilearnerdatatransmissionaudit'),(349,'xapi','xapilrsconfiguration'),(409,'xblock_config','courseeditltifieldsenabledflag'),(408,'xblock_config','studioconfig'),(242,'xblock_django','xblockconfiguration'),(243,'xblock_django','xblockstudioconfiguration'),(244,'xblock_django','xblockstudioconfigurationflag');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=815 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2021-03-24 08:05:15.618549'),(2,'auth','0001_initial','2021-03-24 08:05:15.691422'),(3,'admin','0001_initial','2021-03-24 08:05:15.824231'),(4,'admin','0002_logentry_remove_auto_add','2021-03-24 08:05:15.856693'),(5,'admin','0003_logentry_add_action_flag_choices','2021-03-24 08:05:15.871003'),(6,'announcements','0001_initial','2021-03-24 08:05:15.881777'),(7,'sites','0001_initial','2021-03-24 08:05:15.893202'),(8,'contenttypes','0002_remove_content_type_name','2021-03-24 08:05:15.934540'),(9,'api_admin','0001_initial','2021-03-24 08:05:15.977691'),(10,'api_admin','0002_auto_20160325_1604','2021-03-24 08:05:16.036656'),(11,'api_admin','0003_auto_20160404_1618','2021-03-24 08:05:16.178502'),(12,'api_admin','0004_auto_20160412_1506','2021-03-24 08:05:16.286965'),(13,'api_admin','0005_auto_20160414_1232','2021-03-24 08:05:16.336600'),(14,'api_admin','0006_catalog','2021-03-24 08:05:16.342935'),(15,'api_admin','0007_delete_historical_api_records','2021-03-24 08:05:16.433407'),(16,'assessment','0001_initial','2021-03-24 08:05:16.834790'),(17,'assessment','0002_staffworkflow','2021-03-24 08:05:17.145543'),(18,'assessment','0003_expand_course_id','2021-03-24 08:05:17.202022'),(19,'assessment','0004_historicalsharedfileupload_sharedfileupload','2021-03-24 08:05:17.240964'),(20,'assessment','0005_add_filename_to_sharedupload','2021-03-24 08:05:17.356404'),(21,'assessment','0006_TeamWorkflows','2021-03-24 08:05:17.374406'),(22,'auth','0002_alter_permission_name_max_length','2021-03-24 08:05:17.396841'),(23,'auth','0003_alter_user_email_max_length','2021-03-24 08:05:17.410799'),(24,'auth','0004_alter_user_username_opts','2021-03-24 08:05:17.421571'),(25,'auth','0005_alter_user_last_login_null','2021-03-24 08:05:17.440828'),(26,'auth','0006_require_contenttypes_0002','2021-03-24 08:05:17.442724'),(27,'auth','0007_alter_validators_add_error_messages','2021-03-24 08:05:17.453162'),(28,'auth','0008_alter_user_username_max_length','2021-03-24 08:05:17.467965'),(29,'auth','0009_alter_user_last_name_max_length','2021-03-24 08:05:17.480758'),(30,'auth','0010_alter_group_name_max_length','2021-03-24 08:05:17.493849'),(31,'auth','0011_update_proxy_permissions','2021-03-24 08:05:17.523541'),(32,'instructor_task','0001_initial','2021-03-24 08:05:17.543483'),(33,'certificates','0001_initial','2021-03-24 08:05:17.852932'),(34,'certificates','0002_data__certificatehtmlviewconfiguration_data','2021-03-24 08:05:18.010907'),(35,'certificates','0003_data__default_modes','2021-03-24 08:05:18.062522'),(36,'certificates','0004_certificategenerationhistory','2021-03-24 08:05:18.090731'),(37,'certificates','0005_auto_20151208_0801','2021-03-24 08:05:18.132798'),(38,'certificates','0006_certificatetemplateasset_asset_slug','2021-03-24 08:05:18.150990'),(39,'certificates','0007_certificateinvalidation','2021-03-24 08:05:18.177447'),(40,'badges','0001_initial','2021-03-24 08:05:18.564952'),(41,'badges','0002_data__migrate_assertions','2021-03-24 08:05:18.646238'),(42,'badges','0003_schema__add_event_configuration','2021-03-24 08:05:18.680107'),(43,'waffle','0001_initial','2021-03-24 08:05:18.765148'),(44,'sites','0002_alter_domain_unique','2021-03-24 08:05:18.852398'),(45,'enterprise','0001_initial','2021-03-24 08:05:20.542395'),(46,'enterprise','0002_enterprisecustomerbrandingconfiguration','2021-03-24 08:05:20.544505'),(47,'enterprise','0003_auto_20161104_0937','2021-03-24 08:05:20.546883'),(48,'enterprise','0004_auto_20161114_0434','2021-03-24 08:05:20.548818'),(49,'enterprise','0005_pendingenterprisecustomeruser','2021-03-24 08:05:20.551138'),(50,'enterprise','0006_auto_20161121_0241','2021-03-24 08:05:20.553441'),(51,'enterprise','0007_auto_20161109_1511','2021-03-24 08:05:20.555465'),(52,'enterprise','0008_auto_20161124_2355','2021-03-24 08:05:20.557742'),(53,'enterprise','0009_auto_20161130_1651','2021-03-24 08:05:20.559702'),(54,'enterprise','0010_auto_20161222_1212','2021-03-24 08:05:20.562272'),(55,'enterprise','0011_enterprisecustomerentitlement_historicalenterprisecustomerentitlement','2021-03-24 08:05:20.564512'),(56,'enterprise','0012_auto_20170125_1033','2021-03-24 08:05:20.566782'),(57,'enterprise','0013_auto_20170125_1157','2021-03-24 08:05:20.568716'),(58,'enterprise','0014_enrollmentnotificationemailtemplate_historicalenrollmentnotificationemailtemplate','2021-03-24 08:05:20.571110'),(59,'enterprise','0015_auto_20170130_0003','2021-03-24 08:05:20.573663'),(60,'enterprise','0016_auto_20170405_0647','2021-03-24 08:05:20.575676'),(61,'enterprise','0017_auto_20170508_1341','2021-03-24 08:05:20.578021'),(62,'enterprise','0018_auto_20170511_1357','2021-03-24 08:05:20.580191'),(63,'enterprise','0019_auto_20170606_1853','2021-03-24 08:05:20.582485'),(64,'enterprise','0020_auto_20170624_2316','2021-03-24 08:05:20.584509'),(65,'enterprise','0021_auto_20170711_0712','2021-03-24 08:05:20.586855'),(66,'enterprise','0022_auto_20170720_1543','2021-03-24 08:05:20.588862'),(67,'enterprise','0023_audit_data_reporting_flag','2021-03-24 08:05:20.592242'),(68,'enterprise','0024_enterprisecustomercatalog_historicalenterprisecustomercatalog','2021-03-24 08:05:20.594685'),(69,'enterprise','0025_auto_20170828_1412','2021-03-24 08:05:20.597045'),(70,'enterprise','0026_make_require_account_level_consent_nullable','2021-03-24 08:05:20.599411'),(71,'enterprise','0027_remove_account_level_consent','2021-03-24 08:05:20.601903'),(72,'enterprise','0028_link_enterprise_to_enrollment_template','2021-03-24 08:05:20.604000'),(73,'enterprise','0029_auto_20170925_1909','2021-03-24 08:05:20.606369'),(74,'enterprise','0030_auto_20171005_1600','2021-03-24 08:05:20.608391'),(75,'enterprise','0031_auto_20171012_1249','2021-03-24 08:05:20.610835'),(76,'enterprise','0032_reporting_model','2021-03-24 08:05:20.612931'),(77,'enterprise','0033_add_history_change_reason_field','2021-03-24 08:05:20.615319'),(78,'enterprise','0034_auto_20171023_0727','2021-03-24 08:05:20.617849'),(79,'enterprise','0035_auto_20171212_1129','2021-03-24 08:05:20.619994'),(80,'enterprise','0036_sftp_reporting_support','2021-03-24 08:05:20.622560'),(81,'enterprise','0037_auto_20180110_0450','2021-03-24 08:05:20.624557'),(82,'enterprise','0038_auto_20180122_1427','2021-03-24 08:05:20.627225'),(83,'enterprise','0039_auto_20180129_1034','2021-03-24 08:05:20.631880'),(84,'enterprise','0040_auto_20180129_1428','2021-03-24 08:05:20.634211'),(85,'enterprise','0041_auto_20180212_1507','2021-03-24 08:05:20.636140'),(86,'enterprise','0042_replace_sensitive_sso_username','2021-03-24 08:05:20.638499'),(87,'enterprise','0043_auto_20180507_0138','2021-03-24 08:05:20.640327'),(88,'enterprise','0044_reporting_config_multiple_types','2021-03-24 08:05:20.642894'),(89,'enterprise','0045_report_type_json','2021-03-24 08:05:20.644879'),(90,'enterprise','0046_remove_unique_constraints','2021-03-24 08:05:20.647144'),(91,'enterprise','0047_auto_20180517_0457','2021-03-24 08:05:20.649537'),(92,'enterprise','0048_enterprisecustomeruser_active','2021-03-24 08:05:20.651614'),(93,'enterprise','0049_auto_20180531_0321','2021-03-24 08:05:20.653919'),(94,'enterprise','0050_progress_v2','2021-03-24 08:05:20.657154'),(95,'enterprise','0051_add_enterprise_slug','2021-03-24 08:05:20.659856'),(96,'enterprise','0052_create_unique_slugs','2021-03-24 08:05:20.662307'),(97,'enterprise','0053_pendingenrollment_cohort_name','2021-03-24 08:05:20.664969'),(98,'enterprise','0053_auto_20180911_0811','2021-03-24 08:05:20.669356'),(99,'enterprise','0054_merge_20180914_1511','2021-03-24 08:05:20.672862'),(100,'enterprise','0055_auto_20181015_1112','2021-03-24 08:05:20.675498'),(101,'enterprise','0056_enterprisecustomerreportingconfiguration_pgp_encryption_key','2021-03-24 08:05:20.678178'),(102,'enterprise','0057_enterprisecustomerreportingconfiguration_enterprise_customer_catalogs','2021-03-24 08:05:20.680031'),(103,'enterprise','0058_auto_20181212_0145','2021-03-24 08:05:20.682818'),(104,'enterprise','0059_add_code_management_portal_config','2021-03-24 08:05:20.684658'),(105,'enterprise','0060_upgrade_django_simple_history','2021-03-24 08:05:20.687395'),(106,'enterprise','0061_systemwideenterpriserole_systemwideenterpriseuserroleassignment','2021-03-24 08:05:20.690391'),(107,'enterprise','0062_add_system_wide_enterprise_roles','2021-03-24 08:05:20.692571'),(108,'enterprise','0063_systemwideenterpriserole_description','2021-03-24 08:05:20.695591'),(109,'enterprise','0064_enterprisefeaturerole_enterprisefeatureuserroleassignment','2021-03-24 08:05:20.699092'),(110,'enterprise','0065_add_enterprise_feature_roles','2021-03-24 08:05:20.701554'),(111,'enterprise','0066_add_system_wide_enterprise_operator_role','2021-03-24 08:05:20.703686'),(112,'enterprise','0067_add_role_based_access_control_switch','2021-03-24 08:05:20.706293'),(113,'enterprise','0068_remove_role_based_access_control_switch','2021-03-24 08:05:20.708409'),(114,'enterprise','0069_auto_20190613_0607','2021-03-24 08:05:20.711234'),(115,'enterprise','0070_enterprise_catalog_query','2021-03-24 08:05:20.715015'),(116,'enterprise','0071_historicalpendingenrollment_historicalpendingenterprisecustomeruser','2021-03-24 08:05:20.716911'),(117,'enterprise','0072_add_enterprise_report_config_feature_role','2021-03-24 08:05:20.719474'),(118,'enterprise','0073_enterprisecustomerreportingconfiguration_uuid','2021-03-24 08:05:20.722104'),(119,'enterprise','0074_auto_20190904_1143','2021-03-24 08:05:20.724168'),(120,'enterprise','0075_auto_20190916_1030','2021-03-24 08:05:20.726602'),(121,'enterprise','0076_auto_20190918_2037','2021-03-24 08:05:20.728574'),(122,'enterprise','0077_auto_20191002_1529','2021-03-24 08:05:20.730822'),(123,'enterprise','0078_auto_20191107_1536','2021-03-24 08:05:20.732880'),(124,'enterprise','0079_AddEnterpriseEnrollmentSource','2021-03-24 08:05:20.735235'),(125,'enterprise','0080_auto_20191113_1708','2021-03-24 08:05:20.737682'),(126,'enterprise','0081_UpdateEnterpriseEnrollmentSource','2021-03-24 08:05:20.740151'),(127,'enterprise','0082_AddManagementEnterpriseEnrollmentSource','2021-03-24 08:05:20.742985'),(128,'enterprise','0083_enterprisecustomerreportingconfiguration_include_date','2021-03-24 08:05:20.745278'),(129,'enterprise','0084_auto_20200120_1137','2021-03-24 08:05:20.748366'),(130,'enterprise','0085_enterprisecustomeruser_linked','2021-03-24 08:05:20.751077'),(131,'enterprise','0086_auto_20200128_1726','2021-03-24 08:05:20.753085'),(132,'enterprise','0087_auto_20200206_1151','2021-03-24 08:05:20.755709'),(133,'enterprise','0088_auto_20200224_1341','2021-03-24 08:05:20.758012'),(134,'enterprise','0089_auto_20200305_0652','2021-03-24 08:05:20.760083'),(135,'enterprise','0090_update_content_filter','2021-03-24 08:05:20.762904'),(136,'enterprise','0091_add_sales_force_id_in_pendingenrollment','2021-03-24 08:05:20.765316'),(137,'enterprise','0092_auto_20200312_1650','2021-03-24 08:05:20.768284'),(138,'enterprise','0093_add_use_enterprise_catalog_flag','2021-03-24 08:05:21.221635'),(139,'enterprise','0094_add_use_enterprise_catalog_sample','2021-03-24 08:05:21.709445'),(140,'enterprise','0095_auto_20200507_1138','2021-03-24 08:05:21.811457'),(141,'enterprise','0096_enterprise_catalog_admin_role','2021-03-24 08:05:21.913903'),(142,'enterprise','0097_auto_20200619_1130','2021-03-24 08:05:21.988478'),(143,'enterprise','0098_auto_20200629_1756','2021-03-24 08:05:22.088475'),(144,'enterprise','0099_auto_20200702_1537','2021-03-24 08:05:22.181364'),(145,'enterprise','0100_add_licensed_enterprise_course_enrollment','2021-03-24 08:05:22.316326'),(146,'enterprise','0101_move_data_to_saved_for_later','2021-03-24 08:05:22.438665'),(147,'enterprise','0102_auto_20200708_1615','2021-03-24 08:05:22.557899'),(148,'enterprise','0103_remove_marked_done','2021-03-24 08:05:22.653482'),(149,'enterprise','0104_sync_query_field','2021-03-24 08:05:22.756651'),(150,'enterprise','0105_add_branding_config_color_fields','2021-03-24 08:05:22.846595'),(151,'enterprise','0106_move_branding_config_colors','2021-03-24 08:05:22.946932'),(152,'enterprise','0107_remove_branding_config_banner_fields','2021-03-24 08:05:23.019891'),(153,'enterprise','0108_add_licensed_enrollment_is_revoked','2021-03-24 08:05:23.117666'),(154,'enterprise','0109_remove_use_enterprise_catalog_sample','2021-03-24 08:05:23.209470'),(155,'enterprise','0110_add_default_contract_discount','2021-03-24 08:05:23.325543'),(156,'enterprise','0111_pendingenterprisecustomeradminuser','2021-03-24 08:05:23.469131'),(157,'enterprise','0112_auto_20200914_0926','2021-03-24 08:05:23.638917'),(158,'enterprise','0113_auto_20200914_2054','2021-03-24 08:05:23.759796'),(159,'blackboard','0001_initial','2021-03-24 08:05:24.211030'),(160,'blackboard','0002_auto_20200930_1723','2021-03-24 08:05:24.413990'),(161,'blackboard','0003_blackboardlearnerdatatransmissionaudit','2021-03-24 08:05:24.430368'),(162,'blackboard','0004_blackboard_tx_chunk_size_default_1','2021-03-24 08:05:24.522337'),(163,'blackboard','0005_blackboardlearnerassessmentdatatransmissionaudit','2021-03-24 08:05:24.540956'),(164,'block_structure','0001_config','2021-03-24 08:05:24.624993'),(165,'block_structure','0002_blockstructuremodel','2021-03-24 08:05:24.653387'),(166,'block_structure','0003_blockstructuremodel_storage','2021-03-24 08:05:24.664655'),(167,'block_structure','0004_blockstructuremodel_usagekeywithrun','2021-03-24 08:05:24.673599'),(168,'bookmarks','0001_initial','2021-03-24 08:05:24.917850'),(169,'branding','0001_initial','2021-03-24 08:05:25.121708'),(170,'course_modes','0001_initial','2021-03-24 08:05:25.176689'),(171,'course_modes','0002_coursemode_expiration_datetime_is_explicit','2021-03-24 08:05:25.211464'),(172,'course_modes','0003_auto_20151113_1443','2021-03-24 08:05:25.221185'),(173,'course_modes','0004_auto_20151113_1457','2021-03-24 08:05:25.300963'),(174,'course_modes','0005_auto_20151217_0958','2021-03-24 08:05:25.322310'),(175,'course_modes','0006_auto_20160208_1407','2021-03-24 08:05:25.372512'),(176,'course_modes','0007_coursemode_bulk_sku','2021-03-24 08:05:25.397825'),(177,'course_groups','0001_initial','2021-03-24 08:05:25.965574'),(178,'bulk_email','0001_initial','2021-03-24 08:05:26.306193'),(179,'bulk_email','0002_data__load_course_email_template','2021-03-24 08:05:26.831270'),(180,'bulk_email','0003_config_model_feature_flag','2021-03-24 08:05:26.916751'),(181,'bulk_email','0004_add_email_targets','2021-03-24 08:05:27.187027'),(182,'bulk_email','0005_move_target_data','2021-03-24 08:05:27.350644'),(183,'bulk_email','0006_course_mode_targets','2021-03-24 08:05:27.451954'),(184,'courseware','0001_initial','2021-03-24 08:05:28.410332'),(185,'bulk_grades','0001_initial','2021-03-24 08:05:28.680836'),(186,'bulk_grades','0002_auto_20190703_1526','2021-03-24 08:05:28.802704'),(187,'calendar_sync','0001_initial','2021-03-24 08:05:29.413296'),(188,'calendar_sync','0002_auto_20200709_1743','2021-03-24 08:05:29.609719'),(189,'canvas','0001_initial','2021-03-24 08:05:29.922865'),(190,'canvas','0002_auto_20200806_1632','2021-03-24 08:05:30.095802'),(191,'canvas','0003_delete_canvasglobalconfiguration','2021-03-24 08:05:30.106949'),(192,'canvas','0004_adding_learner_data_to_canvas','2021-03-24 08:05:30.126302'),(193,'canvas','0005_auto_20200909_1534','2021-03-24 08:05:30.152014'),(194,'canvas','0006_canvaslearnerassessmentdatatransmissionaudit','2021-03-24 08:05:30.174697'),(195,'canvas','0007_auto_20210222_2225','2021-03-24 08:05:30.312934'),(196,'catalog','0001_initial','2021-03-24 08:05:30.410921'),(197,'catalog','0002_catalogintegration_username','2021-03-24 08:05:30.509238'),(198,'catalog','0003_catalogintegration_page_size','2021-03-24 08:05:30.587575'),(199,'catalog','0004_auto_20170616_0618','2021-03-24 08:05:30.658638'),(200,'catalog','0005_catalogintegration_long_term_cache_ttl','2021-03-24 08:05:30.736228'),(201,'celery_utils','0001_initial','2021-03-24 08:05:30.773440'),(202,'celery_utils','0002_chordable_django_backend','2021-03-24 08:05:30.783443'),(203,'certificates','0008_schema__remove_badges','2021-03-24 08:05:30.964736'),(204,'certificates','0009_certificategenerationcoursesetting_language_self_generation','2021-03-24 08:05:31.129422'),(205,'certificates','0010_certificatetemplate_language','2021-03-24 08:05:31.150233'),(206,'certificates','0011_certificatetemplate_alter_unique','2021-03-24 08:05:31.289674'),(207,'certificates','0012_certificategenerationcoursesetting_include_hours_of_effort','2021-03-24 08:05:31.308603'),(208,'certificates','0013_remove_certificategenerationcoursesetting_enabled','2021-03-24 08:05:31.331443'),(209,'certificates','0014_change_eligible_certs_manager','2021-03-24 08:05:31.770734'),(210,'certificates','0015_add_masters_choice','2021-03-24 08:05:31.846169'),(211,'certificates','0016_historicalgeneratedcertificate','2021-03-24 08:05:31.949588'),(212,'certificates','0017_add_mode_20201118_1725','2021-03-24 08:05:32.128201'),(213,'certificates','0018_historicalcertificateinvalidation','2021-03-24 08:05:32.228530'),(214,'certificates','0019_allowlistgenerationconfiguration','2021-03-24 08:05:32.350998'),(215,'certificates','0020_remove_existing_mgmt_cmd_args','2021-03-24 08:05:32.491487'),(216,'certificates','0021_remove_certificate_allowlist_duplicate_records','2021-03-24 08:05:32.623703'),(217,'certificates','0022_add_unique_constraints_to_certificatewhitelist_model','2021-03-24 08:05:32.696475'),(218,'user_api','0001_initial','2021-03-24 08:05:33.207420'),(219,'user_api','0002_retirementstate_userretirementstatus','2021-03-24 08:05:33.404280'),(220,'commerce','0001_data__add_ecommerce_service_user','2021-03-24 08:05:33.967415'),(221,'commerce','0002_commerceconfiguration','2021-03-24 08:05:34.080638'),(222,'commerce','0003_auto_20160329_0709','2021-03-24 08:05:34.164164'),(223,'commerce','0004_auto_20160531_0950','2021-03-24 08:05:34.321384'),(224,'commerce','0005_commerceconfiguration_enable_automatic_refund_approval','2021-03-24 08:05:34.419030'),(225,'commerce','0006_auto_20170424_1734','2021-03-24 08:05:34.491923'),(226,'commerce','0007_auto_20180313_0609','2021-03-24 08:05:34.658275'),(227,'commerce','0008_auto_20191024_2048','2021-03-24 08:05:34.792927'),(228,'completion','0001_initial','2021-03-24 08:05:35.049968'),(229,'completion','0002_auto_20180125_1510','2021-03-24 08:05:35.148705'),(230,'completion','0003_learning_context','2021-03-24 08:05:35.450260'),(231,'consent','0001_initial','2021-03-24 08:05:36.096328'),(232,'consent','0002_migrate_to_new_data_sharing_consent','2021-03-24 08:05:36.258998'),(233,'consent','0003_historicaldatasharingconsent_history_change_reason','2021-03-24 08:05:36.359922'),(234,'consent','0004_datasharingconsenttextoverrides','2021-03-24 08:05:36.477036'),(235,'organizations','0001_initial','2021-03-24 08:05:36.636563'),(236,'organizations','0002_auto_20170117_1434','2021-03-24 08:05:36.640074'),(237,'organizations','0003_auto_20170221_1138','2021-03-24 08:05:36.643484'),(238,'organizations','0004_auto_20170413_2315','2021-03-24 08:05:36.646763'),(239,'organizations','0005_auto_20171116_0640','2021-03-24 08:05:36.650162'),(240,'organizations','0006_auto_20171207_0259','2021-03-24 08:05:36.653889'),(241,'organizations','0007_historicalorganization','2021-03-24 08:05:36.657268'),(242,'content_libraries','0001_initial','2021-03-24 08:05:37.148768'),(243,'content_libraries','0002_group_permissions','2021-03-24 08:05:38.207912'),(244,'content_libraries','0003_contentlibrary_type','2021-03-24 08:05:38.250981'),(245,'content_libraries','0004_contentlibrary_license','2021-03-24 08:05:38.279298'),(246,'course_overviews','0001_initial','2021-03-24 08:05:38.335186'),(247,'course_overviews','0002_add_course_catalog_fields','2021-03-24 08:05:38.441943'),(248,'course_overviews','0003_courseoverviewgeneratedhistory','2021-03-24 08:05:38.460379'),(249,'course_overviews','0004_courseoverview_org','2021-03-24 08:05:38.482700'),(250,'course_overviews','0005_delete_courseoverviewgeneratedhistory','2021-03-24 08:05:38.493899'),(251,'course_overviews','0006_courseoverviewimageset','2021-03-24 08:05:38.514783'),(252,'course_overviews','0007_courseoverviewimageconfig','2021-03-24 08:05:38.636153'),(253,'course_overviews','0008_remove_courseoverview_facebook_url','2021-03-24 08:05:38.653833'),(254,'course_overviews','0009_readd_facebook_url','2021-03-24 08:05:38.657462'),(255,'course_overviews','0010_auto_20160329_2317','2021-03-24 08:05:38.704420'),(256,'course_overviews','0011_courseoverview_marketing_url','2021-03-24 08:05:38.747135'),(257,'course_overviews','0012_courseoverview_eligible_for_financial_aid','2021-03-24 08:05:38.775196'),(258,'course_overviews','0013_courseoverview_language','2021-03-24 08:05:38.798288'),(259,'course_overviews','0014_courseoverview_certificate_available_date','2021-03-24 08:05:38.822671'),(260,'content_type_gating','0001_initial','2021-03-24 08:05:38.940649'),(261,'content_type_gating','0002_auto_20181119_0959','2021-03-24 08:05:39.162664'),(262,'content_type_gating','0003_auto_20181128_1407','2021-03-24 08:05:39.272796'),(263,'content_type_gating','0004_auto_20181128_1521','2021-03-24 08:05:39.361794'),(264,'content_type_gating','0005_auto_20190306_1547','2021-03-24 08:05:39.453005'),(265,'content_type_gating','0006_auto_20190308_1447','2021-03-24 08:05:39.545852'),(266,'content_type_gating','0007_auto_20190311_1919','2021-03-24 08:05:40.065983'),(267,'content_type_gating','0008_auto_20190313_1634','2021-03-24 08:05:40.165260'),(268,'contentserver','0001_initial','2021-03-24 08:05:40.284004'),(269,'contentserver','0002_cdnuseragentsconfig','2021-03-24 08:05:40.798644'),(270,'cornerstone','0001_initial','2021-03-24 08:05:41.382688'),(271,'cornerstone','0002_cornerstoneglobalconfiguration_subject_mapping','2021-03-24 08:05:41.523481'),(272,'cornerstone','0003_auto_20190621_1000','2021-03-24 08:05:41.887404'),(273,'cornerstone','0004_cornerstoneglobalconfiguration_languages','2021-03-24 08:05:41.979052'),(274,'cornerstone','0005_auto_20190925_0730','2021-03-24 08:05:42.159153'),(275,'cornerstone','0006_auto_20191001_0742','2021-03-24 08:05:42.310419'),(276,'cors_csrf','0001_initial','2021-03-24 08:05:42.431778'),(277,'course_action_state','0001_initial','2021-03-24 08:05:43.094725'),(278,'course_overviews','0015_historicalcourseoverview','2021-03-24 08:05:43.269526'),(279,'course_overviews','0016_simulatecoursepublishconfig','2021-03-24 08:05:43.407481'),(280,'course_overviews','0017_auto_20191002_0823','2021-03-24 08:05:43.512938'),(281,'course_overviews','0018_add_start_end_in_CourseOverview','2021-03-24 08:05:43.766432'),(282,'course_overviews','0019_improve_courseoverviewtab','2021-03-24 08:05:43.966610'),(283,'course_date_signals','0001_initial','2021-03-24 08:05:44.302598'),(284,'course_duration_limits','0001_initial','2021-03-24 08:05:44.478922'),(285,'course_duration_limits','0002_auto_20181119_0959','2021-03-24 08:05:44.618379'),(286,'course_duration_limits','0003_auto_20181128_1407','2021-03-24 08:05:44.734137'),(287,'course_duration_limits','0004_auto_20181128_1521','2021-03-24 08:05:44.839423'),(288,'course_duration_limits','0005_auto_20190306_1546','2021-03-24 08:05:45.347726'),(289,'course_duration_limits','0006_auto_20190308_1447','2021-03-24 08:05:45.457768'),(290,'course_duration_limits','0007_auto_20190311_1919','2021-03-24 08:05:46.083740'),(291,'course_duration_limits','0008_auto_20190313_1634','2021-03-24 08:05:46.191918'),(292,'course_goals','0001_initial','2021-03-24 08:05:46.407528'),(293,'course_goals','0002_auto_20171010_1129','2021-03-24 08:05:46.515289'),(294,'course_groups','0002_change_inline_default_cohort_value','2021-03-24 08:05:46.530262'),(295,'course_groups','0003_auto_20170609_1455','2021-03-24 08:05:46.687598'),(296,'course_modes','0008_course_key_field_to_foreign_key','2021-03-24 08:05:46.876603'),(297,'course_modes','0009_suggested_prices_to_charfield','2021-03-24 08:05:46.898468'),(298,'course_modes','0010_archived_suggested_prices_to_charfield','2021-03-24 08:05:46.911413'),(299,'course_modes','0011_change_regex_for_comma_separated_ints','2021-03-24 08:05:46.940478'),(300,'course_modes','0012_historicalcoursemode','2021-03-24 08:05:47.077480'),(301,'course_modes','0013_auto_20200115_2022','2021-03-24 08:05:47.230371'),(302,'course_overviews','0020_courseoverviewtab_url_slug','2021-03-24 08:05:47.304330'),(303,'course_overviews','0021_courseoverviewtab_link','2021-03-24 08:05:47.335283'),(304,'course_overviews','0022_courseoverviewtab_is_hidden','2021-03-24 08:05:47.368433'),(305,'course_overviews','0023_courseoverview_banner_image_url','2021-03-24 08:05:47.973035'),(306,'course_overviews','0024_overview_adds_has_highlights','2021-03-24 08:05:48.105389'),(307,'coursewarehistoryextended','0001_initial','2021-03-24 08:05:48.403969'),(308,'coursewarehistoryextended','0002_force_studentmodule_index','2021-03-24 08:05:48.427142'),(309,'courseware','0002_coursedynamicupgradedeadlineconfiguration_dynamicupgradedeadlineconfiguration','2021-03-24 08:05:48.495736'),(310,'courseware','0003_auto_20170825_0935','2021-03-24 08:05:48.551939'),(311,'courseware','0004_auto_20171010_1639','2021-03-24 08:05:48.577030'),(312,'courseware','0005_orgdynamicupgradedeadlineconfiguration','2021-03-24 08:05:48.636831'),(313,'courseware','0006_remove_module_id_index','2021-03-24 08:05:48.685184'),(314,'courseware','0007_remove_done_index','2021-03-24 08:05:48.718565'),(315,'courseware','0008_move_idde_to_edx_when','2021-03-24 08:05:48.891395'),(316,'courseware','0009_auto_20190703_1955','2021-03-24 08:05:48.997613'),(317,'courseware','0010_auto_20190709_1559','2021-03-24 08:05:49.104050'),(318,'courseware','0011_csm_id_bigint','2021-03-24 08:05:49.214588'),(319,'courseware','0012_adjust_fields','2021-03-24 08:05:49.353870'),(320,'courseware','0013_auto_20191001_1858','2021-03-24 08:05:49.496756'),(321,'courseware','0014_fix_nan_value_for_global_speed','2021-03-24 08:05:49.660440'),(322,'courseware','0015_add_courseware_stats_index','2021-03-24 08:05:49.736596'),(323,'crawlers','0001_initial','2021-03-24 08:05:50.275187'),(324,'crawlers','0002_auto_20170419_0018','2021-03-24 08:05:50.360003'),(325,'credentials','0001_initial','2021-03-24 08:05:50.468588'),(326,'credentials','0002_auto_20160325_0631','2021-03-24 08:05:50.556707'),(327,'credentials','0003_auto_20170525_1109','2021-03-24 08:05:50.707094'),(328,'credentials','0004_notifycredentialsconfig','2021-03-24 08:05:50.820708'),(329,'credentials','0005_remove_existing_mgmt_cmd_args','2021-03-24 08:05:51.014616'),(330,'credit','0001_initial','2021-03-24 08:05:51.560054'),(331,'credit','0002_creditconfig','2021-03-24 08:05:51.804305'),(332,'credit','0003_auto_20160511_2227','2021-03-24 08:05:51.830051'),(333,'credit','0004_delete_historical_credit_records','2021-03-24 08:05:52.389512'),(334,'credit','0005_creditrequirement_sort_value','2021-03-24 08:05:52.419099'),(335,'credit','0006_creditrequirement_alter_ordering','2021-03-24 08:05:52.439051'),(336,'credit','0007_creditrequirement_copy_values','2021-03-24 08:05:52.625661'),(337,'credit','0008_creditrequirement_remove_order','2021-03-24 08:05:52.653541'),(338,'dark_lang','0001_initial','2021-03-24 08:05:53.258743'),(339,'dark_lang','0002_data__enable_on_install','2021-03-24 08:05:53.454385'),(340,'dark_lang','0003_auto_20180425_0359','2021-03-24 08:05:53.679163'),(341,'database_fixups','0001_initial','2021-03-24 08:05:53.874095'),(342,'degreed','0001_initial','2021-03-24 08:05:54.255973'),(343,'degreed','0002_auto_20180104_0103','2021-03-24 08:05:54.555742'),(344,'degreed','0003_auto_20180109_0712','2021-03-24 08:05:54.690369'),(345,'degreed','0004_auto_20180306_1251','2021-03-24 08:05:54.848151'),(346,'degreed','0005_auto_20180807_1302','2021-03-24 08:05:56.296354'),(347,'degreed','0006_upgrade_django_simple_history','2021-03-24 08:05:56.407711'),(348,'degreed','0007_auto_20190925_0730','2021-03-24 08:05:56.573189'),(349,'degreed','0008_auto_20191001_0742','2021-03-24 08:05:56.722996'),(350,'degreed','0009_auto_20210119_1546','2021-03-24 08:05:57.426252'),(351,'demographics','0001_initial','2021-03-24 08:05:57.660397'),(352,'demographics','0002_clean_duplicate_entries','2021-03-24 08:05:57.877038'),(353,'demographics','0003_auto_20200827_1949','2021-03-24 08:05:58.009943'),(354,'discounts','0001_initial','2021-03-24 08:05:58.819550'),(355,'discounts','0002_auto_20191022_1720','2021-03-24 08:05:59.204107'),(356,'lti_consumer','0001_initial','2021-03-24 08:05:59.266337'),(357,'discussions','0001_initial','2021-03-24 08:05:59.507282'),(358,'discussions','0002_add_provider_filter','2021-03-24 08:05:59.861838'),(359,'discussions','0003_alter_provider_filter_list','2021-03-24 08:06:00.119349'),(360,'django_celery_results','0001_initial','2021-03-24 08:06:00.141296'),(361,'django_celery_results','0002_add_task_name_args_kwargs','2021-03-24 08:06:00.215144'),(362,'django_celery_results','0003_auto_20181106_1101','2021-03-24 08:06:00.230706'),(363,'django_celery_results','0004_auto_20190516_0412','2021-03-24 08:06:00.367139'),(364,'django_celery_results','0005_taskresult_worker','2021-03-24 08:06:00.393379'),(365,'django_celery_results','0006_taskresult_date_created','2021-03-24 08:06:00.618558'),(366,'django_celery_results','0007_remove_taskresult_hidden','2021-03-24 08:06:00.659015'),(367,'django_celery_results','0008_chordcounter','2021-03-24 08:06:00.682248'),(368,'django_comment_common','0001_initial','2021-03-24 08:06:00.973860'),(369,'django_comment_common','0002_forumsconfig','2021-03-24 08:06:01.624460'),(370,'django_comment_common','0003_enable_forums','2021-03-24 08:06:01.833501'),(371,'django_comment_common','0004_auto_20161117_1209','2021-03-24 08:06:01.935244'),(372,'django_comment_common','0005_coursediscussionsettings','2021-03-24 08:06:01.957624'),(373,'django_comment_common','0006_coursediscussionsettings_discussions_id_map','2021-03-24 08:06:01.981773'),(374,'django_comment_common','0007_discussionsidmapping','2021-03-24 08:06:02.000897'),(375,'django_comment_common','0008_role_user_index','2021-03-24 08:06:02.017431'),(376,'django_notify','0001_initial','2021-03-24 08:06:02.544653'),(377,'edx_proctoring','0001_initial','2021-03-24 08:06:04.596463'),(378,'edx_proctoring','0002_proctoredexamstudentattempt_is_status_acknowledged','2021-03-24 08:06:04.945500'),(379,'edx_proctoring','0003_auto_20160101_0525','2021-03-24 08:06:05.144797'),(380,'edx_proctoring','0004_auto_20160201_0523','2021-03-24 08:06:05.261867'),(381,'edx_proctoring','0005_proctoredexam_hide_after_due','2021-03-24 08:06:05.301177'),(382,'edx_proctoring','0006_allowed_time_limit_mins','2021-03-24 08:06:05.567509'),(383,'edx_proctoring','0007_proctoredexam_backend','2021-03-24 08:06:05.608637'),(384,'edx_proctoring','0008_auto_20181116_1551','2021-03-24 08:06:05.923943'),(385,'edx_proctoring','0009_proctoredexamreviewpolicy_remove_rules','2021-03-24 08:06:06.146706'),(386,'edx_proctoring','0010_update_backend','2021-03-24 08:06:06.363441'),(387,'edx_proctoring','0011_allow_multiple_attempts','2021-03-24 08:06:06.479197'),(388,'edx_proctoring','0012_proctoredexamstudentattempt_time_remaining_seconds','2021-03-24 08:06:06.590651'),(389,'edx_proctoring','0013_proctoredexamsoftwaresecurereview_is_active_attempt','2021-03-24 08:06:07.385642'),(390,'edx_when','0001_initial','2021-03-24 08:06:07.713392'),(391,'edx_when','0002_auto_20190318_1736','2021-03-24 08:06:08.166692'),(392,'edx_when','0003_auto_20190402_1501','2021-03-24 08:06:08.638315'),(393,'edx_when','0004_datepolicy_rel_date','2021-03-24 08:06:08.663365'),(394,'edx_when','0005_auto_20190911_1056','2021-03-24 08:06:08.805030'),(395,'edx_when','0006_drop_active_index','2021-03-24 08:06:08.829246'),(396,'edx_when','0007_meta_tweaks','2021-03-24 08:06:08.845549'),(397,'edxval','0001_initial','2021-03-24 08:06:09.300828'),(398,'edxval','0002_data__default_profiles','2021-03-24 08:06:09.305408'),(399,'edxval','0003_coursevideo_is_hidden','2021-03-24 08:06:09.309838'),(400,'edxval','0004_data__add_hls_profile','2021-03-24 08:06:09.314071'),(401,'edxval','0005_videoimage','2021-03-24 08:06:09.318519'),(402,'edxval','0006_auto_20171009_0725','2021-03-24 08:06:09.323322'),(403,'edxval','0007_transcript_credentials_state','2021-03-24 08:06:09.328116'),(404,'edxval','0008_remove_subtitles','2021-03-24 08:06:09.332803'),(405,'edxval','0009_auto_20171127_0406','2021-03-24 08:06:09.337255'),(406,'edxval','0010_add_video_as_foreign_key','2021-03-24 08:06:09.341805'),(407,'edxval','0011_data__add_audio_mp3_profile','2021-03-24 08:06:09.346289'),(408,'edxval','0012_thirdpartytranscriptcredentialsstate_has_creds','2021-03-24 08:06:09.351611'),(409,'edxval','0013_thirdpartytranscriptcredentialsstate_copy_values','2021-03-24 08:06:09.357290'),(410,'edxval','0014_transcript_credentials_state_retype_exists','2021-03-24 08:06:09.362008'),(411,'edxval','0015_remove_thirdpartytranscriptcredentialsstate_exists','2021-03-24 08:06:09.366703'),(412,'edxval','0016_add_transcript_credentials_model','2021-03-24 08:06:09.371353'),(413,'edxval','0002_add_error_description_field','2021-03-24 08:06:09.476892'),(414,'edxval','0003_delete_transcriptcredentials','2021-03-24 08:06:09.517823'),(415,'email_marketing','0001_initial','2021-03-24 08:06:09.660965'),(416,'email_marketing','0002_auto_20160623_1656','2021-03-24 08:06:11.193619'),(417,'email_marketing','0003_auto_20160715_1145','2021-03-24 08:06:11.713025'),(418,'email_marketing','0004_emailmarketingconfiguration_welcome_email_send_delay','2021-03-24 08:06:11.826400'),(419,'email_marketing','0005_emailmarketingconfiguration_user_registration_cookie_timeout_delay','2021-03-24 08:06:11.938430'),(420,'email_marketing','0006_auto_20170711_0615','2021-03-24 08:06:12.041658'),(421,'email_marketing','0007_auto_20170809_0653','2021-03-24 08:06:12.354247'),(422,'email_marketing','0008_auto_20170809_0539','2021-03-24 08:06:12.584303'),(423,'email_marketing','0009_remove_emailmarketingconfiguration_sailthru_activation_template','2021-03-24 08:06:13.299583'),(424,'email_marketing','0010_auto_20180425_0800','2021-03-24 08:06:13.529413'),(425,'embargo','0001_initial','2021-03-24 08:06:13.966844'),(426,'embargo','0002_data__add_countries','2021-03-24 08:06:14.571709'),(427,'enterprise','0114_auto_20201020_0142','2021-03-24 08:06:14.754387'),(428,'enterprise','0115_enterpriseanalyticsuser_historicalenterpriseanalyticsuser','2021-03-24 08:06:15.049574'),(429,'enterprise','0116_auto_20201116_0400','2021-03-24 08:06:15.129215'),(430,'enterprise','0116_auto_20201208_1759','2021-03-24 08:06:15.315803'),(431,'enterprise','0117_auto_20201215_0258','2021-03-24 08:06:15.480869'),(432,'enterprise','unique_constraints_pending_users','2021-03-24 08:06:15.946489'),(433,'enterprise','0001_auto_20210111_1253','2021-03-24 08:06:16.762814'),(434,'enterprise','0120_systemwiderole_applies_to_all_contexts','2021-03-24 08:06:16.993828'),(435,'enterprise','0121_systemwiderole_add_ent_cust_field','2021-03-24 08:06:17.149067'),(436,'enterprise','0122_remove_field_sync_enterprise_catalog_query','2021-03-24 08:06:17.349462'),(437,'enterprise','0123_enterprisecustomeridentityprovider_default_provider','2021-03-24 08:06:17.402343'),(438,'enterprise','0124_auto_20210301_1309','2021-03-24 08:06:17.561450'),(439,'enterprise','0125_add_config_for_role_assign_backfill','2021-03-24 08:06:17.715873'),(440,'enterprise','0126_auto_20210308_1522','2021-03-24 08:06:17.888855'),(441,'experiments','0001_initial','2021-03-24 08:06:18.260892'),(442,'student','0001_initial','2021-03-24 08:06:25.641637'),(443,'student','0002_auto_20151208_1034','2021-03-24 08:06:25.651662'),(444,'student','0003_auto_20160516_0938','2021-03-24 08:06:25.656798'),(445,'student','0004_auto_20160531_1422','2021-03-24 08:06:25.661843'),(446,'student','0005_auto_20160531_1653','2021-03-24 08:06:25.666640'),(447,'student','0006_logoutviewconfiguration','2021-03-24 08:06:25.671605'),(448,'student','0007_registrationcookieconfiguration','2021-03-24 08:06:25.676644'),(449,'student','0008_auto_20161117_1209','2021-03-24 08:06:25.681339'),(450,'student','0009_auto_20170111_0422','2021-03-24 08:06:25.686302'),(451,'student','0010_auto_20170207_0458','2021-03-24 08:06:25.691082'),(452,'student','0011_course_key_field_to_foreign_key','2021-03-24 08:06:25.697487'),(453,'student','0012_sociallink','2021-03-24 08:06:25.702529'),(454,'student','0013_delete_historical_enrollment_records','2021-03-24 08:06:25.707438'),(455,'student','0014_courseenrollmentallowed_user','2021-03-24 08:06:25.712271'),(456,'student','0015_manualenrollmentaudit_add_role','2021-03-24 08:06:25.717520'),(457,'student','0016_coursenrollment_course_on_delete_do_nothing','2021-03-24 08:06:25.722259'),(458,'student','0017_accountrecovery','2021-03-24 08:06:25.730457'),(459,'student','0018_remove_password_history','2021-03-24 08:06:25.736598'),(460,'student','0019_auto_20181221_0540','2021-03-24 08:06:25.742225'),(461,'student','0020_auto_20190227_2019','2021-03-24 08:06:25.747193'),(462,'student','0021_historicalcourseenrollment','2021-03-24 08:06:25.752176'),(463,'student','0022_indexing_in_courseenrollment','2021-03-24 08:06:25.757664'),(464,'student','0023_bulkunenrollconfiguration','2021-03-24 08:06:25.765167'),(465,'student','0024_fbeenrollmentexclusion','2021-03-24 08:06:25.770362'),(466,'student','0025_auto_20191101_1846','2021-03-24 08:06:25.775087'),(467,'student','0026_allowedauthuser','2021-03-24 08:06:25.780073'),(468,'student','0027_courseenrollment_mode_callable_default','2021-03-24 08:06:25.785128'),(469,'student','0028_historicalmanualenrollmentaudit','2021-03-24 08:06:25.790182'),(470,'student','0029_add_data_researcher','2021-03-24 08:06:25.795260'),(471,'student','0030_userprofile_phone_number','2021-03-24 08:06:25.800520'),(472,'student','0031_auto_20200317_1122','2021-03-24 08:06:25.805912'),(473,'entitlements','0001_initial','2021-03-24 08:06:26.427975'),(474,'entitlements','0002_auto_20171102_0719','2021-03-24 08:06:26.771626'),(475,'entitlements','0003_auto_20171205_1431','2021-03-24 08:06:27.202139'),(476,'entitlements','0004_auto_20171206_1729','2021-03-24 08:06:27.316830'),(477,'entitlements','0005_courseentitlementsupportdetail','2021-03-24 08:06:27.436790'),(478,'entitlements','0006_courseentitlementsupportdetail_action','2021-03-24 08:06:27.575701'),(479,'entitlements','0007_change_expiration_period_default','2021-03-24 08:06:27.629924'),(480,'entitlements','0008_auto_20180328_1107','2021-03-24 08:06:27.819460'),(481,'entitlements','0009_courseentitlement_refund_locked','2021-03-24 08:06:27.927989'),(482,'entitlements','0010_backfill_refund_lock','2021-03-24 08:06:28.215727'),(483,'entitlements','0011_historicalcourseentitlement','2021-03-24 08:06:28.334094'),(484,'entitlements','0012_allow_blank_order_number_values','2021-03-24 08:06:28.536259'),(485,'entitlements','0013_historicalcourseentitlementsupportdetail','2021-03-24 08:06:28.649389'),(486,'entitlements','0014_auto_20200115_2022','2021-03-24 08:06:28.779239'),(487,'entitlements','0015_add_unique_together_constraint','2021-03-24 08:06:29.027518'),(488,'event_routing_backends','0001_initial','2021-03-24 08:06:29.143827'),(489,'experiments','0002_auto_20170627_1402','2021-03-24 08:06:29.193959'),(490,'experiments','0003_auto_20170713_1148','2021-03-24 08:06:29.220183'),(491,'experiments','0004_historicalexperimentkeyvalue','2021-03-24 08:06:29.357791'),(492,'external_user_ids','0001_initial','2021-03-24 08:06:30.556504'),(493,'external_user_ids','0002_mb_coaching_20200210_1754','2021-03-24 08:06:30.918206'),(494,'external_user_ids','0003_auto_20200224_1836','2021-03-24 08:06:31.012085'),(495,'external_user_ids','0004_add_lti_type','2021-03-24 08:06:31.303049'),(496,'grades','0001_initial','2021-03-24 08:06:31.387104'),(497,'grades','0002_rename_last_edited_field','2021-03-24 08:06:31.432503'),(498,'grades','0003_coursepersistentgradesflag_persistentgradesenabledflag','2021-03-24 08:06:31.669541'),(499,'grades','0004_visibleblocks_course_id','2021-03-24 08:06:31.727486'),(500,'grades','0005_multiple_course_flags','2021-03-24 08:06:31.838337'),(501,'grades','0006_persistent_course_grades','2021-03-24 08:06:31.879864'),(502,'grades','0007_add_passed_timestamp_column','2021-03-24 08:06:31.961250'),(503,'grades','0008_persistentsubsectiongrade_first_attempted','2021-03-24 08:06:31.992229'),(504,'grades','0009_auto_20170111_1507','2021-03-24 08:06:32.034022'),(505,'grades','0010_auto_20170112_1156','2021-03-24 08:06:32.057827'),(506,'grades','0011_null_edited_time','2021-03-24 08:06:32.127750'),(507,'grades','0012_computegradessetting','2021-03-24 08:06:32.245790'),(508,'grades','0013_persistentsubsectiongradeoverride','2021-03-24 08:06:32.286119'),(509,'grades','0014_persistentsubsectiongradeoverridehistory','2021-03-24 08:06:32.421862'),(510,'grades','0015_historicalpersistentsubsectiongradeoverride','2021-03-24 08:06:32.574859'),(511,'grades','0016_auto_20190703_1446','2021-03-24 08:06:32.880102'),(512,'grades','0017_delete_manual_psgoverride_table','2021-03-24 08:06:33.027728'),(513,'grades','0018_add_waffle_flag_defaults','2021-03-24 08:06:33.350979'),(514,'instructor_task','0002_gradereportsetting','2021-03-24 08:06:33.488418'),(515,'instructor_task','0003_alter_task_input_field','2021-03-24 08:06:34.278789'),(516,'sap_success_factors','0001_initial','2021-03-24 08:06:34.550660'),(517,'sap_success_factors','0002_auto_20170224_1545','2021-03-24 08:06:34.556586'),(518,'sap_success_factors','0003_auto_20170317_1402','2021-03-24 08:06:34.562036'),(519,'sap_success_factors','0004_catalogtransmissionaudit_audit_summary','2021-03-24 08:06:34.567548'),(520,'sap_success_factors','0005_historicalsapsuccessfactorsenterprisecustomerconfiguration_history_change_reason','2021-03-24 08:06:34.572880'),(521,'sap_success_factors','0006_sapsuccessfactors_use_enterprise_enrollment_page_waffle_flag','2021-03-24 08:06:34.578254'),(522,'sap_success_factors','0007_remove_historicalsapsuccessfactorsenterprisecustomerconfiguration_history_change_reason','2021-03-24 08:06:34.583264'),(523,'sap_success_factors','0008_historicalsapsuccessfactorsenterprisecustomerconfiguration_history_change_reason','2021-03-24 08:06:34.588739'),(524,'sap_success_factors','0009_sapsuccessfactors_remove_enterprise_enrollment_page_waffle_flag','2021-03-24 08:06:34.593929'),(525,'sap_success_factors','0010_move_audit_tables_to_base_integrated_channel','2021-03-24 08:06:34.600007'),(526,'sap_success_factors','0011_auto_20180104_0103','2021-03-24 08:06:34.605448'),(527,'sap_success_factors','0012_auto_20180109_0712','2021-03-24 08:06:34.611628'),(528,'sap_success_factors','0013_auto_20180306_1251','2021-03-24 08:06:34.617220'),(529,'sap_success_factors','0014_drop_historical_table','2021-03-24 08:06:34.622781'),(530,'sap_success_factors','0015_auto_20180510_1259','2021-03-24 08:06:34.628150'),(531,'sap_success_factors','0016_sapsuccessfactorsenterprisecustomerconfiguration_additional_locales','2021-03-24 08:06:34.633910'),(532,'sap_success_factors','0017_sapsuccessfactorsglobalconfiguration_search_student_api_path','2021-03-24 08:06:34.639131'),(533,'sap_success_factors','0018_sapsuccessfactorsenterprisecustomerconfiguration_show_course_price','2021-03-24 08:06:34.644551'),(534,'sap_success_factors','0019_auto_20190925_0730','2021-03-24 08:06:34.649904'),(535,'sap_success_factors','0020_sapsuccessfactorsenterprisecustomerconfiguration_catalogs_to_transmit','2021-03-24 08:06:34.655342'),(536,'sap_success_factors','0021_sapsuccessfactorsenterprisecustomerconfiguration_show_total_hours','2021-03-24 08:06:34.660796'),(537,'sap_success_factors','0022_auto_20200206_1046','2021-03-24 08:06:34.666164'),(538,'integrated_channel','0001_initial','2021-03-24 08:06:34.843183'),(539,'integrated_channel','0002_delete_enterpriseintegratedchannel','2021-03-24 08:06:34.849650'),(540,'integrated_channel','0003_catalogtransmissionaudit_learnerdatatransmissionaudit','2021-03-24 08:06:34.855687'),(541,'integrated_channel','0004_catalogtransmissionaudit_channel','2021-03-24 08:06:34.861318'),(542,'integrated_channel','0005_auto_20180306_1251','2021-03-24 08:06:34.867532'),(543,'integrated_channel','0006_delete_catalogtransmissionaudit','2021-03-24 08:06:34.873579'),(544,'integrated_channel','0007_auto_20190925_0730','2021-03-24 08:06:34.879032'),(545,'integrated_channel','0002_learnerdatatransmissionaudit_subsection_id','2021-03-24 08:06:34.927049'),(546,'learning_sequences','0001_initial','2021-03-24 08:06:35.281566'),(547,'learning_sequences','0002_coursesectionsequence_inaccessible_after_due','2021-03-24 08:06:35.385568'),(548,'learning_sequences','0003_create_course_context_for_course_specific_models','2021-03-24 08:06:35.634963'),(549,'learning_sequences','0004_coursecontext_self_paced','2021-03-24 08:06:35.720370'),(550,'learning_sequences','0005_coursecontext_days_early_for_beta','2021-03-24 08:06:35.759297'),(551,'learning_sequences','0006_coursecontext_entrance_exam_id','2021-03-24 08:06:35.819817'),(552,'learning_sequences','0007_coursesequenceexam','2021-03-24 08:06:35.857366'),(553,'learning_sequences','0008_add_learning_context_title_index','2021-03-24 08:06:35.893521'),(554,'learning_sequences','0009_contenterror_publishreport','2021-03-24 08:06:35.950211'),(555,'learning_sequences','0010_add_publishreport_indexes','2021-03-24 08:06:36.040506'),(556,'learning_sequences','0011_course_meta_names','2021-03-24 08:06:36.084309'),(557,'lms_xblock','0001_initial','2021-03-24 08:06:36.212982'),(558,'lti_consumer','0002_ltiagslineitem','2021-03-24 08:06:36.402232'),(559,'lti_consumer','0003_ltiagsscore','2021-03-24 08:06:36.597269'),(560,'lti_consumer','0004_keyset_mgmt_to_model','2021-03-24 08:06:36.745366'),(561,'lti_consumer','0005_migrate_keyset_to_model','2021-03-24 08:06:37.052428'),(562,'lti_consumer','0006_add_on_model_config_for_lti_1p1','2021-03-24 08:06:37.545973'),(563,'lti_consumer','0007_ltidlcontentitem','2021-03-24 08:06:37.717686'),(564,'lti_consumer','0008_fix_uuid_backfill','2021-03-24 08:06:38.749833'),(565,'lti_consumer','0009_backfill-empty-string-config-id','2021-03-24 08:06:39.061655'),(566,'lti_consumer','0010_backfill-empty-string-lti-config','2021-03-24 08:06:39.366363'),(567,'milestones','0001_initial','2021-03-24 08:06:39.692095'),(568,'milestones','0002_data__seed_relationship_types','2021-03-24 08:06:40.104569'),(569,'milestones','0003_coursecontentmilestone_requirements','2021-03-24 08:06:40.141094'),(570,'milestones','0004_auto_20151221_1445','2021-03-24 08:06:40.248053'),(571,'mobile_api','0001_initial','2021-03-24 08:06:40.428388'),(572,'mobile_api','0002_auto_20160406_0904','2021-03-24 08:06:40.488573'),(573,'mobile_api','0003_ignore_mobile_available_flag','2021-03-24 08:06:40.791100'),(574,'moodle','0001_initial','2021-03-24 08:06:41.167254'),(575,'moodle','0002_moodlelearnerdatatransmissionaudit','2021-03-24 08:06:41.238447'),(576,'moodle','0003_auto_20201006_1706','2021-03-24 08:06:41.441512'),(577,'moodle','0004_auto_20201105_1921','2021-03-24 08:06:41.632005'),(578,'oauth2_provider','0001_initial','2021-03-24 08:06:43.319791'),(579,'oauth2_provider','0002_auto_20190406_1805','2021-03-24 08:06:43.733661'),(580,'oauth_dispatch','0001_initial','2021-03-24 08:06:43.927271'),(581,'oauth_dispatch','0002_scopedapplication_scopedapplicationorganization','2021-03-24 08:06:44.312679'),(582,'oauth_dispatch','0003_application_data','2021-03-24 08:06:44.693827'),(583,'oauth_dispatch','0004_auto_20180626_1349','2021-03-24 08:06:46.271727'),(584,'oauth_dispatch','0005_applicationaccess_type','2021-03-24 08:06:46.356036'),(585,'oauth_dispatch','0006_drop_application_id_constraints','2021-03-24 08:06:46.484415'),(586,'oauth_dispatch','0007_restore_application_id_constraints','2021-03-24 08:06:46.635923'),(587,'oauth_dispatch','0008_applicationaccess_filters','2021-03-24 08:06:46.678109'),(588,'oauth_dispatch','0009_delete_enable_scopes_waffle_switch','2021-03-24 08:06:47.001133'),(589,'organizations','0002_unique_short_name','2021-03-24 08:06:47.058619'),(590,'organizations','0003_historicalorganizationcourse','2021-03-24 08:06:47.106172'),(591,'program_enrollments','0001_initial','2021-03-24 08:06:47.219012'),(592,'program_enrollments','0002_historicalprogramcourseenrollment_programcourseenrollment','2021-03-24 08:06:47.635772'),(593,'program_enrollments','0003_auto_20190424_1622','2021-03-24 08:06:47.833615'),(594,'program_enrollments','0004_add_programcourseenrollment_relatedname','2021-03-24 08:06:48.031963'),(595,'program_enrollments','0005_canceled_not_withdrawn','2021-03-24 08:06:48.329294'),(596,'program_enrollments','0006_add_the_correct_constraints','2021-03-24 08:06:48.485672'),(597,'program_enrollments','0007_waiting_programcourseenrollment_constraint','2021-03-24 08:06:48.522894'),(598,'program_enrollments','0008_add_ended_programenrollment_status','2021-03-24 08:06:48.587168'),(599,'program_enrollments','0009_update_course_enrollment_field_to_foreign_key','2021-03-24 08:06:48.660911'),(600,'program_enrollments','0010_add_courseaccessroleassignment','2021-03-24 08:06:48.749388'),(601,'programs','0001_initial','2021-03-24 08:06:48.819842'),(602,'programs','0002_programsapiconfig_cache_ttl','2021-03-24 08:06:48.886943'),(603,'programs','0003_auto_20151120_1613','2021-03-24 08:06:49.806624'),(604,'programs','0004_programsapiconfig_enable_certification','2021-03-24 08:06:49.857324'),(605,'programs','0005_programsapiconfig_max_retries','2021-03-24 08:06:49.915845'),(606,'programs','0006_programsapiconfig_xseries_ad_enabled','2021-03-24 08:06:49.981304'),(607,'programs','0007_programsapiconfig_program_listing_enabled','2021-03-24 08:06:50.037168'),(608,'programs','0008_programsapiconfig_program_details_enabled','2021-03-24 08:06:50.093829'),(609,'programs','0009_programsapiconfig_marketing_path','2021-03-24 08:06:50.152021'),(610,'programs','0010_auto_20170204_2332','2021-03-24 08:06:50.230278'),(611,'programs','0011_auto_20170301_1844','2021-03-24 08:06:50.808058'),(612,'programs','0012_auto_20170419_0018','2021-03-24 08:06:50.857881'),(613,'programs','0013_customprogramsconfig','2021-03-24 08:06:50.912549'),(614,'redirects','0001_initial','2021-03-24 08:06:51.136460'),(615,'rss_proxy','0001_initial','2021-03-24 08:06:51.180284'),(616,'sap_success_factors','0002_sapsuccessfactorslearnerdatatransmissionaudit_credit_hours','2021-03-24 08:06:51.218697'),(617,'schedules','0001_initial','2021-03-24 08:06:51.408369'),(618,'schedules','0002_auto_20170816_1532','2021-03-24 08:06:51.499037'),(619,'schedules','0003_scheduleconfig','2021-03-24 08:06:51.693514'),(620,'schedules','0004_auto_20170922_1428','2021-03-24 08:06:52.047356'),(621,'schedules','0005_auto_20171010_1722','2021-03-24 08:06:52.376000'),(622,'schedules','0006_scheduleexperience','2021-03-24 08:06:52.578727'),(623,'schedules','0007_scheduleconfig_hold_back_ratio','2021-03-24 08:06:52.761342'),(624,'schedules','0008_add_new_start_date_field','2021-03-24 08:06:52.807862'),(625,'schedules','0009_schedule_copy_column_values','2021-03-24 08:06:53.902943'),(626,'schedules','0010_remove_null_blank_from_schedules_date','2021-03-24 08:06:53.955077'),(627,'schedules','0011_auto_20200228_2018','2021-03-24 08:06:54.011770'),(628,'schedules','0012_auto_20200302_1914','2021-03-24 08:06:54.070218'),(629,'schedules','0013_historicalschedule','2021-03-24 08:06:54.136130'),(630,'schedules','0014_historicalschedule_drop_fk','2021-03-24 08:06:54.217933'),(631,'schedules','0015_schedules_start_nullable','2021-03-24 08:06:54.315294'),(632,'schedules','0016_remove_start_from_schedules','2021-03-24 08:06:54.357695'),(633,'schedules','0017_remove_start_from_historicalschedule','2021-03-24 08:06:54.413580'),(634,'schedules','0018_readd_historicalschedule_fks','2021-03-24 08:06:54.511101'),(635,'schedules','0019_auto_20200316_1935','2021-03-24 08:06:54.664133'),(636,'schedules','0020_remove_config_rollout_fields','2021-03-24 08:06:54.816495'),(637,'self_paced','0001_initial','2021-03-24 08:06:54.903622'),(638,'sessions','0001_initial','2021-03-24 08:06:54.945842'),(639,'shoppingcart','0001_initial','2021-03-24 08:06:56.921718'),(640,'shoppingcart','0002_auto_20151208_1034','2021-03-24 08:06:58.114256'),(641,'shoppingcart','0003_auto_20151217_0958','2021-03-24 08:06:58.180322'),(642,'shoppingcart','0004_change_meta_options','2021-03-24 08:06:58.247133'),(643,'shoppingcart','0005_drop_tables','2021-03-24 08:07:01.152959'),(644,'site_configuration','0001_initial','2021-03-24 08:07:01.323488'),(645,'site_configuration','0002_auto_20160720_0231','2021-03-24 08:07:01.474106'),(646,'site_configuration','0003_auto_20200217_1058','2021-03-24 08:07:01.572735'),(647,'site_configuration','0004_add_site_values_field','2021-03-24 08:07:02.455800'),(648,'site_configuration','0005_populate_siteconfig_history_site_values','2021-03-24 08:07:02.474042'),(649,'site_configuration','0006_copy_values_to_site_values','2021-03-24 08:07:02.815862'),(650,'site_configuration','0007_remove_values_field','2021-03-24 08:07:02.945142'),(651,'default','0001_initial','2021-03-24 08:07:03.211445'),(652,'social_auth','0001_initial','2021-03-24 08:07:03.218303'),(653,'default','0002_add_related_name','2021-03-24 08:07:03.336455'),(654,'social_auth','0002_add_related_name','2021-03-24 08:07:03.343082'),(655,'default','0003_alter_email_max_length','2021-03-24 08:07:03.370914'),(656,'social_auth','0003_alter_email_max_length','2021-03-24 08:07:03.378253'),(657,'default','0004_auto_20160423_0400','2021-03-24 08:07:03.439529'),(658,'social_auth','0004_auto_20160423_0400','2021-03-24 08:07:03.446446'),(659,'social_auth','0005_auto_20160727_2333','2021-03-24 08:07:03.475656'),(660,'social_django','0006_partial','2021-03-24 08:07:03.503064'),(661,'social_django','0007_code_timestamp','2021-03-24 08:07:03.545812'),(662,'social_django','0008_partial_timestamp','2021-03-24 08:07:03.586429'),(663,'social_django','0009_auto_20191118_0520','2021-03-24 08:07:03.734846'),(664,'social_django','0010_uid_db_index','2021-03-24 08:07:03.804548'),(665,'splash','0001_initial','2021-03-24 08:07:03.898097'),(666,'static_replace','0001_initial','2021-03-24 08:07:04.007556'),(667,'static_replace','0002_assetexcludedextensionsconfig','2021-03-24 08:07:04.120411'),(668,'status','0001_initial','2021-03-24 08:07:04.341102'),(669,'status','0002_update_help_text','2021-03-24 08:07:04.438217'),(670,'student','0032_removed_logout_view_configuration','2021-03-24 08:07:04.588826'),(671,'student','0033_userprofile_state','2021-03-24 08:07:04.701963'),(672,'student','0034_courseenrollmentcelebration','2021-03-24 08:07:04.848130'),(673,'student','0035_bulkchangeenrollmentconfiguration','2021-03-24 08:07:04.989681'),(674,'student','0036_userpasswordtogglehistory','2021-03-24 08:07:05.137038'),(675,'student','0037_linkedinaddtoprofileconfiguration_updates','2021-03-24 08:07:05.475812'),(676,'student','0038_auto_20201021_1256','2021-03-24 08:07:05.579517'),(677,'student','0039_anon_id_context','2021-03-24 08:07:05.679086'),(678,'student','0040_usercelebration','2021-03-24 08:07:05.813636'),(679,'student','0041_registration_activation_timestamp','2021-03-24 08:07:05.932831'),(680,'submissions','0001_initial','2021-03-24 08:07:07.186595'),(681,'submissions','0002_auto_20151119_0913','2021-03-24 08:07:07.194734'),(682,'submissions','0003_submission_status','2021-03-24 08:07:07.202365'),(683,'submissions','0004_remove_django_extensions','2021-03-24 08:07:07.211395'),(684,'submissions','0005_CreateTeamModel','2021-03-24 08:07:07.217909'),(685,'super_csv','0001_initial','2021-03-24 08:07:07.424861'),(686,'super_csv','0002_csvoperation_user','2021-03-24 08:07:07.581377'),(687,'super_csv','0003_csvoperation_original_filename','2021-03-24 08:07:07.711220'),(688,'survey','0001_initial','2021-03-24 08:07:07.926199'),(689,'system_wide_roles','0001_SystemWideRole_SystemWideRoleAssignment','2021-03-24 08:07:08.122608'),(690,'system_wide_roles','0002_add_system_wide_student_support_role','2021-03-24 08:07:08.533075'),(691,'system_wide_roles','0003_systemwideroleassignment_applies_to_all_contexts','2021-03-24 08:07:08.656680'),(692,'teams','0001_initial','2021-03-24 08:07:09.117400'),(693,'teams','0002_slug_field_ids','2021-03-24 08:07:09.397355'),(694,'teams','0003_courseteam_organization_protected','2021-03-24 08:07:09.545268'),(695,'teams','0004_alter_defaults','2021-03-24 08:07:10.002564'),(696,'theming','0001_initial','2021-03-24 08:07:10.158571'),(697,'third_party_auth','0001_initial','2021-03-24 08:07:11.734614'),(698,'third_party_auth','0002_schema__provider_icon_image','2021-03-24 08:07:11.742196'),(699,'third_party_auth','0003_samlproviderconfig_debug_mode','2021-03-24 08:07:11.749705'),(700,'third_party_auth','0004_add_visible_field','2021-03-24 08:07:11.756193'),(701,'third_party_auth','0005_add_site_field','2021-03-24 08:07:11.762630'),(702,'third_party_auth','0006_samlproviderconfig_automatic_refresh_enabled','2021-03-24 08:07:11.769175'),(703,'third_party_auth','0007_auto_20170406_0912','2021-03-24 08:07:11.776765'),(704,'third_party_auth','0008_auto_20170413_1455','2021-03-24 08:07:11.783120'),(705,'third_party_auth','0009_auto_20170415_1144','2021-03-24 08:07:11.790499'),(706,'third_party_auth','0010_add_skip_hinted_login_dialog_field','2021-03-24 08:07:11.798223'),(707,'third_party_auth','0011_auto_20170616_0112','2021-03-24 08:07:11.805186'),(708,'third_party_auth','0012_auto_20170626_1135','2021-03-24 08:07:11.811958'),(709,'third_party_auth','0013_sync_learner_profile_data','2021-03-24 08:07:11.818440'),(710,'third_party_auth','0014_auto_20171222_1233','2021-03-24 08:07:11.824779'),(711,'third_party_auth','0015_samlproviderconfig_archived','2021-03-24 08:07:11.831059'),(712,'third_party_auth','0016_auto_20180130_0938','2021-03-24 08:07:11.837885'),(713,'third_party_auth','0017_remove_icon_class_image_secondary_fields','2021-03-24 08:07:11.844356'),(714,'third_party_auth','0018_auto_20180327_1631','2021-03-24 08:07:11.851067'),(715,'third_party_auth','0019_consolidate_slug','2021-03-24 08:07:11.858196'),(716,'third_party_auth','0020_cleanup_slug_fields','2021-03-24 08:07:11.864583'),(717,'third_party_auth','0021_sso_id_verification','2021-03-24 08:07:11.873331'),(718,'third_party_auth','0022_auto_20181012_0307','2021-03-24 08:07:11.881012'),(719,'third_party_auth','0023_auto_20190418_2033','2021-03-24 08:07:11.889080'),(720,'third_party_auth','0024_fix_edit_disallowed','2021-03-24 08:07:11.895675'),(721,'third_party_auth','0025_auto_20200303_1448','2021-03-24 08:07:11.903072'),(722,'third_party_auth','0026_auto_20200401_1932','2021-03-24 08:07:11.910068'),(723,'third_party_auth','0002_samlproviderconfig_country','2021-03-24 08:07:12.267072'),(724,'third_party_auth','0002_auto_20200721_1650','2021-03-24 08:07:12.865199'),(725,'third_party_auth','0003_samlconfiguration_is_public','2021-03-24 08:07:13.051915'),(726,'third_party_auth','0004_auto_20200919_0955','2021-03-24 08:07:13.649946'),(727,'thumbnail','0001_initial','2021-03-24 08:07:13.681085'),(728,'track','0001_initial','2021-03-24 08:07:13.712402'),(729,'track','0002_delete_trackinglog','2021-03-24 08:07:13.742507'),(730,'user_api','0003_userretirementrequest','2021-03-24 08:07:13.935044'),(731,'user_api','0004_userretirementpartnerreportingstatus','2021-03-24 08:07:14.138873'),(732,'user_authn','0001_data__add_login_service','2021-03-24 08:07:14.564308'),(733,'user_tasks','0001_initial','2021-03-24 08:07:15.844953'),(734,'user_tasks','0002_artifact_file_storage','2021-03-24 08:07:15.930249'),(735,'user_tasks','0003_url_max_length','2021-03-24 08:07:15.976174'),(736,'user_tasks','0004_url_textfield','2021-03-24 08:07:16.020203'),(737,'util','0001_initial','2021-03-24 08:07:16.159132'),(738,'util','0002_data__default_rate_limit_config','2021-03-24 08:07:16.554083'),(739,'verified_track_content','0001_initial','2021-03-24 08:07:16.587275'),(740,'verified_track_content','0002_verifiedtrackcohortedcourse_verified_cohort_name','2021-03-24 08:07:16.624110'),(741,'verified_track_content','0003_migrateverifiedtrackcohortssetting','2021-03-24 08:07:16.768894'),(742,'verify_student','0001_initial','2021-03-24 08:07:17.981827'),(743,'verify_student','0002_auto_20151124_1024','2021-03-24 08:07:18.269325'),(744,'verify_student','0003_auto_20151113_1443','2021-03-24 08:07:18.325048'),(745,'verify_student','0004_delete_historical_records','2021-03-24 08:07:18.393550'),(746,'verify_student','0005_remove_deprecated_models','2021-03-24 08:07:20.461869'),(747,'verify_student','0006_ssoverification','2021-03-24 08:07:20.608896'),(748,'verify_student','0007_idverificationaggregate','2021-03-24 08:07:20.776207'),(749,'verify_student','0008_populate_idverificationaggregate','2021-03-24 08:07:21.228062'),(750,'verify_student','0009_remove_id_verification_aggregate','2021-03-24 08:07:21.514107'),(751,'verify_student','0010_manualverification','2021-03-24 08:07:21.648083'),(752,'verify_student','0011_add_fields_to_sspv','2021-03-24 08:07:21.885477'),(753,'verify_student','0012_sspverificationretryconfig','2021-03-24 08:07:22.041837'),(754,'verify_student','0013_add_expiration_date_field','2021-03-24 08:07:22.386749'),(755,'video_config','0001_initial','2021-03-24 08:07:22.667074'),(756,'video_config','0002_coursevideotranscriptenabledflag_videotranscriptenabledflag','2021-03-24 08:07:22.973566'),(757,'video_config','0003_transcriptmigrationsetting','2021-03-24 08:07:23.151364'),(758,'video_config','0004_transcriptmigrationsetting_command_run','2021-03-24 08:07:23.279234'),(759,'video_config','0005_auto_20180719_0752','2021-03-24 08:07:23.423963'),(760,'video_config','0006_videothumbnailetting_updatedcoursevideos','2021-03-24 08:07:23.623356'),(761,'video_config','0007_videothumbnailsetting_offset','2021-03-24 08:07:24.671876'),(762,'video_config','0008_courseyoutubeblockedflag','2021-03-24 08:07:24.810820'),(763,'video_pipeline','0001_initial','2021-03-24 08:07:24.972873'),(764,'video_pipeline','0002_auto_20171114_0704','2021-03-24 08:07:25.196927'),(765,'video_pipeline','0003_coursevideouploadsenabledbydefault_videouploadsenabledbydefault','2021-03-24 08:07:25.464211'),(766,'video_pipeline','0004_vempipelineintegration','2021-03-24 08:07:25.638920'),(767,'video_pipeline','0005_add_vem_course_percentage','2021-03-24 08:07:25.775132'),(768,'video_pipeline','0006_remove_vempipelineintegration_vem_enabled_courses_percentage','2021-03-24 08:07:25.894231'),(769,'video_pipeline','0007_delete_videopipelineintegration','2021-03-24 08:07:25.919869'),(770,'waffle','0002_auto_20161201_0958','2021-03-24 08:07:25.947052'),(771,'waffle','0003_update_strings_for_i18n','2021-03-24 08:07:28.728241'),(772,'waffle','0004_update_everyone_nullbooleanfield','2021-03-24 08:07:28.852481'),(773,'waffle_utils','0001_initial','2021-03-24 08:07:28.996337'),(774,'wiki','0001_initial','2021-03-24 08:07:33.509854'),(775,'wiki','0002_remove_article_subscription','2021-03-24 08:07:33.883514'),(776,'wiki','0003_ip_address_conv','2021-03-24 08:07:34.268271'),(777,'wiki','0004_increase_slug_size','2021-03-24 08:07:34.345570'),(778,'wiki','0005_remove_attachments_and_images','2021-03-24 08:07:35.212235'),(779,'wiki','0006_auto_20200110_1003','2021-03-24 08:07:35.446042'),(780,'workflow','0001_initial','2021-03-24 08:07:35.540762'),(781,'workflow','0002_remove_django_extensions','2021-03-24 08:07:35.623430'),(782,'workflow','0003_TeamWorkflows','2021-03-24 08:07:35.662897'),(783,'workflow','0004_assessmentworkflowstep_skipped','2021-03-24 08:07:35.726190'),(784,'xapi','0001_initial','2021-03-24 08:07:35.846909'),(785,'xapi','0002_auto_20180726_0142','2021-03-24 08:07:35.956895'),(786,'xapi','0003_auto_20190807_1006','2021-03-24 08:07:36.160381'),(787,'xapi','0004_auto_20190830_0710','2021-03-24 08:07:36.271472'),(788,'xblock_django','0001_initial','2021-03-24 08:07:36.394725'),(789,'xblock_django','0002_auto_20160204_0809','2021-03-24 08:07:36.498232'),(790,'xblock_django','0003_add_new_config_models','2021-03-24 08:07:37.755837'),(791,'xblock_django','0004_delete_xblock_disable_config','2021-03-24 08:07:37.948532'),(792,'student','0001_squashed_0031_auto_20200317_1122','2021-03-24 08:07:37.966732'),(793,'third_party_auth','0001_squashed_0026_auto_20200401_1932','2021-03-24 08:07:37.974675'),(794,'social_django','0005_auto_20160727_2333','2021-03-24 08:07:37.982128'),(795,'social_django','0002_add_related_name','2021-03-24 08:07:37.989499'),(796,'social_django','0004_auto_20160423_0400','2021-03-24 08:07:37.997170'),(797,'social_django','0001_initial','2021-03-24 08:07:38.004510'),(798,'social_django','0003_alter_email_max_length','2021-03-24 08:07:38.021375'),(799,'submissions','0001_squashed_0005_CreateTeamModel','2021-03-24 08:07:38.029916'),(800,'edxval','0001_squashed_0016_add_transcript_credentials_model','2021-03-24 08:07:38.037620'),(801,'organizations','0001_squashed_0007_historicalorganization','2021-03-24 08:07:38.046588'),(802,'enterprise','0001_squashed_0092_auto_20200312_1650','2021-03-24 08:07:38.055954'),(803,'integrated_channel','0001_squashed_0007_auto_20190925_0730','2021-03-24 08:07:38.063344'),(804,'sap_success_factors','0001_squashed_0022_auto_20200206_1046','2021-03-24 08:07:38.071149'),(805,'contentstore','0001_initial','2021-03-24 08:09:46.245873'),(806,'contentstore','0002_add_assets_page_flag','2021-03-24 08:09:46.829746'),(807,'contentstore','0003_remove_assets_page_flag','2021-03-24 08:09:47.791881'),(808,'contentstore','0004_remove_push_notification_configmodel_table','2021-03-24 08:09:48.091156'),(809,'contentstore','0005_add_enable_checklists_quality_waffle_flag','2021-03-24 08:09:48.111112'),(810,'course_creators','0001_initial','2021-03-24 08:09:48.387595'),(811,'tagging','0001_initial','2021-03-24 08:09:48.478631'),(812,'tagging','0002_auto_20170116_1541','2021-03-24 08:09:48.529066'),(813,'xblock_config','0001_initial','2021-03-24 08:09:48.809579'),(814,'xblock_config','0002_courseeditltifieldsenabledflag','2021-03-24 08:09:49.108968');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_redirect`
--

DROP TABLE IF EXISTS `django_redirect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_redirect` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `old_path` varchar(200) NOT NULL,
  `new_path` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_redirect_site_id_old_path_ac5dd16b_uniq` (`site_id`,`old_path`),
  KEY `django_redirect_old_path_c6cc94d3` (`old_path`),
  CONSTRAINT `django_redirect_site_id_c3e37341_fk_django_site_id` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_redirect`
--

LOCK TABLES `django_redirect` WRITE;
/*!40000 ALTER TABLE `django_redirect` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_redirect` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_site`
--

DROP TABLE IF EXISTS `django_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_site_domain_a2e37b91_uniq` (`domain`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_site`
--

LOCK TABLES `django_site` WRITE;
/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;
INSERT INTO `django_site` VALUES (1,'example.com','example.com');
/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `edx_when_contentdate`
--

DROP TABLE IF EXISTS `edx_when_contentdate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `edx_when_contentdate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` varchar(255) NOT NULL,
  `location` varchar(255) DEFAULT NULL,
  `policy_id` int(11) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `field` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `edx_when_contentdate_policy_id_location_field_a26790ec_uniq` (`policy_id`,`location`,`field`),
  KEY `edx_when_contentdate_course_id_e6c39fdc` (`course_id`),
  KEY `edx_when_contentdate_location_485206ea` (`location`),
  KEY `edx_when_contentdate_policy_id_af2bcaf4` (`policy_id`),
  CONSTRAINT `edx_when_contentdate_policy_id_af2bcaf4_fk_edx_when_` FOREIGN KEY (`policy_id`) REFERENCES `edx_when_datepolicy` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `edx_when_contentdate`
--

LOCK TABLES `edx_when_contentdate` WRITE;
/*!40000 ALTER TABLE `edx_when_contentdate` DISABLE KEYS */;
/*!40000 ALTER TABLE `edx_when_contentdate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `edx_when_datepolicy`
--

DROP TABLE IF EXISTS `edx_when_datepolicy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `edx_when_datepolicy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `abs_date` datetime(6) DEFAULT NULL,
  `rel_date` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `edx_when_datepolicy_abs_date_1a510cd3` (`abs_date`),
  KEY `edx_when_datepolicy_rel_date_836d6051` (`rel_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `edx_when_datepolicy`
--

LOCK TABLES `edx_when_datepolicy` WRITE;
/*!40000 ALTER TABLE `edx_when_datepolicy` DISABLE KEYS */;
/*!40000 ALTER TABLE `edx_when_datepolicy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `edx_when_userdate`
--

DROP TABLE IF EXISTS `edx_when_userdate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `edx_when_userdate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `abs_date` datetime(6) DEFAULT NULL,
  `rel_date` bigint(20) DEFAULT NULL,
  `reason` longtext NOT NULL,
  `actor_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `content_date_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `edx_when_userdate_user_id_46e8cc36_fk_auth_user_id` (`user_id`),
  KEY `edx_when_userdate_content_date_id_35c5e2e2_fk_edx_when_` (`content_date_id`),
  KEY `edx_when_userdate_actor_id_cbef1cdc_fk_auth_user_id` (`actor_id`),
  KEY `edx_when_userdate_rel_date_954ee5b4` (`rel_date`),
  CONSTRAINT `edx_when_userdate_actor_id_cbef1cdc_fk_auth_user_id` FOREIGN KEY (`actor_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `edx_when_userdate_content_date_id_35c5e2e2_fk_edx_when_` FOREIGN KEY (`content_date_id`) REFERENCES `edx_when_contentdate` (`id`),
  CONSTRAINT `edx_when_userdate_user_id_46e8cc36_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `edx_when_userdate`
--

LOCK TABLES `edx_when_userdate` WRITE;
/*!40000 ALTER TABLE `edx_when_userdate` DISABLE KEYS */;
/*!40000 ALTER TABLE `edx_when_userdate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `edxval_coursevideo`
--

DROP TABLE IF EXISTS `edxval_coursevideo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `edxval_coursevideo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` varchar(255) NOT NULL,
  `video_id` int(11) NOT NULL,
  `is_hidden` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `edxval_coursevideo_course_id_video_id_ebd82f35_uniq` (`course_id`,`video_id`),
  KEY `edxval_coursevideo_video_id_85dfcf76_fk_edxval_video_id` (`video_id`),
  CONSTRAINT `edxval_coursevideo_video_id_85dfcf76_fk_edxval_video_id` FOREIGN KEY (`video_id`) REFERENCES `edxval_video` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `edxval_coursevideo`
--

LOCK TABLES `edxval_coursevideo` WRITE;
/*!40000 ALTER TABLE `edxval_coursevideo` DISABLE KEYS */;
/*!40000 ALTER TABLE `edxval_coursevideo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `edxval_encodedvideo`
--

DROP TABLE IF EXISTS `edxval_encodedvideo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `edxval_encodedvideo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `url` varchar(200) NOT NULL,
  `file_size` int(10) unsigned NOT NULL,
  `bitrate` int(10) unsigned NOT NULL,
  `profile_id` int(11) NOT NULL,
  `video_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `edxval_encodedvideo_profile_id_d9f3e086_fk_edxval_profile_id` (`profile_id`),
  KEY `edxval_encodedvideo_video_id_d8857acb_fk_edxval_video_id` (`video_id`),
  CONSTRAINT `edxval_encodedvideo_profile_id_d9f3e086_fk_edxval_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `edxval_profile` (`id`),
  CONSTRAINT `edxval_encodedvideo_video_id_d8857acb_fk_edxval_video_id` FOREIGN KEY (`video_id`) REFERENCES `edxval_video` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `edxval_encodedvideo`
--

LOCK TABLES `edxval_encodedvideo` WRITE;
/*!40000 ALTER TABLE `edxval_encodedvideo` DISABLE KEYS */;
/*!40000 ALTER TABLE `edxval_encodedvideo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `edxval_profile`
--

DROP TABLE IF EXISTS `edxval_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `edxval_profile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `profile_name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `profile_name` (`profile_name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `edxval_profile`
--

LOCK TABLES `edxval_profile` WRITE;
/*!40000 ALTER TABLE `edxval_profile` DISABLE KEYS */;
INSERT INTO `edxval_profile` VALUES (1,'audio_mp3'),(3,'desktop_mp4'),(4,'desktop_webm'),(2,'hls'),(5,'mobile_high'),(6,'mobile_low'),(7,'youtube');
/*!40000 ALTER TABLE `edxval_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `edxval_thirdpartytranscriptcredentialsstate`
--

DROP TABLE IF EXISTS `edxval_thirdpartytranscriptcredentialsstate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `edxval_thirdpartytranscriptcredentialsstate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `org` varchar(32) NOT NULL,
  `provider` varchar(20) NOT NULL,
  `has_creds` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `edxval_thirdpartytranscr_org_provider_188f7ddf_uniq` (`org`,`provider`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `edxval_thirdpartytranscriptcredentialsstate`
--

LOCK TABLES `edxval_thirdpartytranscriptcredentialsstate` WRITE;
/*!40000 ALTER TABLE `edxval_thirdpartytranscriptcredentialsstate` DISABLE KEYS */;
/*!40000 ALTER TABLE `edxval_thirdpartytranscriptcredentialsstate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `edxval_transcriptpreference`
--

DROP TABLE IF EXISTS `edxval_transcriptpreference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `edxval_transcriptpreference` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `provider` varchar(20) NOT NULL,
  `cielo24_fidelity` varchar(20) DEFAULT NULL,
  `cielo24_turnaround` varchar(20) DEFAULT NULL,
  `three_play_turnaround` varchar(20) DEFAULT NULL,
  `preferred_languages` longtext NOT NULL,
  `video_source_language` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `course_id` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `edxval_transcriptpreference`
--

LOCK TABLES `edxval_transcriptpreference` WRITE;
/*!40000 ALTER TABLE `edxval_transcriptpreference` DISABLE KEYS */;
/*!40000 ALTER TABLE `edxval_transcriptpreference` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `edxval_video`
--

DROP TABLE IF EXISTS `edxval_video`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `edxval_video` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `edx_video_id` varchar(100) NOT NULL,
  `client_video_id` varchar(255) NOT NULL,
  `duration` double NOT NULL,
  `status` varchar(255) NOT NULL,
  `error_description` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `edx_video_id` (`edx_video_id`),
  KEY `edxval_video_client_video_id_2b668312` (`client_video_id`),
  KEY `edxval_video_status_5f33a104` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `edxval_video`
--

LOCK TABLES `edxval_video` WRITE;
/*!40000 ALTER TABLE `edxval_video` DISABLE KEYS */;
/*!40000 ALTER TABLE `edxval_video` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `edxval_videoimage`
--

DROP TABLE IF EXISTS `edxval_videoimage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `edxval_videoimage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `image` varchar(500) DEFAULT NULL,
  `generated_images` longtext NOT NULL,
  `course_video_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `course_video_id` (`course_video_id`),
  CONSTRAINT `edxval_videoimage_course_video_id_06855d34_fk_edxval_co` FOREIGN KEY (`course_video_id`) REFERENCES `edxval_coursevideo` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `edxval_videoimage`
--

LOCK TABLES `edxval_videoimage` WRITE;
/*!40000 ALTER TABLE `edxval_videoimage` DISABLE KEYS */;
/*!40000 ALTER TABLE `edxval_videoimage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `edxval_videotranscript`
--

DROP TABLE IF EXISTS `edxval_videotranscript`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `edxval_videotranscript` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `transcript` varchar(255) DEFAULT NULL,
  `language_code` varchar(50) NOT NULL,
  `provider` varchar(30) NOT NULL,
  `file_format` varchar(20) NOT NULL,
  `video_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `edxval_videotranscript_video_id_language_code_37532906_uniq` (`video_id`,`language_code`),
  KEY `edxval_videotranscript_language_code_d78ce3d1` (`language_code`),
  KEY `edxval_videotranscript_file_format_3adddaf7` (`file_format`),
  CONSTRAINT `edxval_videotranscript_video_id_6ffdfb56_fk_edxval_video_id` FOREIGN KEY (`video_id`) REFERENCES `edxval_video` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `edxval_videotranscript`
--

LOCK TABLES `edxval_videotranscript` WRITE;
/*!40000 ALTER TABLE `edxval_videotranscript` DISABLE KEYS */;
/*!40000 ALTER TABLE `edxval_videotranscript` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_marketing_emailmarketingconfiguration`
--

DROP TABLE IF EXISTS `email_marketing_emailmarketingconfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_marketing_emailmarketingconfiguration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `sailthru_key` varchar(32) NOT NULL,
  `sailthru_secret` varchar(32) NOT NULL,
  `sailthru_new_user_list` varchar(48) NOT NULL,
  `sailthru_retry_interval` int(11) NOT NULL,
  `sailthru_max_retries` int(11) NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  `sailthru_abandoned_cart_delay` int(11) NOT NULL,
  `sailthru_abandoned_cart_template` varchar(20) NOT NULL,
  `sailthru_content_cache_age` int(11) NOT NULL,
  `sailthru_enroll_cost` int(11) NOT NULL,
  `sailthru_enroll_template` varchar(20) NOT NULL,
  `sailthru_get_tags_from_sailthru` tinyint(1) NOT NULL,
  `sailthru_purchase_template` varchar(20) NOT NULL,
  `sailthru_upgrade_template` varchar(20) NOT NULL,
  `sailthru_lms_url_override` varchar(80) NOT NULL,
  `welcome_email_send_delay` int(11) NOT NULL,
  `user_registration_cookie_timeout_delay` double NOT NULL,
  `sailthru_welcome_template` varchar(20) NOT NULL,
  `sailthru_verification_failed_template` varchar(20) NOT NULL,
  `sailthru_verification_passed_template` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `email_marketing_emai_changed_by_id_15ce753b_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `email_marketing_emai_changed_by_id_15ce753b_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_marketing_emailmarketingconfiguration`
--

LOCK TABLES `email_marketing_emailmarketingconfiguration` WRITE;
/*!40000 ALTER TABLE `email_marketing_emailmarketingconfiguration` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_marketing_emailmarketingconfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `embargo_country`
--

DROP TABLE IF EXISTS `embargo_country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `embargo_country` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `country` varchar(2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `country` (`country`)
) ENGINE=InnoDB AUTO_INCREMENT=251 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `embargo_country`
--

LOCK TABLES `embargo_country` WRITE;
/*!40000 ALTER TABLE `embargo_country` DISABLE KEYS */;
INSERT INTO `embargo_country` VALUES (6,'AD'),(235,'AE'),(1,'AF'),(10,'AG'),(8,'AI'),(3,'AL'),(12,'AM'),(7,'AO'),(9,'AQ'),(11,'AR'),(5,'AS'),(15,'AT'),(14,'AU'),(13,'AW'),(2,'AX'),(16,'AZ'),(29,'BA'),(20,'BB'),(19,'BD'),(22,'BE'),(36,'BF'),(35,'BG'),(18,'BH'),(37,'BI'),(24,'BJ'),(186,'BL'),(25,'BM'),(34,'BN'),(27,'BO'),(28,'BQ'),(32,'BR'),(17,'BS'),(26,'BT'),(31,'BV'),(30,'BW'),(21,'BY'),(23,'BZ'),(41,'CA'),(48,'CC'),(52,'CD'),(43,'CF'),(51,'CG'),(217,'CH'),(55,'CI'),(53,'CK'),(45,'CL'),(40,'CM'),(46,'CN'),(49,'CO'),(54,'CR'),(57,'CU'),(38,'CV'),(58,'CW'),(47,'CX'),(59,'CY'),(60,'CZ'),(84,'DE'),(62,'DJ'),(61,'DK'),(63,'DM'),(64,'DO'),(4,'DZ'),(65,'EC'),(70,'EE'),(66,'EG'),(247,'EH'),(69,'ER'),(211,'ES'),(72,'ET'),(76,'FI'),(75,'FJ'),(73,'FK'),(144,'FM'),(74,'FO'),(77,'FR'),(81,'GA'),(236,'GB'),(89,'GD'),(83,'GE'),(78,'GF'),(93,'GG'),(85,'GH'),(86,'GI'),(88,'GL'),(82,'GM'),(94,'GN'),(90,'GP'),(68,'GQ'),(87,'GR'),(208,'GS'),(92,'GT'),(91,'GU'),(95,'GW'),(96,'GY'),(101,'HK'),(98,'HM'),(100,'HN'),(56,'HR'),(97,'HT'),(102,'HU'),(105,'ID'),(108,'IE'),(110,'IL'),(109,'IM'),(104,'IN'),(33,'IO'),(107,'IQ'),(106,'IR'),(103,'IS'),(111,'IT'),(114,'JE'),(112,'JM'),(115,'JO'),(113,'JP'),(117,'KE'),(121,'KG'),(39,'KH'),(118,'KI'),(50,'KM'),(188,'KN'),(164,'KP'),(209,'KR'),(120,'KW'),(42,'KY'),(116,'KZ'),(122,'LA'),(124,'LB'),(189,'LC'),(128,'LI'),(212,'LK'),(126,'LR'),(125,'LS'),(129,'LT'),(130,'LU'),(123,'LV'),(127,'LY'),(150,'MA'),(146,'MC'),(145,'MD'),(148,'ME'),(190,'MF'),(132,'MG'),(138,'MH'),(165,'MK'),(136,'ML'),(152,'MM'),(147,'MN'),(131,'MO'),(166,'MP'),(139,'MQ'),(140,'MR'),(149,'MS'),(137,'MT'),(141,'MU'),(135,'MV'),(133,'MW'),(143,'MX'),(134,'MY'),(151,'MZ'),(153,'NA'),(157,'NC'),(160,'NE'),(163,'NF'),(161,'NG'),(159,'NI'),(156,'NL'),(167,'NO'),(155,'NP'),(154,'NR'),(162,'NU'),(158,'NZ'),(168,'OM'),(172,'PA'),(175,'PE'),(79,'PF'),(173,'PG'),(176,'PH'),(169,'PK'),(178,'PL'),(191,'PM'),(177,'PN'),(180,'PR'),(171,'PS'),(179,'PT'),(170,'PW'),(174,'PY'),(181,'QA'),(182,'RE'),(183,'RO'),(198,'RS'),(184,'RU'),(185,'RW'),(196,'SA'),(205,'SB'),(199,'SC'),(213,'SD'),(216,'SE'),(201,'SG'),(187,'SH'),(204,'SI'),(215,'SJ'),(203,'SK'),(200,'SL'),(194,'SM'),(197,'SN'),(206,'SO'),(214,'SR'),(210,'SS'),(195,'ST'),(67,'SV'),(202,'SX'),(218,'SY'),(71,'SZ'),(231,'TC'),(44,'TD'),(80,'TF'),(224,'TG'),(222,'TH'),(220,'TJ'),(225,'TK'),(223,'TL'),(230,'TM'),(228,'TN'),(226,'TO'),(229,'TR'),(227,'TT'),(232,'TV'),(219,'TW'),(221,'TZ'),(234,'UA'),(233,'UG'),(237,'UM'),(238,'US'),(239,'UY'),(240,'UZ'),(99,'VA'),(192,'VC'),(242,'VE'),(244,'VG'),(245,'VI'),(243,'VN'),(241,'VU'),(246,'WF'),(193,'WS'),(119,'XK'),(248,'YE'),(142,'YT'),(207,'ZA'),(249,'ZM'),(250,'ZW');
/*!40000 ALTER TABLE `embargo_country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `embargo_countryaccessrule`
--

DROP TABLE IF EXISTS `embargo_countryaccessrule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `embargo_countryaccessrule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rule_type` varchar(255) NOT NULL,
  `country_id` int(11) NOT NULL,
  `restricted_course_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `embargo_countryaccessrul_restricted_course_id_cou_477b6bb1_uniq` (`restricted_course_id`,`country_id`),
  KEY `embargo_countryacces_country_id_6af33e89_fk_embargo_c` (`country_id`),
  CONSTRAINT `embargo_countryacces_country_id_6af33e89_fk_embargo_c` FOREIGN KEY (`country_id`) REFERENCES `embargo_country` (`id`),
  CONSTRAINT `embargo_countryacces_restricted_course_id_eedb3d21_fk_embargo_r` FOREIGN KEY (`restricted_course_id`) REFERENCES `embargo_restrictedcourse` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `embargo_countryaccessrule`
--

LOCK TABLES `embargo_countryaccessrule` WRITE;
/*!40000 ALTER TABLE `embargo_countryaccessrule` DISABLE KEYS */;
/*!40000 ALTER TABLE `embargo_countryaccessrule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `embargo_courseaccessrulehistory`
--

DROP TABLE IF EXISTS `embargo_courseaccessrulehistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `embargo_courseaccessrulehistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` datetime(6) NOT NULL,
  `course_key` varchar(255) NOT NULL,
  `snapshot` longtext,
  PRIMARY KEY (`id`),
  KEY `embargo_courseaccessrulehistory_timestamp_0267f0e6` (`timestamp`),
  KEY `embargo_courseaccessrulehistory_course_key_6f7a7a06` (`course_key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `embargo_courseaccessrulehistory`
--

LOCK TABLES `embargo_courseaccessrulehistory` WRITE;
/*!40000 ALTER TABLE `embargo_courseaccessrulehistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `embargo_courseaccessrulehistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `embargo_embargoedcourse`
--

DROP TABLE IF EXISTS `embargo_embargoedcourse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `embargo_embargoedcourse` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` varchar(255) NOT NULL,
  `embargoed` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `course_id` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `embargo_embargoedcourse`
--

LOCK TABLES `embargo_embargoedcourse` WRITE;
/*!40000 ALTER TABLE `embargo_embargoedcourse` DISABLE KEYS */;
/*!40000 ALTER TABLE `embargo_embargoedcourse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `embargo_embargoedstate`
--

DROP TABLE IF EXISTS `embargo_embargoedstate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `embargo_embargoedstate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `embargoed_countries` longtext NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `embargo_embargoedstate_changed_by_id_f7763260_fk_auth_user_id` (`changed_by_id`),
  CONSTRAINT `embargo_embargoedstate_changed_by_id_f7763260_fk_auth_user_id` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `embargo_embargoedstate`
--

LOCK TABLES `embargo_embargoedstate` WRITE;
/*!40000 ALTER TABLE `embargo_embargoedstate` DISABLE KEYS */;
/*!40000 ALTER TABLE `embargo_embargoedstate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `embargo_ipfilter`
--

DROP TABLE IF EXISTS `embargo_ipfilter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `embargo_ipfilter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `whitelist` longtext NOT NULL,
  `blacklist` longtext NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `embargo_ipfilter_changed_by_id_39e4eed2_fk_auth_user_id` (`changed_by_id`),
  CONSTRAINT `embargo_ipfilter_changed_by_id_39e4eed2_fk_auth_user_id` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `embargo_ipfilter`
--

LOCK TABLES `embargo_ipfilter` WRITE;
/*!40000 ALTER TABLE `embargo_ipfilter` DISABLE KEYS */;
/*!40000 ALTER TABLE `embargo_ipfilter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `embargo_restrictedcourse`
--

DROP TABLE IF EXISTS `embargo_restrictedcourse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `embargo_restrictedcourse` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_key` varchar(255) NOT NULL,
  `enroll_msg_key` varchar(255) NOT NULL,
  `access_msg_key` varchar(255) NOT NULL,
  `disable_access_check` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `course_key` (`course_key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `embargo_restrictedcourse`
--

LOCK TABLES `embargo_restrictedcourse` WRITE;
/*!40000 ALTER TABLE `embargo_restrictedcourse` DISABLE KEYS */;
/*!40000 ALTER TABLE `embargo_restrictedcourse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enterprise_enrollmentnotificationemailtemplate`
--

DROP TABLE IF EXISTS `enterprise_enrollmentnotificationemailtemplate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enterprise_enrollmentnotificationemailtemplate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `plaintext_template` longtext NOT NULL,
  `html_template` longtext NOT NULL,
  `subject_line` varchar(100) NOT NULL,
  `enterprise_customer_id` char(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `enterprise_customer_id` (`enterprise_customer_id`),
  CONSTRAINT `enterprise_enrollmen_enterprise_customer__df17d9ff_fk_enterpris` FOREIGN KEY (`enterprise_customer_id`) REFERENCES `enterprise_enterprisecustomer` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enterprise_enrollmentnotificationemailtemplate`
--

LOCK TABLES `enterprise_enrollmentnotificationemailtemplate` WRITE;
/*!40000 ALTER TABLE `enterprise_enrollmentnotificationemailtemplate` DISABLE KEYS */;
/*!40000 ALTER TABLE `enterprise_enrollmentnotificationemailtemplate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enterprise_enterpriseanalyticsuser`
--

DROP TABLE IF EXISTS `enterprise_enterpriseanalyticsuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enterprise_enterpriseanalyticsuser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `analytics_user_id` varchar(255) NOT NULL,
  `enterprise_customer_user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `enterprise_enterpriseana_enterprise_customer_user_bdd48f28_uniq` (`enterprise_customer_user_id`,`analytics_user_id`),
  CONSTRAINT `enterprise_enterpris_enterprise_customer__006186e8_fk_enterpris` FOREIGN KEY (`enterprise_customer_user_id`) REFERENCES `enterprise_enterprisecustomeruser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enterprise_enterpriseanalyticsuser`
--

LOCK TABLES `enterprise_enterpriseanalyticsuser` WRITE;
/*!40000 ALTER TABLE `enterprise_enterpriseanalyticsuser` DISABLE KEYS */;
/*!40000 ALTER TABLE `enterprise_enterpriseanalyticsuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enterprise_enterprisecatalogquery`
--

DROP TABLE IF EXISTS `enterprise_enterprisecatalogquery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enterprise_enterprisecatalogquery` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content_filter` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enterprise_enterprisecatalogquery`
--

LOCK TABLES `enterprise_enterprisecatalogquery` WRITE;
/*!40000 ALTER TABLE `enterprise_enterprisecatalogquery` DISABLE KEYS */;
/*!40000 ALTER TABLE `enterprise_enterprisecatalogquery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enterprise_enterprisecourseenrollment`
--

DROP TABLE IF EXISTS `enterprise_enterprisecourseenrollment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enterprise_enterprisecourseenrollment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `enterprise_customer_user_id` int(11) NOT NULL,
  `source_id` int(11) DEFAULT NULL,
  `saved_for_later` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `enterprise_enterprisecou_enterprise_customer_user_71fe301a_uniq` (`enterprise_customer_user_id`,`course_id`),
  KEY `enterprise_enterpris_source_id_c347bfa6_fk_enterpris` (`source_id`),
  CONSTRAINT `enterprise_enterpris_enterprise_customer__cf423e59_fk_enterpris` FOREIGN KEY (`enterprise_customer_user_id`) REFERENCES `enterprise_enterprisecustomeruser` (`id`),
  CONSTRAINT `enterprise_enterpris_source_id_c347bfa6_fk_enterpris` FOREIGN KEY (`source_id`) REFERENCES `enterprise_enterpriseenrollmentsource` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enterprise_enterprisecourseenrollment`
--

LOCK TABLES `enterprise_enterprisecourseenrollment` WRITE;
/*!40000 ALTER TABLE `enterprise_enterprisecourseenrollment` DISABLE KEYS */;
/*!40000 ALTER TABLE `enterprise_enterprisecourseenrollment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enterprise_enterprisecustomer`
--

DROP TABLE IF EXISTS `enterprise_enterprisecustomer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enterprise_enterprisecustomer` (
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `uuid` char(32) NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(30) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `country` varchar(2) DEFAULT NULL,
  `hide_course_original_price` tinyint(1) NOT NULL,
  `enable_data_sharing_consent` tinyint(1) NOT NULL,
  `enforce_data_sharing_consent` varchar(25) NOT NULL,
  `enable_audit_enrollment` tinyint(1) NOT NULL,
  `enable_audit_data_reporting` tinyint(1) NOT NULL,
  `replace_sensitive_sso_username` tinyint(1) NOT NULL,
  `enable_autocohorting` tinyint(1) NOT NULL,
  `enable_portal_code_management_screen` tinyint(1) NOT NULL,
  `enable_portal_reporting_config_screen` tinyint(1) NOT NULL,
  `enable_portal_subscription_management_screen` tinyint(1) NOT NULL,
  `enable_learner_portal` tinyint(1) NOT NULL,
  `contact_email` varchar(254) DEFAULT NULL,
  `customer_type_id` int(11) NOT NULL,
  `site_id` int(11) NOT NULL,
  `enable_slug_login` tinyint(1) NOT NULL,
  `enable_portal_saml_configuration_screen` tinyint(1) NOT NULL,
  `default_contract_discount` decimal(8,5) DEFAULT NULL,
  `enable_analytics_screen` tinyint(1) NOT NULL,
  `enable_integrated_customer_learner_portal_search` tinyint(1) NOT NULL,
  `default_language` varchar(25) DEFAULT NULL,
  `enable_portal_lms_configurations_screen` tinyint(1) NOT NULL,
  `sender_alias` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `slug` (`slug`),
  KEY `enterprise_enterpris_customer_type_id_4b1ee315_fk_enterpris` (`customer_type_id`),
  KEY `enterprise_enterprisecustomer_site_id_947ed084_fk_django_site_id` (`site_id`),
  CONSTRAINT `enterprise_enterpris_customer_type_id_4b1ee315_fk_enterpris` FOREIGN KEY (`customer_type_id`) REFERENCES `enterprise_enterprisecustomertype` (`id`),
  CONSTRAINT `enterprise_enterprisecustomer_site_id_947ed084_fk_django_site_id` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enterprise_enterprisecustomer`
--

LOCK TABLES `enterprise_enterprisecustomer` WRITE;
/*!40000 ALTER TABLE `enterprise_enterprisecustomer` DISABLE KEYS */;
/*!40000 ALTER TABLE `enterprise_enterprisecustomer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enterprise_enterprisecustomerbrandingconfiguration`
--

DROP TABLE IF EXISTS `enterprise_enterprisecustomerbrandingconfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enterprise_enterprisecustomerbrandingconfiguration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `enterprise_customer_id` char(32) NOT NULL,
  `primary_color` varchar(7) DEFAULT NULL,
  `secondary_color` varchar(7) DEFAULT NULL,
  `tertiary_color` varchar(7) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `enterprise_customer_id` (`enterprise_customer_id`),
  CONSTRAINT `enterprise_enterpris_enterprise_customer__09c1ee14_fk_enterpris` FOREIGN KEY (`enterprise_customer_id`) REFERENCES `enterprise_enterprisecustomer` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enterprise_enterprisecustomerbrandingconfiguration`
--

LOCK TABLES `enterprise_enterprisecustomerbrandingconfiguration` WRITE;
/*!40000 ALTER TABLE `enterprise_enterprisecustomerbrandingconfiguration` DISABLE KEYS */;
/*!40000 ALTER TABLE `enterprise_enterprisecustomerbrandingconfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enterprise_enterprisecustomercatalog`
--

DROP TABLE IF EXISTS `enterprise_enterprisecustomercatalog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enterprise_enterprisecustomercatalog` (
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `uuid` char(32) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content_filter` longtext,
  `enabled_course_modes` longtext NOT NULL,
  `publish_audit_enrollment_urls` tinyint(1) NOT NULL,
  `enterprise_catalog_query_id` int(11) DEFAULT NULL,
  `enterprise_customer_id` char(32) NOT NULL,
  PRIMARY KEY (`uuid`),
  KEY `enterprise_enterpris_enterprise_catalog_q_aa53eb7d_fk_enterpris` (`enterprise_catalog_query_id`),
  KEY `enterprise_enterpris_enterprise_customer__3b4660ad_fk_enterpris` (`enterprise_customer_id`),
  CONSTRAINT `enterprise_enterpris_enterprise_catalog_q_aa53eb7d_fk_enterpris` FOREIGN KEY (`enterprise_catalog_query_id`) REFERENCES `enterprise_enterprisecatalogquery` (`id`),
  CONSTRAINT `enterprise_enterpris_enterprise_customer__3b4660ad_fk_enterpris` FOREIGN KEY (`enterprise_customer_id`) REFERENCES `enterprise_enterprisecustomer` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enterprise_enterprisecustomercatalog`
--

LOCK TABLES `enterprise_enterprisecustomercatalog` WRITE;
/*!40000 ALTER TABLE `enterprise_enterprisecustomercatalog` DISABLE KEYS */;
/*!40000 ALTER TABLE `enterprise_enterprisecustomercatalog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enterprise_enterprisecustomeridentityprovider`
--

DROP TABLE IF EXISTS `enterprise_enterprisecustomeridentityprovider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enterprise_enterprisecustomeridentityprovider` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `provider_id` varchar(50) NOT NULL,
  `enterprise_customer_id` char(32) NOT NULL,
  `default_provider` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `provider_id` (`provider_id`),
  KEY `enterprise_enterprisecustom_enterprise_customer_id_40b39097` (`enterprise_customer_id`),
  CONSTRAINT `enterprise_enterpris_enterprise_customer__40b39097_fk_enterpris` FOREIGN KEY (`enterprise_customer_id`) REFERENCES `enterprise_enterprisecustomer` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enterprise_enterprisecustomeridentityprovider`
--

LOCK TABLES `enterprise_enterprisecustomeridentityprovider` WRITE;
/*!40000 ALTER TABLE `enterprise_enterprisecustomeridentityprovider` DISABLE KEYS */;
/*!40000 ALTER TABLE `enterprise_enterprisecustomeridentityprovider` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enterprise_enterprisecustomerreportingconfiguration`
--

DROP TABLE IF EXISTS `enterprise_enterprisecustomerreportingconfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enterprise_enterprisecustomerreportingconfiguration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `uuid` char(32) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `include_date` tinyint(1) NOT NULL,
  `delivery_method` varchar(20) NOT NULL,
  `pgp_encryption_key` longtext,
  `data_type` varchar(20) NOT NULL,
  `report_type` varchar(20) NOT NULL,
  `email` longtext NOT NULL,
  `frequency` varchar(20) NOT NULL,
  `day_of_month` smallint(6) DEFAULT NULL,
  `day_of_week` smallint(6) DEFAULT NULL,
  `hour_of_day` smallint(6) NOT NULL,
  `decrypted_password` longblob,
  `sftp_hostname` varchar(256) DEFAULT NULL,
  `sftp_port` int(10) unsigned DEFAULT NULL,
  `sftp_username` varchar(256) DEFAULT NULL,
  `decrypted_sftp_password` longblob,
  `sftp_file_path` varchar(256) DEFAULT NULL,
  `enterprise_customer_id` char(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `enterprise_enterpris_enterprise_customer__d5b55543_fk_enterpris` (`enterprise_customer_id`),
  CONSTRAINT `enterprise_enterpris_enterprise_customer__d5b55543_fk_enterpris` FOREIGN KEY (`enterprise_customer_id`) REFERENCES `enterprise_enterprisecustomer` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enterprise_enterprisecustomerreportingconfiguration`
--

LOCK TABLES `enterprise_enterprisecustomerreportingconfiguration` WRITE;
/*!40000 ALTER TABLE `enterprise_enterprisecustomerreportingconfiguration` DISABLE KEYS */;
/*!40000 ALTER TABLE `enterprise_enterprisecustomerreportingconfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enterprise_enterprisecustomerreportingconfiguration_enterpricf00`
--

DROP TABLE IF EXISTS `enterprise_enterprisecustomerreportingconfiguration_enterpricf00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enterprise_enterprisecustomerreportingconfiguration_enterpricf00` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `enterprisecustomerreportingconfiguration_id` int(11) NOT NULL,
  `enterprisecustomercatalog_id` char(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `enterprise_enterprisecus_enterprisecustomerreport_cc87ab4c_uniq` (`enterprisecustomerreportingconfiguration_id`,`enterprisecustomercatalog_id`),
  KEY `enterprise_enterpris_enterprisecustomerca_ebdae525_fk_enterpris` (`enterprisecustomercatalog_id`),
  CONSTRAINT `enterprise_enterpris_enterprisecustomerca_ebdae525_fk_enterpris` FOREIGN KEY (`enterprisecustomercatalog_id`) REFERENCES `enterprise_enterprisecustomercatalog` (`uuid`),
  CONSTRAINT `enterprise_enterpris_enterprisecustomerre_66147101_fk_enterpris` FOREIGN KEY (`enterprisecustomerreportingconfiguration_id`) REFERENCES `enterprise_enterprisecustomerreportingconfiguration` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enterprise_enterprisecustomerreportingconfiguration_enterpricf00`
--

LOCK TABLES `enterprise_enterprisecustomerreportingconfiguration_enterpricf00` WRITE;
/*!40000 ALTER TABLE `enterprise_enterprisecustomerreportingconfiguration_enterpricf00` DISABLE KEYS */;
/*!40000 ALTER TABLE `enterprise_enterprisecustomerreportingconfiguration_enterpricf00` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enterprise_enterprisecustomertype`
--

DROP TABLE IF EXISTS `enterprise_enterprisecustomertype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enterprise_enterprisecustomertype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `name` varchar(25) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enterprise_enterprisecustomertype`
--

LOCK TABLES `enterprise_enterprisecustomertype` WRITE;
/*!40000 ALTER TABLE `enterprise_enterprisecustomertype` DISABLE KEYS */;
INSERT INTO `enterprise_enterprisecustomertype` VALUES (1,'2021-03-24 08:05:19.962071','2021-03-24 08:05:19.962071','Enterprise');
/*!40000 ALTER TABLE `enterprise_enterprisecustomertype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enterprise_enterprisecustomeruser`
--

DROP TABLE IF EXISTS `enterprise_enterprisecustomeruser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enterprise_enterprisecustomeruser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `active` tinyint(1) NOT NULL,
  `linked` tinyint(1) NOT NULL,
  `enterprise_customer_id` char(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `enterprise_enterprisecus_enterprise_customer_id_u_ffddc29f_uniq` (`enterprise_customer_id`,`user_id`),
  KEY `enterprise_enterprisecustomeruser_user_id_aa8d772f` (`user_id`),
  CONSTRAINT `enterprise_enterpris_enterprise_customer__f0fea924_fk_enterpris` FOREIGN KEY (`enterprise_customer_id`) REFERENCES `enterprise_enterprisecustomer` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enterprise_enterprisecustomeruser`
--

LOCK TABLES `enterprise_enterprisecustomeruser` WRITE;
/*!40000 ALTER TABLE `enterprise_enterprisecustomeruser` DISABLE KEYS */;
/*!40000 ALTER TABLE `enterprise_enterprisecustomeruser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enterprise_enterpriseenrollmentsource`
--

DROP TABLE IF EXISTS `enterprise_enterpriseenrollmentsource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enterprise_enterpriseenrollmentsource` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `name` varchar(64) NOT NULL,
  `slug` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enterprise_enterpriseenrollmentsource`
--

LOCK TABLES `enterprise_enterpriseenrollmentsource` WRITE;
/*!40000 ALTER TABLE `enterprise_enterpriseenrollmentsource` DISABLE KEYS */;
INSERT INTO `enterprise_enterpriseenrollmentsource` VALUES (1,'2021-03-24 08:05:20.525570','2021-03-24 08:05:20.525570','Manual Enterprise Enrollment','manual'),(2,'2021-03-24 08:05:20.528661','2021-03-24 08:05:20.528661','Enterprise API Enrollment','enterprise_api'),(3,'2021-03-24 08:05:20.531940','2021-03-24 08:05:20.531940','Enterprise Enrollment URL','enrollment_url'),(4,'2021-03-24 08:05:20.534066','2021-03-24 08:05:20.534066','Enterprise Offer Redemption','offer_redemption'),(5,'2021-03-24 08:05:20.537314','2021-03-24 08:05:20.537314','Enterprise User Enrollment Background Task','enrollment_task'),(6,'2021-03-24 08:05:20.539090','2021-03-24 08:05:20.539090','Enterprise management command enrollment','management_command');
/*!40000 ALTER TABLE `enterprise_enterpriseenrollmentsource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enterprise_enterprisefeaturerole`
--

DROP TABLE IF EXISTS `enterprise_enterprisefeaturerole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enterprise_enterprisefeaturerole` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enterprise_enterprisefeaturerole`
--

LOCK TABLES `enterprise_enterprisefeaturerole` WRITE;
/*!40000 ALTER TABLE `enterprise_enterprisefeaturerole` DISABLE KEYS */;
INSERT INTO `enterprise_enterprisefeaturerole` VALUES (1,'2021-03-24 08:05:20.434729','2021-03-24 08:05:20.434729','catalog_admin',NULL),(2,'2021-03-24 08:05:20.436889','2021-03-24 08:05:20.436889','dashboard_admin',NULL),(3,'2021-03-24 08:05:20.439061','2021-03-24 08:05:20.439061','enrollment_api_admin',NULL),(4,'2021-03-24 08:05:20.441713','2021-03-24 08:05:20.441713','reporting_config_admin',NULL);
/*!40000 ALTER TABLE `enterprise_enterprisefeaturerole` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enterprise_enterprisefeatureuserroleassignment`
--

DROP TABLE IF EXISTS `enterprise_enterprisefeatureuserroleassignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enterprise_enterprisefeatureuserroleassignment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `role_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `applies_to_all_contexts` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `enterprise_enterpris_role_id_5e8cff42_fk_enterpris` (`role_id`),
  KEY `enterprise_enterpris_user_id_2d335bd4_fk_auth_user` (`user_id`),
  CONSTRAINT `enterprise_enterpris_role_id_5e8cff42_fk_enterpris` FOREIGN KEY (`role_id`) REFERENCES `enterprise_enterprisefeaturerole` (`id`),
  CONSTRAINT `enterprise_enterpris_user_id_2d335bd4_fk_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enterprise_enterprisefeatureuserroleassignment`
--

LOCK TABLES `enterprise_enterprisefeatureuserroleassignment` WRITE;
/*!40000 ALTER TABLE `enterprise_enterprisefeatureuserroleassignment` DISABLE KEYS */;
/*!40000 ALTER TABLE `enterprise_enterprisefeatureuserroleassignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enterprise_historicalenrollmentnotificationemailtemplate`
--

DROP TABLE IF EXISTS `enterprise_historicalenrollmentnotificationemailtemplate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enterprise_historicalenrollmentnotificationemailtemplate` (
  `id` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `plaintext_template` longtext NOT NULL,
  `html_template` longtext NOT NULL,
  `subject_line` varchar(100) NOT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `enterprise_customer_id` char(32) DEFAULT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `enterprise_historica_history_user_id_f2a6d605_fk_auth_user` (`history_user_id`),
  KEY `enterprise_historicalenroll_id_d4b3fed2` (`id`),
  KEY `enterprise_historicalenroll_enterprise_customer_id_bc826535` (`enterprise_customer_id`),
  CONSTRAINT `enterprise_historica_history_user_id_f2a6d605_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enterprise_historicalenrollmentnotificationemailtemplate`
--

LOCK TABLES `enterprise_historicalenrollmentnotificationemailtemplate` WRITE;
/*!40000 ALTER TABLE `enterprise_historicalenrollmentnotificationemailtemplate` DISABLE KEYS */;
/*!40000 ALTER TABLE `enterprise_historicalenrollmentnotificationemailtemplate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enterprise_historicalenterpriseanalyticsuser`
--

DROP TABLE IF EXISTS `enterprise_historicalenterpriseanalyticsuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enterprise_historicalenterpriseanalyticsuser` (
  `id` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `analytics_user_id` varchar(255) NOT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `enterprise_customer_user_id` int(11) DEFAULT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `enterprise_historica_history_user_id_749d5e98_fk_auth_user` (`history_user_id`),
  KEY `enterprise_historicalenterpriseanalyticsuser_id_62dc75c5` (`id`),
  KEY `enterprise_historicalenterp_enterprise_customer_user_id_2b116b91` (`enterprise_customer_user_id`),
  CONSTRAINT `enterprise_historica_history_user_id_749d5e98_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enterprise_historicalenterpriseanalyticsuser`
--

LOCK TABLES `enterprise_historicalenterpriseanalyticsuser` WRITE;
/*!40000 ALTER TABLE `enterprise_historicalenterpriseanalyticsuser` DISABLE KEYS */;
/*!40000 ALTER TABLE `enterprise_historicalenterpriseanalyticsuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enterprise_historicalenterprisecourseenrollment`
--

DROP TABLE IF EXISTS `enterprise_historicalenterprisecourseenrollment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enterprise_historicalenterprisecourseenrollment` (
  `id` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `enterprise_customer_user_id` int(11) DEFAULT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  `source_id` int(11) DEFAULT NULL,
  `saved_for_later` tinyint(1) NOT NULL,
  PRIMARY KEY (`history_id`),
  KEY `enterprise_historica_history_user_id_a7d84786_fk_auth_user` (`history_user_id`),
  KEY `enterprise_historicalenterprisecourseenrollment_id_452a4b04` (`id`),
  KEY `enterprise_historicalenterp_enterprise_customer_user_id_380ecc4e` (`enterprise_customer_user_id`),
  KEY `enterprise_historicalenterp_source_id_015c9e9c` (`source_id`),
  CONSTRAINT `enterprise_historica_history_user_id_a7d84786_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enterprise_historicalenterprisecourseenrollment`
--

LOCK TABLES `enterprise_historicalenterprisecourseenrollment` WRITE;
/*!40000 ALTER TABLE `enterprise_historicalenterprisecourseenrollment` DISABLE KEYS */;
/*!40000 ALTER TABLE `enterprise_historicalenterprisecourseenrollment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enterprise_historicalenterprisecustomer`
--

DROP TABLE IF EXISTS `enterprise_historicalenterprisecustomer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enterprise_historicalenterprisecustomer` (
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `uuid` char(32) NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(30) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `country` varchar(2) DEFAULT NULL,
  `hide_course_original_price` tinyint(1) NOT NULL,
  `enable_data_sharing_consent` tinyint(1) NOT NULL,
  `enforce_data_sharing_consent` varchar(25) NOT NULL,
  `enable_audit_enrollment` tinyint(1) NOT NULL,
  `enable_audit_data_reporting` tinyint(1) NOT NULL,
  `replace_sensitive_sso_username` tinyint(1) NOT NULL,
  `enable_autocohorting` tinyint(1) NOT NULL,
  `enable_portal_code_management_screen` tinyint(1) NOT NULL,
  `enable_portal_reporting_config_screen` tinyint(1) NOT NULL,
  `enable_portal_subscription_management_screen` tinyint(1) NOT NULL,
  `enable_learner_portal` tinyint(1) NOT NULL,
  `contact_email` varchar(254) DEFAULT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `customer_type_id` int(11) DEFAULT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `enable_slug_login` tinyint(1) NOT NULL,
  `enable_portal_saml_configuration_screen` tinyint(1) NOT NULL,
  `default_contract_discount` decimal(8,5) DEFAULT NULL,
  `enable_analytics_screen` tinyint(1) NOT NULL,
  `enable_integrated_customer_learner_portal_search` tinyint(1) NOT NULL,
  `default_language` varchar(25) DEFAULT NULL,
  `enable_portal_lms_configurations_screen` tinyint(1) NOT NULL,
  `sender_alias` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `enterprise_historica_history_user_id_bbd9b0d6_fk_auth_user` (`history_user_id`),
  KEY `enterprise_historicalenterprisecustomer_uuid_75c3528e` (`uuid`),
  KEY `enterprise_historicalenterprisecustomer_slug_04622dd4` (`slug`),
  KEY `enterprise_historicalenterp_customer_type_id_8fbc8526` (`customer_type_id`),
  KEY `enterprise_historicalenterprisecustomer_site_id_2463b5d7` (`site_id`),
  CONSTRAINT `enterprise_historica_history_user_id_bbd9b0d6_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enterprise_historicalenterprisecustomer`
--

LOCK TABLES `enterprise_historicalenterprisecustomer` WRITE;
/*!40000 ALTER TABLE `enterprise_historicalenterprisecustomer` DISABLE KEYS */;
/*!40000 ALTER TABLE `enterprise_historicalenterprisecustomer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enterprise_historicalenterprisecustomercatalog`
--

DROP TABLE IF EXISTS `enterprise_historicalenterprisecustomercatalog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enterprise_historicalenterprisecustomercatalog` (
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `uuid` char(32) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content_filter` longtext,
  `enabled_course_modes` longtext NOT NULL,
  `publish_audit_enrollment_urls` tinyint(1) NOT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `enterprise_catalog_query_id` int(11) DEFAULT NULL,
  `enterprise_customer_id` char(32) DEFAULT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `enterprise_historica_history_user_id_31eab231_fk_auth_user` (`history_user_id`),
  KEY `enterprise_historicalenterprisecustomercatalog_uuid_42403101` (`uuid`),
  KEY `enterprise_historicalenterp_enterprise_catalog_query_id_bf435a3a` (`enterprise_catalog_query_id`),
  KEY `enterprise_historicalenterp_enterprise_customer_id_664f4480` (`enterprise_customer_id`),
  CONSTRAINT `enterprise_historica_history_user_id_31eab231_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enterprise_historicalenterprisecustomercatalog`
--

LOCK TABLES `enterprise_historicalenterprisecustomercatalog` WRITE;
/*!40000 ALTER TABLE `enterprise_historicalenterprisecustomercatalog` DISABLE KEYS */;
/*!40000 ALTER TABLE `enterprise_historicalenterprisecustomercatalog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enterprise_historicallicensedenterprisecourseenrollment`
--

DROP TABLE IF EXISTS `enterprise_historicallicensedenterprisecourseenrollment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enterprise_historicallicensedenterprisecourseenrollment` (
  `id` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `license_uuid` char(32) NOT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `enterprise_course_enrollment_id` int(11) DEFAULT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  `is_revoked` tinyint(1) NOT NULL,
  PRIMARY KEY (`history_id`),
  KEY `enterprise_historica_history_user_id_1db87766_fk_auth_user` (`history_user_id`),
  KEY `enterprise_historicallicens_id_ff4cfd4f` (`id`),
  KEY `enterprise_historicallicens_enterprise_course_enrollmen_1b0d3427` (`enterprise_course_enrollment_id`),
  CONSTRAINT `enterprise_historica_history_user_id_1db87766_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enterprise_historicallicensedenterprisecourseenrollment`
--

LOCK TABLES `enterprise_historicallicensedenterprisecourseenrollment` WRITE;
/*!40000 ALTER TABLE `enterprise_historicallicensedenterprisecourseenrollment` DISABLE KEYS */;
/*!40000 ALTER TABLE `enterprise_historicallicensedenterprisecourseenrollment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enterprise_historicalpendingenrollment`
--

DROP TABLE IF EXISTS `enterprise_historicalpendingenrollment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enterprise_historicalpendingenrollment` (
  `id` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `course_mode` varchar(25) NOT NULL,
  `cohort_name` varchar(255) DEFAULT NULL,
  `discount_percentage` decimal(8,5) NOT NULL,
  `sales_force_id` varchar(255) DEFAULT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  `source_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `license_uuid` char(32) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `enterprise_historica_history_user_id_894ad7d0_fk_auth_user` (`history_user_id`),
  KEY `enterprise_historicalpendingenrollment_id_27077b0b` (`id`),
  KEY `enterprise_historicalpendingenrollment_source_id_3a208cd2` (`source_id`),
  KEY `enterprise_historicalpendingenrollment_user_id_97ded265` (`user_id`),
  CONSTRAINT `enterprise_historica_history_user_id_894ad7d0_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enterprise_historicalpendingenrollment`
--

LOCK TABLES `enterprise_historicalpendingenrollment` WRITE;
/*!40000 ALTER TABLE `enterprise_historicalpendingenrollment` DISABLE KEYS */;
/*!40000 ALTER TABLE `enterprise_historicalpendingenrollment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enterprise_historicalpendingenterprisecustomeradminuser`
--

DROP TABLE IF EXISTS `enterprise_historicalpendingenterprisecustomeradminuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enterprise_historicalpendingenterprisecustomeradminuser` (
  `id` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `user_email` varchar(254) NOT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `enterprise_customer_id` char(32) DEFAULT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `enterprise_historica_history_user_id_3a051cc8_fk_auth_user` (`history_user_id`),
  KEY `enterprise_historicalpendin_id_46b9ceba` (`id`),
  KEY `enterprise_historicalpendin_enterprise_customer_id_885a7c1b` (`enterprise_customer_id`),
  CONSTRAINT `enterprise_historica_history_user_id_3a051cc8_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enterprise_historicalpendingenterprisecustomeradminuser`
--

LOCK TABLES `enterprise_historicalpendingenterprisecustomeradminuser` WRITE;
/*!40000 ALTER TABLE `enterprise_historicalpendingenterprisecustomeradminuser` DISABLE KEYS */;
/*!40000 ALTER TABLE `enterprise_historicalpendingenterprisecustomeradminuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enterprise_historicalpendingenterprisecustomeruser`
--

DROP TABLE IF EXISTS `enterprise_historicalpendingenterprisecustomeruser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enterprise_historicalpendingenterprisecustomeruser` (
  `id` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `user_email` varchar(254) NOT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `enterprise_customer_id` char(32) DEFAULT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `enterprise_historica_history_user_id_c491461b_fk_auth_user` (`history_user_id`),
  KEY `enterprise_historicalpendingenterprisecustomeruser_id_3cf88198` (`id`),
  KEY `enterprise_historicalpendin_enterprise_customer_id_6c02ed95` (`enterprise_customer_id`),
  CONSTRAINT `enterprise_historica_history_user_id_c491461b_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enterprise_historicalpendingenterprisecustomeruser`
--

LOCK TABLES `enterprise_historicalpendingenterprisecustomeruser` WRITE;
/*!40000 ALTER TABLE `enterprise_historicalpendingenterprisecustomeruser` DISABLE KEYS */;
/*!40000 ALTER TABLE `enterprise_historicalpendingenterprisecustomeruser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enterprise_licensedenterprisecourseenrollment`
--

DROP TABLE IF EXISTS `enterprise_licensedenterprisecourseenrollment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enterprise_licensedenterprisecourseenrollment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `license_uuid` char(32) NOT NULL,
  `enterprise_course_enrollment_id` int(11) NOT NULL,
  `is_revoked` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `enterprise_course_enrollment_id` (`enterprise_course_enrollment_id`),
  CONSTRAINT `enterprise_licensede_enterprise_course_en_db2f5a9f_fk_enterpris` FOREIGN KEY (`enterprise_course_enrollment_id`) REFERENCES `enterprise_enterprisecourseenrollment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enterprise_licensedenterprisecourseenrollment`
--

LOCK TABLES `enterprise_licensedenterprisecourseenrollment` WRITE;
/*!40000 ALTER TABLE `enterprise_licensedenterprisecourseenrollment` DISABLE KEYS */;
/*!40000 ALTER TABLE `enterprise_licensedenterprisecourseenrollment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enterprise_pendingenrollment`
--

DROP TABLE IF EXISTS `enterprise_pendingenrollment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enterprise_pendingenrollment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `course_mode` varchar(25) NOT NULL,
  `cohort_name` varchar(255) DEFAULT NULL,
  `discount_percentage` decimal(8,5) NOT NULL,
  `sales_force_id` varchar(255) DEFAULT NULL,
  `source_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `license_uuid` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `enterprise_pendingenrollment_user_id_course_id_6d4141c7_uniq` (`user_id`,`course_id`),
  KEY `enterprise_pendingen_source_id_7b6fed0c_fk_enterpris` (`source_id`),
  CONSTRAINT `enterprise_pendingen_source_id_7b6fed0c_fk_enterpris` FOREIGN KEY (`source_id`) REFERENCES `enterprise_enterpriseenrollmentsource` (`id`),
  CONSTRAINT `enterprise_pendingen_user_id_12d21b1a_fk_enterpris` FOREIGN KEY (`user_id`) REFERENCES `enterprise_pendingenterprisecustomeruser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enterprise_pendingenrollment`
--

LOCK TABLES `enterprise_pendingenrollment` WRITE;
/*!40000 ALTER TABLE `enterprise_pendingenrollment` DISABLE KEYS */;
/*!40000 ALTER TABLE `enterprise_pendingenrollment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enterprise_pendingenterprisecustomeradminuser`
--

DROP TABLE IF EXISTS `enterprise_pendingenterprisecustomeradminuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enterprise_pendingenterprisecustomeradminuser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `user_email` varchar(254) NOT NULL,
  `enterprise_customer_id` char(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique pending admin user and EnterpriseCustomer` (`user_email`,`enterprise_customer_id`),
  KEY `enterprise_pendingenterpris_enterprise_customer_id_aae02661` (`enterprise_customer_id`),
  KEY `enterprise__user_em_fead22_idx` (`user_email`,`enterprise_customer_id`),
  KEY `enterprise__user_em_6e1f5b_idx` (`user_email`),
  CONSTRAINT `enterprise_pendingen_enterprise_customer__aae02661_fk_enterpris` FOREIGN KEY (`enterprise_customer_id`) REFERENCES `enterprise_enterprisecustomer` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enterprise_pendingenterprisecustomeradminuser`
--

LOCK TABLES `enterprise_pendingenterprisecustomeradminuser` WRITE;
/*!40000 ALTER TABLE `enterprise_pendingenterprisecustomeradminuser` DISABLE KEYS */;
/*!40000 ALTER TABLE `enterprise_pendingenterprisecustomeradminuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enterprise_pendingenterprisecustomeruser`
--

DROP TABLE IF EXISTS `enterprise_pendingenterprisecustomeruser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enterprise_pendingenterprisecustomeruser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `user_email` varchar(254) NOT NULL,
  `enterprise_customer_id` char(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique user and EnterpriseCustomer` (`user_email`,`enterprise_customer_id`),
  KEY `enterprise_pendingen_enterprise_customer__a858ce2d_fk_enterpris` (`enterprise_customer_id`),
  KEY `enterprise__user_em_f98d36_idx` (`user_email`,`enterprise_customer_id`),
  KEY `enterprise__user_em_488930_idx` (`user_email`),
  CONSTRAINT `enterprise_pendingen_enterprise_customer__a858ce2d_fk_enterpris` FOREIGN KEY (`enterprise_customer_id`) REFERENCES `enterprise_enterprisecustomer` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enterprise_pendingenterprisecustomeruser`
--

LOCK TABLES `enterprise_pendingenterprisecustomeruser` WRITE;
/*!40000 ALTER TABLE `enterprise_pendingenterprisecustomeruser` DISABLE KEYS */;
/*!40000 ALTER TABLE `enterprise_pendingenterprisecustomeruser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enterprise_systemwideenterpriserole`
--

DROP TABLE IF EXISTS `enterprise_systemwideenterpriserole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enterprise_systemwideenterpriserole` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enterprise_systemwideenterpriserole`
--

LOCK TABLES `enterprise_systemwideenterpriserole` WRITE;
/*!40000 ALTER TABLE `enterprise_systemwideenterpriserole` DISABLE KEYS */;
INSERT INTO `enterprise_systemwideenterpriserole` VALUES (1,'2021-03-24 08:05:20.426474','2021-03-24 08:05:20.426474','enterprise_admin',NULL),(2,'2021-03-24 08:05:20.429863','2021-03-24 08:05:20.429863','enterprise_learner',NULL),(3,'2021-03-24 08:05:20.431810','2021-03-24 08:05:20.431810','enterprise_openedx_operator',NULL),(4,'2021-03-24 08:05:21.908886','2021-03-24 08:05:21.908886','enterprise_catalog_admin','Role for access to endpoints in the enterprise catalog service');
/*!40000 ALTER TABLE `enterprise_systemwideenterpriserole` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enterprise_systemwideenterpriseuserroleassignment`
--

DROP TABLE IF EXISTS `enterprise_systemwideenterpriseuserroleassignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enterprise_systemwideenterpriseuserroleassignment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `role_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `applies_to_all_contexts` tinyint(1) NOT NULL,
  `enterprise_customer_id` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `enterprise_systemwid_role_id_bc7092f0_fk_enterpris` (`role_id`),
  KEY `enterprise_systemwid_user_id_e890aef2_fk_auth_user` (`user_id`),
  KEY `enterprise_systemwid_enterprise_customer__0136c565_fk_enterpris` (`enterprise_customer_id`),
  CONSTRAINT `enterprise_systemwid_enterprise_customer__0136c565_fk_enterpris` FOREIGN KEY (`enterprise_customer_id`) REFERENCES `enterprise_enterprisecustomer` (`uuid`),
  CONSTRAINT `enterprise_systemwid_role_id_bc7092f0_fk_enterpris` FOREIGN KEY (`role_id`) REFERENCES `enterprise_systemwideenterpriserole` (`id`),
  CONSTRAINT `enterprise_systemwid_user_id_e890aef2_fk_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enterprise_systemwideenterpriseuserroleassignment`
--

LOCK TABLES `enterprise_systemwideenterpriseuserroleassignment` WRITE;
/*!40000 ALTER TABLE `enterprise_systemwideenterpriseuserroleassignment` DISABLE KEYS */;
/*!40000 ALTER TABLE `enterprise_systemwideenterpriseuserroleassignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enterprise_updateroleassignmentswithcustomersconfig`
--

DROP TABLE IF EXISTS `enterprise_updateroleassignmentswithcustomersconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enterprise_updateroleassignmentswithcustomersconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `role` varchar(100) NOT NULL,
  `batch_size` int(11) NOT NULL,
  `enterprise_customer_uuid` varchar(36) NOT NULL,
  `dry_run` tinyint(1) NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `enterprise_updaterol_changed_by_id_1053fb4d_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `enterprise_updaterol_changed_by_id_1053fb4d_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enterprise_updateroleassignmentswithcustomersconfig`
--

LOCK TABLES `enterprise_updateroleassignmentswithcustomersconfig` WRITE;
/*!40000 ALTER TABLE `enterprise_updateroleassignmentswithcustomersconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `enterprise_updateroleassignmentswithcustomersconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entitlements_courseentitlement`
--

DROP TABLE IF EXISTS `entitlements_courseentitlement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entitlements_courseentitlement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `uuid` char(32) NOT NULL,
  `course_uuid` char(32) NOT NULL,
  `expired_at` datetime(6) DEFAULT NULL,
  `mode` varchar(100) NOT NULL,
  `order_number` varchar(128) DEFAULT NULL,
  `enrollment_course_run_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `_policy_id` int(11) DEFAULT NULL,
  `refund_locked` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entitlements_courseentitlement_uuid_2228ffad_uniq` (`uuid`),
  UNIQUE KEY `entitlements_courseentit_course_uuid_order_number_b37c9e13_uniq` (`course_uuid`,`order_number`),
  KEY `entitlements_courseentitlement_user_id_a518a225_fk_auth_user_id` (`user_id`),
  KEY `entitlements_coursee_enrollment_course_ru_3fc796af_fk_student_c` (`enrollment_course_run_id`),
  KEY `entitlements_coursee__policy_id_37bd7c13_fk_entitleme` (`_policy_id`),
  CONSTRAINT `entitlements_coursee__policy_id_37bd7c13_fk_entitleme` FOREIGN KEY (`_policy_id`) REFERENCES `entitlements_courseentitlementpolicy` (`id`),
  CONSTRAINT `entitlements_coursee_enrollment_course_ru_3fc796af_fk_student_c` FOREIGN KEY (`enrollment_course_run_id`) REFERENCES `student_courseenrollment` (`id`),
  CONSTRAINT `entitlements_courseentitlement_user_id_a518a225_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entitlements_courseentitlement`
--

LOCK TABLES `entitlements_courseentitlement` WRITE;
/*!40000 ALTER TABLE `entitlements_courseentitlement` DISABLE KEYS */;
/*!40000 ALTER TABLE `entitlements_courseentitlement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entitlements_courseentitlementpolicy`
--

DROP TABLE IF EXISTS `entitlements_courseentitlementpolicy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entitlements_courseentitlementpolicy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `expiration_period` bigint(20) NOT NULL,
  `refund_period` bigint(20) NOT NULL,
  `regain_period` bigint(20) NOT NULL,
  `site_id` int(11) DEFAULT NULL,
  `mode` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entitlements_coursee_site_id_c7a9e107_fk_django_si` (`site_id`),
  CONSTRAINT `entitlements_coursee_site_id_c7a9e107_fk_django_si` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entitlements_courseentitlementpolicy`
--

LOCK TABLES `entitlements_courseentitlementpolicy` WRITE;
/*!40000 ALTER TABLE `entitlements_courseentitlementpolicy` DISABLE KEYS */;
/*!40000 ALTER TABLE `entitlements_courseentitlementpolicy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entitlements_courseentitlementsupportdetail`
--

DROP TABLE IF EXISTS `entitlements_courseentitlementsupportdetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entitlements_courseentitlementsupportdetail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `reason` varchar(15) NOT NULL,
  `comments` longtext,
  `entitlement_id` int(11) NOT NULL,
  `support_user_id` int(11) NOT NULL,
  `unenrolled_run_id` varchar(255) DEFAULT NULL,
  `action` varchar(15) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `entitlements_coursee_entitlement_id_93b9020b_fk_entitleme` (`entitlement_id`),
  KEY `entitlements_coursee_support_user_id_97d3095e_fk_auth_user` (`support_user_id`),
  KEY `entitlements_courseentitlem_unenrolled_run_id_d72860e3` (`unenrolled_run_id`),
  CONSTRAINT `entitlements_coursee_entitlement_id_93b9020b_fk_entitleme` FOREIGN KEY (`entitlement_id`) REFERENCES `entitlements_courseentitlement` (`id`),
  CONSTRAINT `entitlements_coursee_support_user_id_97d3095e_fk_auth_user` FOREIGN KEY (`support_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entitlements_courseentitlementsupportdetail`
--

LOCK TABLES `entitlements_courseentitlementsupportdetail` WRITE;
/*!40000 ALTER TABLE `entitlements_courseentitlementsupportdetail` DISABLE KEYS */;
/*!40000 ALTER TABLE `entitlements_courseentitlementsupportdetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entitlements_historicalcourseentitlement`
--

DROP TABLE IF EXISTS `entitlements_historicalcourseentitlement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entitlements_historicalcourseentitlement` (
  `id` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `uuid` char(32) NOT NULL,
  `course_uuid` char(32) NOT NULL,
  `expired_at` datetime(6) DEFAULT NULL,
  `mode` varchar(100) NOT NULL,
  `order_number` varchar(128) DEFAULT NULL,
  `refund_locked` tinyint(1) NOT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `_policy_id` int(11) DEFAULT NULL,
  `enrollment_course_run_id` int(11) DEFAULT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `entitlements_histori_history_user_id_a3bc1823_fk_auth_user` (`history_user_id`),
  KEY `entitlements_historicalcourseentitlement_id_e3740062` (`id`),
  KEY `entitlements_historicalcourseentitlement_uuid_54fd331f` (`uuid`),
  KEY `entitlements_historicalcourseentitlement__policy_id_71c21d43` (`_policy_id`),
  KEY `entitlements_historicalcour_enrollment_course_run_id_1b92719b` (`enrollment_course_run_id`),
  KEY `entitlements_historicalcourseentitlement_user_id_c770997b` (`user_id`),
  CONSTRAINT `entitlements_histori_history_user_id_a3bc1823_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entitlements_historicalcourseentitlement`
--

LOCK TABLES `entitlements_historicalcourseentitlement` WRITE;
/*!40000 ALTER TABLE `entitlements_historicalcourseentitlement` DISABLE KEYS */;
/*!40000 ALTER TABLE `entitlements_historicalcourseentitlement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entitlements_historicalcourseentitlementsupportdetail`
--

DROP TABLE IF EXISTS `entitlements_historicalcourseentitlementsupportdetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entitlements_historicalcourseentitlementsupportdetail` (
  `id` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `reason` varchar(15) NOT NULL,
  `action` varchar(15) NOT NULL,
  `comments` longtext,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `entitlement_id` int(11) DEFAULT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  `support_user_id` int(11) DEFAULT NULL,
  `unenrolled_run_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `entitlements_histori_history_user_id_b00a74ce_fk_auth_user` (`history_user_id`),
  KEY `entitlements_historicalcour_id_d019368b` (`id`),
  KEY `entitlements_historicalcour_entitlement_id_a5a6c6cc` (`entitlement_id`),
  KEY `entitlements_historicalcour_support_user_id_8788841f` (`support_user_id`),
  KEY `entitlements_historicalcour_unenrolled_run_id_67b11a08` (`unenrolled_run_id`),
  CONSTRAINT `entitlements_histori_history_user_id_b00a74ce_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entitlements_historicalcourseentitlementsupportdetail`
--

LOCK TABLES `entitlements_historicalcourseentitlementsupportdetail` WRITE;
/*!40000 ALTER TABLE `entitlements_historicalcourseentitlementsupportdetail` DISABLE KEYS */;
/*!40000 ALTER TABLE `entitlements_historicalcourseentitlementsupportdetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_routing_backends_routerconfiguration`
--

DROP TABLE IF EXISTS `event_routing_backends_routerconfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_routing_backends_routerconfiguration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `backend_name` varchar(50) NOT NULL,
  `configurations` longblob NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `event_routing_backen_changed_by_id_32085a77_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `event_routing_backen_changed_by_id_32085a77_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_routing_backends_routerconfiguration`
--

LOCK TABLES `event_routing_backends_routerconfiguration` WRITE;
/*!40000 ALTER TABLE `event_routing_backends_routerconfiguration` DISABLE KEYS */;
/*!40000 ALTER TABLE `event_routing_backends_routerconfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `experiments_experimentdata`
--

DROP TABLE IF EXISTS `experiments_experimentdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `experiments_experimentdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `experiment_id` smallint(5) unsigned NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` longtext NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `experiments_experimentda_user_id_experiment_id_ke_0ff27a32_uniq` (`user_id`,`experiment_id`,`key`),
  KEY `experiments_experimentdata_user_id_experiment_id_15bd1b30_idx` (`user_id`,`experiment_id`),
  KEY `experiments_experimentdata_experiment_id_e816cee5` (`experiment_id`),
  CONSTRAINT `experiments_experimentdata_user_id_bd6f4720_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `experiments_experimentdata`
--

LOCK TABLES `experiments_experimentdata` WRITE;
/*!40000 ALTER TABLE `experiments_experimentdata` DISABLE KEYS */;
/*!40000 ALTER TABLE `experiments_experimentdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `experiments_experimentkeyvalue`
--

DROP TABLE IF EXISTS `experiments_experimentkeyvalue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `experiments_experimentkeyvalue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `experiment_id` smallint(5) unsigned NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `experiments_experimentkeyvalue_experiment_id_key_15347f43_uniq` (`experiment_id`,`key`),
  KEY `experiments_experimentkeyvalue_experiment_id_741d1a4b` (`experiment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `experiments_experimentkeyvalue`
--

LOCK TABLES `experiments_experimentkeyvalue` WRITE;
/*!40000 ALTER TABLE `experiments_experimentkeyvalue` DISABLE KEYS */;
/*!40000 ALTER TABLE `experiments_experimentkeyvalue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `experiments_historicalexperimentkeyvalue`
--

DROP TABLE IF EXISTS `experiments_historicalexperimentkeyvalue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `experiments_historicalexperimentkeyvalue` (
  `id` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `experiment_id` smallint(5) unsigned NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` longtext NOT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `experiments_historic_history_user_id_3892eb1a_fk_auth_user` (`history_user_id`),
  KEY `experiments_historicalexperimentkeyvalue_id_13f6f6d3` (`id`),
  KEY `experiments_historicalexperimentkeyvalue_experiment_id_6a3c1624` (`experiment_id`),
  CONSTRAINT `experiments_historic_history_user_id_3892eb1a_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `experiments_historicalexperimentkeyvalue`
--

LOCK TABLES `experiments_historicalexperimentkeyvalue` WRITE;
/*!40000 ALTER TABLE `experiments_historicalexperimentkeyvalue` DISABLE KEYS */;
/*!40000 ALTER TABLE `experiments_historicalexperimentkeyvalue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `external_user_ids_externalid`
--

DROP TABLE IF EXISTS `external_user_ids_externalid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `external_user_ids_externalid` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `external_user_id` char(32) NOT NULL,
  `external_id_type_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `external_user_id` (`external_user_id`),
  UNIQUE KEY `external_user_ids_extern_user_id_external_id_type_cf1d16bc_uniq` (`user_id`,`external_id_type_id`),
  KEY `external_user_ids_ex_external_id_type_id_421db1af_fk_external_` (`external_id_type_id`),
  CONSTRAINT `external_user_ids_ex_external_id_type_id_421db1af_fk_external_` FOREIGN KEY (`external_id_type_id`) REFERENCES `external_user_ids_externalidtype` (`id`),
  CONSTRAINT `external_user_ids_externalid_user_id_7789441b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `external_user_ids_externalid`
--

LOCK TABLES `external_user_ids_externalid` WRITE;
/*!40000 ALTER TABLE `external_user_ids_externalid` DISABLE KEYS */;
/*!40000 ALTER TABLE `external_user_ids_externalid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `external_user_ids_externalidtype`
--

DROP TABLE IF EXISTS `external_user_ids_externalidtype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `external_user_ids_externalidtype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `name` varchar(32) NOT NULL,
  `description` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `external_user_ids_externalidtype`
--

LOCK TABLES `external_user_ids_externalidtype` WRITE;
/*!40000 ALTER TABLE `external_user_ids_externalidtype` DISABLE KEYS */;
INSERT INTO `external_user_ids_externalidtype` VALUES (1,'2021-03-24 08:06:30.906916','2021-03-24 08:06:30.906916','mb_coaching','MicroBachelors Coaching'),(2,'2021-03-24 08:06:31.290800','2021-03-24 08:06:31.290800','lti','LTI Xblock launches');
/*!40000 ALTER TABLE `external_user_ids_externalidtype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `external_user_ids_historicalexternalid`
--

DROP TABLE IF EXISTS `external_user_ids_historicalexternalid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `external_user_ids_historicalexternalid` (
  `id` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `external_user_id` char(32) NOT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `external_id_type_id` int(11) DEFAULT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `external_user_ids_hi_history_user_id_fd67f897_fk_auth_user` (`history_user_id`),
  KEY `external_user_ids_historicalexternalid_id_1444e43e` (`id`),
  KEY `external_user_ids_historicalexternalid_external_user_id_03a5f871` (`external_user_id`),
  KEY `external_user_ids_historica_external_id_type_id_74b65da9` (`external_id_type_id`),
  KEY `external_user_ids_historicalexternalid_user_id_64337ddb` (`user_id`),
  CONSTRAINT `external_user_ids_hi_history_user_id_fd67f897_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `external_user_ids_historicalexternalid`
--

LOCK TABLES `external_user_ids_historicalexternalid` WRITE;
/*!40000 ALTER TABLE `external_user_ids_historicalexternalid` DISABLE KEYS */;
/*!40000 ALTER TABLE `external_user_ids_historicalexternalid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `external_user_ids_historicalexternalidtype`
--

DROP TABLE IF EXISTS `external_user_ids_historicalexternalidtype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `external_user_ids_historicalexternalidtype` (
  `id` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `name` varchar(32) NOT NULL,
  `description` longtext NOT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `external_user_ids_hi_history_user_id_6a2c78fc_fk_auth_user` (`history_user_id`),
  KEY `external_user_ids_historicalexternalidtype_id_4cc44c83` (`id`),
  KEY `external_user_ids_historicalexternalidtype_name_a2e9fa4e` (`name`),
  CONSTRAINT `external_user_ids_hi_history_user_id_6a2c78fc_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `external_user_ids_historicalexternalidtype`
--

LOCK TABLES `external_user_ids_historicalexternalidtype` WRITE;
/*!40000 ALTER TABLE `external_user_ids_historicalexternalidtype` DISABLE KEYS */;
/*!40000 ALTER TABLE `external_user_ids_historicalexternalidtype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grades_computegradessetting`
--

DROP TABLE IF EXISTS `grades_computegradessetting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grades_computegradessetting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `batch_size` int(11) NOT NULL,
  `course_ids` longtext NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `grades_computegrades_changed_by_id_f2bf3678_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `grades_computegrades_changed_by_id_f2bf3678_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grades_computegradessetting`
--

LOCK TABLES `grades_computegradessetting` WRITE;
/*!40000 ALTER TABLE `grades_computegradessetting` DISABLE KEYS */;
/*!40000 ALTER TABLE `grades_computegradessetting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grades_coursepersistentgradesflag`
--

DROP TABLE IF EXISTS `grades_coursepersistentgradesflag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grades_coursepersistentgradesflag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `grades_coursepersist_changed_by_id_c8c392d6_fk_auth_user` (`changed_by_id`),
  KEY `grades_coursepersistentgradesflag_course_id_b494f1e7` (`course_id`),
  CONSTRAINT `grades_coursepersist_changed_by_id_c8c392d6_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grades_coursepersistentgradesflag`
--

LOCK TABLES `grades_coursepersistentgradesflag` WRITE;
/*!40000 ALTER TABLE `grades_coursepersistentgradesflag` DISABLE KEYS */;
/*!40000 ALTER TABLE `grades_coursepersistentgradesflag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grades_historicalpersistentsubsectiongradeoverride`
--

DROP TABLE IF EXISTS `grades_historicalpersistentsubsectiongradeoverride`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grades_historicalpersistentsubsectiongradeoverride` (
  `id` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `earned_all_override` double DEFAULT NULL,
  `possible_all_override` double DEFAULT NULL,
  `earned_graded_override` double DEFAULT NULL,
  `possible_graded_override` double DEFAULT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `grade_id` bigint(20) unsigned DEFAULT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  `override_reason` varchar(300) DEFAULT NULL,
  `system` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `grades_historicalper_history_user_id_05000562_fk_auth_user` (`history_user_id`),
  KEY `grades_historicalpersistentsubsectiongradeoverride_id_e30d8953` (`id`),
  KEY `grades_historicalpersistent_created_e5fb4d96` (`created`),
  KEY `grades_historicalpersistent_modified_7355e846` (`modified`),
  KEY `grades_historicalpersistent_grade_id_ecfb45cc` (`grade_id`),
  CONSTRAINT `grades_historicalper_history_user_id_05000562_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grades_historicalpersistentsubsectiongradeoverride`
--

LOCK TABLES `grades_historicalpersistentsubsectiongradeoverride` WRITE;
/*!40000 ALTER TABLE `grades_historicalpersistentsubsectiongradeoverride` DISABLE KEYS */;
/*!40000 ALTER TABLE `grades_historicalpersistentsubsectiongradeoverride` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grades_persistentcoursegrade`
--

DROP TABLE IF EXISTS `grades_persistentcoursegrade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grades_persistentcoursegrade` (
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `course_edited_timestamp` datetime(6) DEFAULT NULL,
  `course_version` varchar(255) NOT NULL,
  `grading_policy_hash` varchar(255) NOT NULL,
  `percent_grade` double NOT NULL,
  `letter_grade` varchar(255) NOT NULL,
  `passed_timestamp` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `grades_persistentcoursegrade_course_id_user_id_d7b585c9_uniq` (`course_id`,`user_id`),
  KEY `grades_persistentcoursegrade_user_id_b2296589` (`user_id`),
  KEY `grades_persistentcoursegr_passed_timestamp_course_i_27d4396e_idx` (`passed_timestamp`,`course_id`),
  KEY `grades_persistentcoursegrade_modified_course_id_0e2ef09a_idx` (`modified`,`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grades_persistentcoursegrade`
--

LOCK TABLES `grades_persistentcoursegrade` WRITE;
/*!40000 ALTER TABLE `grades_persistentcoursegrade` DISABLE KEYS */;
/*!40000 ALTER TABLE `grades_persistentcoursegrade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grades_persistentgradesenabledflag`
--

DROP TABLE IF EXISTS `grades_persistentgradesenabledflag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grades_persistentgradesenabledflag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `enabled_for_all_courses` tinyint(1) NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `grades_persistentgra_changed_by_id_f80cdad1_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `grades_persistentgra_changed_by_id_f80cdad1_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grades_persistentgradesenabledflag`
--

LOCK TABLES `grades_persistentgradesenabledflag` WRITE;
/*!40000 ALTER TABLE `grades_persistentgradesenabledflag` DISABLE KEYS */;
/*!40000 ALTER TABLE `grades_persistentgradesenabledflag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grades_persistentsubsectiongrade`
--

DROP TABLE IF EXISTS `grades_persistentsubsectiongrade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grades_persistentsubsectiongrade` (
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `usage_key` varchar(255) NOT NULL,
  `subtree_edited_timestamp` datetime(6) DEFAULT NULL,
  `course_version` varchar(255) NOT NULL,
  `earned_all` double NOT NULL,
  `possible_all` double NOT NULL,
  `earned_graded` double NOT NULL,
  `possible_graded` double NOT NULL,
  `visible_blocks_hash` varchar(100) NOT NULL,
  `first_attempted` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `grades_persistentsubsect_course_id_user_id_usage__42820224_uniq` (`course_id`,`user_id`,`usage_key`),
  KEY `grades_persistentsub_visible_blocks_hash_20836274_fk_grades_vi` (`visible_blocks_hash`),
  KEY `grades_persistentsubsecti_modified_course_id_usage__80ab6572_idx` (`modified`,`course_id`,`usage_key`),
  KEY `grades_persistentsubsecti_first_attempted_course_id_f59f063c_idx` (`first_attempted`,`course_id`,`user_id`),
  CONSTRAINT `grades_persistentsub_visible_blocks_hash_20836274_fk_grades_vi` FOREIGN KEY (`visible_blocks_hash`) REFERENCES `grades_visibleblocks` (`hashed`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grades_persistentsubsectiongrade`
--

LOCK TABLES `grades_persistentsubsectiongrade` WRITE;
/*!40000 ALTER TABLE `grades_persistentsubsectiongrade` DISABLE KEYS */;
/*!40000 ALTER TABLE `grades_persistentsubsectiongrade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grades_persistentsubsectiongradeoverride`
--

DROP TABLE IF EXISTS `grades_persistentsubsectiongradeoverride`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grades_persistentsubsectiongradeoverride` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `earned_all_override` double DEFAULT NULL,
  `possible_all_override` double DEFAULT NULL,
  `earned_graded_override` double DEFAULT NULL,
  `possible_graded_override` double DEFAULT NULL,
  `grade_id` bigint(20) unsigned NOT NULL,
  `override_reason` varchar(300) DEFAULT NULL,
  `system` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `grade_id` (`grade_id`),
  KEY `grades_persistentsubsectiongradeoverride_created_f80819d0` (`created`),
  KEY `grades_persistentsubsectiongradeoverride_modified_21efde2a` (`modified`),
  CONSTRAINT `grades_persistentsub_grade_id_74123016_fk_grades_pe` FOREIGN KEY (`grade_id`) REFERENCES `grades_persistentsubsectiongrade` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grades_persistentsubsectiongradeoverride`
--

LOCK TABLES `grades_persistentsubsectiongradeoverride` WRITE;
/*!40000 ALTER TABLE `grades_persistentsubsectiongradeoverride` DISABLE KEYS */;
/*!40000 ALTER TABLE `grades_persistentsubsectiongradeoverride` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grades_visibleblocks`
--

DROP TABLE IF EXISTS `grades_visibleblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grades_visibleblocks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `blocks_json` longtext NOT NULL,
  `hashed` varchar(100) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hashed` (`hashed`),
  KEY `grades_visibleblocks_course_id_d5f8e206` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grades_visibleblocks`
--

LOCK TABLES `grades_visibleblocks` WRITE;
/*!40000 ALTER TABLE `grades_visibleblocks` DISABLE KEYS */;
/*!40000 ALTER TABLE `grades_visibleblocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instructor_task_gradereportsetting`
--

DROP TABLE IF EXISTS `instructor_task_gradereportsetting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instructor_task_gradereportsetting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `batch_size` int(11) NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `instructor_task_grad_changed_by_id_dae9a995_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `instructor_task_grad_changed_by_id_dae9a995_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructor_task_gradereportsetting`
--

LOCK TABLES `instructor_task_gradereportsetting` WRITE;
/*!40000 ALTER TABLE `instructor_task_gradereportsetting` DISABLE KEYS */;
/*!40000 ALTER TABLE `instructor_task_gradereportsetting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instructor_task_instructortask`
--

DROP TABLE IF EXISTS `instructor_task_instructortask`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instructor_task_instructortask` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_type` varchar(50) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `task_key` varchar(255) NOT NULL,
  `task_input` longtext NOT NULL,
  `task_id` varchar(255) NOT NULL,
  `task_state` varchar(50) DEFAULT NULL,
  `task_output` varchar(1024) DEFAULT NULL,
  `created` datetime(6) DEFAULT NULL,
  `updated` datetime(6) NOT NULL,
  `subtasks` longtext NOT NULL,
  `requester_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `instructor_task_inst_requester_id_307f955d_fk_auth_user` (`requester_id`),
  KEY `instructor_task_instructortask_task_type_cefe183d` (`task_type`),
  KEY `instructor_task_instructortask_course_id_b160f709` (`course_id`),
  KEY `instructor_task_instructortask_task_key_c1af3961` (`task_key`),
  KEY `instructor_task_instructortask_task_id_4aa92d04` (`task_id`),
  KEY `instructor_task_instructortask_task_state_3ee4e9cb` (`task_state`),
  CONSTRAINT `instructor_task_inst_requester_id_307f955d_fk_auth_user` FOREIGN KEY (`requester_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructor_task_instructortask`
--

LOCK TABLES `instructor_task_instructortask` WRITE;
/*!40000 ALTER TABLE `instructor_task_instructortask` DISABLE KEYS */;
/*!40000 ALTER TABLE `instructor_task_instructortask` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `integrated_channel_contentmetadataitemtransmission`
--

DROP TABLE IF EXISTS `integrated_channel_contentmetadataitemtransmission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `integrated_channel_contentmetadataitemtransmission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `integrated_channel_code` varchar(30) NOT NULL,
  `content_id` varchar(255) NOT NULL,
  `channel_metadata` longtext NOT NULL,
  `enterprise_customer_id` char(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `integrated_channel_conte_enterprise_customer_id_i_44ca3772_uniq` (`enterprise_customer_id`,`integrated_channel_code`,`content_id`),
  CONSTRAINT `integrated_channel_c_enterprise_customer__f6439bfb_fk_enterpris` FOREIGN KEY (`enterprise_customer_id`) REFERENCES `enterprise_enterprisecustomer` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `integrated_channel_contentmetadataitemtransmission`
--

LOCK TABLES `integrated_channel_contentmetadataitemtransmission` WRITE;
/*!40000 ALTER TABLE `integrated_channel_contentmetadataitemtransmission` DISABLE KEYS */;
/*!40000 ALTER TABLE `integrated_channel_contentmetadataitemtransmission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `integrated_channel_learnerdatatransmissionaudit`
--

DROP TABLE IF EXISTS `integrated_channel_learnerdatatransmissionaudit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `integrated_channel_learnerdatatransmissionaudit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `enterprise_course_enrollment_id` int(10) unsigned NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `course_completed` tinyint(1) NOT NULL,
  `completed_timestamp` bigint(20) NOT NULL,
  `instructor_name` varchar(255) NOT NULL,
  `grade` varchar(100) NOT NULL,
  `status` varchar(100) NOT NULL,
  `error_message` longtext NOT NULL,
  `created` datetime(6) NOT NULL,
  `subsection_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `integrated_channel_learnerd_enterprise_course_enrollmen_c2e6c2e0` (`enterprise_course_enrollment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `integrated_channel_learnerdatatransmissionaudit`
--

LOCK TABLES `integrated_channel_learnerdatatransmissionaudit` WRITE;
/*!40000 ALTER TABLE `integrated_channel_learnerdatatransmissionaudit` DISABLE KEYS */;
/*!40000 ALTER TABLE `integrated_channel_learnerdatatransmissionaudit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `learning_sequences_contenterror`
--

DROP TABLE IF EXISTS `learning_sequences_contenterror`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `learning_sequences_contenterror` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `usage_key` varchar(255) DEFAULT NULL,
  `message` longtext NOT NULL,
  `publish_report_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `learning_sequences_c_publish_report_id_d0ec7d1b_fk_learning_` (`publish_report_id`),
  CONSTRAINT `learning_sequences_c_publish_report_id_d0ec7d1b_fk_learning_` FOREIGN KEY (`publish_report_id`) REFERENCES `learning_sequences_publishreport` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `learning_sequences_contenterror`
--

LOCK TABLES `learning_sequences_contenterror` WRITE;
/*!40000 ALTER TABLE `learning_sequences_contenterror` DISABLE KEYS */;
/*!40000 ALTER TABLE `learning_sequences_contenterror` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `learning_sequences_coursecontext`
--

DROP TABLE IF EXISTS `learning_sequences_coursecontext`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `learning_sequences_coursecontext` (
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `learning_context_id` bigint(20) NOT NULL,
  `course_visibility` varchar(32) NOT NULL,
  `self_paced` tinyint(1) NOT NULL,
  `days_early_for_beta` int(11) DEFAULT NULL,
  `entrance_exam_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`learning_context_id`),
  CONSTRAINT `learning_sequences_c_learning_context_id_fe16b41d_fk_learning_` FOREIGN KEY (`learning_context_id`) REFERENCES `learning_sequences_learningcontext` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `learning_sequences_coursecontext`
--

LOCK TABLES `learning_sequences_coursecontext` WRITE;
/*!40000 ALTER TABLE `learning_sequences_coursecontext` DISABLE KEYS */;
/*!40000 ALTER TABLE `learning_sequences_coursecontext` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `learning_sequences_coursesection`
--

DROP TABLE IF EXISTS `learning_sequences_coursesection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `learning_sequences_coursesection` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ordering` int(10) unsigned NOT NULL,
  `usage_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `title` varchar(1000) NOT NULL,
  `hide_from_toc` tinyint(1) NOT NULL,
  `visible_to_staff_only` tinyint(1) NOT NULL,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `course_context_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `learning_sequences_cours_course_context_id_usage__0df8eb59_uniq` (`course_context_id`,`usage_key`),
  KEY `learning_sequences_course_course_context_id_orderin_ee5cfc42_idx` (`course_context_id`,`ordering`),
  CONSTRAINT `learning_sequences_c_course_context_id_f9845b47_fk_learning_` FOREIGN KEY (`course_context_id`) REFERENCES `learning_sequences_coursecontext` (`learning_context_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `learning_sequences_coursesection`
--

LOCK TABLES `learning_sequences_coursesection` WRITE;
/*!40000 ALTER TABLE `learning_sequences_coursesection` DISABLE KEYS */;
/*!40000 ALTER TABLE `learning_sequences_coursesection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `learning_sequences_coursesectionsequence`
--

DROP TABLE IF EXISTS `learning_sequences_coursesectionsequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `learning_sequences_coursesectionsequence` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ordering` int(10) unsigned NOT NULL,
  `hide_from_toc` tinyint(1) NOT NULL,
  `visible_to_staff_only` tinyint(1) NOT NULL,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `section_id` bigint(20) NOT NULL,
  `sequence_id` bigint(20) NOT NULL,
  `inaccessible_after_due` tinyint(1) NOT NULL,
  `course_context_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `learning_sequences_cours_course_context_id_orderi_f233743c_uniq` (`course_context_id`,`ordering`),
  KEY `learning_sequences_c_section_id_646c2074_fk_learning_` (`section_id`),
  KEY `learning_sequences_c_sequence_id_e6a12a64_fk_learning_` (`sequence_id`),
  CONSTRAINT `learning_sequences_c_course_context_id_bb2762af_fk_learning_` FOREIGN KEY (`course_context_id`) REFERENCES `learning_sequences_coursecontext` (`learning_context_id`),
  CONSTRAINT `learning_sequences_c_section_id_646c2074_fk_learning_` FOREIGN KEY (`section_id`) REFERENCES `learning_sequences_coursesection` (`id`),
  CONSTRAINT `learning_sequences_c_sequence_id_e6a12a64_fk_learning_` FOREIGN KEY (`sequence_id`) REFERENCES `learning_sequences_learningsequence` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `learning_sequences_coursesectionsequence`
--

LOCK TABLES `learning_sequences_coursesectionsequence` WRITE;
/*!40000 ALTER TABLE `learning_sequences_coursesectionsequence` DISABLE KEYS */;
/*!40000 ALTER TABLE `learning_sequences_coursesectionsequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `learning_sequences_coursesequenceexam`
--

DROP TABLE IF EXISTS `learning_sequences_coursesequenceexam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `learning_sequences_coursesequenceexam` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `is_practice_exam` tinyint(1) NOT NULL,
  `is_proctored_enabled` tinyint(1) NOT NULL,
  `is_time_limited` tinyint(1) NOT NULL,
  `course_section_sequence_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `course_section_sequence_id` (`course_section_sequence_id`),
  CONSTRAINT `learning_sequences_c_course_section_seque_89ce42a5_fk_learning_` FOREIGN KEY (`course_section_sequence_id`) REFERENCES `learning_sequences_coursesectionsequence` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `learning_sequences_coursesequenceexam`
--

LOCK TABLES `learning_sequences_coursesequenceexam` WRITE;
/*!40000 ALTER TABLE `learning_sequences_coursesequenceexam` DISABLE KEYS */;
/*!40000 ALTER TABLE `learning_sequences_coursesequenceexam` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `learning_sequences_learningcontext`
--

DROP TABLE IF EXISTS `learning_sequences_learningcontext`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `learning_sequences_learningcontext` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `context_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `published_at` datetime(6) NOT NULL,
  `published_version` varchar(255) NOT NULL,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `context_key` (`context_key`),
  KEY `learning_se_publish_62319b_idx` (`published_at`),
  KEY `learning_sequences_learningcontext_title_5a70c4cd` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `learning_sequences_learningcontext`
--

LOCK TABLES `learning_sequences_learningcontext` WRITE;
/*!40000 ALTER TABLE `learning_sequences_learningcontext` DISABLE KEYS */;
/*!40000 ALTER TABLE `learning_sequences_learningcontext` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `learning_sequences_learningsequence`
--

DROP TABLE IF EXISTS `learning_sequences_learningsequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `learning_sequences_learningsequence` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `learning_context_id` bigint(20) NOT NULL,
  `usage_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `title` varchar(1000) NOT NULL,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `learning_sequences_learn_learning_context_id_usag_6a13230f_uniq` (`learning_context_id`,`usage_key`),
  CONSTRAINT `learning_sequences_l_learning_context_id_25f3e4ab_fk_learning_` FOREIGN KEY (`learning_context_id`) REFERENCES `learning_sequences_learningcontext` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `learning_sequences_learningsequence`
--

LOCK TABLES `learning_sequences_learningsequence` WRITE;
/*!40000 ALTER TABLE `learning_sequences_learningsequence` DISABLE KEYS */;
/*!40000 ALTER TABLE `learning_sequences_learningsequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `learning_sequences_publishreport`
--

DROP TABLE IF EXISTS `learning_sequences_publishreport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `learning_sequences_publishreport` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `num_errors` int(10) unsigned NOT NULL,
  `num_sections` int(10) unsigned NOT NULL,
  `num_sequences` int(10) unsigned NOT NULL,
  `learning_context_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `learning_context_id` (`learning_context_id`),
  KEY `learning_sequences_publishreport_num_errors_118a5f55` (`num_errors`),
  KEY `learning_sequences_publishreport_num_sections_ad9e0ae2` (`num_sections`),
  KEY `learning_sequences_publishreport_num_sequences_51743c92` (`num_sequences`),
  CONSTRAINT `learning_sequences_p_learning_context_id_dd7a29fd_fk_learning_` FOREIGN KEY (`learning_context_id`) REFERENCES `learning_sequences_learningcontext` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `learning_sequences_publishreport`
--

LOCK TABLES `learning_sequences_publishreport` WRITE;
/*!40000 ALTER TABLE `learning_sequences_publishreport` DISABLE KEYS */;
/*!40000 ALTER TABLE `learning_sequences_publishreport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lms_xblock_xblockasidesconfig`
--

DROP TABLE IF EXISTS `lms_xblock_xblockasidesconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lms_xblock_xblockasidesconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `disabled_blocks` longtext NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lms_xblock_xblockasi_changed_by_id_71928be3_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `lms_xblock_xblockasi_changed_by_id_71928be3_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lms_xblock_xblockasidesconfig`
--

LOCK TABLES `lms_xblock_xblockasidesconfig` WRITE;
/*!40000 ALTER TABLE `lms_xblock_xblockasidesconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `lms_xblock_xblockasidesconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lti_consumer_ltiagslineitem`
--

DROP TABLE IF EXISTS `lti_consumer_ltiagslineitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lti_consumer_ltiagslineitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `resource_id` varchar(100) NOT NULL,
  `resource_link_id` varchar(255) DEFAULT NULL,
  `label` varchar(100) NOT NULL,
  `score_maximum` int(11) NOT NULL,
  `tag` varchar(50) NOT NULL,
  `start_date_time` datetime(6) DEFAULT NULL,
  `end_date_time` datetime(6) DEFAULT NULL,
  `lti_configuration_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lti_consumer_ltiagsl_lti_configuration_id_03e605a4_fk_lti_consu` (`lti_configuration_id`),
  KEY `lti_consumer_ltiagslineitem_resource_link_id_39f87e2f` (`resource_link_id`),
  CONSTRAINT `lti_consumer_ltiagsl_lti_configuration_id_03e605a4_fk_lti_consu` FOREIGN KEY (`lti_configuration_id`) REFERENCES `lti_consumer_lticonfiguration` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lti_consumer_ltiagslineitem`
--

LOCK TABLES `lti_consumer_ltiagslineitem` WRITE;
/*!40000 ALTER TABLE `lti_consumer_ltiagslineitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `lti_consumer_ltiagslineitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lti_consumer_ltiagsscore`
--

DROP TABLE IF EXISTS `lti_consumer_ltiagsscore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lti_consumer_ltiagsscore` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` datetime(6) NOT NULL,
  `score_given` double DEFAULT NULL,
  `score_maximum` double DEFAULT NULL,
  `comment` longtext,
  `activity_progress` varchar(20) NOT NULL,
  `grading_progress` varchar(20) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `line_item_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lti_consumer_ltiagsscore_line_item_id_user_id_887a73e4_uniq` (`line_item_id`,`user_id`),
  CONSTRAINT `lti_consumer_ltiagss_line_item_id_168433dc_fk_lti_consu` FOREIGN KEY (`line_item_id`) REFERENCES `lti_consumer_ltiagslineitem` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lti_consumer_ltiagsscore`
--

LOCK TABLES `lti_consumer_ltiagsscore` WRITE;
/*!40000 ALTER TABLE `lti_consumer_ltiagsscore` DISABLE KEYS */;
/*!40000 ALTER TABLE `lti_consumer_ltiagsscore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lti_consumer_lticonfiguration`
--

DROP TABLE IF EXISTS `lti_consumer_lticonfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lti_consumer_lticonfiguration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(10) NOT NULL,
  `config_store` varchar(255) NOT NULL,
  `location` varchar(255) DEFAULT NULL,
  `lti_1p3_internal_private_key` longtext NOT NULL,
  `lti_1p3_internal_private_key_id` varchar(255) NOT NULL,
  `lti_1p3_internal_public_jwk` longtext NOT NULL,
  `lti_1p3_client_id` varchar(255) NOT NULL,
  `config_id` char(32) NOT NULL,
  `lti_1p1_client_key` varchar(255) NOT NULL,
  `lti_1p1_client_secret` varchar(255) NOT NULL,
  `lti_1p1_launch_url` varchar(255) NOT NULL,
  `lti_config` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lti_consumer_lticonfiguration_config_id_7e375962_uniq` (`config_id`),
  KEY `lti_consumer_lticonfiguration_location_e7e37735` (`location`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lti_consumer_lticonfiguration`
--

LOCK TABLES `lti_consumer_lticonfiguration` WRITE;
/*!40000 ALTER TABLE `lti_consumer_lticonfiguration` DISABLE KEYS */;
/*!40000 ALTER TABLE `lti_consumer_lticonfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lti_consumer_ltidlcontentitem`
--

DROP TABLE IF EXISTS `lti_consumer_ltidlcontentitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lti_consumer_ltidlcontentitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content_type` varchar(255) NOT NULL,
  `attributes` longtext NOT NULL,
  `lti_configuration_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lti_consumer_ltidlco_lti_configuration_id_887d35fa_fk_lti_consu` (`lti_configuration_id`),
  CONSTRAINT `lti_consumer_ltidlco_lti_configuration_id_887d35fa_fk_lti_consu` FOREIGN KEY (`lti_configuration_id`) REFERENCES `lti_consumer_lticonfiguration` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lti_consumer_ltidlcontentitem`
--

LOCK TABLES `lti_consumer_ltidlcontentitem` WRITE;
/*!40000 ALTER TABLE `lti_consumer_ltidlcontentitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `lti_consumer_ltidlcontentitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `milestones_coursecontentmilestone`
--

DROP TABLE IF EXISTS `milestones_coursecontentmilestone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `milestones_coursecontentmilestone` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `content_id` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `milestone_id` int(11) NOT NULL,
  `milestone_relationship_type_id` int(11) NOT NULL,
  `requirements` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `milestones_coursecontent_course_id_content_id_mil_7caa5ba5_uniq` (`course_id`,`content_id`,`milestone_id`),
  KEY `milestones_coursecontentmilestone_course_id_6fd3fad0` (`course_id`),
  KEY `milestones_coursecontentmilestone_content_id_21f4c95f` (`content_id`),
  KEY `milestones_coursecon_milestone_id_bd7a608b_fk_milestone` (`milestone_id`),
  KEY `milestones_coursecon_milestone_relationsh_31556ebf_fk_milestone` (`milestone_relationship_type_id`),
  KEY `milestones_coursecontentmilestone_active_b7ab709d` (`active`),
  CONSTRAINT `milestones_coursecon_milestone_id_bd7a608b_fk_milestone` FOREIGN KEY (`milestone_id`) REFERENCES `milestones_milestone` (`id`),
  CONSTRAINT `milestones_coursecon_milestone_relationsh_31556ebf_fk_milestone` FOREIGN KEY (`milestone_relationship_type_id`) REFERENCES `milestones_milestonerelationshiptype` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `milestones_coursecontentmilestone`
--

LOCK TABLES `milestones_coursecontentmilestone` WRITE;
/*!40000 ALTER TABLE `milestones_coursecontentmilestone` DISABLE KEYS */;
/*!40000 ALTER TABLE `milestones_coursecontentmilestone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `milestones_coursemilestone`
--

DROP TABLE IF EXISTS `milestones_coursemilestone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `milestones_coursemilestone` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `milestone_id` int(11) NOT NULL,
  `milestone_relationship_type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `milestones_coursemilestone_course_id_milestone_id_36b21ae8_uniq` (`course_id`,`milestone_id`),
  KEY `milestones_coursemilestone_course_id_ce46a0fc` (`course_id`),
  KEY `milestones_coursemil_milestone_id_03d9ef01_fk_milestone` (`milestone_id`),
  KEY `milestones_coursemil_milestone_relationsh_6c64b782_fk_milestone` (`milestone_relationship_type_id`),
  KEY `milestones_coursemilestone_active_c590442e` (`active`),
  CONSTRAINT `milestones_coursemil_milestone_id_03d9ef01_fk_milestone` FOREIGN KEY (`milestone_id`) REFERENCES `milestones_milestone` (`id`),
  CONSTRAINT `milestones_coursemil_milestone_relationsh_6c64b782_fk_milestone` FOREIGN KEY (`milestone_relationship_type_id`) REFERENCES `milestones_milestonerelationshiptype` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `milestones_coursemilestone`
--

LOCK TABLES `milestones_coursemilestone` WRITE;
/*!40000 ALTER TABLE `milestones_coursemilestone` DISABLE KEYS */;
/*!40000 ALTER TABLE `milestones_coursemilestone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `milestones_milestone`
--

DROP TABLE IF EXISTS `milestones_milestone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `milestones_milestone` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `namespace` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `milestones_milestone_namespace_name_0b80f867_uniq` (`namespace`,`name`),
  KEY `milestones_milestone_namespace_a8e8807c` (`namespace`),
  KEY `milestones_milestone_name_23fb0698` (`name`),
  KEY `milestones_milestone_active_9a6c1703` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `milestones_milestone`
--

LOCK TABLES `milestones_milestone` WRITE;
/*!40000 ALTER TABLE `milestones_milestone` DISABLE KEYS */;
/*!40000 ALTER TABLE `milestones_milestone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `milestones_milestonerelationshiptype`
--

DROP TABLE IF EXISTS `milestones_milestonerelationshiptype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `milestones_milestonerelationshiptype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `name` varchar(25) NOT NULL,
  `description` longtext NOT NULL,
  `active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `milestones_milestonerelationshiptype`
--

LOCK TABLES `milestones_milestonerelationshiptype` WRITE;
/*!40000 ALTER TABLE `milestones_milestonerelationshiptype` DISABLE KEYS */;
INSERT INTO `milestones_milestonerelationshiptype` VALUES (1,'2021-03-24 08:06:40.090623','2021-03-24 08:06:40.090623','requires','Autogenerated milestone relationship type \"requires\"',1),(2,'2021-03-24 08:06:40.096431','2021-03-24 08:06:40.096431','fulfills','Autogenerated milestone relationship type \"fulfills\"',1);
/*!40000 ALTER TABLE `milestones_milestonerelationshiptype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `milestones_usermilestone`
--

DROP TABLE IF EXISTS `milestones_usermilestone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `milestones_usermilestone` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL,
  `source` longtext NOT NULL,
  `collected` datetime(6) DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  `milestone_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `milestones_usermilestone_user_id_milestone_id_02197f01_uniq` (`user_id`,`milestone_id`),
  KEY `milestones_usermiles_milestone_id_f90f9430_fk_milestone` (`milestone_id`),
  KEY `milestones_usermilestone_user_id_b3e9aef4` (`user_id`),
  KEY `milestones_usermilestone_active_93a18e7f` (`active`),
  CONSTRAINT `milestones_usermiles_milestone_id_f90f9430_fk_milestone` FOREIGN KEY (`milestone_id`) REFERENCES `milestones_milestone` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `milestones_usermilestone`
--

LOCK TABLES `milestones_usermilestone` WRITE;
/*!40000 ALTER TABLE `milestones_usermilestone` DISABLE KEYS */;
/*!40000 ALTER TABLE `milestones_usermilestone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mobile_api_appversionconfig`
--

DROP TABLE IF EXISTS `mobile_api_appversionconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mobile_api_appversionconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `platform` varchar(50) NOT NULL,
  `version` varchar(50) NOT NULL,
  `major_version` int(11) NOT NULL,
  `minor_version` int(11) NOT NULL,
  `patch_version` int(11) NOT NULL,
  `expire_at` datetime(6) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mobile_api_appversionconfig_platform_version_6b577430_uniq` (`platform`,`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mobile_api_appversionconfig`
--

LOCK TABLES `mobile_api_appversionconfig` WRITE;
/*!40000 ALTER TABLE `mobile_api_appversionconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `mobile_api_appversionconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mobile_api_ignoremobileavailableflagconfig`
--

DROP TABLE IF EXISTS `mobile_api_ignoremobileavailableflagconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mobile_api_ignoremobileavailableflagconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mobile_api_ignoremob_changed_by_id_4ca9c0d6_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `mobile_api_ignoremob_changed_by_id_4ca9c0d6_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mobile_api_ignoremobileavailableflagconfig`
--

LOCK TABLES `mobile_api_ignoremobileavailableflagconfig` WRITE;
/*!40000 ALTER TABLE `mobile_api_ignoremobileavailableflagconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `mobile_api_ignoremobileavailableflagconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mobile_api_mobileapiconfig`
--

DROP TABLE IF EXISTS `mobile_api_mobileapiconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mobile_api_mobileapiconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `video_profiles` longtext NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mobile_api_mobileapi_changed_by_id_8799981a_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `mobile_api_mobileapi_changed_by_id_8799981a_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mobile_api_mobileapiconfig`
--

LOCK TABLES `mobile_api_mobileapiconfig` WRITE;
/*!40000 ALTER TABLE `mobile_api_mobileapiconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `mobile_api_mobileapiconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `moodle_historicalmoodleenterprisecustomerconfiguration`
--

DROP TABLE IF EXISTS `moodle_historicalmoodleenterprisecustomerconfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `moodle_historicalmoodleenterprisecustomerconfiguration` (
  `id` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `transmission_chunk_size` int(11) NOT NULL,
  `channel_worker_username` varchar(255) DEFAULT NULL,
  `catalogs_to_transmit` longtext,
  `moodle_base_url` varchar(255) NOT NULL,
  `service_short_name` varchar(255) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `enterprise_customer_id` char(32) DEFAULT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `moodle_historicalmoo_history_user_id_22017ee9_fk_auth_user` (`history_user_id`),
  KEY `moodle_historicalmoodleente_id_71ddc422` (`id`),
  KEY `moodle_historicalmoodleente_enterprise_customer_id_a816d974` (`enterprise_customer_id`),
  CONSTRAINT `moodle_historicalmoo_history_user_id_22017ee9_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `moodle_historicalmoodleenterprisecustomerconfiguration`
--

LOCK TABLES `moodle_historicalmoodleenterprisecustomerconfiguration` WRITE;
/*!40000 ALTER TABLE `moodle_historicalmoodleenterprisecustomerconfiguration` DISABLE KEYS */;
/*!40000 ALTER TABLE `moodle_historicalmoodleenterprisecustomerconfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `moodle_moodleenterprisecustomerconfiguration`
--

DROP TABLE IF EXISTS `moodle_moodleenterprisecustomerconfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `moodle_moodleenterprisecustomerconfiguration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `transmission_chunk_size` int(11) NOT NULL,
  `channel_worker_username` varchar(255) DEFAULT NULL,
  `catalogs_to_transmit` longtext,
  `moodle_base_url` varchar(255) NOT NULL,
  `service_short_name` varchar(255) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `enterprise_customer_id` char(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `enterprise_customer_id` (`enterprise_customer_id`),
  CONSTRAINT `moodle_moodleenterpr_enterprise_customer__6668537b_fk_enterpris` FOREIGN KEY (`enterprise_customer_id`) REFERENCES `enterprise_enterprisecustomer` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `moodle_moodleenterprisecustomerconfiguration`
--

LOCK TABLES `moodle_moodleenterprisecustomerconfiguration` WRITE;
/*!40000 ALTER TABLE `moodle_moodleenterprisecustomerconfiguration` DISABLE KEYS */;
/*!40000 ALTER TABLE `moodle_moodleenterprisecustomerconfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `moodle_moodlelearnerdatatransmissionaudit`
--

DROP TABLE IF EXISTS `moodle_moodlelearnerdatatransmissionaudit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `moodle_moodlelearnerdatatransmissionaudit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `moodle_user_email` varchar(255) NOT NULL,
  `enterprise_course_enrollment_id` int(10) unsigned NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `grade` decimal(3,2) DEFAULT NULL,
  `total_hours` double DEFAULT NULL,
  `course_completed` tinyint(1) NOT NULL,
  `completed_timestamp` varchar(10) NOT NULL,
  `status` varchar(100) NOT NULL,
  `error_message` longtext NOT NULL,
  `created` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `moodle_moodlelearnerdatatra_enterprise_course_enrollmen_70fa10d7` (`enterprise_course_enrollment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `moodle_moodlelearnerdatatransmissionaudit`
--

LOCK TABLES `moodle_moodlelearnerdatatransmissionaudit` WRITE;
/*!40000 ALTER TABLE `moodle_moodlelearnerdatatransmissionaudit` DISABLE KEYS */;
/*!40000 ALTER TABLE `moodle_moodlelearnerdatatransmissionaudit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notify_notification`
--

DROP TABLE IF EXISTS `notify_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notify_notification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` longtext NOT NULL,
  `url` varchar(200) DEFAULT NULL,
  `is_viewed` tinyint(1) NOT NULL,
  `is_emailed` tinyint(1) NOT NULL,
  `created` datetime(6) NOT NULL,
  `subscription_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notify_notification_subscription_id_0eae0084_fk_notify_su` (`subscription_id`),
  CONSTRAINT `notify_notification_subscription_id_0eae0084_fk_notify_su` FOREIGN KEY (`subscription_id`) REFERENCES `notify_subscription` (`subscription_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notify_notification`
--

LOCK TABLES `notify_notification` WRITE;
/*!40000 ALTER TABLE `notify_notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `notify_notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notify_notificationtype`
--

DROP TABLE IF EXISTS `notify_notificationtype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notify_notificationtype` (
  `key` varchar(128) NOT NULL,
  `label` varchar(128) DEFAULT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`key`),
  KEY `notify_notificationt_content_type_id_f575bac5_fk_django_co` (`content_type_id`),
  CONSTRAINT `notify_notificationt_content_type_id_f575bac5_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notify_notificationtype`
--

LOCK TABLES `notify_notificationtype` WRITE;
/*!40000 ALTER TABLE `notify_notificationtype` DISABLE KEYS */;
/*!40000 ALTER TABLE `notify_notificationtype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notify_settings`
--

DROP TABLE IF EXISTS `notify_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notify_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `interval` smallint(6) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `notify_settings_user_id_088ebffc_fk_auth_user_id` (`user_id`),
  CONSTRAINT `notify_settings_user_id_088ebffc_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notify_settings`
--

LOCK TABLES `notify_settings` WRITE;
/*!40000 ALTER TABLE `notify_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `notify_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notify_subscription`
--

DROP TABLE IF EXISTS `notify_subscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notify_subscription` (
  `subscription_id` int(11) NOT NULL AUTO_INCREMENT,
  `object_id` varchar(64) DEFAULT NULL,
  `send_emails` tinyint(1) NOT NULL,
  `notification_type_id` varchar(128) NOT NULL,
  `settings_id` int(11) NOT NULL,
  PRIMARY KEY (`subscription_id`),
  KEY `notify_subscription_notification_type_id_f73a8b13_fk_notify_no` (`notification_type_id`),
  KEY `notify_subscription_settings_id_dbc3961d_fk_notify_settings_id` (`settings_id`),
  CONSTRAINT `notify_subscription_notification_type_id_f73a8b13_fk_notify_no` FOREIGN KEY (`notification_type_id`) REFERENCES `notify_notificationtype` (`key`),
  CONSTRAINT `notify_subscription_settings_id_dbc3961d_fk_notify_settings_id` FOREIGN KEY (`settings_id`) REFERENCES `notify_settings` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notify_subscription`
--

LOCK TABLES `notify_subscription` WRITE;
/*!40000 ALTER TABLE `notify_subscription` DISABLE KEYS */;
/*!40000 ALTER TABLE `notify_subscription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_provider_accesstoken`
--

DROP TABLE IF EXISTS `oauth2_provider_accesstoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth2_provider_accesstoken` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `token` varchar(255) NOT NULL,
  `expires` datetime(6) NOT NULL,
  `scope` longtext NOT NULL,
  `application_id` bigint(20) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `source_refresh_token_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`),
  UNIQUE KEY `source_refresh_token_id` (`source_refresh_token_id`),
  KEY `oauth2_provider_acce_application_id_b22886e1_fk_oauth2_pr` (`application_id`),
  KEY `oauth2_provider_accesstoken_user_id_6e4c9a65_fk_auth_user_id` (`user_id`),
  CONSTRAINT `oauth2_provider_acce_application_id_b22886e1_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  CONSTRAINT `oauth2_provider_acce_source_refresh_token_e66fbc72_fk_oauth2_pr` FOREIGN KEY (`source_refresh_token_id`) REFERENCES `oauth2_provider_refreshtoken` (`id`),
  CONSTRAINT `oauth2_provider_accesstoken_user_id_6e4c9a65_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_accesstoken`
--

LOCK TABLES `oauth2_provider_accesstoken` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_accesstoken` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth2_provider_accesstoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_provider_application`
--

DROP TABLE IF EXISTS `oauth2_provider_application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth2_provider_application` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_id` varchar(100) NOT NULL,
  `redirect_uris` longtext NOT NULL,
  `client_type` varchar(32) NOT NULL,
  `authorization_grant_type` varchar(32) NOT NULL,
  `client_secret` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `skip_authorization` tinyint(1) NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `client_id` (`client_id`),
  KEY `oauth2_provider_application_user_id_79829054_fk_auth_user_id` (`user_id`),
  KEY `oauth2_provider_application_client_secret_53133678` (`client_secret`),
  CONSTRAINT `oauth2_provider_application_user_id_79829054_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_application`
--

LOCK TABLES `oauth2_provider_application` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_application` DISABLE KEYS */;
INSERT INTO `oauth2_provider_application` VALUES (1,'login-service-client-id','','public','password','5z6303AtoDe2FuHgYbMSvtWS5BEzYHYQZy7fg5rxzT3mB0kcNXW51QK659a9PhRwWFS2AUw9eT1bw8wEbWDjqdghaCDzmkkjZpRF1os4zF606U67ATNeAw2oGkXPCMJG','Login Service for JWT Cookies',2,0,'2021-03-24 08:07:14.555461','2021-03-24 08:07:14.555492');
/*!40000 ALTER TABLE `oauth2_provider_application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_provider_grant`
--

DROP TABLE IF EXISTS `oauth2_provider_grant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth2_provider_grant` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `expires` datetime(6) NOT NULL,
  `redirect_uri` varchar(255) NOT NULL,
  `scope` longtext NOT NULL,
  `application_id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `code_challenge` varchar(128) NOT NULL,
  `code_challenge_method` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `oauth2_provider_gran_application_id_81923564_fk_oauth2_pr` (`application_id`),
  KEY `oauth2_provider_grant_user_id_e8f62af8_fk_auth_user_id` (`user_id`),
  CONSTRAINT `oauth2_provider_gran_application_id_81923564_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  CONSTRAINT `oauth2_provider_grant_user_id_e8f62af8_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_grant`
--

LOCK TABLES `oauth2_provider_grant` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_grant` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth2_provider_grant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_provider_refreshtoken`
--

DROP TABLE IF EXISTS `oauth2_provider_refreshtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth2_provider_refreshtoken` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `token` varchar(255) NOT NULL,
  `access_token_id` bigint(20) DEFAULT NULL,
  `application_id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `revoked` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `access_token_id` (`access_token_id`),
  UNIQUE KEY `oauth2_provider_refreshtoken_token_revoked_af8a5134_uniq` (`token`,`revoked`),
  KEY `oauth2_provider_refr_application_id_2d1c311b_fk_oauth2_pr` (`application_id`),
  KEY `oauth2_provider_refreshtoken_user_id_da837fce_fk_auth_user_id` (`user_id`),
  CONSTRAINT `oauth2_provider_refr_access_token_id_775e84e8_fk_oauth2_pr` FOREIGN KEY (`access_token_id`) REFERENCES `oauth2_provider_accesstoken` (`id`),
  CONSTRAINT `oauth2_provider_refr_application_id_2d1c311b_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  CONSTRAINT `oauth2_provider_refreshtoken_user_id_da837fce_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_refreshtoken`
--

LOCK TABLES `oauth2_provider_refreshtoken` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_refreshtoken` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth2_provider_refreshtoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_dispatch_applicationaccess`
--

DROP TABLE IF EXISTS `oauth_dispatch_applicationaccess`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_dispatch_applicationaccess` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `scopes` varchar(825) NOT NULL,
  `application_id` bigint(20) NOT NULL,
  `filters` varchar(825) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `application_id` (`application_id`),
  CONSTRAINT `oauth_dispatch_appli_application_id_dcddee6e_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_dispatch_applicationaccess`
--

LOCK TABLES `oauth_dispatch_applicationaccess` WRITE;
/*!40000 ALTER TABLE `oauth_dispatch_applicationaccess` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_dispatch_applicationaccess` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_dispatch_applicationorganization`
--

DROP TABLE IF EXISTS `oauth_dispatch_applicationorganization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_dispatch_applicationorganization` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `relation_type` varchar(32) NOT NULL,
  `application_id` bigint(20) NOT NULL,
  `organization_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `oauth_dispatch_applicati_application_id_relation__1b4017f2_uniq` (`application_id`,`relation_type`,`organization_id`),
  KEY `oauth_dispatch_appli_organization_id_fe63a7f2_fk_organizat` (`organization_id`),
  CONSTRAINT `oauth_dispatch_appli_application_id_dea619c6_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  CONSTRAINT `oauth_dispatch_appli_organization_id_fe63a7f2_fk_organizat` FOREIGN KEY (`organization_id`) REFERENCES `organizations_organization` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_dispatch_applicationorganization`
--

LOCK TABLES `oauth_dispatch_applicationorganization` WRITE;
/*!40000 ALTER TABLE `oauth_dispatch_applicationorganization` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_dispatch_applicationorganization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_dispatch_restrictedapplication`
--

DROP TABLE IF EXISTS `oauth_dispatch_restrictedapplication`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_dispatch_restrictedapplication` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `application_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_dispatch_restr_application_id_6b8d0930_fk_oauth2_pr` (`application_id`),
  CONSTRAINT `oauth_dispatch_restr_application_id_6b8d0930_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_dispatch_restrictedapplication`
--

LOCK TABLES `oauth_dispatch_restrictedapplication` WRITE;
/*!40000 ALTER TABLE `oauth_dispatch_restrictedapplication` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_dispatch_restrictedapplication` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organizations_historicalorganization`
--

DROP TABLE IF EXISTS `organizations_historicalorganization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organizations_historicalorganization` (
  `id` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `name` varchar(255) NOT NULL,
  `short_name` varchar(255) NOT NULL,
  `description` longtext,
  `logo` longtext,
  `active` tinyint(1) NOT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `organizations_histor_history_user_id_bb516493_fk_auth_user` (`history_user_id`),
  KEY `organizations_historicalorganization_id_4327d8f9` (`id`),
  KEY `organizations_historicalorganization_name_5f4e354b` (`name`),
  KEY `organizations_historicalorganization_short_name_07087b46` (`short_name`),
  CONSTRAINT `organizations_histor_history_user_id_bb516493_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organizations_historicalorganization`
--

LOCK TABLES `organizations_historicalorganization` WRITE;
/*!40000 ALTER TABLE `organizations_historicalorganization` DISABLE KEYS */;
/*!40000 ALTER TABLE `organizations_historicalorganization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organizations_historicalorganizationcourse`
--

DROP TABLE IF EXISTS `organizations_historicalorganizationcourse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organizations_historicalorganizationcourse` (
  `id` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  `organization_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `organizations_histor_history_user_id_0f165c1b_fk_auth_user` (`history_user_id`),
  KEY `organizations_historicalorganizationcourse_id_9a1564c8` (`id`),
  KEY `organizations_historicalorganizationcourse_course_id_4c93708c` (`course_id`),
  KEY `organizations_historicalorg_organization_id_7cc0ed83` (`organization_id`),
  CONSTRAINT `organizations_histor_history_user_id_0f165c1b_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organizations_historicalorganizationcourse`
--

LOCK TABLES `organizations_historicalorganizationcourse` WRITE;
/*!40000 ALTER TABLE `organizations_historicalorganizationcourse` DISABLE KEYS */;
/*!40000 ALTER TABLE `organizations_historicalorganizationcourse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organizations_organization`
--

DROP TABLE IF EXISTS `organizations_organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organizations_organization` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `name` varchar(255) NOT NULL,
  `short_name` varchar(255) NOT NULL,
  `description` longtext,
  `logo` varchar(255) DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `organizations_organization_short_name_ef338963_uniq` (`short_name`),
  KEY `organizations_organization_name_71edc74b` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organizations_organization`
--

LOCK TABLES `organizations_organization` WRITE;
/*!40000 ALTER TABLE `organizations_organization` DISABLE KEYS */;
/*!40000 ALTER TABLE `organizations_organization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organizations_organizationcourse`
--

DROP TABLE IF EXISTS `organizations_organizationcourse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organizations_organizationcourse` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `organization_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `organizations_organizati_course_id_organization_i_06b1db31_uniq` (`course_id`,`organization_id`),
  KEY `organizations_organi_organization_id_99e77fe0_fk_organizat` (`organization_id`),
  KEY `organizations_organizationcourse_course_id_227b73bc` (`course_id`),
  CONSTRAINT `organizations_organi_organization_id_99e77fe0_fk_organizat` FOREIGN KEY (`organization_id`) REFERENCES `organizations_organization` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organizations_organizationcourse`
--

LOCK TABLES `organizations_organizationcourse` WRITE;
/*!40000 ALTER TABLE `organizations_organizationcourse` DISABLE KEYS */;
/*!40000 ALTER TABLE `organizations_organizationcourse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proctoring_proctoredexam`
--

DROP TABLE IF EXISTS `proctoring_proctoredexam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proctoring_proctoredexam` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `content_id` varchar(255) NOT NULL,
  `external_id` varchar(255) DEFAULT NULL,
  `exam_name` longtext NOT NULL,
  `time_limit_mins` int(11) NOT NULL,
  `due_date` datetime(6) DEFAULT NULL,
  `is_proctored` tinyint(1) NOT NULL,
  `is_practice_exam` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `hide_after_due` tinyint(1) NOT NULL,
  `backend` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `proctoring_proctoredexam_course_id_content_id_1d8358cc_uniq` (`course_id`,`content_id`),
  KEY `proctoring_proctoredexam_course_id_8787b34f` (`course_id`),
  KEY `proctoring_proctoredexam_content_id_13d3bec4` (`content_id`),
  KEY `proctoring_proctoredexam_external_id_0181c110` (`external_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proctoring_proctoredexam`
--

LOCK TABLES `proctoring_proctoredexam` WRITE;
/*!40000 ALTER TABLE `proctoring_proctoredexam` DISABLE KEYS */;
/*!40000 ALTER TABLE `proctoring_proctoredexam` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proctoring_proctoredexamreviewpolicy`
--

DROP TABLE IF EXISTS `proctoring_proctoredexamreviewpolicy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proctoring_proctoredexamreviewpolicy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `review_policy` longtext NOT NULL,
  `proctored_exam_id` int(11) NOT NULL,
  `set_by_user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `proctoring_proctored_proctored_exam_id_57f9ce30_fk_proctorin` (`proctored_exam_id`),
  KEY `proctoring_proctored_set_by_user_id_7c101300_fk_auth_user` (`set_by_user_id`),
  CONSTRAINT `proctoring_proctored_proctored_exam_id_57f9ce30_fk_proctorin` FOREIGN KEY (`proctored_exam_id`) REFERENCES `proctoring_proctoredexam` (`id`),
  CONSTRAINT `proctoring_proctored_set_by_user_id_7c101300_fk_auth_user` FOREIGN KEY (`set_by_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proctoring_proctoredexamreviewpolicy`
--

LOCK TABLES `proctoring_proctoredexamreviewpolicy` WRITE;
/*!40000 ALTER TABLE `proctoring_proctoredexamreviewpolicy` DISABLE KEYS */;
/*!40000 ALTER TABLE `proctoring_proctoredexamreviewpolicy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proctoring_proctoredexamreviewpolicyhistory`
--

DROP TABLE IF EXISTS `proctoring_proctoredexamreviewpolicyhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proctoring_proctoredexamreviewpolicyhistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `original_id` int(11) NOT NULL,
  `review_policy` longtext NOT NULL,
  `proctored_exam_id` int(11) NOT NULL,
  `set_by_user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `proctoring_proctored_proctored_exam_id_8126b616_fk_proctorin` (`proctored_exam_id`),
  KEY `proctoring_proctored_set_by_user_id_42ce126e_fk_auth_user` (`set_by_user_id`),
  KEY `proctoring_proctoredexamreviewpolicyhistory_original_id_ca04913d` (`original_id`),
  CONSTRAINT `proctoring_proctored_proctored_exam_id_8126b616_fk_proctorin` FOREIGN KEY (`proctored_exam_id`) REFERENCES `proctoring_proctoredexam` (`id`),
  CONSTRAINT `proctoring_proctored_set_by_user_id_42ce126e_fk_auth_user` FOREIGN KEY (`set_by_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proctoring_proctoredexamreviewpolicyhistory`
--

LOCK TABLES `proctoring_proctoredexamreviewpolicyhistory` WRITE;
/*!40000 ALTER TABLE `proctoring_proctoredexamreviewpolicyhistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `proctoring_proctoredexamreviewpolicyhistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proctoring_proctoredexamsoftwaresecurereview`
--

DROP TABLE IF EXISTS `proctoring_proctoredexamsoftwaresecurereview`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proctoring_proctoredexamsoftwaresecurereview` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `attempt_code` varchar(255) NOT NULL,
  `review_status` varchar(255) NOT NULL,
  `raw_data` longtext NOT NULL,
  `video_url` longtext NOT NULL,
  `exam_id` int(11) DEFAULT NULL,
  `reviewed_by_id` int(11) DEFAULT NULL,
  `student_id` int(11) DEFAULT NULL,
  `is_attempt_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `proctoring_proctoredexam_attempt_code_706d3717_uniq` (`attempt_code`),
  KEY `proctoring_proctored_exam_id_ea6095a3_fk_proctorin` (`exam_id`),
  KEY `proctoring_proctored_reviewed_by_id_546b4204_fk_auth_user` (`reviewed_by_id`),
  KEY `proctoring_proctored_student_id_7e197288_fk_auth_user` (`student_id`),
  CONSTRAINT `proctoring_proctored_exam_id_ea6095a3_fk_proctorin` FOREIGN KEY (`exam_id`) REFERENCES `proctoring_proctoredexam` (`id`),
  CONSTRAINT `proctoring_proctored_reviewed_by_id_546b4204_fk_auth_user` FOREIGN KEY (`reviewed_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `proctoring_proctored_student_id_7e197288_fk_auth_user` FOREIGN KEY (`student_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proctoring_proctoredexamsoftwaresecurereview`
--

LOCK TABLES `proctoring_proctoredexamsoftwaresecurereview` WRITE;
/*!40000 ALTER TABLE `proctoring_proctoredexamsoftwaresecurereview` DISABLE KEYS */;
/*!40000 ALTER TABLE `proctoring_proctoredexamsoftwaresecurereview` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proctoring_proctoredexamsoftwaresecurereviewhistory`
--

DROP TABLE IF EXISTS `proctoring_proctoredexamsoftwaresecurereviewhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proctoring_proctoredexamsoftwaresecurereviewhistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `attempt_code` varchar(255) NOT NULL,
  `review_status` varchar(255) NOT NULL,
  `raw_data` longtext NOT NULL,
  `video_url` longtext NOT NULL,
  `exam_id` int(11) DEFAULT NULL,
  `reviewed_by_id` int(11) DEFAULT NULL,
  `student_id` int(11) DEFAULT NULL,
  `is_attempt_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `proctoring_proctored_exam_id_380d8588_fk_proctorin` (`exam_id`),
  KEY `proctoring_proctored_reviewed_by_id_bb993b3a_fk_auth_user` (`reviewed_by_id`),
  KEY `proctoring_proctored_student_id_97a63653_fk_auth_user` (`student_id`),
  KEY `proctoring_proctoredexamsof_attempt_code_695faa63` (`attempt_code`),
  CONSTRAINT `proctoring_proctored_exam_id_380d8588_fk_proctorin` FOREIGN KEY (`exam_id`) REFERENCES `proctoring_proctoredexam` (`id`),
  CONSTRAINT `proctoring_proctored_reviewed_by_id_bb993b3a_fk_auth_user` FOREIGN KEY (`reviewed_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `proctoring_proctored_student_id_97a63653_fk_auth_user` FOREIGN KEY (`student_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proctoring_proctoredexamsoftwaresecurereviewhistory`
--

LOCK TABLES `proctoring_proctoredexamsoftwaresecurereviewhistory` WRITE;
/*!40000 ALTER TABLE `proctoring_proctoredexamsoftwaresecurereviewhistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `proctoring_proctoredexamsoftwaresecurereviewhistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proctoring_proctoredexamstudentallowance`
--

DROP TABLE IF EXISTS `proctoring_proctoredexamstudentallowance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proctoring_proctoredexamstudentallowance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  `proctored_exam_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `proctoring_proctoredexam_user_id_proctored_exam_i_56de5b8f_uniq` (`user_id`,`proctored_exam_id`,`key`),
  KEY `proctoring_proctored_proctored_exam_id_9baf5a64_fk_proctorin` (`proctored_exam_id`),
  CONSTRAINT `proctoring_proctored_proctored_exam_id_9baf5a64_fk_proctorin` FOREIGN KEY (`proctored_exam_id`) REFERENCES `proctoring_proctoredexam` (`id`),
  CONSTRAINT `proctoring_proctored_user_id_f21ce9b6_fk_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proctoring_proctoredexamstudentallowance`
--

LOCK TABLES `proctoring_proctoredexamstudentallowance` WRITE;
/*!40000 ALTER TABLE `proctoring_proctoredexamstudentallowance` DISABLE KEYS */;
/*!40000 ALTER TABLE `proctoring_proctoredexamstudentallowance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proctoring_proctoredexamstudentallowancehistory`
--

DROP TABLE IF EXISTS `proctoring_proctoredexamstudentallowancehistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proctoring_proctoredexamstudentallowancehistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `allowance_id` int(11) NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  `proctored_exam_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `proctoring_proctored_proctored_exam_id_a4c8237c_fk_proctorin` (`proctored_exam_id`),
  KEY `proctoring_proctored_user_id_29b863c1_fk_auth_user` (`user_id`),
  CONSTRAINT `proctoring_proctored_proctored_exam_id_a4c8237c_fk_proctorin` FOREIGN KEY (`proctored_exam_id`) REFERENCES `proctoring_proctoredexam` (`id`),
  CONSTRAINT `proctoring_proctored_user_id_29b863c1_fk_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proctoring_proctoredexamstudentallowancehistory`
--

LOCK TABLES `proctoring_proctoredexamstudentallowancehistory` WRITE;
/*!40000 ALTER TABLE `proctoring_proctoredexamstudentallowancehistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `proctoring_proctoredexamstudentallowancehistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proctoring_proctoredexamstudentattempt`
--

DROP TABLE IF EXISTS `proctoring_proctoredexamstudentattempt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proctoring_proctoredexamstudentattempt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `started_at` datetime(6) DEFAULT NULL,
  `completed_at` datetime(6) DEFAULT NULL,
  `last_poll_timestamp` datetime(6) DEFAULT NULL,
  `last_poll_ipaddr` varchar(32) DEFAULT NULL,
  `attempt_code` varchar(255) DEFAULT NULL,
  `external_id` varchar(255) DEFAULT NULL,
  `allowed_time_limit_mins` int(11) DEFAULT NULL,
  `status` varchar(64) NOT NULL,
  `taking_as_proctored` tinyint(1) NOT NULL,
  `is_sample_attempt` tinyint(1) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `review_policy_id` int(11) DEFAULT NULL,
  `proctored_exam_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `is_status_acknowledged` tinyint(1) NOT NULL,
  `time_remaining_seconds` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `proctoring_proctored_proctored_exam_id_0732c688_fk_proctorin` (`proctored_exam_id`),
  KEY `proctoring_proctoredexamstudentattempt_attempt_code_b10ad854` (`attempt_code`),
  KEY `proctoring_proctoredexamstudentattempt_external_id_9c302af3` (`external_id`),
  KEY `proctoring_proctoredexamstudentattempt_user_id_2b58b7ed` (`user_id`),
  CONSTRAINT `proctoring_proctored_proctored_exam_id_0732c688_fk_proctorin` FOREIGN KEY (`proctored_exam_id`) REFERENCES `proctoring_proctoredexam` (`id`),
  CONSTRAINT `proctoring_proctored_user_id_2b58b7ed_fk_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proctoring_proctoredexamstudentattempt`
--

LOCK TABLES `proctoring_proctoredexamstudentattempt` WRITE;
/*!40000 ALTER TABLE `proctoring_proctoredexamstudentattempt` DISABLE KEYS */;
/*!40000 ALTER TABLE `proctoring_proctoredexamstudentattempt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proctoring_proctoredexamstudentattemptcomment`
--

DROP TABLE IF EXISTS `proctoring_proctoredexamstudentattemptcomment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proctoring_proctoredexamstudentattemptcomment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `start_time` int(11) NOT NULL,
  `stop_time` int(11) NOT NULL,
  `duration` int(11) NOT NULL,
  `comment` longtext NOT NULL,
  `status` varchar(255) NOT NULL,
  `review_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `proctoring_proctored_review_id_7f4eec67_fk_proctorin` (`review_id`),
  CONSTRAINT `proctoring_proctored_review_id_7f4eec67_fk_proctorin` FOREIGN KEY (`review_id`) REFERENCES `proctoring_proctoredexamsoftwaresecurereview` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proctoring_proctoredexamstudentattemptcomment`
--

LOCK TABLES `proctoring_proctoredexamstudentattemptcomment` WRITE;
/*!40000 ALTER TABLE `proctoring_proctoredexamstudentattemptcomment` DISABLE KEYS */;
/*!40000 ALTER TABLE `proctoring_proctoredexamstudentattemptcomment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proctoring_proctoredexamstudentattempthistory`
--

DROP TABLE IF EXISTS `proctoring_proctoredexamstudentattempthistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proctoring_proctoredexamstudentattempthistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `attempt_id` int(11) DEFAULT NULL,
  `started_at` datetime(6) DEFAULT NULL,
  `completed_at` datetime(6) DEFAULT NULL,
  `attempt_code` varchar(255) DEFAULT NULL,
  `external_id` varchar(255) DEFAULT NULL,
  `allowed_time_limit_mins` int(11) DEFAULT NULL,
  `status` varchar(64) NOT NULL,
  `taking_as_proctored` tinyint(1) NOT NULL,
  `is_sample_attempt` tinyint(1) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `review_policy_id` int(11) DEFAULT NULL,
  `last_poll_timestamp` datetime(6) DEFAULT NULL,
  `last_poll_ipaddr` varchar(32) DEFAULT NULL,
  `proctored_exam_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `proctoring_proctored_proctored_exam_id_72c6f4ab_fk_proctorin` (`proctored_exam_id`),
  KEY `proctoring_proctored_user_id_52fb8674_fk_auth_user` (`user_id`),
  KEY `proctoring_proctoredexamstu_attempt_code_8db28074` (`attempt_code`),
  KEY `proctoring_proctoredexamstu_external_id_65de5faf` (`external_id`),
  CONSTRAINT `proctoring_proctored_proctored_exam_id_72c6f4ab_fk_proctorin` FOREIGN KEY (`proctored_exam_id`) REFERENCES `proctoring_proctoredexam` (`id`),
  CONSTRAINT `proctoring_proctored_user_id_52fb8674_fk_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proctoring_proctoredexamstudentattempthistory`
--

LOCK TABLES `proctoring_proctoredexamstudentattempthistory` WRITE;
/*!40000 ALTER TABLE `proctoring_proctoredexamstudentattempthistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `proctoring_proctoredexamstudentattempthistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program_enrollments_courseaccessroleassignment`
--

DROP TABLE IF EXISTS `program_enrollments_courseaccessroleassignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program_enrollments_courseaccessroleassignment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `role` varchar(64) NOT NULL,
  `enrollment_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `program_enrollments_cour_role_enrollment_id_5a7bfa63_uniq` (`role`,`enrollment_id`),
  KEY `program_enrollments__enrollment_id_4e0853f0_fk_program_e` (`enrollment_id`),
  CONSTRAINT `program_enrollments__enrollment_id_4e0853f0_fk_program_e` FOREIGN KEY (`enrollment_id`) REFERENCES `program_enrollments_programcourseenrollment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program_enrollments_courseaccessroleassignment`
--

LOCK TABLES `program_enrollments_courseaccessroleassignment` WRITE;
/*!40000 ALTER TABLE `program_enrollments_courseaccessroleassignment` DISABLE KEYS */;
/*!40000 ALTER TABLE `program_enrollments_courseaccessroleassignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program_enrollments_historicalprogramcourseenrollment`
--

DROP TABLE IF EXISTS `program_enrollments_historicalprogramcourseenrollment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program_enrollments_historicalprogramcourseenrollment` (
  `id` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `course_key` varchar(255) NOT NULL,
  `status` varchar(9) NOT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `course_enrollment_id` int(11) DEFAULT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  `program_enrollment_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `program_enrollments__history_user_id_428d002e_fk_auth_user` (`history_user_id`),
  KEY `program_enrollments_histori_id_fe3a72a7` (`id`),
  KEY `program_enrollments_histori_course_enrollment_id_4014ff73` (`course_enrollment_id`),
  KEY `program_enrollments_histori_program_enrollment_id_ebb94d42` (`program_enrollment_id`),
  CONSTRAINT `program_enrollments__history_user_id_428d002e_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program_enrollments_historicalprogramcourseenrollment`
--

LOCK TABLES `program_enrollments_historicalprogramcourseenrollment` WRITE;
/*!40000 ALTER TABLE `program_enrollments_historicalprogramcourseenrollment` DISABLE KEYS */;
/*!40000 ALTER TABLE `program_enrollments_historicalprogramcourseenrollment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program_enrollments_historicalprogramenrollment`
--

DROP TABLE IF EXISTS `program_enrollments_historicalprogramenrollment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program_enrollments_historicalprogramenrollment` (
  `id` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `external_user_key` varchar(255) DEFAULT NULL,
  `program_uuid` char(32) NOT NULL,
  `curriculum_uuid` char(32) NOT NULL,
  `status` varchar(9) NOT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `program_enrollments__history_user_id_abf2d584_fk_auth_user` (`history_user_id`),
  KEY `program_enrollments_historicalprogramenrollment_id_947c385f` (`id`),
  KEY `program_enrollments_histori_external_user_key_5cd8d804` (`external_user_key`),
  KEY `program_enrollments_histori_program_uuid_4c520e40` (`program_uuid`),
  KEY `program_enrollments_histori_curriculum_uuid_a8325208` (`curriculum_uuid`),
  KEY `program_enrollments_historicalprogramenrollment_user_id_e205ccdf` (`user_id`),
  CONSTRAINT `program_enrollments__history_user_id_abf2d584_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program_enrollments_historicalprogramenrollment`
--

LOCK TABLES `program_enrollments_historicalprogramenrollment` WRITE;
/*!40000 ALTER TABLE `program_enrollments_historicalprogramenrollment` DISABLE KEYS */;
/*!40000 ALTER TABLE `program_enrollments_historicalprogramenrollment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program_enrollments_programcourseenrollment`
--

DROP TABLE IF EXISTS `program_enrollments_programcourseenrollment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program_enrollments_programcourseenrollment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `course_key` varchar(255) NOT NULL,
  `status` varchar(9) NOT NULL,
  `course_enrollment_id` int(11) DEFAULT NULL,
  `program_enrollment_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `program_enrollments_prog_program_enrollment_id_co_7d2701fb_uniq` (`program_enrollment_id`,`course_key`),
  KEY `program_enrollments_program_course_enrollment_id_d7890690` (`course_enrollment_id`),
  CONSTRAINT `program_enrollments__course_enrollment_id_d7890690_fk_student_c` FOREIGN KEY (`course_enrollment_id`) REFERENCES `student_courseenrollment` (`id`),
  CONSTRAINT `program_enrollments__program_enrollment_i_02ce2c32_fk_program_e` FOREIGN KEY (`program_enrollment_id`) REFERENCES `program_enrollments_programenrollment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program_enrollments_programcourseenrollment`
--

LOCK TABLES `program_enrollments_programcourseenrollment` WRITE;
/*!40000 ALTER TABLE `program_enrollments_programcourseenrollment` DISABLE KEYS */;
/*!40000 ALTER TABLE `program_enrollments_programcourseenrollment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program_enrollments_programenrollment`
--

DROP TABLE IF EXISTS `program_enrollments_programenrollment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program_enrollments_programenrollment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `external_user_key` varchar(255) DEFAULT NULL,
  `program_uuid` char(32) NOT NULL,
  `curriculum_uuid` char(32) NOT NULL,
  `status` varchar(9) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `program_enrollments_prog_external_user_key_progra_ec52a567_uniq` (`external_user_key`,`program_uuid`,`curriculum_uuid`),
  UNIQUE KEY `program_enrollments_prog_user_id_program_uuid_cur_ecf769fd_uniq` (`user_id`,`program_uuid`,`curriculum_uuid`),
  KEY `program_enrollments_programenrollment_external_user_key_c27b83c5` (`external_user_key`),
  KEY `program_enrollments_programenrollment_program_uuid_131378e0` (`program_uuid`),
  KEY `program_enrollments_programenrollment_curriculum_uuid_da64e123` (`curriculum_uuid`),
  KEY `program_enrollments_programenrollment_user_id_dcfde442` (`user_id`),
  CONSTRAINT `program_enrollments__user_id_dcfde442_fk_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program_enrollments_programenrollment`
--

LOCK TABLES `program_enrollments_programenrollment` WRITE;
/*!40000 ALTER TABLE `program_enrollments_programenrollment` DISABLE KEYS */;
/*!40000 ALTER TABLE `program_enrollments_programenrollment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `programs_customprogramsconfig`
--

DROP TABLE IF EXISTS `programs_customprogramsconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `programs_customprogramsconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `arguments` longtext NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `programs_customprogr_changed_by_id_ae95c36c_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `programs_customprogr_changed_by_id_ae95c36c_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `programs_customprogramsconfig`
--

LOCK TABLES `programs_customprogramsconfig` WRITE;
/*!40000 ALTER TABLE `programs_customprogramsconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `programs_customprogramsconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `programs_programsapiconfig`
--

DROP TABLE IF EXISTS `programs_programsapiconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `programs_programsapiconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  `marketing_path` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `programs_programsapi_changed_by_id_93e09d74_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `programs_programsapi_changed_by_id_93e09d74_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `programs_programsapiconfig`
--

LOCK TABLES `programs_programsapiconfig` WRITE;
/*!40000 ALTER TABLE `programs_programsapiconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `programs_programsapiconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rss_proxy_whitelistedrssurl`
--

DROP TABLE IF EXISTS `rss_proxy_whitelistedrssurl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rss_proxy_whitelistedrssurl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `url` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `url` (`url`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rss_proxy_whitelistedrssurl`
--

LOCK TABLES `rss_proxy_whitelistedrssurl` WRITE;
/*!40000 ALTER TABLE `rss_proxy_whitelistedrssurl` DISABLE KEYS */;
/*!40000 ALTER TABLE `rss_proxy_whitelistedrssurl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sap_success_factors_sapsuccessfactorsenterprisecustomerconfidb8a`
--

DROP TABLE IF EXISTS `sap_success_factors_sapsuccessfactorsenterprisecustomerconfidb8a`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sap_success_factors_sapsuccessfactorsenterprisecustomerconfidb8a` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `transmission_chunk_size` int(11) NOT NULL,
  `channel_worker_username` varchar(255) DEFAULT NULL,
  `catalogs_to_transmit` longtext,
  `key` varchar(255) NOT NULL,
  `sapsf_base_url` varchar(255) NOT NULL,
  `sapsf_company_id` varchar(255) NOT NULL,
  `sapsf_user_id` varchar(255) NOT NULL,
  `secret` varchar(255) NOT NULL,
  `user_type` varchar(20) NOT NULL,
  `additional_locales` longtext NOT NULL,
  `show_course_price` tinyint(1) NOT NULL,
  `transmit_total_hours` tinyint(1) NOT NULL,
  `enterprise_customer_id` char(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `enterprise_customer_id` (`enterprise_customer_id`),
  CONSTRAINT `sap_success_factors__enterprise_customer__4819a28c_fk_enterpris` FOREIGN KEY (`enterprise_customer_id`) REFERENCES `enterprise_enterprisecustomer` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sap_success_factors_sapsuccessfactorsenterprisecustomerconfidb8a`
--

LOCK TABLES `sap_success_factors_sapsuccessfactorsenterprisecustomerconfidb8a` WRITE;
/*!40000 ALTER TABLE `sap_success_factors_sapsuccessfactorsenterprisecustomerconfidb8a` DISABLE KEYS */;
/*!40000 ALTER TABLE `sap_success_factors_sapsuccessfactorsenterprisecustomerconfidb8a` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sap_success_factors_sapsuccessfactorsglobalconfiguration`
--

DROP TABLE IF EXISTS `sap_success_factors_sapsuccessfactorsglobalconfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sap_success_factors_sapsuccessfactorsglobalconfiguration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `completion_status_api_path` varchar(255) NOT NULL,
  `course_api_path` varchar(255) NOT NULL,
  `oauth_api_path` varchar(255) NOT NULL,
  `search_student_api_path` varchar(255) NOT NULL,
  `provider_id` varchar(100) NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sap_success_factors__changed_by_id_e3241cc9_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `sap_success_factors__changed_by_id_e3241cc9_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sap_success_factors_sapsuccessfactorsglobalconfiguration`
--

LOCK TABLES `sap_success_factors_sapsuccessfactorsglobalconfiguration` WRITE;
/*!40000 ALTER TABLE `sap_success_factors_sapsuccessfactorsglobalconfiguration` DISABLE KEYS */;
/*!40000 ALTER TABLE `sap_success_factors_sapsuccessfactorsglobalconfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sap_success_factors_sapsuccessfactorslearnerdatatransmission3ce5`
--

DROP TABLE IF EXISTS `sap_success_factors_sapsuccessfactorslearnerdatatransmission3ce5`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sap_success_factors_sapsuccessfactorslearnerdatatransmission3ce5` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sapsf_user_id` varchar(255) NOT NULL,
  `enterprise_course_enrollment_id` int(10) unsigned NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `course_completed` tinyint(1) NOT NULL,
  `instructor_name` varchar(255) NOT NULL,
  `grade` varchar(100) NOT NULL,
  `total_hours` double DEFAULT NULL,
  `completed_timestamp` bigint(20) NOT NULL,
  `status` varchar(100) NOT NULL,
  `error_message` longtext NOT NULL,
  `created` datetime(6) NOT NULL,
  `credit_hours` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sap_success_factors_sapsucc_enterprise_course_enrollmen_99be77d5` (`enterprise_course_enrollment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sap_success_factors_sapsuccessfactorslearnerdatatransmission3ce5`
--

LOCK TABLES `sap_success_factors_sapsuccessfactorslearnerdatatransmission3ce5` WRITE;
/*!40000 ALTER TABLE `sap_success_factors_sapsuccessfactorslearnerdatatransmission3ce5` DISABLE KEYS */;
/*!40000 ALTER TABLE `sap_success_factors_sapsuccessfactorslearnerdatatransmission3ce5` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedules_historicalschedule`
--

DROP TABLE IF EXISTS `schedules_historicalschedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schedules_historicalschedule` (
  `id` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `start_date` datetime(6) DEFAULT NULL,
  `upgrade_deadline` datetime(6) DEFAULT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `enrollment_id` int(11) DEFAULT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `schedules_historicalschedule_id_f1648c81` (`id`),
  KEY `schedules_historicalschedule_start_date_8c02ff20` (`start_date`),
  KEY `schedules_historicalschedule_upgrade_deadline_ba67bbd9` (`upgrade_deadline`),
  KEY `schedules_historicalschedule_enrollment_id_cd620413` (`enrollment_id`),
  KEY `schedules_historical_history_user_id_6f5d6d7b_fk_auth_user` (`history_user_id`),
  CONSTRAINT `schedules_historical_history_user_id_6f5d6d7b_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedules_historicalschedule`
--

LOCK TABLES `schedules_historicalschedule` WRITE;
/*!40000 ALTER TABLE `schedules_historicalschedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `schedules_historicalschedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedules_schedule`
--

DROP TABLE IF EXISTS `schedules_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schedules_schedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `upgrade_deadline` datetime(6) DEFAULT NULL,
  `enrollment_id` int(11) NOT NULL,
  `start_date` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `enrollment_id` (`enrollment_id`),
  KEY `schedules_schedule_upgrade_deadline_0079081d` (`upgrade_deadline`),
  KEY `schedules_schedule_start_date_3a1c341e` (`start_date`),
  CONSTRAINT `schedules_schedule_enrollment_id_91bf8152_fk_student_c` FOREIGN KEY (`enrollment_id`) REFERENCES `student_courseenrollment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedules_schedule`
--

LOCK TABLES `schedules_schedule` WRITE;
/*!40000 ALTER TABLE `schedules_schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `schedules_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedules_scheduleconfig`
--

DROP TABLE IF EXISTS `schedules_scheduleconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schedules_scheduleconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `enqueue_recurring_nudge` tinyint(1) NOT NULL,
  `deliver_recurring_nudge` tinyint(1) NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  `site_id` int(11) NOT NULL,
  `deliver_upgrade_reminder` tinyint(1) NOT NULL,
  `enqueue_upgrade_reminder` tinyint(1) NOT NULL,
  `deliver_course_update` tinyint(1) NOT NULL,
  `enqueue_course_update` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `schedules_scheduleconfig_changed_by_id_38ef599b_fk_auth_user_id` (`changed_by_id`),
  KEY `schedules_scheduleconfig_site_id_44296ee1_fk_django_site_id` (`site_id`),
  CONSTRAINT `schedules_scheduleconfig_changed_by_id_38ef599b_fk_auth_user_id` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `schedules_scheduleconfig_site_id_44296ee1_fk_django_site_id` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedules_scheduleconfig`
--

LOCK TABLES `schedules_scheduleconfig` WRITE;
/*!40000 ALTER TABLE `schedules_scheduleconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `schedules_scheduleconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedules_scheduleexperience`
--

DROP TABLE IF EXISTS `schedules_scheduleexperience`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schedules_scheduleexperience` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `experience_type` smallint(5) unsigned NOT NULL,
  `schedule_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `schedule_id` (`schedule_id`),
  CONSTRAINT `schedules_scheduleex_schedule_id_ed95c8e7_fk_schedules` FOREIGN KEY (`schedule_id`) REFERENCES `schedules_schedule` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedules_scheduleexperience`
--

LOCK TABLES `schedules_scheduleexperience` WRITE;
/*!40000 ALTER TABLE `schedules_scheduleexperience` DISABLE KEYS */;
/*!40000 ALTER TABLE `schedules_scheduleexperience` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `self_paced_selfpacedconfiguration`
--

DROP TABLE IF EXISTS `self_paced_selfpacedconfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `self_paced_selfpacedconfiguration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `enable_course_home_improvements` tinyint(1) NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `self_paced_selfpaced_changed_by_id_02789a26_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `self_paced_selfpaced_changed_by_id_02789a26_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `self_paced_selfpacedconfiguration`
--

LOCK TABLES `self_paced_selfpacedconfiguration` WRITE;
/*!40000 ALTER TABLE `self_paced_selfpacedconfiguration` DISABLE KEYS */;
/*!40000 ALTER TABLE `self_paced_selfpacedconfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_configuration_siteconfiguration`
--

DROP TABLE IF EXISTS `site_configuration_siteconfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_configuration_siteconfiguration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `site_values` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `site_id` (`site_id`),
  CONSTRAINT `site_configuration_s_site_id_84302d1f_fk_django_si` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_configuration_siteconfiguration`
--

LOCK TABLES `site_configuration_siteconfiguration` WRITE;
/*!40000 ALTER TABLE `site_configuration_siteconfiguration` DISABLE KEYS */;
/*!40000 ALTER TABLE `site_configuration_siteconfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_configuration_siteconfigurationhistory`
--

DROP TABLE IF EXISTS `site_configuration_siteconfigurationhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_configuration_siteconfigurationhistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `site_id` int(11) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `site_values` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `site_configuration_s_site_id_272f5c1a_fk_django_si` (`site_id`),
  CONSTRAINT `site_configuration_s_site_id_272f5c1a_fk_django_si` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_configuration_siteconfigurationhistory`
--

LOCK TABLES `site_configuration_siteconfigurationhistory` WRITE;
/*!40000 ALTER TABLE `site_configuration_siteconfigurationhistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `site_configuration_siteconfigurationhistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `social_auth_association`
--

DROP TABLE IF EXISTS `social_auth_association`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `social_auth_association` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `server_url` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `secret` varchar(255) NOT NULL,
  `issued` int(11) NOT NULL,
  `lifetime` int(11) NOT NULL,
  `assoc_type` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `social_auth_association_server_url_handle_078befa2_uniq` (`server_url`,`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_auth_association`
--

LOCK TABLES `social_auth_association` WRITE;
/*!40000 ALTER TABLE `social_auth_association` DISABLE KEYS */;
/*!40000 ALTER TABLE `social_auth_association` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `social_auth_code`
--

DROP TABLE IF EXISTS `social_auth_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `social_auth_code` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(254) NOT NULL,
  `code` varchar(32) NOT NULL,
  `verified` tinyint(1) NOT NULL,
  `timestamp` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `social_auth_code_email_code_801b2d02_uniq` (`email`,`code`),
  KEY `social_auth_code_code_a2393167` (`code`),
  KEY `social_auth_code_timestamp_176b341f` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_auth_code`
--

LOCK TABLES `social_auth_code` WRITE;
/*!40000 ALTER TABLE `social_auth_code` DISABLE KEYS */;
/*!40000 ALTER TABLE `social_auth_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `social_auth_nonce`
--

DROP TABLE IF EXISTS `social_auth_nonce`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `social_auth_nonce` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `server_url` varchar(255) NOT NULL,
  `timestamp` int(11) NOT NULL,
  `salt` varchar(65) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `social_auth_nonce_server_url_timestamp_salt_f6284463_uniq` (`server_url`,`timestamp`,`salt`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_auth_nonce`
--

LOCK TABLES `social_auth_nonce` WRITE;
/*!40000 ALTER TABLE `social_auth_nonce` DISABLE KEYS */;
/*!40000 ALTER TABLE `social_auth_nonce` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `social_auth_partial`
--

DROP TABLE IF EXISTS `social_auth_partial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `social_auth_partial` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` varchar(32) NOT NULL,
  `next_step` smallint(5) unsigned NOT NULL,
  `backend` varchar(32) NOT NULL,
  `data` longtext NOT NULL,
  `timestamp` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `social_auth_partial_token_3017fea3` (`token`),
  KEY `social_auth_partial_timestamp_50f2119f` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_auth_partial`
--

LOCK TABLES `social_auth_partial` WRITE;
/*!40000 ALTER TABLE `social_auth_partial` DISABLE KEYS */;
/*!40000 ALTER TABLE `social_auth_partial` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `social_auth_usersocialauth`
--

DROP TABLE IF EXISTS `social_auth_usersocialauth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `social_auth_usersocialauth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `provider` varchar(32) NOT NULL,
  `uid` varchar(255) NOT NULL,
  `extra_data` longtext NOT NULL,
  `user_id` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `social_auth_usersocialauth_provider_uid_e6b5e668_uniq` (`provider`,`uid`),
  KEY `social_auth_usersocialauth_user_id_17d28448_fk_auth_user_id` (`user_id`),
  KEY `social_auth_usersocialauth_uid_796e51dc` (`uid`),
  CONSTRAINT `social_auth_usersocialauth_user_id_17d28448_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_auth_usersocialauth`
--

LOCK TABLES `social_auth_usersocialauth` WRITE;
/*!40000 ALTER TABLE `social_auth_usersocialauth` DISABLE KEYS */;
/*!40000 ALTER TABLE `social_auth_usersocialauth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `splash_splashconfig`
--

DROP TABLE IF EXISTS `splash_splashconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `splash_splashconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `cookie_name` longtext NOT NULL,
  `cookie_allowed_values` longtext NOT NULL,
  `unaffected_usernames` longtext NOT NULL,
  `unaffected_url_paths` longtext NOT NULL,
  `redirect_url` varchar(200) NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `splash_splashconfig_changed_by_id_883b17ba_fk_auth_user_id` (`changed_by_id`),
  CONSTRAINT `splash_splashconfig_changed_by_id_883b17ba_fk_auth_user_id` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `splash_splashconfig`
--

LOCK TABLES `splash_splashconfig` WRITE;
/*!40000 ALTER TABLE `splash_splashconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `splash_splashconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `static_replace_assetbaseurlconfig`
--

DROP TABLE IF EXISTS `static_replace_assetbaseurlconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `static_replace_assetbaseurlconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `base_url` longtext NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `static_replace_asset_changed_by_id_f592e050_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `static_replace_asset_changed_by_id_f592e050_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `static_replace_assetbaseurlconfig`
--

LOCK TABLES `static_replace_assetbaseurlconfig` WRITE;
/*!40000 ALTER TABLE `static_replace_assetbaseurlconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `static_replace_assetbaseurlconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `static_replace_assetexcludedextensionsconfig`
--

DROP TABLE IF EXISTS `static_replace_assetexcludedextensionsconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `static_replace_assetexcludedextensionsconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `excluded_extensions` longtext NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `static_replace_asset_changed_by_id_e58299b3_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `static_replace_asset_changed_by_id_e58299b3_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `static_replace_assetexcludedextensionsconfig`
--

LOCK TABLES `static_replace_assetexcludedextensionsconfig` WRITE;
/*!40000 ALTER TABLE `static_replace_assetexcludedextensionsconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `static_replace_assetexcludedextensionsconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status_coursemessage`
--

DROP TABLE IF EXISTS `status_coursemessage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `status_coursemessage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_key` varchar(255) NOT NULL,
  `message` longtext,
  `global_message_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `status_coursemessage_course_key_90c77a2e` (`course_key`),
  KEY `status_coursemessage_global_message_id_01bbfbe6_fk_status_gl` (`global_message_id`),
  CONSTRAINT `status_coursemessage_global_message_id_01bbfbe6_fk_status_gl` FOREIGN KEY (`global_message_id`) REFERENCES `status_globalstatusmessage` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status_coursemessage`
--

LOCK TABLES `status_coursemessage` WRITE;
/*!40000 ALTER TABLE `status_coursemessage` DISABLE KEYS */;
/*!40000 ALTER TABLE `status_coursemessage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status_globalstatusmessage`
--

DROP TABLE IF EXISTS `status_globalstatusmessage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `status_globalstatusmessage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `message` longtext,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `status_globalstatusm_changed_by_id_3c627848_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `status_globalstatusm_changed_by_id_3c627848_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status_globalstatusmessage`
--

LOCK TABLES `status_globalstatusmessage` WRITE;
/*!40000 ALTER TABLE `status_globalstatusmessage` DISABLE KEYS */;
/*!40000 ALTER TABLE `status_globalstatusmessage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_accountrecoveryconfiguration`
--

DROP TABLE IF EXISTS `student_accountrecoveryconfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_accountrecoveryconfiguration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `csv_file` varchar(100) NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `student_accountrecov_changed_by_id_d9d1ddf6_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `student_accountrecov_changed_by_id_d9d1ddf6_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_accountrecoveryconfiguration`
--

LOCK TABLES `student_accountrecoveryconfiguration` WRITE;
/*!40000 ALTER TABLE `student_accountrecoveryconfiguration` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_accountrecoveryconfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_allowedauthuser`
--

DROP TABLE IF EXISTS `student_allowedauthuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_allowedauthuser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `email` varchar(254) NOT NULL,
  `site_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `student_allowedauthuser_site_id_9a6aae9b_fk_django_site_id` (`site_id`),
  CONSTRAINT `student_allowedauthuser_site_id_9a6aae9b_fk_django_site_id` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_allowedauthuser`
--

LOCK TABLES `student_allowedauthuser` WRITE;
/*!40000 ALTER TABLE `student_allowedauthuser` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_allowedauthuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_anonymoususerid`
--

DROP TABLE IF EXISTS `student_anonymoususerid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_anonymoususerid` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `anonymous_user_id` varchar(32) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `anonymous_user_id` (`anonymous_user_id`),
  KEY `student_anonymoususerid_user_id_0fb2ad5c_fk_auth_user_id` (`user_id`),
  KEY `student_anonymoususerid_course_id_99cc6a18` (`course_id`),
  CONSTRAINT `student_anonymoususerid_user_id_0fb2ad5c_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_anonymoususerid`
--

LOCK TABLES `student_anonymoususerid` WRITE;
/*!40000 ALTER TABLE `student_anonymoususerid` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_anonymoususerid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_bulkchangeenrollmentconfiguration`
--

DROP TABLE IF EXISTS `student_bulkchangeenrollmentconfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_bulkchangeenrollmentconfiguration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `csv_file` varchar(100) NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `student_bulkchangeen_changed_by_id_38bf23de_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `student_bulkchangeen_changed_by_id_38bf23de_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_bulkchangeenrollmentconfiguration`
--

LOCK TABLES `student_bulkchangeenrollmentconfiguration` WRITE;
/*!40000 ALTER TABLE `student_bulkchangeenrollmentconfiguration` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_bulkchangeenrollmentconfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_bulkunenrollconfiguration`
--

DROP TABLE IF EXISTS `student_bulkunenrollconfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_bulkunenrollconfiguration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `csv_file` varchar(100) NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `student_bulkunenroll_changed_by_id_7b6131b9_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `student_bulkunenroll_changed_by_id_7b6131b9_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_bulkunenrollconfiguration`
--

LOCK TABLES `student_bulkunenrollconfiguration` WRITE;
/*!40000 ALTER TABLE `student_bulkunenrollconfiguration` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_bulkunenrollconfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_courseaccessrole`
--

DROP TABLE IF EXISTS `student_courseaccessrole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_courseaccessrole` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `org` varchar(64) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `role` varchar(64) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `student_courseaccessrole_user_id_org_course_id_ro_bbf71126_uniq` (`user_id`,`org`,`course_id`,`role`),
  KEY `student_courseaccessrole_org_6d2dbb7a` (`org`),
  KEY `student_courseaccessrole_course_id_60fb355e` (`course_id`),
  KEY `student_courseaccessrole_role_1ac888ea` (`role`),
  CONSTRAINT `student_courseaccessrole_user_id_90cf21fe_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_courseaccessrole`
--

LOCK TABLES `student_courseaccessrole` WRITE;
/*!40000 ALTER TABLE `student_courseaccessrole` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_courseaccessrole` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_courseenrollment`
--

DROP TABLE IF EXISTS `student_courseenrollment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_courseenrollment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` varchar(255) NOT NULL,
  `created` datetime(6) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `mode` varchar(100) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `student_courseenrollment_user_id_course_id_5d34a47f_uniq` (`user_id`,`course_id`),
  KEY `student_courseenrollment_user_id_4263a8e2` (`user_id`),
  KEY `student_cou_user_id_b19dcd_idx` (`user_id`,`created`),
  KEY `student_courseenrollment_course_id_a6f93be8` (`course_id`),
  KEY `student_courseenrollment_created_79829893` (`created`),
  CONSTRAINT `student_courseenrollment_user_id_4263a8e2_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_courseenrollment`
--

LOCK TABLES `student_courseenrollment` WRITE;
/*!40000 ALTER TABLE `student_courseenrollment` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_courseenrollment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_courseenrollment_history`
--

DROP TABLE IF EXISTS `student_courseenrollment_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_courseenrollment_history` (
  `id` int(11) NOT NULL,
  `created` datetime(6) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `mode` varchar(100) NOT NULL,
  `history_id` char(32) NOT NULL,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `course_id` varchar(255) DEFAULT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `student_courseenroll_history_user_id_7065c772_fk_auth_user` (`history_user_id`),
  KEY `student_courseenrollment_history_id_2d80b9b3` (`id`),
  KEY `student_courseenrollment_history_created_6b3154af` (`created`),
  KEY `student_courseenrollment_history_course_id_98f13917` (`course_id`),
  KEY `student_courseenrollment_history_user_id_5f94c628` (`user_id`),
  CONSTRAINT `student_courseenroll_history_user_id_7065c772_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_courseenrollment_history`
--

LOCK TABLES `student_courseenrollment_history` WRITE;
/*!40000 ALTER TABLE `student_courseenrollment_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_courseenrollment_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_courseenrollmentallowed`
--

DROP TABLE IF EXISTS `student_courseenrollmentallowed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_courseenrollmentallowed` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `auto_enroll` tinyint(1) NOT NULL,
  `created` datetime(6) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `student_courseenrollmentallowed_email_course_id_1e23ed5e_uniq` (`email`,`course_id`),
  KEY `student_courseenrollmentallowed_email_969706a0` (`email`),
  KEY `student_courseenrollmentallowed_course_id_67eff667` (`course_id`),
  KEY `student_courseenrollmentallowed_created_b2066658` (`created`),
  KEY `student_courseenrollmentallowed_user_id_5875cce6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `student_courseenrollmentallowed_user_id_5875cce6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_courseenrollmentallowed`
--

LOCK TABLES `student_courseenrollmentallowed` WRITE;
/*!40000 ALTER TABLE `student_courseenrollmentallowed` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_courseenrollmentallowed` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_courseenrollmentattribute`
--

DROP TABLE IF EXISTS `student_courseenrollmentattribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_courseenrollmentattribute` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `namespace` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  `enrollment_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `student_courseenroll_enrollment_id_b2173db0_fk_student_c` (`enrollment_id`),
  CONSTRAINT `student_courseenroll_enrollment_id_b2173db0_fk_student_c` FOREIGN KEY (`enrollment_id`) REFERENCES `student_courseenrollment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_courseenrollmentattribute`
--

LOCK TABLES `student_courseenrollmentattribute` WRITE;
/*!40000 ALTER TABLE `student_courseenrollmentattribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_courseenrollmentattribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_courseenrollmentcelebration`
--

DROP TABLE IF EXISTS `student_courseenrollmentcelebration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_courseenrollmentcelebration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `celebrate_first_section` tinyint(1) NOT NULL,
  `enrollment_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `enrollment_id` (`enrollment_id`),
  CONSTRAINT `student_courseenroll_enrollment_id_c697e4ce_fk_student_c` FOREIGN KEY (`enrollment_id`) REFERENCES `student_courseenrollment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_courseenrollmentcelebration`
--

LOCK TABLES `student_courseenrollmentcelebration` WRITE;
/*!40000 ALTER TABLE `student_courseenrollmentcelebration` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_courseenrollmentcelebration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_dashboardconfiguration`
--

DROP TABLE IF EXISTS `student_dashboardconfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_dashboardconfiguration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `recent_enrollment_time_delta` int(10) unsigned NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `student_dashboardcon_changed_by_id_1960484b_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `student_dashboardcon_changed_by_id_1960484b_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_dashboardconfiguration`
--

LOCK TABLES `student_dashboardconfiguration` WRITE;
/*!40000 ALTER TABLE `student_dashboardconfiguration` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_dashboardconfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_enrollmentrefundconfiguration`
--

DROP TABLE IF EXISTS `student_enrollmentrefundconfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_enrollmentrefundconfiguration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `refund_window_microseconds` bigint(20) NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `student_enrollmentre_changed_by_id_082b4f6f_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `student_enrollmentre_changed_by_id_082b4f6f_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_enrollmentrefundconfiguration`
--

LOCK TABLES `student_enrollmentrefundconfiguration` WRITE;
/*!40000 ALTER TABLE `student_enrollmentrefundconfiguration` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_enrollmentrefundconfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_entranceexamconfiguration`
--

DROP TABLE IF EXISTS `student_entranceexamconfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_entranceexamconfiguration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` varchar(255) NOT NULL,
  `created` datetime(6) DEFAULT NULL,
  `updated` datetime(6) NOT NULL,
  `skip_entrance_exam` tinyint(1) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `student_entranceexamconf_user_id_course_id_23bbcf9b_uniq` (`user_id`,`course_id`),
  KEY `student_entranceexamconfiguration_course_id_eca5c3d4` (`course_id`),
  KEY `student_entranceexamconfiguration_created_27e80637` (`created`),
  KEY `student_entranceexamconfiguration_updated_d560d552` (`updated`),
  CONSTRAINT `student_entranceexam_user_id_387a35d6_fk_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_entranceexamconfiguration`
--

LOCK TABLES `student_entranceexamconfiguration` WRITE;
/*!40000 ALTER TABLE `student_entranceexamconfiguration` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_entranceexamconfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_fbeenrollmentexclusion`
--

DROP TABLE IF EXISTS `student_fbeenrollmentexclusion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_fbeenrollmentexclusion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `enrollment_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `enrollment_id` (`enrollment_id`),
  CONSTRAINT `student_fbeenrollmen_enrollment_id_28537ff8_fk_student_c` FOREIGN KEY (`enrollment_id`) REFERENCES `student_courseenrollment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_fbeenrollmentexclusion`
--

LOCK TABLES `student_fbeenrollmentexclusion` WRITE;
/*!40000 ALTER TABLE `student_fbeenrollmentexclusion` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_fbeenrollmentexclusion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_historicalmanualenrollmentaudit`
--

DROP TABLE IF EXISTS `student_historicalmanualenrollmentaudit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_historicalmanualenrollmentaudit` (
  `id` int(11) NOT NULL,
  `enrolled_email` varchar(255) NOT NULL,
  `time_stamp` datetime(6) DEFAULT NULL,
  `state_transition` varchar(255) NOT NULL,
  `reason` longtext,
  `role` varchar(64) DEFAULT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `enrolled_by_id` int(11) DEFAULT NULL,
  `enrollment_id` int(11) DEFAULT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `student_historicalma_history_user_id_b5f488c2_fk_auth_user` (`history_user_id`),
  KEY `student_historicalmanualenrollmentaudit_id_18eb7e98` (`id`),
  KEY `student_historicalmanualenrollmentaudit_enrolled_email_bfaa34b3` (`enrolled_email`),
  KEY `student_historicalmanualenrollmentaudit_enrolled_by_id_0838a44b` (`enrolled_by_id`),
  KEY `student_historicalmanualenrollmentaudit_enrollment_id_b74f8923` (`enrollment_id`),
  CONSTRAINT `student_historicalma_history_user_id_b5f488c2_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_historicalmanualenrollmentaudit`
--

LOCK TABLES `student_historicalmanualenrollmentaudit` WRITE;
/*!40000 ALTER TABLE `student_historicalmanualenrollmentaudit` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_historicalmanualenrollmentaudit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_languageproficiency`
--

DROP TABLE IF EXISTS `student_languageproficiency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_languageproficiency` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(16) NOT NULL,
  `user_profile_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `student_languageproficiency_code_user_profile_id_9aa4e2f5_uniq` (`code`,`user_profile_id`),
  KEY `student_languageprof_user_profile_id_768cd3eb_fk_auth_user` (`user_profile_id`),
  CONSTRAINT `student_languageprof_user_profile_id_768cd3eb_fk_auth_user` FOREIGN KEY (`user_profile_id`) REFERENCES `auth_userprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_languageproficiency`
--

LOCK TABLES `student_languageproficiency` WRITE;
/*!40000 ALTER TABLE `student_languageproficiency` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_languageproficiency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_linkedinaddtoprofileconfiguration`
--

DROP TABLE IF EXISTS `student_linkedinaddtoprofileconfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_linkedinaddtoprofileconfiguration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `company_identifier` longtext NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `student_linkedinaddt_changed_by_id_dc1c453f_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `student_linkedinaddt_changed_by_id_dc1c453f_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_linkedinaddtoprofileconfiguration`
--

LOCK TABLES `student_linkedinaddtoprofileconfiguration` WRITE;
/*!40000 ALTER TABLE `student_linkedinaddtoprofileconfiguration` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_linkedinaddtoprofileconfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_loginfailures`
--

DROP TABLE IF EXISTS `student_loginfailures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_loginfailures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `failure_count` int(11) NOT NULL,
  `lockout_until` datetime(6) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `student_loginfailures_user_id_50d85202_fk_auth_user_id` (`user_id`),
  CONSTRAINT `student_loginfailures_user_id_50d85202_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_loginfailures`
--

LOCK TABLES `student_loginfailures` WRITE;
/*!40000 ALTER TABLE `student_loginfailures` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_loginfailures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_manualenrollmentaudit`
--

DROP TABLE IF EXISTS `student_manualenrollmentaudit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_manualenrollmentaudit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `enrolled_email` varchar(255) NOT NULL,
  `time_stamp` datetime(6) DEFAULT NULL,
  `state_transition` varchar(255) NOT NULL,
  `reason` longtext,
  `enrolled_by_id` int(11) DEFAULT NULL,
  `enrollment_id` int(11) DEFAULT NULL,
  `role` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `student_manualenroll_enrolled_by_id_1217a0dc_fk_auth_user` (`enrolled_by_id`),
  KEY `student_manualenroll_enrollment_id_decc94fe_fk_student_c` (`enrollment_id`),
  KEY `student_manualenrollmentaudit_enrolled_email_47ce6524` (`enrolled_email`),
  CONSTRAINT `student_manualenroll_enrolled_by_id_1217a0dc_fk_auth_user` FOREIGN KEY (`enrolled_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `student_manualenroll_enrollment_id_decc94fe_fk_student_c` FOREIGN KEY (`enrollment_id`) REFERENCES `student_courseenrollment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_manualenrollmentaudit`
--

LOCK TABLES `student_manualenrollmentaudit` WRITE;
/*!40000 ALTER TABLE `student_manualenrollmentaudit` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_manualenrollmentaudit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_pendingemailchange`
--

DROP TABLE IF EXISTS `student_pendingemailchange`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_pendingemailchange` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `new_email` varchar(255) NOT NULL,
  `activation_key` varchar(32) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `activation_key` (`activation_key`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `student_pendingemailchange_new_email_6887bdea` (`new_email`),
  CONSTRAINT `student_pendingemailchange_user_id_8f2778c5_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_pendingemailchange`
--

LOCK TABLES `student_pendingemailchange` WRITE;
/*!40000 ALTER TABLE `student_pendingemailchange` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_pendingemailchange` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_pendingnamechange`
--

DROP TABLE IF EXISTS `student_pendingnamechange`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_pendingnamechange` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `new_name` varchar(255) NOT NULL,
  `rationale` varchar(1024) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `student_pendingnamechange_user_id_e2cd8b70_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_pendingnamechange`
--

LOCK TABLES `student_pendingnamechange` WRITE;
/*!40000 ALTER TABLE `student_pendingnamechange` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_pendingnamechange` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_pendingsecondaryemailchange`
--

DROP TABLE IF EXISTS `student_pendingsecondaryemailchange`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_pendingsecondaryemailchange` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `new_secondary_email` varchar(255) NOT NULL,
  `activation_key` varchar(32) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `activation_key` (`activation_key`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `student_pendingsecondaryemailchange_new_secondary_email_5e79db59` (`new_secondary_email`),
  CONSTRAINT `student_pendingsecon_user_id_deacc54f_fk_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_pendingsecondaryemailchange`
--

LOCK TABLES `student_pendingsecondaryemailchange` WRITE;
/*!40000 ALTER TABLE `student_pendingsecondaryemailchange` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_pendingsecondaryemailchange` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_registrationcookieconfiguration`
--

DROP TABLE IF EXISTS `student_registrationcookieconfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_registrationcookieconfiguration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `utm_cookie_name` varchar(255) NOT NULL,
  `affiliate_cookie_name` varchar(255) NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `student_registration_changed_by_id_52ac88b0_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `student_registration_changed_by_id_52ac88b0_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_registrationcookieconfiguration`
--

LOCK TABLES `student_registrationcookieconfiguration` WRITE;
/*!40000 ALTER TABLE `student_registrationcookieconfiguration` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_registrationcookieconfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_sociallink`
--

DROP TABLE IF EXISTS `student_sociallink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_sociallink` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `platform` varchar(30) NOT NULL,
  `social_link` varchar(100) NOT NULL,
  `user_profile_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `student_sociallink_user_profile_id_19f54475_fk_auth_user` (`user_profile_id`),
  CONSTRAINT `student_sociallink_user_profile_id_19f54475_fk_auth_user` FOREIGN KEY (`user_profile_id`) REFERENCES `auth_userprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_sociallink`
--

LOCK TABLES `student_sociallink` WRITE;
/*!40000 ALTER TABLE `student_sociallink` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_sociallink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_userattribute`
--

DROP TABLE IF EXISTS `student_userattribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_userattribute` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `name` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `student_userattribute_user_id_name_70e18f46_uniq` (`user_id`,`name`),
  KEY `student_userattribute_name_a55155e3` (`name`),
  CONSTRAINT `student_userattribute_user_id_19c01f5e_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_userattribute`
--

LOCK TABLES `student_userattribute` WRITE;
/*!40000 ALTER TABLE `student_userattribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_userattribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_usercelebration`
--

DROP TABLE IF EXISTS `student_usercelebration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_usercelebration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `last_day_of_streak` date DEFAULT NULL,
  `streak_length` int(11) NOT NULL,
  `longest_ever_streak` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `student_usercelebration_user_id_8682222f_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_usercelebration`
--

LOCK TABLES `student_usercelebration` WRITE;
/*!40000 ALTER TABLE `student_usercelebration` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_usercelebration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_userpasswordtogglehistory`
--

DROP TABLE IF EXISTS `student_userpasswordtogglehistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_userpasswordtogglehistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `disabled` tinyint(1) NOT NULL,
  `created_by_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `student_userpassword_created_by_id_f7092add_fk_auth_user` (`created_by_id`),
  KEY `student_userpassword_user_id_1e2a09c9_fk_auth_user` (`user_id`),
  CONSTRAINT `student_userpassword_created_by_id_f7092add_fk_auth_user` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `student_userpassword_user_id_1e2a09c9_fk_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_userpasswordtogglehistory`
--

LOCK TABLES `student_userpasswordtogglehistory` WRITE;
/*!40000 ALTER TABLE `student_userpasswordtogglehistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_userpasswordtogglehistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_usersignupsource`
--

DROP TABLE IF EXISTS `student_usersignupsource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_usersignupsource` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `student_usersignupsource_user_id_4979dd6e_fk_auth_user_id` (`user_id`),
  KEY `student_usersignupsource_site_beb4d383` (`site`),
  CONSTRAINT `student_usersignupsource_user_id_4979dd6e_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_usersignupsource`
--

LOCK TABLES `student_usersignupsource` WRITE;
/*!40000 ALTER TABLE `student_usersignupsource` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_usersignupsource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_userstanding`
--

DROP TABLE IF EXISTS `student_userstanding`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_userstanding` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_status` varchar(31) NOT NULL,
  `standing_last_changed_at` datetime(6) NOT NULL,
  `changed_by_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `student_userstanding_changed_by_id_469252b4_fk_auth_user_id` (`changed_by_id`),
  CONSTRAINT `student_userstanding_changed_by_id_469252b4_fk_auth_user_id` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `student_userstanding_user_id_00b147e5_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_userstanding`
--

LOCK TABLES `student_userstanding` WRITE;
/*!40000 ALTER TABLE `student_userstanding` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_userstanding` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_usertestgroup`
--

DROP TABLE IF EXISTS `student_usertestgroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_usertestgroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `description` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `student_usertestgroup_name_94f48ddb` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_usertestgroup`
--

LOCK TABLES `student_usertestgroup` WRITE;
/*!40000 ALTER TABLE `student_usertestgroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_usertestgroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_usertestgroup_users`
--

DROP TABLE IF EXISTS `student_usertestgroup_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_usertestgroup_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usertestgroup_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `student_usertestgroup_us_usertestgroup_id_user_id_2bbf095a_uniq` (`usertestgroup_id`,`user_id`),
  KEY `student_usertestgroup_users_user_id_81b93062_fk_auth_user_id` (`user_id`),
  CONSTRAINT `student_usertestgrou_usertestgroup_id_a9097958_fk_student_u` FOREIGN KEY (`usertestgroup_id`) REFERENCES `student_usertestgroup` (`id`),
  CONSTRAINT `student_usertestgroup_users_user_id_81b93062_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_usertestgroup_users`
--

LOCK TABLES `student_usertestgroup_users` WRITE;
/*!40000 ALTER TABLE `student_usertestgroup_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_usertestgroup_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `submissions_score`
--

DROP TABLE IF EXISTS `submissions_score`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `submissions_score` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `points_earned` int(10) unsigned NOT NULL,
  `points_possible` int(10) unsigned NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `reset` tinyint(1) NOT NULL,
  `student_item_id` int(11) NOT NULL,
  `submission_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `submissions_score_created_at_b65f0390` (`created_at`),
  KEY `submissions_score_student_item_id_de4f5954_fk_submissio` (`student_item_id`),
  KEY `submissions_score_submission_id_ba095829_fk_submissio` (`submission_id`),
  CONSTRAINT `submissions_score_student_item_id_de4f5954_fk_submissio` FOREIGN KEY (`student_item_id`) REFERENCES `submissions_studentitem` (`id`),
  CONSTRAINT `submissions_score_submission_id_ba095829_fk_submissio` FOREIGN KEY (`submission_id`) REFERENCES `submissions_submission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submissions_score`
--

LOCK TABLES `submissions_score` WRITE;
/*!40000 ALTER TABLE `submissions_score` DISABLE KEYS */;
/*!40000 ALTER TABLE `submissions_score` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `submissions_scoreannotation`
--

DROP TABLE IF EXISTS `submissions_scoreannotation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `submissions_scoreannotation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `annotation_type` varchar(255) NOT NULL,
  `creator` varchar(255) NOT NULL,
  `reason` longtext NOT NULL,
  `score_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `submissions_scoreann_score_id_2dda6e02_fk_submissio` (`score_id`),
  KEY `submissions_scoreannotation_annotation_type_117a2607` (`annotation_type`),
  KEY `submissions_scoreannotation_creator_5cc126cc` (`creator`),
  CONSTRAINT `submissions_scoreann_score_id_2dda6e02_fk_submissio` FOREIGN KEY (`score_id`) REFERENCES `submissions_score` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submissions_scoreannotation`
--

LOCK TABLES `submissions_scoreannotation` WRITE;
/*!40000 ALTER TABLE `submissions_scoreannotation` DISABLE KEYS */;
/*!40000 ALTER TABLE `submissions_scoreannotation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `submissions_scoresummary`
--

DROP TABLE IF EXISTS `submissions_scoresummary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `submissions_scoresummary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `highest_id` int(11) NOT NULL,
  `latest_id` int(11) NOT NULL,
  `student_item_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `student_item_id` (`student_item_id`),
  KEY `submissions_scoresum_highest_id_3efe897d_fk_submissio` (`highest_id`),
  KEY `submissions_scoresum_latest_id_dd8a17bb_fk_submissio` (`latest_id`),
  CONSTRAINT `submissions_scoresum_highest_id_3efe897d_fk_submissio` FOREIGN KEY (`highest_id`) REFERENCES `submissions_score` (`id`),
  CONSTRAINT `submissions_scoresum_latest_id_dd8a17bb_fk_submissio` FOREIGN KEY (`latest_id`) REFERENCES `submissions_score` (`id`),
  CONSTRAINT `submissions_scoresum_student_item_id_35f8ef06_fk_submissio` FOREIGN KEY (`student_item_id`) REFERENCES `submissions_studentitem` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submissions_scoresummary`
--

LOCK TABLES `submissions_scoresummary` WRITE;
/*!40000 ALTER TABLE `submissions_scoresummary` DISABLE KEYS */;
/*!40000 ALTER TABLE `submissions_scoresummary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `submissions_studentitem`
--

DROP TABLE IF EXISTS `submissions_studentitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `submissions_studentitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` varchar(255) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `item_id` varchar(255) NOT NULL,
  `item_type` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `submissions_studentitem_course_id_student_id_ite_5b02ecf8_uniq` (`course_id`,`student_id`,`item_id`),
  KEY `submissions_studentitem_student_id_8e72bcd9` (`student_id`),
  KEY `submissions_studentitem_course_id_05ee1efe` (`course_id`),
  KEY `submissions_studentitem_item_id_6c409784` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submissions_studentitem`
--

LOCK TABLES `submissions_studentitem` WRITE;
/*!40000 ALTER TABLE `submissions_studentitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `submissions_studentitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `submissions_submission`
--

DROP TABLE IF EXISTS `submissions_submission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `submissions_submission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(32) NOT NULL,
  `attempt_number` int(10) unsigned NOT NULL,
  `submitted_at` datetime(6) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `raw_answer` longtext NOT NULL,
  `student_item_id` int(11) NOT NULL,
  `status` varchar(1) NOT NULL,
  `team_submission_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `submissions_submissi_student_item_id_9d087470_fk_submissio` (`student_item_id`),
  KEY `submissions_submission_uuid_210428ab` (`uuid`),
  KEY `submissions_submission_submitted_at_9653124d` (`submitted_at`),
  KEY `submissions_submission_created_at_01c4bf22` (`created_at`),
  KEY `submissions_submissi_team_submission_id_40e6bc97_fk_submissio` (`team_submission_id`),
  CONSTRAINT `submissions_submissi_student_item_id_9d087470_fk_submissio` FOREIGN KEY (`student_item_id`) REFERENCES `submissions_studentitem` (`id`),
  CONSTRAINT `submissions_submissi_team_submission_id_40e6bc97_fk_submissio` FOREIGN KEY (`team_submission_id`) REFERENCES `submissions_teamsubmission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submissions_submission`
--

LOCK TABLES `submissions_submission` WRITE;
/*!40000 ALTER TABLE `submissions_submission` DISABLE KEYS */;
/*!40000 ALTER TABLE `submissions_submission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `submissions_teamsubmission`
--

DROP TABLE IF EXISTS `submissions_teamsubmission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `submissions_teamsubmission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `uuid` char(32) NOT NULL,
  `attempt_number` int(10) unsigned NOT NULL,
  `submitted_at` datetime(6) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `item_id` varchar(255) NOT NULL,
  `team_id` varchar(255) NOT NULL,
  `status` varchar(1) NOT NULL,
  `submitted_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `submissions_teamsubm_submitted_by_id_5a27162a_fk_auth_user` (`submitted_by_id`),
  KEY `submissions_teamsubmission_uuid_4d1aef87` (`uuid`),
  KEY `submissions_teamsubmission_submitted_at_74e28ed6` (`submitted_at`),
  KEY `submissions_teamsubmission_course_id_68c6908d` (`course_id`),
  KEY `submissions_teamsubmission_item_id_2bdcb26c` (`item_id`),
  KEY `submissions_teamsubmission_team_id_5fda0e54` (`team_id`),
  CONSTRAINT `submissions_teamsubm_submitted_by_id_5a27162a_fk_auth_user` FOREIGN KEY (`submitted_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submissions_teamsubmission`
--

LOCK TABLES `submissions_teamsubmission` WRITE;
/*!40000 ALTER TABLE `submissions_teamsubmission` DISABLE KEYS */;
/*!40000 ALTER TABLE `submissions_teamsubmission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `super_csv_csvoperation`
--

DROP TABLE IF EXISTS `super_csv_csvoperation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `super_csv_csvoperation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `class_name` varchar(255) NOT NULL,
  `unique_id` varchar(255) NOT NULL,
  `operation` varchar(255) NOT NULL,
  `data` varchar(255) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `original_filename` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `super_csv_csvoperation_class_name_c8b5b4e2` (`class_name`),
  KEY `super_csv_csvoperation_unique_id_08aa974e` (`unique_id`),
  KEY `super_csv_csvoperation_user_id_f87de59a_fk_auth_user_id` (`user_id`),
  CONSTRAINT `super_csv_csvoperation_user_id_f87de59a_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `super_csv_csvoperation`
--

LOCK TABLES `super_csv_csvoperation` WRITE;
/*!40000 ALTER TABLE `super_csv_csvoperation` DISABLE KEYS */;
/*!40000 ALTER TABLE `super_csv_csvoperation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `survey_surveyanswer`
--

DROP TABLE IF EXISTS `survey_surveyanswer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `survey_surveyanswer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `field_name` varchar(255) NOT NULL,
  `field_value` varchar(1024) NOT NULL,
  `course_key` varchar(255) DEFAULT NULL,
  `form_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `survey_surveyanswer_field_name_7123dc3d` (`field_name`),
  KEY `survey_surveyanswer_course_key_497ade68` (`course_key`),
  KEY `survey_surveyanswer_form_id_7f0df59f_fk_survey_surveyform_id` (`form_id`),
  KEY `survey_surveyanswer_user_id_4c028d25_fk_auth_user_id` (`user_id`),
  CONSTRAINT `survey_surveyanswer_form_id_7f0df59f_fk_survey_surveyform_id` FOREIGN KEY (`form_id`) REFERENCES `survey_surveyform` (`id`),
  CONSTRAINT `survey_surveyanswer_user_id_4c028d25_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `survey_surveyanswer`
--

LOCK TABLES `survey_surveyanswer` WRITE;
/*!40000 ALTER TABLE `survey_surveyanswer` DISABLE KEYS */;
/*!40000 ALTER TABLE `survey_surveyanswer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `survey_surveyform`
--

DROP TABLE IF EXISTS `survey_surveyform`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `survey_surveyform` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `name` varchar(255) NOT NULL,
  `form` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `survey_surveyform`
--

LOCK TABLES `survey_surveyform` WRITE;
/*!40000 ALTER TABLE `survey_surveyform` DISABLE KEYS */;
/*!40000 ALTER TABLE `survey_surveyform` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_wide_roles_systemwiderole`
--

DROP TABLE IF EXISTS `system_wide_roles_systemwiderole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system_wide_roles_systemwiderole` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_wide_roles_systemwiderole`
--

LOCK TABLES `system_wide_roles_systemwiderole` WRITE;
/*!40000 ALTER TABLE `system_wide_roles_systemwiderole` DISABLE KEYS */;
INSERT INTO `system_wide_roles_systemwiderole` VALUES (1,'2021-03-24 08:07:08.519262','2021-03-24 08:07:08.519262','student_support_admin',NULL);
/*!40000 ALTER TABLE `system_wide_roles_systemwiderole` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_wide_roles_systemwideroleassignment`
--

DROP TABLE IF EXISTS `system_wide_roles_systemwideroleassignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system_wide_roles_systemwideroleassignment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `role_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `applies_to_all_contexts` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `system_wide_roles_sy_role_id_b553068b_fk_system_wi` (`role_id`),
  KEY `system_wide_roles_sy_user_id_8ec7ad0d_fk_auth_user` (`user_id`),
  CONSTRAINT `system_wide_roles_sy_role_id_b553068b_fk_system_wi` FOREIGN KEY (`role_id`) REFERENCES `system_wide_roles_systemwiderole` (`id`),
  CONSTRAINT `system_wide_roles_sy_user_id_8ec7ad0d_fk_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_wide_roles_systemwideroleassignment`
--

LOCK TABLES `system_wide_roles_systemwideroleassignment` WRITE;
/*!40000 ALTER TABLE `system_wide_roles_systemwideroleassignment` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_wide_roles_systemwideroleassignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tagging_tagavailablevalues`
--

DROP TABLE IF EXISTS `tagging_tagavailablevalues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tagging_tagavailablevalues` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` varchar(255) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tagging_tagavailable_category_id_9cc60a44_fk_tagging_t` (`category_id`),
  CONSTRAINT `tagging_tagavailable_category_id_9cc60a44_fk_tagging_t` FOREIGN KEY (`category_id`) REFERENCES `tagging_tagcategories` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tagging_tagavailablevalues`
--

LOCK TABLES `tagging_tagavailablevalues` WRITE;
/*!40000 ALTER TABLE `tagging_tagavailablevalues` DISABLE KEYS */;
/*!40000 ALTER TABLE `tagging_tagavailablevalues` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tagging_tagcategories`
--

DROP TABLE IF EXISTS `tagging_tagcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tagging_tagcategories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tagging_tagcategories`
--

LOCK TABLES `tagging_tagcategories` WRITE;
/*!40000 ALTER TABLE `tagging_tagcategories` DISABLE KEYS */;
/*!40000 ALTER TABLE `tagging_tagcategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teams_courseteam`
--

DROP TABLE IF EXISTS `teams_courseteam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teams_courseteam` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `team_id` varchar(255) NOT NULL,
  `discussion_topic_id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `topic_id` varchar(255) NOT NULL,
  `date_created` datetime(6) NOT NULL,
  `description` varchar(300) NOT NULL,
  `country` varchar(2) NOT NULL,
  `language` varchar(16) NOT NULL,
  `last_activity_at` datetime(6) NOT NULL,
  `team_size` int(11) NOT NULL,
  `organization_protected` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `team_id` (`team_id`),
  UNIQUE KEY `discussion_topic_id` (`discussion_topic_id`),
  KEY `teams_courseteam_name_3bef5f8c` (`name`),
  KEY `teams_courseteam_course_id_1e7dbede` (`course_id`),
  KEY `teams_courseteam_topic_id_4d4f5d0d` (`topic_id`),
  KEY `teams_courseteam_last_activity_at_376db5d3` (`last_activity_at`),
  KEY `teams_courseteam_team_size_d264574e` (`team_size`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teams_courseteam`
--

LOCK TABLES `teams_courseteam` WRITE;
/*!40000 ALTER TABLE `teams_courseteam` DISABLE KEYS */;
/*!40000 ALTER TABLE `teams_courseteam` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teams_courseteammembership`
--

DROP TABLE IF EXISTS `teams_courseteammembership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teams_courseteammembership` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_joined` datetime(6) NOT NULL,
  `last_activity_at` datetime(6) NOT NULL,
  `team_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `teams_courseteammembership_user_id_team_id_aa45a20c_uniq` (`user_id`,`team_id`),
  KEY `teams_courseteammemb_team_id_b021eccd_fk_teams_cou` (`team_id`),
  CONSTRAINT `teams_courseteammemb_team_id_b021eccd_fk_teams_cou` FOREIGN KEY (`team_id`) REFERENCES `teams_courseteam` (`id`),
  CONSTRAINT `teams_courseteammembership_user_id_18f9ff5d_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teams_courseteammembership`
--

LOCK TABLES `teams_courseteammembership` WRITE;
/*!40000 ALTER TABLE `teams_courseteammembership` DISABLE KEYS */;
/*!40000 ALTER TABLE `teams_courseteammembership` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `theming_sitetheme`
--

DROP TABLE IF EXISTS `theming_sitetheme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `theming_sitetheme` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `theme_dir_name` varchar(255) NOT NULL,
  `site_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `theming_sitetheme_site_id_fe93d039_fk_django_site_id` (`site_id`),
  CONSTRAINT `theming_sitetheme_site_id_fe93d039_fk_django_site_id` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `theming_sitetheme`
--

LOCK TABLES `theming_sitetheme` WRITE;
/*!40000 ALTER TABLE `theming_sitetheme` DISABLE KEYS */;
/*!40000 ALTER TABLE `theming_sitetheme` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `third_party_auth_ltiproviderconfig`
--

DROP TABLE IF EXISTS `third_party_auth_ltiproviderconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `third_party_auth_ltiproviderconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `name` varchar(50) NOT NULL,
  `skip_registration_form` tinyint(1) NOT NULL,
  `skip_email_verification` tinyint(1) NOT NULL,
  `lti_consumer_key` varchar(255) NOT NULL,
  `lti_hostname` varchar(255) NOT NULL,
  `lti_consumer_secret` varchar(255) NOT NULL,
  `lti_max_timestamp_age` int(11) NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  `visible` tinyint(1) NOT NULL,
  `site_id` int(11) NOT NULL,
  `max_session_length` int(10) unsigned DEFAULT NULL,
  `skip_hinted_login_dialog` tinyint(1) NOT NULL,
  `send_to_registration_first` tinyint(1) NOT NULL,
  `sync_learner_profile_data` tinyint(1) NOT NULL,
  `send_welcome_email` tinyint(1) NOT NULL,
  `slug` varchar(30) NOT NULL,
  `enable_sso_id_verification` tinyint(1) NOT NULL,
  `organization_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `third_party_auth_lti_changed_by_id_7b39c829_fk_auth_user` (`changed_by_id`),
  KEY `third_party_auth_lti_site_id_c8442a80_fk_django_si` (`site_id`),
  KEY `third_party_auth_lti_organization_id_7494c417_fk_organizat` (`organization_id`),
  KEY `third_party_auth_ltiproviderconfig_lti_hostname_540ce676` (`lti_hostname`),
  KEY `third_party_auth_ltiproviderconfig_slug_9cd23a79` (`slug`),
  CONSTRAINT `third_party_auth_lti_changed_by_id_7b39c829_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `third_party_auth_lti_organization_id_7494c417_fk_organizat` FOREIGN KEY (`organization_id`) REFERENCES `organizations_organization` (`id`),
  CONSTRAINT `third_party_auth_lti_site_id_c8442a80_fk_django_si` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `third_party_auth_ltiproviderconfig`
--

LOCK TABLES `third_party_auth_ltiproviderconfig` WRITE;
/*!40000 ALTER TABLE `third_party_auth_ltiproviderconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `third_party_auth_ltiproviderconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `third_party_auth_oauth2providerconfig`
--

DROP TABLE IF EXISTS `third_party_auth_oauth2providerconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `third_party_auth_oauth2providerconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `icon_class` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `secondary` tinyint(1) NOT NULL,
  `skip_registration_form` tinyint(1) NOT NULL,
  `skip_email_verification` tinyint(1) NOT NULL,
  `backend_name` varchar(50) NOT NULL,
  `key` longtext NOT NULL,
  `secret` longtext NOT NULL,
  `other_settings` longtext NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  `icon_image` varchar(100) NOT NULL,
  `visible` tinyint(1) NOT NULL,
  `site_id` int(11) NOT NULL,
  `max_session_length` int(10) unsigned DEFAULT NULL,
  `skip_hinted_login_dialog` tinyint(1) NOT NULL,
  `send_to_registration_first` tinyint(1) NOT NULL,
  `sync_learner_profile_data` tinyint(1) NOT NULL,
  `send_welcome_email` tinyint(1) NOT NULL,
  `slug` varchar(30) NOT NULL,
  `enable_sso_id_verification` tinyint(1) NOT NULL,
  `organization_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `third_party_auth_oau_changed_by_id_55219296_fk_auth_user` (`changed_by_id`),
  KEY `third_party_auth_oau_site_id_a4ae3e66_fk_django_si` (`site_id`),
  KEY `third_party_auth_oau_organization_id_cc8874ba_fk_organizat` (`organization_id`),
  KEY `third_party_auth_oauth2providerconfig_backend_name_0c14d294` (`backend_name`),
  KEY `third_party_auth_oauth2providerconfig_slug_226038d8` (`slug`),
  CONSTRAINT `third_party_auth_oau_changed_by_id_55219296_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `third_party_auth_oau_organization_id_cc8874ba_fk_organizat` FOREIGN KEY (`organization_id`) REFERENCES `organizations_organization` (`id`),
  CONSTRAINT `third_party_auth_oau_site_id_a4ae3e66_fk_django_si` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `third_party_auth_oauth2providerconfig`
--

LOCK TABLES `third_party_auth_oauth2providerconfig` WRITE;
/*!40000 ALTER TABLE `third_party_auth_oauth2providerconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `third_party_auth_oauth2providerconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `third_party_auth_samlconfiguration`
--

DROP TABLE IF EXISTS `third_party_auth_samlconfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `third_party_auth_samlconfiguration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `private_key` longtext NOT NULL,
  `public_key` longtext NOT NULL,
  `entity_id` varchar(255) NOT NULL,
  `org_info_str` longtext NOT NULL,
  `other_config_str` longtext NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  `site_id` int(11) NOT NULL,
  `slug` varchar(30) NOT NULL,
  `is_public` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `third_party_auth_sam_changed_by_id_c9343fb9_fk_auth_user` (`changed_by_id`),
  KEY `third_party_auth_sam_site_id_8fab01ee_fk_django_si` (`site_id`),
  KEY `third_party_auth_samlconfiguration_slug_f9008e26` (`slug`),
  CONSTRAINT `third_party_auth_sam_changed_by_id_c9343fb9_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `third_party_auth_sam_site_id_8fab01ee_fk_django_si` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `third_party_auth_samlconfiguration`
--

LOCK TABLES `third_party_auth_samlconfiguration` WRITE;
/*!40000 ALTER TABLE `third_party_auth_samlconfiguration` DISABLE KEYS */;
/*!40000 ALTER TABLE `third_party_auth_samlconfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `third_party_auth_samlproviderconfig`
--

DROP TABLE IF EXISTS `third_party_auth_samlproviderconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `third_party_auth_samlproviderconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `icon_class` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `secondary` tinyint(1) NOT NULL,
  `skip_registration_form` tinyint(1) NOT NULL,
  `skip_email_verification` tinyint(1) NOT NULL,
  `backend_name` varchar(50) NOT NULL,
  `entity_id` varchar(255) NOT NULL,
  `metadata_source` varchar(255) NOT NULL,
  `attr_user_permanent_id` varchar(128) NOT NULL,
  `attr_full_name` varchar(128) NOT NULL,
  `attr_first_name` varchar(128) NOT NULL,
  `attr_last_name` varchar(128) NOT NULL,
  `attr_username` varchar(128) NOT NULL,
  `attr_email` varchar(128) NOT NULL,
  `other_settings` longtext NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  `icon_image` varchar(100) NOT NULL,
  `debug_mode` tinyint(1) NOT NULL,
  `visible` tinyint(1) NOT NULL,
  `site_id` int(11) NOT NULL,
  `automatic_refresh_enabled` tinyint(1) NOT NULL,
  `identity_provider_type` varchar(128) NOT NULL,
  `max_session_length` int(10) unsigned DEFAULT NULL,
  `skip_hinted_login_dialog` tinyint(1) NOT NULL,
  `send_to_registration_first` tinyint(1) NOT NULL,
  `sync_learner_profile_data` tinyint(1) NOT NULL,
  `archived` tinyint(1) NOT NULL,
  `saml_configuration_id` int(11) DEFAULT NULL,
  `send_welcome_email` tinyint(1) NOT NULL,
  `slug` varchar(30) NOT NULL,
  `enable_sso_id_verification` tinyint(1) NOT NULL,
  `default_email` varchar(255) NOT NULL,
  `default_first_name` varchar(255) NOT NULL,
  `default_full_name` varchar(255) NOT NULL,
  `default_last_name` varchar(255) NOT NULL,
  `default_username` varchar(255) NOT NULL,
  `organization_id` int(11) DEFAULT NULL,
  `country` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `third_party_auth_sam_changed_by_id_4c8fa8c0_fk_auth_user` (`changed_by_id`),
  KEY `third_party_auth_sam_site_id_b7e2af73_fk_django_si` (`site_id`),
  KEY `third_party_auth_sam_saml_configuration_i_eeb9fe72_fk_third_par` (`saml_configuration_id`),
  KEY `third_party_auth_sam_organization_id_8a7f5596_fk_organizat` (`organization_id`),
  KEY `third_party_auth_samlproviderconfig_slug_95883dea` (`slug`),
  CONSTRAINT `third_party_auth_sam_changed_by_id_4c8fa8c0_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `third_party_auth_sam_organization_id_8a7f5596_fk_organizat` FOREIGN KEY (`organization_id`) REFERENCES `organizations_organization` (`id`),
  CONSTRAINT `third_party_auth_sam_saml_configuration_i_eeb9fe72_fk_third_par` FOREIGN KEY (`saml_configuration_id`) REFERENCES `third_party_auth_samlconfiguration` (`id`),
  CONSTRAINT `third_party_auth_sam_site_id_b7e2af73_fk_django_si` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `third_party_auth_samlproviderconfig`
--

LOCK TABLES `third_party_auth_samlproviderconfig` WRITE;
/*!40000 ALTER TABLE `third_party_auth_samlproviderconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `third_party_auth_samlproviderconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `third_party_auth_samlproviderdata`
--

DROP TABLE IF EXISTS `third_party_auth_samlproviderdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `third_party_auth_samlproviderdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fetched_at` datetime(6) NOT NULL,
  `expires_at` datetime(6) DEFAULT NULL,
  `entity_id` varchar(255) NOT NULL,
  `sso_url` varchar(200) NOT NULL,
  `public_key` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `third_party_auth_samlproviderdata_fetched_at_2286ac32` (`fetched_at`),
  KEY `third_party_auth_samlproviderdata_expires_at_eaf594c7` (`expires_at`),
  KEY `third_party_auth_samlproviderdata_entity_id_b163c6fc` (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `third_party_auth_samlproviderdata`
--

LOCK TABLES `third_party_auth_samlproviderdata` WRITE;
/*!40000 ALTER TABLE `third_party_auth_samlproviderdata` DISABLE KEYS */;
/*!40000 ALTER TABLE `third_party_auth_samlproviderdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thumbnail_kvstore`
--

DROP TABLE IF EXISTS `thumbnail_kvstore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `thumbnail_kvstore` (
  `key` varchar(200) NOT NULL,
  `value` longtext NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thumbnail_kvstore`
--

LOCK TABLES `thumbnail_kvstore` WRITE;
/*!40000 ALTER TABLE `thumbnail_kvstore` DISABLE KEYS */;
/*!40000 ALTER TABLE `thumbnail_kvstore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_api_retirementstate`
--

DROP TABLE IF EXISTS `user_api_retirementstate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_api_retirementstate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `state_name` varchar(30) NOT NULL,
  `state_execution_order` smallint(6) NOT NULL,
  `is_dead_end_state` tinyint(1) NOT NULL,
  `required` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `state_name` (`state_name`),
  UNIQUE KEY `state_execution_order` (`state_execution_order`),
  KEY `user_api_retirementstate_is_dead_end_state_62eaf9b7` (`is_dead_end_state`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_api_retirementstate`
--

LOCK TABLES `user_api_retirementstate` WRITE;
/*!40000 ALTER TABLE `user_api_retirementstate` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_api_retirementstate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_api_usercoursetag`
--

DROP TABLE IF EXISTS `user_api_usercoursetag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_api_usercoursetag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `value` longtext NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_api_usercoursetag_user_id_course_id_key_d73150ab_uniq` (`user_id`,`course_id`,`key`),
  KEY `user_api_usercoursetag_key_d6420575` (`key`),
  KEY `user_api_usercoursetag_course_id_a336d583` (`course_id`),
  CONSTRAINT `user_api_usercoursetag_user_id_106a4cbc_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_api_usercoursetag`
--

LOCK TABLES `user_api_usercoursetag` WRITE;
/*!40000 ALTER TABLE `user_api_usercoursetag` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_api_usercoursetag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_api_userorgtag`
--

DROP TABLE IF EXISTS `user_api_userorgtag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_api_userorgtag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `key` varchar(255) NOT NULL,
  `org` varchar(255) NOT NULL,
  `value` longtext NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_api_userorgtag_user_id_org_key_d4df9ac1_uniq` (`user_id`,`org`,`key`),
  KEY `user_api_userorgtag_key_b1f2bafe` (`key`),
  KEY `user_api_userorgtag_org_41caa15c` (`org`),
  CONSTRAINT `user_api_userorgtag_user_id_cc0d415d_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_api_userorgtag`
--

LOCK TABLES `user_api_userorgtag` WRITE;
/*!40000 ALTER TABLE `user_api_userorgtag` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_api_userorgtag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_api_userpreference`
--

DROP TABLE IF EXISTS `user_api_userpreference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_api_userpreference` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `value` longtext NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_api_userpreference_user_id_key_17924c0d_uniq` (`user_id`,`key`),
  KEY `user_api_userpreference_key_9c8a8f6b` (`key`),
  CONSTRAINT `user_api_userpreference_user_id_68f8a34b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_api_userpreference`
--

LOCK TABLES `user_api_userpreference` WRITE;
/*!40000 ALTER TABLE `user_api_userpreference` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_api_userpreference` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_api_userretirementpartnerreportingstatus`
--

DROP TABLE IF EXISTS `user_api_userretirementpartnerreportingstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_api_userretirementpartnerreportingstatus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `original_username` varchar(150) NOT NULL,
  `original_email` varchar(254) NOT NULL,
  `original_name` varchar(255) NOT NULL,
  `is_being_processed` tinyint(1) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `user_api_userretirementpart_original_username_6bf5d3d1` (`original_username`),
  KEY `user_api_userretirementpart_original_email_aaab0bc9` (`original_email`),
  KEY `user_api_userretirementpart_original_name_9aedd7f0` (`original_name`),
  CONSTRAINT `user_api_userretirem_user_id_272c8f78_fk_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_api_userretirementpartnerreportingstatus`
--

LOCK TABLES `user_api_userretirementpartnerreportingstatus` WRITE;
/*!40000 ALTER TABLE `user_api_userretirementpartnerreportingstatus` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_api_userretirementpartnerreportingstatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_api_userretirementrequest`
--

DROP TABLE IF EXISTS `user_api_userretirementrequest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_api_userretirementrequest` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `user_api_userretirementrequest_user_id_7f7ca22f_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_api_userretirementrequest`
--

LOCK TABLES `user_api_userretirementrequest` WRITE;
/*!40000 ALTER TABLE `user_api_userretirementrequest` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_api_userretirementrequest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_api_userretirementstatus`
--

DROP TABLE IF EXISTS `user_api_userretirementstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_api_userretirementstatus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `original_username` varchar(150) NOT NULL,
  `original_email` varchar(254) NOT NULL,
  `original_name` varchar(255) NOT NULL,
  `retired_username` varchar(150) NOT NULL,
  `retired_email` varchar(254) NOT NULL,
  `responses` longtext NOT NULL,
  `current_state_id` int(11) NOT NULL,
  `last_state_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `user_api_userretirem_current_state_id_e37bb094_fk_user_api_` (`current_state_id`),
  KEY `user_api_userretirem_last_state_id_359e74cd_fk_user_api_` (`last_state_id`),
  KEY `user_api_userretirementstatus_original_username_fa5d4a21` (`original_username`),
  KEY `user_api_userretirementstatus_original_email_a7203bff` (`original_email`),
  KEY `user_api_userretirementstatus_original_name_17c2846b` (`original_name`),
  KEY `user_api_userretirementstatus_retired_username_52067a53` (`retired_username`),
  KEY `user_api_userretirementstatus_retired_email_ee7c1579` (`retired_email`),
  CONSTRAINT `user_api_userretirem_current_state_id_e37bb094_fk_user_api_` FOREIGN KEY (`current_state_id`) REFERENCES `user_api_retirementstate` (`id`),
  CONSTRAINT `user_api_userretirem_last_state_id_359e74cd_fk_user_api_` FOREIGN KEY (`last_state_id`) REFERENCES `user_api_retirementstate` (`id`),
  CONSTRAINT `user_api_userretirementstatus_user_id_aca4dc7b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_api_userretirementstatus`
--

LOCK TABLES `user_api_userretirementstatus` WRITE;
/*!40000 ALTER TABLE `user_api_userretirementstatus` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_api_userretirementstatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_tasks_usertaskartifact`
--

DROP TABLE IF EXISTS `user_tasks_usertaskartifact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_tasks_usertaskartifact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `uuid` char(32) NOT NULL,
  `name` varchar(255) NOT NULL,
  `file` varchar(100) DEFAULT NULL,
  `url` longtext NOT NULL,
  `text` longtext NOT NULL,
  `status_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `user_tasks_usertaska_status_id_641f31be_fk_user_task` (`status_id`),
  CONSTRAINT `user_tasks_usertaska_status_id_641f31be_fk_user_task` FOREIGN KEY (`status_id`) REFERENCES `user_tasks_usertaskstatus` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_tasks_usertaskartifact`
--

LOCK TABLES `user_tasks_usertaskartifact` WRITE;
/*!40000 ALTER TABLE `user_tasks_usertaskartifact` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_tasks_usertaskartifact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_tasks_usertaskstatus`
--

DROP TABLE IF EXISTS `user_tasks_usertaskstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_tasks_usertaskstatus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `uuid` char(32) NOT NULL,
  `task_id` varchar(128) NOT NULL,
  `is_container` tinyint(1) NOT NULL,
  `task_class` varchar(128) NOT NULL,
  `name` varchar(255) NOT NULL,
  `state` varchar(128) NOT NULL,
  `completed_steps` smallint(5) unsigned NOT NULL,
  `total_steps` smallint(5) unsigned NOT NULL,
  `attempts` smallint(5) unsigned NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `task_id` (`task_id`),
  KEY `user_tasks_usertasks_parent_id_5009f727_fk_user_task` (`parent_id`),
  KEY `user_tasks_usertaskstatus_user_id_5bec3d4a_fk_auth_user_id` (`user_id`),
  CONSTRAINT `user_tasks_usertasks_parent_id_5009f727_fk_user_task` FOREIGN KEY (`parent_id`) REFERENCES `user_tasks_usertaskstatus` (`id`),
  CONSTRAINT `user_tasks_usertaskstatus_user_id_5bec3d4a_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_tasks_usertaskstatus`
--

LOCK TABLES `user_tasks_usertaskstatus` WRITE;
/*!40000 ALTER TABLE `user_tasks_usertaskstatus` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_tasks_usertaskstatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `util_ratelimitconfiguration`
--

DROP TABLE IF EXISTS `util_ratelimitconfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `util_ratelimitconfiguration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `util_ratelimitconfig_changed_by_id_794ac118_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `util_ratelimitconfig_changed_by_id_794ac118_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `util_ratelimitconfiguration`
--

LOCK TABLES `util_ratelimitconfiguration` WRITE;
/*!40000 ALTER TABLE `util_ratelimitconfiguration` DISABLE KEYS */;
INSERT INTO `util_ratelimitconfiguration` VALUES (1,'2021-03-24 08:07:16.543058',1,NULL);
/*!40000 ALTER TABLE `util_ratelimitconfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `verified_track_content_migrateverifiedtrackcohortssetting`
--

DROP TABLE IF EXISTS `verified_track_content_migrateverifiedtrackcohortssetting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `verified_track_content_migrateverifiedtrackcohortssetting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `old_course_key` varchar(255) NOT NULL,
  `rerun_course_key` varchar(255) NOT NULL,
  `audit_cohort_names` longtext NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `verified_track_conte_changed_by_id_29944bff_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `verified_track_conte_changed_by_id_29944bff_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `verified_track_content_migrateverifiedtrackcohortssetting`
--

LOCK TABLES `verified_track_content_migrateverifiedtrackcohortssetting` WRITE;
/*!40000 ALTER TABLE `verified_track_content_migrateverifiedtrackcohortssetting` DISABLE KEYS */;
/*!40000 ALTER TABLE `verified_track_content_migrateverifiedtrackcohortssetting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `verified_track_content_verifiedtrackcohortedcourse`
--

DROP TABLE IF EXISTS `verified_track_content_verifiedtrackcohortedcourse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `verified_track_content_verifiedtrackcohortedcourse` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_key` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `verified_cohort_name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `course_key` (`course_key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `verified_track_content_verifiedtrackcohortedcourse`
--

LOCK TABLES `verified_track_content_verifiedtrackcohortedcourse` WRITE;
/*!40000 ALTER TABLE `verified_track_content_verifiedtrackcohortedcourse` DISABLE KEYS */;
/*!40000 ALTER TABLE `verified_track_content_verifiedtrackcohortedcourse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `verify_student_manualverification`
--

DROP TABLE IF EXISTS `verify_student_manualverification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `verify_student_manualverification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(100) NOT NULL,
  `status_changed` datetime(6) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `expiration_date` datetime(6),
  PRIMARY KEY (`id`),
  KEY `verify_student_manua_user_id_f38b72b4_fk_auth_user` (`user_id`),
  KEY `verify_student_manualverification_created_at_e4e3731a` (`created_at`),
  KEY `verify_student_manualverification_updated_at_1a350690` (`updated_at`),
  KEY `verify_student_manualverification_expiration_date_d2feae82` (`expiration_date`),
  CONSTRAINT `verify_student_manua_user_id_f38b72b4_fk_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `verify_student_manualverification`
--

LOCK TABLES `verify_student_manualverification` WRITE;
/*!40000 ALTER TABLE `verify_student_manualverification` DISABLE KEYS */;
/*!40000 ALTER TABLE `verify_student_manualverification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `verify_student_softwaresecurephotoverification`
--

DROP TABLE IF EXISTS `verify_student_softwaresecurephotoverification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `verify_student_softwaresecurephotoverification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(100) NOT NULL,
  `status_changed` datetime(6) NOT NULL,
  `name` varchar(255) NOT NULL,
  `face_image_url` varchar(255) NOT NULL,
  `photo_id_image_url` varchar(255) NOT NULL,
  `receipt_id` varchar(255) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `display` tinyint(1) NOT NULL,
  `submitted_at` datetime(6) DEFAULT NULL,
  `reviewing_service` varchar(255) NOT NULL,
  `error_msg` longtext NOT NULL,
  `error_code` varchar(50) NOT NULL,
  `photo_id_key` longtext NOT NULL,
  `copy_id_photo_from_id` int(11) DEFAULT NULL,
  `reviewing_user_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `expiry_date` datetime(6) DEFAULT NULL,
  `expiry_email_date` datetime(6) DEFAULT NULL,
  `expiration_date` datetime(6),
  PRIMARY KEY (`id`),
  KEY `verify_student_softw_copy_id_photo_from_i_059e40b6_fk_verify_st` (`copy_id_photo_from_id`),
  KEY `verify_student_softw_reviewing_user_id_55fd003a_fk_auth_user` (`reviewing_user_id`),
  KEY `verify_student_softw_user_id_66ca4f6d_fk_auth_user` (`user_id`),
  KEY `verify_student_softwaresecu_receipt_id_2160ce88` (`receipt_id`),
  KEY `verify_student_softwaresecu_created_at_566f779f` (`created_at`),
  KEY `verify_student_softwaresecu_updated_at_8f5cf2d7` (`updated_at`),
  KEY `verify_student_softwaresecurephotoverification_display_287287f8` (`display`),
  KEY `verify_student_softwaresecu_submitted_at_f3d5cd03` (`submitted_at`),
  KEY `verify_student_softwaresecu_expiry_date_5c297927` (`expiry_date`),
  KEY `verify_student_softwaresecu_expiry_email_date_6ae6d6c9` (`expiry_email_date`),
  KEY `verify_student_softwaresecu_expiration_date_f7f2d890` (`expiration_date`),
  CONSTRAINT `verify_student_softw_copy_id_photo_from_i_059e40b6_fk_verify_st` FOREIGN KEY (`copy_id_photo_from_id`) REFERENCES `verify_student_softwaresecurephotoverification` (`id`),
  CONSTRAINT `verify_student_softw_reviewing_user_id_55fd003a_fk_auth_user` FOREIGN KEY (`reviewing_user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `verify_student_softw_user_id_66ca4f6d_fk_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `verify_student_softwaresecurephotoverification`
--

LOCK TABLES `verify_student_softwaresecurephotoverification` WRITE;
/*!40000 ALTER TABLE `verify_student_softwaresecurephotoverification` DISABLE KEYS */;
/*!40000 ALTER TABLE `verify_student_softwaresecurephotoverification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `verify_student_ssoverification`
--

DROP TABLE IF EXISTS `verify_student_ssoverification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `verify_student_ssoverification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(100) NOT NULL,
  `status_changed` datetime(6) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `identity_provider_type` varchar(100) NOT NULL,
  `identity_provider_slug` varchar(30) NOT NULL,
  `user_id` int(11) NOT NULL,
  `expiration_date` datetime(6),
  PRIMARY KEY (`id`),
  KEY `verify_student_ssoverification_user_id_5e6186eb_fk_auth_user_id` (`user_id`),
  KEY `verify_student_ssoverification_created_at_6381e5a4` (`created_at`),
  KEY `verify_student_ssoverification_updated_at_9d6cc952` (`updated_at`),
  KEY `verify_student_ssoverification_identity_provider_slug_56c53eb6` (`identity_provider_slug`),
  KEY `verify_student_ssoverification_expiration_date_26ec549d` (`expiration_date`),
  CONSTRAINT `verify_student_ssoverification_user_id_5e6186eb_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `verify_student_ssoverification`
--

LOCK TABLES `verify_student_ssoverification` WRITE;
/*!40000 ALTER TABLE `verify_student_ssoverification` DISABLE KEYS */;
/*!40000 ALTER TABLE `verify_student_ssoverification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `verify_student_sspverificationretryconfig`
--

DROP TABLE IF EXISTS `verify_student_sspverificationretryconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `verify_student_sspverificationretryconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `arguments` longtext NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `verify_student_sspve_changed_by_id_c035fbe5_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `verify_student_sspve_changed_by_id_c035fbe5_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `verify_student_sspverificationretryconfig`
--

LOCK TABLES `verify_student_sspverificationretryconfig` WRITE;
/*!40000 ALTER TABLE `verify_student_sspverificationretryconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `verify_student_sspverificationretryconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `verify_student_verificationdeadline`
--

DROP TABLE IF EXISTS `verify_student_verificationdeadline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `verify_student_verificationdeadline` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `course_key` varchar(255) NOT NULL,
  `deadline` datetime(6) NOT NULL,
  `deadline_is_explicit` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `course_key` (`course_key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `verify_student_verificationdeadline`
--

LOCK TABLES `verify_student_verificationdeadline` WRITE;
/*!40000 ALTER TABLE `verify_student_verificationdeadline` DISABLE KEYS */;
/*!40000 ALTER TABLE `verify_student_verificationdeadline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `video_config_coursehlsplaybackenabledflag`
--

DROP TABLE IF EXISTS `video_config_coursehlsplaybackenabledflag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `video_config_coursehlsplaybackenabledflag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `video_config_courseh_changed_by_id_fa268d53_fk_auth_user` (`changed_by_id`),
  KEY `video_config_coursehlsplaybackenabledflag_course_id_c0fcaead` (`course_id`),
  CONSTRAINT `video_config_courseh_changed_by_id_fa268d53_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `video_config_coursehlsplaybackenabledflag`
--

LOCK TABLES `video_config_coursehlsplaybackenabledflag` WRITE;
/*!40000 ALTER TABLE `video_config_coursehlsplaybackenabledflag` DISABLE KEYS */;
/*!40000 ALTER TABLE `video_config_coursehlsplaybackenabledflag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `video_config_coursevideotranscriptenabledflag`
--

DROP TABLE IF EXISTS `video_config_coursevideotranscriptenabledflag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `video_config_coursevideotranscriptenabledflag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `video_config_coursev_changed_by_id_3bdcf2a6_fk_auth_user` (`changed_by_id`),
  KEY `video_config_coursevideotranscriptenabledflag_course_id_fcfacf5b` (`course_id`),
  CONSTRAINT `video_config_coursev_changed_by_id_3bdcf2a6_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `video_config_coursevideotranscriptenabledflag`
--

LOCK TABLES `video_config_coursevideotranscriptenabledflag` WRITE;
/*!40000 ALTER TABLE `video_config_coursevideotranscriptenabledflag` DISABLE KEYS */;
/*!40000 ALTER TABLE `video_config_coursevideotranscriptenabledflag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `video_config_courseyoutubeblockedflag`
--

DROP TABLE IF EXISTS `video_config_courseyoutubeblockedflag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `video_config_courseyoutubeblockedflag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `video_config_coursey_changed_by_id_3496713f_fk_auth_user` (`changed_by_id`),
  KEY `video_config_courseyoutubeblockedflag_course_id_4c9395c6` (`course_id`),
  CONSTRAINT `video_config_coursey_changed_by_id_3496713f_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `video_config_courseyoutubeblockedflag`
--

LOCK TABLES `video_config_courseyoutubeblockedflag` WRITE;
/*!40000 ALTER TABLE `video_config_courseyoutubeblockedflag` DISABLE KEYS */;
/*!40000 ALTER TABLE `video_config_courseyoutubeblockedflag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `video_config_hlsplaybackenabledflag`
--

DROP TABLE IF EXISTS `video_config_hlsplaybackenabledflag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `video_config_hlsplaybackenabledflag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `enabled_for_all_courses` tinyint(1) NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `video_config_hlsplay_changed_by_id_d93f2234_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `video_config_hlsplay_changed_by_id_d93f2234_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `video_config_hlsplaybackenabledflag`
--

LOCK TABLES `video_config_hlsplaybackenabledflag` WRITE;
/*!40000 ALTER TABLE `video_config_hlsplaybackenabledflag` DISABLE KEYS */;
/*!40000 ALTER TABLE `video_config_hlsplaybackenabledflag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `video_config_migrationenqueuedcourse`
--

DROP TABLE IF EXISTS `video_config_migrationenqueuedcourse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `video_config_migrationenqueuedcourse` (
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `command_run` int(10) unsigned NOT NULL,
  PRIMARY KEY (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `video_config_migrationenqueuedcourse`
--

LOCK TABLES `video_config_migrationenqueuedcourse` WRITE;
/*!40000 ALTER TABLE `video_config_migrationenqueuedcourse` DISABLE KEYS */;
/*!40000 ALTER TABLE `video_config_migrationenqueuedcourse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `video_config_transcriptmigrationsetting`
--

DROP TABLE IF EXISTS `video_config_transcriptmigrationsetting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `video_config_transcriptmigrationsetting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `force_update` tinyint(1) NOT NULL,
  `commit` tinyint(1) NOT NULL,
  `all_courses` tinyint(1) NOT NULL,
  `course_ids` longtext NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  `command_run` int(10) unsigned NOT NULL,
  `batch_size` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `video_config_transcr_changed_by_id_4c7817bd_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `video_config_transcr_changed_by_id_4c7817bd_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `video_config_transcriptmigrationsetting`
--

LOCK TABLES `video_config_transcriptmigrationsetting` WRITE;
/*!40000 ALTER TABLE `video_config_transcriptmigrationsetting` DISABLE KEYS */;
/*!40000 ALTER TABLE `video_config_transcriptmigrationsetting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `video_config_updatedcoursevideos`
--

DROP TABLE IF EXISTS `video_config_updatedcoursevideos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `video_config_updatedcoursevideos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `edx_video_id` varchar(100) NOT NULL,
  `command_run` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `video_config_updatedcour_course_id_edx_video_id_455a73ff_uniq` (`course_id`,`edx_video_id`),
  KEY `video_config_updatedcoursevideos_course_id_e72703a3` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `video_config_updatedcoursevideos`
--

LOCK TABLES `video_config_updatedcoursevideos` WRITE;
/*!40000 ALTER TABLE `video_config_updatedcoursevideos` DISABLE KEYS */;
/*!40000 ALTER TABLE `video_config_updatedcoursevideos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `video_config_videothumbnailsetting`
--

DROP TABLE IF EXISTS `video_config_videothumbnailsetting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `video_config_videothumbnailsetting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `command_run` int(10) unsigned NOT NULL,
  `batch_size` int(10) unsigned NOT NULL,
  `videos_per_task` int(10) unsigned NOT NULL,
  `commit` tinyint(1) NOT NULL,
  `all_course_videos` tinyint(1) NOT NULL,
  `course_ids` longtext NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  `offset` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `video_config_videoth_changed_by_id_9385a0b2_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `video_config_videoth_changed_by_id_9385a0b2_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `video_config_videothumbnailsetting`
--

LOCK TABLES `video_config_videothumbnailsetting` WRITE;
/*!40000 ALTER TABLE `video_config_videothumbnailsetting` DISABLE KEYS */;
/*!40000 ALTER TABLE `video_config_videothumbnailsetting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `video_config_videotranscriptenabledflag`
--

DROP TABLE IF EXISTS `video_config_videotranscriptenabledflag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `video_config_videotranscriptenabledflag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `enabled_for_all_courses` tinyint(1) NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `video_config_videotr_changed_by_id_9f0afd7f_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `video_config_videotr_changed_by_id_9f0afd7f_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `video_config_videotranscriptenabledflag`
--

LOCK TABLES `video_config_videotranscriptenabledflag` WRITE;
/*!40000 ALTER TABLE `video_config_videotranscriptenabledflag` DISABLE KEYS */;
/*!40000 ALTER TABLE `video_config_videotranscriptenabledflag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `video_pipeline_coursevideouploadsenabledbydefault`
--

DROP TABLE IF EXISTS `video_pipeline_coursevideouploadsenabledbydefault`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `video_pipeline_coursevideouploadsenabledbydefault` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `video_pipeline_cours_changed_by_id_84ec1a58_fk_auth_user` (`changed_by_id`),
  KEY `video_pipeline_coursevideou_course_id_9fd1b18b` (`course_id`),
  CONSTRAINT `video_pipeline_cours_changed_by_id_84ec1a58_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `video_pipeline_coursevideouploadsenabledbydefault`
--

LOCK TABLES `video_pipeline_coursevideouploadsenabledbydefault` WRITE;
/*!40000 ALTER TABLE `video_pipeline_coursevideouploadsenabledbydefault` DISABLE KEYS */;
/*!40000 ALTER TABLE `video_pipeline_coursevideouploadsenabledbydefault` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `video_pipeline_vempipelineintegration`
--

DROP TABLE IF EXISTS `video_pipeline_vempipelineintegration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `video_pipeline_vempipelineintegration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `client_name` varchar(100) NOT NULL,
  `api_url` varchar(200) NOT NULL,
  `service_username` varchar(100) NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `video_pipeline_vempi_changed_by_id_cadc1895_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `video_pipeline_vempi_changed_by_id_cadc1895_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `video_pipeline_vempipelineintegration`
--

LOCK TABLES `video_pipeline_vempipelineintegration` WRITE;
/*!40000 ALTER TABLE `video_pipeline_vempipelineintegration` DISABLE KEYS */;
/*!40000 ALTER TABLE `video_pipeline_vempipelineintegration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `video_pipeline_videouploadsenabledbydefault`
--

DROP TABLE IF EXISTS `video_pipeline_videouploadsenabledbydefault`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `video_pipeline_videouploadsenabledbydefault` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `enabled_for_all_courses` tinyint(1) NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `video_pipeline_video_changed_by_id_3d066822_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `video_pipeline_video_changed_by_id_3d066822_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `video_pipeline_videouploadsenabledbydefault`
--

LOCK TABLES `video_pipeline_videouploadsenabledbydefault` WRITE;
/*!40000 ALTER TABLE `video_pipeline_videouploadsenabledbydefault` DISABLE KEYS */;
/*!40000 ALTER TABLE `video_pipeline_videouploadsenabledbydefault` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waffle_flag`
--

DROP TABLE IF EXISTS `waffle_flag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waffle_flag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `everyone` tinyint(1) DEFAULT NULL,
  `percent` decimal(3,1) DEFAULT NULL,
  `testing` tinyint(1) NOT NULL,
  `superusers` tinyint(1) NOT NULL,
  `staff` tinyint(1) NOT NULL,
  `authenticated` tinyint(1) NOT NULL,
  `languages` longtext NOT NULL,
  `rollout` tinyint(1) NOT NULL,
  `note` longtext NOT NULL,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `waffle_flag_created_4a6e8cef` (`created`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waffle_flag`
--

LOCK TABLES `waffle_flag` WRITE;
/*!40000 ALTER TABLE `waffle_flag` DISABLE KEYS */;
INSERT INTO `waffle_flag` VALUES (2,'grades.rejected_exam_overrides_grade',1,NULL,0,1,0,0,'',0,'','2021-03-24 08:06:33.339181','2021-03-24 08:06:33.339192'),(3,'grades.enforce_freeze_grade_after_course_end',1,NULL,0,1,0,0,'',0,'','2021-03-24 08:06:33.341566','2021-03-24 08:06:33.341573'),(4,'grades.writable_gradebook',1,NULL,0,1,0,0,'',0,'','2021-03-24 08:06:33.344015','2021-03-24 08:06:33.344022'),(5,'studio.enable_checklists_quality',1,NULL,0,1,0,0,'',0,'','2021-03-24 08:09:48.102102','2021-03-24 08:09:48.102111');
/*!40000 ALTER TABLE `waffle_flag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waffle_flag_groups`
--

DROP TABLE IF EXISTS `waffle_flag_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waffle_flag_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `flag_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `waffle_flag_groups_flag_id_group_id_8ba0c71b_uniq` (`flag_id`,`group_id`),
  KEY `waffle_flag_groups_group_id_a97c4f66_fk_auth_group_id` (`group_id`),
  CONSTRAINT `waffle_flag_groups_flag_id_c11c0c05_fk_waffle_flag_id` FOREIGN KEY (`flag_id`) REFERENCES `waffle_flag` (`id`),
  CONSTRAINT `waffle_flag_groups_group_id_a97c4f66_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waffle_flag_groups`
--

LOCK TABLES `waffle_flag_groups` WRITE;
/*!40000 ALTER TABLE `waffle_flag_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `waffle_flag_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waffle_flag_users`
--

DROP TABLE IF EXISTS `waffle_flag_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waffle_flag_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `flag_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `waffle_flag_users_flag_id_user_id_b46f76b0_uniq` (`flag_id`,`user_id`),
  KEY `waffle_flag_users_user_id_8026df9b_fk_auth_user_id` (`user_id`),
  CONSTRAINT `waffle_flag_users_flag_id_833c37b0_fk_waffle_flag_id` FOREIGN KEY (`flag_id`) REFERENCES `waffle_flag` (`id`),
  CONSTRAINT `waffle_flag_users_user_id_8026df9b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waffle_flag_users`
--

LOCK TABLES `waffle_flag_users` WRITE;
/*!40000 ALTER TABLE `waffle_flag_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `waffle_flag_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waffle_sample`
--

DROP TABLE IF EXISTS `waffle_sample`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waffle_sample` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `percent` decimal(4,1) NOT NULL,
  `note` longtext NOT NULL,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `waffle_sample_created_76198bd5` (`created`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waffle_sample`
--

LOCK TABLES `waffle_sample` WRITE;
/*!40000 ALTER TABLE `waffle_sample` DISABLE KEYS */;
/*!40000 ALTER TABLE `waffle_sample` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waffle_switch`
--

DROP TABLE IF EXISTS `waffle_switch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waffle_switch` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `note` longtext NOT NULL,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `waffle_switch_created_c004e77e` (`created`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waffle_switch`
--

LOCK TABLES `waffle_switch` WRITE;
/*!40000 ALTER TABLE `waffle_switch` DISABLE KEYS */;
/*!40000 ALTER TABLE `waffle_switch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waffle_utils_waffleflagcourseoverridemodel`
--

DROP TABLE IF EXISTS `waffle_utils_waffleflagcourseoverridemodel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waffle_utils_waffleflagcourseoverridemodel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `waffle_flag` varchar(255) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `override_choice` varchar(3) NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `waffle_utils_wafflef_changed_by_id_28429bf5_fk_auth_user` (`changed_by_id`),
  KEY `waffle_utils_waffleflagcourseoverridemodel_waffle_flag_d261aad1` (`waffle_flag`),
  KEY `waffle_utils_waffleflagcourseoverridemodel_course_id_e94a9fc3` (`course_id`),
  CONSTRAINT `waffle_utils_wafflef_changed_by_id_28429bf5_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waffle_utils_waffleflagcourseoverridemodel`
--

LOCK TABLES `waffle_utils_waffleflagcourseoverridemodel` WRITE;
/*!40000 ALTER TABLE `waffle_utils_waffleflagcourseoverridemodel` DISABLE KEYS */;
/*!40000 ALTER TABLE `waffle_utils_waffleflagcourseoverridemodel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wiki_article`
--

DROP TABLE IF EXISTS `wiki_article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wiki_article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `group_read` tinyint(1) NOT NULL,
  `group_write` tinyint(1) NOT NULL,
  `other_read` tinyint(1) NOT NULL,
  `other_write` tinyint(1) NOT NULL,
  `current_revision_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `owner_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `current_revision_id` (`current_revision_id`),
  KEY `wiki_article_group_id_bf035c83_fk_auth_group_id` (`group_id`),
  KEY `wiki_article_owner_id_956bc94a_fk_auth_user_id` (`owner_id`),
  CONSTRAINT `wiki_article_current_revision_id_fc83ea0a_fk_wiki_arti` FOREIGN KEY (`current_revision_id`) REFERENCES `wiki_articlerevision` (`id`),
  CONSTRAINT `wiki_article_group_id_bf035c83_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `wiki_article_owner_id_956bc94a_fk_auth_user_id` FOREIGN KEY (`owner_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wiki_article`
--

LOCK TABLES `wiki_article` WRITE;
/*!40000 ALTER TABLE `wiki_article` DISABLE KEYS */;
/*!40000 ALTER TABLE `wiki_article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wiki_articleforobject`
--

DROP TABLE IF EXISTS `wiki_articleforobject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wiki_articleforobject` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `object_id` int(10) unsigned NOT NULL,
  `is_mptt` tinyint(1) NOT NULL,
  `article_id` int(11) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `wiki_articleforobject_content_type_id_object_id_046be756_uniq` (`content_type_id`,`object_id`),
  KEY `wiki_articleforobject_article_id_7d67d809_fk_wiki_article_id` (`article_id`),
  CONSTRAINT `wiki_articleforobjec_content_type_id_ba569059_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `wiki_articleforobject_article_id_7d67d809_fk_wiki_article_id` FOREIGN KEY (`article_id`) REFERENCES `wiki_article` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wiki_articleforobject`
--

LOCK TABLES `wiki_articleforobject` WRITE;
/*!40000 ALTER TABLE `wiki_articleforobject` DISABLE KEYS */;
/*!40000 ALTER TABLE `wiki_articleforobject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wiki_articleplugin`
--

DROP TABLE IF EXISTS `wiki_articleplugin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wiki_articleplugin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) NOT NULL,
  `created` datetime(6) NOT NULL,
  `article_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `wiki_articleplugin_article_id_9ab0e854_fk_wiki_article_id` (`article_id`),
  CONSTRAINT `wiki_articleplugin_article_id_9ab0e854_fk_wiki_article_id` FOREIGN KEY (`article_id`) REFERENCES `wiki_article` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wiki_articleplugin`
--

LOCK TABLES `wiki_articleplugin` WRITE;
/*!40000 ALTER TABLE `wiki_articleplugin` DISABLE KEYS */;
/*!40000 ALTER TABLE `wiki_articleplugin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wiki_articlerevision`
--

DROP TABLE IF EXISTS `wiki_articlerevision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wiki_articlerevision` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `revision_number` int(11) NOT NULL,
  `user_message` longtext NOT NULL,
  `automatic_log` longtext NOT NULL,
  `ip_address` char(39) DEFAULT NULL,
  `modified` datetime(6) NOT NULL,
  `created` datetime(6) NOT NULL,
  `deleted` tinyint(1) NOT NULL,
  `locked` tinyint(1) NOT NULL,
  `content` longtext NOT NULL,
  `title` varchar(512) NOT NULL,
  `article_id` int(11) NOT NULL,
  `previous_revision_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `wiki_articlerevision_article_id_revision_number_5bcd5334_uniq` (`article_id`,`revision_number`),
  KEY `wiki_articlerevision_previous_revision_id_bcfaf4c9_fk_wiki_arti` (`previous_revision_id`),
  KEY `wiki_articlerevision_user_id_c687e4de_fk_auth_user_id` (`user_id`),
  CONSTRAINT `wiki_articlerevision_article_id_e0fb2474_fk_wiki_article_id` FOREIGN KEY (`article_id`) REFERENCES `wiki_article` (`id`),
  CONSTRAINT `wiki_articlerevision_previous_revision_id_bcfaf4c9_fk_wiki_arti` FOREIGN KEY (`previous_revision_id`) REFERENCES `wiki_articlerevision` (`id`),
  CONSTRAINT `wiki_articlerevision_user_id_c687e4de_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wiki_articlerevision`
--

LOCK TABLES `wiki_articlerevision` WRITE;
/*!40000 ALTER TABLE `wiki_articlerevision` DISABLE KEYS */;
/*!40000 ALTER TABLE `wiki_articlerevision` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wiki_reusableplugin`
--

DROP TABLE IF EXISTS `wiki_reusableplugin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wiki_reusableplugin` (
  `articleplugin_ptr_id` int(11) NOT NULL,
  PRIMARY KEY (`articleplugin_ptr_id`),
  CONSTRAINT `wiki_reusableplugin_articleplugin_ptr_id_c1737239_fk_wiki_arti` FOREIGN KEY (`articleplugin_ptr_id`) REFERENCES `wiki_articleplugin` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wiki_reusableplugin`
--

LOCK TABLES `wiki_reusableplugin` WRITE;
/*!40000 ALTER TABLE `wiki_reusableplugin` DISABLE KEYS */;
/*!40000 ALTER TABLE `wiki_reusableplugin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wiki_reusableplugin_articles`
--

DROP TABLE IF EXISTS `wiki_reusableplugin_articles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wiki_reusableplugin_articles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reusableplugin_id` int(11) NOT NULL,
  `article_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `wiki_reusableplugin_arti_reusableplugin_id_articl_302a7a01_uniq` (`reusableplugin_id`,`article_id`),
  KEY `wiki_reusableplugin__article_id_8a09d39e_fk_wiki_arti` (`article_id`),
  CONSTRAINT `wiki_reusableplugin__article_id_8a09d39e_fk_wiki_arti` FOREIGN KEY (`article_id`) REFERENCES `wiki_article` (`id`),
  CONSTRAINT `wiki_reusableplugin__reusableplugin_id_52618a1c_fk_wiki_reus` FOREIGN KEY (`reusableplugin_id`) REFERENCES `wiki_reusableplugin` (`articleplugin_ptr_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wiki_reusableplugin_articles`
--

LOCK TABLES `wiki_reusableplugin_articles` WRITE;
/*!40000 ALTER TABLE `wiki_reusableplugin_articles` DISABLE KEYS */;
/*!40000 ALTER TABLE `wiki_reusableplugin_articles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wiki_revisionplugin`
--

DROP TABLE IF EXISTS `wiki_revisionplugin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wiki_revisionplugin` (
  `articleplugin_ptr_id` int(11) NOT NULL,
  `current_revision_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`articleplugin_ptr_id`),
  UNIQUE KEY `current_revision_id` (`current_revision_id`),
  CONSTRAINT `wiki_revisionplugin_articleplugin_ptr_id_95c295f2_fk_wiki_arti` FOREIGN KEY (`articleplugin_ptr_id`) REFERENCES `wiki_articleplugin` (`id`),
  CONSTRAINT `wiki_revisionplugin_current_revision_id_46514536_fk_wiki_revi` FOREIGN KEY (`current_revision_id`) REFERENCES `wiki_revisionpluginrevision` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wiki_revisionplugin`
--

LOCK TABLES `wiki_revisionplugin` WRITE;
/*!40000 ALTER TABLE `wiki_revisionplugin` DISABLE KEYS */;
/*!40000 ALTER TABLE `wiki_revisionplugin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wiki_revisionpluginrevision`
--

DROP TABLE IF EXISTS `wiki_revisionpluginrevision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wiki_revisionpluginrevision` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `revision_number` int(11) NOT NULL,
  `user_message` longtext NOT NULL,
  `automatic_log` longtext NOT NULL,
  `ip_address` char(39) DEFAULT NULL,
  `modified` datetime(6) NOT NULL,
  `created` datetime(6) NOT NULL,
  `deleted` tinyint(1) NOT NULL,
  `locked` tinyint(1) NOT NULL,
  `plugin_id` int(11) NOT NULL,
  `previous_revision_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `wiki_revisionpluginr_plugin_id_c8f4475b_fk_wiki_revi` (`plugin_id`),
  KEY `wiki_revisionpluginr_previous_revision_id_38c877c0_fk_wiki_revi` (`previous_revision_id`),
  KEY `wiki_revisionpluginrevision_user_id_ee40f729_fk_auth_user_id` (`user_id`),
  CONSTRAINT `wiki_revisionpluginr_plugin_id_c8f4475b_fk_wiki_revi` FOREIGN KEY (`plugin_id`) REFERENCES `wiki_revisionplugin` (`articleplugin_ptr_id`),
  CONSTRAINT `wiki_revisionpluginr_previous_revision_id_38c877c0_fk_wiki_revi` FOREIGN KEY (`previous_revision_id`) REFERENCES `wiki_revisionpluginrevision` (`id`),
  CONSTRAINT `wiki_revisionpluginrevision_user_id_ee40f729_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wiki_revisionpluginrevision`
--

LOCK TABLES `wiki_revisionpluginrevision` WRITE;
/*!40000 ALTER TABLE `wiki_revisionpluginrevision` DISABLE KEYS */;
/*!40000 ALTER TABLE `wiki_revisionpluginrevision` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wiki_simpleplugin`
--

DROP TABLE IF EXISTS `wiki_simpleplugin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wiki_simpleplugin` (
  `articleplugin_ptr_id` int(11) NOT NULL,
  `article_revision_id` int(11) NOT NULL,
  PRIMARY KEY (`articleplugin_ptr_id`),
  KEY `wiki_simpleplugin_article_revision_id_cff7df92_fk_wiki_arti` (`article_revision_id`),
  CONSTRAINT `wiki_simpleplugin_article_revision_id_cff7df92_fk_wiki_arti` FOREIGN KEY (`article_revision_id`) REFERENCES `wiki_articlerevision` (`id`),
  CONSTRAINT `wiki_simpleplugin_articleplugin_ptr_id_2b99b828_fk_wiki_arti` FOREIGN KEY (`articleplugin_ptr_id`) REFERENCES `wiki_articleplugin` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wiki_simpleplugin`
--

LOCK TABLES `wiki_simpleplugin` WRITE;
/*!40000 ALTER TABLE `wiki_simpleplugin` DISABLE KEYS */;
/*!40000 ALTER TABLE `wiki_simpleplugin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wiki_urlpath`
--

DROP TABLE IF EXISTS `wiki_urlpath`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wiki_urlpath` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `slug` varchar(255) DEFAULT NULL,
  `lft` int(10) unsigned NOT NULL,
  `rght` int(10) unsigned NOT NULL,
  `tree_id` int(10) unsigned NOT NULL,
  `level` int(10) unsigned NOT NULL,
  `article_id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `site_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `wiki_urlpath_site_id_parent_id_slug_e4942e5d_uniq` (`site_id`,`parent_id`,`slug`),
  KEY `wiki_urlpath_article_id_9ef0c0fb_fk_wiki_article_id` (`article_id`),
  KEY `wiki_urlpath_slug_39d212eb` (`slug`),
  KEY `wiki_urlpath_tree_id_090b475d` (`tree_id`),
  KEY `wiki_urlpath_parent_id_a6e675ac` (`parent_id`),
  CONSTRAINT `wiki_urlpath_article_id_9ef0c0fb_fk_wiki_article_id` FOREIGN KEY (`article_id`) REFERENCES `wiki_article` (`id`),
  CONSTRAINT `wiki_urlpath_parent_id_a6e675ac_fk_wiki_urlpath_id` FOREIGN KEY (`parent_id`) REFERENCES `wiki_urlpath` (`id`),
  CONSTRAINT `wiki_urlpath_site_id_319be912_fk_django_site_id` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wiki_urlpath`
--

LOCK TABLES `wiki_urlpath` WRITE;
/*!40000 ALTER TABLE `wiki_urlpath` DISABLE KEYS */;
/*!40000 ALTER TABLE `wiki_urlpath` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workflow_assessmentworkflow`
--

DROP TABLE IF EXISTS `workflow_assessmentworkflow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workflow_assessmentworkflow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `status` varchar(100) NOT NULL,
  `status_changed` datetime(6) NOT NULL,
  `submission_uuid` varchar(36) NOT NULL,
  `uuid` char(32) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `item_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `submission_uuid` (`submission_uuid`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `workflow_assessmentworkflow_course_id_8c2d171b` (`course_id`),
  KEY `workflow_assessmentworkflow_item_id_3ad0d291` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workflow_assessmentworkflow`
--

LOCK TABLES `workflow_assessmentworkflow` WRITE;
/*!40000 ALTER TABLE `workflow_assessmentworkflow` DISABLE KEYS */;
/*!40000 ALTER TABLE `workflow_assessmentworkflow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workflow_assessmentworkflowcancellation`
--

DROP TABLE IF EXISTS `workflow_assessmentworkflowcancellation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workflow_assessmentworkflowcancellation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comments` longtext NOT NULL,
  `cancelled_by_id` varchar(40) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `workflow_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `workflow_assessmentw_workflow_id_5e534711_fk_workflow_` (`workflow_id`),
  KEY `workflow_assessmentworkflowcancellation_cancelled_by_id_8467736a` (`cancelled_by_id`),
  KEY `workflow_assessmentworkflowcancellation_created_at_9da54d83` (`created_at`),
  CONSTRAINT `workflow_assessmentw_workflow_id_5e534711_fk_workflow_` FOREIGN KEY (`workflow_id`) REFERENCES `workflow_assessmentworkflow` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workflow_assessmentworkflowcancellation`
--

LOCK TABLES `workflow_assessmentworkflowcancellation` WRITE;
/*!40000 ALTER TABLE `workflow_assessmentworkflowcancellation` DISABLE KEYS */;
/*!40000 ALTER TABLE `workflow_assessmentworkflowcancellation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workflow_assessmentworkflowstep`
--

DROP TABLE IF EXISTS `workflow_assessmentworkflowstep`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workflow_assessmentworkflowstep` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `submitter_completed_at` datetime(6) DEFAULT NULL,
  `assessment_completed_at` datetime(6) DEFAULT NULL,
  `order_num` int(10) unsigned NOT NULL,
  `workflow_id` int(11) NOT NULL,
  `skipped` tinyint(1),
  PRIMARY KEY (`id`),
  KEY `workflow_assessmentw_workflow_id_fe52b4aa_fk_workflow_` (`workflow_id`),
  CONSTRAINT `workflow_assessmentw_workflow_id_fe52b4aa_fk_workflow_` FOREIGN KEY (`workflow_id`) REFERENCES `workflow_assessmentworkflow` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workflow_assessmentworkflowstep`
--

LOCK TABLES `workflow_assessmentworkflowstep` WRITE;
/*!40000 ALTER TABLE `workflow_assessmentworkflowstep` DISABLE KEYS */;
/*!40000 ALTER TABLE `workflow_assessmentworkflowstep` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workflow_teamassessmentworkflow`
--

DROP TABLE IF EXISTS `workflow_teamassessmentworkflow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workflow_teamassessmentworkflow` (
  `assessmentworkflow_ptr_id` int(11) NOT NULL,
  `team_submission_uuid` varchar(128) NOT NULL,
  PRIMARY KEY (`assessmentworkflow_ptr_id`),
  UNIQUE KEY `team_submission_uuid` (`team_submission_uuid`),
  CONSTRAINT `workflow_teamassessm_assessmentworkflow_p_53110fc3_fk_workflow_` FOREIGN KEY (`assessmentworkflow_ptr_id`) REFERENCES `workflow_assessmentworkflow` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workflow_teamassessmentworkflow`
--

LOCK TABLES `workflow_teamassessmentworkflow` WRITE;
/*!40000 ALTER TABLE `workflow_teamassessmentworkflow` DISABLE KEYS */;
/*!40000 ALTER TABLE `workflow_teamassessmentworkflow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xapi_xapilearnerdatatransmissionaudit`
--

DROP TABLE IF EXISTS `xapi_xapilearnerdatatransmissionaudit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xapi_xapilearnerdatatransmissionaudit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `enterprise_course_enrollment_id` int(10) unsigned DEFAULT NULL,
  `course_id` varchar(255) NOT NULL,
  `course_completed` tinyint(1) NOT NULL,
  `completed_timestamp` datetime(6) DEFAULT NULL,
  `grade` varchar(255) DEFAULT NULL,
  `status` varchar(100) NOT NULL,
  `error_message` longtext,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `xapi_xapilearnerdatatran_user_id_course_id_557488b4_uniq` (`user_id`,`course_id`),
  KEY `xapi_xapilearnerdatatransmi_enterprise_course_enrollmen_0a180d75` (`enterprise_course_enrollment_id`),
  KEY `xapi_xapilearnerdatatransmissionaudit_course_id_c18248d2` (`course_id`),
  CONSTRAINT `xapi_xapilearnerdata_user_id_6a49eb25_fk_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xapi_xapilearnerdatatransmissionaudit`
--

LOCK TABLES `xapi_xapilearnerdatatransmissionaudit` WRITE;
/*!40000 ALTER TABLE `xapi_xapilearnerdatatransmissionaudit` DISABLE KEYS */;
/*!40000 ALTER TABLE `xapi_xapilearnerdatatransmissionaudit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xapi_xapilrsconfiguration`
--

DROP TABLE IF EXISTS `xapi_xapilrsconfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xapi_xapilrsconfiguration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `version` varchar(16) NOT NULL,
  `endpoint` varchar(200) NOT NULL,
  `key` varchar(255) NOT NULL,
  `secret` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `enterprise_customer_id` char(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `enterprise_customer_id` (`enterprise_customer_id`),
  CONSTRAINT `xapi_xapilrsconfigur_enterprise_customer__90c03ad5_fk_enterpris` FOREIGN KEY (`enterprise_customer_id`) REFERENCES `enterprise_enterprisecustomer` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xapi_xapilrsconfiguration`
--

LOCK TABLES `xapi_xapilrsconfiguration` WRITE;
/*!40000 ALTER TABLE `xapi_xapilrsconfiguration` DISABLE KEYS */;
/*!40000 ALTER TABLE `xapi_xapilrsconfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xblock_config_courseeditltifieldsenabledflag`
--

DROP TABLE IF EXISTS `xblock_config_courseeditltifieldsenabledflag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xblock_config_courseeditltifieldsenabledflag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `course_id` varchar(255) NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `xblock_config_course_changed_by_id_09761e15_fk_auth_user` (`changed_by_id`),
  KEY `xblock_config_courseeditltifieldsenabledflag_course_id_4f2393b4` (`course_id`),
  CONSTRAINT `xblock_config_course_changed_by_id_09761e15_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xblock_config_courseeditltifieldsenabledflag`
--

LOCK TABLES `xblock_config_courseeditltifieldsenabledflag` WRITE;
/*!40000 ALTER TABLE `xblock_config_courseeditltifieldsenabledflag` DISABLE KEYS */;
/*!40000 ALTER TABLE `xblock_config_courseeditltifieldsenabledflag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xblock_config_studioconfig`
--

DROP TABLE IF EXISTS `xblock_config_studioconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xblock_config_studioconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `disabled_blocks` longtext NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `xblock_config_studio_changed_by_id_8e87ad07_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `xblock_config_studio_changed_by_id_8e87ad07_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xblock_config_studioconfig`
--

LOCK TABLES `xblock_config_studioconfig` WRITE;
/*!40000 ALTER TABLE `xblock_config_studioconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `xblock_config_studioconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xblock_django_xblockconfiguration`
--

DROP TABLE IF EXISTS `xblock_django_xblockconfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xblock_django_xblockconfiguration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `deprecated` tinyint(1) NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `xblock_django_xblock_changed_by_id_221b9d0e_fk_auth_user` (`changed_by_id`),
  KEY `xblock_django_xblockconfiguration_name_9596c362` (`name`),
  CONSTRAINT `xblock_django_xblock_changed_by_id_221b9d0e_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xblock_django_xblockconfiguration`
--

LOCK TABLES `xblock_django_xblockconfiguration` WRITE;
/*!40000 ALTER TABLE `xblock_django_xblockconfiguration` DISABLE KEYS */;
/*!40000 ALTER TABLE `xblock_django_xblockconfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xblock_django_xblockstudioconfiguration`
--

DROP TABLE IF EXISTS `xblock_django_xblockstudioconfiguration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xblock_django_xblockstudioconfiguration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `template` varchar(255) NOT NULL,
  `support_level` varchar(2) NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `xblock_django_xblock_changed_by_id_641b0905_fk_auth_user` (`changed_by_id`),
  KEY `xblock_django_xblockstudioconfiguration_name_1450bfa3` (`name`),
  CONSTRAINT `xblock_django_xblock_changed_by_id_641b0905_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xblock_django_xblockstudioconfiguration`
--

LOCK TABLES `xblock_django_xblockstudioconfiguration` WRITE;
/*!40000 ALTER TABLE `xblock_django_xblockstudioconfiguration` DISABLE KEYS */;
/*!40000 ALTER TABLE `xblock_django_xblockstudioconfiguration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xblock_django_xblockstudioconfigurationflag`
--

DROP TABLE IF EXISTS `xblock_django_xblockstudioconfigurationflag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xblock_django_xblockstudioconfigurationflag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `change_date` datetime(6) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `xblock_django_xblock_changed_by_id_fdf047b8_fk_auth_user` (`changed_by_id`),
  CONSTRAINT `xblock_django_xblock_changed_by_id_fdf047b8_fk_auth_user` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xblock_django_xblockstudioconfigurationflag`
--

LOCK TABLES `xblock_django_xblockstudioconfigurationflag` WRITE;
/*!40000 ALTER TABLE `xblock_django_xblockstudioconfigurationflag` DISABLE KEYS */;
/*!40000 ALTER TABLE `xblock_django_xblockstudioconfigurationflag` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed
