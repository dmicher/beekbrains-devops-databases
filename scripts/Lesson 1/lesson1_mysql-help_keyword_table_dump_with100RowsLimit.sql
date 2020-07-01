-- MySQL dump 10.13  Distrib 8.0.20, for Win64 (x86_64)
--
-- Host: localhost    Database: mysql
-- ------------------------------------------------------
-- Server version	8.0.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `help_keyword`
--

DROP TABLE IF EXISTS `help_keyword`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `help_keyword` (
  `help_keyword_id` int unsigned NOT NULL,
  `name` char(64) NOT NULL,
  PRIMARY KEY (`help_keyword_id`),
  UNIQUE KEY `name` (`name`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='help keywords';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `help_keyword`
--
-- WHERE:  true limit 100

LOCK TABLES `help_keyword` WRITE;
/*!40000 ALTER TABLE `help_keyword` DISABLE KEYS */;
INSERT INTO `help_keyword` VALUES (225,'(JSON'),(226,'->'),(228,'->>'),(46,'<>'),(630,'ACCOUNT'),(422,'ACTION'),(40,'ADD'),(655,'ADMIN'),(108,'AES_DECRYPT'),(109,'AES_ENCRYPT'),(341,'AFTER'),(95,'AGAINST'),(677,'AGGREGATE'),(342,'ALGORITHM'),(489,'ALL'),(41,'ALTER'),(343,'ANALYZE'),(47,'AND'),(311,'ANY_VALUE'),(423,'ARCHIVE'),(102,'ARRAY'),(490,'AS'),(259,'ASC'),(404,'AT'),(514,'AUTOCOMMIT'),(447,'AUTOEXTEND_SIZE'),(344,'AUTO_INCREMENT'),(345,'AVG_ROW_LENGTH'),(528,'BACKUP'),(542,'BEFORE'),(515,'BEGIN'),(48,'BETWEEN'),(59,'BIGINT'),(104,'BINARY'),(706,'BINLOG'),(312,'BIN_TO_UUID'),(8,'BOOL'),(9,'BOOLEAN'),(85,'BOTH'),(408,'BTREE'),(260,'BY'),(33,'BYTE'),(714,'CACHE'),(455,'CALL'),(283,'CAN_ACCESS_COLUMN'),(284,'CAN_ACCESS_DATABASE'),(285,'CAN_ACCESS_TABLE'),(286,'CAN_ACCESS_VIEW'),(424,'CASCADE'),(53,'CASE'),(610,'CATALOG_NAME'),(62,'CEIL'),(63,'CEILING'),(516,'CHAIN'),(346,'CHANGE'),(548,'CHANNEL'),(34,'CHAR'),(30,'CHARACTER'),(689,'CHARSET'),(347,'CHECK'),(348,'CHECKSUM'),(631,'CIPHER'),(611,'CLASS_ORIGIN'),(656,'CLIENT'),(685,'CLONE'),(461,'CLOSE'),(349,'COALESCE'),(709,'CODE'),(316,'COLLATE'),(691,'COLLATION'),(350,'COLUMN'),(351,'COLUMNS'),(612,'COLUMN_NAME'),(321,'COMMENT'),(517,'COMMIT'),(531,'COMMITTED'),(425,'COMPACT'),(322,'COMPLETION'),(681,'COMPONENT'),(426,'COMPRESSED'),(352,'COMPRESSION'),(476,'CONCURRENT'),(607,'CONDITION'),(353,'CONNECTION'),(518,'CONSISTENT'),(354,'CONSTRAINT'),(613,'CONSTRAINT_CATALOG'),(614,'CONSTRAINT_NAME'),(615,'CONSTRAINT_SCHEMA'),(608,'CONTINUE'),(103,'CONVERT'),(258,'COUNT'),(42,'CREATE'),(256,'CREATE_DH_PARAMETERS'),(507,'CROSS'),(427,'CSV'),(268,'CUME_DIST'),(632,'CURRENT'),(116,'CURRENT_ROLE'),(323,'CURRENT_USER');
/*!40000 ALTER TABLE `help_keyword` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-07-01 15:15:17
