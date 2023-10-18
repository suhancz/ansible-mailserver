-- MySQL dump 10.19  Distrib 10.3.39-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: horde
-- ------------------------------------------------------
-- Server version	10.3.39-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `content_schema_info`
--

DROP TABLE IF EXISTS `content_schema_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `content_schema_info` (
  `version` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content_schema_info`
--

LOCK TABLES `content_schema_info` WRITE;
/*!40000 ALTER TABLE `content_schema_info` DISABLE KEYS */;
REPLACE INTO `content_schema_info` (`version`) VALUES (2);
/*!40000 ALTER TABLE `content_schema_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_activesync_cache`
--

DROP TABLE IF EXISTS `horde_activesync_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_activesync_cache` (
  `cache_devid` varchar(255) DEFAULT NULL,
  `cache_user` varchar(255) DEFAULT NULL,
  `cache_data` mediumtext DEFAULT NULL,
  KEY `index_horde_activesync_cache_on_cache_devid` (`cache_devid`),
  KEY `index_horde_activesync_cache_on_cache_user` (`cache_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_activesync_cache`
--

LOCK TABLES `horde_activesync_cache` WRITE;
/*!40000 ALTER TABLE `horde_activesync_cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `horde_activesync_cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_activesync_device`
--

DROP TABLE IF EXISTS `horde_activesync_device`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_activesync_device` (
  `device_id` varchar(255) NOT NULL,
  `device_type` varchar(255) NOT NULL,
  `device_agent` varchar(255) NOT NULL,
  `device_supported` text DEFAULT NULL,
  `device_rwstatus` int(11) DEFAULT NULL,
  `device_properties` text DEFAULT NULL,
  PRIMARY KEY (`device_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_activesync_device`
--

LOCK TABLES `horde_activesync_device` WRITE;
/*!40000 ALTER TABLE `horde_activesync_device` DISABLE KEYS */;
/*!40000 ALTER TABLE `horde_activesync_device` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_activesync_device_users`
--

DROP TABLE IF EXISTS `horde_activesync_device_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_activesync_device_users` (
  `device_id` varchar(255) NOT NULL,
  `device_user` varchar(255) NOT NULL,
  `device_policykey` bigint(20) DEFAULT 0,
  KEY `index_horde_activesync_device_users_on_device_user` (`device_user`),
  KEY `index_horde_activesync_device_users_on_device_id` (`device_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_activesync_device_users`
--

LOCK TABLES `horde_activesync_device_users` WRITE;
/*!40000 ALTER TABLE `horde_activesync_device_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `horde_activesync_device_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_activesync_mailmap`
--

DROP TABLE IF EXISTS `horde_activesync_mailmap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_activesync_mailmap` (
  `message_uid` int(11) NOT NULL DEFAULT 0,
  `sync_key` varchar(255) NOT NULL,
  `sync_devid` varchar(255) NOT NULL,
  `sync_folderid` varchar(255) NOT NULL,
  `sync_user` varchar(255) DEFAULT NULL,
  `sync_read` tinyint(1) DEFAULT NULL,
  `sync_deleted` tinyint(1) DEFAULT NULL,
  `sync_flagged` tinyint(1) DEFAULT NULL,
  `sync_changed` tinyint(1) DEFAULT NULL,
  `sync_category` varchar(255) DEFAULT NULL,
  `sync_draft` tinyint(1) DEFAULT NULL,
  KEY `index_horde_activesync_mailmap_on_message_uid` (`message_uid`),
  KEY `index_horde_activesync_mailmap_on_sync_devid` (`sync_devid`),
  KEY `index_horde_activesync_mailmap_on_sync_folderid` (`sync_folderid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_activesync_mailmap`
--

LOCK TABLES `horde_activesync_mailmap` WRITE;
/*!40000 ALTER TABLE `horde_activesync_mailmap` DISABLE KEYS */;
/*!40000 ALTER TABLE `horde_activesync_mailmap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_activesync_map`
--

DROP TABLE IF EXISTS `horde_activesync_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_activesync_map` (
  `message_uid` varchar(255) NOT NULL,
  `sync_modtime` int(11) DEFAULT NULL,
  `sync_key` varchar(255) NOT NULL,
  `sync_devid` varchar(255) NOT NULL,
  `sync_folderid` varchar(255) NOT NULL,
  `sync_user` varchar(255) DEFAULT NULL,
  `sync_clientid` varchar(255) DEFAULT NULL,
  `sync_deleted` tinyint(1) DEFAULT NULL,
  KEY `index_horde_activesync_map_on_sync_devid` (`sync_devid`),
  KEY `index_horde_activesync_map_on_message_uid` (`message_uid`),
  KEY `index_horde_activesync_map_on_sync_user` (`sync_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_activesync_map`
--

LOCK TABLES `horde_activesync_map` WRITE;
/*!40000 ALTER TABLE `horde_activesync_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `horde_activesync_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_activesync_schema_info`
--

DROP TABLE IF EXISTS `horde_activesync_schema_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_activesync_schema_info` (
  `version` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_activesync_schema_info`
--

LOCK TABLES `horde_activesync_schema_info` WRITE;
/*!40000 ALTER TABLE `horde_activesync_schema_info` DISABLE KEYS */;
REPLACE INTO `horde_activesync_schema_info` (`version`) VALUES (23);
/*!40000 ALTER TABLE `horde_activesync_schema_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_activesync_state`
--

DROP TABLE IF EXISTS `horde_activesync_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_activesync_state` (
  `sync_mod` int(11) DEFAULT NULL,
  `sync_key` varchar(255) NOT NULL,
  `sync_data` longblob DEFAULT NULL,
  `sync_devid` varchar(255) DEFAULT NULL,
  `sync_folderid` varchar(255) DEFAULT NULL,
  `sync_user` varchar(255) DEFAULT NULL,
  `sync_pending` mediumtext DEFAULT NULL,
  `sync_timestamp` int(11) DEFAULT NULL,
  PRIMARY KEY (`sync_key`),
  KEY `index_horde_activesync_state_on_sync_folderid` (`sync_folderid`),
  KEY `index_horde_activesync_state_on_sync_devid` (`sync_devid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_activesync_state`
--

LOCK TABLES `horde_activesync_state` WRITE;
/*!40000 ALTER TABLE `horde_activesync_state` DISABLE KEYS */;
/*!40000 ALTER TABLE `horde_activesync_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_alarm_schema_info`
--

DROP TABLE IF EXISTS `horde_alarm_schema_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_alarm_schema_info` (
  `version` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_alarm_schema_info`
--

LOCK TABLES `horde_alarm_schema_info` WRITE;
/*!40000 ALTER TABLE `horde_alarm_schema_info` DISABLE KEYS */;
REPLACE INTO `horde_alarm_schema_info` (`version`) VALUES (2);
/*!40000 ALTER TABLE `horde_alarm_schema_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_alarms`
--

DROP TABLE IF EXISTS `horde_alarms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_alarms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `alarm_id` varchar(255) NOT NULL,
  `alarm_uid` varchar(255) DEFAULT NULL,
  `alarm_start` datetime NOT NULL,
  `alarm_end` datetime DEFAULT NULL,
  `alarm_methods` varchar(255) DEFAULT NULL,
  `alarm_params` text DEFAULT NULL,
  `alarm_title` varchar(255) NOT NULL,
  `alarm_text` text DEFAULT NULL,
  `alarm_snooze` datetime DEFAULT NULL,
  `alarm_dismissed` int(1) NOT NULL DEFAULT 0,
  `alarm_internal` text DEFAULT NULL,
  `alarm_instanceid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_horde_alarms_on_alarm_id` (`alarm_id`),
  KEY `index_horde_alarms_on_alarm_uid` (`alarm_uid`),
  KEY `index_horde_alarms_on_alarm_start` (`alarm_start`),
  KEY `index_horde_alarms_on_alarm_end` (`alarm_end`),
  KEY `index_horde_alarms_on_alarm_snooze` (`alarm_snooze`),
  KEY `index_horde_alarms_on_alarm_dismissed` (`alarm_dismissed`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_alarms`
--

LOCK TABLES `horde_alarms` WRITE;
/*!40000 ALTER TABLE `horde_alarms` DISABLE KEYS */;
/*!40000 ALTER TABLE `horde_alarms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_auth_schema_info`
--

DROP TABLE IF EXISTS `horde_auth_schema_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_auth_schema_info` (
  `version` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_auth_schema_info`
--

LOCK TABLES `horde_auth_schema_info` WRITE;
/*!40000 ALTER TABLE `horde_auth_schema_info` DISABLE KEYS */;
REPLACE INTO `horde_auth_schema_info` (`version`) VALUES (1);
/*!40000 ALTER TABLE `horde_auth_schema_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_cache`
--

DROP TABLE IF EXISTS `horde_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_cache` (
  `cache_id` varchar(32) NOT NULL,
  `cache_timestamp` bigint(20) NOT NULL,
  `cache_expiration` bigint(20) NOT NULL,
  `cache_data` longblob DEFAULT NULL,
  PRIMARY KEY (`cache_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_cache`
--

LOCK TABLES `horde_cache` WRITE;
/*!40000 ALTER TABLE `horde_cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `horde_cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_cache_schema_info`
--

DROP TABLE IF EXISTS `horde_cache_schema_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_cache_schema_info` (
  `version` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_cache_schema_info`
--

LOCK TABLES `horde_cache_schema_info` WRITE;
/*!40000 ALTER TABLE `horde_cache_schema_info` DISABLE KEYS */;
REPLACE INTO `horde_cache_schema_info` (`version`) VALUES (2);
/*!40000 ALTER TABLE `horde_cache_schema_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_core_schema_info`
--

DROP TABLE IF EXISTS `horde_core_schema_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_core_schema_info` (
  `version` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_core_schema_info`
--

LOCK TABLES `horde_core_schema_info` WRITE;
/*!40000 ALTER TABLE `horde_core_schema_info` DISABLE KEYS */;
REPLACE INTO `horde_core_schema_info` (`version`) VALUES (1);
/*!40000 ALTER TABLE `horde_core_schema_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_dav_collections`
--

DROP TABLE IF EXISTS `horde_dav_collections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_dav_collections` (
  `id_interface` varchar(255) NOT NULL,
  `id_internal` varchar(255) NOT NULL,
  `id_external` varchar(255) NOT NULL,
  UNIQUE KEY `index_horde_dav_collections_on_id_external` (`id_external`),
  KEY `index_horde_dav_collections_on_id_interface` (`id_interface`),
  KEY `index_horde_dav_collections_on_id_internal` (`id_internal`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_dav_collections`
--

LOCK TABLES `horde_dav_collections` WRITE;
/*!40000 ALTER TABLE `horde_dav_collections` DISABLE KEYS */;
/*!40000 ALTER TABLE `horde_dav_collections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_dav_objects`
--

DROP TABLE IF EXISTS `horde_dav_objects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_dav_objects` (
  `id_collection` varchar(255) NOT NULL,
  `id_internal` varchar(255) NOT NULL,
  `id_external` varchar(255) NOT NULL,
  UNIQUE KEY `index_horde_dav_objects_on_id_internal` (`id_internal`),
  UNIQUE KEY `index_horde_dav_objects_on_id_external_and_id_collection` (`id_external`,`id_collection`),
  KEY `index_horde_dav_objects_on_id_collection` (`id_collection`),
  KEY `index_horde_dav_objects_on_id_external` (`id_external`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_dav_objects`
--

LOCK TABLES `horde_dav_objects` WRITE;
/*!40000 ALTER TABLE `horde_dav_objects` DISABLE KEYS */;
/*!40000 ALTER TABLE `horde_dav_objects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_dav_schema_info`
--

DROP TABLE IF EXISTS `horde_dav_schema_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_dav_schema_info` (
  `version` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_dav_schema_info`
--

LOCK TABLES `horde_dav_schema_info` WRITE;
/*!40000 ALTER TABLE `horde_dav_schema_info` DISABLE KEYS */;
REPLACE INTO `horde_dav_schema_info` (`version`) VALUES (2);
/*!40000 ALTER TABLE `horde_dav_schema_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_group_schema_info`
--

DROP TABLE IF EXISTS `horde_group_schema_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_group_schema_info` (
  `version` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_group_schema_info`
--

LOCK TABLES `horde_group_schema_info` WRITE;
/*!40000 ALTER TABLE `horde_group_schema_info` DISABLE KEYS */;
REPLACE INTO `horde_group_schema_info` (`version`) VALUES (3);
/*!40000 ALTER TABLE `horde_group_schema_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_groups`
--

DROP TABLE IF EXISTS `horde_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_groups` (
  `group_uid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `group_name` varchar(255) NOT NULL,
  `group_parents` varchar(255) DEFAULT NULL,
  `group_email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`group_uid`),
  UNIQUE KEY `index_horde_groups_on_group_name` (`group_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_groups`
--

LOCK TABLES `horde_groups` WRITE;
/*!40000 ALTER TABLE `horde_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `horde_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_groups_members`
--

DROP TABLE IF EXISTS `horde_groups_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_groups_members` (
  `group_uid` int(10) unsigned NOT NULL,
  `user_uid` varchar(255) NOT NULL,
  KEY `index_horde_groups_members_on_group_uid` (`group_uid`),
  KEY `index_horde_groups_members_on_user_uid` (`user_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_groups_members`
--

LOCK TABLES `horde_groups_members` WRITE;
/*!40000 ALTER TABLE `horde_groups_members` DISABLE KEYS */;
/*!40000 ALTER TABLE `horde_groups_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_histories`
--

DROP TABLE IF EXISTS `horde_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_histories` (
  `history_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `object_uid` varchar(255) NOT NULL,
  `history_action` varchar(32) NOT NULL,
  `history_ts` bigint(20) NOT NULL,
  `history_desc` text DEFAULT NULL,
  `history_who` varchar(255) DEFAULT NULL,
  `history_extra` text DEFAULT NULL,
  `history_modseq` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`history_id`),
  KEY `index_horde_histories_on_history_action` (`history_action`),
  KEY `index_horde_histories_on_history_ts` (`history_ts`),
  KEY `index_horde_histories_on_history_modseq` (`history_modseq`),
  KEY `index_horde_histories_on_object_uid` (`object_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_histories`
--

LOCK TABLES `horde_histories` WRITE;
/*!40000 ALTER TABLE `horde_histories` DISABLE KEYS */;
/*!40000 ALTER TABLE `horde_histories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_histories_modseq`
--

DROP TABLE IF EXISTS `horde_histories_modseq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_histories_modseq` (
  `history_modseq` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `history_modseqempty` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`history_modseq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_histories_modseq`
--

LOCK TABLES `horde_histories_modseq` WRITE;
/*!40000 ALTER TABLE `horde_histories_modseq` DISABLE KEYS */;
/*!40000 ALTER TABLE `horde_histories_modseq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_history_schema_info`
--

DROP TABLE IF EXISTS `horde_history_schema_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_history_schema_info` (
  `version` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_history_schema_info`
--

LOCK TABLES `horde_history_schema_info` WRITE;
/*!40000 ALTER TABLE `horde_history_schema_info` DISABLE KEYS */;
REPLACE INTO `horde_history_schema_info` (`version`) VALUES (6);
/*!40000 ALTER TABLE `horde_history_schema_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_imap_client_data`
--

DROP TABLE IF EXISTS `horde_imap_client_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_imap_client_data` (
  `messageid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `hostspec` varchar(255) NOT NULL,
  `mailbox` varchar(255) NOT NULL,
  `modified` bigint(20) DEFAULT NULL,
  `port` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  PRIMARY KEY (`messageid`),
  KEY `index_horde_imap_client_data_on_hostspec_and_mailbox_and_port_an` (`hostspec`,`mailbox`,`port`,`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_imap_client_data`
--

LOCK TABLES `horde_imap_client_data` WRITE;
/*!40000 ALTER TABLE `horde_imap_client_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `horde_imap_client_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_imap_client_message`
--

DROP TABLE IF EXISTS `horde_imap_client_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_imap_client_message` (
  `data` longblob DEFAULT NULL,
  `msguid` varchar(255) NOT NULL,
  `messageid` bigint(20) NOT NULL,
  KEY `index_horde_imap_client_message_on_msguid_and_messageid` (`msguid`,`messageid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_imap_client_message`
--

LOCK TABLES `horde_imap_client_message` WRITE;
/*!40000 ALTER TABLE `horde_imap_client_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `horde_imap_client_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_imap_client_metadata`
--

DROP TABLE IF EXISTS `horde_imap_client_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_imap_client_metadata` (
  `data` longblob DEFAULT NULL,
  `field` varchar(255) NOT NULL,
  `messageid` bigint(20) NOT NULL,
  KEY `index_horde_imap_client_metadata_on_messageid` (`messageid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_imap_client_metadata`
--

LOCK TABLES `horde_imap_client_metadata` WRITE;
/*!40000 ALTER TABLE `horde_imap_client_metadata` DISABLE KEYS */;
/*!40000 ALTER TABLE `horde_imap_client_metadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_imap_client_schema_info`
--

DROP TABLE IF EXISTS `horde_imap_client_schema_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_imap_client_schema_info` (
  `version` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_imap_client_schema_info`
--

LOCK TABLES `horde_imap_client_schema_info` WRITE;
/*!40000 ALTER TABLE `horde_imap_client_schema_info` DISABLE KEYS */;
REPLACE INTO `horde_imap_client_schema_info` (`version`) VALUES (2);
/*!40000 ALTER TABLE `horde_imap_client_schema_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_lock_schema_info`
--

DROP TABLE IF EXISTS `horde_lock_schema_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_lock_schema_info` (
  `version` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_lock_schema_info`
--

LOCK TABLES `horde_lock_schema_info` WRITE;
/*!40000 ALTER TABLE `horde_lock_schema_info` DISABLE KEYS */;
REPLACE INTO `horde_lock_schema_info` (`version`) VALUES (3);
/*!40000 ALTER TABLE `horde_lock_schema_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_locks`
--

DROP TABLE IF EXISTS `horde_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_locks` (
  `lock_id` varchar(36) NOT NULL,
  `lock_owner` varchar(255) NOT NULL,
  `lock_scope` varchar(32) NOT NULL,
  `lock_principal` varchar(255) NOT NULL,
  `lock_origin_timestamp` bigint(20) NOT NULL,
  `lock_update_timestamp` bigint(20) NOT NULL,
  `lock_expiry_timestamp` bigint(20) NOT NULL,
  `lock_type` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`lock_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_locks`
--

LOCK TABLES `horde_locks` WRITE;
/*!40000 ALTER TABLE `horde_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `horde_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_metar_airports`
--

DROP TABLE IF EXISTS `horde_metar_airports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_metar_airports` (
  `id` int(11) NOT NULL,
  `icao` varchar(4) DEFAULT NULL,
  `name` varchar(80) DEFAULT NULL,
  `state` varchar(4) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `municipality` varchar(80) DEFAULT NULL,
  `latitude` float DEFAULT 0,
  `longitude` float DEFAULT 0,
  `elevation` float DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_metar_airports`
--

LOCK TABLES `horde_metar_airports` WRITE;
/*!40000 ALTER TABLE `horde_metar_airports` DISABLE KEYS */;
/*!40000 ALTER TABLE `horde_metar_airports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_muvfs`
--

DROP TABLE IF EXISTS `horde_muvfs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_muvfs` (
  `vfs_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `vfs_type` smallint(5) unsigned NOT NULL,
  `vfs_path` varchar(255) DEFAULT NULL,
  `vfs_name` varchar(255) NOT NULL,
  `vfs_modified` bigint(20) NOT NULL,
  `vfs_owner` varchar(255) DEFAULT NULL,
  `vfs_perms` smallint(5) unsigned NOT NULL,
  `vfs_data` longblob DEFAULT NULL,
  PRIMARY KEY (`vfs_id`),
  KEY `index_horde_muvfs_on_vfs_path` (`vfs_path`),
  KEY `index_horde_muvfs_on_vfs_name` (`vfs_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_muvfs`
--

LOCK TABLES `horde_muvfs` WRITE;
/*!40000 ALTER TABLE `horde_muvfs` DISABLE KEYS */;
/*!40000 ALTER TABLE `horde_muvfs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_perms`
--

DROP TABLE IF EXISTS `horde_perms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_perms` (
  `perm_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `perm_name` varchar(255) NOT NULL,
  `perm_parents` varchar(255) DEFAULT NULL,
  `perm_data` text DEFAULT NULL,
  PRIMARY KEY (`perm_id`),
  UNIQUE KEY `index_horde_perms_on_perm_name` (`perm_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_perms`
--

LOCK TABLES `horde_perms` WRITE;
/*!40000 ALTER TABLE `horde_perms` DISABLE KEYS */;
REPLACE INTO `horde_perms` (`perm_id`, `perm_name`, `perm_parents`, `perm_data`) VALUES (3,'wicked',NULL,'a:2:{s:4:\"type\";s:6:\"matrix\";s:7:\"default\";i:14;}'),(4,'wicked:pages',':3','a:1:{s:4:\"type\";s:6:\"matrix\";}'),(5,'wicked:pages:AllPages',':3:4','a:1:{s:4:\"type\";s:6:\"matrix\";}'),(6,'horde',NULL,'a:1:{s:4:\"type\";s:6:\"matrix\";}'),(7,'horde:activesync',':6','a:2:{s:4:\"type\";s:7:\"boolean\";s:7:\"default\";b:1;}'),(8,'horde:activesync:provisioning',':6:7','a:3:{s:4:\"type\";s:4:\"enum\";s:6:\"params\";a:1:{i:0;a:4:{i:0;s:0:\"\";s:4:\"true\";s:6:\"Enable\";s:5:\"allow\";s:31:\"Allow non-provisionable devices\";s:5:\"false\";s:25:\"Disable (not recommended)\";}}s:7:\"default\";s:5:\"allow\";}');
/*!40000 ALTER TABLE `horde_perms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_perms_schema_info`
--

DROP TABLE IF EXISTS `horde_perms_schema_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_perms_schema_info` (
  `version` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_perms_schema_info`
--

LOCK TABLES `horde_perms_schema_info` WRITE;
/*!40000 ALTER TABLE `horde_perms_schema_info` DISABLE KEYS */;
REPLACE INTO `horde_perms_schema_info` (`version`) VALUES (3);
/*!40000 ALTER TABLE `horde_perms_schema_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_prefs`
--

DROP TABLE IF EXISTS `horde_prefs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_prefs` (
  `pref_uid` varchar(255) NOT NULL,
  `pref_scope` varchar(16) NOT NULL DEFAULT '',
  `pref_name` varchar(32) NOT NULL,
  `pref_value` longblob DEFAULT NULL,
  PRIMARY KEY (`pref_uid`,`pref_scope`,`pref_name`),
  KEY `index_horde_prefs_on_pref_uid` (`pref_uid`),
  KEY `index_horde_prefs_on_pref_scope` (`pref_scope`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_prefs`
--

LOCK TABLES `horde_prefs` WRITE;
/*!40000 ALTER TABLE `horde_prefs` DISABLE KEYS */;
/*!40000 ALTER TABLE `horde_prefs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_prefs_schema_info`
--

DROP TABLE IF EXISTS `horde_prefs_schema_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_prefs_schema_info` (
  `version` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_prefs_schema_info`
--

LOCK TABLES `horde_prefs_schema_info` WRITE;
/*!40000 ALTER TABLE `horde_prefs_schema_info` DISABLE KEYS */;
REPLACE INTO `horde_prefs_schema_info` (`version`) VALUES (3);
/*!40000 ALTER TABLE `horde_prefs_schema_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_queue_schema_info`
--

DROP TABLE IF EXISTS `horde_queue_schema_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_queue_schema_info` (
  `version` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_queue_schema_info`
--

LOCK TABLES `horde_queue_schema_info` WRITE;
/*!40000 ALTER TABLE `horde_queue_schema_info` DISABLE KEYS */;
REPLACE INTO `horde_queue_schema_info` (`version`) VALUES (1);
/*!40000 ALTER TABLE `horde_queue_schema_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_queue_tasks`
--

DROP TABLE IF EXISTS `horde_queue_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_queue_tasks` (
  `task_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `task_queue` varchar(255) NOT NULL,
  `task_fields` text NOT NULL,
  PRIMARY KEY (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_queue_tasks`
--

LOCK TABLES `horde_queue_tasks` WRITE;
/*!40000 ALTER TABLE `horde_queue_tasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `horde_queue_tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_service_weather_schema_info`
--

DROP TABLE IF EXISTS `horde_service_weather_schema_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_service_weather_schema_info` (
  `version` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_service_weather_schema_info`
--

LOCK TABLES `horde_service_weather_schema_info` WRITE;
/*!40000 ALTER TABLE `horde_service_weather_schema_info` DISABLE KEYS */;
REPLACE INTO `horde_service_weather_schema_info` (`version`) VALUES (2);
/*!40000 ALTER TABLE `horde_service_weather_schema_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_sessionhandler`
--

DROP TABLE IF EXISTS `horde_sessionhandler`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_sessionhandler` (
  `session_id` varchar(32) NOT NULL,
  `session_lastmodified` int(11) NOT NULL,
  `session_data` longblob DEFAULT NULL,
  PRIMARY KEY (`session_id`),
  KEY `index_horde_sessionhandler_on_session_lastmodified` (`session_lastmodified`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_sessionhandler`
--

LOCK TABLES `horde_sessionhandler` WRITE;
/*!40000 ALTER TABLE `horde_sessionhandler` DISABLE KEYS */;
/*!40000 ALTER TABLE `horde_sessionhandler` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_sessionhandler_schema_info`
--

DROP TABLE IF EXISTS `horde_sessionhandler_schema_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_sessionhandler_schema_info` (
  `version` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_sessionhandler_schema_info`
--

LOCK TABLES `horde_sessionhandler_schema_info` WRITE;
/*!40000 ALTER TABLE `horde_sessionhandler_schema_info` DISABLE KEYS */;
REPLACE INTO `horde_sessionhandler_schema_info` (`version`) VALUES (2);
/*!40000 ALTER TABLE `horde_sessionhandler_schema_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_signups`
--

DROP TABLE IF EXISTS `horde_signups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_signups` (
  `user_name` varchar(255) NOT NULL,
  `signup_date` int(11) NOT NULL,
  `signup_host` varchar(255) NOT NULL,
  `signup_data` text NOT NULL,
  PRIMARY KEY (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_signups`
--

LOCK TABLES `horde_signups` WRITE;
/*!40000 ALTER TABLE `horde_signups` DISABLE KEYS */;
/*!40000 ALTER TABLE `horde_signups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_syncml_anchors`
--

DROP TABLE IF EXISTS `horde_syncml_anchors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_syncml_anchors` (
  `syncml_syncpartner` varchar(255) NOT NULL,
  `syncml_db` varchar(255) NOT NULL,
  `syncml_uid` varchar(255) NOT NULL,
  `syncml_clientanchor` varchar(255) DEFAULT NULL,
  `syncml_serveranchor` varchar(255) DEFAULT NULL,
  KEY `index_horde_syncml_anchors_on_syncml_syncpartner` (`syncml_syncpartner`),
  KEY `index_horde_syncml_anchors_on_syncml_db` (`syncml_db`),
  KEY `index_horde_syncml_anchors_on_syncml_uid` (`syncml_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_syncml_anchors`
--

LOCK TABLES `horde_syncml_anchors` WRITE;
/*!40000 ALTER TABLE `horde_syncml_anchors` DISABLE KEYS */;
/*!40000 ALTER TABLE `horde_syncml_anchors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_syncml_map`
--

DROP TABLE IF EXISTS `horde_syncml_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_syncml_map` (
  `syncml_syncpartner` varchar(255) NOT NULL,
  `syncml_db` varchar(255) NOT NULL,
  `syncml_uid` varchar(255) NOT NULL,
  `syncml_cuid` varchar(255) DEFAULT NULL,
  `syncml_suid` varchar(255) DEFAULT NULL,
  `syncml_timestamp` int(11) DEFAULT NULL,
  KEY `index_horde_syncml_map_on_syncml_syncpartner` (`syncml_syncpartner`),
  KEY `index_horde_syncml_map_on_syncml_db` (`syncml_db`),
  KEY `index_horde_syncml_map_on_syncml_uid` (`syncml_uid`),
  KEY `index_horde_syncml_map_on_syncml_cuid` (`syncml_cuid`),
  KEY `index_horde_syncml_map_on_syncml_suid` (`syncml_suid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_syncml_map`
--

LOCK TABLES `horde_syncml_map` WRITE;
/*!40000 ALTER TABLE `horde_syncml_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `horde_syncml_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_syncml_schema_info`
--

DROP TABLE IF EXISTS `horde_syncml_schema_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_syncml_schema_info` (
  `version` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_syncml_schema_info`
--

LOCK TABLES `horde_syncml_schema_info` WRITE;
/*!40000 ALTER TABLE `horde_syncml_schema_info` DISABLE KEYS */;
REPLACE INTO `horde_syncml_schema_info` (`version`) VALUES (1);
/*!40000 ALTER TABLE `horde_syncml_schema_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_token_schema_info`
--

DROP TABLE IF EXISTS `horde_token_schema_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_token_schema_info` (
  `version` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_token_schema_info`
--

LOCK TABLES `horde_token_schema_info` WRITE;
/*!40000 ALTER TABLE `horde_token_schema_info` DISABLE KEYS */;
REPLACE INTO `horde_token_schema_info` (`version`) VALUES (1);
/*!40000 ALTER TABLE `horde_token_schema_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_tokens`
--

DROP TABLE IF EXISTS `horde_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_tokens` (
  `token_address` varchar(100) NOT NULL,
  `token_id` varchar(32) NOT NULL,
  `token_timestamp` bigint(20) NOT NULL,
  PRIMARY KEY (`token_address`,`token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_tokens`
--

LOCK TABLES `horde_tokens` WRITE;
/*!40000 ALTER TABLE `horde_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `horde_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_users`
--

DROP TABLE IF EXISTS `horde_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_users` (
  `user_uid` varchar(255) NOT NULL,
  `user_pass` varchar(255) NOT NULL,
  `user_soft_expiration_date` int(11) DEFAULT NULL,
  `user_hard_expiration_date` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_users`
--

LOCK TABLES `horde_users` WRITE;
/*!40000 ALTER TABLE `horde_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `horde_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_vfs`
--

DROP TABLE IF EXISTS `horde_vfs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_vfs` (
  `vfs_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `vfs_type` smallint(5) unsigned NOT NULL,
  `vfs_path` varchar(255) DEFAULT NULL,
  `vfs_name` varchar(255) NOT NULL,
  `vfs_modified` bigint(20) NOT NULL,
  `vfs_owner` varchar(255) DEFAULT NULL,
  `vfs_data` longblob DEFAULT NULL,
  PRIMARY KEY (`vfs_id`),
  KEY `index_horde_vfs_on_vfs_path` (`vfs_path`),
  KEY `index_horde_vfs_on_vfs_name` (`vfs_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_vfs`
--

LOCK TABLES `horde_vfs` WRITE;
/*!40000 ALTER TABLE `horde_vfs` DISABLE KEYS */;
/*!40000 ALTER TABLE `horde_vfs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horde_vfs_schema_info`
--

DROP TABLE IF EXISTS `horde_vfs_schema_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horde_vfs_schema_info` (
  `version` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horde_vfs_schema_info`
--

LOCK TABLES `horde_vfs_schema_info` WRITE;
/*!40000 ALTER TABLE `horde_vfs_schema_info` DISABLE KEYS */;
REPLACE INTO `horde_vfs_schema_info` (`version`) VALUES (4);
/*!40000 ALTER TABLE `horde_vfs_schema_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imp_schema_info`
--

DROP TABLE IF EXISTS `imp_schema_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imp_schema_info` (
  `version` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imp_schema_info`
--

LOCK TABLES `imp_schema_info` WRITE;
/*!40000 ALTER TABLE `imp_schema_info` DISABLE KEYS */;
REPLACE INTO `imp_schema_info` (`version`) VALUES (3);
/*!40000 ALTER TABLE `imp_schema_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imp_sentmail`
--

DROP TABLE IF EXISTS `imp_sentmail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imp_sentmail` (
  `sentmail_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sentmail_who` varchar(255) NOT NULL,
  `sentmail_ts` bigint(20) NOT NULL,
  `sentmail_messageid` varchar(255) NOT NULL,
  `sentmail_action` varchar(32) NOT NULL,
  `sentmail_recipient` varchar(255) NOT NULL,
  `sentmail_success` int(11) NOT NULL,
  PRIMARY KEY (`sentmail_id`),
  KEY `index_imp_sentmail_on_sentmail_ts` (`sentmail_ts`),
  KEY `index_imp_sentmail_on_sentmail_who` (`sentmail_who`),
  KEY `index_imp_sentmail_on_sentmail_success` (`sentmail_success`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imp_sentmail`
--

LOCK TABLES `imp_sentmail` WRITE;
/*!40000 ALTER TABLE `imp_sentmail` DISABLE KEYS */;
/*!40000 ALTER TABLE `imp_sentmail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingo_forwards`
--

DROP TABLE IF EXISTS `ingo_forwards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ingo_forwards` (
  `forward_owner` varchar(255) NOT NULL,
  `forward_addresses` text DEFAULT NULL,
  `forward_keep` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingo_forwards`
--

LOCK TABLES `ingo_forwards` WRITE;
/*!40000 ALTER TABLE `ingo_forwards` DISABLE KEYS */;
/*!40000 ALTER TABLE `ingo_forwards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingo_lists`
--

DROP TABLE IF EXISTS `ingo_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ingo_lists` (
  `list_owner` varchar(255) NOT NULL,
  `list_blacklist` int(11) DEFAULT 0,
  `list_address` varchar(255) NOT NULL,
  KEY `index_ingo_lists_on_list_owner_and_list_blacklist` (`list_owner`,`list_blacklist`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingo_lists`
--

LOCK TABLES `ingo_lists` WRITE;
/*!40000 ALTER TABLE `ingo_lists` DISABLE KEYS */;
/*!40000 ALTER TABLE `ingo_lists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingo_rules`
--

DROP TABLE IF EXISTS `ingo_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ingo_rules` (
  `rule_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rule_owner` varchar(255) NOT NULL,
  `rule_name` varchar(255) NOT NULL,
  `rule_action` int(11) NOT NULL,
  `rule_value` varchar(255) DEFAULT NULL,
  `rule_flags` int(11) DEFAULT NULL,
  `rule_conditions` text DEFAULT NULL,
  `rule_combine` int(11) DEFAULT NULL,
  `rule_stop` int(11) DEFAULT NULL,
  `rule_active` int(11) NOT NULL DEFAULT 1,
  `rule_order` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`rule_id`),
  KEY `index_ingo_rules_on_rule_owner` (`rule_owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingo_rules`
--

LOCK TABLES `ingo_rules` WRITE;
/*!40000 ALTER TABLE `ingo_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `ingo_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingo_schema_info`
--

DROP TABLE IF EXISTS `ingo_schema_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ingo_schema_info` (
  `version` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingo_schema_info`
--

LOCK TABLES `ingo_schema_info` WRITE;
/*!40000 ALTER TABLE `ingo_schema_info` DISABLE KEYS */;
REPLACE INTO `ingo_schema_info` (`version`) VALUES (7);
/*!40000 ALTER TABLE `ingo_schema_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingo_shares`
--

DROP TABLE IF EXISTS `ingo_shares`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ingo_shares` (
  `share_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `share_name` varchar(255) NOT NULL,
  `share_owner` varchar(255) NOT NULL,
  `share_flags` int(11) NOT NULL DEFAULT 0,
  `perm_creator` int(11) NOT NULL DEFAULT 0,
  `perm_default` int(11) NOT NULL DEFAULT 0,
  `perm_guest` int(11) NOT NULL DEFAULT 0,
  `attribute_name` varchar(255) NOT NULL,
  `attribute_desc` varchar(255) DEFAULT NULL,
  `share_parents` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`share_id`),
  KEY `index_ingo_shares_on_share_name` (`share_name`),
  KEY `index_ingo_shares_on_share_owner` (`share_owner`),
  KEY `index_ingo_shares_on_perm_creator` (`perm_creator`),
  KEY `index_ingo_shares_on_perm_default` (`perm_default`),
  KEY `index_ingo_shares_on_perm_guest` (`perm_guest`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingo_shares`
--

LOCK TABLES `ingo_shares` WRITE;
/*!40000 ALTER TABLE `ingo_shares` DISABLE KEYS */;
/*!40000 ALTER TABLE `ingo_shares` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingo_shares_groups`
--

DROP TABLE IF EXISTS `ingo_shares_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ingo_shares_groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `share_id` int(11) NOT NULL,
  `group_uid` varchar(255) NOT NULL,
  `perm` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_ingo_shares_groups_on_share_id` (`share_id`),
  KEY `index_ingo_shares_groups_on_group_uid` (`group_uid`),
  KEY `index_ingo_shares_groups_on_perm` (`perm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingo_shares_groups`
--

LOCK TABLES `ingo_shares_groups` WRITE;
/*!40000 ALTER TABLE `ingo_shares_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `ingo_shares_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingo_shares_users`
--

DROP TABLE IF EXISTS `ingo_shares_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ingo_shares_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `share_id` int(11) NOT NULL,
  `user_uid` varchar(255) NOT NULL,
  `perm` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_ingo_shares_users_on_share_id` (`share_id`),
  KEY `index_ingo_shares_users_on_user_uid` (`user_uid`),
  KEY `index_ingo_shares_users_on_perm` (`perm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingo_shares_users`
--

LOCK TABLES `ingo_shares_users` WRITE;
/*!40000 ALTER TABLE `ingo_shares_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `ingo_shares_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingo_sharesng`
--

DROP TABLE IF EXISTS `ingo_sharesng`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ingo_sharesng` (
  `share_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `share_name` varchar(255) NOT NULL,
  `share_owner` varchar(255) DEFAULT NULL,
  `share_flags` int(11) NOT NULL DEFAULT 0,
  `perm_creator_2` tinyint(1) NOT NULL DEFAULT 0,
  `perm_creator_4` tinyint(1) NOT NULL DEFAULT 0,
  `perm_creator_8` tinyint(1) NOT NULL DEFAULT 0,
  `perm_creator_16` tinyint(1) NOT NULL DEFAULT 0,
  `perm_default_2` tinyint(1) NOT NULL DEFAULT 0,
  `perm_default_4` tinyint(1) NOT NULL DEFAULT 0,
  `perm_default_8` tinyint(1) NOT NULL DEFAULT 0,
  `perm_default_16` tinyint(1) NOT NULL DEFAULT 0,
  `perm_guest_2` tinyint(1) NOT NULL DEFAULT 0,
  `perm_guest_4` tinyint(1) NOT NULL DEFAULT 0,
  `perm_guest_8` tinyint(1) NOT NULL DEFAULT 0,
  `perm_guest_16` tinyint(1) NOT NULL DEFAULT 0,
  `attribute_name` varchar(255) NOT NULL,
  `attribute_desc` varchar(255) DEFAULT NULL,
  `share_parents` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`share_id`),
  KEY `index_ingo_sharesng_on_share_name` (`share_name`),
  KEY `index_ingo_sharesng_on_share_owner` (`share_owner`),
  KEY `index_ingo_sharesng_on_perm_creator_2` (`perm_creator_2`),
  KEY `index_ingo_sharesng_on_perm_creator_4` (`perm_creator_4`),
  KEY `index_ingo_sharesng_on_perm_creator_8` (`perm_creator_8`),
  KEY `index_ingo_sharesng_on_perm_creator_16` (`perm_creator_16`),
  KEY `index_ingo_sharesng_on_perm_default_2` (`perm_default_2`),
  KEY `index_ingo_sharesng_on_perm_default_4` (`perm_default_4`),
  KEY `index_ingo_sharesng_on_perm_default_8` (`perm_default_8`),
  KEY `index_ingo_sharesng_on_perm_default_16` (`perm_default_16`),
  KEY `index_ingo_sharesng_on_perm_guest_2` (`perm_guest_2`),
  KEY `index_ingo_sharesng_on_perm_guest_4` (`perm_guest_4`),
  KEY `index_ingo_sharesng_on_perm_guest_8` (`perm_guest_8`),
  KEY `index_ingo_sharesng_on_perm_guest_16` (`perm_guest_16`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingo_sharesng`
--

LOCK TABLES `ingo_sharesng` WRITE;
/*!40000 ALTER TABLE `ingo_sharesng` DISABLE KEYS */;
/*!40000 ALTER TABLE `ingo_sharesng` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingo_sharesng_groups`
--

DROP TABLE IF EXISTS `ingo_sharesng_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ingo_sharesng_groups` (
  `share_id` int(11) NOT NULL,
  `group_uid` varchar(255) NOT NULL,
  `perm_2` tinyint(1) NOT NULL DEFAULT 0,
  `perm_4` tinyint(1) NOT NULL DEFAULT 0,
  `perm_8` tinyint(1) NOT NULL DEFAULT 0,
  `perm_16` tinyint(1) NOT NULL DEFAULT 0,
  KEY `index_ingo_sharesng_groups_on_share_id` (`share_id`),
  KEY `index_ingo_sharesng_groups_on_group_uid` (`group_uid`),
  KEY `index_ingo_sharesng_groups_on_perm_2` (`perm_2`),
  KEY `index_ingo_sharesng_groups_on_perm_4` (`perm_4`),
  KEY `index_ingo_sharesng_groups_on_perm_8` (`perm_8`),
  KEY `index_ingo_sharesng_groups_on_perm_16` (`perm_16`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingo_sharesng_groups`
--

LOCK TABLES `ingo_sharesng_groups` WRITE;
/*!40000 ALTER TABLE `ingo_sharesng_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `ingo_sharesng_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingo_sharesng_users`
--

DROP TABLE IF EXISTS `ingo_sharesng_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ingo_sharesng_users` (
  `share_id` int(11) NOT NULL,
  `user_uid` varchar(255) NOT NULL,
  `perm_2` tinyint(1) NOT NULL DEFAULT 0,
  `perm_4` tinyint(1) NOT NULL DEFAULT 0,
  `perm_8` tinyint(1) NOT NULL DEFAULT 0,
  `perm_16` tinyint(1) NOT NULL DEFAULT 0,
  KEY `index_ingo_sharesng_users_on_share_id` (`share_id`),
  KEY `index_ingo_sharesng_users_on_user_uid` (`user_uid`),
  KEY `index_ingo_sharesng_users_on_perm_2` (`perm_2`),
  KEY `index_ingo_sharesng_users_on_perm_4` (`perm_4`),
  KEY `index_ingo_sharesng_users_on_perm_8` (`perm_8`),
  KEY `index_ingo_sharesng_users_on_perm_16` (`perm_16`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingo_sharesng_users`
--

LOCK TABLES `ingo_sharesng_users` WRITE;
/*!40000 ALTER TABLE `ingo_sharesng_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `ingo_sharesng_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingo_spam`
--

DROP TABLE IF EXISTS `ingo_spam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ingo_spam` (
  `spam_owner` varchar(255) NOT NULL,
  `spam_level` int(11) DEFAULT 5,
  `spam_folder` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`spam_owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingo_spam`
--

LOCK TABLES `ingo_spam` WRITE;
/*!40000 ALTER TABLE `ingo_spam` DISABLE KEYS */;
/*!40000 ALTER TABLE `ingo_spam` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingo_vacations`
--

DROP TABLE IF EXISTS `ingo_vacations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ingo_vacations` (
  `vacation_owner` varchar(255) NOT NULL,
  `vacation_addresses` text DEFAULT NULL,
  `vacation_subject` varchar(255) DEFAULT NULL,
  `vacation_reason` text DEFAULT NULL,
  `vacation_days` int(11) DEFAULT 7,
  `vacation_start` int(11) DEFAULT NULL,
  `vacation_end` int(11) DEFAULT NULL,
  `vacation_excludes` text DEFAULT NULL,
  `vacation_ignorelists` int(11) DEFAULT 1,
  PRIMARY KEY (`vacation_owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingo_vacations`
--

LOCK TABLES `ingo_vacations` WRITE;
/*!40000 ALTER TABLE `ingo_vacations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ingo_vacations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kronolith_events`
--

DROP TABLE IF EXISTS `kronolith_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kronolith_events` (
  `event_id` varchar(32) NOT NULL,
  `event_uid` varchar(255) NOT NULL,
  `calendar_id` varchar(255) NOT NULL,
  `event_creator_id` varchar(255) NOT NULL,
  `event_description` text DEFAULT NULL,
  `event_location` text DEFAULT NULL,
  `event_status` int(11) DEFAULT 0,
  `event_attendees` text DEFAULT NULL,
  `event_keywords` text DEFAULT NULL,
  `event_exceptions` text DEFAULT NULL,
  `event_title` varchar(255) DEFAULT NULL,
  `event_recurtype` int(11) DEFAULT 0,
  `event_recurinterval` int(11) DEFAULT NULL,
  `event_recurdays` int(11) DEFAULT NULL,
  `event_recurenddate` datetime DEFAULT NULL,
  `event_recurcount` int(11) DEFAULT NULL,
  `event_start` datetime DEFAULT NULL,
  `event_end` datetime DEFAULT NULL,
  `event_alarm` int(11) DEFAULT 0,
  `event_modified` int(11) DEFAULT 0,
  `event_private` int(11) NOT NULL DEFAULT 0,
  `event_allday` int(11) DEFAULT 0,
  `event_alarm_methods` text DEFAULT NULL,
  `event_url` text DEFAULT NULL,
  `event_baseid` varchar(255) DEFAULT '',
  `event_exceptionoriginaldate` datetime DEFAULT NULL,
  `event_resources` text DEFAULT NULL,
  `event_timezone` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `index_kronolith_events_on_calendar_id` (`calendar_id`),
  KEY `index_kronolith_events_on_event_uid` (`event_uid`),
  KEY `index_kronolith_events_on_event_baseid` (`event_baseid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kronolith_events`
--

LOCK TABLES `kronolith_events` WRITE;
/*!40000 ALTER TABLE `kronolith_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `kronolith_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kronolith_events_geo`
--

DROP TABLE IF EXISTS `kronolith_events_geo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kronolith_events_geo` (
  `event_id` varchar(32) NOT NULL,
  `event_lat` varchar(32) NOT NULL,
  `event_lon` varchar(32) NOT NULL,
  PRIMARY KEY (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kronolith_events_geo`
--

LOCK TABLES `kronolith_events_geo` WRITE;
/*!40000 ALTER TABLE `kronolith_events_geo` DISABLE KEYS */;
/*!40000 ALTER TABLE `kronolith_events_geo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kronolith_events_mysqlgeo`
--

DROP TABLE IF EXISTS `kronolith_events_mysqlgeo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kronolith_events_mysqlgeo` (
  `event_id` varchar(32) NOT NULL,
  `event_coordinates` point NOT NULL,
  `event_zoom` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kronolith_events_mysqlgeo`
--

LOCK TABLES `kronolith_events_mysqlgeo` WRITE;
/*!40000 ALTER TABLE `kronolith_events_mysqlgeo` DISABLE KEYS */;
/*!40000 ALTER TABLE `kronolith_events_mysqlgeo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kronolith_resources`
--

DROP TABLE IF EXISTS `kronolith_resources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kronolith_resources` (
  `resource_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `resource_name` varchar(255) DEFAULT NULL,
  `resource_calendar` varchar(255) DEFAULT NULL,
  `resource_description` text DEFAULT NULL,
  `resource_response_type` int(11) DEFAULT 0,
  `resource_type` varchar(255) NOT NULL,
  `resource_members` text DEFAULT NULL,
  `resource_email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`resource_id`),
  KEY `index_kronolith_resources_on_resource_calendar` (`resource_calendar`),
  KEY `index_kronolith_resources_on_resource_type` (`resource_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kronolith_resources`
--

LOCK TABLES `kronolith_resources` WRITE;
/*!40000 ALTER TABLE `kronolith_resources` DISABLE KEYS */;
/*!40000 ALTER TABLE `kronolith_resources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kronolith_schema_info`
--

DROP TABLE IF EXISTS `kronolith_schema_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kronolith_schema_info` (
  `version` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kronolith_schema_info`
--

LOCK TABLES `kronolith_schema_info` WRITE;
/*!40000 ALTER TABLE `kronolith_schema_info` DISABLE KEYS */;
REPLACE INTO `kronolith_schema_info` (`version`) VALUES (23);
/*!40000 ALTER TABLE `kronolith_schema_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kronolith_shares`
--

DROP TABLE IF EXISTS `kronolith_shares`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kronolith_shares` (
  `share_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `share_name` varchar(255) NOT NULL,
  `share_owner` varchar(255) DEFAULT NULL,
  `share_flags` int(11) NOT NULL DEFAULT 0,
  `perm_creator` int(11) NOT NULL DEFAULT 0,
  `perm_default` int(11) NOT NULL DEFAULT 0,
  `perm_guest` int(11) NOT NULL DEFAULT 0,
  `attribute_name` varchar(255) NOT NULL,
  `attribute_desc` varchar(255) DEFAULT NULL,
  `attribute_color` varchar(7) DEFAULT NULL,
  `share_parents` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`share_id`),
  KEY `index_kronolith_shares_on_share_name` (`share_name`),
  KEY `index_kronolith_shares_on_share_owner` (`share_owner`),
  KEY `index_kronolith_shares_on_perm_creator` (`perm_creator`),
  KEY `index_kronolith_shares_on_perm_default` (`perm_default`),
  KEY `index_kronolith_shares_on_perm_guest` (`perm_guest`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kronolith_shares`
--

LOCK TABLES `kronolith_shares` WRITE;
/*!40000 ALTER TABLE `kronolith_shares` DISABLE KEYS */;
/*!40000 ALTER TABLE `kronolith_shares` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kronolith_shares_groups`
--

DROP TABLE IF EXISTS `kronolith_shares_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kronolith_shares_groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `share_id` int(11) NOT NULL,
  `group_uid` varchar(255) NOT NULL,
  `perm` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_kronolith_shares_groups_on_share_id` (`share_id`),
  KEY `index_kronolith_shares_groups_on_group_uid` (`group_uid`),
  KEY `index_kronolith_shares_groups_on_perm` (`perm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kronolith_shares_groups`
--

LOCK TABLES `kronolith_shares_groups` WRITE;
/*!40000 ALTER TABLE `kronolith_shares_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `kronolith_shares_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kronolith_shares_users`
--

DROP TABLE IF EXISTS `kronolith_shares_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kronolith_shares_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `share_id` int(11) NOT NULL,
  `user_uid` varchar(255) NOT NULL,
  `perm` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_kronolith_shares_users_on_share_id` (`share_id`),
  KEY `index_kronolith_shares_users_on_user_uid` (`user_uid`),
  KEY `index_kronolith_shares_users_on_perm` (`perm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kronolith_shares_users`
--

LOCK TABLES `kronolith_shares_users` WRITE;
/*!40000 ALTER TABLE `kronolith_shares_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `kronolith_shares_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kronolith_sharesng`
--

DROP TABLE IF EXISTS `kronolith_sharesng`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kronolith_sharesng` (
  `share_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `share_name` varchar(255) NOT NULL,
  `share_owner` varchar(255) DEFAULT NULL,
  `share_flags` int(11) NOT NULL DEFAULT 0,
  `perm_creator_2` tinyint(1) NOT NULL DEFAULT 0,
  `perm_creator_4` tinyint(1) NOT NULL DEFAULT 0,
  `perm_creator_8` tinyint(1) NOT NULL DEFAULT 0,
  `perm_creator_16` tinyint(1) NOT NULL DEFAULT 0,
  `perm_creator_1024` tinyint(1) NOT NULL DEFAULT 0,
  `perm_default_2` tinyint(1) NOT NULL DEFAULT 0,
  `perm_default_4` tinyint(1) NOT NULL DEFAULT 0,
  `perm_default_8` tinyint(1) NOT NULL DEFAULT 0,
  `perm_default_16` tinyint(1) NOT NULL DEFAULT 0,
  `perm_default_1024` tinyint(1) NOT NULL DEFAULT 0,
  `perm_guest_2` tinyint(1) NOT NULL DEFAULT 0,
  `perm_guest_4` tinyint(1) NOT NULL DEFAULT 0,
  `perm_guest_8` tinyint(1) NOT NULL DEFAULT 0,
  `perm_guest_16` tinyint(1) NOT NULL DEFAULT 0,
  `perm_guest_1024` tinyint(1) NOT NULL DEFAULT 0,
  `attribute_name` varchar(255) NOT NULL,
  `attribute_desc` varchar(255) DEFAULT NULL,
  `attribute_color` varchar(7) DEFAULT NULL,
  `share_parents` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`share_id`),
  KEY `index_kronolith_sharesng_on_share_name` (`share_name`),
  KEY `index_kronolith_sharesng_on_share_owner` (`share_owner`),
  KEY `index_kronolith_sharesng_on_perm_creator_2` (`perm_creator_2`),
  KEY `index_kronolith_sharesng_on_perm_creator_4` (`perm_creator_4`),
  KEY `index_kronolith_sharesng_on_perm_creator_8` (`perm_creator_8`),
  KEY `index_kronolith_sharesng_on_perm_creator_16` (`perm_creator_16`),
  KEY `index_kronolith_sharesng_on_perm_creator_1024` (`perm_creator_1024`),
  KEY `index_kronolith_sharesng_on_perm_default_2` (`perm_default_2`),
  KEY `index_kronolith_sharesng_on_perm_default_4` (`perm_default_4`),
  KEY `index_kronolith_sharesng_on_perm_default_8` (`perm_default_8`),
  KEY `index_kronolith_sharesng_on_perm_default_16` (`perm_default_16`),
  KEY `index_kronolith_sharesng_on_perm_default_1024` (`perm_default_1024`),
  KEY `index_kronolith_sharesng_on_perm_guest_2` (`perm_guest_2`),
  KEY `index_kronolith_sharesng_on_perm_guest_4` (`perm_guest_4`),
  KEY `index_kronolith_sharesng_on_perm_guest_8` (`perm_guest_8`),
  KEY `index_kronolith_sharesng_on_perm_guest_16` (`perm_guest_16`),
  KEY `index_kronolith_sharesng_on_perm_guest_1024` (`perm_guest_1024`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kronolith_sharesng`
--

LOCK TABLES `kronolith_sharesng` WRITE;
/*!40000 ALTER TABLE `kronolith_sharesng` DISABLE KEYS */;
/*!40000 ALTER TABLE `kronolith_sharesng` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kronolith_sharesng_groups`
--

DROP TABLE IF EXISTS `kronolith_sharesng_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kronolith_sharesng_groups` (
  `share_id` int(11) NOT NULL,
  `group_uid` varchar(255) NOT NULL,
  `perm_2` tinyint(1) NOT NULL DEFAULT 0,
  `perm_4` tinyint(1) NOT NULL DEFAULT 0,
  `perm_8` tinyint(1) NOT NULL DEFAULT 0,
  `perm_16` tinyint(1) NOT NULL DEFAULT 0,
  `perm_1024` tinyint(1) NOT NULL DEFAULT 0,
  KEY `index_kronolith_sharesng_groups_on_share_id` (`share_id`),
  KEY `index_kronolith_sharesng_groups_on_group_uid` (`group_uid`),
  KEY `index_kronolith_sharesng_groups_on_perm_2` (`perm_2`),
  KEY `index_kronolith_sharesng_groups_on_perm_4` (`perm_4`),
  KEY `index_kronolith_sharesng_groups_on_perm_8` (`perm_8`),
  KEY `index_kronolith_sharesng_groups_on_perm_16` (`perm_16`),
  KEY `index_kronolith_sharesng_groups_on_perm_1024` (`perm_1024`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kronolith_sharesng_groups`
--

LOCK TABLES `kronolith_sharesng_groups` WRITE;
/*!40000 ALTER TABLE `kronolith_sharesng_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `kronolith_sharesng_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kronolith_sharesng_users`
--

DROP TABLE IF EXISTS `kronolith_sharesng_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kronolith_sharesng_users` (
  `share_id` int(11) NOT NULL,
  `user_uid` varchar(255) NOT NULL,
  `perm_2` tinyint(1) NOT NULL DEFAULT 0,
  `perm_4` tinyint(1) NOT NULL DEFAULT 0,
  `perm_8` tinyint(1) NOT NULL DEFAULT 0,
  `perm_16` tinyint(1) NOT NULL DEFAULT 0,
  `perm_1024` tinyint(1) NOT NULL DEFAULT 0,
  KEY `index_kronolith_sharesng_users_on_share_id` (`share_id`),
  KEY `index_kronolith_sharesng_users_on_user_uid` (`user_uid`),
  KEY `index_kronolith_sharesng_users_on_perm_2` (`perm_2`),
  KEY `index_kronolith_sharesng_users_on_perm_4` (`perm_4`),
  KEY `index_kronolith_sharesng_users_on_perm_8` (`perm_8`),
  KEY `index_kronolith_sharesng_users_on_perm_16` (`perm_16`),
  KEY `index_kronolith_sharesng_users_on_perm_1024` (`perm_1024`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kronolith_sharesng_users`
--

LOCK TABLES `kronolith_sharesng_users` WRITE;
/*!40000 ALTER TABLE `kronolith_sharesng_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `kronolith_sharesng_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kronolith_storage`
--

DROP TABLE IF EXISTS `kronolith_storage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kronolith_storage` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `vfb_owner` varchar(255) DEFAULT NULL,
  `vfb_email` varchar(255) NOT NULL,
  `vfb_serialized` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_kronolith_storage_on_vfb_owner` (`vfb_owner`),
  KEY `index_kronolith_storage_on_vfb_email` (`vfb_email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kronolith_storage`
--

LOCK TABLES `kronolith_storage` WRITE;
/*!40000 ALTER TABLE `kronolith_storage` DISABLE KEYS */;
/*!40000 ALTER TABLE `kronolith_storage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mnemo_memos`
--

DROP TABLE IF EXISTS `mnemo_memos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mnemo_memos` (
  `memo_owner` varchar(255) NOT NULL,
  `memo_id` varchar(32) NOT NULL,
  `memo_uid` varchar(255) NOT NULL,
  `memo_desc` varchar(255) NOT NULL,
  `memo_body` text DEFAULT NULL,
  `memo_private` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`memo_owner`,`memo_id`),
  KEY `index_mnemo_memos_on_memo_owner` (`memo_owner`),
  KEY `index_mnemo_memos_on_memo_uid` (`memo_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mnemo_memos`
--

LOCK TABLES `mnemo_memos` WRITE;
/*!40000 ALTER TABLE `mnemo_memos` DISABLE KEYS */;
/*!40000 ALTER TABLE `mnemo_memos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mnemo_schema_info`
--

DROP TABLE IF EXISTS `mnemo_schema_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mnemo_schema_info` (
  `version` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mnemo_schema_info`
--

LOCK TABLES `mnemo_schema_info` WRITE;
/*!40000 ALTER TABLE `mnemo_schema_info` DISABLE KEYS */;
REPLACE INTO `mnemo_schema_info` (`version`) VALUES (8);
/*!40000 ALTER TABLE `mnemo_schema_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mnemo_shares`
--

DROP TABLE IF EXISTS `mnemo_shares`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mnemo_shares` (
  `share_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `share_name` varchar(255) NOT NULL,
  `share_owner` varchar(255) NOT NULL,
  `share_flags` int(11) NOT NULL DEFAULT 0,
  `perm_creator` int(11) NOT NULL DEFAULT 0,
  `perm_default` int(11) NOT NULL DEFAULT 0,
  `perm_guest` int(11) NOT NULL DEFAULT 0,
  `attribute_name` varchar(255) NOT NULL,
  `attribute_desc` varchar(255) DEFAULT NULL,
  `share_parents` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`share_id`),
  KEY `index_mnemo_shares_on_share_name` (`share_name`),
  KEY `index_mnemo_shares_on_share_owner` (`share_owner`),
  KEY `index_mnemo_shares_on_perm_creator` (`perm_creator`),
  KEY `index_mnemo_shares_on_perm_default` (`perm_default`),
  KEY `index_mnemo_shares_on_perm_guest` (`perm_guest`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mnemo_shares`
--

LOCK TABLES `mnemo_shares` WRITE;
/*!40000 ALTER TABLE `mnemo_shares` DISABLE KEYS */;
/*!40000 ALTER TABLE `mnemo_shares` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mnemo_shares_groups`
--

DROP TABLE IF EXISTS `mnemo_shares_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mnemo_shares_groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `share_id` int(11) NOT NULL,
  `group_uid` varchar(255) NOT NULL,
  `perm` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mnemo_shares_groups_on_share_id` (`share_id`),
  KEY `index_mnemo_shares_groups_on_group_uid` (`group_uid`),
  KEY `index_mnemo_shares_groups_on_perm` (`perm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mnemo_shares_groups`
--

LOCK TABLES `mnemo_shares_groups` WRITE;
/*!40000 ALTER TABLE `mnemo_shares_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `mnemo_shares_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mnemo_shares_users`
--

DROP TABLE IF EXISTS `mnemo_shares_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mnemo_shares_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `share_id` int(11) NOT NULL,
  `user_uid` varchar(255) NOT NULL,
  `perm` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mnemo_shares_users_on_share_id` (`share_id`),
  KEY `index_mnemo_shares_users_on_user_uid` (`user_uid`),
  KEY `index_mnemo_shares_users_on_perm` (`perm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mnemo_shares_users`
--

LOCK TABLES `mnemo_shares_users` WRITE;
/*!40000 ALTER TABLE `mnemo_shares_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `mnemo_shares_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mnemo_sharesng`
--

DROP TABLE IF EXISTS `mnemo_sharesng`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mnemo_sharesng` (
  `share_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `share_name` varchar(255) NOT NULL,
  `share_owner` varchar(255) DEFAULT NULL,
  `share_flags` int(11) NOT NULL DEFAULT 0,
  `perm_creator_2` tinyint(1) NOT NULL DEFAULT 0,
  `perm_creator_4` tinyint(1) NOT NULL DEFAULT 0,
  `perm_creator_8` tinyint(1) NOT NULL DEFAULT 0,
  `perm_creator_16` tinyint(1) NOT NULL DEFAULT 0,
  `perm_default_2` tinyint(1) NOT NULL DEFAULT 0,
  `perm_default_4` tinyint(1) NOT NULL DEFAULT 0,
  `perm_default_8` tinyint(1) NOT NULL DEFAULT 0,
  `perm_default_16` tinyint(1) NOT NULL DEFAULT 0,
  `perm_guest_2` tinyint(1) NOT NULL DEFAULT 0,
  `perm_guest_4` tinyint(1) NOT NULL DEFAULT 0,
  `perm_guest_8` tinyint(1) NOT NULL DEFAULT 0,
  `perm_guest_16` tinyint(1) NOT NULL DEFAULT 0,
  `attribute_name` varchar(255) NOT NULL,
  `attribute_desc` varchar(255) DEFAULT NULL,
  `share_parents` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`share_id`),
  KEY `index_mnemo_sharesng_on_share_name` (`share_name`),
  KEY `index_mnemo_sharesng_on_share_owner` (`share_owner`),
  KEY `index_mnemo_sharesng_on_perm_creator_2` (`perm_creator_2`),
  KEY `index_mnemo_sharesng_on_perm_creator_4` (`perm_creator_4`),
  KEY `index_mnemo_sharesng_on_perm_creator_8` (`perm_creator_8`),
  KEY `index_mnemo_sharesng_on_perm_creator_16` (`perm_creator_16`),
  KEY `index_mnemo_sharesng_on_perm_default_2` (`perm_default_2`),
  KEY `index_mnemo_sharesng_on_perm_default_4` (`perm_default_4`),
  KEY `index_mnemo_sharesng_on_perm_default_8` (`perm_default_8`),
  KEY `index_mnemo_sharesng_on_perm_default_16` (`perm_default_16`),
  KEY `index_mnemo_sharesng_on_perm_guest_2` (`perm_guest_2`),
  KEY `index_mnemo_sharesng_on_perm_guest_4` (`perm_guest_4`),
  KEY `index_mnemo_sharesng_on_perm_guest_8` (`perm_guest_8`),
  KEY `index_mnemo_sharesng_on_perm_guest_16` (`perm_guest_16`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mnemo_sharesng`
--

LOCK TABLES `mnemo_sharesng` WRITE;
/*!40000 ALTER TABLE `mnemo_sharesng` DISABLE KEYS */;
/*!40000 ALTER TABLE `mnemo_sharesng` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mnemo_sharesng_groups`
--

DROP TABLE IF EXISTS `mnemo_sharesng_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mnemo_sharesng_groups` (
  `share_id` int(11) NOT NULL,
  `group_uid` varchar(255) NOT NULL,
  `perm_2` tinyint(1) NOT NULL DEFAULT 0,
  `perm_4` tinyint(1) NOT NULL DEFAULT 0,
  `perm_8` tinyint(1) NOT NULL DEFAULT 0,
  `perm_16` tinyint(1) NOT NULL DEFAULT 0,
  KEY `index_mnemo_sharesng_groups_on_share_id` (`share_id`),
  KEY `index_mnemo_sharesng_groups_on_group_uid` (`group_uid`),
  KEY `index_mnemo_sharesng_groups_on_perm_2` (`perm_2`),
  KEY `index_mnemo_sharesng_groups_on_perm_4` (`perm_4`),
  KEY `index_mnemo_sharesng_groups_on_perm_8` (`perm_8`),
  KEY `index_mnemo_sharesng_groups_on_perm_16` (`perm_16`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mnemo_sharesng_groups`
--

LOCK TABLES `mnemo_sharesng_groups` WRITE;
/*!40000 ALTER TABLE `mnemo_sharesng_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `mnemo_sharesng_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mnemo_sharesng_users`
--

DROP TABLE IF EXISTS `mnemo_sharesng_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mnemo_sharesng_users` (
  `share_id` int(11) NOT NULL,
  `user_uid` varchar(255) NOT NULL,
  `perm_2` tinyint(1) NOT NULL DEFAULT 0,
  `perm_4` tinyint(1) NOT NULL DEFAULT 0,
  `perm_8` tinyint(1) NOT NULL DEFAULT 0,
  `perm_16` tinyint(1) NOT NULL DEFAULT 0,
  KEY `index_mnemo_sharesng_users_on_share_id` (`share_id`),
  KEY `index_mnemo_sharesng_users_on_user_uid` (`user_uid`),
  KEY `index_mnemo_sharesng_users_on_perm_2` (`perm_2`),
  KEY `index_mnemo_sharesng_users_on_perm_4` (`perm_4`),
  KEY `index_mnemo_sharesng_users_on_perm_8` (`perm_8`),
  KEY `index_mnemo_sharesng_users_on_perm_16` (`perm_16`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mnemo_sharesng_users`
--

LOCK TABLES `mnemo_sharesng_users` WRITE;
/*!40000 ALTER TABLE `mnemo_sharesng_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `mnemo_sharesng_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nag_schema_info`
--

DROP TABLE IF EXISTS `nag_schema_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nag_schema_info` (
  `version` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nag_schema_info`
--

LOCK TABLES `nag_schema_info` WRITE;
/*!40000 ALTER TABLE `nag_schema_info` DISABLE KEYS */;
REPLACE INTO `nag_schema_info` (`version`) VALUES (14);
/*!40000 ALTER TABLE `nag_schema_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nag_shares`
--

DROP TABLE IF EXISTS `nag_shares`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nag_shares` (
  `share_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `share_name` varchar(255) NOT NULL,
  `share_owner` varchar(255) DEFAULT NULL,
  `share_flags` int(2) NOT NULL DEFAULT 0,
  `perm_creator` int(2) NOT NULL DEFAULT 0,
  `perm_default` int(2) NOT NULL DEFAULT 0,
  `perm_guest` int(2) NOT NULL DEFAULT 0,
  `attribute_name` varchar(255) NOT NULL,
  `attribute_desc` varchar(255) DEFAULT NULL,
  `attribute_color` varchar(7) DEFAULT NULL,
  `share_parents` varchar(4000) DEFAULT NULL,
  `attribute_issmart` int(11) DEFAULT 0,
  `attribute_search` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`share_id`),
  KEY `index_nag_shares_on_share_name` (`share_name`),
  KEY `index_nag_shares_on_share_owner` (`share_owner`),
  KEY `index_nag_shares_on_perm_creator` (`perm_creator`),
  KEY `index_nag_shares_on_perm_default` (`perm_default`),
  KEY `index_nag_shares_on_perm_guest` (`perm_guest`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nag_shares`
--

LOCK TABLES `nag_shares` WRITE;
/*!40000 ALTER TABLE `nag_shares` DISABLE KEYS */;
/*!40000 ALTER TABLE `nag_shares` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nag_shares_groups`
--

DROP TABLE IF EXISTS `nag_shares_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nag_shares_groups` (
  `share_id` int(11) NOT NULL,
  `group_uid` varchar(255) NOT NULL,
  `perm` int(2) NOT NULL,
  KEY `index_nag_shares_groups_on_share_id` (`share_id`),
  KEY `index_nag_shares_groups_on_group_uid` (`group_uid`),
  KEY `index_nag_shares_groups_on_perm` (`perm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nag_shares_groups`
--

LOCK TABLES `nag_shares_groups` WRITE;
/*!40000 ALTER TABLE `nag_shares_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `nag_shares_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nag_shares_users`
--

DROP TABLE IF EXISTS `nag_shares_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nag_shares_users` (
  `share_id` int(11) NOT NULL,
  `user_uid` varchar(255) NOT NULL,
  `perm` int(2) NOT NULL,
  KEY `index_nag_shares_users_on_share_id` (`share_id`),
  KEY `index_nag_shares_users_on_user_uid` (`user_uid`),
  KEY `index_nag_shares_users_on_perm` (`perm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nag_shares_users`
--

LOCK TABLES `nag_shares_users` WRITE;
/*!40000 ALTER TABLE `nag_shares_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `nag_shares_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nag_sharesng`
--

DROP TABLE IF EXISTS `nag_sharesng`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nag_sharesng` (
  `share_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `share_name` varchar(255) NOT NULL,
  `share_owner` varchar(255) DEFAULT NULL,
  `share_flags` int(11) NOT NULL DEFAULT 0,
  `perm_creator_2` tinyint(1) NOT NULL DEFAULT 0,
  `perm_creator_4` tinyint(1) NOT NULL DEFAULT 0,
  `perm_creator_8` tinyint(1) NOT NULL DEFAULT 0,
  `perm_creator_16` tinyint(1) NOT NULL DEFAULT 0,
  `perm_default_2` tinyint(1) NOT NULL DEFAULT 0,
  `perm_default_4` tinyint(1) NOT NULL DEFAULT 0,
  `perm_default_8` tinyint(1) NOT NULL DEFAULT 0,
  `perm_default_16` tinyint(1) NOT NULL DEFAULT 0,
  `perm_guest_2` tinyint(1) NOT NULL DEFAULT 0,
  `perm_guest_4` tinyint(1) NOT NULL DEFAULT 0,
  `perm_guest_8` tinyint(1) NOT NULL DEFAULT 0,
  `perm_guest_16` tinyint(1) NOT NULL DEFAULT 0,
  `attribute_name` varchar(255) NOT NULL,
  `attribute_desc` varchar(255) DEFAULT NULL,
  `attribute_color` varchar(7) DEFAULT NULL,
  `share_parents` varchar(4000) DEFAULT NULL,
  `attribute_issmart` int(11) DEFAULT 0,
  `attribute_search` text DEFAULT NULL,
  PRIMARY KEY (`share_id`),
  KEY `index_nag_sharesng_on_share_name` (`share_name`),
  KEY `index_nag_sharesng_on_share_owner` (`share_owner`),
  KEY `index_nag_sharesng_on_perm_creator_2` (`perm_creator_2`),
  KEY `index_nag_sharesng_on_perm_creator_4` (`perm_creator_4`),
  KEY `index_nag_sharesng_on_perm_creator_8` (`perm_creator_8`),
  KEY `index_nag_sharesng_on_perm_creator_16` (`perm_creator_16`),
  KEY `index_nag_sharesng_on_perm_default_2` (`perm_default_2`),
  KEY `index_nag_sharesng_on_perm_default_4` (`perm_default_4`),
  KEY `index_nag_sharesng_on_perm_default_8` (`perm_default_8`),
  KEY `index_nag_sharesng_on_perm_default_16` (`perm_default_16`),
  KEY `index_nag_sharesng_on_perm_guest_2` (`perm_guest_2`),
  KEY `index_nag_sharesng_on_perm_guest_4` (`perm_guest_4`),
  KEY `index_nag_sharesng_on_perm_guest_8` (`perm_guest_8`),
  KEY `index_nag_sharesng_on_perm_guest_16` (`perm_guest_16`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nag_sharesng`
--

LOCK TABLES `nag_sharesng` WRITE;
/*!40000 ALTER TABLE `nag_sharesng` DISABLE KEYS */;
/*!40000 ALTER TABLE `nag_sharesng` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nag_sharesng_groups`
--

DROP TABLE IF EXISTS `nag_sharesng_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nag_sharesng_groups` (
  `share_id` int(11) NOT NULL,
  `group_uid` varchar(255) NOT NULL,
  `perm_2` tinyint(1) NOT NULL DEFAULT 0,
  `perm_4` tinyint(1) NOT NULL DEFAULT 0,
  `perm_8` tinyint(1) NOT NULL DEFAULT 0,
  `perm_16` tinyint(1) NOT NULL DEFAULT 0,
  KEY `index_nag_sharesng_groups_on_share_id` (`share_id`),
  KEY `index_nag_sharesng_groups_on_group_uid` (`group_uid`),
  KEY `index_nag_sharesng_groups_on_perm_2` (`perm_2`),
  KEY `index_nag_sharesng_groups_on_perm_4` (`perm_4`),
  KEY `index_nag_sharesng_groups_on_perm_8` (`perm_8`),
  KEY `index_nag_sharesng_groups_on_perm_16` (`perm_16`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nag_sharesng_groups`
--

LOCK TABLES `nag_sharesng_groups` WRITE;
/*!40000 ALTER TABLE `nag_sharesng_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `nag_sharesng_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nag_sharesng_users`
--

DROP TABLE IF EXISTS `nag_sharesng_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nag_sharesng_users` (
  `share_id` int(11) NOT NULL,
  `user_uid` varchar(255) NOT NULL,
  `perm_2` tinyint(1) NOT NULL DEFAULT 0,
  `perm_4` tinyint(1) NOT NULL DEFAULT 0,
  `perm_8` tinyint(1) NOT NULL DEFAULT 0,
  `perm_16` tinyint(1) NOT NULL DEFAULT 0,
  KEY `index_nag_sharesng_users_on_share_id` (`share_id`),
  KEY `index_nag_sharesng_users_on_user_uid` (`user_uid`),
  KEY `index_nag_sharesng_users_on_perm_2` (`perm_2`),
  KEY `index_nag_sharesng_users_on_perm_4` (`perm_4`),
  KEY `index_nag_sharesng_users_on_perm_8` (`perm_8`),
  KEY `index_nag_sharesng_users_on_perm_16` (`perm_16`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nag_sharesng_users`
--

LOCK TABLES `nag_sharesng_users` WRITE;
/*!40000 ALTER TABLE `nag_sharesng_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `nag_sharesng_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nag_tasks`
--

DROP TABLE IF EXISTS `nag_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nag_tasks` (
  `task_id` varchar(32) NOT NULL,
  `task_owner` varchar(255) NOT NULL,
  `task_creator` varchar(255) NOT NULL,
  `task_parent` varchar(255) DEFAULT NULL,
  `task_assignee` varchar(255) DEFAULT NULL,
  `task_name` varchar(255) NOT NULL,
  `task_uid` varchar(255) NOT NULL,
  `task_desc` text DEFAULT NULL,
  `task_start` int(11) DEFAULT NULL,
  `task_due` int(11) DEFAULT NULL,
  `task_priority` int(11) NOT NULL DEFAULT 0,
  `task_estimate` float DEFAULT NULL,
  `task_completed` int(1) NOT NULL DEFAULT 0,
  `task_completed_date` int(11) DEFAULT NULL,
  `task_alarm` int(11) NOT NULL DEFAULT 0,
  `task_alarm_methods` text DEFAULT NULL,
  `task_private` int(1) NOT NULL DEFAULT 0,
  `task_recurtype` int(11) DEFAULT 0,
  `task_recurinterval` int(11) DEFAULT NULL,
  `task_recurdays` int(11) DEFAULT NULL,
  `task_recurenddate` datetime DEFAULT NULL,
  `task_recurcount` int(11) DEFAULT NULL,
  `task_exceptions` text DEFAULT NULL,
  `task_completions` text DEFAULT NULL,
  PRIMARY KEY (`task_id`),
  KEY `index_nag_tasks_on_task_owner` (`task_owner`),
  KEY `index_nag_tasks_on_task_uid` (`task_uid`),
  KEY `index_nag_tasks_on_task_start` (`task_start`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nag_tasks`
--

LOCK TABLES `nag_tasks` WRITE;
/*!40000 ALTER TABLE `nag_tasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `nag_tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rampage_objects`
--

DROP TABLE IF EXISTS `rampage_objects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rampage_objects` (
  `object_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `object_name` varchar(255) NOT NULL,
  `type_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`object_id`),
  UNIQUE KEY `rampage_objects_type_object_name` (`type_id`,`object_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rampage_objects`
--

LOCK TABLES `rampage_objects` WRITE;
/*!40000 ALTER TABLE `rampage_objects` DISABLE KEYS */;
/*!40000 ALTER TABLE `rampage_objects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rampage_tag_stats`
--

DROP TABLE IF EXISTS `rampage_tag_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rampage_tag_stats` (
  `tag_id` int(10) unsigned NOT NULL,
  `count` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rampage_tag_stats`
--

LOCK TABLES `rampage_tag_stats` WRITE;
/*!40000 ALTER TABLE `rampage_tag_stats` DISABLE KEYS */;
/*!40000 ALTER TABLE `rampage_tag_stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rampage_tagged`
--

DROP TABLE IF EXISTS `rampage_tagged`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rampage_tagged` (
  `user_id` int(10) unsigned NOT NULL,
  `object_id` int(10) unsigned NOT NULL,
  `tag_id` int(10) unsigned NOT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`user_id`,`object_id`,`tag_id`),
  KEY `rampage_tagged_object_id` (`object_id`),
  KEY `rampage_tagged_tag_id` (`tag_id`),
  KEY `rampage_tagged_created` (`created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rampage_tagged`
--

LOCK TABLES `rampage_tagged` WRITE;
/*!40000 ALTER TABLE `rampage_tagged` DISABLE KEYS */;
/*!40000 ALTER TABLE `rampage_tagged` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rampage_tags`
--

DROP TABLE IF EXISTS `rampage_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rampage_tags` (
  `tag_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tag_name` varchar(255) NOT NULL,
  PRIMARY KEY (`tag_id`),
  UNIQUE KEY `rampage_tags_tag_name` (`tag_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rampage_tags`
--

LOCK TABLES `rampage_tags` WRITE;
/*!40000 ALTER TABLE `rampage_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `rampage_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rampage_types`
--

DROP TABLE IF EXISTS `rampage_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rampage_types` (
  `type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type_name` varchar(255) NOT NULL,
  PRIMARY KEY (`type_id`),
  UNIQUE KEY `rampage_objects_type_name` (`type_name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rampage_types`
--

LOCK TABLES `rampage_types` WRITE;
/*!40000 ALTER TABLE `rampage_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `rampage_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rampage_user_tag_stats`
--

DROP TABLE IF EXISTS `rampage_user_tag_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rampage_user_tag_stats` (
  `user_id` int(10) unsigned NOT NULL,
  `tag_id` int(10) unsigned NOT NULL,
  `count` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`user_id`,`tag_id`),
  KEY `rampage_user_tag_stats_tag_id` (`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rampage_user_tag_stats`
--

LOCK TABLES `rampage_user_tag_stats` WRITE;
/*!40000 ALTER TABLE `rampage_user_tag_stats` DISABLE KEYS */;
/*!40000 ALTER TABLE `rampage_user_tag_stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rampage_users`
--

DROP TABLE IF EXISTS `rampage_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rampage_users` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `rampage_users_user_name` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rampage_users`
--

LOCK TABLES `rampage_users` WRITE;
/*!40000 ALTER TABLE `rampage_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `rampage_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `turba_objects`
--

DROP TABLE IF EXISTS `turba_objects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `turba_objects` (
  `object_id` varchar(32) NOT NULL,
  `owner_id` varchar(255) NOT NULL,
  `object_type` varchar(255) NOT NULL DEFAULT 'Object',
  `object_uid` varchar(255) DEFAULT NULL,
  `object_members` text DEFAULT NULL,
  `object_firstname` varchar(255) DEFAULT NULL,
  `object_lastname` varchar(255) DEFAULT NULL,
  `object_middlenames` varchar(255) DEFAULT NULL,
  `object_nameprefix` varchar(32) DEFAULT NULL,
  `object_namesuffix` varchar(32) DEFAULT NULL,
  `object_alias` varchar(32) DEFAULT NULL,
  `object_photo` longblob DEFAULT NULL,
  `object_phototype` varchar(10) DEFAULT NULL,
  `object_bday` varchar(10) DEFAULT NULL,
  `object_homestreet` varchar(255) DEFAULT NULL,
  `object_homepob` varchar(10) DEFAULT NULL,
  `object_homecity` varchar(255) DEFAULT NULL,
  `object_homeprovince` varchar(255) DEFAULT NULL,
  `object_homepostalcode` varchar(10) DEFAULT NULL,
  `object_homecountry` varchar(255) DEFAULT NULL,
  `object_workstreet` varchar(255) DEFAULT NULL,
  `object_workpob` varchar(10) DEFAULT NULL,
  `object_workcity` varchar(255) DEFAULT NULL,
  `object_workprovince` varchar(255) DEFAULT NULL,
  `object_workpostalcode` varchar(10) DEFAULT NULL,
  `object_workcountry` varchar(255) DEFAULT NULL,
  `object_tz` varchar(32) DEFAULT NULL,
  `object_geo` varchar(255) DEFAULT NULL,
  `object_email` varchar(255) DEFAULT NULL,
  `object_homephone` varchar(25) DEFAULT NULL,
  `object_workphone` varchar(25) DEFAULT NULL,
  `object_cellphone` varchar(25) DEFAULT NULL,
  `object_fax` varchar(25) DEFAULT NULL,
  `object_pager` varchar(25) DEFAULT NULL,
  `object_title` varchar(255) DEFAULT NULL,
  `object_role` varchar(255) DEFAULT NULL,
  `object_logo` longblob DEFAULT NULL,
  `object_logotype` varchar(10) DEFAULT NULL,
  `object_company` varchar(255) DEFAULT NULL,
  `object_notes` text DEFAULT NULL,
  `object_url` varchar(255) DEFAULT NULL,
  `object_freebusyurl` varchar(255) DEFAULT NULL,
  `object_pgppublickey` text DEFAULT NULL,
  `object_smimepublickey` text DEFAULT NULL,
  `object_anniversary` varchar(10) DEFAULT NULL,
  `object_department` varchar(255) DEFAULT NULL,
  `object_spouse` varchar(255) DEFAULT NULL,
  `object_homefax` varchar(25) DEFAULT NULL,
  `object_nickname` varchar(255) DEFAULT NULL,
  `object_assistantphone` varchar(25) DEFAULT NULL,
  `object_imaddress` varchar(255) DEFAULT NULL,
  `object_imaddress2` varchar(255) DEFAULT NULL,
  `object_imaddress3` varchar(255) DEFAULT NULL,
  `object_homephone2` varchar(25) DEFAULT NULL,
  `object_carphone` varchar(25) DEFAULT NULL,
  `object_workphone2` varchar(25) DEFAULT NULL,
  `object_radiophone` varchar(25) DEFAULT NULL,
  `object_companyphone` varchar(25) DEFAULT NULL,
  `object_otherstreet` varchar(255) DEFAULT NULL,
  `object_otherpob` varchar(10) DEFAULT NULL,
  `object_othercity` varchar(255) DEFAULT NULL,
  `object_otherprovince` varchar(255) DEFAULT NULL,
  `object_otherpostalcode` varchar(10) DEFAULT NULL,
  `object_othercountry` varchar(255) DEFAULT NULL,
  `object_yomifirstname` varchar(255) DEFAULT NULL,
  `object_yomilastname` varchar(255) DEFAULT NULL,
  `object_manager` varchar(255) DEFAULT NULL,
  `object_assistant` varchar(255) DEFAULT NULL,
  `object_workemail` varchar(255) DEFAULT NULL,
  `object_homeemail` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`object_id`),
  KEY `index_turba_objects_on_owner_id` (`owner_id`),
  KEY `index_turba_objects_on_object_email` (`object_email`),
  KEY `index_turba_objects_on_object_firstname` (`object_firstname`),
  KEY `index_turba_objects_on_object_lastname` (`object_lastname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turba_objects`
--

LOCK TABLES `turba_objects` WRITE;
/*!40000 ALTER TABLE `turba_objects` DISABLE KEYS */;
/*!40000 ALTER TABLE `turba_objects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `turba_schema_info`
--

DROP TABLE IF EXISTS `turba_schema_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `turba_schema_info` (
  `version` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turba_schema_info`
--

LOCK TABLES `turba_schema_info` WRITE;
/*!40000 ALTER TABLE `turba_schema_info` DISABLE KEYS */;
REPLACE INTO `turba_schema_info` (`version`) VALUES (11);
/*!40000 ALTER TABLE `turba_schema_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `turba_shares`
--

DROP TABLE IF EXISTS `turba_shares`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `turba_shares` (
  `share_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `share_name` varchar(255) NOT NULL,
  `share_owner` varchar(255) NOT NULL,
  `share_flags` int(11) NOT NULL DEFAULT 0,
  `perm_creator` int(11) NOT NULL DEFAULT 0,
  `perm_default` int(11) NOT NULL DEFAULT 0,
  `perm_guest` int(11) NOT NULL DEFAULT 0,
  `attribute_name` varchar(255) NOT NULL,
  `attribute_desc` varchar(255) DEFAULT NULL,
  `attribute_params` text DEFAULT NULL,
  `share_parents` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`share_id`),
  KEY `index_turba_shares_on_share_name` (`share_name`),
  KEY `index_turba_shares_on_share_owner` (`share_owner`),
  KEY `index_turba_shares_on_perm_creator` (`perm_creator`),
  KEY `index_turba_shares_on_perm_default` (`perm_default`),
  KEY `index_turba_shares_on_perm_guest` (`perm_guest`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turba_shares`
--

LOCK TABLES `turba_shares` WRITE;
/*!40000 ALTER TABLE `turba_shares` DISABLE KEYS */;
/*!40000 ALTER TABLE `turba_shares` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `turba_shares_groups`
--

DROP TABLE IF EXISTS `turba_shares_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `turba_shares_groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `share_id` int(11) NOT NULL,
  `group_uid` varchar(255) NOT NULL,
  `perm` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_turba_shares_groups_on_share_id` (`share_id`),
  KEY `index_turba_shares_groups_on_group_uid` (`group_uid`),
  KEY `index_turba_shares_groups_on_perm` (`perm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turba_shares_groups`
--

LOCK TABLES `turba_shares_groups` WRITE;
/*!40000 ALTER TABLE `turba_shares_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `turba_shares_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `turba_shares_users`
--

DROP TABLE IF EXISTS `turba_shares_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `turba_shares_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `share_id` int(11) NOT NULL,
  `user_uid` varchar(255) NOT NULL,
  `perm` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_turba_shares_users_on_share_id` (`share_id`),
  KEY `index_turba_shares_users_on_user_uid` (`user_uid`),
  KEY `index_turba_shares_users_on_perm` (`perm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turba_shares_users`
--

LOCK TABLES `turba_shares_users` WRITE;
/*!40000 ALTER TABLE `turba_shares_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `turba_shares_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `turba_sharesng`
--

DROP TABLE IF EXISTS `turba_sharesng`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `turba_sharesng` (
  `share_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `share_name` varchar(255) NOT NULL,
  `share_owner` varchar(255) DEFAULT NULL,
  `share_flags` int(11) NOT NULL DEFAULT 0,
  `perm_creator_2` tinyint(1) NOT NULL DEFAULT 0,
  `perm_creator_4` tinyint(1) NOT NULL DEFAULT 0,
  `perm_creator_8` tinyint(1) NOT NULL DEFAULT 0,
  `perm_creator_16` tinyint(1) NOT NULL DEFAULT 0,
  `perm_default_2` tinyint(1) NOT NULL DEFAULT 0,
  `perm_default_4` tinyint(1) NOT NULL DEFAULT 0,
  `perm_default_8` tinyint(1) NOT NULL DEFAULT 0,
  `perm_default_16` tinyint(1) NOT NULL DEFAULT 0,
  `perm_guest_2` tinyint(1) NOT NULL DEFAULT 0,
  `perm_guest_4` tinyint(1) NOT NULL DEFAULT 0,
  `perm_guest_8` tinyint(1) NOT NULL DEFAULT 0,
  `perm_guest_16` tinyint(1) NOT NULL DEFAULT 0,
  `attribute_name` varchar(255) NOT NULL,
  `attribute_desc` varchar(255) DEFAULT NULL,
  `attribute_params` text DEFAULT NULL,
  `share_parents` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`share_id`),
  KEY `index_turba_sharesng_on_share_name` (`share_name`),
  KEY `index_turba_sharesng_on_share_owner` (`share_owner`),
  KEY `index_turba_sharesng_on_perm_creator_2` (`perm_creator_2`),
  KEY `index_turba_sharesng_on_perm_creator_4` (`perm_creator_4`),
  KEY `index_turba_sharesng_on_perm_creator_8` (`perm_creator_8`),
  KEY `index_turba_sharesng_on_perm_creator_16` (`perm_creator_16`),
  KEY `index_turba_sharesng_on_perm_default_2` (`perm_default_2`),
  KEY `index_turba_sharesng_on_perm_default_4` (`perm_default_4`),
  KEY `index_turba_sharesng_on_perm_default_8` (`perm_default_8`),
  KEY `index_turba_sharesng_on_perm_default_16` (`perm_default_16`),
  KEY `index_turba_sharesng_on_perm_guest_2` (`perm_guest_2`),
  KEY `index_turba_sharesng_on_perm_guest_4` (`perm_guest_4`),
  KEY `index_turba_sharesng_on_perm_guest_8` (`perm_guest_8`),
  KEY `index_turba_sharesng_on_perm_guest_16` (`perm_guest_16`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turba_sharesng`
--

LOCK TABLES `turba_sharesng` WRITE;
/*!40000 ALTER TABLE `turba_sharesng` DISABLE KEYS */;
/*!40000 ALTER TABLE `turba_sharesng` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `turba_sharesng_groups`
--

DROP TABLE IF EXISTS `turba_sharesng_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `turba_sharesng_groups` (
  `share_id` int(11) NOT NULL,
  `group_uid` varchar(255) NOT NULL,
  `perm_2` tinyint(1) NOT NULL DEFAULT 0,
  `perm_4` tinyint(1) NOT NULL DEFAULT 0,
  `perm_8` tinyint(1) NOT NULL DEFAULT 0,
  `perm_16` tinyint(1) NOT NULL DEFAULT 0,
  KEY `index_turba_sharesng_groups_on_share_id` (`share_id`),
  KEY `index_turba_sharesng_groups_on_group_uid` (`group_uid`),
  KEY `index_turba_sharesng_groups_on_perm_2` (`perm_2`),
  KEY `index_turba_sharesng_groups_on_perm_4` (`perm_4`),
  KEY `index_turba_sharesng_groups_on_perm_8` (`perm_8`),
  KEY `index_turba_sharesng_groups_on_perm_16` (`perm_16`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turba_sharesng_groups`
--

LOCK TABLES `turba_sharesng_groups` WRITE;
/*!40000 ALTER TABLE `turba_sharesng_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `turba_sharesng_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `turba_sharesng_users`
--

DROP TABLE IF EXISTS `turba_sharesng_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `turba_sharesng_users` (
  `share_id` int(11) NOT NULL,
  `user_uid` varchar(255) NOT NULL,
  `perm_2` tinyint(1) NOT NULL DEFAULT 0,
  `perm_4` tinyint(1) NOT NULL DEFAULT 0,
  `perm_8` tinyint(1) NOT NULL DEFAULT 0,
  `perm_16` tinyint(1) NOT NULL DEFAULT 0,
  KEY `index_turba_sharesng_users_on_share_id` (`share_id`),
  KEY `index_turba_sharesng_users_on_user_uid` (`user_uid`),
  KEY `index_turba_sharesng_users_on_perm_2` (`perm_2`),
  KEY `index_turba_sharesng_users_on_perm_4` (`perm_4`),
  KEY `index_turba_sharesng_users_on_perm_8` (`perm_8`),
  KEY `index_turba_sharesng_users_on_perm_16` (`perm_16`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turba_sharesng_users`
--

LOCK TABLES `turba_sharesng_users` WRITE;
/*!40000 ALTER TABLE `turba_sharesng_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `turba_sharesng_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wicked_attachment_history`
--

DROP TABLE IF EXISTS `wicked_attachment_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wicked_attachment_history` (
  `page_id` int(10) unsigned NOT NULL,
  `attachment_name` varchar(100) NOT NULL,
  `attachment_created` int(10) unsigned NOT NULL,
  `change_author` varchar(255) DEFAULT NULL,
  `change_log` text DEFAULT NULL,
  `attachment_version` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`page_id`,`attachment_name`,`attachment_version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wicked_attachment_history`
--

LOCK TABLES `wicked_attachment_history` WRITE;
/*!40000 ALTER TABLE `wicked_attachment_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `wicked_attachment_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wicked_attachments`
--

DROP TABLE IF EXISTS `wicked_attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wicked_attachments` (
  `page_id` int(10) unsigned NOT NULL,
  `attachment_name` varchar(100) NOT NULL,
  `attachment_hits` int(10) unsigned DEFAULT 0,
  `attachment_created` int(10) unsigned NOT NULL,
  `change_author` varchar(255) DEFAULT NULL,
  `change_log` text DEFAULT NULL,
  `attachment_version` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`page_id`,`attachment_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wicked_attachments`
--

LOCK TABLES `wicked_attachments` WRITE;
/*!40000 ALTER TABLE `wicked_attachments` DISABLE KEYS */;
/*!40000 ALTER TABLE `wicked_attachments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wicked_history`
--

DROP TABLE IF EXISTS `wicked_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wicked_history` (
  `page_id` int(10) unsigned NOT NULL,
  `page_name` varchar(100) NOT NULL,
  `page_text` longtext DEFAULT NULL,
  `version_created` int(10) unsigned NOT NULL,
  `change_author` varchar(255) DEFAULT NULL,
  `change_log` text DEFAULT NULL,
  `page_version` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`page_id`,`page_version`),
  KEY `index_wicked_history_on_page_name` (`page_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wicked_history`
--

LOCK TABLES `wicked_history` WRITE;
/*!40000 ALTER TABLE `wicked_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `wicked_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wicked_pages`
--

DROP TABLE IF EXISTS `wicked_pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wicked_pages` (
  `page_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `page_name` varchar(100) NOT NULL,
  `page_text` longtext DEFAULT NULL,
  `page_hits` int(10) unsigned DEFAULT 0,
  `version_created` int(10) unsigned NOT NULL,
  `change_author` varchar(255) DEFAULT NULL,
  `change_log` text DEFAULT NULL,
  `page_version` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`page_id`),
  UNIQUE KEY `index_wicked_pages_on_page_name` (`page_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wicked_pages`
--

LOCK TABLES `wicked_pages` WRITE;
/*!40000 ALTER TABLE `wicked_pages` DISABLE KEYS */;
/*!40000 ALTER TABLE `wicked_pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wicked_schema_info`
--

DROP TABLE IF EXISTS `wicked_schema_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wicked_schema_info` (
  `version` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wicked_schema_info`
--

LOCK TABLES `wicked_schema_info` WRITE;
/*!40000 ALTER TABLE `wicked_schema_info` DISABLE KEYS */;
REPLACE INTO `wicked_schema_info` (`version`) VALUES (6);
/*!40000 ALTER TABLE `wicked_schema_info` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-10-18 22:26:49
