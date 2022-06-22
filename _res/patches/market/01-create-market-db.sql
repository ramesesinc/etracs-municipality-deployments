-- MySQL dump 10.13  Distrib 5.5.59, for Win64 (AMD64)
--
-- Host: localhost    Database: market
-- ------------------------------------------------------
-- Server version	5.5.59

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
-- Current Database: `market`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `market` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `market`;

--
-- Table structure for table `market_abstract_billitem`
--

DROP TABLE IF EXISTS `market_abstract_billitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `market_abstract_billitem` (
  `objid` varchar(50) NOT NULL,
  `billid` varchar(50) DEFAULT NULL,
  `itemid` varchar(50) DEFAULT NULL,
  `amount` decimal(16,2) DEFAULT NULL,
  `amtpaid` decimal(16,2) DEFAULT NULL,
  `remarks` varchar(50) DEFAULT NULL,
  `uid` varchar(200) DEFAULT NULL,
  `auto` int(11) DEFAULT '0',
  `forwarded` int(11) DEFAULT '0',
  PRIMARY KEY (`objid`),
  UNIQUE KEY `uix_market_billitem_billid_uid` (`billid`,`uid`) USING BTREE,
  KEY `fk_market_billitem_itemid` (`itemid`),
  KEY `uix_market_bilitem_acctid_itemid_billscheduleid` (`billid`,`itemid`) USING BTREE,
  CONSTRAINT `fk_market_billitem_billid` FOREIGN KEY (`billid`) REFERENCES `market_bill` (`objid`),
  CONSTRAINT `fk_market_billitem_itemid` FOREIGN KEY (`itemid`) REFERENCES `market_itemaccount` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_abstract_billitem`
--

LOCK TABLES `market_abstract_billitem` WRITE;
/*!40000 ALTER TABLE `market_abstract_billitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `market_abstract_billitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market_account`
--

DROP TABLE IF EXISTS `market_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `market_account` (
  `objid` varchar(50) NOT NULL,
  `state` varchar(10) DEFAULT NULL,
  `acctno` varchar(50) DEFAULT NULL,
  `dtcreated` datetime DEFAULT NULL,
  `createdby_objid` varchar(50) DEFAULT NULL,
  `createdby_name` varchar(255) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `txnmode` varchar(50) DEFAULT NULL,
  `acctinfoid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  UNIQUE KEY `uix_market_account_acctno` (`acctno`) USING BTREE,
  KEY `fk_market_account_acctinfoid` (`acctinfoid`),
  CONSTRAINT `fk_market_account_acctinfoid` FOREIGN KEY (`acctinfoid`) REFERENCES `market_account_info` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_account`
--

LOCK TABLES `market_account` WRITE;
/*!40000 ALTER TABLE `market_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `market_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market_account_info`
--

DROP TABLE IF EXISTS `market_account_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `market_account_info` (
  `objid` varchar(50) NOT NULL,
  `acctid` varchar(50) DEFAULT NULL,
  `acctname` varchar(255) DEFAULT NULL,
  `owner_objid` varchar(50) DEFAULT NULL,
  `owner_name` varchar(255) DEFAULT NULL,
  `owner_address_text` varchar(255) DEFAULT NULL,
  `owner_entitytype` varchar(50) DEFAULT NULL,
  `owner_profileid` varchar(50) DEFAULT NULL,
  `owner_profileno` varchar(50) DEFAULT NULL,
  `owner_firstname` varchar(255) DEFAULT NULL,
  `owner_lastname` varchar(255) DEFAULT NULL,
  `owner_middlename` varchar(255) DEFAULT NULL,
  `owner_resident` smallint(1) DEFAULT NULL,
  `owner_address_objid` varchar(50) DEFAULT NULL,
  `owner_address_unitno` varchar(50) DEFAULT NULL,
  `owner_address_bldgno` varchar(50) DEFAULT NULL,
  `owner_address_bldgname` varchar(255) DEFAULT NULL,
  `owner_address_street` varchar(255) DEFAULT NULL,
  `owner_address_subdivision` varchar(255) DEFAULT NULL,
  `owner_address_barangay_objid` varchar(50) DEFAULT NULL,
  `owner_address_barangay_name` varchar(255) DEFAULT NULL,
  `owner_address_citymunicipality` varchar(255) DEFAULT NULL,
  `owner_address_province` varchar(255) DEFAULT NULL,
  `owner_tin` varchar(255) DEFAULT NULL,
  `owner_email` varchar(255) DEFAULT NULL,
  `owner_mobileno` varchar(50) DEFAULT NULL,
  `owner_phoneno` varchar(50) DEFAULT NULL,
  `owner_id_type_name` varchar(50) DEFAULT NULL,
  `owner_id_idno` varchar(50) DEFAULT NULL,
  `owner_id_placeissued` varchar(255) DEFAULT NULL,
  `owner_id_dtissued` date DEFAULT NULL,
  `contact_mobileno` varchar(50) DEFAULT NULL,
  `contact_email` varchar(255) DEFAULT NULL,
  `contact_phoneno` varchar(50) DEFAULT NULL,
  `unitid` varchar(50) DEFAULT NULL,
  `paymentmode` varchar(50) DEFAULT NULL,
  `business_objid` varchar(50) DEFAULT NULL,
  `business_bin` varchar(50) DEFAULT NULL,
  `business_tradename` varchar(300) DEFAULT NULL,
  `txnid` varchar(50) DEFAULT NULL,
  `txntype` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `fk_market_account_info_acctid` (`acctid`) USING BTREE,
  KEY `fk_market_account_info_unitid` (`unitid`),
  CONSTRAINT `fk_market_account_info_acctid` FOREIGN KEY (`acctid`) REFERENCES `market_account` (`objid`),
  CONSTRAINT `fk_market_account_info_unitid` FOREIGN KEY (`unitid`) REFERENCES `market_rental_unit` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_account_info`
--

LOCK TABLES `market_account_info` WRITE;
/*!40000 ALTER TABLE `market_account_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `market_account_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market_batch_bill`
--

DROP TABLE IF EXISTS `market_batch_bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `market_batch_bill` (
  `objid` varchar(50) NOT NULL,
  `billtype` varchar(50) DEFAULT NULL,
  `billgroupid` varchar(50) DEFAULT NULL,
  `billscheduleid` varchar(50) DEFAULT NULL,
  `batchdate` datetime DEFAULT NULL,
  `taskid` varchar(50) DEFAULT NULL,
  `procstate` int(1) DEFAULT NULL,
  `counter` int(255) DEFAULT NULL,
  `totalcount` int(255) DEFAULT NULL,
  `autopost` int(1) DEFAULT NULL,
  `autogenerate` int(1) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  UNIQUE KEY `uix_market_batch_billtype_centerid_billgroupid_billscheduleid` (`billgroupid`,`billscheduleid`) USING BTREE,
  KEY `fk_market_batchbill_billgroupid` (`billgroupid`) USING BTREE,
  KEY `fk_market_batchbill_billscheduleid` (`billscheduleid`) USING BTREE,
  KEY `fk_market_batchbill_taskid` (`taskid`) USING BTREE,
  CONSTRAINT `fk_market_batch_bill_billgroupid` FOREIGN KEY (`billgroupid`) REFERENCES `market_billgroup` (`objid`),
  CONSTRAINT `fk_market_batch_bill_billscheduleid` FOREIGN KEY (`billscheduleid`) REFERENCES `market_billschedule` (`objid`),
  CONSTRAINT `fk_market_batch_bill_taskid` FOREIGN KEY (`taskid`) REFERENCES `market_batch_bill_task` (`taskid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_batch_bill`
--

LOCK TABLES `market_batch_bill` WRITE;
/*!40000 ALTER TABLE `market_batch_bill` DISABLE KEYS */;
/*!40000 ALTER TABLE `market_batch_bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market_batch_bill_error`
--

DROP TABLE IF EXISTS `market_batch_bill_error`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `market_batch_bill_error` (
  `objid` varchar(50) NOT NULL,
  `batchid` varchar(50) DEFAULT NULL,
  `acctid` varchar(50) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `fk_market_batch_bill_error_batchid` (`batchid`),
  KEY `fk_market_batch_bill_error_acctid` (`acctid`),
  CONSTRAINT `fk_market_batch_bill_error_acctid` FOREIGN KEY (`acctid`) REFERENCES `market_account` (`objid`),
  CONSTRAINT `fk_market_batch_bill_error_batchid` FOREIGN KEY (`batchid`) REFERENCES `market_batch_bill` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_batch_bill_error`
--

LOCK TABLES `market_batch_bill_error` WRITE;
/*!40000 ALTER TABLE `market_batch_bill_error` DISABLE KEYS */;
/*!40000 ALTER TABLE `market_batch_bill_error` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market_batch_bill_task`
--

DROP TABLE IF EXISTS `market_batch_bill_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `market_batch_bill_task` (
  `taskid` varchar(50) NOT NULL,
  `refid` varchar(50) DEFAULT NULL,
  `parentprocessid` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `startdate` datetime DEFAULT NULL,
  `enddate` datetime DEFAULT NULL,
  `assignee_objid` varchar(50) DEFAULT NULL,
  `assignee_name` varchar(100) DEFAULT NULL,
  `actor_objid` varchar(50) DEFAULT NULL,
  `actor_name` varchar(100) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `dtcreated` datetime DEFAULT NULL,
  `prevtaskid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`taskid`) USING BTREE,
  KEY `ix_refid` (`refid`) USING BTREE,
  KEY `ix_parentprocessid` (`parentprocessid`) USING BTREE,
  KEY `ix_startdate` (`startdate`) USING BTREE,
  KEY `ix_enddate` (`enddate`) USING BTREE,
  KEY `ix_assignee_objid` (`assignee_objid`) USING BTREE,
  KEY `ix_actor_objid` (`actor_objid`) USING BTREE,
  KEY `ix_dtcreated` (`dtcreated`) USING BTREE,
  KEY `ix_prevtaskid` (`prevtaskid`) USING BTREE,
  CONSTRAINT `fk_market_batch_bill_task_refid` FOREIGN KEY (`refid`) REFERENCES `market_batch_bill` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_batch_bill_task`
--

LOCK TABLES `market_batch_bill_task` WRITE;
/*!40000 ALTER TABLE `market_batch_bill_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `market_batch_bill_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market_batch_rental_rate`
--

DROP TABLE IF EXISTS `market_batch_rental_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `market_batch_rental_rate` (
  `objid` varchar(50) NOT NULL,
  `startdate` date DEFAULT NULL,
  `state` varchar(20) DEFAULT NULL,
  `createdby_objid` varchar(50) DEFAULT NULL,
  `createdby_name` varchar(255) DEFAULT NULL,
  `dtcreated` datetime DEFAULT NULL,
  `particulars` varchar(255) DEFAULT NULL,
  `rate` decimal(16,2) DEFAULT NULL,
  `ratetype` varchar(50) DEFAULT NULL,
  `fixed` int(1) DEFAULT NULL,
  `frequency` int(2) DEFAULT NULL,
  `enddate` date DEFAULT NULL,
  `nextdate` date DEFAULT NULL,
  `interval` int(255) DEFAULT NULL,
  `centerid` varchar(50) DEFAULT NULL,
  `orgunit` varchar(255) DEFAULT NULL,
  `includeunits` int(1) DEFAULT NULL,
  `units` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `fk_market_batc_rental_rate_centerid` (`centerid`),
  CONSTRAINT `fk_market_batc_rental_rate_centerid` FOREIGN KEY (`centerid`) REFERENCES `market_center` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_batch_rental_rate`
--

LOCK TABLES `market_batch_rental_rate` WRITE;
/*!40000 ALTER TABLE `market_batch_rental_rate` DISABLE KEYS */;
/*!40000 ALTER TABLE `market_batch_rental_rate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market_bill`
--

DROP TABLE IF EXISTS `market_bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `market_bill` (
  `objid` varchar(50) NOT NULL,
  `prevbillid` varchar(50) DEFAULT NULL,
  `billtype` varchar(50) DEFAULT NULL,
  `billno` varchar(50) DEFAULT NULL,
  `billdate` date DEFAULT NULL,
  `lasttxndate` date DEFAULT NULL,
  `validitydate` date DEFAULT NULL,
  `acctid` varchar(50) DEFAULT NULL,
  `acctinfoid` varchar(50) DEFAULT NULL,
  `state` varchar(10) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `balanceforward` decimal(16,2) DEFAULT NULL,
  `totalpayment` decimal(16,2) DEFAULT NULL,
  `interest` decimal(16,2) DEFAULT NULL,
  `surcharge` decimal(16,2) DEFAULT NULL,
  `amount` decimal(16,2) DEFAULT NULL,
  `discount` decimal(16,2) DEFAULT NULL,
  `txnmode` varchar(50) DEFAULT NULL,
  `hold` int(1) DEFAULT NULL,
  `uid` varchar(50) DEFAULT NULL,
  `billscheduleid` varchar(50) DEFAULT NULL,
  `batchid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  UNIQUE KEY `uix_market_bill_billno` (`billno`),
  UNIQUE KEY `uix_market_bill_acctid_billscheduleid` (`acctid`,`billscheduleid`) USING BTREE,
  KEY `fk_market_bill_billscheduleid` (`billscheduleid`),
  KEY `fk_market_bill_acctinfoid` (`acctinfoid`),
  KEY `fk_market_bill_batchid` (`batchid`),
  CONSTRAINT `fk_market_bill_acctid` FOREIGN KEY (`acctid`) REFERENCES `market_account` (`objid`),
  CONSTRAINT `fk_market_bill_acctinfoid` FOREIGN KEY (`acctinfoid`) REFERENCES `market_account_info` (`objid`),
  CONSTRAINT `fk_market_bill_batchid` FOREIGN KEY (`batchid`) REFERENCES `market_batch_bill` (`objid`),
  CONSTRAINT `fk_market_bill_billscheduleid` FOREIGN KEY (`billscheduleid`) REFERENCES `market_billschedule` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_bill`
--

LOCK TABLES `market_bill` WRITE;
/*!40000 ALTER TABLE `market_bill` DISABLE KEYS */;
/*!40000 ALTER TABLE `market_bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market_billgroup`
--

DROP TABLE IF EXISTS `market_billgroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `market_billgroup` (
  `objid` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `billtype` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `tag` varchar(100) DEFAULT NULL,
  `batchid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `fk_market_billgroup_batchid` (`batchid`),
  CONSTRAINT `fk_market_billgroup_batchid` FOREIGN KEY (`batchid`) REFERENCES `market_batch_bill` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_billgroup`
--

LOCK TABLES `market_billgroup` WRITE;
/*!40000 ALTER TABLE `market_billgroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `market_billgroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market_billgroup_unit`
--

DROP TABLE IF EXISTS `market_billgroup_unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `market_billgroup_unit` (
  `objid` varchar(100) NOT NULL,
  `billgroupid` varchar(50) DEFAULT NULL,
  `billtype` varchar(50) DEFAULT NULL,
  `unitid` varchar(50) DEFAULT NULL,
  `state` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  UNIQUE KEY `uix_market_billgroup_unit_unitid_billtype` (`unitid`,`billtype`),
  KEY `fk_market_billgroup_unit_billgroupid` (`billgroupid`),
  CONSTRAINT `fk_market_billgroup_unit_billgroupid` FOREIGN KEY (`billgroupid`) REFERENCES `market_billgroup` (`objid`),
  CONSTRAINT `fk_market_billgroup_unit_unitid` FOREIGN KEY (`unitid`) REFERENCES `market_rental_unit` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_billgroup_unit`
--

LOCK TABLES `market_billgroup_unit` WRITE;
/*!40000 ALTER TABLE `market_billgroup_unit` DISABLE KEYS */;
/*!40000 ALTER TABLE `market_billgroup_unit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market_billitem`
--

DROP TABLE IF EXISTS `market_billitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `market_billitem` (
  `objid` varchar(50) NOT NULL,
  `year` int(4) DEFAULT NULL,
  `month` int(2) DEFAULT NULL,
  `billdate` date DEFAULT NULL,
  `compromiseid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `fk_market_billitem_compromiseid` (`compromiseid`),
  CONSTRAINT `fk_market_billitem_compromiseid` FOREIGN KEY (`compromiseid`) REFERENCES `market_compromise` (`objid`),
  CONSTRAINT `fk_market_billitem_objid` FOREIGN KEY (`objid`) REFERENCES `market_abstract_billitem` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_billitem`
--

LOCK TABLES `market_billitem` WRITE;
/*!40000 ALTER TABLE `market_billitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `market_billitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market_billschedule`
--

DROP TABLE IF EXISTS `market_billschedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `market_billschedule` (
  `objid` varchar(50) NOT NULL,
  `billgroupid` varchar(50) DEFAULT NULL,
  `year` int(4) DEFAULT NULL,
  `month` int(2) DEFAULT NULL,
  `fromdate` date DEFAULT NULL,
  `todate` date DEFAULT NULL,
  `billdate` date DEFAULT NULL,
  `readingdate` date DEFAULT NULL,
  `discdate` date DEFAULT NULL,
  `duedate` date DEFAULT NULL,
  `expirydate` date DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  UNIQUE KEY `uix_market_billschedule_billgroupid_year_month_fromdate` (`billgroupid`,`year`,`month`,`fromdate`),
  KEY `fk_market_billschedule_billgroupid` (`billgroupid`) USING BTREE,
  CONSTRAINT `fk_market_billschedule_billgroupid` FOREIGN KEY (`billgroupid`) REFERENCES `market_billgroup` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_billschedule`
--

LOCK TABLES `market_billschedule` WRITE;
/*!40000 ALTER TABLE `market_billschedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `market_billschedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market_center`
--

DROP TABLE IF EXISTS `market_center`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `market_center` (
  `objid` varchar(50) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `address_text` varchar(255) DEFAULT NULL,
  `address_unitno` varchar(20) DEFAULT NULL,
  `address_bldgno` varchar(20) DEFAULT NULL,
  `address_bldgname` varchar(50) DEFAULT NULL,
  `address_street` varchar(50) DEFAULT NULL,
  `address_subdivision` varchar(50) DEFAULT NULL,
  `address_barangay_objid` varchar(50) DEFAULT NULL,
  `address_barangay_name` varchar(255) DEFAULT NULL,
  `address_citymunicipality` varchar(100) DEFAULT NULL,
  `address_province` varchar(50) DEFAULT NULL,
  `contactinfo` varchar(255) DEFAULT NULL,
  `controlcode` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_center`
--

LOCK TABLES `market_center` WRITE;
/*!40000 ALTER TABLE `market_center` DISABLE KEYS */;
/*!40000 ALTER TABLE `market_center` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market_changeapp`
--

DROP TABLE IF EXISTS `market_changeapp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `market_changeapp` (
  `objid` varchar(50) NOT NULL,
  `appno` varchar(50) DEFAULT NULL,
  `apptype` varchar(50) DEFAULT NULL,
  `dtcreated` datetime DEFAULT NULL,
  `createdby_objid` varchar(50) DEFAULT NULL,
  `createdby_name` varchar(255) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `acctid` varchar(50) DEFAULT NULL,
  `oldacctinfoid` varchar(50) DEFAULT NULL,
  `newacctinfoid` varchar(50) DEFAULT NULL,
  `taskid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  UNIQUE KEY `uix_market_account_appno` (`appno`) USING BTREE,
  KEY `fk_market_account_acctinfoid` (`oldacctinfoid`),
  KEY `fk_market_changeapp_newinfoid` (`newacctinfoid`),
  KEY `fk_market_changeapp_acctid` (`acctid`),
  KEY `fk_market_changeapp_taskid` (`taskid`),
  CONSTRAINT `fk_market_changeapp_acctid` FOREIGN KEY (`acctid`) REFERENCES `market_account` (`objid`),
  CONSTRAINT `fk_market_changeapp_newinfoid` FOREIGN KEY (`newacctinfoid`) REFERENCES `market_account_info` (`objid`),
  CONSTRAINT `fk_market_changeapp_oldinfoid` FOREIGN KEY (`oldacctinfoid`) REFERENCES `market_account_info` (`objid`),
  CONSTRAINT `fk_market_changeapp_taskid` FOREIGN KEY (`taskid`) REFERENCES `market_changeapp_task` (`taskid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_changeapp`
--

LOCK TABLES `market_changeapp` WRITE;
/*!40000 ALTER TABLE `market_changeapp` DISABLE KEYS */;
/*!40000 ALTER TABLE `market_changeapp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market_changeapp_task`
--

DROP TABLE IF EXISTS `market_changeapp_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `market_changeapp_task` (
  `taskid` varchar(50) NOT NULL,
  `refid` varchar(50) DEFAULT NULL,
  `parentprocessid` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `startdate` datetime DEFAULT NULL,
  `enddate` datetime DEFAULT NULL,
  `assignee_objid` varchar(50) DEFAULT NULL,
  `assignee_name` varchar(100) DEFAULT NULL,
  `actor_objid` varchar(50) DEFAULT NULL,
  `actor_name` varchar(100) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `dtcreated` datetime DEFAULT NULL,
  `prevtaskid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`taskid`) USING BTREE,
  KEY `ix_refid` (`refid`) USING BTREE,
  KEY `ix_parentprocessid` (`parentprocessid`) USING BTREE,
  KEY `ix_startdate` (`startdate`) USING BTREE,
  KEY `ix_enddate` (`enddate`) USING BTREE,
  KEY `ix_assignee_objid` (`assignee_objid`) USING BTREE,
  KEY `ix_actor_objid` (`actor_objid`) USING BTREE,
  KEY `ix_dtcreated` (`dtcreated`) USING BTREE,
  KEY `ix_prevtaskid` (`prevtaskid`) USING BTREE,
  CONSTRAINT `fk_market_changeapp_task_refid` FOREIGN KEY (`refid`) REFERENCES `market_changeapp` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_changeapp_task`
--

LOCK TABLES `market_changeapp_task` WRITE;
/*!40000 ALTER TABLE `market_changeapp_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `market_changeapp_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market_compromise`
--

DROP TABLE IF EXISTS `market_compromise`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `market_compromise` (
  `objid` varchar(50) NOT NULL,
  `acctid` varchar(50) DEFAULT NULL,
  `controlno` varchar(50) DEFAULT NULL,
  `controldate` date DEFAULT NULL,
  `billid` varchar(50) DEFAULT NULL,
  `amount` decimal(16,2) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `creditmemoid` varchar(50) DEFAULT NULL,
  `amtbilled` decimal(16,2) DEFAULT NULL,
  `term` int(2) DEFAULT NULL,
  `itemid` varchar(50) DEFAULT NULL,
  `particulars` mediumtext,
  `tobilldate` date DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `fk_market_compromise_billid` (`billid`),
  KEY `fk_market_compromise_itemid` (`itemid`),
  KEY `fk_market_compromise_postcreditd` (`creditmemoid`),
  CONSTRAINT `fk_market_compromise_billid` FOREIGN KEY (`billid`) REFERENCES `market_bill` (`objid`),
  CONSTRAINT `fk_market_compromise_itemid` FOREIGN KEY (`itemid`) REFERENCES `market_itemaccount` (`objid`),
  CONSTRAINT `fk_market_compromise_postcreditd` FOREIGN KEY (`creditmemoid`) REFERENCES `market_payment` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_compromise`
--

LOCK TABLES `market_compromise` WRITE;
/*!40000 ALTER TABLE `market_compromise` DISABLE KEYS */;
/*!40000 ALTER TABLE `market_compromise` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market_credit`
--

DROP TABLE IF EXISTS `market_credit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `market_credit` (
  `objid` varchar(50) NOT NULL,
  `acctid` varchar(50) DEFAULT NULL,
  `billid` varchar(50) DEFAULT NULL,
  `paymentrefid` varchar(50) DEFAULT NULL,
  `particulars` varchar(255) DEFAULT NULL,
  `refid` varchar(50) DEFAULT NULL,
  `itemid` varchar(50) DEFAULT NULL,
  `dr` decimal(16,2) DEFAULT NULL,
  `cr` decimal(16,2) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `fk_market_rental_month_billid` (`acctid`) USING BTREE,
  KEY `fk_market_rental_month_itemid` (`itemid`) USING BTREE,
  KEY `market_credit_itemid` (`itemid`) USING BTREE,
  KEY `market_credit_paymentrefid` (`paymentrefid`),
  CONSTRAINT `market_credit_acctid` FOREIGN KEY (`acctid`) REFERENCES `market_account` (`objid`),
  CONSTRAINT `market_credit_itemid` FOREIGN KEY (`itemid`) REFERENCES `market_itemaccount` (`objid`),
  CONSTRAINT `market_credit_paymentrefid` FOREIGN KEY (`paymentrefid`) REFERENCES `market_payment` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_credit`
--

LOCK TABLES `market_credit` WRITE;
/*!40000 ALTER TABLE `market_credit` DISABLE KEYS */;
/*!40000 ALTER TABLE `market_credit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market_credit_billitem`
--

DROP TABLE IF EXISTS `market_credit_billitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `market_credit_billitem` (
  `objid` varchar(50) NOT NULL,
  `paymentid` varchar(50) DEFAULT NULL,
  `creditmemoid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `fk_market_credit_billitem_paymentid` (`paymentid`),
  KEY `fk_market_credit_billitem_creditmemoid` (`creditmemoid`),
  CONSTRAINT `fk_market_credit_billitem_creditmemoid` FOREIGN KEY (`creditmemoid`) REFERENCES `market_payment_bill` (`objid`),
  CONSTRAINT `fk_market_credit_billitem_objid` FOREIGN KEY (`objid`) REFERENCES `market_abstract_billitem` (`objid`),
  CONSTRAINT `fk_market_credit_billitem_paymentid` FOREIGN KEY (`paymentid`) REFERENCES `market_payment_bill` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_credit_billitem`
--

LOCK TABLES `market_credit_billitem` WRITE;
/*!40000 ALTER TABLE `market_credit_billitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `market_credit_billitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market_electricity_bill`
--

DROP TABLE IF EXISTS `market_electricity_bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `market_electricity_bill` (
  `objid` varchar(50) NOT NULL,
  `subacctid` varchar(50) DEFAULT NULL,
  `initialreading` int(255) DEFAULT NULL,
  `reading` int(255) DEFAULT NULL,
  `readingdate` date DEFAULT NULL,
  `reader_objid` varchar(50) DEFAULT NULL,
  `volume` int(255) DEFAULT NULL,
  `rate` decimal(16,2) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `fk_market_utility_consumption_reader_objid` (`reader_objid`) USING BTREE,
  KEY `fk_market_electricity_bill_subacctid` (`subacctid`),
  CONSTRAINT `fk_market_electricity_bill_objid` FOREIGN KEY (`objid`) REFERENCES `market_bill` (`objid`),
  CONSTRAINT `fk_market_electricity_bill_reader_objid` FOREIGN KEY (`reader_objid`) REFERENCES `sys_user` (`objid`),
  CONSTRAINT `fk_market_electricity_bill_subacctid` FOREIGN KEY (`subacctid`) REFERENCES `market_electricity_subaccount` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_electricity_bill`
--

LOCK TABLES `market_electricity_bill` WRITE;
/*!40000 ALTER TABLE `market_electricity_bill` DISABLE KEYS */;
/*!40000 ALTER TABLE `market_electricity_bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market_electricity_subaccount`
--

DROP TABLE IF EXISTS `market_electricity_subaccount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `market_electricity_subaccount` (
  `objid` varchar(255) NOT NULL,
  `state` varchar(50) DEFAULT NULL,
  `acctno` varchar(50) DEFAULT NULL,
  `acctid` varchar(50) DEFAULT NULL,
  `unitid` varchar(50) DEFAULT NULL,
  `capacity` int(10) DEFAULT NULL,
  `currentreading` int(10) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  UNIQUE KEY `uix_market_electricity_subaccount_acctid_unitid` (`acctid`,`unitid`),
  KEY `fk_market_electricity_subaccount_acctid` (`acctid`) USING BTREE,
  CONSTRAINT `market_electricity_subaccount_ibfk_1` FOREIGN KEY (`acctid`) REFERENCES `market_account` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_electricity_subaccount`
--

LOCK TABLES `market_electricity_subaccount` WRITE;
/*!40000 ALTER TABLE `market_electricity_subaccount` DISABLE KEYS */;
/*!40000 ALTER TABLE `market_electricity_subaccount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market_itemaccount`
--

DROP TABLE IF EXISTS `market_itemaccount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `market_itemaccount` (
  `objid` varchar(50) NOT NULL,
  `title` varchar(50) DEFAULT NULL,
  `item_objid` varchar(50) DEFAULT NULL,
  `item_code` varchar(50) DEFAULT NULL,
  `item_title` varchar(255) DEFAULT NULL,
  `item_fund_objid` varchar(50) DEFAULT NULL,
  `item_fund_title` varchar(50) DEFAULT NULL,
  `sortorder` int(10) DEFAULT NULL,
  `itemtype` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_itemaccount`
--

LOCK TABLES `market_itemaccount` WRITE;
/*!40000 ALTER TABLE `market_itemaccount` DISABLE KEYS */;
INSERT INTO `market_itemaccount` VALUES ('CUSA','COMMON USAGE AREA',NULL,NULL,NULL,NULL,NULL,11,'RENTAL'),('MARKET_ADVANCE','MARKET ADVANCE PAYMENT',NULL,NULL,NULL,NULL,NULL,1,'RENTAL'),('MARKET_ELECTRICITY_FEE','MARKET ELECTRICITY FEE',NULL,NULL,NULL,NULL,NULL,2,NULL),('MARKET_FEE','MARKET FEE',NULL,NULL,NULL,NULL,NULL,10,'RENTAL'),('MARKET_INSTALLMENT_FEE','MARKET INSTALLMENT FEE',NULL,NULL,NULL,NULL,NULL,10,'COMPROMISE'),('MARKET_RENTAL_INTEREST','MARKET RENTAL INTEREST',NULL,NULL,NULL,NULL,NULL,200,'INTEREST'),('MARKET_RENTAL_SURCHARGE','MARKET RENTAL SURCHARGE',NULL,NULL,NULL,NULL,NULL,100,'SURCHARGE'),('MARKET_WATER_FEE','MARKET WATER FEE',NULL,NULL,NULL,NULL,NULL,2,NULL),('MARKET_WATER_INTEREST','MARKET WATER INTEREST',NULL,NULL,NULL,NULL,NULL,1,'INTEREST');
/*!40000 ALTER TABLE `market_itemaccount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market_orgunit`
--

DROP TABLE IF EXISTS `market_orgunit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `market_orgunit` (
  `objid` varchar(50) NOT NULL,
  `centerid` varchar(50) DEFAULT NULL,
  `parentid` varchar(50) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `leftindex` int(5) DEFAULT NULL,
  `rightindex` int(5) DEFAULT NULL,
  `fullpath` varchar(500) DEFAULT NULL,
  `uid` int(100) NOT NULL,
  `controlcode` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `objid` (`objid`),
  KEY `fk_market_orgunit_centerid` (`centerid`),
  KEY `fk_market_orgunit_parentid` (`parentid`),
  KEY `uix_market_orgunit_uid` (`uid`) USING BTREE,
  CONSTRAINT `fk_market_orgunit_centerid` FOREIGN KEY (`centerid`) REFERENCES `market_center` (`objid`),
  CONSTRAINT `fk_market_orgunit_parentid` FOREIGN KEY (`parentid`) REFERENCES `market_orgunit` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_orgunit`
--

LOCK TABLES `market_orgunit` WRITE;
/*!40000 ALTER TABLE `market_orgunit` DISABLE KEYS */;
/*!40000 ALTER TABLE `market_orgunit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market_payment`
--

DROP TABLE IF EXISTS `market_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `market_payment` (
  `objid` varchar(50) NOT NULL,
  `refid` varchar(50) DEFAULT NULL,
  `refno` varchar(50) DEFAULT NULL,
  `reftype` varchar(50) DEFAULT NULL,
  `refdate` date DEFAULT NULL,
  `txnmode` varchar(50) DEFAULT NULL,
  `voided` int(255) DEFAULT NULL,
  `amount` decimal(16,2) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_payment`
--

LOCK TABLES `market_payment` WRITE;
/*!40000 ALTER TABLE `market_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `market_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market_payment_bill`
--

DROP TABLE IF EXISTS `market_payment_bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `market_payment_bill` (
  `objid` varchar(50) NOT NULL,
  `parentid` varchar(50) DEFAULT NULL,
  `billid` varchar(50) DEFAULT NULL,
  `amount` decimal(16,2) DEFAULT NULL,
  `discount` decimal(16,2) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `fk_market_payment_bill_billid` (`billid`),
  KEY `fk_market_payment_bill_parentid` (`parentid`),
  CONSTRAINT `fk_market_payment_bill_billid` FOREIGN KEY (`billid`) REFERENCES `market_bill` (`objid`),
  CONSTRAINT `fk_market_payment_bill_parentid` FOREIGN KEY (`parentid`) REFERENCES `market_payment` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_payment_bill`
--

LOCK TABLES `market_payment_bill` WRITE;
/*!40000 ALTER TABLE `market_payment_bill` DISABLE KEYS */;
/*!40000 ALTER TABLE `market_payment_bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market_payment_item`
--

DROP TABLE IF EXISTS `market_payment_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `market_payment_item` (
  `objid` varchar(50) NOT NULL,
  `parentid` varchar(50) DEFAULT NULL,
  `billitemid` varchar(50) DEFAULT NULL,
  `amount` decimal(16,2) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `fk_market_payment_item_parentid` (`parentid`) USING BTREE,
  KEY `fk_market_paymentitem_billitemid` (`billitemid`),
  CONSTRAINT `fk_market_paymentitem_billitemid` FOREIGN KEY (`billitemid`) REFERENCES `market_abstract_billitem` (`objid`),
  CONSTRAINT `fk_market_paymentitem_parentid` FOREIGN KEY (`parentid`) REFERENCES `market_payment_bill` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_payment_item`
--

LOCK TABLES `market_payment_item` WRITE;
/*!40000 ALTER TABLE `market_payment_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `market_payment_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market_penalty_billitem`
--

DROP TABLE IF EXISTS `market_penalty_billitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `market_penalty_billitem` (
  `objid` varchar(50) NOT NULL,
  `billdate` date DEFAULT NULL,
  `billitemrefid` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `fk_market_penalty_billitem_billitemrefid` (`billitemrefid`),
  CONSTRAINT `fk_market_penalty_billitem_billitemrefid` FOREIGN KEY (`billitemrefid`) REFERENCES `market_abstract_billitem` (`objid`),
  CONSTRAINT `fk_market_penalty_billitem_objid` FOREIGN KEY (`objid`) REFERENCES `market_abstract_billitem` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_penalty_billitem`
--

LOCK TABLES `market_penalty_billitem` WRITE;
/*!40000 ALTER TABLE `market_penalty_billitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `market_penalty_billitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market_recurringfee`
--

DROP TABLE IF EXISTS `market_recurringfee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `market_recurringfee` (
  `objid` varchar(50) NOT NULL,
  `acctid` varchar(50) DEFAULT NULL,
  `itemid` varchar(50) DEFAULT NULL,
  `amount` decimal(16,2) DEFAULT NULL,
  `recurtype` varchar(50) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `fk_market_recurringfee_acctid` (`acctid`),
  KEY `fk_market_recurringfee_itemid` (`itemid`),
  CONSTRAINT `fk_market_recurringfee_acctid` FOREIGN KEY (`acctid`) REFERENCES `market_account` (`objid`),
  CONSTRAINT `fk_market_recurringfee_itemid` FOREIGN KEY (`itemid`) REFERENCES `market_itemaccount` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_recurringfee`
--

LOCK TABLES `market_recurringfee` WRITE;
/*!40000 ALTER TABLE `market_recurringfee` DISABLE KEYS */;
/*!40000 ALTER TABLE `market_recurringfee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market_rental_bill`
--

DROP TABLE IF EXISTS `market_rental_bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `market_rental_bill` (
  `objid` varchar(50) NOT NULL,
  `rateid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `fk_market_rental_bill_rateid` (`rateid`),
  CONSTRAINT `fk_market_rental_bill_rateid` FOREIGN KEY (`rateid`) REFERENCES `market_rental_rate` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_rental_bill`
--

LOCK TABLES `market_rental_bill` WRITE;
/*!40000 ALTER TABLE `market_rental_bill` DISABLE KEYS */;
/*!40000 ALTER TABLE `market_rental_bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market_rental_rate`
--

DROP TABLE IF EXISTS `market_rental_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `market_rental_rate` (
  `objid` varchar(50) NOT NULL,
  `unitid` varchar(50) DEFAULT NULL,
  `rate` decimal(16,2) DEFAULT NULL,
  `ratetype` varchar(50) DEFAULT NULL,
  `effectivedate` date DEFAULT NULL,
  `createdby_objid` varchar(50) DEFAULT NULL,
  `createdby_name` varchar(100) DEFAULT NULL,
  `dtcreated` datetime DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `batchid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `fk_market_rental_rate_unitid` (`unitid`),
  KEY `fk_market_rental_rate_batchid` (`batchid`),
  CONSTRAINT `fk_market_rental_rate_batchid` FOREIGN KEY (`batchid`) REFERENCES `market_batch_rental_rate` (`objid`),
  CONSTRAINT `fk_market_rental_rate_unitid` FOREIGN KEY (`unitid`) REFERENCES `market_rental_unit` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_rental_rate`
--

LOCK TABLES `market_rental_rate` WRITE;
/*!40000 ALTER TABLE `market_rental_rate` DISABLE KEYS */;
/*!40000 ALTER TABLE `market_rental_rate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market_rental_unit`
--

DROP TABLE IF EXISTS `market_rental_unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `market_rental_unit` (
  `objid` varchar(50) NOT NULL,
  `state` varchar(50) DEFAULT NULL,
  `centerid` varchar(50) DEFAULT NULL,
  `orgunitid` varchar(50) DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `unittype` varchar(50) DEFAULT NULL,
  `currentacctid` varchar(50) DEFAULT NULL,
  `indexno` int(11) DEFAULT NULL,
  `areasqm` decimal(16,2) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `fk_market_rental_unit_orgid` (`centerid`) USING BTREE,
  KEY `uix_market_rental_unit_centerid_code` (`centerid`,`code`),
  KEY `fk_market_rental_unit_currentacctid` (`currentacctid`),
  KEY `fk_market_rental_unit_orgunitid` (`orgunitid`),
  CONSTRAINT `fk_market_rental_unit_centerid` FOREIGN KEY (`centerid`) REFERENCES `market_center` (`objid`),
  CONSTRAINT `fk_market_rental_unit_currentacctid` FOREIGN KEY (`currentacctid`) REFERENCES `market_account` (`objid`),
  CONSTRAINT `fk_market_rental_unit_orgunitid` FOREIGN KEY (`orgunitid`) REFERENCES `market_orgunit` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_rental_unit`
--

LOCK TABLES `market_rental_unit` WRITE;
/*!40000 ALTER TABLE `market_rental_unit` DISABLE KEYS */;
/*!40000 ALTER TABLE `market_rental_unit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market_rental_unit_type`
--

DROP TABLE IF EXISTS `market_rental_unit_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `market_rental_unit_type` (
  `objid` varchar(50) NOT NULL,
  PRIMARY KEY (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_rental_unit_type`
--

LOCK TABLES `market_rental_unit_type` WRITE;
/*!40000 ALTER TABLE `market_rental_unit_type` DISABLE KEYS */;
INSERT INTO `market_rental_unit_type` VALUES ('BLOCK'),('SPACE'),('STALL'),('TABLE'),('TILE');
/*!40000 ALTER TABLE `market_rental_unit_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market_water_bill`
--

DROP TABLE IF EXISTS `market_water_bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `market_water_bill` (
  `objid` varchar(50) NOT NULL,
  `subacctid` varchar(50) DEFAULT NULL,
  `initialreading` int(255) DEFAULT NULL,
  `reading` int(255) DEFAULT NULL,
  `readingdate` date DEFAULT NULL,
  `reader_objid` varchar(50) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `volume` int(255) DEFAULT NULL,
  `rate` decimal(16,2) DEFAULT NULL,
  `uix` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `fk_market_utility_consumption_reader_objid` (`reader_objid`) USING BTREE,
  KEY `fk_market_water_bill_subacctid` (`subacctid`),
  CONSTRAINT `fk_market_water_bill_objid` FOREIGN KEY (`objid`) REFERENCES `market_bill` (`objid`),
  CONSTRAINT `fk_market_water_bill_reader_objid` FOREIGN KEY (`reader_objid`) REFERENCES `sys_user` (`objid`),
  CONSTRAINT `fk_market_water_bill_subacctid` FOREIGN KEY (`subacctid`) REFERENCES `market_water_subaccount` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_water_bill`
--

LOCK TABLES `market_water_bill` WRITE;
/*!40000 ALTER TABLE `market_water_bill` DISABLE KEYS */;
/*!40000 ALTER TABLE `market_water_bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `market_water_subaccount`
--

DROP TABLE IF EXISTS `market_water_subaccount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `market_water_subaccount` (
  `objid` varchar(255) NOT NULL,
  `state` varchar(50) DEFAULT NULL,
  `acctno` varchar(50) DEFAULT NULL,
  `acctid` varchar(50) DEFAULT NULL,
  `unitid` varchar(50) DEFAULT NULL,
  `capacity` int(10) DEFAULT NULL,
  `currentreading` int(10) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  UNIQUE KEY `uix_market_water_subaccount_acctid_unitid` (`acctid`,`unitid`) USING BTREE,
  KEY `fk_market_water_subaccount_acctid` (`acctid`) USING BTREE,
  CONSTRAINT `fk_market_water_subaccount_acctid` FOREIGN KEY (`acctid`) REFERENCES `market_account` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `market_water_subaccount`
--

LOCK TABLES `market_water_subaccount` WRITE;
/*!40000 ALTER TABLE `market_water_subaccount` DISABLE KEYS */;
/*!40000 ALTER TABLE `market_water_subaccount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_email_queue`
--

DROP TABLE IF EXISTS `sys_email_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_email_queue` (
  `objid` varchar(50) NOT NULL,
  `refid` varchar(50) DEFAULT NULL,
  `state` int(1) DEFAULT NULL,
  `reportid` varchar(50) DEFAULT NULL,
  `dtsent` datetime DEFAULT NULL,
  `to` varchar(255) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `message` mediumtext,
  `errmsg` varchar(255) DEFAULT NULL,
  `connection` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_email_queue`
--

LOCK TABLES `sys_email_queue` WRITE;
/*!40000 ALTER TABLE `sys_email_queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_email_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_email_template`
--

DROP TABLE IF EXISTS `sys_email_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_email_template` (
  `objid` varchar(50) NOT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `message` mediumtext,
  PRIMARY KEY (`objid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_email_template`
--

LOCK TABLES `sys_email_template` WRITE;
/*!40000 ALTER TABLE `sys_email_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_email_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_report_def`
--

DROP TABLE IF EXISTS `sys_report_def`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_report_def` (
  `name` varchar(100) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `template` varchar(255) DEFAULT NULL,
  `reportheader` varchar(100) DEFAULT NULL,
  `role` varchar(50) DEFAULT NULL,
  `sortorder` int(4) DEFAULT NULL,
  `statement` mediumtext,
  `permission` varchar(100) DEFAULT NULL,
  `parameters` mediumtext,
  `querytype` varchar(50) DEFAULT NULL,
  `state` varchar(10) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `properties` mediumtext,
  PRIMARY KEY (`name`) USING BTREE,
  KEY `fk_sys_report_def_template` (`template`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_report_def`
--

LOCK TABLES `sys_report_def` WRITE;
/*!40000 ALTER TABLE `sys_report_def` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_report_def` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_report_template`
--

DROP TABLE IF EXISTS `sys_report_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_report_template` (
  `name` varchar(100) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `filepath` varchar(255) NOT NULL,
  `master` int(1) DEFAULT NULL,
  `icon` mediumblob,
  PRIMARY KEY (`name`),
  UNIQUE KEY `uix_sys_report_template_filepath` (`filepath`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_report_template`
--

LOCK TABLES `sys_report_template` WRITE;
/*!40000 ALTER TABLE `sys_report_template` DISABLE KEYS */;
INSERT INTO `sys_report_template` VALUES ('blank','Blank Report','/master-templates/blank.jrxml',1,NULL);
/*!40000 ALTER TABLE `sys_report_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role`
--

DROP TABLE IF EXISTS `sys_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role` (
  `name` varchar(50) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `system` int(1) DEFAULT NULL,
  PRIMARY KEY (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES ('ADMIN','MARKET ADMIN',NULL),('BILLER','MARKET BILLER',NULL),('INFO','INFO',0),('MASTER','MARKET MASTER',NULL),('PROCESSOR','PROCESSOR',0),('REPORT_EDITOR','REPORT EDITOR',0),('RULE_AUTHOR','MARKET RULE AUTHOR',NULL),('SYSTEM','SYSTEM',0),('WF_EDITOR','MARKET WF EDITOR',NULL);
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_permission`
--

DROP TABLE IF EXISTS `sys_role_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role_permission` (
  `objid` varchar(100) NOT NULL,
  `role` varchar(50) DEFAULT NULL,
  `object` varchar(25) DEFAULT NULL,
  `permission` varchar(25) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `fk_sys_role_permission_role` (`role`) USING BTREE,
  CONSTRAINT `fk_sys_role_permission_role` FOREIGN KEY (`role`) REFERENCES `sys_role` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_permission`
--

LOCK TABLES `sys_role_permission` WRITE;
/*!40000 ALTER TABLE `sys_role_permission` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_role_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_rule`
--

DROP TABLE IF EXISTS `sys_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_rule` (
  `objid` varchar(50) NOT NULL,
  `state` varchar(25) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `ruleset` varchar(50) NOT NULL,
  `rulegroup` varchar(50) DEFAULT NULL,
  `title` varchar(250) DEFAULT NULL,
  `description` longtext,
  `salience` int(11) DEFAULT NULL,
  `effectivefrom` date DEFAULT NULL,
  `effectiveto` date DEFAULT NULL,
  `dtfiled` datetime DEFAULT NULL,
  `user_objid` varchar(50) DEFAULT NULL,
  `user_name` varchar(100) DEFAULT NULL,
  `noloop` int(11) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `rulegroup` (`rulegroup`,`ruleset`) USING BTREE,
  KEY `ruleset` (`ruleset`) USING BTREE,
  CONSTRAINT `sys_rule_ibfk_1` FOREIGN KEY (`rulegroup`, `ruleset`) REFERENCES `sys_rulegroup` (`name`, `ruleset`),
  CONSTRAINT `sys_rule_ibfk_2` FOREIGN KEY (`ruleset`) REFERENCES `sys_ruleset` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_rule`
--

LOCK TABLES `sys_rule` WRITE;
/*!40000 ALTER TABLE `sys_rule` DISABLE KEYS */;
INSERT INTO `sys_rule` VALUES ('RUL-15ffadb8:17d2c8dcc4f:-7250','DRAFT','MARKET_RENTAL_SURCHARGE','marketpayment','map-account','MARKET_RENTAL_SURCHARGE',NULL,50000,NULL,NULL,'2021-11-17 15:28:43','USR-1b82c604:14cc29913bb:-7fec','ADMIN',1),('RUL-1642179f:1805e7640a3:-6bfa','DRAFT','REMOVE_BILL_2020_MAR_TO_DEC','marketbilling','summary','REMOVE DUE TO COVID',NULL,50000,NULL,NULL,'2022-04-25 11:38:57','USR-1b82c604:14cc29913bb:-7fec','ADMIN',1),('RUL-63b19689:17ef6d330a9:-7391','DRAFT','ADD_MONTHLY_SURCHARGE','marketbilling','compute-surcharge','ADD MONTHLY SURCHARGE',NULL,50000,NULL,NULL,'2022-02-14 14:37:10','USR-1b82c604:14cc29913bb:-7fec','ADMIN',1),('RUL214dddab:17a7631e40f:-78e9','DRAFT','APPLY_PAYMENT','marketpayment','apply-payment','Apply Payment',NULL,50000,NULL,NULL,'2021-07-05 18:26:29','USR-ADMIN','ADMIN',1),('RUL2e766257:18027a1b666:-6c6a','DRAFT','COMPUTE_INTEREST','marketbilling','compute-interest','compute interest',NULL,50000,NULL,NULL,'2022-04-15 21:35:46','USR-1b82c604:14cc29913bb:-7fec','ADMIN',1),('RUL2e766257:18027a1b666:-78b6','DRAFT','UPDATE_VALIDITY_DATE','marketbilling','summary','UPDATE VALIDITY DATE',NULL,50000,NULL,NULL,'2022-04-15 19:46:12','USR-1b82c604:14cc29913bb:-7fec','ADMIN',1),('RUL45fdd67:18003d296b8:-760d','DRAFT','TERMINAL_RENTAL_FEE','marketpayment','map-account','terminal rental fee',NULL,100000,NULL,NULL,'2022-04-07 20:23:31','USR-1b82c604:14cc29913bb:-7fec','ADMIN',1),('RUL5839c553:17cfa116791:-7d05','DRAFT','APPLY_EXCESS_PAYMENT','marketpayment','apply-payment','APPLY_EXCESS_PAYMENT',NULL,50000,NULL,NULL,'2021-11-07 19:16:03','USR-1b82c604:14cc29913bb:-7fec','ADMIN',1),('RUL63c10b3c:17d88149545:-7d4d','DRAFT','MARKET_CREDIT_BILLITEM','marketpayment','map-account','MAP CREDIT BILLITEM',NULL,50000,NULL,NULL,'2021-12-05 09:13:14','USR-1b82c604:14cc29913bb:-7fec','ADMIN',1),('RUL7f1d2a7:17fda7f921d:-7d63','DRAFT','BASIC_RENTAL_SCHEDULE','marketbillingschedule','set-schedule','BASIC RENTAL SCHEDULE',NULL,50000,NULL,NULL,'2022-03-30 19:10:29','USR-1b82c604:14cc29913bb:-7fec','ADMIN',1),('RUL94e7e78:17e437ee3f0:-7a44','DRAFT','ADD_BILLITEM_MONTHLY','marketbilling','initial','ADD_BILLITEM_MONTHLY',NULL,50000,NULL,NULL,'2022-01-10 19:43:32','USR-1b82c604:14cc29913bb:-7fec','ADMIN',1);
/*!40000 ALTER TABLE `sys_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_rule_action`
--

DROP TABLE IF EXISTS `sys_rule_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_rule_action` (
  `objid` varchar(50) NOT NULL,
  `parentid` varchar(50) DEFAULT NULL,
  `actiondef_objid` varchar(50) DEFAULT NULL,
  `actiondef_name` varchar(50) DEFAULT NULL,
  `pos` int(11) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `parentid` (`parentid`) USING BTREE,
  KEY `sys_rule_action_actiondef` (`actiondef_objid`) USING BTREE,
  CONSTRAINT `sys_rule_action_actiondef` FOREIGN KEY (`actiondef_objid`) REFERENCES `sys_rule_actiondef` (`objid`),
  CONSTRAINT `sys_rule_action_ibfk_1` FOREIGN KEY (`parentid`) REFERENCES `sys_rule` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_rule_action`
--

LOCK TABLES `sys_rule_action` WRITE;
/*!40000 ALTER TABLE `sys_rule_action` DISABLE KEYS */;
INSERT INTO `sys_rule_action` VALUES ('RA-2c592aee:17fda85180b:-7ffa','RUL7f1d2a7:17fda7f921d:-7d63','market.actions.SetMarketBillSchedule','set-market-bill-schedule',0),('RA234fa872:18003d4c1af:-7fe9','RUL45fdd67:18003d296b8:-760d','treasury.actions.AddCashReceiptItem','add-cashreceipt-item',0),('RA286de2e1:17ef6f125b1:-7ff4','RUL-63b19689:17ef6d330a9:-7391','treasury.actions.AddSurchargeItem','add-surcharge-item',0),('RACT-1642179f:1805e7640a3:-3912','RUL-1642179f:1805e7640a3:-6bfa','treasury.actions.RemoveBillItem','remove-billitem',0),('RACT214dddab:17a7631e40f:-7847','RUL214dddab:17a7631e40f:-78e9','treasury.actions.ApplyPayment','apply-payment',0),('RACT2e766257:18027a1b666:-60ee','RUL2e766257:18027a1b666:-6c6a','treasury.actions.AddInterestItem','add-interest-item',0),('RACT2e766257:18027a1b666:-74f0','RUL2e766257:18027a1b666:-78b6','treasury.actions.SetBillValidityDate','set-bill-validity-date',0),('RACT447795b:17e46b41478:-7c6c','RUL94e7e78:17e437ee3f0:-7a44','market.actions.AddMarketBillItem','add-market-billitem',0),('RACT45fdd67:18003d296b8:-7267','RUL-15ffadb8:17d2c8dcc4f:-7250','treasury.actions.AddCashReceiptItem','add-cashreceipt-item',0),('RACT45fdd67:18003d296b8:-737c','RUL63c10b3c:17d88149545:-7d4d','treasury.actions.AddCashReceiptItem','add-cashreceipt-item',0),('RACTa3fca46:17d04497a05:-79a1','RUL5839c553:17cfa116791:-7d05','treasury.actions.AddCreditBillItem','add-credit-billitem',0);
/*!40000 ALTER TABLE `sys_rule_action` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_rule_action_param`
--

DROP TABLE IF EXISTS `sys_rule_action_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_rule_action_param` (
  `objid` varchar(50) NOT NULL,
  `parentid` varchar(50) DEFAULT NULL,
  `actiondefparam_objid` varchar(100) DEFAULT NULL,
  `stringvalue` varchar(255) DEFAULT NULL,
  `booleanvalue` int(11) DEFAULT NULL,
  `var_objid` varchar(50) DEFAULT NULL,
  `var_name` varchar(50) DEFAULT NULL,
  `expr` longtext,
  `exprtype` varchar(25) DEFAULT NULL,
  `pos` int(11) DEFAULT NULL,
  `obj_key` varchar(50) DEFAULT NULL,
  `obj_value` varchar(255) DEFAULT NULL,
  `listvalue` longtext,
  `lov` varchar(50) DEFAULT NULL,
  `rangeoption` int(11) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `parentid` (`parentid`) USING BTREE,
  KEY `var_objid` (`var_objid`) USING BTREE,
  KEY `sys_rule_action_param_actiondefparam` (`actiondefparam_objid`) USING BTREE,
  CONSTRAINT `sys_rule_action_param_actiondefparam` FOREIGN KEY (`actiondefparam_objid`) REFERENCES `sys_rule_actiondef_param` (`objid`),
  CONSTRAINT `sys_rule_action_param_ibfk_1` FOREIGN KEY (`parentid`) REFERENCES `sys_rule_action` (`objid`),
  CONSTRAINT `sys_rule_action_param_ibfk_2` FOREIGN KEY (`var_objid`) REFERENCES `sys_rule_condition_var` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_rule_action_param`
--

LOCK TABLES `sys_rule_action_param` WRITE;
/*!40000 ALTER TABLE `sys_rule_action_param` DISABLE KEYS */;
INSERT INTO `sys_rule_action_param` VALUES ('RAP-2c592aee:17fda85180b:-7ff4','RA-2c592aee:17fda85180b:-7ffa','market.actions.SetMarketBillSchedule.billdate',NULL,NULL,NULL,NULL,'@DATE( YR , MON,  1 )','expression',NULL,NULL,NULL,NULL,NULL,NULL),('RAP-2c592aee:17fda85180b:-7ff5','RA-2c592aee:17fda85180b:-7ffa','market.actions.SetMarketBillSchedule.expirydate',NULL,NULL,NULL,NULL,'@MONTHEND(   @DATE( YR , MON,  1 )  )','expression',NULL,NULL,NULL,NULL,NULL,NULL),('RAP-2c592aee:17fda85180b:-7ff6','RA-2c592aee:17fda85180b:-7ffa','market.actions.SetMarketBillSchedule.duedate',NULL,NULL,NULL,NULL,'@FINDNEXTWORKDAY(  @MONTHEND(  @DATE( YR , MON,  1 )  ) , null, 1 ) ','expression',NULL,NULL,NULL,NULL,NULL,NULL),('RAP-2c592aee:17fda85180b:-7ff7','RA-2c592aee:17fda85180b:-7ffa','market.actions.SetMarketBillSchedule.todate',NULL,NULL,NULL,NULL,'@MONTHEND(   @DATE( YR , MON,  1 )  )','expression',NULL,NULL,NULL,NULL,NULL,NULL),('RAP-2c592aee:17fda85180b:-7ff8','RA-2c592aee:17fda85180b:-7ffa','market.actions.SetMarketBillSchedule.fromdate',NULL,NULL,NULL,NULL,'@DATE( YR , MON,  1 )','expression',NULL,NULL,NULL,NULL,NULL,NULL),('RAP-2c592aee:17fda85180b:-7ff9','RA-2c592aee:17fda85180b:-7ffa','market.actions.SetMarketBillSchedule.billschedule',NULL,NULL,'RC-2c592aee:17fda85180b:-7ffd','MBS',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('RAP234fa872:18003d4c1af:-7fe7','RA234fa872:18003d4c1af:-7fe9','treasury.actions.AddCashReceiptItem.billitem',NULL,NULL,'RC234fa872:18003d4c1af:-7fed','ABILLITEM',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('RAP234fa872:18003d4c1af:-7fe8','RA234fa872:18003d4c1af:-7fe9','treasury.actions.AddCashReceiptItem.account',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'ITMACCT45fdd67:18003d296b8:-7699','INCOME FROM MARKET TERMINAL',NULL,NULL,NULL),('RAP286de2e1:17ef6f125b1:-7ff0','RA286de2e1:17ef6f125b1:-7ff4','treasury.actions.AddSurchargeItem.billitem',NULL,NULL,'RC286de2e1:17ef6f125b1:-7ff9','BILLITEM',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('RAP286de2e1:17ef6f125b1:-7ff1','RA286de2e1:17ef6f125b1:-7ff4','treasury.actions.AddSurchargeItem.amount',NULL,NULL,NULL,NULL,'@ROUND( AMT * 0.25 );','expression',NULL,NULL,NULL,NULL,NULL,NULL),('RAP286de2e1:17ef6f125b1:-7ff2','RA286de2e1:17ef6f125b1:-7ff4','treasury.actions.AddSurchargeItem.account',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'MARKET_RENTAL_SURCHARGE','MARKET RENTAL SURCHARGE',NULL,NULL,NULL),('RAP286de2e1:17ef6f125b1:-7ff3','RA286de2e1:17ef6f125b1:-7ff4','treasury.actions.AddSurchargeItem.billdate',NULL,NULL,NULL,NULL,'DUEDATE ','expression',NULL,NULL,NULL,NULL,NULL,NULL),('RULACT-1642179f:1805e7640a3:-3906','RACT-1642179f:1805e7640a3:-3912','treasury.actions.RemoveBillItem.billitem',NULL,NULL,'RCOND-1642179f:1805e7640a3:-3a2c','SUBITM',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('RULACT-5ac08a89:17eaeb7f1d7:-765d','RACT447795b:17e46b41478:-7c6c','market.actions.AddMarketBillItem.month',NULL,NULL,'RCC-4d346da4:17e43ccf62d:-7ff6','MON',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('RULACT-5ac08a89:17eaeb7f1d7:-7694','RACT447795b:17e46b41478:-7c6c','market.actions.AddMarketBillItem.year',NULL,NULL,'RCC-4d346da4:17e43ccf62d:-7ff5','YR',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('RULACT214dddab:17a7631e40f:-783b','RACT214dddab:17a7631e40f:-7847','treasury.actions.ApplyPayment.payment',NULL,NULL,'RCOND214dddab:17a7631e40f:-78a2','PMT',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('RULACT2e766257:18027a1b666:-5e67','RACT2e766257:18027a1b666:-60ee','treasury.actions.AddInterestItem.amount',NULL,NULL,NULL,NULL,'if( INT > 0 ) {\n    return @ROUND(( AMT + SUR + INT ) * 0.02);   \n}\nelse {\n    return  @ROUND( (AMT + SUR) * (1.02**( YRMON - BYRMON )  )) -  (AMT+SUR);\n} \n','expression',NULL,NULL,NULL,NULL,NULL,NULL),('RULACT2e766257:18027a1b666:-606c','RACT2e766257:18027a1b666:-60ee','treasury.actions.AddInterestItem.billdate',NULL,NULL,NULL,NULL,'BILLDATE','expression',NULL,NULL,NULL,NULL,NULL,NULL),('RULACT2e766257:18027a1b666:-60a8','RACT2e766257:18027a1b666:-60ee','treasury.actions.AddInterestItem.account',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'MARKET_RENTAL_INTEREST','MARKET RENTAL INTEREST',NULL,NULL,NULL),('RULACT2e766257:18027a1b666:-60d0','RACT2e766257:18027a1b666:-60ee','treasury.actions.AddInterestItem.billitem',NULL,NULL,'RCOND2e766257:18027a1b666:-6694','BILLITEM',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('RULACT2e766257:18027a1b666:-74c6','RACT2e766257:18027a1b666:-74f0','treasury.actions.SetBillValidityDate.date',NULL,NULL,NULL,NULL,'@IIF(  TXNDATE.before(  DUEDATE)  ,  DUEDATE,   EXPIRYDATE );','expression',NULL,NULL,NULL,NULL,NULL,NULL),('RULACT2e766257:18027a1b666:-74de','RACT2e766257:18027a1b666:-74f0','treasury.actions.SetBillValidityDate.bill',NULL,NULL,'RCOND2e766257:18027a1b666:-7556','MBILL',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('RULACT447795b:17e46b41478:-7a2e','RACT447795b:17e46b41478:-7c6c','market.actions.AddMarketBillItem.billdate',NULL,NULL,NULL,NULL,'BILLDATE','expression',NULL,NULL,NULL,NULL,NULL,NULL),('RULACT447795b:17e46b41478:-7bfb','RACT447795b:17e46b41478:-7c6c','market.actions.AddMarketBillItem.amount',NULL,NULL,NULL,NULL,'@IIF(  TYPE == \'DAY\',   RATE *  @DAY(  TODATE  ) ,   RATE )','expression',NULL,NULL,NULL,NULL,NULL,NULL),('RULACT447795b:17e46b41478:-7c3f','RACT447795b:17e46b41478:-7c6c','market.actions.AddMarketBillItem.account',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'MARKET_FEE','MARKET FEE',NULL,NULL,NULL),('RULACT45fdd67:18003d296b8:-7216','RACT45fdd67:18003d296b8:-7267','treasury.actions.AddCashReceiptItem.account',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'ITMACCT554829fd:17d889e2b73:-7912','MARKET SURCHARGE',NULL,NULL,NULL),('RULACT45fdd67:18003d296b8:-7243','RACT45fdd67:18003d296b8:-7267','treasury.actions.AddCashReceiptItem.billitem',NULL,NULL,'RCOND-15ffadb8:17d2c8dcc4f:-6f13','ABILLITEM',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('RULACT45fdd67:18003d296b8:-732b','RACT45fdd67:18003d296b8:-737c','treasury.actions.AddCashReceiptItem.account',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'ITMACCT45fdd67:18003d296b8:-7699','INCOME FROM MARKET TERMINAL',NULL,NULL,NULL),('RULACT45fdd67:18003d296b8:-7358','RACT45fdd67:18003d296b8:-737c','treasury.actions.AddCashReceiptItem.billitem',NULL,NULL,'RCOND63c10b3c:17d88149545:-7c1b','CRBILL',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('RULACTa3fca46:17d04497a05:-796b','RACTa3fca46:17d04497a05:-79a1','treasury.actions.AddCreditBillItem.amount',NULL,NULL,NULL,NULL,'AMT','expression',NULL,NULL,NULL,NULL,NULL,NULL),('RULACTa3fca46:17d04497a05:-798f','RACTa3fca46:17d04497a05:-79a1','treasury.actions.AddCreditBillItem.account',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'MARKET_ADVANCE','MARKET ADVANCE PAYMENT',NULL,NULL,NULL);
/*!40000 ALTER TABLE `sys_rule_action_param` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_rule_actiondef`
--

DROP TABLE IF EXISTS `sys_rule_actiondef`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_rule_actiondef` (
  `objid` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `title` varchar(250) DEFAULT NULL,
  `sortorder` int(11) DEFAULT NULL,
  `actionname` varchar(50) DEFAULT NULL,
  `domain` varchar(50) DEFAULT NULL,
  `actionclass` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_rule_actiondef`
--

LOCK TABLES `sys_rule_actiondef` WRITE;
/*!40000 ALTER TABLE `sys_rule_actiondef` DISABLE KEYS */;
INSERT INTO `sys_rule_actiondef` VALUES ('enterprise.actions.AddRequirement','add-requirement','Add Requirement',2,'add-requirement','enterprise','enterprise.actions.AddRequirement'),('enterprise.actions.PrintTest','print-test','Print Test',1,'print-test','ENTERPRISE','enterprise.actions.PrintTest'),('enterprise.actions.ThrowException','throw-exeception','Throw Exception',1,'throw-exeception','ENTERPRISE','enterprise.actions.ThrowException'),('market.actions.AddMarketBillItem','add-market-billitem','Add Market Bill Item',0,'add-market-billitem','MARKET','market.actions.AddMarketBillItem'),('market.actions.AddMarketBillSchedule','add-market-bill-schedule','Add Market Bill Schedule',0,'add-market-bill-schedule','MARKET','market.actions.AddMarketBillSchedule'),('market.actions.SetMarketBillSchedule','set-market-bill-schedule','Set Market Bill Schedule',1,'set-market-bill-schedule','MARKET','market.actions.SetMarketBillSchedule'),('treasury.actions.AddCashReceiptItem','add-cashreceipt-item','Add Cash Receipt Item',1,'add-cashreceipt-item','TREASURY','treasury.actions.AddCashReceiptItem'),('treasury.actions.AddCreditBillItem','add-credit-billitem','Add Credit Bill Item',2,'add-credit-billitem','TREASURY','treasury.actions.AddCreditBillItem'),('treasury.actions.AddDiscountItem','add-discount-item','Add Discount',3,'add-discount-item','TREASURY','treasury.actions.AddDiscountItem'),('treasury.actions.AddInterestItem','add-interest-item','Add Interest',3,'add-interest-item','TREASURY','treasury.actions.AddInterestItem'),('treasury.actions.AddSurchargeItem','add-surcharge-item','Add Surcharge',3,'add-surcharge-item','TREASURY','treasury.actions.AddSurchargeItem'),('treasury.actions.AddVarInteger','add-var-integer','Add Var Integer',1,'add-var-integer','TREASURY','treasury.actions.AddVarInteger'),('treasury.actions.ApplyPayment','apply-payment','Apply Payment',5,'apply-payment','TREASURY','treasury.actions.ApplyPayment'),('treasury.actions.RemoveBillItem','remove-billitem','Remove Bill Item',10,'remove-billitem','TREASURY','treasury.actions.RemoveBillItem'),('treasury.actions.SetBillItemAccount','set-billitem-account','Set Bill Item Account',4,'set-billitem-account','TREASURY','treasury.actions.SetBillItemAccount'),('treasury.actions.SetBillItemProperty','set-billitem-property','Set BillItem Property Value',10,'set-billitem-property','TREASURY','treasury.actions.SetBillItemProperty'),('treasury.actions.SetBillValidityDate','set-bill-validity-date','Set Bill Validity date',1,'set-bill-validity-date','TREASURY','treasury.actions.SetBillValidityDate'),('treasury.actions.SetCashReceiptItemRemarks','set-cashreceipt-item-remarks','Set Cash Receipt Item Remarks',1,'set-cashreceipt-item-remarks','TREASURY','treasury.actions.SetCashReceiptItemRemarks'),('treasury.actions.UpdateBillItemAmount','update-billitem-amount','Update Bill Item Amount',1,'update-billitem-amount','TREASURY','treasury.actions.UpdateBillItemAmount');
/*!40000 ALTER TABLE `sys_rule_actiondef` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_rule_actiondef_param`
--

DROP TABLE IF EXISTS `sys_rule_actiondef_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_rule_actiondef_param` (
  `objid` varchar(100) NOT NULL DEFAULT '',
  `parentid` varchar(50) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `sortorder` int(11) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `datatype` varchar(50) DEFAULT NULL,
  `handler` varchar(50) DEFAULT NULL,
  `lookuphandler` varchar(50) DEFAULT NULL,
  `lookupkey` varchar(50) DEFAULT NULL,
  `lookupvalue` varchar(50) DEFAULT NULL,
  `vardatatype` varchar(50) DEFAULT NULL,
  `lovname` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `parentid` (`parentid`) USING BTREE,
  CONSTRAINT `sys_rule_actiondef_param_ibfk_1` FOREIGN KEY (`parentid`) REFERENCES `sys_rule_actiondef` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_rule_actiondef_param`
--

LOCK TABLES `sys_rule_actiondef_param` WRITE;
/*!40000 ALTER TABLE `sys_rule_actiondef_param` DISABLE KEYS */;
INSERT INTO `sys_rule_actiondef_param` VALUES ('enterprise.actions.AddRequirement.message','enterprise.actions.AddRequirement','message',2,'Message',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('enterprise.actions.AddRequirement.reqtype','enterprise.actions.AddRequirement','reqtype',1,'Requirement Type',NULL,'lookup','sys_requirement_type:lookup','code','title','string',NULL),('enterprise.actions.AddRequirement.required','enterprise.actions.AddRequirement','required',4,'Required','boolean','boolean',NULL,NULL,NULL,'boolean',NULL),('enterprise.actions.AddRequirement.sortorder','enterprise.actions.AddRequirement','sortorder',3,'Sort Order','string','string',NULL,NULL,NULL,'string',NULL),('enterprise.actions.PrintTest.message','enterprise.actions.PrintTest','message',1,'Message',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('enterprise.actions.ThrowException.msg','enterprise.actions.ThrowException','msg',1,'Message',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('market.actions.AddMarketBillItem.account','market.actions.AddMarketBillItem','account',1,'Account',NULL,'lookup','market_itemaccount:lookup','objid','title',NULL,NULL),('market.actions.AddMarketBillItem.amount','market.actions.AddMarketBillItem','amount',2,'Amount',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('market.actions.AddMarketBillItem.billdate','market.actions.AddMarketBillItem','billdate',5,'Bill Date',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('market.actions.AddMarketBillItem.month','market.actions.AddMarketBillItem','month',4,'Month',NULL,'var',NULL,NULL,NULL,'integer',NULL),('market.actions.AddMarketBillItem.year','market.actions.AddMarketBillItem','year',3,'Year',NULL,'var',NULL,NULL,NULL,'integer',NULL),('market.actions.AddMarketBillSchedule.month','market.actions.AddMarketBillSchedule','month',3,'Month',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('market.actions.AddMarketBillSchedule.params','market.actions.AddMarketBillSchedule','params',1,'Parameters',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('market.actions.AddMarketBillSchedule.year','market.actions.AddMarketBillSchedule','year',2,'Year',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('market.actions.SetMarketBillSchedule.billdate','market.actions.SetMarketBillSchedule','billdate',4,'Bill Date',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('market.actions.SetMarketBillSchedule.billschedule','market.actions.SetMarketBillSchedule','billschedule',1,'Bill Schedule',NULL,'var',NULL,NULL,NULL,'market.facts.MarketBillSchedule',NULL),('market.actions.SetMarketBillSchedule.discdate','market.actions.SetMarketBillSchedule','discdate',5,'Discount Date',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('market.actions.SetMarketBillSchedule.duedate','market.actions.SetMarketBillSchedule','duedate',6,'Due Date',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('market.actions.SetMarketBillSchedule.expirydate','market.actions.SetMarketBillSchedule','expirydate',7,'Bill Expiry Date',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('market.actions.SetMarketBillSchedule.fromdate','market.actions.SetMarketBillSchedule','fromdate',2,'From Date',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('market.actions.SetMarketBillSchedule.readingdate','market.actions.SetMarketBillSchedule','readingdate',8,'Reading Date',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('market.actions.SetMarketBillSchedule.todate','market.actions.SetMarketBillSchedule','todate',3,'To Date',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('treasury.actions.AddCashReceiptItem.account','treasury.actions.AddCashReceiptItem','account',2,'Receipt Account',NULL,'lookup','revenueitem:lookup','objid','title',NULL,NULL),('treasury.actions.AddCashReceiptItem.amount','treasury.actions.AddCashReceiptItem','amount',3,'Amount',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('treasury.actions.AddCashReceiptItem.billitem','treasury.actions.AddCashReceiptItem','billitem',1,'Bill Item',NULL,'var',NULL,NULL,NULL,'treasury.facts.AbstractBillItem',NULL),('treasury.actions.AddCashReceiptItem.remarks','treasury.actions.AddCashReceiptItem','remarks',5,'Remarks',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('treasury.actions.AddCashReceiptItem.uid','treasury.actions.AddCashReceiptItem','uid',4,'UID',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('treasury.actions.AddCreditBillItem.account','treasury.actions.AddCreditBillItem','account',1,'Account',NULL,'lookup','itemaccount:lookup','objid','title',NULL,NULL),('treasury.actions.AddCreditBillItem.amount','treasury.actions.AddCreditBillItem','amount',2,'Amount',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('treasury.actions.AddDiscountItem.account','treasury.actions.AddDiscountItem','account',4,'Account',NULL,'lookup','revenueitem:lookup','objid','title',NULL,NULL),('treasury.actions.AddDiscountItem.amount','treasury.actions.AddDiscountItem','amount',2,'Amount',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('treasury.actions.AddDiscountItem.billcode','treasury.actions.AddDiscountItem','billcode',3,'Billcode',NULL,'lookup','market_itemaccount:lookup','objid','title','string',NULL),('treasury.actions.AddDiscountItem.billitem','treasury.actions.AddDiscountItem','billitem',1,'Bill Item',NULL,'var',NULL,NULL,NULL,'treasury.facts.AbstractBillItem',NULL),('treasury.actions.AddInterestItem.account','treasury.actions.AddInterestItem','account',3,'Account',NULL,'lookup','market_itemaccount:lookup','objid','title',NULL,NULL),('treasury.actions.AddInterestItem.amount','treasury.actions.AddInterestItem','amount',2,'Amount',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('treasury.actions.AddInterestItem.billdate','treasury.actions.AddInterestItem','billdate',4,'Bill Date',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('treasury.actions.AddInterestItem.billitem','treasury.actions.AddInterestItem','billitem',1,'Bill Item',NULL,'var',NULL,NULL,NULL,'treasury.facts.AbstractBillItem',NULL),('treasury.actions.AddSurchargeItem.account','treasury.actions.AddSurchargeItem','account',3,'Account',NULL,'lookup','market_itemaccount:lookup','objid','title',NULL,NULL),('treasury.actions.AddSurchargeItem.amount','treasury.actions.AddSurchargeItem','amount',2,'Amount',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('treasury.actions.AddSurchargeItem.billdate','treasury.actions.AddSurchargeItem','billdate',4,'Bill Date',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('treasury.actions.AddSurchargeItem.billitem','treasury.actions.AddSurchargeItem','billitem',1,'Bill Item',NULL,'var',NULL,NULL,NULL,'treasury.facts.AbstractBillItem',NULL),('treasury.actions.AddVarInteger.tag','treasury.actions.AddVarInteger','tag',2,'Tag','string','string',NULL,NULL,NULL,'string',NULL),('treasury.actions.AddVarInteger.value','treasury.actions.AddVarInteger','value',1,'Value',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('treasury.actions.ApplyPayment.payment','treasury.actions.ApplyPayment','payment',1,'Payment',NULL,'var',NULL,NULL,NULL,'treasury.facts.Payment',NULL),('treasury.actions.RemoveBillItem.billitem','treasury.actions.RemoveBillItem','billitem',1,'Bill Item',NULL,'var',NULL,NULL,NULL,'treasury.facts.AbstractBillItem',NULL),('treasury.actions.SetBillItemAccount.account','treasury.actions.SetBillItemAccount','account',2,'Account',NULL,'lookup','itemaccount:lookup','objid','title',NULL,NULL),('treasury.actions.SetBillItemAccount.billcode','treasury.actions.SetBillItemAccount','billcode',3,'Billcode',NULL,'lookup','waterworks_itemaccount:lookup','objid','title','string',NULL),('treasury.actions.SetBillItemAccount.billitem','treasury.actions.SetBillItemAccount','billitem',1,'Bill Item',NULL,'var',NULL,NULL,NULL,'treasury.facts.AbstractBillItem',NULL),('treasury.actions.SetBillItemProperty.billitem','treasury.actions.SetBillItemProperty','billitem',1,'Bill Item',NULL,'var',NULL,NULL,NULL,'treasury.facts.BillItem',NULL),('treasury.actions.SetBillItemProperty.fieldname','treasury.actions.SetBillItemProperty','fieldname',2,'Property Field Name',NULL,'fieldlist',NULL,'billitem',NULL,NULL,NULL),('treasury.actions.SetBillItemProperty.value','treasury.actions.SetBillItemProperty','value',3,'Value',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('treasury.actions.SetBillValidityDate.bill','treasury.actions.SetBillValidityDate','bill',1,'Bill',NULL,'var',NULL,NULL,NULL,'treasury.facts.Bill',NULL),('treasury.actions.SetBillValidityDate.date','treasury.actions.SetBillValidityDate','date',2,'Validity Date',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('treasury.actions.SetCashReceiptItemRemarks.receiptitem','treasury.actions.SetCashReceiptItemRemarks','receiptitem',1,'Receipt Item',NULL,'var',NULL,NULL,NULL,'treasury.facts.CashReceiptItem',NULL),('treasury.actions.SetCashReceiptItemRemarks.remarks','treasury.actions.SetCashReceiptItemRemarks','remarks',2,'Remarks',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('treasury.actions.UpdateBillItemAmount.amount','treasury.actions.UpdateBillItemAmount','amount',3,'Amount',NULL,'expression',NULL,NULL,NULL,NULL,NULL),('treasury.actions.UpdateBillItemAmount.billitem','treasury.actions.UpdateBillItemAmount','billitem',1,'Bill Item',NULL,'var',NULL,NULL,NULL,'treasury.facts.AbstractBillItem',NULL),('treasury.actions.UpdateBillItemAmount.type','treasury.actions.UpdateBillItemAmount','type',2,'Type',NULL,'lov',NULL,NULL,NULL,NULL,'UPDATE_BILLITEM_TYPE');
/*!40000 ALTER TABLE `sys_rule_actiondef_param` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_rule_condition`
--

DROP TABLE IF EXISTS `sys_rule_condition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_rule_condition` (
  `objid` varchar(50) NOT NULL,
  `parentid` varchar(50) DEFAULT NULL,
  `fact_name` varchar(50) DEFAULT NULL,
  `fact_objid` varchar(50) DEFAULT NULL,
  `varname` varchar(50) DEFAULT NULL,
  `pos` int(11) DEFAULT NULL,
  `ruletext` longtext,
  `displaytext` longtext,
  `dynamic_datatype` varchar(50) DEFAULT NULL,
  `dynamic_key` varchar(50) DEFAULT NULL,
  `dynamic_value` varchar(50) DEFAULT NULL,
  `notexist` int(11) NOT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `fact_objid` (`fact_objid`) USING BTREE,
  KEY `parentid` (`parentid`) USING BTREE,
  CONSTRAINT `sys_rule_condition_fact` FOREIGN KEY (`fact_objid`) REFERENCES `sys_rule_fact` (`objid`),
  CONSTRAINT `sys_rule_condition_ibfk_1` FOREIGN KEY (`fact_objid`) REFERENCES `sys_rule_fact` (`objid`),
  CONSTRAINT `sys_rule_condition_ibfk_2` FOREIGN KEY (`parentid`) REFERENCES `sys_rule` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_rule_condition`
--

LOCK TABLES `sys_rule_condition` WRITE;
/*!40000 ALTER TABLE `sys_rule_condition` DISABLE KEYS */;
INSERT INTO `sys_rule_condition` VALUES ('RC-2c592aee:17fda85180b:-7ffd','RUL7f1d2a7:17fda7f921d:-7d63','market.facts.MarketBillSchedule','market.facts.MarketBillSchedule','MBS',1,NULL,NULL,NULL,NULL,NULL,0),('RC-2c592aee:17fda85180b:-8000','RUL7f1d2a7:17fda7f921d:-7d63','market.facts.MarketBillGroup','market.facts.MarketBillGroup',NULL,0,NULL,NULL,NULL,NULL,NULL,0),('RC-4d346da4:17e43ccf62d:-7ff8','RUL94e7e78:17e437ee3f0:-7a44','market.facts.MarketBillSchedule','market.facts.MarketBillSchedule','MBS',2,NULL,NULL,NULL,NULL,NULL,0),('RC-4d346da4:17e43ccf62d:-8000','RUL94e7e78:17e437ee3f0:-7a44','market.facts.MarketBill','market.facts.MarketBill','MBILL',3,NULL,NULL,NULL,NULL,NULL,0),('RC234fa872:18003d4c1af:-7fed','RUL45fdd67:18003d296b8:-760d','treasury.facts.AbstractBillItem','treasury.facts.AbstractBillItem','ABILLITEM',1,NULL,NULL,NULL,NULL,NULL,0),('RC286de2e1:17ef6f125b1:-7ff9','RUL-63b19689:17ef6d330a9:-7391','market.facts.MarketBillItem','market.facts.MarketBillItem','BILLITEM',2,NULL,NULL,NULL,NULL,NULL,0),('RC286de2e1:17ef6f125b1:-7ffb','RUL-63b19689:17ef6d330a9:-7391','treasury.facts.TransactionDate','treasury.facts.TransactionDate',NULL,0,NULL,NULL,NULL,NULL,NULL,0),('RCOND-15ffadb8:17d2c8dcc4f:-6f13','RUL-15ffadb8:17d2c8dcc4f:-7250','treasury.facts.AbstractBillItem','treasury.facts.AbstractBillItem','ABILLITEM',1,NULL,NULL,NULL,NULL,NULL,0),('RCOND-15ffadb8:17d2c8dcc4f:-7007','RUL-15ffadb8:17d2c8dcc4f:-7250','treasury.facts.BillSubItem','treasury.facts.BillSubItem','SURCHG',0,NULL,NULL,NULL,NULL,NULL,0),('RCOND-1642179f:1805e7640a3:-3a2c','RUL-1642179f:1805e7640a3:-6bfa','treasury.facts.BillSubItem','treasury.facts.BillSubItem','SUBITM',1,NULL,NULL,NULL,NULL,NULL,0),('RCOND-1642179f:1805e7640a3:-5bc1','RUL-1642179f:1805e7640a3:-6bfa','market.facts.MarketBillItem','market.facts.MarketBillItem','MBI',0,NULL,NULL,NULL,NULL,NULL,0),('RCOND-63b19689:17ef6d330a9:-711d','RUL-63b19689:17ef6d330a9:-7391','market.facts.MarketBill','market.facts.MarketBill','MBILL',1,NULL,NULL,NULL,NULL,NULL,0),('RCOND-642c5cda:18044af565b:-7783','RUL2e766257:18027a1b666:-6c6a','treasury.facts.TransactionDate','treasury.facts.TransactionDate',NULL,0,NULL,NULL,NULL,NULL,NULL,0),('RCOND1e664b20:1800c300567:-7d5b','RUL45fdd67:18003d296b8:-760d','market.facts.MarketCenter','market.facts.MarketCenter',NULL,1,NULL,NULL,NULL,NULL,NULL,0),('RCOND214dddab:17a7631e40f:-78a2','RUL214dddab:17a7631e40f:-78e9','treasury.facts.Payment','treasury.facts.Payment','PMT',0,NULL,NULL,NULL,NULL,NULL,0),('RCOND2e766257:18027a1b666:-6694','RUL2e766257:18027a1b666:-6c6a','market.facts.MarketBillItem','market.facts.MarketBillItem','BILLITEM',2,NULL,NULL,NULL,NULL,NULL,0),('RCOND2e766257:18027a1b666:-6bf1','RUL2e766257:18027a1b666:-6c6a','market.facts.MarketBill','market.facts.MarketBill','MBILL',1,NULL,NULL,NULL,NULL,NULL,0),('RCOND2e766257:18027a1b666:-7556','RUL2e766257:18027a1b666:-78b6','market.facts.MarketBill','market.facts.MarketBill','MBILL',2,NULL,NULL,NULL,NULL,NULL,0),('RCOND2e766257:18027a1b666:-779b','RUL2e766257:18027a1b666:-78b6','market.facts.MarketBillSchedule','market.facts.MarketBillSchedule','MBS',1,NULL,NULL,NULL,NULL,NULL,0),('RCOND2e766257:18027a1b666:-783f','RUL2e766257:18027a1b666:-78b6','treasury.facts.TransactionDate','treasury.facts.TransactionDate',NULL,0,NULL,NULL,NULL,NULL,NULL,0),('RCOND45fdd67:18003d296b8:-747a','RUL63c10b3c:17d88149545:-7d4d','market.facts.MarketCenter','market.facts.MarketCenter',NULL,1,NULL,NULL,NULL,NULL,NULL,0),('RCOND5839c553:17cfa116791:-7cc0','RUL5839c553:17cfa116791:-7d05','treasury.facts.ExcessPayment','treasury.facts.ExcessPayment','EXPMT',0,NULL,NULL,NULL,NULL,NULL,0),('RCOND63c10b3c:17d88149545:-7c1b','RUL63c10b3c:17d88149545:-7d4d','treasury.facts.CreditBillItem','treasury.facts.CreditBillItem','CRBILL',0,NULL,NULL,NULL,NULL,NULL,0);
/*!40000 ALTER TABLE `sys_rule_condition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_rule_condition_constraint`
--

DROP TABLE IF EXISTS `sys_rule_condition_constraint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_rule_condition_constraint` (
  `objid` varchar(50) NOT NULL,
  `parentid` varchar(50) DEFAULT NULL,
  `field_objid` varchar(100) DEFAULT NULL,
  `fieldname` varchar(50) DEFAULT NULL,
  `varname` varchar(50) DEFAULT NULL,
  `operator_caption` varchar(50) DEFAULT NULL,
  `operator_symbol` varchar(50) DEFAULT NULL,
  `usevar` int(11) DEFAULT NULL,
  `var_objid` varchar(50) DEFAULT NULL,
  `var_name` varchar(50) DEFAULT NULL,
  `decimalvalue` decimal(16,2) DEFAULT NULL,
  `intvalue` int(11) DEFAULT NULL,
  `stringvalue` varchar(255) DEFAULT NULL,
  `listvalue` longtext,
  `datevalue` date DEFAULT NULL,
  `pos` int(11) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `parentid` (`parentid`) USING BTREE,
  KEY `var_objid` (`var_objid`) USING BTREE,
  KEY `sys_rule_condition_constraint_fact_field` (`field_objid`) USING BTREE,
  CONSTRAINT `sys_rule_condition_constraint_fact_field` FOREIGN KEY (`field_objid`) REFERENCES `sys_rule_fact_field` (`objid`),
  CONSTRAINT `sys_rule_condition_constraint_ibfk_1` FOREIGN KEY (`parentid`) REFERENCES `sys_rule_condition` (`objid`),
  CONSTRAINT `sys_rule_condition_constraint_ibfk_2` FOREIGN KEY (`var_objid`) REFERENCES `sys_rule_condition_var` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_rule_condition_constraint`
--

LOCK TABLES `sys_rule_condition_constraint` WRITE;
/*!40000 ALTER TABLE `sys_rule_condition_constraint` DISABLE KEYS */;
INSERT INTO `sys_rule_condition_constraint` VALUES ('RCC-2c592aee:17fda85180b:-7ffb','RC-2c592aee:17fda85180b:-7ffd','market.facts.MarketBillSchedule.month','month','MON',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),('RCC-2c592aee:17fda85180b:-7ffc','RC-2c592aee:17fda85180b:-7ffd','market.facts.MarketBillSchedule.year','year','YR',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),('RCC-2c592aee:17fda85180b:-7ffe','RC-2c592aee:17fda85180b:-8000','market.facts.MarketBillGroup.billtype','billtype',NULL,'is any of the ff.','matches',NULL,NULL,NULL,NULL,NULL,NULL,'[\"RENTAL\"]',NULL,0),('RCC-2c592aee:17fda85180b:-7fff','RC-2c592aee:17fda85180b:-8000','market.facts.MarketBillGroup.tag','tag',NULL,'matches','matches',NULL,NULL,NULL,NULL,NULL,'BASIC',NULL,NULL,1),('RCC-4d346da4:17e43ccf62d:-7ff4','RC-4d346da4:17e43ccf62d:-7ff8','market.facts.MarketBillSchedule.todate','todate','TODATE',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,3),('RCC-4d346da4:17e43ccf62d:-7ff5','RC-4d346da4:17e43ccf62d:-7ff8','market.facts.MarketBillSchedule.year','year','YR',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),('RCC-4d346da4:17e43ccf62d:-7ff6','RC-4d346da4:17e43ccf62d:-7ff8','market.facts.MarketBillSchedule.month','month','MON',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),('RCC-4d346da4:17e43ccf62d:-7fff','RC-4d346da4:17e43ccf62d:-8000','market.facts.MarketBill.state','state',NULL,'is any of the ff.','matches',NULL,NULL,NULL,NULL,NULL,NULL,'[\"OPEN\",\"POSTED\"]',NULL,0),('RCC234fa872:18003d4c1af:-7fec','RC234fa872:18003d4c1af:-7fed','treasury.facts.AbstractBillItem.acctid','acctid',NULL,'is any of the ff.','matches',NULL,NULL,NULL,NULL,NULL,NULL,'[[key:\"MARKET_FEE\",value:\"MARKET FEE\"]]',NULL,0),('RCC286de2e1:17ef6f125b1:-7ff5','RC286de2e1:17ef6f125b1:-7ff9','market.facts.MarketBillItem.acctid','acctid',NULL,'is any of the ff.','matches',NULL,NULL,NULL,NULL,NULL,NULL,'[[key:\"MARKET_FEE\",value:\"MARKET FEE\"]]',NULL,2),('RCC286de2e1:17ef6f125b1:-7ff6','RC286de2e1:17ef6f125b1:-7ff9','market.facts.MarketBillItem.amount','amount','AMT','greater than','>',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,0),('RCC286de2e1:17ef6f125b1:-7ffa','RC286de2e1:17ef6f125b1:-7ffb','treasury.facts.TransactionDate.date','date','TXNDATE',NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),('RCONST-1086f126:1804fd87c17:-7b56','RC-4d346da4:17e43ccf62d:-8000','market.facts.MarketBill.ratetype','ratetype','TYPE',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,3),('RCONST-1086f126:1804fd87c17:-7c1c','RC-4d346da4:17e43ccf62d:-8000','market.facts.MarketBill.rate','rate','RATE',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2),('RCONST-15ffadb8:17d2c8dcc4f:-6c89','RCOND-15ffadb8:17d2c8dcc4f:-7007','treasury.facts.BillSubItem.acctid','acctid','ACCTID',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2),('RCONST-15ffadb8:17d2c8dcc4f:-6ef7','RCOND-15ffadb8:17d2c8dcc4f:-6f13','treasury.facts.AbstractBillItem.objid','objid',NULL,'equal to','==',1,'RCONST-15ffadb8:17d2c8dcc4f:-6fdf','SID',NULL,NULL,NULL,NULL,NULL,0),('RCONST-15ffadb8:17d2c8dcc4f:-6f9b','RCOND-15ffadb8:17d2c8dcc4f:-7007','treasury.facts.BillSubItem.amount','amount','AMT',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),('RCONST-15ffadb8:17d2c8dcc4f:-6fdf','RCOND-15ffadb8:17d2c8dcc4f:-7007','treasury.facts.BillSubItem.objid','objid','SID',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),('RCONST-1642179f:1805e7640a3:-39f5','RCOND-1642179f:1805e7640a3:-3a2c','treasury.facts.BillSubItem.billitemrefid','billitemrefid',NULL,'equal to','==',1,'RCONST-1642179f:1805e7640a3:-4061','REFID',NULL,NULL,NULL,NULL,NULL,0),('RCONST-1642179f:1805e7640a3:-4061','RCOND-1642179f:1805e7640a3:-5bc1','market.facts.MarketBillItem.objid','objid','REFID',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2),('RCONST-1642179f:1805e7640a3:-52b0','RCOND-1642179f:1805e7640a3:-5bc1','market.facts.MarketBillItem.month','month',NULL,'greater than or equal to','>=',NULL,NULL,NULL,NULL,3,NULL,NULL,NULL,2),('RCONST-1642179f:1805e7640a3:-5354','RCOND-1642179f:1805e7640a3:-5bc1','market.facts.MarketBillItem.year','year',NULL,'equal to','==',NULL,NULL,NULL,NULL,2020,NULL,NULL,NULL,1),('RCONST-2ce09f5b:1804ee40acb:-7472','RCOND2e766257:18027a1b666:-6bf1','market.facts.MarketBill.billdate','billdate','BILLDATE',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,4),('RCONST-63b19689:17ef6d330a9:-70c2','RCOND-63b19689:17ef6d330a9:-711d','market.facts.MarketBill.billtype','billtype',NULL,'is any of the ff.','matches',NULL,NULL,NULL,NULL,NULL,NULL,'[\"RENTAL\"]',NULL,0),('RCONST-642c5cda:18044af565b:-63be','RCOND2e766257:18027a1b666:-6694','market.facts.MarketBillItem.yearmonth','yearmonth','BYRMON',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,4),('RCONST-642c5cda:18044af565b:-6c54','RCOND2e766257:18027a1b666:-6694','market.facts.MarketBillItem.duedate','duedate','DUEDATE','before','<',1,'RCONST-642c5cda:18044af565b:-7755','TXNDATE',NULL,NULL,NULL,NULL,NULL,4),('RCONST-642c5cda:18044af565b:-705e','RCOND2e766257:18027a1b666:-6bf1','market.facts.MarketBill.yearmonth','yearmonth','YRMON',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,3),('RCONST-642c5cda:18044af565b:-7755','RCOND-642c5cda:18044af565b:-7783','treasury.facts.TransactionDate.date','date','TXNDATE',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),('RCONST-642c5cda:18044af565b:-79e5','RC286de2e1:17ef6f125b1:-7ff9','market.facts.MarketBillItem.duedate','duedate','DUEDATE','before','<',1,'RCC286de2e1:17ef6f125b1:-7ffa','TXNDATE',NULL,NULL,NULL,NULL,NULL,3),('RCONST1e664b20:1800c300567:-7d4b','RCOND1e664b20:1800c300567:-7d5b','market.facts.MarketCenter.name','name',NULL,'is any of the ff.','matches',NULL,NULL,NULL,NULL,NULL,NULL,'[[key:\"MKTCTR-37bb3146:17fddecebd5:-7dbb\",value:\"TERMINAL\"]]',NULL,0),('RCONST214dddab:17a7631e40f:-7892','RCOND214dddab:17a7631e40f:-78a2','treasury.facts.Payment.amount','amount',NULL,'greater than','>',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,0),('RCONST2e766257:18027a1b666:-6226','RCOND2e766257:18027a1b666:-6694','market.facts.MarketBillItem.interest','interest','INT',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,5),('RCONST2e766257:18027a1b666:-632f','RCOND2e766257:18027a1b666:-6694','market.facts.MarketBillItem.surcharge','surcharge','SUR',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,4),('RCONST2e766257:18027a1b666:-6410','RCOND2e766257:18027a1b666:-6694','market.facts.MarketBillItem.amount','amount','AMT','greater than','>',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,3),('RCONST2e766257:18027a1b666:-69d0','RCOND2e766257:18027a1b666:-6bf1','market.facts.MarketBill.month','month','MON',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,3),('RCONST2e766257:18027a1b666:-6a78','RCOND2e766257:18027a1b666:-6bf1','market.facts.MarketBill.year','year','YR',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2),('RCONST2e766257:18027a1b666:-6b7f','RCOND2e766257:18027a1b666:-6bf1','market.facts.MarketBill.billtype','billtype',NULL,'is any of the ff.','matches',NULL,NULL,NULL,NULL,NULL,NULL,'[\"RENTAL\"]',NULL,0),('RCONST2e766257:18027a1b666:-7672','RCOND2e766257:18027a1b666:-779b','market.facts.MarketBillSchedule.expirydate','expirydate','EXPIRYDATE',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),('RCONST2e766257:18027a1b666:-7742','RCOND2e766257:18027a1b666:-779b','market.facts.MarketBillSchedule.duedate','duedate','DUEDATE',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),('RCONST2e766257:18027a1b666:-7811','RCOND2e766257:18027a1b666:-783f','treasury.facts.TransactionDate.date','date','TXNDATE',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),('RCONST2e766257:18027a1b666:-7a16','RC-4d346da4:17e43ccf62d:-7ff8','market.facts.MarketBillSchedule.billdate','billdate','BILLDATE',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,3),('RCONST45fdd67:18003d296b8:-746a','RCOND45fdd67:18003d296b8:-747a','market.facts.MarketCenter.name','name',NULL,'is any of the ff.','matches',NULL,NULL,NULL,NULL,NULL,NULL,'[[key:\"MKTCTR-37bb3146:17fddecebd5:-7dbb\",value:\"TERMINAL\"]]',NULL,0),('RCONST5839c553:17cfa116791:-7cb0','RCOND5839c553:17cfa116791:-7cc0','treasury.facts.ExcessPayment.amount','amount','AMT','greater than','>',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,0),('RCONST63c10b3c:17d88149545:-7bf9','RCOND63c10b3c:17d88149545:-7c1b','treasury.facts.CreditBillItem.amount','amount','AMT',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),('RCONST7f1d2a7:17fda7f921d:-71f2','RC286de2e1:17ef6f125b1:-7ff9','market.facts.MarketBillItem.surcharge','surcharge',NULL,'equal to','==',NULL,NULL,NULL,0.00,NULL,NULL,NULL,NULL,3),('RCONST94e7e78:17e437ee3f0:-7618','RC-4d346da4:17e43ccf62d:-8000','market.facts.MarketBill.billtype','billtype',NULL,'is any of the ff.','matches',NULL,NULL,NULL,NULL,NULL,NULL,'[\"RENTAL\"]',NULL,2);
/*!40000 ALTER TABLE `sys_rule_condition_constraint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_rule_condition_var`
--

DROP TABLE IF EXISTS `sys_rule_condition_var`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_rule_condition_var` (
  `objid` varchar(50) NOT NULL,
  `parentid` varchar(50) DEFAULT NULL,
  `ruleid` varchar(50) DEFAULT NULL,
  `varname` varchar(50) DEFAULT NULL,
  `datatype` varchar(50) DEFAULT NULL,
  `pos` int(11) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `parentid` (`parentid`) USING BTREE,
  CONSTRAINT `sys_rule_condition_var_ibfk_1` FOREIGN KEY (`parentid`) REFERENCES `sys_rule_condition` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_rule_condition_var`
--

LOCK TABLES `sys_rule_condition_var` WRITE;
/*!40000 ALTER TABLE `sys_rule_condition_var` DISABLE KEYS */;
INSERT INTO `sys_rule_condition_var` VALUES ('RC-2c592aee:17fda85180b:-7ffd','RC-2c592aee:17fda85180b:-7ffd','RUL7f1d2a7:17fda7f921d:-7d63','MBS','market.facts.MarketBillSchedule',1),('RC-4d346da4:17e43ccf62d:-7ff8','RC-4d346da4:17e43ccf62d:-7ff8','RUL94e7e78:17e437ee3f0:-7a44','MBS','market.facts.MarketBillSchedule',2),('RC-4d346da4:17e43ccf62d:-8000','RC-4d346da4:17e43ccf62d:-8000','RUL94e7e78:17e437ee3f0:-7a44','MBILL','market.facts.MarketBill',3),('RC234fa872:18003d4c1af:-7fed','RC234fa872:18003d4c1af:-7fed','RUL45fdd67:18003d296b8:-760d','ABILLITEM','treasury.facts.AbstractBillItem',1),('RC286de2e1:17ef6f125b1:-7ff9','RC286de2e1:17ef6f125b1:-7ff9','RUL-63b19689:17ef6d330a9:-7391','BILLITEM','market.facts.MarketBillItem',2),('RCC-2c592aee:17fda85180b:-7ffb','RC-2c592aee:17fda85180b:-7ffd','RUL7f1d2a7:17fda7f921d:-7d63','MON','integer',1),('RCC-2c592aee:17fda85180b:-7ffc','RC-2c592aee:17fda85180b:-7ffd','RUL7f1d2a7:17fda7f921d:-7d63','YR','integer',0),('RCC-4d346da4:17e43ccf62d:-7ff4','RC-4d346da4:17e43ccf62d:-7ff8','RUL94e7e78:17e437ee3f0:-7a44','TODATE','date',3),('RCC-4d346da4:17e43ccf62d:-7ff5','RC-4d346da4:17e43ccf62d:-7ff8','RUL94e7e78:17e437ee3f0:-7a44','YR','integer',0),('RCC-4d346da4:17e43ccf62d:-7ff6','RC-4d346da4:17e43ccf62d:-7ff8','RUL94e7e78:17e437ee3f0:-7a44','MON','integer',1),('RCC286de2e1:17ef6f125b1:-7ff6','RC286de2e1:17ef6f125b1:-7ff9','RUL-63b19689:17ef6d330a9:-7391','AMT','decimal',0),('RCC286de2e1:17ef6f125b1:-7ffa','RC286de2e1:17ef6f125b1:-7ffb','RUL-63b19689:17ef6d330a9:-7391','TXNDATE','date',0),('RCOND-15ffadb8:17d2c8dcc4f:-6f13','RCOND-15ffadb8:17d2c8dcc4f:-6f13','RUL-15ffadb8:17d2c8dcc4f:-7250','ABILLITEM','treasury.facts.AbstractBillItem',1),('RCOND-15ffadb8:17d2c8dcc4f:-7007','RCOND-15ffadb8:17d2c8dcc4f:-7007','RUL-15ffadb8:17d2c8dcc4f:-7250','SURCHG','treasury.facts.BillSubItem',0),('RCOND-1642179f:1805e7640a3:-3a2c','RCOND-1642179f:1805e7640a3:-3a2c','RUL-1642179f:1805e7640a3:-6bfa','SUBITM','treasury.facts.BillSubItem',1),('RCOND-1642179f:1805e7640a3:-5bc1','RCOND-1642179f:1805e7640a3:-5bc1','RUL-1642179f:1805e7640a3:-6bfa','MBI','market.facts.MarketBillItem',0),('RCOND-63b19689:17ef6d330a9:-711d','RCOND-63b19689:17ef6d330a9:-711d','RUL-63b19689:17ef6d330a9:-7391','MBILL','market.facts.MarketBill',1),('RCOND214dddab:17a7631e40f:-78a2','RCOND214dddab:17a7631e40f:-78a2','RUL214dddab:17a7631e40f:-78e9','PMT','treasury.facts.Payment',0),('RCOND2e766257:18027a1b666:-6694','RCOND2e766257:18027a1b666:-6694','RUL2e766257:18027a1b666:-6c6a','BILLITEM','market.facts.MarketBillItem',2),('RCOND2e766257:18027a1b666:-6bf1','RCOND2e766257:18027a1b666:-6bf1','RUL2e766257:18027a1b666:-6c6a','MBILL','market.facts.MarketBill',1),('RCOND2e766257:18027a1b666:-7556','RCOND2e766257:18027a1b666:-7556','RUL2e766257:18027a1b666:-78b6','MBILL','market.facts.MarketBill',2),('RCOND2e766257:18027a1b666:-779b','RCOND2e766257:18027a1b666:-779b','RUL2e766257:18027a1b666:-78b6','MBS','market.facts.MarketBillSchedule',1),('RCOND5839c553:17cfa116791:-7cc0','RCOND5839c553:17cfa116791:-7cc0','RUL5839c553:17cfa116791:-7d05','EXPMT','treasury.facts.ExcessPayment',0),('RCOND63c10b3c:17d88149545:-7c1b','RCOND63c10b3c:17d88149545:-7c1b','RUL63c10b3c:17d88149545:-7d4d','CRBILL','treasury.facts.CreditBillItem',0),('RCONST-1086f126:1804fd87c17:-7b56','RC-4d346da4:17e43ccf62d:-8000','RUL94e7e78:17e437ee3f0:-7a44','TYPE','string',3),('RCONST-1086f126:1804fd87c17:-7c1c','RC-4d346da4:17e43ccf62d:-8000','RUL94e7e78:17e437ee3f0:-7a44','RATE','decimal',2),('RCONST-15ffadb8:17d2c8dcc4f:-6c89','RCOND-15ffadb8:17d2c8dcc4f:-7007','RUL-15ffadb8:17d2c8dcc4f:-7250','ACCTID','string',2),('RCONST-15ffadb8:17d2c8dcc4f:-6f9b','RCOND-15ffadb8:17d2c8dcc4f:-7007','RUL-15ffadb8:17d2c8dcc4f:-7250','AMT','decimal',1),('RCONST-15ffadb8:17d2c8dcc4f:-6fdf','RCOND-15ffadb8:17d2c8dcc4f:-7007','RUL-15ffadb8:17d2c8dcc4f:-7250','SID','string',0),('RCONST-1642179f:1805e7640a3:-4061','RCOND-1642179f:1805e7640a3:-5bc1','RUL-1642179f:1805e7640a3:-6bfa','REFID','string',2),('RCONST-2ce09f5b:1804ee40acb:-7472','RCOND2e766257:18027a1b666:-6bf1','RUL2e766257:18027a1b666:-6c6a','BILLDATE','date',4),('RCONST-642c5cda:18044af565b:-63be','RCOND2e766257:18027a1b666:-6694','RUL2e766257:18027a1b666:-6c6a','BYRMON','integer',4),('RCONST-642c5cda:18044af565b:-6c54','RCOND2e766257:18027a1b666:-6694','RUL2e766257:18027a1b666:-6c6a','DUEDATE','date',4),('RCONST-642c5cda:18044af565b:-705e','RCOND2e766257:18027a1b666:-6bf1','RUL2e766257:18027a1b666:-6c6a','YRMON','integer',3),('RCONST-642c5cda:18044af565b:-7755','RCOND-642c5cda:18044af565b:-7783','RUL2e766257:18027a1b666:-6c6a','TXNDATE','date',0),('RCONST-642c5cda:18044af565b:-79e5','RC286de2e1:17ef6f125b1:-7ff9','RUL-63b19689:17ef6d330a9:-7391','DUEDATE','date',3),('RCONST2e766257:18027a1b666:-6226','RCOND2e766257:18027a1b666:-6694','RUL2e766257:18027a1b666:-6c6a','INT','decimal',5),('RCONST2e766257:18027a1b666:-632f','RCOND2e766257:18027a1b666:-6694','RUL2e766257:18027a1b666:-6c6a','SUR','decimal',4),('RCONST2e766257:18027a1b666:-6410','RCOND2e766257:18027a1b666:-6694','RUL2e766257:18027a1b666:-6c6a','AMT','decimal',3),('RCONST2e766257:18027a1b666:-69d0','RCOND2e766257:18027a1b666:-6bf1','RUL2e766257:18027a1b666:-6c6a','MON','integer',3),('RCONST2e766257:18027a1b666:-6a78','RCOND2e766257:18027a1b666:-6bf1','RUL2e766257:18027a1b666:-6c6a','YR','integer',2),('RCONST2e766257:18027a1b666:-7672','RCOND2e766257:18027a1b666:-779b','RUL2e766257:18027a1b666:-78b6','EXPIRYDATE','date',1),('RCONST2e766257:18027a1b666:-7742','RCOND2e766257:18027a1b666:-779b','RUL2e766257:18027a1b666:-78b6','DUEDATE','date',0),('RCONST2e766257:18027a1b666:-7811','RCOND2e766257:18027a1b666:-783f','RUL2e766257:18027a1b666:-78b6','TXNDATE','date',0),('RCONST2e766257:18027a1b666:-7a16','RC-4d346da4:17e43ccf62d:-7ff8','RUL94e7e78:17e437ee3f0:-7a44','BILLDATE','date',3),('RCONST5839c553:17cfa116791:-7cb0','RCOND5839c553:17cfa116791:-7cc0','RUL5839c553:17cfa116791:-7d05','AMT','decimal',0),('RCONST63c10b3c:17d88149545:-7bf9','RCOND63c10b3c:17d88149545:-7c1b','RUL63c10b3c:17d88149545:-7d4d','AMT','decimal',0);
/*!40000 ALTER TABLE `sys_rule_condition_var` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_rule_deployed`
--

DROP TABLE IF EXISTS `sys_rule_deployed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_rule_deployed` (
  `objid` varchar(50) NOT NULL,
  `ruletext` longtext,
  PRIMARY KEY (`objid`) USING BTREE,
  CONSTRAINT `sys_rule_deployed_ibfk_1` FOREIGN KEY (`objid`) REFERENCES `sys_rule` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_rule_deployed`
--

LOCK TABLES `sys_rule_deployed` WRITE;
/*!40000 ALTER TABLE `sys_rule_deployed` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_rule_deployed` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_rule_fact`
--

DROP TABLE IF EXISTS `sys_rule_fact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_rule_fact` (
  `objid` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `title` varchar(160) DEFAULT NULL,
  `factclass` varchar(50) DEFAULT NULL,
  `sortorder` int(11) DEFAULT NULL,
  `handler` varchar(50) DEFAULT NULL,
  `defaultvarname` varchar(25) DEFAULT NULL,
  `dynamic` int(11) DEFAULT NULL,
  `lookuphandler` varchar(50) DEFAULT NULL,
  `lookupkey` varchar(50) DEFAULT NULL,
  `lookupvalue` varchar(50) DEFAULT NULL,
  `lookupdatatype` varchar(50) DEFAULT NULL,
  `dynamicfieldname` varchar(50) DEFAULT NULL,
  `builtinconstraints` varchar(50) DEFAULT NULL,
  `domain` varchar(50) DEFAULT NULL,
  `factsuperclass` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_rule_fact`
--

LOCK TABLES `sys_rule_fact` WRITE;
/*!40000 ALTER TABLE `sys_rule_fact` DISABLE KEYS */;
INSERT INTO `sys_rule_fact` VALUES ('com.rameses.rules.common.CurrentDate','com.rameses.rules.common.CurrentDate','Current Date','com.rameses.rules.common.CurrentDate',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'SYSTEM',NULL),('market.facts.MarketAccount','market.facts.MarketAccount','Market Account','market.facts.MarketAccount',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'MARKET',NULL),('market.facts.MarketBill','market.facts.MarketBill','Market Bill','market.facts.MarketBill',1,NULL,'MBILL',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'MARKET','treasury.facts.Bill'),('market.facts.MarketBillGroup','market.facts.MarketBillGroup','Market Bill Group','market.facts.MarketBillGroup',-1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'MARKET',NULL),('market.facts.MarketBillItem','market.facts.MarketBillItem','Market Bill Item','market.facts.MarketBillItem',1,NULL,'BILLITEM',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'MARKET','treasury.facts.AbstractBillItem'),('market.facts.MarketBillSchedule','market.facts.MarketBillSchedule','Market Bill Schedule','market.facts.MarketBillSchedule',-1,NULL,'MBS',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'MARKET',NULL),('market.facts.MarketCenter','market.facts.MarketCenter','Market Center','market.facts.MarketCenter',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'MARKET',NULL),('market.facts.MarketScheduleParam','market.facts.MarketScheduleParam','Market Schedule Param','market.facts.MarketScheduleParam',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'MARKET',NULL),('market.facts.MarketUtilityConsumption','market.facts.MarketUtilityConsumption','Market Utility Consumption','market.facts.MarketUtilityConsumption',-1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'MARKET',NULL),('treasury.facts.AbstractBillItem','treasury.facts.AbstractBillItem','Abstract Bill Item','treasury.facts.AbstractBillItem',1,NULL,'ABILLITEM',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TREASURY',NULL),('treasury.facts.Bill','treasury.facts.Bill','Bill','treasury.facts.Bill',1,NULL,'BILL',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TREASURY',NULL),('treasury.facts.BillSubItem','treasury.facts.BillSubItem','Bill Sub Item','treasury.facts.BillSubItem',1,NULL,'SUBITM',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TREASURY','treasury.facts.AbstractBillItem'),('treasury.facts.CashReceipt','treasury.facts.CashReceipt','Cash Receipt','treasury.facts.CashReceipt',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TREASURY',NULL),('treasury.facts.CashReceiptItem','treasury.facts.CashReceiptItem','Cash Receipt Item','treasury.facts.CashReceiptItem',1,NULL,'CRI',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TREASURY',NULL),('treasury.facts.CreditBillItem','treasury.facts.CreditBillItem','Credit Bill Item','treasury.facts.CreditBillItem',1,NULL,'CRBILL',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TREASURY','treasury.facts.AbstractBillItem'),('treasury.facts.Deposit','treasury.facts.Deposit','Deposit','treasury.facts.Deposit',5,NULL,'PMT',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TREASURY',NULL),('treasury.facts.ExcessPayment','treasury.facts.ExcessPayment','Excess Payment','treasury.facts.ExcessPayment',5,NULL,'EXPMT',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TREASURY',NULL),('treasury.facts.HolidayFact','treasury.facts.HolidayFact','Holidays','treasury.facts.HolidayFact',1,NULL,'HOLIDAYS',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TREASURY',NULL),('treasury.facts.Payment','treasury.facts.Payment','Payment','treasury.facts.Payment',5,NULL,'PMT',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TREASURY',NULL),('treasury.facts.Requirement','treasury.facts.Requirement','Requirement','treasury.facts.Requirement',2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TREASURY',NULL),('treasury.facts.TransactionDate','treasury.facts.TransactionDate','Transaction Date','treasury.facts.TransactionDate',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TREASURY',NULL),('treasury.facts.VarInteger','treasury.facts.VarInteger','Var Integer','treasury.facts.VarInteger',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TREASURY',NULL);
/*!40000 ALTER TABLE `sys_rule_fact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_rule_fact_field`
--

DROP TABLE IF EXISTS `sys_rule_fact_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_rule_fact_field` (
  `objid` varchar(100) NOT NULL DEFAULT '',
  `parentid` varchar(50) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `title` varchar(160) DEFAULT NULL,
  `datatype` varchar(50) DEFAULT NULL,
  `sortorder` int(11) DEFAULT NULL,
  `handler` varchar(50) DEFAULT NULL,
  `lookuphandler` varchar(50) DEFAULT NULL,
  `lookupkey` varchar(50) DEFAULT NULL,
  `lookupvalue` varchar(50) DEFAULT NULL,
  `lookupdatatype` varchar(50) DEFAULT NULL,
  `multivalued` int(11) DEFAULT NULL,
  `required` int(11) DEFAULT NULL,
  `vardatatype` varchar(50) DEFAULT NULL,
  `lovname` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `parentid` (`parentid`) USING BTREE,
  CONSTRAINT `sys_rule_fact_field_ibfk_1` FOREIGN KEY (`parentid`) REFERENCES `sys_rule_fact` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_rule_fact_field`
--

LOCK TABLES `sys_rule_fact_field` WRITE;
/*!40000 ALTER TABLE `sys_rule_fact_field` DISABLE KEYS */;
INSERT INTO `sys_rule_fact_field` VALUES ('com.rameses.rules.common.CurrentDate.date','com.rameses.rules.common.CurrentDate','date','Date','date',4,'date',NULL,NULL,NULL,NULL,NULL,NULL,'date',NULL),('com.rameses.rules.common.CurrentDate.day','com.rameses.rules.common.CurrentDate','day','Day','integer',5,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('com.rameses.rules.common.CurrentDate.month','com.rameses.rules.common.CurrentDate','month','Month','integer',3,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('com.rameses.rules.common.CurrentDate.qtr','com.rameses.rules.common.CurrentDate','qtr','Qtr','integer',1,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('com.rameses.rules.common.CurrentDate.year','com.rameses.rules.common.CurrentDate','year','Year','integer',2,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('market.facts.MarketAccount.paymentmode','market.facts.MarketAccount','paymentmode','Payment Mode','string',3,'lov',NULL,NULL,NULL,NULL,NULL,NULL,'string','MARKET_PAYMENT_MODES'),('market.facts.MarketAccount.rate','market.facts.MarketAccount','rate','Rate','decimal',1,'decimal',NULL,NULL,NULL,NULL,NULL,NULL,'decimal',NULL),('market.facts.MarketAccount.ratetype','market.facts.MarketAccount','ratetype','Rate Type','string',2,'lov',NULL,NULL,NULL,NULL,NULL,NULL,'string','MARKET_RATE_TYPE'),('market.facts.MarketAccount.unitno','market.facts.MarketAccount','unitno','Unit No','string',4,'string',NULL,NULL,NULL,NULL,NULL,NULL,'string',NULL),('market.facts.MarketBill.balance','market.facts.MarketBill','balance','Balance','decimal',8,'decimal',NULL,NULL,NULL,NULL,NULL,NULL,'decimal',NULL),('market.facts.MarketBill.balanceforward','market.facts.MarketBill','balanceforward','Balance Forward','decimal',2,'decimal',NULL,NULL,NULL,NULL,NULL,NULL,'decimal',NULL),('market.facts.MarketBill.billdate','market.facts.MarketBill','billdate','Bill Date','date',6,'date',NULL,NULL,NULL,NULL,NULL,NULL,'date',NULL),('market.facts.MarketBill.billtype','market.facts.MarketBill','billtype','Bill Type','string',9,'lov',NULL,NULL,NULL,NULL,NULL,NULL,'string','MARKET_BILL_TYPE'),('market.facts.MarketBill.month','market.facts.MarketBill','month','Month','integer',5,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('market.facts.MarketBill.objid','market.facts.MarketBill','objid','Obj ID','string',1,'string',NULL,NULL,NULL,NULL,NULL,NULL,'string',NULL),('market.facts.MarketBill.rate','market.facts.MarketBill','rate','Rate','decimal',11,'decimal',NULL,NULL,NULL,NULL,NULL,NULL,'decimal',NULL),('market.facts.MarketBill.ratetype','market.facts.MarketBill','ratetype','Rate Type','string',12,'lov',NULL,NULL,NULL,NULL,NULL,NULL,'string','MARKET_RATE_TYPE'),('market.facts.MarketBill.state','market.facts.MarketBill','state','State','string',3,'lov',NULL,NULL,NULL,NULL,NULL,NULL,'string','MARKET_BILL_STATE'),('market.facts.MarketBill.validitydate','market.facts.MarketBill','validitydate','Validity Date','date',7,'date',NULL,NULL,NULL,NULL,NULL,NULL,'date',NULL),('market.facts.MarketBill.year','market.facts.MarketBill','year','Year','integer',4,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('market.facts.MarketBill.yearmonth','market.facts.MarketBill','yearmonth','Year Month','integer',10,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('market.facts.MarketBillGroup.billtype','market.facts.MarketBillGroup','billtype','Bill Type','string',3,'lov',NULL,NULL,NULL,NULL,NULL,NULL,'string','MARKET_BILL_TYPE'),('market.facts.MarketBillGroup.id','market.facts.MarketBillGroup','id','ID','string',1,'lookup','market_billgroup:lookup','objid','objid',NULL,NULL,NULL,'string',NULL),('market.facts.MarketBillGroup.tag','market.facts.MarketBillGroup','tag','Tag','string',2,'string',NULL,NULL,NULL,NULL,NULL,NULL,'string',NULL),('market.facts.MarketBillItem.acctid','market.facts.MarketBillItem','acctid','Account','string',3,'lookup','market_itemaccount:lookup','objid','title',NULL,NULL,NULL,'string',NULL),('market.facts.MarketBillItem.amount','market.facts.MarketBillItem','amount','Amount','decimal',5,'decimal',NULL,NULL,NULL,NULL,NULL,NULL,'decimal',NULL),('market.facts.MarketBillItem.billcode','market.facts.MarketBillItem','billcode','Bill code','string',4,'lookup','market_itemaccount:lookup','objid','title',NULL,NULL,NULL,'string',NULL),('market.facts.MarketBillItem.billdate','market.facts.MarketBillItem','billdate','Bill Date','date',12,'date',NULL,NULL,NULL,NULL,NULL,NULL,'date',NULL),('market.facts.MarketBillItem.billid','market.facts.MarketBillItem','billid','Bill ID','string',2,'string',NULL,NULL,NULL,NULL,NULL,NULL,'string',NULL),('market.facts.MarketBillItem.day','market.facts.MarketBillItem','day','Day','integer',10,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('market.facts.MarketBillItem.duedate','market.facts.MarketBillItem','duedate','Due Date','date',16,'date',NULL,NULL,NULL,NULL,NULL,NULL,'date',NULL),('market.facts.MarketBillItem.forwarded','market.facts.MarketBillItem','forwarded','Forwarded','boolean',14,'boolean',NULL,NULL,NULL,NULL,NULL,NULL,'boolean',NULL),('market.facts.MarketBillItem.interest','market.facts.MarketBillItem','interest','Interest','decimal',8,'decimal',NULL,NULL,NULL,NULL,NULL,NULL,'decimal',NULL),('market.facts.MarketBillItem.month','market.facts.MarketBillItem','month','Month','integer',9,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('market.facts.MarketBillItem.objid','market.facts.MarketBillItem','objid','ObjID','string',1,'string',NULL,NULL,NULL,NULL,NULL,NULL,'string',NULL),('market.facts.MarketBillItem.remarks','market.facts.MarketBillItem','remarks','Remarks','string',13,'string',NULL,NULL,NULL,NULL,NULL,NULL,'string',NULL),('market.facts.MarketBillItem.surcharge','market.facts.MarketBillItem','surcharge','Surcharge','decimal',6,'decimal',NULL,NULL,NULL,NULL,NULL,NULL,'decimal',NULL),('market.facts.MarketBillItem.tag','market.facts.MarketBillItem','tag','Tag','string',11,'string',NULL,NULL,NULL,NULL,NULL,NULL,'string',NULL),('market.facts.MarketBillItem.year','market.facts.MarketBillItem','year','Year','integer',7,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('market.facts.MarketBillItem.yearmonth','market.facts.MarketBillItem','yearmonth','Year Month','integer',15,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('market.facts.MarketBillSchedule.billdate','market.facts.MarketBillSchedule','billdate','Bill Date','date',6,'date',NULL,NULL,NULL,NULL,NULL,NULL,'date',NULL),('market.facts.MarketBillSchedule.day','market.facts.MarketBillSchedule','day','Day','integer',3,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('market.facts.MarketBillSchedule.discdate','market.facts.MarketBillSchedule','discdate','Discount Date','date',7,'date',NULL,NULL,NULL,NULL,NULL,NULL,'date',NULL),('market.facts.MarketBillSchedule.duedate','market.facts.MarketBillSchedule','duedate','Due Date','date',8,'date',NULL,NULL,NULL,NULL,NULL,NULL,'date',NULL),('market.facts.MarketBillSchedule.expirydate','market.facts.MarketBillSchedule','expirydate','Bill Expiry Date','date',9,'date',NULL,NULL,NULL,NULL,NULL,NULL,'date',NULL),('market.facts.MarketBillSchedule.fromdate','market.facts.MarketBillSchedule','fromdate','From Date','date',4,'date',NULL,NULL,NULL,NULL,NULL,NULL,'date',NULL),('market.facts.MarketBillSchedule.month','market.facts.MarketBillSchedule','month','Month','integer',2,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('market.facts.MarketBillSchedule.todate','market.facts.MarketBillSchedule','todate','To Date','date',5,'date',NULL,NULL,NULL,NULL,NULL,NULL,'date',NULL),('market.facts.MarketBillSchedule.year','market.facts.MarketBillSchedule','year','Year','integer',1,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('market.facts.MarketCenter.name','market.facts.MarketCenter','name','Name','string',1,'lookup','market_center:lookup','objid','name',NULL,NULL,NULL,'string',NULL),('market.facts.MarketCenter.orgunit','market.facts.MarketCenter','orgunit','Org Unit','string',2,'string',NULL,NULL,NULL,NULL,NULL,NULL,'string',NULL),('market.facts.MarketScheduleParam.action','market.facts.MarketScheduleParam','action','Action','string',4,'lov',NULL,NULL,NULL,NULL,NULL,NULL,'string','MARKET_SCHEDULE_ACTION'),('market.facts.MarketScheduleParam.date','market.facts.MarketScheduleParam','date','Date','date',5,'date',NULL,NULL,NULL,NULL,NULL,NULL,'date',NULL),('market.facts.MarketScheduleParam.day','market.facts.MarketScheduleParam','day','Day','integer',3,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('market.facts.MarketScheduleParam.month','market.facts.MarketScheduleParam','month','Month','integer',2,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('market.facts.MarketScheduleParam.year','market.facts.MarketScheduleParam','year','Year','integer',1,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('market.facts.MarketUtilityConsumption.amount','market.facts.MarketUtilityConsumption','amount','Amount','decimal',2,'decimal',NULL,NULL,NULL,NULL,NULL,NULL,'decimal',NULL),('market.facts.MarketUtilityConsumption.billtype','market.facts.MarketUtilityConsumption','billtype','Bill Type','string',3,'lov',NULL,NULL,NULL,NULL,NULL,NULL,'string','MARKET_CONSUMPTION_TYPE'),('market.facts.MarketUtilityConsumption.volume','market.facts.MarketUtilityConsumption','volume','Volume','integer',1,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('treasury.facts.AbstractBillItem.acctid','treasury.facts.AbstractBillItem','acctid','Account','string',2,'lookup','itemaccount:lookup','objid','title',NULL,NULL,NULL,'string',NULL),('treasury.facts.AbstractBillItem.amount','treasury.facts.AbstractBillItem','amount','Amount','decimal',3,'decimal',NULL,NULL,NULL,NULL,NULL,NULL,'decimal',NULL),('treasury.facts.AbstractBillItem.objid','treasury.facts.AbstractBillItem','objid','ObjID','string',1,'string',NULL,NULL,NULL,NULL,NULL,NULL,'string',NULL),('treasury.facts.Bill.amount','treasury.facts.Bill','amount','Amount','decimal',6,'decimal',NULL,NULL,NULL,NULL,NULL,NULL,'decimal',NULL),('treasury.facts.Bill.balance','treasury.facts.Bill','balance','Balance','decimal',8,'decimal',NULL,NULL,NULL,NULL,NULL,NULL,'decimal',NULL),('treasury.facts.Bill.balanceforward','treasury.facts.Bill','balanceforward','Balance Forward','decimal',4,'decimal',NULL,NULL,NULL,NULL,NULL,NULL,'decimal',NULL),('treasury.facts.Bill.billdate','treasury.facts.Bill','billdate','Bill Date','date',5,'date',NULL,NULL,NULL,NULL,NULL,NULL,'date',NULL),('treasury.facts.Bill.expirydate','treasury.facts.Bill','expirydate','Expiry Date','date',3,'date',NULL,NULL,NULL,NULL,NULL,NULL,'date',NULL),('treasury.facts.Bill.objid','treasury.facts.Bill','objid','ObjID',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('treasury.facts.Bill.state','treasury.facts.Bill','state','State','string',7,'lov',NULL,NULL,NULL,NULL,NULL,NULL,'string','MARKET_BILL_STATE'),('treasury.facts.Bill.validitydate','treasury.facts.Bill','validitydate','Validity Date','date',2,'date',NULL,NULL,NULL,NULL,NULL,NULL,'date',NULL),('treasury.facts.BillSubItem.acctid','treasury.facts.BillSubItem','acctid','Account','string',2,'lookup','itemaccount:lookup','objid','title',NULL,NULL,NULL,'string',NULL),('treasury.facts.BillSubItem.amount','treasury.facts.BillSubItem','amount','Amount','decimal',3,'decimal',NULL,NULL,NULL,NULL,NULL,NULL,'decimal',NULL),('treasury.facts.BillSubItem.billitemrefid','treasury.facts.BillSubItem','billitemrefid','Bill Item Refid','string',5,'string',NULL,NULL,NULL,NULL,NULL,NULL,'string',NULL),('treasury.facts.BillSubItem.objid','treasury.facts.BillSubItem','objid','ObjID','string',1,'string',NULL,NULL,NULL,NULL,NULL,NULL,'string',NULL),('treasury.facts.BillSubItem.type','treasury.facts.BillSubItem','type','Type','string',4,'lov',NULL,NULL,NULL,NULL,NULL,NULL,'string','SUB_BILLITEM_TYPE'),('treasury.facts.CashReceipt.receiptdate','treasury.facts.CashReceipt','receiptdate','Receipt Date','date',2,'date',NULL,NULL,NULL,NULL,NULL,NULL,'date',NULL),('treasury.facts.CashReceipt.txnmode','treasury.facts.CashReceipt','txnmode','Txn Mode','string',1,'string',NULL,NULL,NULL,NULL,NULL,NULL,'string',NULL),('treasury.facts.CashReceiptItem.account','treasury.facts.CashReceiptItem','account','Account','string',1,'lookup','itemaccount:lookup','objid','title',NULL,NULL,NULL,'string',NULL),('treasury.facts.CashReceiptItem.amount','treasury.facts.CashReceiptItem','amount','Amount','decimal',2,'decimal',NULL,NULL,NULL,NULL,NULL,NULL,'decimal',NULL),('treasury.facts.CashReceiptItem.billitems','treasury.facts.CashReceiptItem','billitems','Bill Items','string',4,'var',NULL,NULL,NULL,NULL,NULL,NULL,'object',NULL),('treasury.facts.CashReceiptItem.remarks','treasury.facts.CashReceiptItem','remarks','Remarks','string',3,'string',NULL,NULL,NULL,NULL,NULL,NULL,'string',NULL),('treasury.facts.CreditBillItem.amount','treasury.facts.CreditBillItem','amount','Amount','decimal',1,'decimal',NULL,NULL,NULL,NULL,NULL,NULL,'decimal',NULL),('treasury.facts.CreditBillItem.billcode','treasury.facts.CreditBillItem','billcode','Bill code','string',2,'lookup','waterworks_itemaccount:lookup','objid','title',NULL,NULL,NULL,'string',NULL),('treasury.facts.Deposit.amount','treasury.facts.Deposit','amount','Amount','decimal',1,'decimal',NULL,NULL,NULL,NULL,NULL,NULL,'decimal',NULL),('treasury.facts.ExcessPayment.amount','treasury.facts.ExcessPayment','amount','Amount','decimal',1,'decimal',NULL,NULL,NULL,NULL,NULL,NULL,'decimal',NULL),('treasury.facts.HolidayFact.id','treasury.facts.HolidayFact','id','ID','string',1,'string',NULL,NULL,NULL,NULL,NULL,NULL,'string',NULL),('treasury.facts.Payment.amount','treasury.facts.Payment','amount','Amount','decimal',1,'decimal',NULL,NULL,NULL,NULL,NULL,NULL,'decimal',NULL),('treasury.facts.Requirement.code','treasury.facts.Requirement','code','Code','string',1,'lookup','requirementtype:lookup','code','title',NULL,NULL,NULL,'string',NULL),('treasury.facts.Requirement.completed','treasury.facts.Requirement','completed','Completed','boolean',2,'boolean',NULL,NULL,NULL,NULL,NULL,NULL,'boolean',NULL),('treasury.facts.TransactionDate.date','treasury.facts.TransactionDate','date','Date','date',1,'date',NULL,NULL,NULL,NULL,NULL,NULL,'date',NULL),('treasury.facts.TransactionDate.day','treasury.facts.TransactionDate','day','Day','integer',4,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('treasury.facts.TransactionDate.month','treasury.facts.TransactionDate','month','Month','integer',3,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('treasury.facts.TransactionDate.qtr','treasury.facts.TransactionDate','qtr','Qtr','integer',5,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('treasury.facts.TransactionDate.tag','treasury.facts.TransactionDate','tag','Tag','string',6,'string',NULL,NULL,NULL,NULL,NULL,NULL,'string',NULL),('treasury.facts.TransactionDate.year','treasury.facts.TransactionDate','year','Year','integer',2,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL),('treasury.facts.VarInteger.tag','treasury.facts.VarInteger','tag','Tag','string',2,'string',NULL,NULL,NULL,NULL,NULL,NULL,'string',NULL),('treasury.facts.VarInteger.value','treasury.facts.VarInteger','value','Value','integer',1,'integer',NULL,NULL,NULL,NULL,NULL,NULL,'integer',NULL);
/*!40000 ALTER TABLE `sys_rule_fact_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_rulegroup`
--

DROP TABLE IF EXISTS `sys_rulegroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_rulegroup` (
  `name` varchar(50) NOT NULL,
  `ruleset` varchar(50) NOT NULL,
  `title` varchar(160) DEFAULT NULL,
  `sortorder` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`,`ruleset`) USING BTREE,
  KEY `ruleset` (`ruleset`) USING BTREE,
  CONSTRAINT `sys_rulegroup_ibfk_1` FOREIGN KEY (`ruleset`) REFERENCES `sys_ruleset` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_rulegroup`
--

LOCK TABLES `sys_rulegroup` WRITE;
/*!40000 ALTER TABLE `sys_rulegroup` DISABLE KEYS */;
INSERT INTO `sys_rulegroup` VALUES ('apply-payment','marketpayment','Payment',1),('compute-fees','marketbilling','Compute Fees',1),('compute-interest','marketbilling','Compute Interest',3),('compute-surcharge','marketbilling','Compute Surcharge',2),('initial','marketbilling','Initial',0),('initial','marketbillingschedule','Initial',0),('initial','marketpayment','Initial',0),('map-account','marketbilling','Map Accounts',5),('map-account','marketpayment','Map Account',2),('post-map-account','marketpayment','Post Map Account',3),('set-schedule','marketbillingschedule','Set Schedule',1),('summary','marketbilling','Summary',4);
/*!40000 ALTER TABLE `sys_rulegroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_ruleset`
--

DROP TABLE IF EXISTS `sys_ruleset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_ruleset` (
  `name` varchar(50) NOT NULL,
  `title` varchar(160) DEFAULT NULL,
  `packagename` varchar(50) DEFAULT NULL,
  `domain` varchar(50) DEFAULT NULL,
  `role` varchar(50) DEFAULT NULL,
  `permission` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_ruleset`
--

LOCK TABLES `sys_ruleset` WRITE;
/*!40000 ALTER TABLE `sys_ruleset` DISABLE KEYS */;
INSERT INTO `sys_ruleset` VALUES ('marketbilling','Market Billing','marketbilling','MARKET','RULE_AUTHOR',NULL),('marketbillingschedule','Market Billing Schedule','marketbillingschedule','MARKET','RULE_AUTHOR',NULL),('marketpayment','Market Payment','marketpayment','MARKET','RULE_AUTHOR',NULL);
/*!40000 ALTER TABLE `sys_ruleset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_ruleset_actiondef`
--

DROP TABLE IF EXISTS `sys_ruleset_actiondef`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_ruleset_actiondef` (
  `ruleset` varchar(50) NOT NULL,
  `actiondef` varchar(50) NOT NULL,
  PRIMARY KEY (`ruleset`,`actiondef`) USING BTREE,
  KEY `actiondef` (`actiondef`) USING BTREE,
  CONSTRAINT `fk_sys_ruleset_actiondef_actiondef` FOREIGN KEY (`actiondef`) REFERENCES `sys_rule_actiondef` (`objid`),
  CONSTRAINT `sys_ruleset_actiondef_ibfk_2` FOREIGN KEY (`ruleset`) REFERENCES `sys_ruleset` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_ruleset_actiondef`
--

LOCK TABLES `sys_ruleset_actiondef` WRITE;
/*!40000 ALTER TABLE `sys_ruleset_actiondef` DISABLE KEYS */;
INSERT INTO `sys_ruleset_actiondef` VALUES ('marketbilling','enterprise.actions.PrintTest'),('marketbilling','enterprise.actions.ThrowException'),('marketbillingschedule','enterprise.actions.ThrowException'),('marketpayment','enterprise.actions.ThrowException'),('marketbilling','market.actions.AddMarketBillItem'),('marketbillingschedule','market.actions.AddMarketBillSchedule'),('marketbillingschedule','market.actions.SetMarketBillSchedule'),('marketpayment','treasury.actions.AddCashReceiptItem'),('marketpayment','treasury.actions.AddCreditBillItem'),('marketpayment','treasury.actions.AddDiscountItem'),('marketbilling','treasury.actions.AddInterestItem'),('marketbilling','treasury.actions.AddSurchargeItem'),('marketpayment','treasury.actions.ApplyPayment'),('marketbilling','treasury.actions.RemoveBillItem'),('marketpayment','treasury.actions.SetBillItemAccount'),('marketbilling','treasury.actions.SetBillItemProperty'),('marketbilling','treasury.actions.SetBillValidityDate'),('marketpayment','treasury.actions.SetCashReceiptItemRemarks'),('marketbilling','treasury.actions.UpdateBillItemAmount');
/*!40000 ALTER TABLE `sys_ruleset_actiondef` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_ruleset_fact`
--

DROP TABLE IF EXISTS `sys_ruleset_fact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_ruleset_fact` (
  `ruleset` varchar(50) NOT NULL,
  `rulefact` varchar(50) NOT NULL,
  PRIMARY KEY (`ruleset`,`rulefact`) USING BTREE,
  KEY `rulefact` (`rulefact`) USING BTREE,
  CONSTRAINT `fk_sys_ruleset_fact_rulefact` FOREIGN KEY (`rulefact`) REFERENCES `sys_rule_fact` (`objid`),
  CONSTRAINT `sys_ruleset_fact_ibfk_2` FOREIGN KEY (`ruleset`) REFERENCES `sys_ruleset` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_ruleset_fact`
--

LOCK TABLES `sys_ruleset_fact` WRITE;
/*!40000 ALTER TABLE `sys_ruleset_fact` DISABLE KEYS */;
INSERT INTO `sys_ruleset_fact` VALUES ('marketpayment','com.rameses.rules.common.CurrentDate'),('marketbilling','market.facts.MarketAccount'),('marketpayment','market.facts.MarketAccount'),('marketbilling','market.facts.MarketBill'),('marketbilling','market.facts.MarketBillGroup'),('marketbillingschedule','market.facts.MarketBillGroup'),('marketbilling','market.facts.MarketBillItem'),('marketpayment','market.facts.MarketBillItem'),('marketbilling','market.facts.MarketBillSchedule'),('marketbillingschedule','market.facts.MarketBillSchedule'),('marketbilling','market.facts.MarketCenter'),('marketpayment','market.facts.MarketCenter'),('marketbillingschedule','market.facts.MarketScheduleParam'),('marketbilling','market.facts.MarketUtilityConsumption'),('marketbilling','treasury.facts.AbstractBillItem'),('marketpayment','treasury.facts.AbstractBillItem'),('marketbilling','treasury.facts.Bill'),('marketbilling','treasury.facts.BillSubItem'),('marketpayment','treasury.facts.BillSubItem'),('marketpayment','treasury.facts.CashReceiptItem'),('marketpayment','treasury.facts.CreditBillItem'),('marketpayment','treasury.facts.ExcessPayment'),('marketbillingschedule','treasury.facts.HolidayFact'),('marketpayment','treasury.facts.Payment'),('marketbilling','treasury.facts.TransactionDate'),('marketpayment','treasury.facts.TransactionDate');
/*!40000 ALTER TABLE `sys_ruleset_fact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_sequence`
--

DROP TABLE IF EXISTS `sys_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_sequence` (
  `objid` varchar(100) NOT NULL,
  `nextSeries` int(11) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_sequence`
--

LOCK TABLES `sys_sequence` WRITE;
/*!40000 ALTER TABLE `sys_sequence` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user` (
  `objid` varchar(50) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `middlename` varchar(50) DEFAULT NULL,
  `name` varchar(150) DEFAULT NULL,
  `jobtitle` varchar(50) DEFAULT NULL,
  `txncode` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  UNIQUE KEY `uix_username` (`username`) USING BTREE,
  KEY `ix_lastname_firstname` (`lastname`,`firstname`) USING BTREE,
  KEY `ix_name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_role`
--

DROP TABLE IF EXISTS `sys_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user_role` (
  `objid` varchar(50) NOT NULL,
  `role` varchar(50) DEFAULT NULL,
  `userid` varchar(50) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `org_objid` varchar(50) DEFAULT NULL,
  `org_name` varchar(50) DEFAULT NULL,
  `securitygroup_objid` varchar(50) DEFAULT NULL,
  `exclude` varchar(255) DEFAULT NULL,
  `uid` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  UNIQUE KEY `uix_sys_user_role_uid` (`uid`) USING BTREE,
  KEY `fk_sys_user_role_role` (`role`) USING BTREE,
  KEY `fk_sys_user_role_userid` (`userid`) USING BTREE,
  CONSTRAINT `fk_sys_user_role_role` FOREIGN KEY (`role`) REFERENCES `sys_role` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_role`
--

LOCK TABLES `sys_user_role` WRITE;
/*!40000 ALTER TABLE `sys_user_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_var`
--

DROP TABLE IF EXISTS `sys_var`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_var` (
  `name` varchar(50) NOT NULL,
  `value` longtext,
  `description` varchar(255) DEFAULT NULL,
  `datatype` varchar(15) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_var`
--

LOCK TABLES `sys_var` WRITE;
/*!40000 ALTER TABLE `sys_var` DISABLE KEYS */;
INSERT INTO `sys_var` VALUES ('market_account_acctno','[marketcode]-[yyyy][MM]-[%06d]',NULL,NULL,NULL),('market_batch_billno','BAT-[yyyy][MM]-[%06d]',NULL,NULL,NULL),('market_batch_rental_rate_no','MRR[yyyy][MM][%06d]',NULL,NULL,NULL),('market_changeapp_appno','MCA-[yyyy][MM][%06d]',NULL,NULL,NULL),('market_compromise_controlno','MCOMP-[yyyy][MM][%06d]',NULL,NULL,NULL),('market_electricity_acctno','ME-[yyyy][MM]-[%06d]',NULL,NULL,NULL),('market_electricity_billno','EB-[yyyy][MM]-[%06d]',NULL,NULL,NULL),('market_rental_acctno','MR-[yyyy][MM]-[%06d]',NULL,NULL,NULL),('market_rental_billno','RB-[yyyy][MM]-[%06d]',NULL,NULL,NULL);
/*!40000 ALTER TABLE `sys_var` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_wf`
--

DROP TABLE IF EXISTS `sys_wf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_wf` (
  `name` varchar(50) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `domain` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_wf`
--

LOCK TABLES `sys_wf` WRITE;
/*!40000 ALTER TABLE `sys_wf` DISABLE KEYS */;
INSERT INTO `sys_wf` VALUES ('market_batch_bill','Market Batch Bill','MARKET'),('market_changeapp','Market Change Application','MARKET');
/*!40000 ALTER TABLE `sys_wf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_wf_eventaction`
--

DROP TABLE IF EXISTS `sys_wf_eventaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_wf_eventaction` (
  `processname` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `eventtype` varchar(10) DEFAULT NULL,
  `index` int(2) DEFAULT NULL,
  `nodename` varchar(50) DEFAULT NULL,
  `transitionto` varchar(50) DEFAULT NULL,
  `scriptname` varchar(255) DEFAULT NULL,
  `method` varchar(50) DEFAULT NULL,
  `params` varchar(255) DEFAULT NULL,
  `retval` varchar(255) DEFAULT NULL,
  `active` int(1) DEFAULT NULL,
  PRIMARY KEY (`processname`,`name`) USING BTREE,
  KEY `fk_sys_wf_eventaction_transition` (`processname`,`nodename`,`transitionto`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_wf_eventaction`
--

LOCK TABLES `sys_wf_eventaction` WRITE;
/*!40000 ALTER TABLE `sys_wf_eventaction` DISABLE KEYS */;
INSERT INTO `sys_wf_eventaction` VALUES ('market_batch_bill','load-batch-info','before',1,'route-process',NULL,'MarketBatchBillingService','getInfo','[ batchid: refid ]',NULL,1),('market_changeapp','check-has-billing','before',1,'check-has-billing',NULL,'MarketChangeAppService','getHasBilling','[ appid: refid ]',NULL,1),('market_changeapp','update-account-after-approval','after',1,'check-has-billing','end','MarketChangeAppService','updateAccount','[ appid: refid ]',NULL,1),('market_changeapp','update-account-after-post-payment','after',1,'payment','end','MarketChangeAppService','updateAccount','[appid: refid ]',NULL,1);
/*!40000 ALTER TABLE `sys_wf_eventaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_wf_node`
--

DROP TABLE IF EXISTS `sys_wf_node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_wf_node` (
  `name` varchar(50) NOT NULL,
  `processname` varchar(50) NOT NULL DEFAULT '',
  `title` varchar(100) DEFAULT NULL,
  `nodetype` varchar(10) DEFAULT NULL,
  `idx` int(11) DEFAULT NULL,
  `salience` int(11) DEFAULT NULL,
  `domain` varchar(50) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `ui` text,
  `properties` text,
  `tracktime` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`,`processname`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_wf_node`
--

LOCK TABLES `sys_wf_node` WRITE;
/*!40000 ALTER TABLE `sys_wf_node` DISABLE KEYS */;
INSERT INTO `sys_wf_node` VALUES ('approval','market_changeapp','Approval','state',2,1,NULL,NULL,'[type:\"state\",fillColor:\"#c0c0c0\",pos:[326,37],size:[109,49]]','[:]',1),('check-has-billing','market_changeapp','Check Has Billing','decision',3,0,NULL,NULL,'[type:\"decision\",fillColor:\"#c0c0c0\",pos:[429,141],size:[124,59]]','[:]',NULL),('end','market_batch_bill','Closed','end',4,0,NULL,NULL,'[type:\"end\",fillColor:\"#ff0000\",pos:[825,364],size:[32,32]]','[:]',NULL),('end','market_changeapp','Completed','end',5,0,NULL,NULL,'[type:\"end\",fillColor:\"#ff0000\",pos:[496,458],size:[32,32]]','[:]',NULL),('open','market_batch_bill','Open','state',1,0,'MARKET','BILLER','[type:\"state\",fillColor:\"#c0c0c0\",pos:[518,170],size:[97,39]]','[:]',1),('payment','market_changeapp','Payment','state',4,1,NULL,NULL,'[type:\"state\",fillColor:\"#c0c0c0\",pos:[334,289],size:[110,44]]','[:]',1),('posted','market_batch_bill','Posted','state',2,0,'MARKET','BILLER','[type:\"state\",fillColor:\"#c0c0c0\",pos:[475,363],size:[101,35]]','[:]',0),('processing','market_batch_bill','Processing','state',0,0,'MARKET','SYSTEM','[type:\"state\",fillColor:\"#c0c0c0\",pos:[198,102],size:[102,37]]','[:]',NULL),('route-process','market_batch_bill','Route','decision',0,0,NULL,NULL,'[type:\"decision\",fillColor:\"#c0c0c0\",pos:[264,182],size:[121,52]]','[:]',NULL),('start','market_batch_bill','Start','start',0,0,NULL,NULL,'[type:\"start\",fillColor:\"#00ff00\",pos:[114,28],size:[32,32]]','[:]',NULL),('start','market_changeapp','start','start',1,NULL,NULL,NULL,'[type:\"start\",fillColor:\"#00ff00\",pos:[159,29],size:[32,32]]','[:]',NULL);
/*!40000 ALTER TABLE `sys_wf_node` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_wf_transition`
--

DROP TABLE IF EXISTS `sys_wf_transition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_wf_transition` (
  `parentid` varchar(50) NOT NULL DEFAULT '',
  `processname` varchar(50) NOT NULL DEFAULT '',
  `action` varchar(50) NOT NULL,
  `to` varchar(50) NOT NULL,
  `idx` int(11) DEFAULT NULL,
  `eval` mediumtext,
  `properties` varchar(255) DEFAULT NULL,
  `permission` varchar(255) DEFAULT NULL,
  `caption` varchar(255) DEFAULT NULL,
  `ui` text,
  PRIMARY KEY (`parentid`,`processname`,`to`,`action`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_wf_transition`
--

LOCK TABLES `sys_wf_transition` WRITE;
/*!40000 ALTER TABLE `sys_wf_transition` DISABLE KEYS */;
INSERT INTO `sys_wf_transition` VALUES ('approval','market_changeapp','approve','check-has-billing',0,NULL,'[showConfirm:true,confirmMessage:\"You are about to approve this change. Proceed?\"]',NULL,'Approve','[points:[405,86,461,141],type:\"arrow\",pos:[405,86],size:[56,55]]'),('check-has-billing','market_changeapp','has-no-billing','end',0,'#{ info.hasbilling == false }','[:]',NULL,'Post Approved','[points:[493,200,513,458],type:\"arrow\",pos:[493,200],size:[20,258]]'),('check-has-billing','market_changeapp','has-billing','payment',0,'#{ info.hasbilling  == true }','[:]',NULL,'Has Billing','[points:[431,170,376,171,374,288],type:\"arrow\",pos:[374,170],size:[57,118]]'),('open','market_batch_bill','post','posted',0,NULL,'[showConfirm:true,confirmMessage:\"You are about to post this batch. This cannot be edited once posted. Proceed?\"]',NULL,'Post','[points:[566,209,525,363],type:\"arrow\",pos:[525,209],size:[41,154]]'),('payment','market_changeapp','post-payment','end',0,NULL,'[:]',NULL,'Post Payment','[points:[405,333,500,458],type:\"arrow\",pos:[405,333],size:[95,125]]'),('posted','market_batch_bill','end','end',0,NULL,'[visibleWhen:\"#{ false }\"]',NULL,'Submit to end','[points:[547,398,825,365],type:\"arrow\",pos:[547,365],size:[278,33]]'),('posted','market_batch_bill','resend-to-open','open',0,NULL,'[:]',NULL,'Resend to Open','[points:[554,363,625,322,626,317,593,209],type:\"arrow\",pos:[554,209],size:[72,154]]'),('processing','market_batch_bill','submit-route','route-process',0,NULL,'[:]',NULL,'Submit','[points:[265,139,307,182],type:\"arrow\",pos:[265,139],size:[42,43]]'),('route-process','market_batch_bill','send-to-open','open',0,'#{ info.autopost == 0 }','[:]',NULL,'Send to Open','[points:[385,203,518,193],type:\"arrow\",pos:[385,193],size:[133,10]]'),('route-process','market_batch_bill','send-to-posted','posted',0,'#{ info.autopost == 1 }','[:]',NULL,'Send to Posted','[points:[354,234,503,363],type:\"arrow\",pos:[354,234],size:[149,129]]'),('start','market_batch_bill','start','processing',0,NULL,'[:]',NULL,'Start','[points:[146,54,220,102],type:\"arrow\",pos:[146,54],size:[74,48]]'),('start','market_changeapp','start','approval',0,NULL,'[:]',NULL,'Start','[points:[191,46,326,56],type:\"arrow\",pos:[191,46],size:[135,10]]');
/*!40000 ALTER TABLE `sys_wf_transition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `vw_market_account`
--

DROP TABLE IF EXISTS `vw_market_account`;
/*!50001 DROP VIEW IF EXISTS `vw_market_account`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_market_account` (
  `objid` tinyint NOT NULL,
  `state` tinyint NOT NULL,
  `acctno` tinyint NOT NULL,
  `dtcreated` tinyint NOT NULL,
  `createdby_objid` tinyint NOT NULL,
  `createdby_name` tinyint NOT NULL,
  `remarks` tinyint NOT NULL,
  `txnmode` tinyint NOT NULL,
  `acctinfoid` tinyint NOT NULL,
  `acctname` tinyint NOT NULL,
  `owner_name` tinyint NOT NULL,
  `owner_address_text` tinyint NOT NULL,
  `owner_entitytype` tinyint NOT NULL,
  `owner_profileid` tinyint NOT NULL,
  `owner_profileno` tinyint NOT NULL,
  `owner_firstname` tinyint NOT NULL,
  `owner_lastname` tinyint NOT NULL,
  `owner_middlename` tinyint NOT NULL,
  `owner_resident` tinyint NOT NULL,
  `owner_address_unitno` tinyint NOT NULL,
  `owner_address_bldgno` tinyint NOT NULL,
  `owner_address_bldgname` tinyint NOT NULL,
  `owner_address_street` tinyint NOT NULL,
  `owner_address_subdivision` tinyint NOT NULL,
  `owner_address_barangay_objid` tinyint NOT NULL,
  `owner_address_barangay_name` tinyint NOT NULL,
  `owner_address_citymunicipality` tinyint NOT NULL,
  `owner_address_province` tinyint NOT NULL,
  `owner_tin` tinyint NOT NULL,
  `owner_email` tinyint NOT NULL,
  `owner_mobileno` tinyint NOT NULL,
  `owner_phoneno` tinyint NOT NULL,
  `owner_id_type_name` tinyint NOT NULL,
  `owner_id_idno` tinyint NOT NULL,
  `owner_id_placeissued` tinyint NOT NULL,
  `owner_id_dtissued` tinyint NOT NULL,
  `contact_mobileno` tinyint NOT NULL,
  `contact_email` tinyint NOT NULL,
  `contact_phoneno` tinyint NOT NULL,
  `unitid` tinyint NOT NULL,
  `paymentmode` tinyint NOT NULL,
  `business_objid` tinyint NOT NULL,
  `business_bin` tinyint NOT NULL,
  `business_tradename` tinyint NOT NULL,
  `unitno` tinyint NOT NULL,
  `areasqm` tinyint NOT NULL,
  `centerid` tinyint NOT NULL,
  `center_name` tinyint NOT NULL,
  `billgroupid` tinyint NOT NULL,
  `orgunitid` tinyint NOT NULL,
  `orgunit_name` tinyint NOT NULL,
  `orgunit_fullpath` tinyint NOT NULL,
  `rateid` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_market_account_info`
--

DROP TABLE IF EXISTS `vw_market_account_info`;
/*!50001 DROP VIEW IF EXISTS `vw_market_account_info`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_market_account_info` (
  `objid` tinyint NOT NULL,
  `acctid` tinyint NOT NULL,
  `acctname` tinyint NOT NULL,
  `owner_objid` tinyint NOT NULL,
  `owner_name` tinyint NOT NULL,
  `owner_address_text` tinyint NOT NULL,
  `owner_entitytype` tinyint NOT NULL,
  `owner_profileid` tinyint NOT NULL,
  `owner_profileno` tinyint NOT NULL,
  `owner_firstname` tinyint NOT NULL,
  `owner_lastname` tinyint NOT NULL,
  `owner_middlename` tinyint NOT NULL,
  `owner_resident` tinyint NOT NULL,
  `owner_address_objid` tinyint NOT NULL,
  `owner_address_unitno` tinyint NOT NULL,
  `owner_address_bldgno` tinyint NOT NULL,
  `owner_address_bldgname` tinyint NOT NULL,
  `owner_address_street` tinyint NOT NULL,
  `owner_address_subdivision` tinyint NOT NULL,
  `owner_address_barangay_objid` tinyint NOT NULL,
  `owner_address_barangay_name` tinyint NOT NULL,
  `owner_address_citymunicipality` tinyint NOT NULL,
  `owner_address_province` tinyint NOT NULL,
  `owner_tin` tinyint NOT NULL,
  `owner_email` tinyint NOT NULL,
  `owner_mobileno` tinyint NOT NULL,
  `owner_phoneno` tinyint NOT NULL,
  `owner_id_type_name` tinyint NOT NULL,
  `owner_id_idno` tinyint NOT NULL,
  `owner_id_placeissued` tinyint NOT NULL,
  `owner_id_dtissued` tinyint NOT NULL,
  `contact_mobileno` tinyint NOT NULL,
  `contact_email` tinyint NOT NULL,
  `contact_phoneno` tinyint NOT NULL,
  `unitid` tinyint NOT NULL,
  `paymentmode` tinyint NOT NULL,
  `business_objid` tinyint NOT NULL,
  `business_bin` tinyint NOT NULL,
  `business_tradename` tinyint NOT NULL,
  `txnid` tinyint NOT NULL,
  `txntype` tinyint NOT NULL,
  `unit_objid` tinyint NOT NULL,
  `unit_code` tinyint NOT NULL,
  `unit_centerid` tinyint NOT NULL,
  `unit_areasqm` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_market_batch_bill`
--

DROP TABLE IF EXISTS `vw_market_batch_bill`;
/*!50001 DROP VIEW IF EXISTS `vw_market_batch_bill`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_market_batch_bill` (
  `objid` tinyint NOT NULL,
  `billtype` tinyint NOT NULL,
  `billgroupid` tinyint NOT NULL,
  `billscheduleid` tinyint NOT NULL,
  `batchdate` tinyint NOT NULL,
  `taskid` tinyint NOT NULL,
  `procstate` tinyint NOT NULL,
  `counter` tinyint NOT NULL,
  `totalcount` tinyint NOT NULL,
  `autopost` tinyint NOT NULL,
  `autogenerate` tinyint NOT NULL,
  `task_state` tinyint NOT NULL,
  `task_dtcreated` tinyint NOT NULL,
  `task_startdate` tinyint NOT NULL,
  `task_enddate` tinyint NOT NULL,
  `task_assignee_objid` tinyint NOT NULL,
  `task_assignee_name` tinyint NOT NULL,
  `task_actor_objid` tinyint NOT NULL,
  `task_actor_name` tinyint NOT NULL,
  `task_title` tinyint NOT NULL,
  `task_tracktime` tinyint NOT NULL,
  `task_properties` tinyint NOT NULL,
  `year` tinyint NOT NULL,
  `month` tinyint NOT NULL,
  `fromdate` tinyint NOT NULL,
  `billdate` tinyint NOT NULL,
  `todate` tinyint NOT NULL,
  `discdate` tinyint NOT NULL,
  `duedate` tinyint NOT NULL,
  `expirydate` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_market_bill`
--

DROP TABLE IF EXISTS `vw_market_bill`;
/*!50001 DROP VIEW IF EXISTS `vw_market_bill`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_market_bill` (
  `objid` tinyint NOT NULL,
  `prevbillid` tinyint NOT NULL,
  `billtype` tinyint NOT NULL,
  `billno` tinyint NOT NULL,
  `billdate` tinyint NOT NULL,
  `lasttxndate` tinyint NOT NULL,
  `validitydate` tinyint NOT NULL,
  `acctid` tinyint NOT NULL,
  `acctinfoid` tinyint NOT NULL,
  `state` tinyint NOT NULL,
  `remarks` tinyint NOT NULL,
  `balanceforward` tinyint NOT NULL,
  `totalpayment` tinyint NOT NULL,
  `interest` tinyint NOT NULL,
  `surcharge` tinyint NOT NULL,
  `amount` tinyint NOT NULL,
  `discount` tinyint NOT NULL,
  `txnmode` tinyint NOT NULL,
  `hold` tinyint NOT NULL,
  `uid` tinyint NOT NULL,
  `billscheduleid` tinyint NOT NULL,
  `batchid` tinyint NOT NULL,
  `unitno` tinyint NOT NULL,
  `acctno` tinyint NOT NULL,
  `acctname` tinyint NOT NULL,
  `year` tinyint NOT NULL,
  `month` tinyint NOT NULL,
  `fromdate` tinyint NOT NULL,
  `todate` tinyint NOT NULL,
  `duedate` tinyint NOT NULL,
  `expirydate` tinyint NOT NULL,
  `billgroupid` tinyint NOT NULL,
  `balance` tinyint NOT NULL,
  `orgunit_name` tinyint NOT NULL,
  `orgunit_fullpath` tinyint NOT NULL,
  `center_name` tinyint NOT NULL,
  `owner_objid` tinyint NOT NULL,
  `owner_name` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_market_billgroup_unit_electricity`
--

DROP TABLE IF EXISTS `vw_market_billgroup_unit_electricity`;
/*!50001 DROP VIEW IF EXISTS `vw_market_billgroup_unit_electricity`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_market_billgroup_unit_electricity` (
  `objid` tinyint NOT NULL,
  `code` tinyint NOT NULL,
  `fullpath` tinyint NOT NULL,
  `billgroupid` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_market_billgroup_unit_rental`
--

DROP TABLE IF EXISTS `vw_market_billgroup_unit_rental`;
/*!50001 DROP VIEW IF EXISTS `vw_market_billgroup_unit_rental`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_market_billgroup_unit_rental` (
  `objid` tinyint NOT NULL,
  `code` tinyint NOT NULL,
  `fullpath` tinyint NOT NULL,
  `billgroupid` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_market_billgroup_unit_water`
--

DROP TABLE IF EXISTS `vw_market_billgroup_unit_water`;
/*!50001 DROP VIEW IF EXISTS `vw_market_billgroup_unit_water`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_market_billgroup_unit_water` (
  `objid` tinyint NOT NULL,
  `code` tinyint NOT NULL,
  `fullpath` tinyint NOT NULL,
  `billgroupid` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_market_billitem`
--

DROP TABLE IF EXISTS `vw_market_billitem`;
/*!50001 DROP VIEW IF EXISTS `vw_market_billitem`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_market_billitem` (
  `objid` tinyint NOT NULL,
  `billid` tinyint NOT NULL,
  `itemid` tinyint NOT NULL,
  `amount` tinyint NOT NULL,
  `amtpaid` tinyint NOT NULL,
  `remarks` tinyint NOT NULL,
  `uid` tinyint NOT NULL,
  `auto` tinyint NOT NULL,
  `forwarded` tinyint NOT NULL,
  `particulars` tinyint NOT NULL,
  `balance` tinyint NOT NULL,
  `year` tinyint NOT NULL,
  `month` tinyint NOT NULL,
  `billdate` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_market_compromise_billitem`
--

DROP TABLE IF EXISTS `vw_market_compromise_billitem`;
/*!50001 DROP VIEW IF EXISTS `vw_market_compromise_billitem`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_market_compromise_billitem` (
  `objid` tinyint NOT NULL,
  `year` tinyint NOT NULL,
  `month` tinyint NOT NULL,
  `itemid` tinyint NOT NULL,
  `amount` tinyint NOT NULL,
  `compromiseid` tinyint NOT NULL,
  `billdate` tinyint NOT NULL,
  `billno` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_market_electricity_bill`
--

DROP TABLE IF EXISTS `vw_market_electricity_bill`;
/*!50001 DROP VIEW IF EXISTS `vw_market_electricity_bill`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_market_electricity_bill` (
  `objid` tinyint NOT NULL,
  `prevbillid` tinyint NOT NULL,
  `billno` tinyint NOT NULL,
  `billdate` tinyint NOT NULL,
  `billtype` tinyint NOT NULL,
  `lasttxndate` tinyint NOT NULL,
  `validitydate` tinyint NOT NULL,
  `acctid` tinyint NOT NULL,
  `acctinfoid` tinyint NOT NULL,
  `state` tinyint NOT NULL,
  `remarks` tinyint NOT NULL,
  `balanceforward` tinyint NOT NULL,
  `totalpayment` tinyint NOT NULL,
  `interest` tinyint NOT NULL,
  `surcharge` tinyint NOT NULL,
  `amount` tinyint NOT NULL,
  `discount` tinyint NOT NULL,
  `txnmode` tinyint NOT NULL,
  `hold` tinyint NOT NULL,
  `uid` tinyint NOT NULL,
  `billscheduleid` tinyint NOT NULL,
  `batchid` tinyint NOT NULL,
  `acctno` tinyint NOT NULL,
  `superacctno` tinyint NOT NULL,
  `centerid` tinyint NOT NULL,
  `unitno` tinyint NOT NULL,
  `acctname` tinyint NOT NULL,
  `owner_objid` tinyint NOT NULL,
  `owner_name` tinyint NOT NULL,
  `owner_address_text` tinyint NOT NULL,
  `year` tinyint NOT NULL,
  `month` tinyint NOT NULL,
  `fromdate` tinyint NOT NULL,
  `todate` tinyint NOT NULL,
  `duedate` tinyint NOT NULL,
  `expirydate` tinyint NOT NULL,
  `billgroupid` tinyint NOT NULL,
  `reading` tinyint NOT NULL,
  `readingdate` tinyint NOT NULL,
  `reader_objid` tinyint NOT NULL,
  `volume` tinyint NOT NULL,
  `rate` tinyint NOT NULL,
  `prevreading` tinyint NOT NULL,
  `capacity` tinyint NOT NULL,
  `orgunit_name` tinyint NOT NULL,
  `center_name` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_market_electricity_prevbill`
--

DROP TABLE IF EXISTS `vw_market_electricity_prevbill`;
/*!50001 DROP VIEW IF EXISTS `vw_market_electricity_prevbill`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_market_electricity_prevbill` (
  `objid` tinyint NOT NULL,
  `acctid` tinyint NOT NULL,
  `unitid` tinyint NOT NULL,
  `reading` tinyint NOT NULL,
  `year` tinyint NOT NULL,
  `month` tinyint NOT NULL,
  `yearmonth` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_market_electricity_subaccount`
--

DROP TABLE IF EXISTS `vw_market_electricity_subaccount`;
/*!50001 DROP VIEW IF EXISTS `vw_market_electricity_subaccount`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_market_electricity_subaccount` (
  `objid` tinyint NOT NULL,
  `state` tinyint NOT NULL,
  `acctno` tinyint NOT NULL,
  `acctid` tinyint NOT NULL,
  `unitid` tinyint NOT NULL,
  `capacity` tinyint NOT NULL,
  `currentreading` tinyint NOT NULL,
  `remarks` tinyint NOT NULL,
  `parentacctno` tinyint NOT NULL,
  `unitno` tinyint NOT NULL,
  `acctname` tinyint NOT NULL,
  `owner_objid` tinyint NOT NULL,
  `owner_name` tinyint NOT NULL,
  `owner_address_text` tinyint NOT NULL,
  `orgunitid` tinyint NOT NULL,
  `orgunit_name` tinyint NOT NULL,
  `centerid` tinyint NOT NULL,
  `center_name` tinyint NOT NULL,
  `billgroupid` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_market_penalty_billitem`
--

DROP TABLE IF EXISTS `vw_market_penalty_billitem`;
/*!50001 DROP VIEW IF EXISTS `vw_market_penalty_billitem`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_market_penalty_billitem` (
  `objid` tinyint NOT NULL,
  `billid` tinyint NOT NULL,
  `itemid` tinyint NOT NULL,
  `amount` tinyint NOT NULL,
  `amtpaid` tinyint NOT NULL,
  `remarks` tinyint NOT NULL,
  `uid` tinyint NOT NULL,
  `auto` tinyint NOT NULL,
  `forwarded` tinyint NOT NULL,
  `balance` tinyint NOT NULL,
  `type` tinyint NOT NULL,
  `billdate` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_market_rental_bill`
--

DROP TABLE IF EXISTS `vw_market_rental_bill`;
/*!50001 DROP VIEW IF EXISTS `vw_market_rental_bill`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_market_rental_bill` (
  `objid` tinyint NOT NULL,
  `prevbillid` tinyint NOT NULL,
  `billno` tinyint NOT NULL,
  `billdate` tinyint NOT NULL,
  `billtype` tinyint NOT NULL,
  `lasttxndate` tinyint NOT NULL,
  `validitydate` tinyint NOT NULL,
  `acctid` tinyint NOT NULL,
  `acctinfoid` tinyint NOT NULL,
  `state` tinyint NOT NULL,
  `remarks` tinyint NOT NULL,
  `balanceforward` tinyint NOT NULL,
  `totalpayment` tinyint NOT NULL,
  `interest` tinyint NOT NULL,
  `surcharge` tinyint NOT NULL,
  `amount` tinyint NOT NULL,
  `discount` tinyint NOT NULL,
  `txnmode` tinyint NOT NULL,
  `hold` tinyint NOT NULL,
  `uid` tinyint NOT NULL,
  `billscheduleid` tinyint NOT NULL,
  `batchid` tinyint NOT NULL,
  `acctno` tinyint NOT NULL,
  `acctname` tinyint NOT NULL,
  `rate` tinyint NOT NULL,
  `ratetype` tinyint NOT NULL,
  `owner_objid` tinyint NOT NULL,
  `owner_name` tinyint NOT NULL,
  `owner_address_text` tinyint NOT NULL,
  `year` tinyint NOT NULL,
  `month` tinyint NOT NULL,
  `fromdate` tinyint NOT NULL,
  `todate` tinyint NOT NULL,
  `duedate` tinyint NOT NULL,
  `expirydate` tinyint NOT NULL,
  `billgroupid` tinyint NOT NULL,
  `paymentmode` tinyint NOT NULL,
  `unitno` tinyint NOT NULL,
  `unittype` tinyint NOT NULL,
  `centerid` tinyint NOT NULL,
  `orgunitid` tinyint NOT NULL,
  `orgunit_name` tinyint NOT NULL,
  `orgunit_fullpath` tinyint NOT NULL,
  `center_name` tinyint NOT NULL,
  `center_title` tinyint NOT NULL,
  `center_address_text` tinyint NOT NULL,
  `center_contactinfo` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_market_rental_rate`
--

DROP TABLE IF EXISTS `vw_market_rental_rate`;
/*!50001 DROP VIEW IF EXISTS `vw_market_rental_rate`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_market_rental_rate` (
  `objid` tinyint NOT NULL,
  `unitid` tinyint NOT NULL,
  `rate` tinyint NOT NULL,
  `ratetype` tinyint NOT NULL,
  `effectivedate` tinyint NOT NULL,
  `createdby_objid` tinyint NOT NULL,
  `createdby_name` tinyint NOT NULL,
  `dtcreated` tinyint NOT NULL,
  `reason` tinyint NOT NULL,
  `batchid` tinyint NOT NULL,
  `unitno` tinyint NOT NULL,
  `center_name` tinyint NOT NULL,
  `orgunit_name` tinyint NOT NULL,
  `orgunit_fullpath` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_market_rental_unit`
--

DROP TABLE IF EXISTS `vw_market_rental_unit`;
/*!50001 DROP VIEW IF EXISTS `vw_market_rental_unit`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_market_rental_unit` (
  `objid` tinyint NOT NULL,
  `state` tinyint NOT NULL,
  `centerid` tinyint NOT NULL,
  `orgunitid` tinyint NOT NULL,
  `code` tinyint NOT NULL,
  `unittype` tinyint NOT NULL,
  `currentacctid` tinyint NOT NULL,
  `indexno` tinyint NOT NULL,
  `areasqm` tinyint NOT NULL,
  `center_objid` tinyint NOT NULL,
  `center_name` tinyint NOT NULL,
  `orgunit_objid` tinyint NOT NULL,
  `orgunit_name` tinyint NOT NULL,
  `orgunit_leftindex` tinyint NOT NULL,
  `orgunit_rightindex` tinyint NOT NULL,
  `orgunit_fullpath` tinyint NOT NULL,
  `account_acctno` tinyint NOT NULL,
  `account_objid` tinyint NOT NULL,
  `account_acctname` tinyint NOT NULL,
  `billgroupid` tinyint NOT NULL,
  `rateid` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_market_water_bill`
--

DROP TABLE IF EXISTS `vw_market_water_bill`;
/*!50001 DROP VIEW IF EXISTS `vw_market_water_bill`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_market_water_bill` (
  `objid` tinyint NOT NULL,
  `prevbillid` tinyint NOT NULL,
  `billno` tinyint NOT NULL,
  `billdate` tinyint NOT NULL,
  `billtype` tinyint NOT NULL,
  `lasttxndate` tinyint NOT NULL,
  `validitydate` tinyint NOT NULL,
  `acctid` tinyint NOT NULL,
  `acctinfoid` tinyint NOT NULL,
  `state` tinyint NOT NULL,
  `remarks` tinyint NOT NULL,
  `balanceforward` tinyint NOT NULL,
  `totalpayment` tinyint NOT NULL,
  `interest` tinyint NOT NULL,
  `surcharge` tinyint NOT NULL,
  `amount` tinyint NOT NULL,
  `discount` tinyint NOT NULL,
  `txnmode` tinyint NOT NULL,
  `hold` tinyint NOT NULL,
  `uid` tinyint NOT NULL,
  `billscheduleid` tinyint NOT NULL,
  `batchid` tinyint NOT NULL,
  `acctno` tinyint NOT NULL,
  `superacctno` tinyint NOT NULL,
  `centerid` tinyint NOT NULL,
  `unitno` tinyint NOT NULL,
  `acctname` tinyint NOT NULL,
  `owner_objid` tinyint NOT NULL,
  `owner_name` tinyint NOT NULL,
  `owner_address_text` tinyint NOT NULL,
  `year` tinyint NOT NULL,
  `month` tinyint NOT NULL,
  `fromdate` tinyint NOT NULL,
  `todate` tinyint NOT NULL,
  `duedate` tinyint NOT NULL,
  `expirydate` tinyint NOT NULL,
  `billgroupid` tinyint NOT NULL,
  `reading` tinyint NOT NULL,
  `readingdate` tinyint NOT NULL,
  `reader_objid` tinyint NOT NULL,
  `volume` tinyint NOT NULL,
  `rate` tinyint NOT NULL,
  `prevreading` tinyint NOT NULL,
  `capacity` tinyint NOT NULL,
  `orgunit_name` tinyint NOT NULL,
  `center_name` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_market_water_prevbill`
--

DROP TABLE IF EXISTS `vw_market_water_prevbill`;
/*!50001 DROP VIEW IF EXISTS `vw_market_water_prevbill`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_market_water_prevbill` (
  `objid` tinyint NOT NULL,
  `acctid` tinyint NOT NULL,
  `unitid` tinyint NOT NULL,
  `reading` tinyint NOT NULL,
  `year` tinyint NOT NULL,
  `month` tinyint NOT NULL,
  `yearmonth` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_market_water_subaccount`
--

DROP TABLE IF EXISTS `vw_market_water_subaccount`;
/*!50001 DROP VIEW IF EXISTS `vw_market_water_subaccount`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `vw_market_water_subaccount` (
  `objid` tinyint NOT NULL,
  `state` tinyint NOT NULL,
  `acctno` tinyint NOT NULL,
  `acctid` tinyint NOT NULL,
  `unitid` tinyint NOT NULL,
  `capacity` tinyint NOT NULL,
  `currentreading` tinyint NOT NULL,
  `remarks` tinyint NOT NULL,
  `parentacctno` tinyint NOT NULL,
  `unitno` tinyint NOT NULL,
  `acctname` tinyint NOT NULL,
  `owner_objid` tinyint NOT NULL,
  `owner_name` tinyint NOT NULL,
  `owner_address_text` tinyint NOT NULL,
  `orgunitid` tinyint NOT NULL,
  `orgunit_name` tinyint NOT NULL,
  `centerid` tinyint NOT NULL,
  `center_name` tinyint NOT NULL,
  `billgroupid` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Current Database: `market`
--

USE `market`;

--
-- Final view structure for view `vw_market_account`
--

/*!50001 DROP TABLE IF EXISTS `vw_market_account`*/;
/*!50001 DROP VIEW IF EXISTS `vw_market_account`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_market_account` AS select `ma`.`objid` AS `objid`,`ma`.`state` AS `state`,`ma`.`acctno` AS `acctno`,`ma`.`dtcreated` AS `dtcreated`,`ma`.`createdby_objid` AS `createdby_objid`,`ma`.`createdby_name` AS `createdby_name`,`ma`.`remarks` AS `remarks`,`ma`.`txnmode` AS `txnmode`,`ma`.`acctinfoid` AS `acctinfoid`,`mai`.`acctname` AS `acctname`,`mai`.`owner_name` AS `owner_name`,`mai`.`owner_address_text` AS `owner_address_text`,`mai`.`owner_entitytype` AS `owner_entitytype`,`mai`.`owner_profileid` AS `owner_profileid`,`mai`.`owner_profileno` AS `owner_profileno`,`mai`.`owner_firstname` AS `owner_firstname`,`mai`.`owner_lastname` AS `owner_lastname`,`mai`.`owner_middlename` AS `owner_middlename`,`mai`.`owner_resident` AS `owner_resident`,`mai`.`owner_address_unitno` AS `owner_address_unitno`,`mai`.`owner_address_bldgno` AS `owner_address_bldgno`,`mai`.`owner_address_bldgname` AS `owner_address_bldgname`,`mai`.`owner_address_street` AS `owner_address_street`,`mai`.`owner_address_subdivision` AS `owner_address_subdivision`,`mai`.`owner_address_barangay_objid` AS `owner_address_barangay_objid`,`mai`.`owner_address_barangay_name` AS `owner_address_barangay_name`,`mai`.`owner_address_citymunicipality` AS `owner_address_citymunicipality`,`mai`.`owner_address_province` AS `owner_address_province`,`mai`.`owner_tin` AS `owner_tin`,`mai`.`owner_email` AS `owner_email`,`mai`.`owner_mobileno` AS `owner_mobileno`,`mai`.`owner_phoneno` AS `owner_phoneno`,`mai`.`owner_id_type_name` AS `owner_id_type_name`,`mai`.`owner_id_idno` AS `owner_id_idno`,`mai`.`owner_id_placeissued` AS `owner_id_placeissued`,`mai`.`owner_id_dtissued` AS `owner_id_dtissued`,`mai`.`contact_mobileno` AS `contact_mobileno`,`mai`.`contact_email` AS `contact_email`,`mai`.`contact_phoneno` AS `contact_phoneno`,`mai`.`unitid` AS `unitid`,`mai`.`paymentmode` AS `paymentmode`,`mai`.`business_objid` AS `business_objid`,`mai`.`business_bin` AS `business_bin`,`mai`.`business_tradename` AS `business_tradename`,`mu`.`code` AS `unitno`,`mu`.`areasqm` AS `areasqm`,`mu`.`centerid` AS `centerid`,`mo`.`name` AS `center_name`,`mbgu`.`billgroupid` AS `billgroupid`,`ou`.`objid` AS `orgunitid`,`ou`.`name` AS `orgunit_name`,`ou`.`fullpath` AS `orgunit_fullpath`,(select `market_rental_rate`.`objid` from `market_rental_rate` where ((`market_rental_rate`.`unitid` = `mai`.`unitid`) and (`market_rental_rate`.`effectivedate` <= now())) order by `market_rental_rate`.`effectivedate` desc limit 1) AS `rateid` from (((((`market_account` `ma` join `market_account_info` `mai` on((`ma`.`acctinfoid` = `mai`.`objid`))) join `market_rental_unit` `mu` on((`mai`.`unitid` = `mu`.`objid`))) join `market_orgunit` `ou` on((`mu`.`orgunitid` = `ou`.`objid`))) join `market_center` `mo` on((`ou`.`centerid` = `mo`.`objid`))) left join `market_billgroup_unit` `mbgu` on(((`mbgu`.`unitid` = `mai`.`unitid`) and (`mbgu`.`billtype` = 'RENTAL')))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_market_account_info`
--

/*!50001 DROP TABLE IF EXISTS `vw_market_account_info`*/;
/*!50001 DROP VIEW IF EXISTS `vw_market_account_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_market_account_info` AS select `mai`.`objid` AS `objid`,`mai`.`acctid` AS `acctid`,`mai`.`acctname` AS `acctname`,`mai`.`owner_objid` AS `owner_objid`,`mai`.`owner_name` AS `owner_name`,`mai`.`owner_address_text` AS `owner_address_text`,`mai`.`owner_entitytype` AS `owner_entitytype`,`mai`.`owner_profileid` AS `owner_profileid`,`mai`.`owner_profileno` AS `owner_profileno`,`mai`.`owner_firstname` AS `owner_firstname`,`mai`.`owner_lastname` AS `owner_lastname`,`mai`.`owner_middlename` AS `owner_middlename`,`mai`.`owner_resident` AS `owner_resident`,`mai`.`owner_address_objid` AS `owner_address_objid`,`mai`.`owner_address_unitno` AS `owner_address_unitno`,`mai`.`owner_address_bldgno` AS `owner_address_bldgno`,`mai`.`owner_address_bldgname` AS `owner_address_bldgname`,`mai`.`owner_address_street` AS `owner_address_street`,`mai`.`owner_address_subdivision` AS `owner_address_subdivision`,`mai`.`owner_address_barangay_objid` AS `owner_address_barangay_objid`,`mai`.`owner_address_barangay_name` AS `owner_address_barangay_name`,`mai`.`owner_address_citymunicipality` AS `owner_address_citymunicipality`,`mai`.`owner_address_province` AS `owner_address_province`,`mai`.`owner_tin` AS `owner_tin`,`mai`.`owner_email` AS `owner_email`,`mai`.`owner_mobileno` AS `owner_mobileno`,`mai`.`owner_phoneno` AS `owner_phoneno`,`mai`.`owner_id_type_name` AS `owner_id_type_name`,`mai`.`owner_id_idno` AS `owner_id_idno`,`mai`.`owner_id_placeissued` AS `owner_id_placeissued`,`mai`.`owner_id_dtissued` AS `owner_id_dtissued`,`mai`.`contact_mobileno` AS `contact_mobileno`,`mai`.`contact_email` AS `contact_email`,`mai`.`contact_phoneno` AS `contact_phoneno`,`mai`.`unitid` AS `unitid`,`mai`.`paymentmode` AS `paymentmode`,`mai`.`business_objid` AS `business_objid`,`mai`.`business_bin` AS `business_bin`,`mai`.`business_tradename` AS `business_tradename`,`mai`.`txnid` AS `txnid`,`mai`.`txntype` AS `txntype`,`mu`.`objid` AS `unit_objid`,`mu`.`code` AS `unit_code`,`mu`.`centerid` AS `unit_centerid`,`mu`.`areasqm` AS `unit_areasqm` from (`market_account_info` `mai` join `market_rental_unit` `mu` on((`mai`.`unitid` = `mu`.`objid`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_market_batch_bill`
--

/*!50001 DROP TABLE IF EXISTS `vw_market_batch_bill`*/;
/*!50001 DROP VIEW IF EXISTS `vw_market_batch_bill`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_market_batch_bill` AS select `mb`.`objid` AS `objid`,`mb`.`billtype` AS `billtype`,`mb`.`billgroupid` AS `billgroupid`,`mb`.`billscheduleid` AS `billscheduleid`,`mb`.`batchdate` AS `batchdate`,`mb`.`taskid` AS `taskid`,`mb`.`procstate` AS `procstate`,`mb`.`counter` AS `counter`,`mb`.`totalcount` AS `totalcount`,`mb`.`autopost` AS `autopost`,`mb`.`autogenerate` AS `autogenerate`,`mbt`.`state` AS `task_state`,`mbt`.`dtcreated` AS `task_dtcreated`,`mbt`.`startdate` AS `task_startdate`,`mbt`.`enddate` AS `task_enddate`,`mbt`.`assignee_objid` AS `task_assignee_objid`,`mbt`.`assignee_name` AS `task_assignee_name`,`mbt`.`actor_objid` AS `task_actor_objid`,`mbt`.`actor_name` AS `task_actor_name`,`sn`.`title` AS `task_title`,`sn`.`tracktime` AS `task_tracktime`,`sn`.`properties` AS `task_properties`,`bs`.`year` AS `year`,`bs`.`month` AS `month`,`bs`.`fromdate` AS `fromdate`,`bs`.`billdate` AS `billdate`,`bs`.`todate` AS `todate`,`bs`.`discdate` AS `discdate`,`bs`.`duedate` AS `duedate`,`bs`.`expirydate` AS `expirydate` from (((`market_batch_bill` `mb` join `market_batch_bill_task` `mbt` on((`mb`.`taskid` = `mbt`.`taskid`))) join `sys_wf_node` `sn` on(((`sn`.`processname` = 'market_batch_bill') and (`sn`.`name` = `mbt`.`state`)))) join `market_billschedule` `bs` on((`mb`.`billscheduleid` = `bs`.`objid`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_market_bill`
--

/*!50001 DROP TABLE IF EXISTS `vw_market_bill`*/;
/*!50001 DROP VIEW IF EXISTS `vw_market_bill`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_market_bill` AS select `mb`.`objid` AS `objid`,`mb`.`prevbillid` AS `prevbillid`,`mb`.`billtype` AS `billtype`,`mb`.`billno` AS `billno`,`mb`.`billdate` AS `billdate`,`mb`.`lasttxndate` AS `lasttxndate`,`mb`.`validitydate` AS `validitydate`,`mb`.`acctid` AS `acctid`,`mb`.`acctinfoid` AS `acctinfoid`,`mb`.`state` AS `state`,`mb`.`remarks` AS `remarks`,`mb`.`balanceforward` AS `balanceforward`,`mb`.`totalpayment` AS `totalpayment`,`mb`.`interest` AS `interest`,`mb`.`surcharge` AS `surcharge`,`mb`.`amount` AS `amount`,`mb`.`discount` AS `discount`,`mb`.`txnmode` AS `txnmode`,`mb`.`hold` AS `hold`,`mb`.`uid` AS `uid`,`mb`.`billscheduleid` AS `billscheduleid`,`mb`.`batchid` AS `batchid`,`mru`.`code` AS `unitno`,`ma`.`acctno` AS `acctno`,`mai`.`acctname` AS `acctname`,`mbs`.`year` AS `year`,`mbs`.`month` AS `month`,`mbs`.`fromdate` AS `fromdate`,`mbs`.`todate` AS `todate`,`mbs`.`duedate` AS `duedate`,`mbs`.`expirydate` AS `expirydate`,`mbs`.`billgroupid` AS `billgroupid`,((((`mb`.`balanceforward` + `mb`.`interest`) + `mb`.`surcharge`) + `mb`.`amount`) - (`mb`.`totalpayment` + `mb`.`discount`)) AS `balance`,`ou`.`name` AS `orgunit_name`,`ou`.`fullpath` AS `orgunit_fullpath`,`mc`.`name` AS `center_name`,`mai`.`owner_objid` AS `owner_objid`,`mai`.`owner_name` AS `owner_name` from ((((((`market_bill` `mb` join `market_billschedule` `mbs` on((`mb`.`billscheduleid` = `mbs`.`objid`))) join `market_account` `ma` on((`mb`.`acctid` = `ma`.`objid`))) join `market_account_info` `mai` on((`mb`.`acctinfoid` = `mai`.`objid`))) join `market_rental_unit` `mru` on((`mai`.`unitid` = `mru`.`objid`))) join `market_orgunit` `ou` on((`mru`.`orgunitid` = `ou`.`objid`))) join `market_center` `mc` on((`ou`.`centerid` = `mc`.`objid`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_market_billgroup_unit_electricity`
--

/*!50001 DROP TABLE IF EXISTS `vw_market_billgroup_unit_electricity`*/;
/*!50001 DROP VIEW IF EXISTS `vw_market_billgroup_unit_electricity`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_market_billgroup_unit_electricity` AS select `mru`.`objid` AS `objid`,`mru`.`code` AS `code`,`ou`.`fullpath` AS `fullpath`,`mbgu`.`billgroupid` AS `billgroupid` from ((`market_rental_unit` `mru` join `market_orgunit` `ou` on((`mru`.`orgunitid` = `ou`.`objid`))) left join `market_billgroup_unit` `mbgu` on(((`mbgu`.`unitid` = `mru`.`objid`) and (`mbgu`.`billtype` = 'ELECTRICITY')))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_market_billgroup_unit_rental`
--

/*!50001 DROP TABLE IF EXISTS `vw_market_billgroup_unit_rental`*/;
/*!50001 DROP VIEW IF EXISTS `vw_market_billgroup_unit_rental`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_market_billgroup_unit_rental` AS select `mru`.`objid` AS `objid`,`mru`.`code` AS `code`,`ou`.`fullpath` AS `fullpath`,`mbgu`.`billgroupid` AS `billgroupid` from ((`market_rental_unit` `mru` join `market_orgunit` `ou` on((`mru`.`orgunitid` = `ou`.`objid`))) left join `market_billgroup_unit` `mbgu` on(((`mbgu`.`unitid` = `mru`.`objid`) and (`mbgu`.`billtype` = 'RENTAL')))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_market_billgroup_unit_water`
--

/*!50001 DROP TABLE IF EXISTS `vw_market_billgroup_unit_water`*/;
/*!50001 DROP VIEW IF EXISTS `vw_market_billgroup_unit_water`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_market_billgroup_unit_water` AS select `mru`.`objid` AS `objid`,`mru`.`code` AS `code`,`ou`.`fullpath` AS `fullpath`,`mbgu`.`billgroupid` AS `billgroupid` from ((`market_rental_unit` `mru` join `market_orgunit` `ou` on((`mru`.`orgunitid` = `ou`.`objid`))) left join `market_billgroup_unit` `mbgu` on(((`mbgu`.`unitid` = `mru`.`objid`) and (`mbgu`.`billtype` = 'WATER')))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_market_billitem`
--

/*!50001 DROP TABLE IF EXISTS `vw_market_billitem`*/;
/*!50001 DROP VIEW IF EXISTS `vw_market_billitem`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_market_billitem` AS select `mbi`.`objid` AS `objid`,`mbi`.`billid` AS `billid`,`mbi`.`itemid` AS `itemid`,`mbi`.`amount` AS `amount`,`mbi`.`amtpaid` AS `amtpaid`,`mbi`.`remarks` AS `remarks`,`mbi`.`uid` AS `uid`,`mbi`.`auto` AS `auto`,`mbi`.`forwarded` AS `forwarded`,(case when isnull(`mri`.`billdate`) then concat(`mai`.`title`,' ',`mri`.`year`,' ',`mri`.`month`) else concat(`mai`.`title`,' (',`mri`.`billdate`,')') end) AS `particulars`,(`mbi`.`amount` - `mbi`.`amtpaid`) AS `balance`,`mri`.`year` AS `year`,`mri`.`month` AS `month`,`mri`.`billdate` AS `billdate` from ((`market_abstract_billitem` `mbi` join `market_billitem` `mri` on((`mri`.`objid` = `mbi`.`objid`))) join `market_itemaccount` `mai` on((`mbi`.`itemid` = `mai`.`objid`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_market_compromise_billitem`
--

/*!50001 DROP TABLE IF EXISTS `vw_market_compromise_billitem`*/;
/*!50001 DROP VIEW IF EXISTS `vw_market_compromise_billitem`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_market_compromise_billitem` AS select `mbi`.`objid` AS `objid`,`mbs`.`year` AS `year`,`mbs`.`month` AS `month`,`abi`.`itemid` AS `itemid`,`abi`.`amount` AS `amount`,`mbi`.`compromiseid` AS `compromiseid`,`mbi`.`billdate` AS `billdate`,`mb`.`billno` AS `billno` from (((`market_billitem` `mbi` join `market_abstract_billitem` `abi` on((`mbi`.`objid` = `abi`.`objid`))) join `market_bill` `mb` on((`abi`.`billid` = `mb`.`objid`))) join `market_billschedule` `mbs` on((`mb`.`billscheduleid` = `mbs`.`objid`))) where (`mbi`.`compromiseid` is not null) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_market_electricity_bill`
--

/*!50001 DROP TABLE IF EXISTS `vw_market_electricity_bill`*/;
/*!50001 DROP VIEW IF EXISTS `vw_market_electricity_bill`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_market_electricity_bill` AS select `mb`.`objid` AS `objid`,`mb`.`prevbillid` AS `prevbillid`,`mb`.`billno` AS `billno`,`mb`.`billdate` AS `billdate`,`mb`.`billtype` AS `billtype`,`mb`.`lasttxndate` AS `lasttxndate`,`mb`.`validitydate` AS `validitydate`,`mb`.`acctid` AS `acctid`,`mb`.`acctinfoid` AS `acctinfoid`,`mb`.`state` AS `state`,`mb`.`remarks` AS `remarks`,`mb`.`balanceforward` AS `balanceforward`,`mb`.`totalpayment` AS `totalpayment`,`mb`.`interest` AS `interest`,`mb`.`surcharge` AS `surcharge`,`mb`.`amount` AS `amount`,`mb`.`discount` AS `discount`,`mb`.`txnmode` AS `txnmode`,`mb`.`hold` AS `hold`,`mb`.`uid` AS `uid`,`mb`.`billscheduleid` AS `billscheduleid`,`mb`.`batchid` AS `batchid`,`esa`.`acctno` AS `acctno`,`ma`.`acctno` AS `superacctno`,`mru`.`centerid` AS `centerid`,`mru`.`code` AS `unitno`,`mai`.`acctname` AS `acctname`,`mai`.`owner_objid` AS `owner_objid`,`mai`.`owner_name` AS `owner_name`,`mai`.`owner_address_text` AS `owner_address_text`,`mbs`.`year` AS `year`,`mbs`.`month` AS `month`,`mbs`.`fromdate` AS `fromdate`,`mbs`.`todate` AS `todate`,`mbs`.`duedate` AS `duedate`,`mbs`.`expirydate` AS `expirydate`,`mbs`.`billgroupid` AS `billgroupid`,`eb`.`reading` AS `reading`,`eb`.`readingdate` AS `readingdate`,`eb`.`reader_objid` AS `reader_objid`,`eb`.`volume` AS `volume`,`eb`.`rate` AS `rate`,ifnull((case when isnull(`prev`.`objid`) then `eb`.`initialreading` when (`mai`.`unitid` = `prev`.`unitid`) then `prev`.`reading` else `eb`.`initialreading` end),0) AS `prevreading`,`esa`.`capacity` AS `capacity`,`ou`.`name` AS `orgunit_name`,`mc`.`name` AS `center_name` from (((((((((`market_electricity_bill` `eb` join `market_bill` `mb` on((`eb`.`objid` = `mb`.`objid`))) join `market_account` `ma` on((`mb`.`acctid` = `ma`.`objid`))) join `market_account_info` `mai` on((`mb`.`acctinfoid` = `mai`.`objid`))) join `market_rental_unit` `mru` on((`mai`.`unitid` = `mru`.`objid`))) join `market_orgunit` `ou` on((`mru`.`orgunitid` = `ou`.`objid`))) join `market_center` `mc` on((`ou`.`centerid` = `mc`.`objid`))) join `market_billschedule` `mbs` on((`mb`.`billscheduleid` = `mbs`.`objid`))) join `market_electricity_subaccount` `esa` on((`eb`.`subacctid` = `esa`.`objid`))) left join `vw_market_electricity_prevbill` `prev` on((`mb`.`prevbillid` = `prev`.`objid`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_market_electricity_prevbill`
--

/*!50001 DROP TABLE IF EXISTS `vw_market_electricity_prevbill`*/;
/*!50001 DROP VIEW IF EXISTS `vw_market_electricity_prevbill`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_market_electricity_prevbill` AS select `mb`.`objid` AS `objid`,`mb`.`acctid` AS `acctid`,`mai`.`unitid` AS `unitid`,`eb`.`reading` AS `reading`,`mbs`.`year` AS `year`,`mbs`.`month` AS `month`,((`mbs`.`year` * 12) + `mbs`.`month`) AS `yearmonth` from (((`market_electricity_bill` `eb` join `market_bill` `mb` on((`eb`.`objid` = `mb`.`objid`))) join `market_billschedule` `mbs` on((`mb`.`billscheduleid` = `mbs`.`objid`))) join `market_account_info` `mai` on((`mb`.`acctinfoid` = `mai`.`objid`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_market_electricity_subaccount`
--

/*!50001 DROP TABLE IF EXISTS `vw_market_electricity_subaccount`*/;
/*!50001 DROP VIEW IF EXISTS `vw_market_electricity_subaccount`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_market_electricity_subaccount` AS select `sa`.`objid` AS `objid`,`sa`.`state` AS `state`,`sa`.`acctno` AS `acctno`,`sa`.`acctid` AS `acctid`,`sa`.`unitid` AS `unitid`,`sa`.`capacity` AS `capacity`,`sa`.`currentreading` AS `currentreading`,`sa`.`remarks` AS `remarks`,`ma`.`acctno` AS `parentacctno`,`mu`.`code` AS `unitno`,`mai`.`acctname` AS `acctname`,`mai`.`owner_objid` AS `owner_objid`,`mai`.`owner_name` AS `owner_name`,`mai`.`owner_address_text` AS `owner_address_text`,`ou`.`objid` AS `orgunitid`,`ou`.`name` AS `orgunit_name`,`ctr`.`objid` AS `centerid`,`ctr`.`name` AS `center_name`,`mbgu`.`billgroupid` AS `billgroupid` from ((((((`market_electricity_subaccount` `sa` join `market_account` `ma` on((`sa`.`acctid` = `ma`.`objid`))) join `market_account_info` `mai` on((`ma`.`acctinfoid` = `mai`.`objid`))) join `market_rental_unit` `mu` on((`mai`.`unitid` = `mu`.`objid`))) join `market_orgunit` `ou` on((`mu`.`orgunitid` = `ou`.`objid`))) join `market_center` `ctr` on((`ou`.`centerid` = `ctr`.`objid`))) left join `market_billgroup_unit` `mbgu` on(((`mu`.`objid` = `mbgu`.`unitid`) and (`mbgu`.`billtype` = 'ELECTRICITY')))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_market_penalty_billitem`
--

/*!50001 DROP TABLE IF EXISTS `vw_market_penalty_billitem`*/;
/*!50001 DROP VIEW IF EXISTS `vw_market_penalty_billitem`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_market_penalty_billitem` AS select `abi`.`objid` AS `objid`,`abi`.`billid` AS `billid`,`abi`.`itemid` AS `itemid`,`abi`.`amount` AS `amount`,`abi`.`amtpaid` AS `amtpaid`,`abi`.`remarks` AS `remarks`,`abi`.`uid` AS `uid`,`abi`.`auto` AS `auto`,`abi`.`forwarded` AS `forwarded`,(`abi`.`amount` - `abi`.`amtpaid`) AS `balance`,`pbi`.`type` AS `type`,`pbi`.`billdate` AS `billdate` from (`market_abstract_billitem` `abi` join `market_penalty_billitem` `pbi` on((`pbi`.`objid` = `abi`.`objid`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_market_rental_bill`
--

/*!50001 DROP TABLE IF EXISTS `vw_market_rental_bill`*/;
/*!50001 DROP VIEW IF EXISTS `vw_market_rental_bill`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_market_rental_bill` AS select `mb`.`objid` AS `objid`,`mb`.`prevbillid` AS `prevbillid`,`mb`.`billno` AS `billno`,`mb`.`billdate` AS `billdate`,`mb`.`billtype` AS `billtype`,`mb`.`lasttxndate` AS `lasttxndate`,`mb`.`validitydate` AS `validitydate`,`mb`.`acctid` AS `acctid`,`mb`.`acctinfoid` AS `acctinfoid`,`mb`.`state` AS `state`,`mb`.`remarks` AS `remarks`,`mb`.`balanceforward` AS `balanceforward`,`mb`.`totalpayment` AS `totalpayment`,`mb`.`interest` AS `interest`,`mb`.`surcharge` AS `surcharge`,`mb`.`amount` AS `amount`,`mb`.`discount` AS `discount`,`mb`.`txnmode` AS `txnmode`,`mb`.`hold` AS `hold`,`mb`.`uid` AS `uid`,`mb`.`billscheduleid` AS `billscheduleid`,`mb`.`batchid` AS `batchid`,`ma`.`acctno` AS `acctno`,`mai`.`acctname` AS `acctname`,`mrr`.`rate` AS `rate`,`mrr`.`ratetype` AS `ratetype`,`mai`.`owner_objid` AS `owner_objid`,`mai`.`owner_name` AS `owner_name`,`mai`.`owner_address_text` AS `owner_address_text`,`mbs`.`year` AS `year`,`mbs`.`month` AS `month`,`mbs`.`fromdate` AS `fromdate`,`mbs`.`todate` AS `todate`,`mbs`.`duedate` AS `duedate`,`mbs`.`expirydate` AS `expirydate`,`mbs`.`billgroupid` AS `billgroupid`,`mai`.`paymentmode` AS `paymentmode`,`mru`.`code` AS `unitno`,`mru`.`unittype` AS `unittype`,`mru`.`centerid` AS `centerid`,`mru`.`orgunitid` AS `orgunitid`,`ou`.`name` AS `orgunit_name`,`ou`.`fullpath` AS `orgunit_fullpath`,`mc`.`name` AS `center_name`,`mc`.`title` AS `center_title`,`mc`.`address_text` AS `center_address_text`,`mc`.`contactinfo` AS `center_contactinfo` from (((((((((`market_bill` `mb` join `market_rental_bill` `mrb` on((`mrb`.`objid` = `mb`.`objid`))) left join `market_rental_rate` `mrr` on((`mrb`.`rateid` = `mrr`.`objid`))) join `market_account` `ma` on((`mb`.`acctid` = `ma`.`objid`))) join `market_account_info` `mai` on((`ma`.`acctinfoid` = `mai`.`objid`))) join `market_rental_unit` `mru` on((`mai`.`unitid` = `mru`.`objid`))) join `market_orgunit` `ou` on((`mru`.`orgunitid` = `ou`.`objid`))) join `market_center` `mc` on((`ou`.`centerid` = `mc`.`objid`))) join `market_billschedule` `mbs` on((`mb`.`billscheduleid` = `mbs`.`objid`))) join `market_billgroup` `bg` on((`mbs`.`billgroupid` = `bg`.`objid`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_market_rental_rate`
--

/*!50001 DROP TABLE IF EXISTS `vw_market_rental_rate`*/;
/*!50001 DROP VIEW IF EXISTS `vw_market_rental_rate`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_market_rental_rate` AS select `mrr`.`objid` AS `objid`,`mrr`.`unitid` AS `unitid`,`mrr`.`rate` AS `rate`,`mrr`.`ratetype` AS `ratetype`,`mrr`.`effectivedate` AS `effectivedate`,`mrr`.`createdby_objid` AS `createdby_objid`,`mrr`.`createdby_name` AS `createdby_name`,`mrr`.`dtcreated` AS `dtcreated`,`mrr`.`reason` AS `reason`,`mrr`.`batchid` AS `batchid`,`mru`.`code` AS `unitno`,`mc`.`name` AS `center_name`,`mou`.`name` AS `orgunit_name`,`mou`.`fullpath` AS `orgunit_fullpath` from (((`market_rental_rate` `mrr` join `market_rental_unit` `mru` on((`mrr`.`unitid` = `mru`.`objid`))) left join `market_orgunit` `mou` on((`mru`.`orgunitid` = `mou`.`objid`))) left join `market_center` `mc` on((`mru`.`centerid` = `mc`.`objid`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_market_rental_unit`
--

/*!50001 DROP TABLE IF EXISTS `vw_market_rental_unit`*/;
/*!50001 DROP VIEW IF EXISTS `vw_market_rental_unit`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_market_rental_unit` AS select `mu`.`objid` AS `objid`,`mu`.`state` AS `state`,`mu`.`centerid` AS `centerid`,`mu`.`orgunitid` AS `orgunitid`,`mu`.`code` AS `code`,`mu`.`unittype` AS `unittype`,`mu`.`currentacctid` AS `currentacctid`,`mu`.`indexno` AS `indexno`,`mu`.`areasqm` AS `areasqm`,`mc`.`objid` AS `center_objid`,`mc`.`name` AS `center_name`,`ou`.`objid` AS `orgunit_objid`,`ou`.`name` AS `orgunit_name`,`ou`.`leftindex` AS `orgunit_leftindex`,`ou`.`rightindex` AS `orgunit_rightindex`,`ou`.`fullpath` AS `orgunit_fullpath`,`ma`.`acctno` AS `account_acctno`,`ma`.`objid` AS `account_objid`,`mai`.`acctname` AS `account_acctname`,`mbgu`.`billgroupid` AS `billgroupid`,(select `market_rental_rate`.`objid` from `market_rental_rate` where ((`market_rental_rate`.`unitid` = `mu`.`objid`) and (`market_rental_rate`.`effectivedate` <= now())) order by `market_rental_rate`.`effectivedate` desc limit 1) AS `rateid` from (((((`market_rental_unit` `mu` join `market_center` `mc` on((`mu`.`centerid` = `mc`.`objid`))) join `market_orgunit` `ou` on((`mu`.`orgunitid` = `ou`.`objid`))) left join `market_account` `ma` on((`mu`.`currentacctid` = `ma`.`objid`))) left join `market_account_info` `mai` on((`ma`.`acctinfoid` = `mai`.`objid`))) left join `market_billgroup_unit` `mbgu` on(((`mu`.`objid` = `mbgu`.`unitid`) and (`mbgu`.`billtype` = 'RENTAL')))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_market_water_bill`
--

/*!50001 DROP TABLE IF EXISTS `vw_market_water_bill`*/;
/*!50001 DROP VIEW IF EXISTS `vw_market_water_bill`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_market_water_bill` AS select `mb`.`objid` AS `objid`,`mb`.`prevbillid` AS `prevbillid`,`mb`.`billno` AS `billno`,`mb`.`billdate` AS `billdate`,`mb`.`billtype` AS `billtype`,`mb`.`lasttxndate` AS `lasttxndate`,`mb`.`validitydate` AS `validitydate`,`mb`.`acctid` AS `acctid`,`mb`.`acctinfoid` AS `acctinfoid`,`mb`.`state` AS `state`,`mb`.`remarks` AS `remarks`,`mb`.`balanceforward` AS `balanceforward`,`mb`.`totalpayment` AS `totalpayment`,`mb`.`interest` AS `interest`,`mb`.`surcharge` AS `surcharge`,`mb`.`amount` AS `amount`,`mb`.`discount` AS `discount`,`mb`.`txnmode` AS `txnmode`,`mb`.`hold` AS `hold`,`mb`.`uid` AS `uid`,`mb`.`billscheduleid` AS `billscheduleid`,`mb`.`batchid` AS `batchid`,`esa`.`acctno` AS `acctno`,`ma`.`acctno` AS `superacctno`,`mru`.`centerid` AS `centerid`,`mru`.`code` AS `unitno`,`mai`.`acctname` AS `acctname`,`mai`.`owner_objid` AS `owner_objid`,`mai`.`owner_name` AS `owner_name`,`mai`.`owner_address_text` AS `owner_address_text`,`mbs`.`year` AS `year`,`mbs`.`month` AS `month`,`mbs`.`fromdate` AS `fromdate`,`mbs`.`todate` AS `todate`,`mbs`.`duedate` AS `duedate`,`mbs`.`expirydate` AS `expirydate`,`mbs`.`billgroupid` AS `billgroupid`,`eb`.`reading` AS `reading`,`eb`.`readingdate` AS `readingdate`,`eb`.`reader_objid` AS `reader_objid`,`eb`.`volume` AS `volume`,`eb`.`rate` AS `rate`,ifnull((case when isnull(`prev`.`objid`) then `eb`.`initialreading` when (`mai`.`unitid` = `prev`.`unitid`) then `prev`.`reading` else `eb`.`initialreading` end),0) AS `prevreading`,`esa`.`capacity` AS `capacity`,`ou`.`name` AS `orgunit_name`,`mc`.`name` AS `center_name` from (((((((((`market_water_bill` `eb` join `market_bill` `mb` on((`eb`.`objid` = `mb`.`objid`))) join `market_account` `ma` on((`mb`.`acctid` = `ma`.`objid`))) join `market_account_info` `mai` on((`mb`.`acctinfoid` = `mai`.`objid`))) join `market_rental_unit` `mru` on((`mai`.`unitid` = `mru`.`objid`))) join `market_orgunit` `ou` on((`mru`.`orgunitid` = `ou`.`objid`))) join `market_center` `mc` on((`ou`.`centerid` = `mc`.`objid`))) join `market_billschedule` `mbs` on((`mb`.`billscheduleid` = `mbs`.`objid`))) join `market_water_subaccount` `esa` on((`eb`.`subacctid` = `esa`.`objid`))) left join `vw_market_water_prevbill` `prev` on((`mb`.`prevbillid` = `prev`.`objid`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_market_water_prevbill`
--

/*!50001 DROP TABLE IF EXISTS `vw_market_water_prevbill`*/;
/*!50001 DROP VIEW IF EXISTS `vw_market_water_prevbill`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_market_water_prevbill` AS select `mb`.`objid` AS `objid`,`mb`.`acctid` AS `acctid`,`mai`.`unitid` AS `unitid`,`eb`.`reading` AS `reading`,`mbs`.`year` AS `year`,`mbs`.`month` AS `month`,((`mbs`.`year` * 12) + `mbs`.`month`) AS `yearmonth` from (((`market_water_bill` `eb` join `market_bill` `mb` on((`eb`.`objid` = `mb`.`objid`))) join `market_billschedule` `mbs` on((`mb`.`billscheduleid` = `mbs`.`objid`))) join `market_account_info` `mai` on((`mb`.`acctinfoid` = `mai`.`objid`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_market_water_subaccount`
--

/*!50001 DROP TABLE IF EXISTS `vw_market_water_subaccount`*/;
/*!50001 DROP VIEW IF EXISTS `vw_market_water_subaccount`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_market_water_subaccount` AS select `sa`.`objid` AS `objid`,`sa`.`state` AS `state`,`sa`.`acctno` AS `acctno`,`sa`.`acctid` AS `acctid`,`sa`.`unitid` AS `unitid`,`sa`.`capacity` AS `capacity`,`sa`.`currentreading` AS `currentreading`,`sa`.`remarks` AS `remarks`,`ma`.`acctno` AS `parentacctno`,`mu`.`code` AS `unitno`,`mai`.`acctname` AS `acctname`,`mai`.`owner_objid` AS `owner_objid`,`mai`.`owner_name` AS `owner_name`,`mai`.`owner_address_text` AS `owner_address_text`,`ou`.`objid` AS `orgunitid`,`ou`.`name` AS `orgunit_name`,`ctr`.`objid` AS `centerid`,`ctr`.`name` AS `center_name`,`mbgu`.`billgroupid` AS `billgroupid` from ((((((`market_water_subaccount` `sa` join `market_account` `ma` on((`sa`.`acctid` = `ma`.`objid`))) join `market_account_info` `mai` on((`ma`.`acctinfoid` = `mai`.`objid`))) join `market_rental_unit` `mu` on((`mai`.`unitid` = `mu`.`objid`))) join `market_orgunit` `ou` on((`mu`.`orgunitid` = `ou`.`objid`))) join `market_center` `ctr` on((`ou`.`centerid` = `ctr`.`objid`))) left join `market_billgroup_unit` `mbgu` on(((`mu`.`objid` = `mbgu`.`unitid`) and (`mbgu`.`billtype` = 'WATER')))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-06-21 21:32:39
