-- MySQL dump 10.13  Distrib 5.6.14, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: student_module_history_test
-- ------------------------------------------------------
-- Server version	5.6.14-1+debphp.org~precise+1

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
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2016-02-11 21:37:52.298915'),(2,'auth','0001_initial','2016-02-11 21:37:52.352361'),(3,'admin','0001_initial','2016-02-11 21:37:52.377323'),(4,'assessment','0001_initial','2016-02-11 21:37:53.131359'),(5,'assessment','0002_staffworkflow','2016-02-11 21:37:53.142911'),(6,'contenttypes','0002_remove_content_type_name','2016-02-11 21:37:53.223025'),(7,'auth','0002_alter_permission_name_max_length','2016-02-11 21:37:53.248006'),(8,'auth','0003_alter_user_email_max_length','2016-02-11 21:37:53.275274'),(9,'auth','0004_alter_user_username_opts','2016-02-11 21:37:53.300246'),(10,'auth','0005_alter_user_last_login_null','2016-02-11 21:37:53.329248'),(11,'auth','0006_require_contenttypes_0002','2016-02-11 21:37:53.332266'),(12,'bookmarks','0001_initial','2016-02-11 21:37:53.432100'),(13,'branding','0001_initial','2016-02-11 21:37:53.501875'),(14,'bulk_email','0001_initial','2016-02-11 21:37:53.646577'),(15,'bulk_email','0002_data__load_course_email_template','2016-02-11 21:37:53.656953'),(16,'instructor_task','0001_initial','2016-02-11 21:37:53.708601'),(17,'certificates','0001_initial','2016-02-11 21:37:54.202629'),(18,'certificates','0002_data__certificatehtmlviewconfiguration_data','2016-02-11 21:37:54.212658'),(19,'certificates','0003_data__default_modes','2016-02-11 21:37:54.224874'),(20,'certificates','0004_certificategenerationhistory','2016-02-11 21:37:54.294115'),(21,'certificates','0005_auto_20151208_0801','2016-02-11 21:37:54.363359'),(22,'certificates','0006_certificatetemplateasset_asset_slug','2016-02-11 21:37:54.377813'),(23,'certificates','0007_certificateinvalidation','2016-02-11 21:37:54.457766'),(24,'commerce','0001_data__add_ecommerce_service_user','2016-02-11 21:37:54.471143'),(25,'contentserver','0001_initial','2016-02-11 21:37:54.542976'),(26,'cors_csrf','0001_initial','2016-02-11 21:37:54.620492'),(27,'course_action_state','0001_initial','2016-02-11 21:37:54.787318'),(28,'course_groups','0001_initial','2016-02-11 21:37:55.481108'),(29,'course_modes','0001_initial','2016-02-11 21:37:55.520095'),(30,'course_modes','0002_coursemode_expiration_datetime_is_explicit','2016-02-11 21:37:55.538585'),(31,'course_modes','0003_auto_20151113_1443','2016-02-11 21:37:55.558569'),(32,'course_modes','0004_auto_20151113_1457','2016-02-11 21:37:55.667192'),(33,'course_modes','0005_auto_20151217_0958','2016-02-11 21:37:55.688693'),(34,'course_modes','0006_auto_20160208_1407','2016-02-11 21:37:55.791520'),(35,'course_overviews','0001_initial','2016-02-11 21:37:55.831453'),(36,'course_overviews','0002_add_course_catalog_fields','2016-02-11 21:37:55.933935'),(37,'course_overviews','0003_courseoverviewgeneratedhistory','2016-02-11 21:37:55.950920'),(38,'course_overviews','0004_courseoverview_org','2016-02-11 21:37:55.973704'),(39,'course_overviews','0005_delete_courseoverviewgeneratedhistory','2016-02-11 21:37:55.988457'),(40,'course_overviews','0006_courseoverviewimageset','2016-02-11 21:37:56.014973'),(41,'course_overviews','0007_courseoverviewimageconfig','2016-02-11 21:37:56.129234'),(42,'course_structures','0001_initial','2016-02-11 21:37:56.147597'),(43,'courseware','0001_initial','2016-02-11 21:37:58.408469'),(44,'courseware','0002_csmh-extended-keyspace','2016-02-11 21:37:58.606862'),(45,'credentials','0001_initial','2016-02-11 21:37:58.739327'),(46,'credit','0001_initial','2016-02-11 21:37:59.872951'),(47,'dark_lang','0001_initial','2016-02-11 21:38:00.053053'),(48,'dark_lang','0002_data__enable_on_install','2016-02-11 21:38:00.070921'),(49,'default','0001_initial','2016-02-11 21:38:00.525779'),(50,'default','0002_add_related_name','2016-02-11 21:38:00.702333'),(51,'default','0003_alter_email_max_length','2016-02-11 21:38:00.722375'),(52,'django_comment_common','0001_initial','2016-02-11 21:38:01.114988'),(53,'django_notify','0001_initial','2016-02-11 21:38:01.922968'),(54,'django_openid_auth','0001_initial','2016-02-11 21:38:02.170578'),(55,'edx_proctoring','0001_initial','2016-02-11 21:38:06.030017'),(56,'edx_proctoring','0002_proctoredexamstudentattempt_is_status_acknowledged','2016-02-11 21:38:06.241168'),(57,'edx_proctoring','0003_auto_20160101_0525','2016-02-11 21:38:06.696741'),(58,'edx_proctoring','0004_auto_20160201_0523','2016-02-11 21:38:06.940477'),(59,'edxval','0001_initial','2016-02-11 21:38:07.194937'),(60,'edxval','0002_data__default_profiles','2016-02-11 21:38:07.218254'),(61,'embargo','0001_initial','2016-02-11 21:38:08.056333'),(62,'embargo','0002_data__add_countries','2016-02-11 21:38:08.346354'),(63,'external_auth','0001_initial','2016-02-11 21:38:09.008928'),(64,'lms_xblock','0001_initial','2016-02-11 21:38:09.314915'),(65,'sites','0001_initial','2016-02-11 21:38:09.343048'),(66,'microsite_configuration','0001_initial','2016-02-11 21:38:11.137800'),(67,'microsite_configuration','0002_auto_20160202_0228','2016-02-11 21:38:11.972064'),(68,'milestones','0001_initial','2016-02-11 21:38:13.550894'),(69,'milestones','0002_data__seed_relationship_types','2016-02-11 21:38:13.574119'),(70,'milestones','0003_coursecontentmilestone_requirements','2016-02-11 21:38:13.620636'),(71,'milestones','0004_auto_20151221_1445','2016-02-11 21:38:13.798776'),(72,'mobile_api','0001_initial','2016-02-11 21:38:14.103569'),(73,'notes','0001_initial','2016-02-11 21:38:14.420792'),(74,'oauth2','0001_initial','2016-02-11 21:38:16.173446'),(75,'oauth2_provider','0001_initial','2016-02-11 21:38:16.513968'),(76,'oauth_provider','0001_initial','2016-02-11 21:38:17.354962'),(77,'organizations','0001_initial','2016-02-11 21:38:17.487086'),(78,'programs','0001_initial','2016-02-11 21:38:17.996961'),(79,'programs','0002_programsapiconfig_cache_ttl','2016-02-11 21:38:18.430520'),(80,'programs','0003_auto_20151120_1613','2016-02-11 21:38:20.231426'),(81,'programs','0004_programsapiconfig_enable_certification','2016-02-11 21:38:20.695401'),(82,'rss_proxy','0001_initial','2016-02-11 21:38:20.723143'),(83,'self_paced','0001_initial','2016-02-11 21:38:21.159324'),(84,'sessions','0001_initial','2016-02-11 21:38:21.185510'),(85,'student','0001_initial','2016-02-11 21:38:34.873694'),(86,'shoppingcart','0001_initial','2016-02-11 21:38:45.279289'),(87,'shoppingcart','0002_auto_20151208_1034','2016-02-11 21:38:46.155351'),(88,'shoppingcart','0003_auto_20151217_0958','2016-02-11 21:38:47.009825'),(89,'splash','0001_initial','2016-02-11 21:38:47.484507'),(90,'static_replace','0001_initial','2016-02-11 21:38:47.997996'),(91,'static_replace','0002_assetexcludedextensionsconfig','2016-02-11 21:38:48.577441'),(92,'status','0001_initial','2016-02-11 21:38:49.868965'),(93,'student','0002_auto_20151208_1034','2016-02-11 21:38:51.098087'),(94,'submissions','0001_initial','2016-02-11 21:38:51.445403'),(95,'submissions','0002_auto_20151119_0913','2016-02-11 21:38:51.576839'),(96,'survey','0001_initial','2016-02-11 21:38:53.171811'),(97,'teams','0001_initial','2016-02-11 21:38:54.649105'),(98,'third_party_auth','0001_initial','2016-02-11 21:38:57.885856'),(99,'track','0001_initial','2016-02-11 21:38:57.920191'),(100,'user_api','0001_initial','2016-02-11 21:39:02.378720'),(101,'util','0001_initial','2016-02-11 21:39:03.957150'),(102,'util','0002_data__default_rate_limit_config','2016-02-11 21:39:03.991298'),(103,'verify_student','0001_initial','2016-02-11 21:39:11.533155'),(104,'verify_student','0002_auto_20151124_1024','2016-02-11 21:39:12.427221'),(105,'verify_student','0003_auto_20151113_1443','2016-02-11 21:39:13.371245'),(106,'wiki','0001_initial','2016-02-11 21:39:36.194006'),(107,'wiki','0002_remove_article_subscription','2016-02-11 21:39:36.227651'),(108,'workflow','0001_initial','2016-02-11 21:39:36.375866'),(109,'xblock_django','0001_initial','2016-02-11 21:39:37.277775'),(110,'xblock_django','0002_auto_20160204_0809','2016-02-11 21:39:38.191698'),(111,'contentstore','0001_initial','2016-02-11 21:39:58.747862'),(112,'course_creators','0001_initial','2016-02-11 21:39:58.779308'),(113,'xblock_config','0001_initial','2016-02-11 21:39:59.020635');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-02-11 21:40:01
