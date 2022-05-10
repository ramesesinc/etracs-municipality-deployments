set foreign_key_checks = 0
;

CREATE TABLE `bpexpirydate` (
  `year` int(11) NOT NULL,
  `qtr` int(11) NOT NULL,
  `expirydate` date DEFAULT NULL,
  `reason` text,
  PRIMARY KEY (`year`,`qtr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `business` (
  `objid` varchar(50) NOT NULL,
  `state` varchar(15) NOT NULL,
  `owner_name` varchar(255) NOT NULL,
  `owner_objid` varchar(50) NOT NULL,
  `owner_address_text` varchar(255) DEFAULT NULL,
  `owner_address_objid` varchar(50) DEFAULT NULL,
  `businessname` varchar(255) DEFAULT NULL,
  `tradename` varchar(255) NOT NULL,
  `address_text` varchar(255) DEFAULT NULL,
  `address_objid` varchar(50) DEFAULT NULL,
  `orgtype` varchar(50) DEFAULT NULL,
  `yearstarted` int(11) DEFAULT NULL,
  `activeyear` int(11) DEFAULT NULL,
  `pin` varchar(50) DEFAULT NULL,
  `taxcredit` decimal(18,2) DEFAULT NULL,
  `currentapplicationid` varchar(50) DEFAULT NULL,
  `currentpermitid` varchar(50) DEFAULT NULL,
  `bin` varchar(50) DEFAULT NULL,
  `activeqtr` int(11) DEFAULT NULL,
  `appcount` int(11) DEFAULT NULL,
  `mobileno` varchar(50) DEFAULT NULL,
  `phoneno` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `apptype` varchar(50) DEFAULT NULL,
  `oldbin` varchar(50) DEFAULT NULL,
  `permit_objid` varchar(50) DEFAULT NULL,
  `permittype` varchar(50) DEFAULT NULL,
  `expirydate` date DEFAULT NULL,
  `officetype` varchar(25) DEFAULT NULL,
  `purpose` varchar(50) DEFAULT NULL,
  `nextrenewaldate` date DEFAULT NULL,
  `lockid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  UNIQUE KEY `uix_businessname` (`businessname`),
  UNIQUE KEY `uix_bin` (`bin`),
  KEY `ix_state` (`state`),
  KEY `ix_owner_objid` (`owner_objid`),
  KEY `ix_owner_name` (`owner_name`),
  KEY `ix_owner_address_objid` (`owner_address_objid`),
  KEY `ix_tradename` (`tradename`),
  KEY `ix_address_objid` (`address_objid`),
  KEY `ix_bin` (`bin`),
  KEY `ix_currentapplicationid` (`currentapplicationid`),
  KEY `ix_currentpermitid` (`currentpermitid`),
  KEY `ix_yearstarted` (`yearstarted`),
  KEY `ix_activeyear` (`activeyear`),
  CONSTRAINT `FK_business_business_address` FOREIGN KEY (`address_objid`) REFERENCES `business_address` (`objid`),
  CONSTRAINT `FK_business_business_application` FOREIGN KEY (`currentapplicationid`) REFERENCES `business_application` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `business_active_info` (
  `objid` varchar(50) NOT NULL DEFAULT '',
  `businessid` varchar(50) NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `attribute_objid` varchar(50) NOT NULL,
  `attribute_name` varchar(50) NOT NULL,
  `lob_objid` varchar(50) DEFAULT NULL,
  `lob_name` varchar(100) DEFAULT NULL,
  `decimalvalue` decimal(16,2) DEFAULT NULL,
  `intvalue` int(11) DEFAULT NULL,
  `stringvalue` varchar(255) DEFAULT NULL,
  `boolvalue` int(11) DEFAULT NULL,
  `phase` int(11) DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_businessid` (`businessid`),
  KEY `ix_attribute_objid` (`attribute_objid`),
  KEY `ix_attribute_name` (`attribute_name`),
  KEY `ix_lob_objid` (`lob_objid`),
  KEY `ix_lob_name` (`lob_name`),
  CONSTRAINT `FK_business_active_info_business` FOREIGN KEY (`businessid`) REFERENCES `business` (`objid`),
  CONSTRAINT `FK_business_active_info_lob` FOREIGN KEY (`lob_objid`) REFERENCES `lob` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `business_active_lob` (
  `objid` varchar(50) NOT NULL,
  `businessid` varchar(50) NOT NULL,
  `lobid` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_businessid` (`businessid`),
  KEY `ix_lobid` (`lobid`),
  CONSTRAINT `FK_business_active_lob_business` FOREIGN KEY (`businessid`) REFERENCES `business` (`objid`),
  CONSTRAINT `FK_business_active_lob_lob` FOREIGN KEY (`lobid`) REFERENCES `lob` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `business_active_lob_history` (
  `objid` varchar(50) NOT NULL,
  `businessid` varchar(50) DEFAULT NULL,
  `activeyear` int(11) DEFAULT NULL,
  `lobid` varchar(50) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_businessid` (`businessid`),
  KEY `ix_activeyear` (`activeyear`),
  KEY `ix_lobid` (`lobid`),
  CONSTRAINT `fk_business_active_lob_history_businessid` FOREIGN KEY (`businessid`) REFERENCES `business` (`objid`),
  CONSTRAINT `fk_business_active_lob_history_lobid` FOREIGN KEY (`lobid`) REFERENCES `lob` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `business_active_lob_history_forprocess` (
  `businessid` varchar(50) NOT NULL,
  PRIMARY KEY (`businessid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `business_address` (
  `objid` varchar(50) NOT NULL DEFAULT '',
  `businessid` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `addresstype` varchar(50) DEFAULT NULL,
  `barangay_objid` varchar(50) DEFAULT NULL,
  `barangay_name` varchar(100) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `province` varchar(50) DEFAULT NULL,
  `municipality` varchar(50) DEFAULT NULL,
  `bldgno` varchar(50) DEFAULT NULL,
  `bldgname` varchar(50) DEFAULT NULL,
  `unitno` varchar(50) DEFAULT NULL,
  `street` varchar(100) DEFAULT NULL,
  `subdivision` varchar(100) DEFAULT NULL,
  `pin` varchar(50) DEFAULT NULL,
  `monthlyrent` decimal(18,2) DEFAULT NULL,
  `lessor_objid` varchar(50) DEFAULT NULL,
  `lessor_name` varchar(255) DEFAULT NULL,
  `lessor_address_text` varchar(255) DEFAULT NULL,
  `rentedaddressid` varchar(50) DEFAULT NULL,
  `ownedaddressid` varchar(50) DEFAULT NULL,
  `lessor_address_objid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_businessid` (`businessid`),
  KEY `ix_barangay_objid` (`barangay_objid`),
  KEY `ix_lessor_objid` (`lessor_objid`),
  KEY `ix_rentedaddressid` (`rentedaddressid`),
  KEY `ix_ownedaddressid` (`ownedaddressid`),
  KEY `ix_lessor_address_objid` (`lessor_address_objid`),
  CONSTRAINT `FK_business_address_ownerid` FOREIGN KEY (`ownedaddressid`) REFERENCES `business_lessor` (`objid`),
  CONSTRAINT `FK_business_address_rentedaddressid` FOREIGN KEY (`rentedaddressid`) REFERENCES `business_lessor` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `business_application` (
  `objid` varchar(50) NOT NULL,
  `business_objid` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `appno` varchar(50) DEFAULT NULL,
  `apptype` varchar(25) DEFAULT NULL,
  `dtfiled` date DEFAULT NULL,
  `ownername` varchar(255) DEFAULT NULL,
  `owneraddress` varchar(255) DEFAULT NULL,
  `tradename` varchar(255) DEFAULT NULL,
  `businessaddress` varchar(255) DEFAULT NULL,
  `txndate` datetime DEFAULT NULL,
  `yearstarted` int(11) DEFAULT NULL,
  `appyear` int(11) DEFAULT NULL,
  `appqtr` int(11) DEFAULT NULL,
  `txnmode` varchar(25) DEFAULT NULL,
  `assessor_objid` varchar(50) DEFAULT NULL,
  `assessor_name` varchar(255) DEFAULT NULL,
  `assessor_title` varchar(50) DEFAULT NULL,
  `createdby_objid` varchar(50) DEFAULT NULL,
  `createdby_name` varchar(255) DEFAULT NULL,
  `approver_objid` varchar(50) DEFAULT NULL,
  `approver_name` varchar(255) DEFAULT NULL,
  `approver_title` varchar(50) DEFAULT NULL,
  `dtreleased` datetime DEFAULT NULL,
  `totals_tax` decimal(18,2) DEFAULT NULL,
  `totals_regfee` decimal(18,2) DEFAULT NULL,
  `totals_othercharge` decimal(18,2) DEFAULT NULL,
  `totals_total` decimal(18,2) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `permit_objid` varchar(50) DEFAULT NULL,
  `parentapplicationid` varchar(50) DEFAULT NULL,
  `nextbilldate` date DEFAULT NULL,
  PRIMARY KEY (`objid`),
  UNIQUE KEY `uix_appno` (`appno`),
  KEY `ix_business_objid` (`business_objid`),
  KEY `ix_state` (`state`),
  KEY `ix_dtfiled` (`dtfiled`),
  KEY `ix_ownername` (`ownername`),
  KEY `ix_owneraddress` (`owneraddress`),
  KEY `ix_tradename` (`tradename`),
  KEY `ix_txndate` (`txndate`),
  KEY `ix_appyear` (`appyear`),
  KEY `ix_businessaddress` (`businessaddress`),
  KEY `ix_assessor_objid` (`assessor_objid`),
  KEY `ix_createdby_objid` (`createdby_objid`),
  KEY `ix_approver_objid` (`approver_objid`),
  KEY `ix_dtreleased` (`dtreleased`),
  KEY `ix_permit_objid` (`permit_objid`),
  KEY `ix_parentapplicationid` (`parentapplicationid`),
  KEY `ix_nextbilldate` (`nextbilldate`),
  CONSTRAINT `FK_business_application_business` FOREIGN KEY (`business_objid`) REFERENCES `business` (`objid`),
  CONSTRAINT `FK_business_application_parent` FOREIGN KEY (`parentapplicationid`) REFERENCES `business_application` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `business_application_info` (
  `objid` varchar(50) NOT NULL DEFAULT '',
  `businessid` varchar(50) NOT NULL,
  `applicationid` varchar(50) DEFAULT NULL,
  `activeyear` int(11) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `attribute_objid` varchar(50) NOT NULL,
  `attribute_name` varchar(50) NOT NULL,
  `lob_objid` varchar(50) DEFAULT NULL,
  `lob_name` varchar(100) DEFAULT NULL,
  `decimalvalue` decimal(16,2) DEFAULT NULL,
  `intvalue` int(11) DEFAULT NULL,
  `stringvalue` varchar(255) DEFAULT NULL,
  `boolvalue` int(11) DEFAULT NULL,
  `phase` int(11) DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_businessid` (`businessid`),
  KEY `ix_applicationid` (`applicationid`),
  KEY `ix_activeyear` (`activeyear`),
  KEY `ix_attribute_objid` (`attribute_objid`),
  KEY `ix_lob_objid` (`lob_objid`),
  CONSTRAINT `FK_business_info_business` FOREIGN KEY (`businessid`) REFERENCES `business` (`objid`),
  CONSTRAINT `FK_business_info_business_application` FOREIGN KEY (`applicationid`) REFERENCES `business_application` (`objid`),
  CONSTRAINT `FK_business_info_business_lob` FOREIGN KEY (`lob_objid`) REFERENCES `lob` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `business_application_lob` (
  `objid` varchar(50) NOT NULL,
  `businessid` varchar(50) NOT NULL,
  `applicationid` varchar(50) DEFAULT NULL,
  `activeyear` int(11) NOT NULL,
  `lobid` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `assessmenttype` varchar(50) NOT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_businessid` (`businessid`),
  KEY `ix_applicationid` (`applicationid`),
  KEY `ix_activeyear` (`activeyear`),
  KEY `ix_lobid` (`lobid`),
  KEY `ix_name` (`name`),
  CONSTRAINT `fk_business_application_lob_application` FOREIGN KEY (`applicationid`) REFERENCES `business_application` (`objid`),
  CONSTRAINT `fk_business_application_lob_business` FOREIGN KEY (`businessid`) REFERENCES `business` (`objid`),
  CONSTRAINT `fk_business_application_lob_lob` FOREIGN KEY (`lobid`) REFERENCES `lob` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `business_application_task` (
  `objid` varchar(50) NOT NULL DEFAULT '',
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
  PRIMARY KEY (`objid`),
  KEY `ix_refid` (`refid`),
  KEY `ix_parentprocessid` (`parentprocessid`),
  KEY `ix_startdate` (`startdate`),
  KEY `ix_enddate` (`enddate`),
  KEY `ix_assignee_objid` (`assignee_objid`),
  KEY `ix_actor_objid` (`actor_objid`),
  CONSTRAINT `fk_business_application_task_application` FOREIGN KEY (`refid`) REFERENCES `business_application` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `business_application_task_lock` (
  `refid` varchar(50) NOT NULL,
  `state` varchar(50) NOT NULL,
  PRIMARY KEY (`refid`,`state`),
  KEY `ix_refid` (`refid`),
  CONSTRAINT `fk_business_application_task_lock_refid` FOREIGN KEY (`refid`) REFERENCES `business_application` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `business_application_workitem` (
  `objid` varchar(50) NOT NULL DEFAULT '',
  `refid` varchar(50) DEFAULT NULL,
  `taskid` varchar(50) DEFAULT NULL,
  `workitemid` varchar(50) DEFAULT NULL,
  `startdate` datetime DEFAULT NULL,
  `enddate` datetime DEFAULT NULL,
  `assignee_objid` varchar(50) DEFAULT NULL,
  `assignee_name` varchar(100) DEFAULT NULL,
  `actor_objid` varchar(50) DEFAULT NULL,
  `actor_name` varchar(100) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `action` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_refid` (`refid`),
  KEY `ix_taskid` (`taskid`),
  KEY `ix_workitemid` (`workitemid`),
  KEY `ix_startdate` (`startdate`),
  KEY `ix_enddate` (`enddate`),
  KEY `ix_assignee_objid` (`assignee_objid`),
  KEY `ix_actor_objid` (`actor_objid`),
  CONSTRAINT `fk_business_application_workitem_task` FOREIGN KEY (`taskid`) REFERENCES `business_application_task` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `business_billing` (
  `objid` varchar(50) NOT NULL,
  `applicationid` varchar(50) DEFAULT NULL,
  `businessid` varchar(50) DEFAULT NULL,
  `billdate` datetime DEFAULT NULL,
  `apptype` varchar(50) DEFAULT NULL,
  `appyear` int(11) DEFAULT NULL,
  `expirydate` datetime DEFAULT NULL,
  `amount` decimal(18,2) DEFAULT NULL,
  `surcharge` decimal(18,2) DEFAULT NULL,
  `interest` decimal(18,2) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  UNIQUE KEY `ix_applicationid` (`applicationid`),
  KEY `ix_businessid` (`businessid`),
  KEY `ix_billdate` (`billdate`),
  KEY `ix_appyear` (`appyear`),
  KEY `ix_expirydate` (`expirydate`),
  CONSTRAINT `FK_business_billing_applicationid` FOREIGN KEY (`applicationid`) REFERENCES `business_application` (`objid`),
  CONSTRAINT `FK_business_billing_businessid` FOREIGN KEY (`businessid`) REFERENCES `business` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `business_billing_item` (
  `objid` varchar(50) NOT NULL,
  `parentid` varchar(50) DEFAULT NULL,
  `receivableid` varchar(50) DEFAULT NULL,
  `account_objid` varchar(50) DEFAULT NULL,
  `account_title` varchar(255) DEFAULT NULL,
  `qtr` int(11) DEFAULT NULL,
  `duedate` datetime DEFAULT NULL,
  `amount` decimal(18,2) DEFAULT NULL,
  `surcharge` decimal(18,2) DEFAULT NULL,
  `interest` decimal(18,2) DEFAULT NULL,
  `discount` decimal(18,2) DEFAULT NULL,
  `lob_objid` varchar(50) DEFAULT NULL,
  `lob_assessmenttype` varchar(50) DEFAULT NULL,
  `taxfeetype` varchar(50) DEFAULT NULL,
  `paypriority` int(11) DEFAULT NULL,
  `sortorder` int(11) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_parentid` (`parentid`),
  KEY `ix_receivableid` (`receivableid`),
  KEY `ix_account_objid` (`account_objid`),
  KEY `ix_duedate` (`duedate`),
  KEY `ix_lob_objid` (`lob_objid`),
  CONSTRAINT `fk_business_billing_item_parent` FOREIGN KEY (`parentid`) REFERENCES `business_billing` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `business_billitem_txntype` (
  `objid` varchar(50) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `acctid` varchar(50) DEFAULT NULL,
  `feetype` varchar(50) DEFAULT NULL,
  `domain` varchar(100) DEFAULT NULL,
  `role` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_acctid` (`acctid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `business_change_log` (
  `objid` varchar(50) NOT NULL,
  `businessid` varchar(50) NOT NULL,
  `applicationid` varchar(50) NOT NULL,
  `entryno` varchar(50) NOT NULL,
  `dtfiled` datetime NOT NULL,
  `filedby_objid` varchar(50) NOT NULL,
  `filedby_name` varchar(100) NOT NULL,
  `changetype` varchar(50) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `particulars` text,
  PRIMARY KEY (`objid`),
  KEY `ix_businessid` (`businessid`),
  KEY `ix_applicationid` (`applicationid`),
  KEY `ix_entryno` (`entryno`),
  KEY `ix_dtfiled` (`dtfiled`),
  KEY `ix_filedby_objid` (`filedby_objid`),
  CONSTRAINT `FK_business_change_log_applicationid` FOREIGN KEY (`applicationid`) REFERENCES `business_application` (`objid`),
  CONSTRAINT `FK_business_change_log_businessid` FOREIGN KEY (`businessid`) REFERENCES `business` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `business_closure` (
  `objid` varchar(50) NOT NULL,
  `businessid` varchar(50) NOT NULL,
  `dtcreated` datetime NOT NULL,
  `createdby_objid` varchar(50) NOT NULL,
  `createdby_name` varchar(150) NOT NULL,
  `dtceased` date NOT NULL,
  `dtissued` datetime NOT NULL,
  `remarks` text,
  PRIMARY KEY (`objid`),
  UNIQUE KEY `uix_businessid` (`businessid`),
  KEY `ix_createdby_objid` (`createdby_objid`),
  KEY `ix_dtceased` (`dtceased`),
  KEY `ix_dtcreated` (`dtcreated`),
  KEY `ix_dtissued` (`dtissued`),
  CONSTRAINT `fk_business_closure_businessid` FOREIGN KEY (`businessid`) REFERENCES `business` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `business_compromise` (
  `objid` varchar(50) NOT NULL,
  `businessid` varchar(50) DEFAULT NULL,
  `txntype` varchar(50) DEFAULT NULL,
  `dtfiled` datetime DEFAULT NULL,
  `dtexpiry` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `createdby_objid` varchar(50) DEFAULT NULL,
  `createdby_name` varchar(255) DEFAULT NULL,
  `approver_objid` varchar(50) DEFAULT NULL,
  `approver_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_businessid` (`businessid`),
  KEY `ix_txntype` (`txntype`),
  KEY `ix_dtfiled` (`dtfiled`),
  KEY `ix_dtexpiry` (`dtexpiry`),
  KEY `ix_createdby_objid` (`createdby_objid`),
  KEY `ix_approver_objid` (`approver_objid`),
  CONSTRAINT `fk_business_compromise_business` FOREIGN KEY (`businessid`) REFERENCES `business` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `business_lessor` (
  `objid` varchar(50) NOT NULL,
  `government` int(11) DEFAULT NULL,
  `lessor_orgtype` varchar(50) DEFAULT NULL,
  `lessor_objid` varchar(50) DEFAULT NULL,
  `lessor_name` varchar(100) DEFAULT NULL,
  `lessor_address_text` varchar(255) DEFAULT NULL,
  `lessor_address_objid` varchar(50) DEFAULT NULL,
  `bldgno` varchar(50) DEFAULT NULL,
  `bldgname` varchar(50) DEFAULT NULL,
  `street` varchar(100) DEFAULT NULL,
  `subdivision` varchar(100) DEFAULT NULL,
  `barangay_objid` varchar(50) DEFAULT NULL,
  `barangay_name` varchar(100) DEFAULT NULL,
  `pin` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_lessor_objid` (`lessor_objid`),
  KEY `ix_lessor_address_objid` (`lessor_address_objid`),
  KEY `ix_bldgno` (`bldgno`),
  KEY `ix_bldgname` (`bldgname`),
  KEY `ix_barangay_objid` (`barangay_objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `business_payment` (
  `objid` varchar(50) NOT NULL,
  `businessid` varchar(50) DEFAULT NULL,
  `appyear` int(11) DEFAULT NULL,
  `applicationid` varchar(50) DEFAULT NULL,
  `refid` varchar(50) DEFAULT NULL,
  `reftype` varchar(50) DEFAULT NULL,
  `refno` varchar(50) DEFAULT NULL,
  `refdate` date DEFAULT NULL,
  `amount` decimal(18,2) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `voided` int(11) DEFAULT NULL,
  `paymentmode` varchar(50) DEFAULT NULL,
  `taxcredit` decimal(16,2) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_businessid` (`businessid`),
  KEY `ix_appyear` (`appyear`),
  KEY `ix_applicationid` (`applicationid`),
  KEY `ix_refid` (`refid`),
  KEY `ix_refno` (`refno`),
  KEY `ix_refdate` (`refdate`),
  CONSTRAINT `fk_business_payment_application` FOREIGN KEY (`applicationid`) REFERENCES `business_application` (`objid`),
  CONSTRAINT `fk_business_payment_business` FOREIGN KEY (`businessid`) REFERENCES `business` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `business_payment_item` (
  `objid` varchar(50) NOT NULL,
  `parentid` varchar(50) DEFAULT NULL,
  `receivableid` varchar(50) DEFAULT NULL,
  `amount` decimal(16,2) DEFAULT NULL,
  `discount` decimal(16,2) DEFAULT NULL,
  `account_objid` varchar(50) DEFAULT NULL,
  `account_code` varchar(50) DEFAULT NULL,
  `account_title` varchar(100) DEFAULT NULL,
  `lob_objid` varchar(50) DEFAULT NULL,
  `lob_name` varchar(255) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `txntype` varchar(50) DEFAULT NULL,
  `sortorder` int(11) DEFAULT NULL,
  `surcharge` decimal(16,2) DEFAULT NULL,
  `interest` decimal(16,2) DEFAULT NULL,
  `qtr` int(11) DEFAULT NULL,
  `partial` int(11) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_parentid` (`parentid`),
  KEY `ix_receivableid` (`receivableid`),
  KEY `ix_account_objid` (`account_objid`),
  KEY `ix_lob_objid` (`lob_objid`),
  CONSTRAINT `fk_business_payment_item_parent` FOREIGN KEY (`parentid`) REFERENCES `business_payment` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `business_permit` (
  `objid` varchar(50) NOT NULL,
  `businessid` varchar(50) DEFAULT NULL,
  `applicationid` varchar(50) DEFAULT NULL,
  `state` varchar(20) DEFAULT NULL,
  `permitno` varchar(20) DEFAULT NULL,
  `activeyear` int(11) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `permittype` varchar(20) DEFAULT NULL,
  `dtissued` date DEFAULT NULL,
  `issuedby_objid` varchar(50) DEFAULT NULL,
  `issuedby_name` varchar(255) DEFAULT NULL,
  `expirydate` date DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `plateno` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  UNIQUE KEY `uix_businessid_activeyear_version` (`businessid`,`activeyear`,`version`),
  UNIQUE KEY `uix_permitno` (`permitno`),
  KEY `ix_businessid` (`businessid`),
  KEY `ix_applicationid` (`applicationid`),
  KEY `ix_activeyear` (`activeyear`),
  KEY `ix_dtissued` (`dtissued`),
  KEY `ix_issuedby_objid` (`issuedby_objid`),
  KEY `ix_expirydate` (`expirydate`),
  KEY `ix_plateno` (`plateno`),
  CONSTRAINT `fk_business_permit_application` FOREIGN KEY (`applicationid`) REFERENCES `business_application` (`objid`),
  CONSTRAINT `fk_business_permit_business` FOREIGN KEY (`businessid`) REFERENCES `business` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `business_permit_lob` (
  `objid` varchar(50) NOT NULL,
  `parentid` varchar(50) DEFAULT NULL,
  `lobid` varchar(50) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `txndate` datetime DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_parentid` (`parentid`),
  KEY `ix_lobid` (`lobid`),
  KEY `ix_name` (`name`),
  CONSTRAINT `fk_business_permit_lob_lobid` FOREIGN KEY (`lobid`) REFERENCES `lob` (`objid`),
  CONSTRAINT `fk_business_permit_lob_parentid` FOREIGN KEY (`parentid`) REFERENCES `business_permit` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `business_permit_type` (
  `objid` varchar(10) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `options` varchar(255) DEFAULT NULL,
  `indexno` int(11) DEFAULT NULL,
  `handler` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `business_receivable` (
  `objid` varchar(50) NOT NULL,
  `businessid` varchar(50) DEFAULT NULL,
  `applicationid` varchar(50) DEFAULT NULL,
  `iyear` int(11) DEFAULT NULL,
  `account_objid` varchar(50) DEFAULT NULL,
  `account_title` varchar(100) DEFAULT NULL,
  `lob_objid` varchar(50) DEFAULT NULL,
  `lob_name` varchar(100) DEFAULT NULL,
  `amount` decimal(16,2) NOT NULL,
  `amtpaid` decimal(16,2) NOT NULL,
  `discount` decimal(16,2) NOT NULL,
  `taxcredit` decimal(16,2) DEFAULT NULL,
  `refid` varchar(50) DEFAULT NULL,
  `reftype` varchar(50) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `department` varchar(50) DEFAULT NULL,
  `taxfeetype` varchar(50) DEFAULT NULL,
  `qtr` int(11) DEFAULT NULL,
  `surcharge` decimal(16,2) DEFAULT NULL,
  `interest` decimal(16,2) DEFAULT NULL,
  `assessmenttype` varchar(50) DEFAULT NULL,
  `lastqtrpaid` int(11) DEFAULT NULL,
  `partial` int(11) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_businessid` (`businessid`),
  KEY `ix_applicationid` (`applicationid`),
  KEY `ix_account_objid` (`account_objid`),
  KEY `ix_lob_objid` (`lob_objid`),
  CONSTRAINT `fk_business_receivable_application` FOREIGN KEY (`applicationid`) REFERENCES `business_application` (`objid`),
  CONSTRAINT `fk_business_receivable_business` FOREIGN KEY (`businessid`) REFERENCES `business` (`objid`),
  CONSTRAINT `fk_business_receivable_lob_objid` FOREIGN KEY (`lob_objid`) REFERENCES `lob` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `business_receivable_detail` (
  `objid` varchar(50) NOT NULL,
  `receivableid` varchar(50) DEFAULT NULL,
  `qtr` int(11) DEFAULT NULL,
  `duedate` datetime DEFAULT NULL,
  `amount` decimal(18,2) DEFAULT NULL,
  `surcharge` decimal(18,2) DEFAULT NULL,
  `interest` decimal(18,2) DEFAULT NULL,
  `discount` decimal(18,2) DEFAULT NULL,
  `paypriority` int(11) DEFAULT NULL,
  `sortorder` int(11) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_receivableid` (`receivableid`),
  KEY `ix_duedate` (`duedate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `business_recurringfee` (
  `objid` varchar(50) NOT NULL DEFAULT '',
  `businessid` varchar(50) DEFAULT NULL,
  `state` varchar(20) DEFAULT NULL,
  `account_objid` varchar(50) DEFAULT NULL,
  `account_title` varchar(100) DEFAULT NULL,
  `amount` decimal(16,2) NOT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `department` varchar(50) DEFAULT NULL,
  `user_objid` varchar(50) DEFAULT NULL,
  `user_name` varchar(150) DEFAULT NULL,
  `txntype_objid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  UNIQUE KEY `uix_businessid_acctid` (`businessid`,`account_objid`),
  KEY `ix_businessid` (`businessid`),
  KEY `ix_account_objid` (`account_objid`),
  KEY `ix_txntype_objid` (`txntype_objid`),
  CONSTRAINT `fk_business_recurringfee_business` FOREIGN KEY (`businessid`) REFERENCES `business` (`objid`),
  CONSTRAINT `fk_business_recurringfee_txntype_objid` FOREIGN KEY (`txntype_objid`) REFERENCES `business_billitem_txntype` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `business_redflag` (
  `objid` varchar(50) NOT NULL,
  `businessid` varchar(50) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `dtfiled` datetime DEFAULT NULL,
  `filedby_objid` varchar(50) DEFAULT NULL,
  `filedby_name` varchar(255) DEFAULT NULL,
  `resolved` int(11) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `blockaction` varchar(50) DEFAULT NULL,
  `effectivedate` date DEFAULT NULL,
  `resolvedby_objid` varchar(50) DEFAULT NULL,
  `resolvedby_name` varchar(100) DEFAULT NULL,
  `caseno` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_businessid` (`businessid`),
  KEY `ix_dtfiled` (`dtfiled`),
  KEY `ix_filedby_objid` (`filedby_objid`),
  KEY `ix_effectivedate` (`effectivedate`),
  KEY `ix_resolvedby_objid` (`resolvedby_objid`),
  CONSTRAINT `fk_business_redflag_business` FOREIGN KEY (`businessid`) REFERENCES `business` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `business_requirement` (
  `objid` varchar(50) NOT NULL,
  `businessid` varchar(50) DEFAULT NULL,
  `applicationid` varchar(50) DEFAULT NULL,
  `refid` varchar(50) DEFAULT NULL,
  `reftype` varchar(50) DEFAULT NULL,
  `refno` varchar(50) DEFAULT NULL,
  `issuedby` varchar(100) DEFAULT NULL,
  `dtissued` date DEFAULT NULL,
  `placeissued` varchar(100) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `status` varchar(25) DEFAULT NULL,
  `step` varchar(50) DEFAULT NULL,
  `completedby_objid` varchar(50) DEFAULT NULL,
  `completedby_name` varchar(50) DEFAULT NULL,
  `dtcompleted` datetime DEFAULT NULL,
  `completed` int(11) DEFAULT NULL,
  `expirydate` date DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_businessid` (`businessid`),
  KEY `ix_applicationid` (`applicationid`),
  KEY `ix_refid` (`refid`),
  KEY `ix_refno` (`refno`),
  KEY `ix_dtissued` (`dtissued`),
  KEY `ix_completedby_objid` (`completedby_objid`),
  KEY `ix_dtcompleted` (`dtcompleted`),
  CONSTRAINT `fk_business_requirement_application` FOREIGN KEY (`applicationid`) REFERENCES `business_application` (`objid`),
  CONSTRAINT `fk_business_requirement_business` FOREIGN KEY (`businessid`) REFERENCES `business` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `business_sms` (
  `objid` varchar(50) NOT NULL,
  `businessid` varchar(50) DEFAULT NULL,
  `traceid` varchar(50) DEFAULT NULL,
  `phoneno` varchar(50) DEFAULT NULL,
  `logdate` datetime DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `amtpaid` decimal(10,2) DEFAULT NULL,
  `action` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `business_taxcredit` (
  `objid` varchar(50) NOT NULL DEFAULT '',
  `businessid` varchar(50) DEFAULT NULL,
  `currentlineno` int(11) DEFAULT NULL,
  `totaldr` decimal(18,2) DEFAULT NULL,
  `totalcr` decimal(18,2) DEFAULT NULL,
  `balance` decimal(18,2) DEFAULT NULL,
  PRIMARY KEY (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `business_taxcredit_item` (
  `objid` varchar(50) NOT NULL,
  `parentid` varchar(50) DEFAULT NULL,
  `lineno` int(11) DEFAULT NULL,
  `particulars` varchar(100) DEFAULT NULL,
  `refid` varchar(50) DEFAULT NULL,
  `refdate` date DEFAULT NULL,
  `refno` varchar(50) DEFAULT NULL,
  `reftype` varchar(20) DEFAULT NULL,
  `dr` decimal(18,2) DEFAULT NULL,
  `cr` decimal(18,2) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `parentid` (`parentid`),
  CONSTRAINT `FK_business_taxcredit_detail_business_taxcredit` FOREIGN KEY (`parentid`) REFERENCES `business_taxcredit` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `business_taxincentive` (
  `objid` varchar(50) NOT NULL,
  `businessid` varchar(50) DEFAULT NULL,
  `txntype` varchar(50) DEFAULT NULL,
  `dtfiled` datetime DEFAULT NULL,
  `dtexpiry` datetime DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `approver_objid` varchar(50) DEFAULT NULL,
  `approver_name` varchar(255) DEFAULT NULL,
  `createdby_objid` varchar(50) DEFAULT NULL,
  `createdby_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `businessrequirementtype` (
  `objid` varchar(50) NOT NULL,
  `code` varchar(50) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `handler` varchar(50) DEFAULT NULL,
  `system` int(11) DEFAULT NULL,
  `agency` varchar(50) DEFAULT NULL,
  `sortindex` int(11) DEFAULT NULL,
  `verifier` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  UNIQUE KEY `uix_code` (`code`),
  UNIQUE KEY `uix_title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `businessvariable` (
  `objid` varchar(50) NOT NULL,
  `state` varchar(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  `datatype` varchar(20) NOT NULL,
  `caption` varchar(50) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `arrayvalues` longtext,
  `system` int(11) DEFAULT NULL,
  `sortorder` int(11) DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `handler` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  UNIQUE KEY `uix_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `cashreceipt_group` (
  `objid` varchar(50) NOT NULL,
  `txndate` datetime NOT NULL,
  `controlid` varchar(50) NOT NULL,
  `amount` decimal(16,2) NOT NULL,
  `totalcash` decimal(16,2) NOT NULL,
  `totalnoncash` decimal(16,2) NOT NULL,
  `cashchange` decimal(16,2) NOT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_controlid` (`controlid`),
  KEY `ix_txndate` (`txndate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `cashreceipt_groupitem` (
  `objid` varchar(50) NOT NULL,
  `parentid` varchar(50) NOT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_parentid` (`parentid`),
  CONSTRAINT `fk_cashreceipt_groupitem_objid` FOREIGN KEY (`objid`) REFERENCES `cashreceipt` (`objid`),
  CONSTRAINT `fk_cashreceipt_groupitem_parentid` FOREIGN KEY (`parentid`) REFERENCES `cashreceipt_group` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `cashreceipt_plugin` (
  `objid` varchar(50) NOT NULL,
  `connection` varchar(150) NOT NULL,
  `servicename` varchar(255) NOT NULL,
  PRIMARY KEY (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `cashreceipt_rpt_share_forposting` (
  `objid` varchar(50) NOT NULL,
  `receiptid` varchar(50) NOT NULL,
  `rptledgerid` varchar(50) NOT NULL,
  `txndate` datetime NOT NULL,
  `error` int(255) NOT NULL,
  `msg` text,
  PRIMARY KEY (`objid`),
  UNIQUE KEY `ux_receiptid_rptledgerid` (`receiptid`,`rptledgerid`),
  KEY `fk_cashreceipt_rpt_share_forposing_rptledger` (`rptledgerid`),
  KEY `fk_cashreceipt_rpt_share_forposing_cashreceipt` (`receiptid`),
  CONSTRAINT `fk_cashreceipt_rpt_share_forposing_cashreceipt` FOREIGN KEY (`receiptid`) REFERENCES `cashreceipt` (`objid`),
  CONSTRAINT `fk_cashreceipt_rpt_share_forposing_rptledger` FOREIGN KEY (`rptledgerid`) REFERENCES `rptledger` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `lob` (
  `objid` varchar(50) NOT NULL,
  `state` varchar(10) NOT NULL,
  `name` varchar(255) NOT NULL,
  `classification_objid` varchar(50) NOT NULL,
  `psic` varchar(50) DEFAULT NULL,
  `psic_objid` varchar(50) DEFAULT NULL,
  `_ukey` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`objid`),
  UNIQUE KEY `uix_name` (`name`,`_ukey`),
  KEY `ix_name` (`name`),
  KEY `ix_classification_objid` (`classification_objid`),
  KEY `ix_psic` (`psic`),
  KEY `ix_psic_objid` (`psic_objid`),
  CONSTRAINT `lob_classification_objid_ibfk_1` FOREIGN KEY (`classification_objid`) REFERENCES `lobclassification` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `lob_lobattribute` (
  `lobid` varchar(50) NOT NULL,
  `lobattributeid` varchar(50) NOT NULL,
  PRIMARY KEY (`lobid`,`lobattributeid`),
  KEY `lobattributeid` (`lobattributeid`),
  CONSTRAINT `lob_lobattribute_ibfk_1` FOREIGN KEY (`lobid`) REFERENCES `lob` (`objid`),
  CONSTRAINT `lob_lobattribute_ibfk_2` FOREIGN KEY (`lobattributeid`) REFERENCES `lobattribute` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `lob_report_category` (
  `objid` varchar(50) NOT NULL,
  `parentid` varchar(50) DEFAULT NULL,
  `groupid` varchar(50) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `itemtype` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_parentid` (`parentid`),
  KEY `ix_groupid` (`groupid`),
  CONSTRAINT `fk_lob_report_category_groupid` FOREIGN KEY (`groupid`) REFERENCES `lob_report_group` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `lob_report_category_mapping` (
  `objid` varchar(50) NOT NULL,
  `lobid` varchar(50) NOT NULL,
  `categoryid` varchar(50) NOT NULL,
  PRIMARY KEY (`objid`),
  UNIQUE KEY `uix_categoryid` (`categoryid`),
  KEY `ix_lobid` (`lobid`),
  CONSTRAINT `fk_lob_report_category_mapping_categoryid` FOREIGN KEY (`categoryid`) REFERENCES `lob_report_category` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `lob_report_group` (
  `objid` varchar(50) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `lobattribute` (
  `objid` varchar(50) NOT NULL,
  `state` varchar(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `lobclassification` (
  `objid` varchar(50) NOT NULL,
  `state` varchar(10) NOT NULL,
  `name` varchar(100) NOT NULL,
  `remarks` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `online_business_application` (
  `objid` varchar(50) NOT NULL,
  `state` varchar(20) NOT NULL,
  `dtcreated` datetime NOT NULL,
  `createdby_objid` varchar(50) NOT NULL,
  `createdby_name` varchar(100) NOT NULL,
  `controlno` varchar(25) NOT NULL,
  `prevapplicationid` varchar(50) NOT NULL,
  `business_objid` varchar(50) NOT NULL,
  `appyear` int(11) NOT NULL,
  `apptype` varchar(20) NOT NULL,
  `appdate` date NOT NULL,
  `lobs` text NOT NULL,
  `infos` longtext NOT NULL,
  `requirements` longtext NOT NULL,
  `step` int(11) NOT NULL DEFAULT '0',
  `dtapproved` datetime DEFAULT NULL,
  `approvedby_objid` varchar(50) DEFAULT NULL,
  `approvedby_name` varchar(150) DEFAULT NULL,
  `approvedappno` varchar(25) DEFAULT NULL,
  `contact_name` varchar(255) NOT NULL,
  `contact_address` varchar(255) NOT NULL,
  `contact_email` varchar(255) NOT NULL,
  `contact_mobileno` varchar(15) DEFAULT NULL,
  `partnername` varchar(50) NOT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_state` (`state`),
  KEY `ix_dtcreated` (`dtcreated`),
  KEY `ix_controlno` (`controlno`),
  KEY `ix_prevapplicationid` (`prevapplicationid`),
  KEY `ix_business_objid` (`business_objid`),
  KEY `ix_appyear` (`appyear`),
  KEY `ix_appdate` (`appdate`),
  KEY `ix_dtapproved` (`dtapproved`),
  KEY `ix_approvedby_objid` (`approvedby_objid`),
  KEY `ix_approvedby_name` (`approvedby_name`),
  CONSTRAINT `fk_online_business_application_business_objid` FOREIGN KEY (`business_objid`) REFERENCES `business` (`objid`),
  CONSTRAINT `fk_online_business_application_prevapplicationid` FOREIGN KEY (`prevapplicationid`) REFERENCES `business_application` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `psic` (
  `objid` varchar(50) NOT NULL,
  `title` varchar(255) NOT NULL,
  `parentid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_title` (`title`),
  KEY `ix_parentid` (`parentid`),
  CONSTRAINT `fk_psic_parentid` FOREIGN KEY (`parentid`) REFERENCES `psic` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;
CREATE TABLE `sys_email_queue` (
  `objid` varchar(50) NOT NULL,
  `refid` varchar(50) NOT NULL,
  `state` int(11) NOT NULL,
  `reportid` varchar(50) DEFAULT NULL,
  `dtsent` datetime NOT NULL,
  `to` varchar(255) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `errmsg` longtext,
  `connection` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_refid` (`refid`),
  KEY `ix_state` (`state`),
  KEY `ix_reportid` (`reportid`),
  KEY `ix_dtsent` (`dtsent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;


drop view if exists vw_account_incometarget;
drop view if exists vw_account_item_mapping;
drop view if exists vw_account_mapping;
drop view if exists vw_af_control_detail;
drop view if exists vw_af_inventory_summary;
drop view if exists vw_afunit;
drop view if exists vw_business_application_lob_retire;
drop view if exists vw_cashbook_cashreceipt;
drop view if exists vw_cashbook_cashreceipt_share;
drop view if exists vw_cashbook_cashreceipt_share_payable;
drop view if exists vw_cashbook_cashreceiptvoid;
drop view if exists vw_cashbook_cashreceiptvoid_share;
drop view if exists vw_cashbook_cashreceiptvoid_share_payable;
drop view if exists vw_cashbook_remittance;
drop view if exists vw_cashbook_remittance_share;
drop view if exists vw_cashbook_remittance_share_payable;
drop view if exists vw_cashreceipt_itemaccount;
drop view if exists vw_cashreceipt_itemaccount_collectiongroup;
drop view if exists vw_cashreceipt_itemaccount_collectiontype;
drop view if exists vw_cashreceiptpayment_noncash;
drop view if exists vw_cashreceiptpayment_noncash_liquidated;
drop view if exists vw_certification_land_improvement;
drop view if exists vw_certification_landdetail;
drop view if exists vw_collectiongroup;
drop view if exists vw_collectiontype;
drop view if exists vw_collectiontype_account;
drop view if exists vw_collectionvoucher_cashreceiptitem;
drop view if exists vw_collectionvoucher_cashreceiptshare;
drop view if exists vw_deposit_fund_transfer;
drop view if exists vw_entity_relation;
drop view if exists vw_entityindividual;
drop view if exists vw_entityindividual_lookup;
drop view if exists vw_entityrelation_lookup;
drop view if exists vw_fund;
drop view if exists vw_income_ledger;
drop view if exists vw_income_summary;
drop view if exists vw_landtax_abstract_of_collection_detail;
drop view if exists vw_landtax_collection_detail;
drop view if exists vw_landtax_collection_detail_eor;
drop view if exists vw_landtax_collection_disposition_detail;
drop view if exists vw_landtax_collection_disposition_detail_eor;
drop view if exists vw_landtax_eor;
drop view if exists vw_landtax_eor_remittance;
drop view if exists vw_newly_assessed_property;
drop view if exists vw_online_business_application;
drop view if exists vw_real_property_payment;
drop view if exists vw_remittance_cashreceipt;
drop view if exists vw_remittance_cashreceipt_af;
drop view if exists vw_remittance_cashreceipt_afsummary;
drop view if exists vw_remittance_cashreceiptitem;
drop view if exists vw_remittance_cashreceiptpayment_noncash;
drop view if exists vw_remittance_cashreceiptshare;
drop view if exists vw_rptledger_cancelled_faas;


CREATE VIEW `vw_account_incometarget` AS select `t`.`objid` AS `objid`,`t`.`itemid` AS `itemid`,`t`.`year` AS `year`,`t`.`target` AS `target`,`a`.`maingroupid` AS `maingroupid`,`a`.`objid` AS `item_objid`,`a`.`code` AS `item_code`,`a`.`title` AS `item_title`,`a`.`level` AS `item_level`,`a`.`leftindex` AS `item_leftindex`,`g`.`objid` AS `group_objid`,`g`.`code` AS `group_code`,`g`.`title` AS `group_title`,`g`.`level` AS `group_level`,`g`.`leftindex` AS `group_leftindex` from ((`account_incometarget` `t` join `account` `a` on((`a`.`objid` = `t`.`itemid`))) join `account` `g` on((`g`.`objid` = `a`.`groupid`)))
;
CREATE VIEW `vw_income_ledger` AS select year(`jev`.`jevdate`) AS `year`,month(`jev`.`jevdate`) AS `month`,`jev`.`fundid` AS `fundid`,`l`.`itemacctid` AS `itemacctid`,`l`.`cr` AS `amount`,`l`.`jevid` AS `jevid`,`l`.`objid` AS `objid` from (`income_ledger` `l` join `jev` on((`jev`.`objid` = `l`.`jevid`))) union all select year(`jev`.`jevdate`) AS `year`,month(`jev`.`jevdate`) AS `month`,`jev`.`fundid` AS `fundid`,`l`.`refitemacctid` AS `itemacctid`,(`l`.`cr` - `l`.`dr`) AS `amount`,`l`.`jevid` AS `jevid`,`l`.`objid` AS `objid` from (`payable_ledger` `l` join `jev` on((`jev`.`objid` = `l`.`jevid`)))
;
CREATE VIEW `vw_income_summary` AS select `inc`.`refid` AS `refid`,`inc`.`refdate` AS `refdate`,`inc`.`acctid` AS `acctid`,`inc`.`fundid` AS `fundid`,`inc`.`amount` AS `amount`,`inc`.`refno` AS `refno`,`inc`.`reftype` AS `reftype`,`inc`.`orgid` AS `orgid`,`inc`.`collectorid` AS `collectorid`,`inc`.`refyear` AS `refyear`,`inc`.`refmonth` AS `refmonth`,`inc`.`refqtr` AS `refqtr`,`inc`.`remittanceid` AS `remittanceid`,`inc`.`remittancedate` AS `remittancedate`,`inc`.`remittanceyear` AS `remittanceyear`,`inc`.`remittancemonth` AS `remittancemonth`,`inc`.`remittanceqtr` AS `remittanceqtr`,`inc`.`liquidationid` AS `liquidationid`,`inc`.`liquidationdate` AS `liquidationdate`,`inc`.`liquidationyear` AS `liquidationyear`,`inc`.`liquidationmonth` AS `liquidationmonth`,`inc`.`liquidationqtr` AS `liquidationqtr`,`fund`.`groupid` AS `fundgroupid`,`ia`.`objid` AS `itemid`,`ia`.`code` AS `itemcode`,`ia`.`title` AS `itemtitle`,`ia`.`type` AS `itemtype` from ((`income_summary` `inc` join `fund` on((`fund`.`objid` = `inc`.`fundid`))) join `itemaccount` `ia` on((`ia`.`objid` = `inc`.`acctid`)))
;
CREATE VIEW `vw_account_item_mapping` AS select `a`.`objid` AS `objid`,`a`.`maingroupid` AS `maingroupid`,`a`.`code` AS `code`,`a`.`title` AS `title`,`a`.`groupid` AS `groupid`,`a`.`type` AS `type`,`a`.`leftindex` AS `leftindex`,`a`.`rightindex` AS `rightindex`,`a`.`level` AS `level`,`l`.`amount` AS `amount`,`l`.`fundid` AS `fundid`,`l`.`year` AS `year`,`l`.`month` AS `month`,`aim`.`itemid` AS `itemid`,`ia`.`code` AS `itemcode`,`ia`.`title` AS `itemtitle` from (((`account_item_mapping` `aim` join `account` `a` on((`a`.`objid` = `aim`.`acctid`))) join `itemaccount` `ia` on((`ia`.`objid` = `aim`.`itemid`))) join `vw_income_ledger` `l` on((`l`.`itemacctid` = `aim`.`itemid`)))
;
CREATE VIEW `vw_account_mapping` AS select `a`.`objid` AS `objid`,`a`.`maingroupid` AS `maingroupid`,`a`.`code` AS `code`,`a`.`title` AS `title`,`a`.`groupid` AS `groupid`,`a`.`type` AS `type`,`a`.`leftindex` AS `leftindex`,`a`.`rightindex` AS `rightindex`,`a`.`level` AS `level`,`m`.`itemid` AS `itemid`,`m`.`acctid` AS `acctid` from (`account_item_mapping` `m` join `account` `a` on((`a`.`objid` = `m`.`acctid`)))
;
CREATE VIEW `vw_af_control_detail` AS select `afd`.`objid` AS `objid`,`afd`.`state` AS `state`,`afd`.`controlid` AS `controlid`,`afd`.`indexno` AS `indexno`,`afd`.`refid` AS `refid`,`afd`.`aftxnitemid` AS `aftxnitemid`,`afd`.`refno` AS `refno`,`afd`.`reftype` AS `reftype`,`afd`.`refdate` AS `refdate`,`afd`.`txndate` AS `txndate`,`afd`.`txntype` AS `txntype`,`afd`.`receivedstartseries` AS `receivedstartseries`,`afd`.`receivedendseries` AS `receivedendseries`,`afd`.`beginstartseries` AS `beginstartseries`,`afd`.`beginendseries` AS `beginendseries`,`afd`.`issuedstartseries` AS `issuedstartseries`,`afd`.`issuedendseries` AS `issuedendseries`,`afd`.`endingstartseries` AS `endingstartseries`,`afd`.`endingendseries` AS `endingendseries`,`afd`.`qtyreceived` AS `qtyreceived`,`afd`.`qtybegin` AS `qtybegin`,`afd`.`qtyissued` AS `qtyissued`,`afd`.`qtyending` AS `qtyending`,`afd`.`qtycancelled` AS `qtycancelled`,`afd`.`remarks` AS `remarks`,`afd`.`issuedto_objid` AS `issuedto_objid`,`afd`.`issuedto_name` AS `issuedto_name`,`afd`.`respcenter_objid` AS `respcenter_objid`,`afd`.`respcenter_name` AS `respcenter_name`,`afd`.`prevdetailid` AS `prevdetailid`,`afd`.`aftxnid` AS `aftxnid`,`afc`.`afid` AS `afid`,`afc`.`unit` AS `unit`,`af`.`formtype` AS `formtype`,`af`.`denomination` AS `denomination`,`af`.`serieslength` AS `serieslength`,`afu`.`qty` AS `qty`,`afu`.`saleprice` AS `saleprice`,`afc`.`startseries` AS `startseries`,`afc`.`endseries` AS `endseries`,`afc`.`currentseries` AS `currentseries`,`afc`.`stubno` AS `stubno`,`afc`.`prefix` AS `prefix`,`afc`.`suffix` AS `suffix`,`afc`.`cost` AS `cost`,`afc`.`batchno` AS `batchno`,`afc`.`state` AS `controlstate`,`afd`.`qtyending` AS `qtybalance` from (((`af_control_detail` `afd` join `af_control` `afc` on((`afc`.`objid` = `afd`.`controlid`))) join `af` on((`af`.`objid` = `afc`.`afid`))) join `afunit` `afu` on(((`afu`.`itemid` = `af`.`objid`) and (`afu`.`unit` = `afc`.`unit`))))
;
CREATE VIEW `vw_af_inventory_summary` AS select `af`.`objid` AS `objid`,`af`.`title` AS `title`,`u`.`unit` AS `unit`,`af`.`formtype` AS `formtype`,(case when (`af`.`formtype` = 'serial') then 0 else 1 end) AS `formtypeindex`,(select count(0) from `af_control` where ((`af_control`.`afid` = `af`.`objid`) and (`af_control`.`state` = 'OPEN'))) AS `countopen`,(select count(0) from `af_control` where ((`af_control`.`afid` = `af`.`objid`) and (`af_control`.`state` = 'ISSUED'))) AS `countissued`,(select count(0) from `af_control` where ((`af_control`.`afid` = `af`.`objid`) and (`af_control`.`state` = 'ISSUED') and (`af_control`.`currentseries` > `af_control`.`endseries`))) AS `countclosed`,(select count(0) from `af_control` where ((`af_control`.`afid` = `af`.`objid`) and (`af_control`.`state` = 'SOLD'))) AS `countsold`,(select count(0) from `af_control` where ((`af_control`.`afid` = `af`.`objid`) and (`af_control`.`state` = 'PROCESSING'))) AS `countprocessing`,(select count(0) from `af_control` where ((`af_control`.`afid` = `af`.`objid`) and (`af_control`.`state` = 'HOLD'))) AS `counthold` from (`af` join `afunit` `u`) where (`af`.`objid` = `u`.`itemid`) order by (case when (`af`.`formtype` = 'serial') then 0 else 1 end),`af`.`objid`
;
CREATE VIEW `vw_afunit` AS select `u`.`objid` AS `objid`,`af`.`title` AS `title`,`af`.`usetype` AS `usetype`,`af`.`serieslength` AS `serieslength`,`af`.`system` AS `system`,`af`.`denomination` AS `denomination`,`af`.`formtype` AS `formtype`,`u`.`itemid` AS `itemid`,`u`.`unit` AS `unit`,`u`.`qty` AS `qty`,`u`.`saleprice` AS `saleprice`,`u`.`interval` AS `interval`,`u`.`cashreceiptprintout` AS `cashreceiptprintout`,`u`.`cashreceiptdetailprintout` AS `cashreceiptdetailprintout` from (`afunit` `u` join `af` on((`af`.`objid` = `u`.`itemid`)))
;
CREATE VIEW `vw_business_application_lob_retire` AS select `a`.`business_objid` AS `businessid`,`a`.`objid` AS `applicationid`,`a`.`appno` AS `appno`,`a`.`appyear` AS `appyear`,`a`.`dtfiled` AS `dtfiled`,`a`.`txndate` AS `txndate`,`a`.`tradename` AS `tradename`,`b`.`bin` AS `bin`,`alob`.`assessmenttype` AS `assessmenttype`,`alob`.`lobid` AS `lobid`,`alob`.`name` AS `lobname`,`a`.`objid` AS `refid`,`a`.`appno` AS `refno` from ((`business_application` `a` join `business_application_lob` `alob` on((`alob`.`applicationid` = `a`.`objid`))) join `business` `b` on((`b`.`objid` = `a`.`business_objid`))) where ((`alob`.`assessmenttype` = 'RETIRE') and (`a`.`state` = 'COMPLETED') and isnull(`a`.`parentapplicationid`)) union all select `pa`.`business_objid` AS `businessid`,`pa`.`objid` AS `applicationid`,`pa`.`appno` AS `appno`,`pa`.`appyear` AS `appyear`,`pa`.`dtfiled` AS `dtfiled`,`pa`.`txndate` AS `txndate`,`pa`.`tradename` AS `tradename`,`b`.`bin` AS `bin`,`alob`.`assessmenttype` AS `assessmenttype`,`alob`.`lobid` AS `lobid`,`alob`.`name` AS `lobname`,`a`.`objid` AS `refid`,`a`.`appno` AS `refno` from (((`business_application` `a` join `business_application` `pa` on((`pa`.`objid` = `a`.`parentapplicationid`))) join `business_application_lob` `alob` on((`alob`.`applicationid` = `a`.`objid`))) join `business` `b` on((`b`.`objid` = `pa`.`business_objid`))) where ((`alob`.`assessmenttype` = 'RETIRE') and (`a`.`state` = 'COMPLETED'))
;
CREATE VIEW `vw_cashbook_cashreceipt` AS select `c`.`objid` AS `objid`,`c`.`txndate` AS `txndate`,cast(`c`.`receiptdate` as date) AS `refdate`,`c`.`objid` AS `refid`,`c`.`receiptno` AS `refno`,'cashreceipt' AS `reftype`,concat(`ct`.`name`,' (',`c`.`paidby`,')') AS `particulars`,`ci`.`item_fund_objid` AS `fundid`,`c`.`collector_objid` AS `collectorid`,`ci`.`amount` AS `dr`,0.0 AS `cr`,`c`.`formno` AS `formno`,`c`.`formtype` AS `formtype`,`c`.`series` AS `series`,`c`.`controlid` AS `controlid`,`c`.`txndate` AS `sortdate`,`c`.`receiptdate` AS `receiptdate`,`c`.`objid` AS `receiptid`,`c`.`remittanceid` AS `remittanceid`,`r`.`controldate` AS `remittancedate`,`r`.`dtposted` AS `remittancedtposted` from (((`cashreceipt` `c` join `collectiontype` `ct` on((`ct`.`objid` = `c`.`collectiontype_objid`))) join `cashreceiptitem` `ci` on((`ci`.`receiptid` = `c`.`objid`))) left join `remittance` `r` on((`r`.`objid` = `c`.`remittanceid`)))
;
CREATE VIEW `vw_cashbook_cashreceipt_share` AS select `c`.`objid` AS `objid`,`c`.`txndate` AS `txndate`,cast(`c`.`receiptdate` as date) AS `refdate`,`c`.`objid` AS `refid`,`c`.`receiptno` AS `refno`,'cashreceipt' AS `reftype`,concat(`ct`.`name`,' (',`c`.`paidby`,')') AS `particulars`,`ia`.`fund_objid` AS `fundid`,`c`.`collector_objid` AS `collectorid`,`cs`.`amount` AS `dr`,0.0 AS `cr`,`c`.`formno` AS `formno`,`c`.`formtype` AS `formtype`,`c`.`series` AS `series`,`c`.`controlid` AS `controlid`,`c`.`txndate` AS `sortdate`,`c`.`receiptdate` AS `receiptdate`,`c`.`objid` AS `receiptid`,`cs`.`refitem_objid` AS `refitemid`,`c`.`remittanceid` AS `remittanceid`,`r`.`controldate` AS `remittancedate`,`r`.`dtposted` AS `remittancedtposted` from ((((`cashreceipt` `c` join `collectiontype` `ct` on((`ct`.`objid` = `c`.`collectiontype_objid`))) join `cashreceipt_share` `cs` on((`cs`.`receiptid` = `c`.`objid`))) join `itemaccount` `ia` on((`ia`.`objid` = `cs`.`refitem_objid`))) left join `remittance` `r` on((`r`.`objid` = `c`.`remittanceid`)))
;
CREATE VIEW `vw_cashbook_cashreceipt_share_payable` AS select `c`.`objid` AS `objid`,`c`.`txndate` AS `txndate`,cast(`c`.`receiptdate` as date) AS `refdate`,`c`.`objid` AS `refid`,`c`.`receiptno` AS `refno`,'cashreceipt' AS `reftype`,concat(`ct`.`name`,' (',`c`.`paidby`,')') AS `particulars`,`ia`.`fund_objid` AS `fundid`,`c`.`collector_objid` AS `collectorid`,`cs`.`amount` AS `dr`,0.0 AS `cr`,`c`.`formno` AS `formno`,`c`.`formtype` AS `formtype`,`c`.`series` AS `series`,`c`.`controlid` AS `controlid`,`c`.`txndate` AS `sortdate`,`c`.`receiptdate` AS `receiptdate`,`c`.`objid` AS `receiptid`,`cs`.`payableitem_objid` AS `payableitemid`,`c`.`remittanceid` AS `remittanceid`,`r`.`controldate` AS `remittancedate`,`r`.`dtposted` AS `remittancedtposted` from ((((`cashreceipt` `c` join `collectiontype` `ct` on((`ct`.`objid` = `c`.`collectiontype_objid`))) join `cashreceipt_share` `cs` on((`cs`.`receiptid` = `c`.`objid`))) join `itemaccount` `ia` on((`ia`.`objid` = `cs`.`payableitem_objid`))) left join `remittance` `r` on((`r`.`objid` = `c`.`remittanceid`)))
;
CREATE VIEW `vw_cashbook_cashreceiptvoid` AS select `v`.`objid` AS `objid`,`v`.`txndate` AS `txndate`,cast(`v`.`txndate` as date) AS `refdate`,`v`.`objid` AS `refid`,`c`.`receiptno` AS `refno`,'cashreceipt:void' AS `reftype`,concat('VOID ',`v`.`reason`) AS `particulars`,`ci`.`item_fund_objid` AS `fundid`,`c`.`collector_objid` AS `collectorid`,`ci`.`amount` AS `dr`,(case when isnull(`r`.`liquidatingofficer_objid`) then 0.0 when (`v`.`txndate` > `r`.`dtposted`) then `ci`.`amount` else 0.0 end) AS `cr`,`c`.`formno` AS `formno`,`c`.`formtype` AS `formtype`,`c`.`series` AS `series`,`c`.`controlid` AS `controlid`,`v`.`txndate` AS `sortdate`,`c`.`receiptdate` AS `receiptdate`,`c`.`remittanceid` AS `remittanceid`,`r`.`controldate` AS `remittancedate`,`r`.`dtposted` AS `remittancedtposted` from ((((`cashreceipt_void` `v` join `cashreceipt` `c` on((`c`.`objid` = `v`.`receiptid`))) join `cashreceiptitem` `ci` on((`ci`.`receiptid` = `c`.`objid`))) join `collectiontype` `ct` on((`ct`.`objid` = `c`.`collectiontype_objid`))) left join `remittance` `r` on((`r`.`objid` = `c`.`remittanceid`)))
;
CREATE VIEW `vw_cashbook_cashreceiptvoid_share` AS select `v`.`objid` AS `objid`,`v`.`txndate` AS `txndate`,cast(`v`.`txndate` as date) AS `refdate`,`v`.`objid` AS `refid`,`c`.`receiptno` AS `refno`,'cashreceipt:void' AS `reftype`,concat('VOID ',`v`.`reason`) AS `particulars`,`ia`.`fund_objid` AS `fundid`,`c`.`collector_objid` AS `collectorid`,`cs`.`amount` AS `dr`,(case when isnull(`r`.`liquidatingofficer_objid`) then 0.0 when (`v`.`txndate` > `r`.`dtposted`) then `cs`.`amount` else 0.0 end) AS `cr`,`c`.`formno` AS `formno`,`c`.`formtype` AS `formtype`,`c`.`series` AS `series`,`c`.`controlid` AS `controlid`,`v`.`txndate` AS `sortdate`,`c`.`receiptdate` AS `receiptdate`,`c`.`remittanceid` AS `remittanceid`,`r`.`controldate` AS `remittancedate`,`r`.`dtposted` AS `remittancedtposted` from (((((`cashreceipt_void` `v` join `cashreceipt` `c` on((`c`.`objid` = `v`.`receiptid`))) join `cashreceipt_share` `cs` on((`cs`.`receiptid` = `c`.`objid`))) join `itemaccount` `ia` on((`ia`.`objid` = `cs`.`refitem_objid`))) join `collectiontype` `ct` on((`ct`.`objid` = `c`.`collectiontype_objid`))) left join `remittance` `r` on((`r`.`objid` = `c`.`remittanceid`)))
;
CREATE VIEW `vw_cashbook_cashreceiptvoid_share_payable` AS select `v`.`objid` AS `objid`,`v`.`txndate` AS `txndate`,cast(`v`.`txndate` as date) AS `refdate`,`v`.`objid` AS `refid`,`c`.`receiptno` AS `refno`,'cashreceipt:void' AS `reftype`,concat('VOID ',`v`.`reason`) AS `particulars`,`ia`.`fund_objid` AS `fundid`,`c`.`collector_objid` AS `collectorid`,`cs`.`amount` AS `dr`,(case when isnull(`r`.`liquidatingofficer_objid`) then 0.0 when (`v`.`txndate` > `r`.`dtposted`) then `cs`.`amount` else 0.0 end) AS `cr`,`c`.`formno` AS `formno`,`c`.`formtype` AS `formtype`,`c`.`series` AS `series`,`c`.`controlid` AS `controlid`,`v`.`txndate` AS `sortdate`,`c`.`receiptdate` AS `receiptdate`,`c`.`remittanceid` AS `remittanceid`,`r`.`controldate` AS `remittancedate`,`r`.`dtposted` AS `remittancedtposted` from (((((`cashreceipt_void` `v` join `cashreceipt` `c` on((`c`.`objid` = `v`.`receiptid`))) join `cashreceipt_share` `cs` on((`cs`.`receiptid` = `c`.`objid`))) join `itemaccount` `ia` on((`ia`.`objid` = `cs`.`payableitem_objid`))) join `collectiontype` `ct` on((`ct`.`objid` = `c`.`collectiontype_objid`))) left join `remittance` `r` on((`r`.`objid` = `c`.`remittanceid`)))
;
CREATE VIEW `vw_cashbook_remittance` AS select `r`.`objid` AS `objid`,`r`.`dtposted` AS `txndate`,`r`.`controldate` AS `refdate`,`r`.`objid` AS `refid`,`r`.`controlno` AS `refno`,'remittance' AS `reftype`,'REMITTANCE' AS `particulars`,`ci`.`item_fund_objid` AS `fundid`,`r`.`collector_objid` AS `collectorid`,0.0 AS `dr`,`ci`.`amount` AS `cr`,'remittance' AS `formno`,'remittance' AS `formtype`,NULL AS `series`,NULL AS `controlid`,`r`.`dtposted` AS `sortdate`,`r`.`liquidatingofficer_objid` AS `liquidatingofficer_objid`,`r`.`liquidatingofficer_name` AS `liquidatingofficer_name`,`v`.`objid` AS `voidid`,`v`.`txndate` AS `voiddate` from (((`remittance` `r` join `cashreceipt` `c` on((`c`.`remittanceid` = `r`.`objid`))) join `cashreceiptitem` `ci` on((`ci`.`receiptid` = `c`.`objid`))) left join `cashreceipt_void` `v` on((`v`.`receiptid` = `c`.`objid`)))
;
CREATE VIEW `vw_cashbook_remittance_share` AS select `r`.`objid` AS `objid`,`r`.`dtposted` AS `txndate`,`r`.`controldate` AS `refdate`,`r`.`objid` AS `refid`,`r`.`controlno` AS `refno`,'remittance' AS `reftype`,'REMITTANCE' AS `particulars`,`ia`.`fund_objid` AS `fundid`,`r`.`collector_objid` AS `collectorid`,0.0 AS `dr`,`cs`.`amount` AS `cr`,'remittance' AS `formno`,'remittance' AS `formtype`,NULL AS `series`,NULL AS `controlid`,`r`.`dtposted` AS `sortdate`,`r`.`liquidatingofficer_objid` AS `liquidatingofficer_objid`,`r`.`liquidatingofficer_name` AS `liquidatingofficer_name`,`v`.`objid` AS `voidid`,`v`.`txndate` AS `voiddate` from ((((`remittance` `r` join `cashreceipt` `c` on((`c`.`remittanceid` = `r`.`objid`))) join `cashreceipt_share` `cs` on((`cs`.`receiptid` = `c`.`objid`))) join `itemaccount` `ia` on((`ia`.`objid` = `cs`.`refitem_objid`))) left join `cashreceipt_void` `v` on((`v`.`receiptid` = `c`.`objid`)))
;
CREATE VIEW `vw_cashbook_remittance_share_payable` AS select `r`.`objid` AS `objid`,`r`.`dtposted` AS `txndate`,`r`.`controldate` AS `refdate`,`r`.`objid` AS `refid`,`r`.`controlno` AS `refno`,'remittance' AS `reftype`,'REMITTANCE' AS `particulars`,`ia`.`fund_objid` AS `fundid`,`r`.`collector_objid` AS `collectorid`,0.0 AS `dr`,`cs`.`amount` AS `cr`,'remittance' AS `formno`,'remittance' AS `formtype`,NULL AS `series`,NULL AS `controlid`,`r`.`dtposted` AS `sortdate`,`r`.`liquidatingofficer_objid` AS `liquidatingofficer_objid`,`r`.`liquidatingofficer_name` AS `liquidatingofficer_name`,`v`.`objid` AS `voidid`,`v`.`txndate` AS `voiddate` from ((((`remittance` `r` join `cashreceipt` `c` on((`c`.`remittanceid` = `r`.`objid`))) join `cashreceipt_share` `cs` on((`cs`.`receiptid` = `c`.`objid`))) join `itemaccount` `ia` on((`ia`.`objid` = `cs`.`payableitem_objid`))) left join `cashreceipt_void` `v` on((`v`.`receiptid` = `c`.`objid`)))
;
CREATE VIEW `vw_cashreceipt_itemaccount` AS select `itemaccount`.`objid` AS `objid`,`itemaccount`.`state` AS `state`,`itemaccount`.`code` AS `code`,`itemaccount`.`title` AS `title`,`itemaccount`.`description` AS `description`,`itemaccount`.`type` AS `type`,`itemaccount`.`fund_objid` AS `fund_objid`,`itemaccount`.`fund_code` AS `fund_code`,`itemaccount`.`fund_title` AS `fund_title`,`itemaccount`.`defaultvalue` AS `defaultvalue`,`itemaccount`.`valuetype` AS `valuetype`,`itemaccount`.`sortorder` AS `sortorder`,`itemaccount`.`org_objid` AS `orgid`,`itemaccount`.`hidefromlookup` AS `hidefromlookup` from `itemaccount` where ((`itemaccount`.`state` = 'ACTIVE') and (`itemaccount`.`type` in ('REVENUE','NONREVENUE','PAYABLE')) and (ifnull(`itemaccount`.`generic`,0) = 0))
;
CREATE VIEW `vw_cashreceipt_itemaccount_collectiongroup` AS select `ia`.`objid` AS `objid`,`ia`.`state` AS `state`,`ia`.`code` AS `code`,`ia`.`title` AS `title`,`ia`.`description` AS `description`,`ia`.`type` AS `type`,`ia`.`fund_objid` AS `fund_objid`,`ia`.`fund_code` AS `fund_code`,`ia`.`fund_title` AS `fund_title`,(case when (`ca`.`defaultvalue` = 0) then `ia`.`defaultvalue` else `ca`.`defaultvalue` end) AS `defaultvalue`,(case when (`ca`.`defaultvalue` = 0) then `ia`.`valuetype` else `ca`.`valuetype` end) AS `valuetype`,`ca`.`sortorder` AS `sortorder`,`ia`.`org_objid` AS `orgid`,`ca`.`collectiongroupid` AS `collectiongroupid`,`ia`.`generic` AS `generic` from (`collectiongroup_account` `ca` join `itemaccount` `ia` on((`ia`.`objid` = `ca`.`account_objid`)))
;
CREATE VIEW `vw_cashreceipt_itemaccount_collectiontype` AS select `ia`.`objid` AS `objid`,`ia`.`state` AS `state`,`ia`.`code` AS `code`,`ia`.`title` AS `title`,`ia`.`description` AS `description`,`ia`.`type` AS `type`,`ia`.`fund_objid` AS `fund_objid`,`ia`.`fund_code` AS `fund_code`,`ia`.`fund_title` AS `fund_title`,`ca`.`defaultvalue` AS `defaultvalue`,(case when isnull(`ca`.`valuetype`) then 'ANY' else `ca`.`valuetype` end) AS `valuetype`,(case when isnull(`ca`.`sortorder`) then 0 else `ca`.`sortorder` end) AS `sortorder`,NULL AS `orgid`,`ca`.`collectiontypeid` AS `collectiontypeid`,0 AS `hasorg`,`ia`.`hidefromlookup` AS `hidefromlookup` from (((`collectiontype` `ct` join `collectiontype_account` `ca` on((`ca`.`collectiontypeid` = `ct`.`objid`))) join `itemaccount` `ia` on((`ia`.`objid` = `ca`.`account_objid`))) left join `collectiontype_org` `o` on((`o`.`collectiontypeid` = `ca`.`objid`))) where (isnull(`o`.`objid`) and (`ia`.`state` = 'ACTIVE') and (`ia`.`type` in ('REVENUE','NONREVENUE','PAYABLE'))) union all select `ia`.`objid` AS `objid`,`ia`.`state` AS `state`,`ia`.`code` AS `code`,`ia`.`title` AS `title`,`ia`.`description` AS `description`,`ia`.`type` AS `type`,`ia`.`fund_objid` AS `fund_objid`,`ia`.`fund_code` AS `fund_code`,`ia`.`fund_title` AS `fund_title`,`ca`.`defaultvalue` AS `defaultvalue`,(case when isnull(`ca`.`valuetype`) then 'ANY' else `ca`.`valuetype` end) AS `valuetype`,(case when isnull(`ca`.`sortorder`) then 0 else `ca`.`sortorder` end) AS `sortorder`,`o`.`org_objid` AS `orgid`,`ca`.`collectiontypeid` AS `collectiontypeid`,1 AS `hasorg`,`ia`.`hidefromlookup` AS `hidefromlookup` from (((`collectiontype` `ct` join `collectiontype_org` `o` on((`o`.`collectiontypeid` = `ct`.`objid`))) join `collectiontype_account` `ca` on((`ca`.`collectiontypeid` = `ct`.`objid`))) join `itemaccount` `ia` on((`ia`.`objid` = `ca`.`account_objid`))) where ((`ia`.`state` = 'ACTIVE') and (`ia`.`type` in ('REVENUE','NONREVENUE','PAYABLE')))
;
CREATE VIEW `vw_cashreceiptpayment_noncash` AS select `nc`.`objid` AS `objid`,`nc`.`receiptid` AS `receiptid`,`nc`.`refno` AS `refno`,`nc`.`refdate` AS `refdate`,`nc`.`reftype` AS `reftype`,`nc`.`amount` AS `amount`,`nc`.`particulars` AS `particulars`,`nc`.`account_objid` AS `account_objid`,`nc`.`account_code` AS `account_code`,`nc`.`account_name` AS `account_name`,`nc`.`account_fund_objid` AS `account_fund_objid`,`nc`.`account_fund_name` AS `account_fund_name`,`nc`.`account_bank` AS `account_bank`,`nc`.`fund_objid` AS `fund_objid`,`nc`.`refid` AS `refid`,`nc`.`checkid` AS `checkid`,`nc`.`voidamount` AS `voidamount`,`v`.`objid` AS `void_objid`,(case when isnull(`v`.`objid`) then 0 else 1 end) AS `voided`,`c`.`receiptno` AS `receipt_receiptno`,`c`.`receiptdate` AS `receipt_receiptdate`,`c`.`amount` AS `receipt_amount`,`c`.`collector_objid` AS `receipt_collector_objid`,`c`.`collector_name` AS `receipt_collector_name`,`c`.`remittanceid` AS `remittanceid`,`rem`.`objid` AS `remittance_objid`,`rem`.`controlno` AS `remittance_controlno`,`rem`.`controldate` AS `remittance_controldate` from (((`cashreceiptpayment_noncash` `nc` join `cashreceipt` `c` on((`c`.`objid` = `nc`.`receiptid`))) left join `cashreceipt_void` `v` on((`v`.`receiptid` = `c`.`objid`))) left join `remittance` `rem` on((`rem`.`objid` = `c`.`remittanceid`)))
;
CREATE VIEW `vw_cashreceiptpayment_noncash_liquidated` AS select `nc`.`objid` AS `objid`,`nc`.`receiptid` AS `receiptid`,`nc`.`refno` AS `refno`,`nc`.`refdate` AS `refdate`,`nc`.`reftype` AS `reftype`,`nc`.`amount` AS `amount`,`nc`.`particulars` AS `particulars`,`nc`.`account_objid` AS `account_objid`,`nc`.`account_code` AS `account_code`,`nc`.`account_name` AS `account_name`,`nc`.`account_fund_objid` AS `account_fund_objid`,`nc`.`account_fund_name` AS `account_fund_name`,`nc`.`account_bank` AS `account_bank`,`nc`.`fund_objid` AS `fund_objid`,`nc`.`refid` AS `refid`,`nc`.`checkid` AS `checkid`,`nc`.`voidamount` AS `voidamount`,`v`.`objid` AS `void_objid`,(case when isnull(`v`.`objid`) then 0 else 1 end) AS `voided`,`c`.`receiptno` AS `receipt_receiptno`,`c`.`receiptdate` AS `receipt_receiptdate`,`c`.`amount` AS `receipt_amount`,`c`.`collector_objid` AS `receipt_collector_objid`,`c`.`collector_name` AS `receipt_collector_name`,`c`.`remittanceid` AS `remittanceid`,`r`.`objid` AS `remittance_objid`,`r`.`controlno` AS `remittance_controlno`,`r`.`controldate` AS `remittance_controldate`,`r`.`collectionvoucherid` AS `collectionvoucherid`,`cv`.`objid` AS `collectionvoucher_objid`,`cv`.`controlno` AS `collectionvoucher_controlno`,`cv`.`controldate` AS `collectionvoucher_controldate`,`cv`.`depositvoucherid` AS `depositvoucherid` from ((((`collectionvoucher` `cv` join `remittance` `r` on((`r`.`collectionvoucherid` = `cv`.`objid`))) join `cashreceipt` `c` on((`c`.`remittanceid` = `r`.`objid`))) join `cashreceiptpayment_noncash` `nc` on((`nc`.`receiptid` = `c`.`objid`))) left join `cashreceipt_void` `v` on((`v`.`receiptid` = `c`.`objid`)))
;
CREATE VIEW `vw_certification_land_improvement` AS select `f`.`objid` AS `faasid`,`pt`.`name` AS `improvement`,`ptd`.`areacovered` AS `areacovered`,`ptd`.`productive` AS `productive`,`ptd`.`nonproductive` AS `nonproductive`,`ptd`.`basemarketvalue` AS `basemarketvalue`,`ptd`.`marketvalue` AS `marketvalue`,`ptd`.`unitvalue` AS `unitvalue`,`ptd`.`assessedvalue` AS `assessedvalue` from ((`faas` `f` join `planttreedetail` `ptd` on((`f`.`rpuid` = `ptd`.`landrpuid`))) join `planttree` `pt` on((`ptd`.`planttree_objid` = `pt`.`objid`)))
;
CREATE VIEW `vw_certification_landdetail` AS select `f`.`objid` AS `faasid`,`ld`.`areaha` AS `areaha`,`ld`.`areasqm` AS `areasqm`,`ld`.`assessedvalue` AS `assessedvalue`,`ld`.`marketvalue` AS `marketvalue`,`ld`.`basemarketvalue` AS `basemarketvalue`,`ld`.`unitvalue` AS `unitvalue`,`lspc`.`name` AS `specificclass_name` from ((`faas` `f` join `landdetail` `ld` on((`f`.`rpuid` = `ld`.`landrpuid`))) join `landspecificclass` `lspc` on((`ld`.`landspecificclass_objid` = `lspc`.`objid`)))
;
CREATE VIEW `vw_collectiongroup` AS select `cg`.`objid` AS `objid`,`cg`.`name` AS `name`,`cg`.`sharing` AS `sharing`,NULL AS `orgid` from (`collectiongroup` `cg` left join `collectiongroup_org` `co` on((`co`.`collectiongroupid` = `cg`.`objid`))) where ((`cg`.`state` = 'ACTIVE') and isnull(`co`.`objid`)) union select `cg`.`objid` AS `objid`,`cg`.`name` AS `name`,`cg`.`sharing` AS `sharing`,`co`.`org_objid` AS `orgid` from (`collectiongroup` `cg` join `collectiongroup_org` `co` on((`co`.`collectiongroupid` = `cg`.`objid`))) where (`cg`.`state` = 'ACTIVE')
;
CREATE VIEW `vw_collectiontype` AS select `c`.`objid` AS `objid`,`c`.`state` AS `state`,`c`.`name` AS `name`,`c`.`title` AS `title`,`c`.`formno` AS `formno`,`c`.`handler` AS `handler`,`c`.`allowbatch` AS `allowbatch`,`c`.`barcodekey` AS `barcodekey`,`c`.`allowonline` AS `allowonline`,`c`.`allowoffline` AS `allowoffline`,`c`.`sortorder` AS `sortorder`,`o`.`org_objid` AS `orgid`,`c`.`fund_objid` AS `fund_objid`,`c`.`fund_title` AS `fund_title`,`c`.`category` AS `category`,`c`.`queuesection` AS `queuesection`,`c`.`system` AS `system`,`af`.`formtype` AS `af_formtype`,`af`.`serieslength` AS `af_serieslength`,`af`.`denomination` AS `af_denomination`,`af`.`baseunit` AS `af_baseunit`,`c`.`allowpaymentorder` AS `allowpaymentorder`,`c`.`allowkiosk` AS `allowkiosk`,`c`.`allowcreditmemo` AS `allowcreditmemo` from ((`collectiontype_org` `o` join `collectiontype` `c` on((`c`.`objid` = `o`.`collectiontypeid`))) join `af` on((`af`.`objid` = `c`.`formno`))) where (`c`.`state` = 'ACTIVE') union select `c`.`objid` AS `objid`,`c`.`state` AS `state`,`c`.`name` AS `name`,`c`.`title` AS `title`,`c`.`formno` AS `formno`,`c`.`handler` AS `handler`,`c`.`allowbatch` AS `allowbatch`,`c`.`barcodekey` AS `barcodekey`,`c`.`allowonline` AS `allowonline`,`c`.`allowoffline` AS `allowoffline`,`c`.`sortorder` AS `sortorder`,NULL AS `orgid`,`c`.`fund_objid` AS `fund_objid`,`c`.`fund_title` AS `fund_title`,`c`.`category` AS `category`,`c`.`queuesection` AS `queuesection`,`c`.`system` AS `system`,`af`.`formtype` AS `af_formtype`,`af`.`serieslength` AS `af_serieslength`,`af`.`denomination` AS `af_denomination`,`af`.`baseunit` AS `af_baseunit`,`c`.`allowpaymentorder` AS `allowpaymentorder`,`c`.`allowkiosk` AS `allowkiosk`,`c`.`allowcreditmemo` AS `allowcreditmemo` from ((`collectiontype` `c` join `af` on((`af`.`objid` = `c`.`formno`))) left join `collectiontype_org` `o` on((`c`.`objid` = `o`.`collectiontypeid`))) where ((`c`.`state` = 'ACTIVE') and isnull(`o`.`objid`))
;
CREATE VIEW `vw_collectiontype_account` AS select `ia`.`objid` AS `objid`,`ia`.`code` AS `code`,`ia`.`title` AS `title`,`ia`.`fund_objid` AS `fund_objid`,`fund`.`code` AS `fund_code`,`fund`.`title` AS `fund_title`,`cta`.`collectiontypeid` AS `collectiontypeid`,`cta`.`tag` AS `tag`,`cta`.`valuetype` AS `valuetype`,`cta`.`defaultvalue` AS `defaultvalue` from ((`collectiontype_account` `cta` join `itemaccount` `ia` on((`ia`.`objid` = `cta`.`account_objid`))) join `fund` on((`fund`.`objid` = `ia`.`fund_objid`)))
;
CREATE VIEW `vw_remittance_cashreceipt` AS select `r`.`objid` AS `remittance_objid`,`r`.`controldate` AS `remittance_controldate`,`r`.`controlno` AS `remittance_controlno`,`c`.`remittanceid` AS `remittanceid`,`r`.`collectionvoucherid` AS `collectionvoucherid`,`c`.`controlid` AS `controlid`,`af`.`formtype` AS `formtype`,(case when (`af`.`formtype` = 'serial') then 0 else 1 end) AS `formtypeindexno`,`c`.`formno` AS `formno`,`c`.`stub` AS `stubno`,`c`.`series` AS `series`,`c`.`receiptno` AS `receiptno`,`c`.`receiptdate` AS `receiptdate`,`c`.`amount` AS `amount`,`c`.`totalnoncash` AS `totalnoncash`,(`c`.`amount` - `c`.`totalnoncash`) AS `totalcash`,(case when isnull(`v`.`objid`) then 0 else 1 end) AS `voided`,(case when isnull(`v`.`objid`) then 0 else `c`.`amount` end) AS `voidamount`,`c`.`paidby` AS `paidby`,`c`.`paidbyaddress` AS `paidbyaddress`,`c`.`payer_objid` AS `payer_objid`,`c`.`payer_name` AS `payer_name`,`c`.`collector_objid` AS `collector_objid`,`c`.`collector_name` AS `collector_name`,`c`.`collector_title` AS `collector_title`,`c`.`objid` AS `receiptid`,`c`.`collectiontype_objid` AS `collectiontype_objid`,`c`.`org_objid` AS `org_objid` from (((`remittance` `r` join `cashreceipt` `c` on((`c`.`remittanceid` = `r`.`objid`))) join `af` on((`af`.`objid` = `c`.`formno`))) left join `cashreceipt_void` `v` on((`v`.`receiptid` = `c`.`objid`)))
;
CREATE VIEW `vw_remittance_cashreceipt_af` AS select `cr`.`remittanceid` AS `remittanceid`,`cr`.`collector_objid` AS `collector_objid`,`cr`.`controlid` AS `controlid`,min(`cr`.`receiptno`) AS `fromreceiptno`,max(`cr`.`receiptno`) AS `toreceiptno`,min(`cr`.`series`) AS `fromseries`,max(`cr`.`series`) AS `toseries`,count(`cr`.`objid`) AS `qty`,sum(`cr`.`amount`) AS `amount`,0 AS `qtyvoided`,0.0 AS `voidamt`,0 AS `qtycancelled`,0.0 AS `cancelledamt`,`af`.`formtype` AS `formtype`,`af`.`serieslength` AS `serieslength`,`af`.`denomination` AS `denomination`,`cr`.`formno` AS `formno`,`afc`.`stubno` AS `stubno`,`afc`.`startseries` AS `startseries`,`afc`.`endseries` AS `endseries`,`afc`.`prefix` AS `prefix`,`afc`.`suffix` AS `suffix` from (((`cashreceipt` `cr` join `remittance` `rem` on((`rem`.`objid` = `cr`.`remittanceid`))) join `af_control` `afc` on((`cr`.`controlid` = `afc`.`objid`))) join `af` on((`afc`.`afid` = `af`.`objid`))) group by `cr`.`remittanceid`,`cr`.`collector_objid`,`cr`.`controlid`,`af`.`formtype`,`af`.`serieslength`,`af`.`denomination`,`cr`.`formno`,`afc`.`stubno`,`afc`.`startseries`,`afc`.`endseries`,`afc`.`prefix`,`afc`.`suffix` union all select `cr`.`remittanceid` AS `remittanceid`,`cr`.`collector_objid` AS `collector_objid`,`cr`.`controlid` AS `controlid`,NULL AS `fromreceiptno`,NULL AS `toreceiptno`,NULL AS `fromseries`,NULL AS `toseries`,0 AS `qty`,0.0 AS `amount`,count(`cr`.`objid`) AS `qtyvoided`,sum(`cr`.`amount`) AS `voidamt`,0 AS `qtycancelled`,0.0 AS `cancelledamt`,`af`.`formtype` AS `formtype`,`af`.`serieslength` AS `serieslength`,`af`.`denomination` AS `denomination`,`cr`.`formno` AS `formno`,`afc`.`stubno` AS `stubno`,`afc`.`startseries` AS `startseries`,`afc`.`endseries` AS `endseries`,`afc`.`prefix` AS `prefix`,`afc`.`suffix` AS `suffix` from ((((`cashreceipt` `cr` join `cashreceipt_void` `cv` on((`cv`.`receiptid` = `cr`.`objid`))) join `remittance` `rem` on((`rem`.`objid` = `cr`.`remittanceid`))) join `af_control` `afc` on((`cr`.`controlid` = `afc`.`objid`))) join `af` on((`afc`.`afid` = `af`.`objid`))) group by `cr`.`remittanceid`,`cr`.`collector_objid`,`cr`.`controlid`,`af`.`formtype`,`af`.`serieslength`,`af`.`denomination`,`cr`.`formno`,`afc`.`stubno`,`afc`.`startseries`,`afc`.`endseries`,`afc`.`prefix`,`afc`.`suffix` union all select `cr`.`remittanceid` AS `remittanceid`,`cr`.`collector_objid` AS `collector_objid`,`cr`.`controlid` AS `controlid`,NULL AS `fromreceiptno`,NULL AS `toreceiptno`,NULL AS `fromseries`,NULL AS `toseries`,0 AS `qty`,0.0 AS `amount`,0 AS `qtyvoided`,0.0 AS `voidamt`,count(`cr`.`objid`) AS `qtycancelled`,sum(`cr`.`amount`) AS `cancelledamt`,`af`.`formtype` AS `formtype`,`af`.`serieslength` AS `serieslength`,`af`.`denomination` AS `denomination`,`cr`.`formno` AS `formno`,`afc`.`stubno` AS `stubno`,`afc`.`startseries` AS `startseries`,`afc`.`endseries` AS `endseries`,`afc`.`prefix` AS `prefix`,`afc`.`suffix` AS `suffix` from (((`cashreceipt` `cr` join `remittance` `rem` on((`rem`.`objid` = `cr`.`remittanceid`))) join `af_control` `afc` on((`cr`.`controlid` = `afc`.`objid`))) join `af` on((`afc`.`afid` = `af`.`objid`))) where (`cr`.`state` = 'CANCELLED') group by `cr`.`remittanceid`,`cr`.`collector_objid`,`cr`.`controlid`,`af`.`formtype`,`af`.`serieslength`,`af`.`denomination`,`cr`.`formno`,`afc`.`stubno`,`afc`.`startseries`,`afc`.`endseries`,`afc`.`prefix`,`afc`.`suffix`
;
CREATE VIEW `vw_remittance_cashreceipt_afsummary` AS select concat(`v`.`remittanceid`,'|',`v`.`collector_objid`,'|',`v`.`controlid`) AS `objid`,`v`.`remittanceid` AS `remittanceid`,`v`.`collector_objid` AS `collector_objid`,`v`.`controlid` AS `controlid`,min(`v`.`fromreceiptno`) AS `fromreceiptno`,max(`v`.`toreceiptno`) AS `toreceiptno`,min(`v`.`fromseries`) AS `fromseries`,max(`v`.`toseries`) AS `toseries`,sum(`v`.`qty`) AS `qty`,sum(`v`.`amount`) AS `amount`,sum(`v`.`qtyvoided`) AS `qtyvoided`,sum(`v`.`voidamt`) AS `voidamt`,sum(`v`.`qtycancelled`) AS `qtycancelled`,sum(`v`.`cancelledamt`) AS `cancelledamt`,`v`.`formtype` AS `formtype`,`v`.`serieslength` AS `serieslength`,`v`.`denomination` AS `denomination`,`v`.`formno` AS `formno`,`v`.`stubno` AS `stubno`,`v`.`startseries` AS `startseries`,`v`.`endseries` AS `endseries`,`v`.`prefix` AS `prefix`,`v`.`suffix` AS `suffix` from `vw_remittance_cashreceipt_af` `v` group by `v`.`remittanceid`,`v`.`collector_objid`,`v`.`controlid`,`v`.`formtype`,`v`.`serieslength`,`v`.`denomination`,`v`.`formno`,`v`.`stubno`,`v`.`startseries`,`v`.`endseries`,`v`.`prefix`,`v`.`suffix`
;
CREATE VIEW `vw_remittance_cashreceiptitem` AS select `c`.`remittanceid` AS `remittanceid`,`r`.`controldate` AS `remittance_controldate`,`r`.`controlno` AS `remittance_controlno`,`r`.`collectionvoucherid` AS `collectionvoucherid`,`c`.`collectiontype_objid` AS `collectiontype_objid`,`c`.`collectiontype_name` AS `collectiontype_name`,`c`.`org_objid` AS `org_objid`,`c`.`org_name` AS `org_name`,`c`.`formtype` AS `formtype`,`c`.`formno` AS `formno`,`cri`.`receiptid` AS `receiptid`,`c`.`receiptdate` AS `receiptdate`,`c`.`receiptno` AS `receiptno`,`c`.`controlid` AS `controlid`,`c`.`series` AS `series`,`c`.`stub` AS `stubno`,`c`.`paidby` AS `paidby`,`c`.`paidbyaddress` AS `paidbyaddress`,`c`.`collector_objid` AS `collectorid`,`c`.`collector_name` AS `collectorname`,`c`.`collector_title` AS `collectortitle`,`cri`.`item_fund_objid` AS `fundid`,`cri`.`item_objid` AS `acctid`,`cri`.`item_code` AS `acctcode`,`cri`.`item_title` AS `acctname`,`cri`.`remarks` AS `remarks`,(case when isnull(`v`.`objid`) then `cri`.`amount` else 0.0 end) AS `amount`,(case when isnull(`v`.`objid`) then 0 else 1 end) AS `voided`,(case when isnull(`v`.`objid`) then 0.0 else `cri`.`amount` end) AS `voidamount`,(case when (`c`.`formtype` = 'serial') then 0 else 1 end) AS `formtypeindex` from (((`remittance` `r` join `cashreceipt` `c` on((`c`.`remittanceid` = `r`.`objid`))) join `cashreceiptitem` `cri` on((`cri`.`receiptid` = `c`.`objid`))) left join `cashreceipt_void` `v` on((`v`.`receiptid` = `c`.`objid`)))
;
CREATE VIEW `vw_remittance_cashreceiptpayment_noncash` AS select `nc`.`objid` AS `objid`,`nc`.`receiptid` AS `receiptid`,`nc`.`refno` AS `refno`,`nc`.`refdate` AS `refdate`,`nc`.`reftype` AS `reftype`,`nc`.`particulars` AS `particulars`,`nc`.`fund_objid` AS `fundid`,`nc`.`refid` AS `refid`,`nc`.`amount` AS `amount`,(case when isnull(`v`.`objid`) then 0 else 1 end) AS `voided`,(case when isnull(`v`.`objid`) then 0.0 else `nc`.`amount` end) AS `voidamount`,`cp`.`bankid` AS `bankid`,`cp`.`bank_name` AS `bank_name`,`c`.`remittanceid` AS `remittanceid`,`r`.`collectionvoucherid` AS `collectionvoucherid` from ((((`remittance` `r` join `cashreceipt` `c` on((`c`.`remittanceid` = `r`.`objid`))) join `cashreceiptpayment_noncash` `nc` on(((`nc`.`receiptid` = `c`.`objid`) and (`nc`.`reftype` = 'CHECK')))) join `checkpayment` `cp` on((`cp`.`objid` = `nc`.`refid`))) left join `cashreceipt_void` `v` on((`v`.`receiptid` = `c`.`objid`))) union all select `nc`.`objid` AS `objid`,`nc`.`receiptid` AS `receiptid`,`nc`.`refno` AS `refno`,`nc`.`refdate` AS `refdate`,'EFT' AS `reftype`,`nc`.`particulars` AS `particulars`,`nc`.`fund_objid` AS `fundid`,`nc`.`refid` AS `refid`,`nc`.`amount` AS `amount`,(case when isnull(`v`.`objid`) then 0 else 1 end) AS `voided`,(case when isnull(`v`.`objid`) then 0.0 else `nc`.`amount` end) AS `voidamount`,`ba`.`bank_objid` AS `bankid`,`ba`.`bank_name` AS `bank_name`,`c`.`remittanceid` AS `remittanceid`,`r`.`collectionvoucherid` AS `collectionvoucherid` from (((((`remittance` `r` join `cashreceipt` `c` on((`c`.`remittanceid` = `r`.`objid`))) join `cashreceiptpayment_noncash` `nc` on(((`nc`.`receiptid` = `c`.`objid`) and (`nc`.`reftype` = 'EFT')))) join `eftpayment` `eft` on((`eft`.`objid` = `nc`.`refid`))) join `bankaccount` `ba` on((`ba`.`objid` = `eft`.`bankacctid`))) left join `cashreceipt_void` `v` on((`v`.`receiptid` = `c`.`objid`)))
;
CREATE VIEW `vw_remittance_cashreceiptshare` AS select `c`.`remittanceid` AS `remittanceid`,`r`.`controldate` AS `remittance_controldate`,`r`.`controlno` AS `remittance_controlno`,`r`.`collectionvoucherid` AS `collectionvoucherid`,`c`.`formno` AS `formno`,`c`.`formtype` AS `formtype`,`c`.`controlid` AS `controlid`,`c`.`series` AS `series`,`cs`.`receiptid` AS `receiptid`,`c`.`receiptdate` AS `receiptdate`,`c`.`receiptno` AS `receiptno`,`c`.`paidby` AS `paidby`,`c`.`paidbyaddress` AS `paidbyaddress`,`c`.`org_objid` AS `org_objid`,`c`.`org_name` AS `org_name`,`c`.`collectiontype_objid` AS `collectiontype_objid`,`c`.`collectiontype_name` AS `collectiontype_name`,`c`.`collector_objid` AS `collectorid`,`c`.`collector_name` AS `collectorname`,`c`.`collector_title` AS `collectortitle`,`cs`.`refitem_objid` AS `refacctid`,`ia`.`fund_objid` AS `fundid`,`ia`.`objid` AS `acctid`,`ia`.`code` AS `acctcode`,`ia`.`title` AS `acctname`,(case when isnull(`v`.`objid`) then `cs`.`amount` else 0.0 end) AS `amount`,(case when isnull(`v`.`objid`) then 0 else 1 end) AS `voided`,(case when isnull(`v`.`objid`) then 0.0 else `cs`.`amount` end) AS `voidamount`,(case when (`c`.`formtype` = 'serial') then 0 else 1 end) AS `formtypeindex` from ((((`remittance` `r` join `cashreceipt` `c` on((`c`.`remittanceid` = `r`.`objid`))) join `cashreceipt_share` `cs` on((`cs`.`receiptid` = `c`.`objid`))) join `itemaccount` `ia` on((`ia`.`objid` = `cs`.`payableitem_objid`))) left join `cashreceipt_void` `v` on((`v`.`receiptid` = `c`.`objid`)))
;
CREATE VIEW `vw_collectionvoucher_cashreceiptitem` AS select `cv`.`controldate` AS `collectionvoucher_controldate`,`cv`.`controlno` AS `collectionvoucher_controlno`,`v`.`remittanceid` AS `remittanceid`,`v`.`remittance_controldate` AS `remittance_controldate`,`v`.`remittance_controlno` AS `remittance_controlno`,`v`.`collectionvoucherid` AS `collectionvoucherid`,`v`.`collectiontype_objid` AS `collectiontype_objid`,`v`.`collectiontype_name` AS `collectiontype_name`,`v`.`org_objid` AS `org_objid`,`v`.`org_name` AS `org_name`,`v`.`formtype` AS `formtype`,`v`.`formno` AS `formno`,`v`.`receiptid` AS `receiptid`,`v`.`receiptdate` AS `receiptdate`,`v`.`receiptno` AS `receiptno`,`v`.`controlid` AS `controlid`,`v`.`series` AS `series`,`v`.`stubno` AS `stubno`,`v`.`paidby` AS `paidby`,`v`.`paidbyaddress` AS `paidbyaddress`,`v`.`collectorid` AS `collectorid`,`v`.`collectorname` AS `collectorname`,`v`.`collectortitle` AS `collectortitle`,`v`.`fundid` AS `fundid`,`v`.`acctid` AS `acctid`,`v`.`acctcode` AS `acctcode`,`v`.`acctname` AS `acctname`,`v`.`remarks` AS `remarks`,`v`.`amount` AS `amount`,`v`.`voided` AS `voided`,`v`.`voidamount` AS `voidamount`,`v`.`formtypeindex` AS `formtypeindex` from (`collectionvoucher` `cv` join `vw_remittance_cashreceiptitem` `v` on((`v`.`collectionvoucherid` = `cv`.`objid`)))
;
CREATE VIEW `vw_collectionvoucher_cashreceiptshare` AS select `cv`.`controldate` AS `collectionvoucher_controldate`,`cv`.`controlno` AS `collectionvoucher_controlno`,`v`.`remittanceid` AS `remittanceid`,`v`.`remittance_controldate` AS `remittance_controldate`,`v`.`remittance_controlno` AS `remittance_controlno`,`v`.`collectionvoucherid` AS `collectionvoucherid`,`v`.`formno` AS `formno`,`v`.`formtype` AS `formtype`,`v`.`controlid` AS `controlid`,`v`.`receiptid` AS `receiptid`,`v`.`receiptdate` AS `receiptdate`,`v`.`receiptno` AS `receiptno`,`v`.`paidby` AS `paidby`,`v`.`paidbyaddress` AS `paidbyaddress`,`v`.`org_objid` AS `org_objid`,`v`.`org_name` AS `org_name`,`v`.`collectiontype_objid` AS `collectiontype_objid`,`v`.`collectiontype_name` AS `collectiontype_name`,`v`.`collectorid` AS `collectorid`,`v`.`collectorname` AS `collectorname`,`v`.`collectortitle` AS `collectortitle`,`v`.`refacctid` AS `refacctid`,`v`.`fundid` AS `fundid`,`v`.`acctid` AS `acctid`,`v`.`acctcode` AS `acctcode`,`v`.`acctname` AS `acctname`,`v`.`amount` AS `amount`,`v`.`voided` AS `voided`,`v`.`voidamount` AS `voidamount`,`v`.`formtypeindex` AS `formtypeindex` from (`collectionvoucher` `cv` join `vw_remittance_cashreceiptshare` `v` on((`v`.`collectionvoucherid` = `cv`.`objid`)))
;
CREATE VIEW `vw_deposit_fund_transfer` AS select `dft`.`objid` AS `objid`,`dft`.`amount` AS `amount`,`dft`.`todepositvoucherfundid` AS `todepositvoucherfundid`,`tof`.`objid` AS `todepositvoucherfund_fund_objid`,`tof`.`code` AS `todepositvoucherfund_fund_code`,`tof`.`title` AS `todepositvoucherfund_fund_title`,`dft`.`fromdepositvoucherfundid` AS `fromdepositvoucherfundid`,`fromf`.`objid` AS `fromdepositvoucherfund_fund_objid`,`fromf`.`code` AS `fromdepositvoucherfund_fund_code`,`fromf`.`title` AS `fromdepositvoucherfund_fund_title` from ((((`deposit_fund_transfer` `dft` join `depositvoucher_fund` `todv` on((`dft`.`todepositvoucherfundid` = `todv`.`objid`))) join `fund` `tof` on((`todv`.`fundid` = `tof`.`objid`))) join `depositvoucher_fund` `fromdv` on((`dft`.`fromdepositvoucherfundid` = `fromdv`.`objid`))) join `fund` `fromf` on((`fromdv`.`fundid` = `fromf`.`objid`)))
;
CREATE VIEW `vw_entityindividual` AS select `ei`.`objid` AS `objid`,`ei`.`lastname` AS `lastname`,`ei`.`firstname` AS `firstname`,`ei`.`middlename` AS `middlename`,`ei`.`birthdate` AS `birthdate`,`ei`.`birthplace` AS `birthplace`,`ei`.`citizenship` AS `citizenship`,`ei`.`gender` AS `gender`,`ei`.`civilstatus` AS `civilstatus`,`ei`.`profession` AS `profession`,`ei`.`tin` AS `tin`,`ei`.`sss` AS `sss`,`ei`.`height` AS `height`,`ei`.`weight` AS `weight`,`ei`.`acr` AS `acr`,`ei`.`religion` AS `religion`,`ei`.`photo` AS `photo`,`ei`.`thumbnail` AS `thumbnail`,`ei`.`profileid` AS `profileid`,`e`.`entityno` AS `entityno`,`e`.`type` AS `type`,`e`.`name` AS `name`,`e`.`entityname` AS `entityname`,`e`.`mobileno` AS `mobileno`,`e`.`phoneno` AS `phoneno`,`e`.`address_objid` AS `address_objid`,`e`.`address_text` AS `address_text` from (`entityindividual` `ei` join `entity` `e` on((`e`.`objid` = `ei`.`objid`)))
;
CREATE VIEW `vw_entityindividual_lookup` AS select `e`.`objid` AS `objid`,`e`.`entityno` AS `entityno`,`e`.`name` AS `name`,`e`.`address_text` AS `addresstext`,`e`.`type` AS `type`,`ei`.`lastname` AS `lastname`,`ei`.`firstname` AS `firstname`,`ei`.`middlename` AS `middlename`,`ei`.`gender` AS `gender`,`ei`.`birthdate` AS `birthdate`,`e`.`mobileno` AS `mobileno`,`e`.`phoneno` AS `phoneno` from (`entity` `e` join `entityindividual` `ei` on((`ei`.`objid` = `e`.`objid`)))
;
CREATE VIEW `vw_entity_relation` AS select `er`.`objid` AS `objid`,`er`.`entity_objid` AS `ownerid`,`ei`.`objid` AS `entityid`,`ei`.`entityno` AS `entityno`,`ei`.`name` AS `name`,`ei`.`firstname` AS `firstname`,`ei`.`lastname` AS `lastname`,`ei`.`middlename` AS `middlename`,`ei`.`birthdate` AS `birthdate`,`ei`.`gender` AS `gender`,`er`.`relation_objid` AS `relationship` from (`entity_relation` `er` join `vw_entityindividual` `ei` on((`er`.`relateto_objid` = `ei`.`objid`))) union all select `er`.`objid` AS `objid`,`er`.`relateto_objid` AS `ownerid`,`ei`.`objid` AS `entityid`,`ei`.`entityno` AS `entityno`,`ei`.`name` AS `name`,`ei`.`firstname` AS `firstname`,`ei`.`lastname` AS `lastname`,`ei`.`middlename` AS `middlename`,`ei`.`birthdate` AS `birthdate`,`ei`.`gender` AS `gender`,(case when (`ei`.`gender` = 'M') then `et`.`inverse_male` when (`ei`.`gender` = 'F') then `et`.`inverse_female` else `et`.`inverse_any` end) AS `relationship` from ((`entity_relation` `er` join `vw_entityindividual` `ei` on((`er`.`entity_objid` = `ei`.`objid`))) join `entity_relation_type` `et` on((`er`.`relation_objid` = `et`.`objid`)))
;
CREATE VIEW `vw_entityrelation_lookup` AS select `er`.`objid` AS `objid`,`er`.`entity_objid` AS `entity_objid`,`er`.`relateto_objid` AS `relateto_objid`,`er`.`relation_objid` AS `relation_objid`,`e`.`entityno` AS `entityno`,`e`.`name` AS `name`,`e`.`address_text` AS `addresstext`,`e`.`type` AS `type`,`ei`.`lastname` AS `lastname`,`ei`.`firstname` AS `firstname`,`ei`.`middlename` AS `middlename`,`ei`.`gender` AS `gender`,`ei`.`birthdate` AS `birthdate`,`e`.`mobileno` AS `mobileno`,`e`.`phoneno` AS `phoneno` from ((`entity_relation` `er` join `entityindividual` `ei` on((`ei`.`objid` = `er`.`relateto_objid`))) join `entity` `e` on((`e`.`objid` = `ei`.`objid`)))
;
CREATE VIEW `vw_fund` AS select `f`.`objid` AS `objid`,`f`.`parentid` AS `parentid`,`f`.`state` AS `state`,`f`.`code` AS `code`,`f`.`title` AS `title`,`f`.`type` AS `type`,`f`.`special` AS `special`,`f`.`system` AS `system`,`f`.`groupid` AS `groupid`,`f`.`depositoryfundid` AS `depositoryfundid`,`g`.`objid` AS `group_objid`,`g`.`title` AS `group_title`,`g`.`indexno` AS `group_indexno`,`d`.`objid` AS `depositoryfund_objid`,`d`.`state` AS `depositoryfund_state`,`d`.`code` AS `depositoryfund_code`,`d`.`title` AS `depositoryfund_title` from ((`fund` `f` left join `fundgroup` `g` on((`g`.`objid` = `f`.`groupid`))) left join `fund` `d` on((`d`.`objid` = `f`.`depositoryfundid`)))
;
CREATE VIEW `vw_landtax_abstract_of_collection_detail` AS select `liq`.`objid` AS `liquidationid`,`liq`.`controldate` AS `liquidationdate`,`rem`.`objid` AS `remittanceid`,`rem`.`dtposted` AS `remittancedate`,`cr`.`objid` AS `receiptid`,`cr`.`receiptdate` AS `ordate`,`cr`.`receiptno` AS `orno`,`cr`.`collector_objid` AS `collectorid`,`rl`.`objid` AS `rptledgerid`,`rl`.`fullpin` AS `fullpin`,`rl`.`titleno` AS `titleno`,`rl`.`cadastrallotno` AS `cadastrallotno`,`rl`.`rputype` AS `rputype`,`rl`.`totalmv` AS `totalmv`,`b`.`name` AS `barangay`,`rp`.`fromqtr` AS `fromqtr`,`rp`.`toqtr` AS `toqtr`,`rpi`.`year` AS `year`,`rpi`.`qtr` AS `qtr`,`rpi`.`revtype` AS `revtype`,(case when isnull(`cv`.`objid`) then `rl`.`owner_name` else '*** voided ***' end) AS `taxpayername`,(case when isnull(`cv`.`objid`) then `rl`.`tdno` else '' end) AS `tdno`,(case when isnull(`m`.`name`) then `c`.`name` else `m`.`name` end) AS `municityname`,(case when isnull(`cv`.`objid`) then `rl`.`classcode` else '' end) AS `classification`,(case when isnull(`cv`.`objid`) then `rl`.`totalav` else 0.0 end) AS `assessvalue`,(case when isnull(`cv`.`objid`) then `rl`.`totalav` else 0.0 end) AS `assessedvalue`,(case when (isnull(`cv`.`objid`) and (`rpi`.`revtype` = 'basic') and (`rpi`.`revperiod` in ('current','advance'))) then `rpi`.`amount` else 0.0 end) AS `basiccurrentyear`,(case when (isnull(`cv`.`objid`) and (`rpi`.`revtype` = 'basic') and (`rpi`.`revperiod` in ('previous','prior'))) then `rpi`.`amount` else 0.0 end) AS `basicpreviousyear`,(case when (isnull(`cv`.`objid`) and (`rpi`.`revtype` = 'basic')) then `rpi`.`discount` else 0.0 end) AS `basicdiscount`,(case when (isnull(`cv`.`objid`) and (`rpi`.`revtype` = 'basic') and (`rpi`.`revperiod` in ('current','advance'))) then `rpi`.`interest` else 0.0 end) AS `basicpenaltycurrent`,(case when (isnull(`cv`.`objid`) and (`rpi`.`revtype` = 'basic') and (`rpi`.`revperiod` in ('previous','prior'))) then `rpi`.`interest` else 0.0 end) AS `basicpenaltyprevious`,(case when (isnull(`cv`.`objid`) and (`rpi`.`revtype` = 'sef') and (`rpi`.`revperiod` in ('current','advance'))) then `rpi`.`amount` else 0.0 end) AS `sefcurrentyear`,(case when (isnull(`cv`.`objid`) and (`rpi`.`revtype` = 'sef') and (`rpi`.`revperiod` in ('previous','prior'))) then `rpi`.`amount` else 0.0 end) AS `sefpreviousyear`,(case when (isnull(`cv`.`objid`) and (`rpi`.`revtype` = 'sef')) then `rpi`.`discount` else 0.0 end) AS `sefdiscount`,(case when (isnull(`cv`.`objid`) and (`rpi`.`revtype` = 'sef') and (`rpi`.`revperiod` in ('current','advance'))) then `rpi`.`interest` else 0.0 end) AS `sefpenaltycurrent`,(case when (isnull(`cv`.`objid`) and (`rpi`.`revtype` = 'sef') and (`rpi`.`revperiod` in ('previous','prior'))) then `rpi`.`interest` else 0.0 end) AS `sefpenaltyprevious`,(case when (isnull(`cv`.`objid`) and (`rpi`.`revtype` = 'basicidle') and (`rpi`.`revperiod` in ('current','advance'))) then `rpi`.`amount` else 0.0 end) AS `basicidlecurrent`,(case when (isnull(`cv`.`objid`) and (`rpi`.`revtype` = 'basicidle') and (`rpi`.`revperiod` in ('previous','prior'))) then `rpi`.`amount` else 0.0 end) AS `basicidleprevious`,(case when (isnull(`cv`.`objid`) and (`rpi`.`revtype` = 'basicidle')) then `rpi`.`amount` else 0.0 end) AS `basicidlediscount`,(case when (isnull(`cv`.`objid`) and (`rpi`.`revtype` = 'basicidle') and (`rpi`.`revperiod` in ('current','advance'))) then `rpi`.`interest` else 0.0 end) AS `basicidlecurrentpenalty`,(case when (isnull(`cv`.`objid`) and (`rpi`.`revtype` = 'basicidle') and (`rpi`.`revperiod` in ('previous','prior'))) then `rpi`.`interest` else 0.0 end) AS `basicidlepreviouspenalty`,(case when (isnull(`cv`.`objid`) and (`rpi`.`revtype` = 'sh') and (`rpi`.`revperiod` in ('current','advance'))) then `rpi`.`amount` else 0.0 end) AS `shcurrent`,(case when (isnull(`cv`.`objid`) and (`rpi`.`revtype` = 'sh') and (`rpi`.`revperiod` in ('previous','prior'))) then `rpi`.`amount` else 0.0 end) AS `shprevious`,(case when (isnull(`cv`.`objid`) and (`rpi`.`revtype` = 'sh')) then `rpi`.`discount` else 0.0 end) AS `shdiscount`,(case when (isnull(`cv`.`objid`) and (`rpi`.`revtype` = 'sh') and (`rpi`.`revperiod` in ('current','advance'))) then `rpi`.`interest` else 0.0 end) AS `shcurrentpenalty`,(case when (isnull(`cv`.`objid`) and (`rpi`.`revtype` = 'sh') and (`rpi`.`revperiod` in ('previous','prior'))) then `rpi`.`interest` else 0.0 end) AS `shpreviouspenalty`,(case when (isnull(`cv`.`objid`) and (`rpi`.`revtype` = 'firecode')) then `rpi`.`amount` else 0.0 end) AS `firecode`,(case when isnull(`cv`.`objid`) then ((`rpi`.`amount` - `rpi`.`discount`) + `rpi`.`interest`) else 0.0 end) AS `total`,(case when isnull(`cv`.`objid`) then `rpi`.`partialled` else 0 end) AS `partialled` from ((((((((((`collectionvoucher` `liq` join `remittance` `rem` on((`rem`.`collectionvoucherid` = `liq`.`objid`))) join `cashreceipt` `cr` on((`rem`.`objid` = `cr`.`remittanceid`))) left join `cashreceipt_void` `cv` on((`cr`.`objid` = `cv`.`receiptid`))) join `rptpayment` `rp` on((`rp`.`receiptid` = `cr`.`objid`))) join `rptpayment_item` `rpi` on((`rpi`.`parentid` = `rp`.`objid`))) join `rptledger` `rl` on((`rl`.`objid` = `rp`.`refid`))) join `barangay` `b` on((`b`.`objid` = `rl`.`barangayid`))) left join `district` `d` on((`b`.`parentid` = `d`.`objid`))) left join `city` `c` on((`d`.`parentid` = `c`.`objid`))) left join `municipality` `m` on((`b`.`parentid` = `m`.`objid`)))
;
CREATE VIEW `vw_landtax_collection_detail` AS select `cv`.`objid` AS `liquidationid`,`cv`.`controldate` AS `liquidationdate`,`rem`.`objid` AS `remittanceid`,`rem`.`controldate` AS `remittancedate`,`cr`.`receiptdate` AS `receiptdate`,`o`.`objid` AS `lguid`,`o`.`name` AS `lgu`,`b`.`objid` AS `barangayid`,`b`.`indexno` AS `brgyindex`,`b`.`name` AS `barangay`,`ri`.`revperiod` AS `revperiod`,`ri`.`revtype` AS `revtype`,`ri`.`year` AS `year`,`ri`.`qtr` AS `qtr`,`ri`.`amount` AS `amount`,`ri`.`interest` AS `interest`,`ri`.`discount` AS `discount`,`pc`.`name` AS `classname`,`pc`.`orderno` AS `orderno`,`pc`.`special` AS `special`,(case when ((`ri`.`revperiod` = 'current') and (`ri`.`revtype` = 'basic')) then `ri`.`amount` else 0.0 end) AS `basiccurrent`,(case when (`ri`.`revtype` = 'basic') then `ri`.`discount` else 0.0 end) AS `basicdisc`,(case when ((`ri`.`revperiod` in ('previous','prior')) and (`ri`.`revtype` = 'basic')) then `ri`.`amount` else 0.0 end) AS `basicprev`,(case when ((`ri`.`revperiod` = 'current') and (`ri`.`revtype` = 'basic')) then `ri`.`interest` else 0.0 end) AS `basiccurrentint`,(case when ((`ri`.`revperiod` in ('previous','prior')) and (`ri`.`revtype` = 'basic')) then `ri`.`interest` else 0.0 end) AS `basicprevint`,(case when (`ri`.`revtype` = 'basic') then ((`ri`.`amount` - `ri`.`discount`) + `ri`.`interest`) else 0 end) AS `basicnet`,(case when ((`ri`.`revperiod` = 'current') and (`ri`.`revtype` = 'sef')) then `ri`.`amount` else 0.0 end) AS `sefcurrent`,(case when (`ri`.`revtype` = 'sef') then `ri`.`discount` else 0.0 end) AS `sefdisc`,(case when ((`ri`.`revperiod` in ('previous','prior')) and (`ri`.`revtype` = 'sef')) then `ri`.`amount` else 0.0 end) AS `sefprev`,(case when ((`ri`.`revperiod` = 'current') and (`ri`.`revtype` = 'sef')) then `ri`.`interest` else 0.0 end) AS `sefcurrentint`,(case when ((`ri`.`revperiod` in ('previous','prior')) and (`ri`.`revtype` = 'sef')) then `ri`.`interest` else 0.0 end) AS `sefprevint`,(case when (`ri`.`revtype` = 'sef') then ((`ri`.`amount` - `ri`.`discount`) + `ri`.`interest`) else 0 end) AS `sefnet`,(case when ((`ri`.`revperiod` = 'current') and (`ri`.`revtype` = 'basicidle')) then `ri`.`amount` else 0.0 end) AS `idlecurrent`,(case when ((`ri`.`revperiod` in ('previous','prior')) and (`ri`.`revtype` = 'basicidle')) then `ri`.`amount` else 0.0 end) AS `idleprev`,(case when (`ri`.`revtype` = 'basicidle') then `ri`.`discount` else 0.0 end) AS `idledisc`,(case when (`ri`.`revtype` = 'basicidle') then `ri`.`interest` else 0 end) AS `idleint`,(case when (`ri`.`revtype` = 'basicidle') then ((`ri`.`amount` - `ri`.`discount`) + `ri`.`interest`) else 0 end) AS `idlenet`,(case when ((`ri`.`revperiod` = 'current') and (`ri`.`revtype` = 'sh')) then `ri`.`amount` else 0.0 end) AS `shcurrent`,(case when ((`ri`.`revperiod` in ('previous','prior')) and (`ri`.`revtype` = 'sh')) then `ri`.`amount` else 0.0 end) AS `shprev`,(case when (`ri`.`revtype` = 'sh') then `ri`.`discount` else 0.0 end) AS `shdisc`,(case when (`ri`.`revtype` = 'sh') then `ri`.`interest` else 0 end) AS `shint`,(case when (`ri`.`revtype` = 'sh') then ((`ri`.`amount` - `ri`.`discount`) + `ri`.`interest`) else 0 end) AS `shnet`,(case when (`ri`.`revtype` = 'firecode') then ((`ri`.`amount` - `ri`.`discount`) + `ri`.`interest`) else 0 end) AS `firecode`,0.0 AS `levynet`,(case when isnull(`crv`.`objid`) then 0 else 1 end) AS `voided` from (((((((((`remittance` `rem` join `collectionvoucher` `cv` on((`cv`.`objid` = `rem`.`collectionvoucherid`))) join `cashreceipt` `cr` on((`cr`.`remittanceid` = `rem`.`objid`))) left join `cashreceipt_void` `crv` on((`cr`.`objid` = `crv`.`receiptid`))) join `rptpayment` `rp` on((`cr`.`objid` = `rp`.`receiptid`))) join `rptpayment_item` `ri` on((`rp`.`objid` = `ri`.`parentid`))) left join `rptledger` `rl` on((`rp`.`refid` = `rl`.`objid`))) left join `barangay` `b` on((`rl`.`barangayid` = `b`.`objid`))) left join `sys_org` `o` on((`rl`.`lguid` = `o`.`objid`))) left join `propertyclassification` `pc` on((`rl`.`classification_objid` = `pc`.`objid`)))
;
CREATE VIEW `vw_landtax_collection_detail_eor` AS select `rem`.`objid` AS `liquidationid`,`rem`.`controldate` AS `liquidationdate`,`rem`.`objid` AS `remittanceid`,`rem`.`controldate` AS `remittancedate`,`eor`.`receiptdate` AS `receiptdate`,`o`.`objid` AS `lguid`,`o`.`name` AS `lgu`,`b`.`objid` AS `barangayid`,`b`.`indexno` AS `brgyindex`,`b`.`name` AS `barangay`,`ri`.`revperiod` AS `revperiod`,`ri`.`revtype` AS `revtype`,`ri`.`year` AS `year`,`ri`.`qtr` AS `qtr`,`ri`.`amount` AS `amount`,`ri`.`interest` AS `interest`,`ri`.`discount` AS `discount`,`pc`.`name` AS `classname`,`pc`.`orderno` AS `orderno`,`pc`.`special` AS `special`,(case when ((`ri`.`revperiod` = 'current') and (`ri`.`revtype` = 'basic')) then `ri`.`amount` else 0.0 end) AS `basiccurrent`,(case when (`ri`.`revtype` = 'basic') then `ri`.`discount` else 0.0 end) AS `basicdisc`,(case when ((`ri`.`revperiod` in ('previous','prior')) and (`ri`.`revtype` = 'basic')) then `ri`.`amount` else 0.0 end) AS `basicprev`,(case when ((`ri`.`revperiod` = 'current') and (`ri`.`revtype` = 'basic')) then `ri`.`interest` else 0.0 end) AS `basiccurrentint`,(case when ((`ri`.`revperiod` in ('previous','prior')) and (`ri`.`revtype` = 'basic')) then `ri`.`interest` else 0.0 end) AS `basicprevint`,(case when (`ri`.`revtype` = 'basic') then ((`ri`.`amount` - `ri`.`discount`) + `ri`.`interest`) else 0 end) AS `basicnet`,(case when ((`ri`.`revperiod` = 'current') and (`ri`.`revtype` = 'sef')) then `ri`.`amount` else 0.0 end) AS `sefcurrent`,(case when (`ri`.`revtype` = 'sef') then `ri`.`discount` else 0.0 end) AS `sefdisc`,(case when ((`ri`.`revperiod` in ('previous','prior')) and (`ri`.`revtype` = 'sef')) then `ri`.`amount` else 0.0 end) AS `sefprev`,(case when ((`ri`.`revperiod` = 'current') and (`ri`.`revtype` = 'sef')) then `ri`.`interest` else 0.0 end) AS `sefcurrentint`,(case when ((`ri`.`revperiod` in ('previous','prior')) and (`ri`.`revtype` = 'sef')) then `ri`.`interest` else 0.0 end) AS `sefprevint`,(case when (`ri`.`revtype` = 'sef') then ((`ri`.`amount` - `ri`.`discount`) + `ri`.`interest`) else 0 end) AS `sefnet`,(case when ((`ri`.`revperiod` = 'current') and (`ri`.`revtype` = 'basicidle')) then `ri`.`amount` else 0.0 end) AS `idlecurrent`,(case when ((`ri`.`revperiod` in ('previous','prior')) and (`ri`.`revtype` = 'basicidle')) then `ri`.`amount` else 0.0 end) AS `idleprev`,(case when (`ri`.`revtype` = 'basicidle') then `ri`.`discount` else 0.0 end) AS `idledisc`,(case when (`ri`.`revtype` = 'basicidle') then `ri`.`interest` else 0 end) AS `idleint`,(case when (`ri`.`revtype` = 'basicidle') then ((`ri`.`amount` - `ri`.`discount`) + `ri`.`interest`) else 0 end) AS `idlenet`,(case when ((`ri`.`revperiod` = 'current') and (`ri`.`revtype` = 'sh')) then `ri`.`amount` else 0.0 end) AS `shcurrent`,(case when ((`ri`.`revperiod` in ('previous','prior')) and (`ri`.`revtype` = 'sh')) then `ri`.`amount` else 0.0 end) AS `shprev`,(case when (`ri`.`revtype` = 'sh') then `ri`.`discount` else 0.0 end) AS `shdisc`,(case when (`ri`.`revtype` = 'sh') then `ri`.`interest` else 0 end) AS `shint`,(case when (`ri`.`revtype` = 'sh') then ((`ri`.`amount` - `ri`.`discount`) + `ri`.`interest`) else 0 end) AS `shnet`,(case when (`ri`.`revtype` = 'firecode') then ((`ri`.`amount` - `ri`.`discount`) + `ri`.`interest`) else 0 end) AS `firecode`,0.0 AS `levynet` from (((((((`etracs255_carcar`.`vw_landtax_eor_remittance` `rem` join `etracs255_carcar`.`vw_landtax_eor` `eor` on((`rem`.`objid` = `eor`.`remittanceid`))) join `etracs255_carcar`.`rptpayment` `rp` on((`eor`.`objid` = `rp`.`receiptid`))) join `etracs255_carcar`.`rptpayment_item` `ri` on((`rp`.`objid` = `ri`.`parentid`))) left join `etracs255_carcar`.`rptledger` `rl` on((`rp`.`refid` = `rl`.`objid`))) left join `etracs255_carcar`.`barangay` `b` on((`rl`.`barangayid` = `b`.`objid`))) left join `etracs255_carcar`.`sys_org` `o` on((`rl`.`lguid` = `o`.`objid`))) left join `etracs255_carcar`.`propertyclassification` `pc` on((`rl`.`classification_objid` = `pc`.`objid`)))
;
CREATE VIEW `vw_landtax_collection_disposition_detail` AS select `cv`.`objid` AS `liquidationid`,`cv`.`controldate` AS `liquidationdate`,`rem`.`objid` AS `remittanceid`,`rem`.`controldate` AS `remittancedate`,`cr`.`receiptdate` AS `receiptdate`,`ri`.`revperiod` AS `revperiod`,(case when ((`ri`.`revtype` in ('basic','basicint','basicidle','basicidleint')) and (`ri`.`sharetype` in ('province','city'))) then `ri`.`amount` else 0.0 end) AS `provcitybasicshare`,(case when ((`ri`.`revtype` in ('basic','basicint','basicidle','basicidleint')) and (`ri`.`sharetype` = 'municipality')) then `ri`.`amount` else 0.0 end) AS `munibasicshare`,(case when ((`ri`.`revtype` in ('basic','basicint')) and (`ri`.`sharetype` = 'barangay')) then `ri`.`amount` else 0.0 end) AS `brgybasicshare`,(case when ((`ri`.`revtype` in ('sef','sefint')) and (`ri`.`sharetype` in ('province','city'))) then `ri`.`amount` else 0.0 end) AS `provcitysefshare`,(case when ((`ri`.`revtype` in ('sef','sefint')) and (`ri`.`sharetype` = 'municipality')) then `ri`.`amount` else 0.0 end) AS `munisefshare`,0.0 AS `brgysefshare`,(case when isnull(`crv`.`objid`) then 0 else 1 end) AS `voided` from (((((`remittance` `rem` join `collectionvoucher` `cv` on((`cv`.`objid` = `rem`.`collectionvoucherid`))) join `cashreceipt` `cr` on((`cr`.`remittanceid` = `rem`.`objid`))) left join `cashreceipt_void` `crv` on((`cr`.`objid` = `crv`.`receiptid`))) join `rptpayment` `rp` on((`cr`.`objid` = `rp`.`receiptid`))) join `rptpayment_share` `ri` on((`rp`.`objid` = `ri`.`parentid`)))
;
CREATE VIEW `vw_landtax_collection_disposition_detail_eor` AS select `rem`.`objid` AS `liquidationid`,`rem`.`controldate` AS `liquidationdate`,`rem`.`objid` AS `remittanceid`,`rem`.`controldate` AS `remittancedate`,`eor`.`receiptdate` AS `receiptdate`,`ri`.`revperiod` AS `revperiod`,(case when ((`ri`.`revtype` in ('basic','basicint','basicidle','basicidleint')) and (`ri`.`sharetype` in ('province','city'))) then `ri`.`amount` else 0.0 end) AS `provcitybasicshare`,(case when ((`ri`.`revtype` in ('basic','basicint','basicidle','basicidleint')) and (`ri`.`sharetype` = 'municipality')) then `ri`.`amount` else 0.0 end) AS `munibasicshare`,(case when ((`ri`.`revtype` in ('basic','basicint')) and (`ri`.`sharetype` = 'barangay')) then `ri`.`amount` else 0.0 end) AS `brgybasicshare`,(case when ((`ri`.`revtype` in ('sef','sefint')) and (`ri`.`sharetype` in ('province','city'))) then `ri`.`amount` else 0.0 end) AS `provcitysefshare`,(case when ((`ri`.`revtype` in ('sef','sefint')) and (`ri`.`sharetype` = 'municipality')) then `ri`.`amount` else 0.0 end) AS `munisefshare`,0.0 AS `brgysefshare` from (((`etracs255_carcar`.`vw_landtax_eor_remittance` `rem` join `etracs255_carcar`.`vw_landtax_eor` `eor` on((`rem`.`objid` = `eor`.`remittanceid`))) join `etracs255_carcar`.`rptpayment` `rp` on((`eor`.`objid` = `rp`.`receiptid`))) join `etracs255_carcar`.`rptpayment_share` `ri` on((`rp`.`objid` = `ri`.`parentid`)))
;
CREATE VIEW `vw_landtax_eor` AS select `eor`.`eor`.`objid` AS `objid`,`eor`.`eor`.`receiptno` AS `receiptno`,`eor`.`eor`.`receiptdate` AS `receiptdate`,`eor`.`eor`.`txndate` AS `txndate`,`eor`.`eor`.`state` AS `state`,`eor`.`eor`.`partnerid` AS `partnerid`,`eor`.`eor`.`txntype` AS `txntype`,`eor`.`eor`.`traceid` AS `traceid`,`eor`.`eor`.`tracedate` AS `tracedate`,`eor`.`eor`.`refid` AS `refid`,`eor`.`eor`.`paidby` AS `paidby`,`eor`.`eor`.`paidbyaddress` AS `paidbyaddress`,`eor`.`eor`.`payer_objid` AS `payer_objid`,`eor`.`eor`.`paymethod` AS `paymethod`,`eor`.`eor`.`paymentrefid` AS `paymentrefid`,`eor`.`eor`.`remittanceid` AS `remittanceid`,`eor`.`eor`.`remarks` AS `remarks`,`eor`.`eor`.`amount` AS `amount`,`eor`.`eor`.`lockid` AS `lockid` from `eor`.`eor`
;
CREATE VIEW `vw_landtax_eor_remittance` AS select `eor`.`eor_remittance`.`objid` AS `objid`,`eor`.`eor_remittance`.`state` AS `state`,`eor`.`eor_remittance`.`controlno` AS `controlno`,`eor`.`eor_remittance`.`partnerid` AS `partnerid`,`eor`.`eor_remittance`.`controldate` AS `controldate`,`eor`.`eor_remittance`.`dtcreated` AS `dtcreated`,`eor`.`eor_remittance`.`createdby_objid` AS `createdby_objid`,`eor`.`eor_remittance`.`createdby_name` AS `createdby_name`,`eor`.`eor_remittance`.`amount` AS `amount`,`eor`.`eor_remittance`.`dtposted` AS `dtposted`,`eor`.`eor_remittance`.`postedby_objid` AS `postedby_objid`,`eor`.`eor_remittance`.`postedby_name` AS `postedby_name`,`eor`.`eor_remittance`.`lockid` AS `lockid` from `eor`.`eor_remittance`
;
CREATE VIEW `vw_newly_assessed_property` AS select `f`.`objid` AS `objid`,`f`.`owner_name` AS `owner_name`,`f`.`tdno` AS `tdno`,`b`.`name` AS `barangay`,(case when (`f`.`rputype` = 'land') then 'LAND' when (`f`.`rputype` = 'bldg') then 'BUILDING' when (`f`.`rputype` = 'mach') then 'MACHINERY' when (`f`.`rputype` = 'planttree') then 'PLANT/TREE' else 'MISCELLANEOUS' end) AS `rputype`,`f`.`totalav` AS `totalav`,`f`.`effectivityyear` AS `effectivityyear` from (`faas_list` `f` join `barangay` `b` on((`f`.`barangayid` = `b`.`objid`))) where ((`f`.`state` in ('CURRENT','CANCELLED')) and (`f`.`txntype_objid` = 'ND'))
;
CREATE VIEW `vw_online_business_application` AS select `oa`.`objid` AS `objid`,`oa`.`state` AS `state`,`oa`.`dtcreated` AS `dtcreated`,`oa`.`createdby_objid` AS `createdby_objid`,`oa`.`createdby_name` AS `createdby_name`,`oa`.`controlno` AS `controlno`,`oa`.`apptype` AS `apptype`,`oa`.`appyear` AS `appyear`,`oa`.`appdate` AS `appdate`,`oa`.`prevapplicationid` AS `prevapplicationid`,`oa`.`business_objid` AS `business_objid`,`b`.`bin` AS `bin`,`b`.`tradename` AS `tradename`,`b`.`businessname` AS `businessname`,`b`.`address_text` AS `address_text`,`b`.`address_objid` AS `address_objid`,`b`.`owner_name` AS `owner_name`,`b`.`owner_address_text` AS `owner_address_text`,`b`.`owner_address_objid` AS `owner_address_objid`,`b`.`yearstarted` AS `yearstarted`,`b`.`orgtype` AS `orgtype`,`b`.`permittype` AS `permittype`,`b`.`officetype` AS `officetype`,`oa`.`step` AS `step` from ((`online_business_application` `oa` join `business_application` `a` on((`a`.`objid` = `oa`.`prevapplicationid`))) join `business` `b` on((`b`.`objid` = `a`.`business_objid`)))
;
CREATE VIEW `vw_real_property_payment` AS select `cv`.`controldate` AS `cv_controldate`,`rem`.`controldate` AS `rem_controldate`,`rl`.`owner_name` AS `owner_name`,`rl`.`tdno` AS `tdno`,`pc`.`name` AS `classification`,(case when (`rl`.`rputype` = 'land') then 'LAND' when (`rl`.`rputype` = 'bldg') then 'BUILDING' when (`rl`.`rputype` = 'mach') then 'MACHINERY' when (`rl`.`rputype` = 'planttree') then 'PLANT/TREE' else 'MISCELLANEOUS' end) AS `rputype`,`b`.`name` AS `barangay`,`rpi`.`year` AS `year`,`rpi`.`qtr` AS `qtr`,((`rpi`.`amount` + `rpi`.`interest`) - `rpi`.`discount`) AS `amount`,(case when isnull(`v`.`objid`) then 0 else 1 end) AS `voided` from ((((((((`collectionvoucher` `cv` join `remittance` `rem` on((`cv`.`objid` = `rem`.`collectionvoucherid`))) join `cashreceipt` `cr` on((`rem`.`objid` = `cr`.`remittanceid`))) join `rptpayment` `rp` on((`cr`.`objid` = `rp`.`receiptid`))) join `rptpayment_item` `rpi` on((`rp`.`objid` = `rpi`.`parentid`))) join `rptledger` `rl` on((`rp`.`refid` = `rl`.`objid`))) join `barangay` `b` on((`rl`.`barangayid` = `b`.`objid`))) join `propertyclassification` `pc` on((`rl`.`classification_objid` = `pc`.`objid`))) left join `cashreceipt_void` `v` on((`cr`.`objid` = `v`.`receiptid`)))
;
CREATE VIEW `vw_rptledger_cancelled_faas` AS select `rl`.`objid` AS `objid`,`rl`.`state` AS `state`,`rl`.`faasid` AS `faasid`,`rl`.`lastyearpaid` AS `lastyearpaid`,`rl`.`lastqtrpaid` AS `lastqtrpaid`,`rl`.`barangayid` AS `barangayid`,`rl`.`taxpayer_objid` AS `taxpayer_objid`,`rl`.`fullpin` AS `fullpin`,`rl`.`tdno` AS `tdno`,`rl`.`cadastrallotno` AS `cadastrallotno`,`rl`.`rputype` AS `rputype`,`rl`.`txntype_objid` AS `txntype_objid`,`rl`.`classification_objid` AS `classification_objid`,`rl`.`classcode` AS `classcode`,`rl`.`totalav` AS `totalav`,`rl`.`totalmv` AS `totalmv`,`rl`.`totalareaha` AS `totalareaha`,`rl`.`taxable` AS `taxable`,`rl`.`owner_name` AS `owner_name`,`rl`.`prevtdno` AS `prevtdno`,`rl`.`titleno` AS `titleno`,`rl`.`administrator_name` AS `administrator_name`,`rl`.`blockno` AS `blockno`,`rl`.`lguid` AS `lguid`,`rl`.`beneficiary_objid` AS `beneficiary_objid`,`pc`.`name` AS `classification`,`b`.`name` AS `barangay`,`o`.`name` AS `lgu` from (((((`rptledger` `rl` join `faas` `f` on((`rl`.`faasid` = `f`.`objid`))) left join `barangay` `b` on((`rl`.`barangayid` = `b`.`objid`))) left join `sys_org` `o` on((`rl`.`lguid` = `o`.`objid`))) left join `propertyclassification` `pc` on((`rl`.`classification_objid` = `pc`.`objid`))) join `entity` `e` on((`rl`.`taxpayer_objid` = `e`.`objid`))) where ((`rl`.`state` = 'APPROVED') and (`f`.`state` = 'CANCELLED'))
;








INSERT INTO `lobclassification` (`objid`, `state`, `name`, `remarks`) VALUES ('AMUSEMENT', 'DRAFT', 'AMUSEMENT ', 'AMUSEMENT');
INSERT INTO `lobclassification` (`objid`, `state`, `name`, `remarks`) VALUES ('ASSEMBLER', 'DRAFT', 'ASSEMBLER', 'ASSEMBLER');
INSERT INTO `lobclassification` (`objid`, `state`, `name`, `remarks`) VALUES ('CONTRACTORS', 'DRAFT', 'CONTRACTORS', 'CONTRACTORS');
INSERT INTO `lobclassification` (`objid`, `state`, `name`, `remarks`) VALUES ('DEALERS', 'DRAFT', 'DEALERS', 'DEALERS');
INSERT INTO `lobclassification` (`objid`, `state`, `name`, `remarks`) VALUES ('DISTRIBUTOR', 'DRAFT', 'DISTRIBUTOR', 'DISTRIBUTOR');
INSERT INTO `lobclassification` (`objid`, `state`, `name`, `remarks`) VALUES ('EXPORTER', 'DRAFT', 'EXPORTER ', 'EXPORTER');
INSERT INTO `lobclassification` (`objid`, `state`, `name`, `remarks`) VALUES ('FINANCIAL_INSTITUTIONS', 'DRAFT', 'FINANCIAL INSTITUTIONS', 'FINANCIAL INSTITUTIONS');
INSERT INTO `lobclassification` (`objid`, `state`, `name`, `remarks`) VALUES ('MANUFACTURER', 'DRAFT', 'MANUFACTURER', 'MANUFACTURER');
INSERT INTO `lobclassification` (`objid`, `state`, `name`, `remarks`) VALUES ('OTHER', 'DRAFT', 'OTHER BUSINESS ', 'OTHER BUSINESS');
INSERT INTO `lobclassification` (`objid`, `state`, `name`, `remarks`) VALUES ('PEDDLER', 'DRAFT', 'PEDDLER', 'PEDDLER');
INSERT INTO `lobclassification` (`objid`, `state`, `name`, `remarks`) VALUES ('PROCESSOR', 'DRAFT', 'PROCESSOR', 'PROCESSOR');
INSERT INTO `lobclassification` (`objid`, `state`, `name`, `remarks`) VALUES ('RETAILER', 'DRAFT', 'RETAILER', 'RETAILER');
INSERT INTO `lobclassification` (`objid`, `state`, `name`, `remarks`) VALUES ('SERVICES', 'DRAFT', 'SERVICES', 'SERVICES');
INSERT INTO `lobclassification` (`objid`, `state`, `name`, `remarks`) VALUES ('WHOLESALERS', 'DRAFT', 'WHOLESALERS', 'WHOLESALERS');

INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB-12ad73a4:17283234e49:-7bbf', 'APPROVED', 'CARWASH', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB-1a36cc7b:1572b29a4a4:-6de8', 'APPROVED', 'MONEY TRANSFER & REMITTANCES', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB-1a9da644:161f3d9cff1:-7fd2', 'APPROVED', 'PIZZA', 'MANUFACTURER', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB-1e77d65e:1609f8b6405:164f', 'APPROVED', 'RICE & CORN MILL SERVICES', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB-200a8393:150b6fae3a4:-5398', 'APPROVED', 'COMMERCIAL BANK', 'FINANCIAL_INSTITUTIONS', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB-200a8393:150b6fae3a4:-6087', 'APPROVED', 'COMMERCIAL BUILDING FOR RENT', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB-200a8393:150b6fae3a4:-60a3', 'APPROVED', 'COFFEE SHOP', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB-200a8393:150b6fae3a4:-60bd', 'APPROVED', 'COCONUT LUMBER', 'DEALERS', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB-200a8393:150b6fae3a4:-612b', 'APPROVED', 'CELLPHONE REPAIR SHOP', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB-200a8393:150b6fae3a4:-6144', 'APPROVED', 'RETAILER OF CELLPHONE AND ACCESSORIES', 'RETAILER', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB-200a8393:150b6fae3a4:-6159', 'APPROVED', 'CATERING SERVICES', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB-200a8393:150b6fae3a4:-6196', 'APPROVED', 'BUY & SELL COAL', 'DEALERS', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB-200a8393:150b6fae3a4:-61bd', 'APPROVED', 'RETAILER OF BUY & SELL CHARCOAL', 'RETAILER', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB-24f934bb:15f2cf0cd91:-7965', 'APPROVED', 'ROOMS FOR RENT', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB-30aabaf2:175f29d52d4:-7bfa', 'APPROVED', 'METAL WORK SERVICES', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB-30d6c922:170cc8bafc5:-7544', 'APPROVED', 'RETAILER OF RICE & FEEDS', 'RETAILER', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB-32779d18:16f7d8ab2ec:-42be', 'APPROVED', 'DRUG TEST & MEDICAL SERVICES', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB-3293956a:1532a7423db:-27b1', 'APPROVED', 'RESTAURANT', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB-3296baf9:16bd4e38286:-7f7d', 'APPROVED', 'ONLINE TICKETING SERVICES', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB-383b7682:16835312df2:-77f1', 'APPROVED', 'SOUND SYSTEM RENTAL', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB-425f5df7:1525c661a0c:-7396', 'APPROVED', 'GLASS SERVICES', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB-513e70c5:17c342224a8:-7c70', 'APPROVED', 'MINI MART', 'WHOLESALERS', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB-517070ce:17ed7c45bf2:-7ca6', 'APPROVED', 'LPG ACCESSORIES', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB-556c46df:15234322fc4:-4655', 'APPROVED', 'RETAILER OF LPG', 'RETAILER', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB-65fc978f:168db28ce33:-78f6', 'APPROVED', 'RETAILER OF GARDEN & PLANTS', 'RETAILER', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB-6e25bea2:16df13d1aa6:-7c43', 'APPROVED', 'FASHION SHOP', 'WHOLESALERS', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB-b93436c:1550ea9c13f:-7a9b', 'APPROVED', 'PHOTOCOPIER SERVICES', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB-b93436c:1550ea9c13f:-7c06', 'APPROVED', 'RETAILER OF SCHOOL SUPPLIES', 'RETAILER', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB-ca566f8:150d57eace0:-7db1', 'APPROVED', 'RETAILER OF CEMENT', 'RETAILER', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB-ca566f8:150d57eace0:-7dcd', 'APPROVED', 'RETAILER OF AGRICULTURAL FARM SUPPLY', 'RETAILER', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB-ca566f8:150d57eace0:-7de5', 'APPROVED', 'REPAIR SHOP', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB-ca566f8:150d57eace0:-7dfa', 'APPROVED', 'PUBLIC UTILITY JEEP SERVICES', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB-ca566f8:150d57eace0:-7e18', 'APPROVED', 'PRINTING JOBS', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB-ca566f8:150d57eace0:-7e4a', 'APPROVED', 'POULTRY RAISING', 'DEALERS', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB-ca566f8:150d57eace0:-7e65', 'APPROVED', 'POOL', 'AMUSEMENT', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB-ca566f8:150d57eace0:-7f6e', 'APPROVED', 'PALAY BUYER', 'DEALERS', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB-d782645:179ee172373:-7455', 'APPROVED', 'MEDICAL CLINIC', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB14afef5f:155488ff5eb:-7f61', 'APPROVED', 'DEALER OF ASSORTED COMMODITIES', 'DEALERS', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB1606a7bc:150d61c40c6:-93e', 'APPROVED', 'WELDING SHOP', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB1606a7bc:150d61c40c6:-953', 'APPROVED', 'WEB SOLUTIONS & TUTORIALS', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB1606a7bc:150d61c40c6:-96d', 'APPROVED', 'WATER REFILLING STATION', 'DISTRIBUTOR', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB1606a7bc:150d61c40c6:-982', 'APPROVED', 'WAREHOUSE SERVICES', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB1606a7bc:150d61c40c6:-99c', 'APPROVED', 'VULCANIZING SHOP', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB1606a7bc:150d61c40c6:-9b4', 'APPROVED', 'VIDEOKE', 'AMUSEMENT', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB1606a7bc:150d61c40c6:-9cf', 'APPROVED', 'RETAILER OF VEGETABLE VENDOR', 'RETAILER', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB1606a7bc:150d61c40c6:-9e4', 'APPROVED', 'RETAILER OF VARIOUS KITCHEN UTENSILS', 'RETAILER', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB1606a7bc:150d61c40c6:-9f9', 'APPROVED', 'VAN SERVICES', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB1606a7bc:150d61c40c6:-a12', 'APPROVED', 'TUBA DEALER', 'DEALERS', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB1606a7bc:150d61c40c6:-a2c', 'APPROVED', 'RETAILER OF TOYS & POPCORN', 'RETAILER', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB1606a7bc:150d61c40c6:-a46', 'APPROVED', 'TIRE SUPPLY', 'DEALERS', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB1606a7bc:150d61c40c6:-a60', 'APPROVED', 'TICKETING OUTLET', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB1606a7bc:150d61c40c6:-a78', 'APPROVED', 'TAILORING SERVICES', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB1606a7bc:150d61c40c6:-ac4', 'APPROVED', 'SMALL SCALE LENDING', 'FINANCIAL_INSTITUTIONS', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB1606a7bc:150d61c40c6:-adc', 'APPROVED', 'SERVICE ESTABLISHMENT', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB1606a7bc:150d61c40c6:-af4', 'APPROVED', 'RETAILER OF SELLING OF RELIGIOUS ITEMS & TOYS', 'RETAILER', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB1606a7bc:150d61c40c6:-b0e', 'APPROVED', 'RETAILER OF SELLING OF RELIGIOUS ITEMS', 'RETAILER', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB1606a7bc:150d61c40c6:-b28', 'APPROVED', 'SECURITY AGENCY', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB1606a7bc:150d61c40c6:-b59', 'APPROVED', 'SCRAP BUYER', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB1606a7bc:150d61c40c6:-bab', 'APPROVED', 'RURAL BANK', 'FINANCIAL_INSTITUTIONS', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB1606a7bc:150d61c40c6:-bd9', 'APPROVED', 'RICE MILL SERVICES', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB1606a7bc:150d61c40c6:-bf0', 'APPROVED', 'RICE DEALER', 'DEALERS', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB1606a7bc:150d61c40c6:-c07', 'APPROVED', 'RETAILER OF RICE AND CORN', 'RETAILER', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB1606a7bc:150d61c40c6:-c22', 'APPROVED', 'RETAILER OF SALTED FISH', 'RETAILER', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB1606a7bc:150d61c40c6:-c3a', 'APPROVED', 'RETAILER OF GASOLINE', 'RETAILER', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB22dd10ec:17b5cf5f1bb:-7dc8', 'APPROVED', 'PROCESSOR OF MEAT PROCESSING', 'PROCESSOR', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB22e2845:15d9b2249f4:-7e27', 'APPROVED', 'RETAILER OF UKAY-UKAY', 'RETAILER', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB23937e55:161bb5fb19c:-7f8b', 'APPROVED', 'CAKES AND PASTRIES', 'MANUFACTURER', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB23937e55:161bb5fb19c:-7fd3', 'APPROVED', 'DENTAL CLINIC', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB28de5fbe:17d7d8d4a84:-40fb', 'APPROVED', 'BEACH RESORT', 'AMUSEMENT', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB2a20cb25:1772873e9b4:-7a47', 'APPROVED', 'TRAVELLER\'S INN', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB30542c65:15253ea1525:-7fc6', 'APPROVED', 'RETAILER OF DRESSED CHICKEN', 'RETAILER', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB3b5c6e9a:16bb56395c7:-7f8d', 'APPROVED', 'CONVENIENCE STORE', 'WHOLESALERS', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB3e96ca2f:15112ec9172:-56c2', 'APPROVED', 'RETAILER OF RICE', 'RETAILER', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB4ba3275e:15bf586f0b6:-7fbb', 'APPROVED', 'RESORT', 'AMUSEMENT', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB4d44daf7:15f7f37a11d:-6d1c', 'APPROVED', 'RETAILER OF FRUIT VENDOR', 'RETAILER', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB59019b0d:1601eda95ec:-79bd', 'APPROVED', 'RETAILER OF LIEMPO AND CHICKEN', 'RETAILER', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB5a582b94:15d07027f74:-7d2c', 'APPROVED', 'MONEY CHANGER', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB601f7a31:164d02a1c12:-7fbb', 'APPROVED', 'PENSION HOUSE', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB639ac11d:16b20312841:-7dcb', 'APPROVED', 'DRIVING LESSON', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-100e', 'APPROVED', 'PHYSICAL FITNESS PLACE', 'AMUSEMENT', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-102a', 'APPROVED', 'PHARMACY', 'DISTRIBUTOR', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-1b2d', 'APPROVED', 'PEDDLER', 'PEDDLER', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-1eb9', 'APPROVED', 'PAWNSHOP', 'FINANCIAL_INSTITUTIONS', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-1ed1', 'APPROVED', 'RETAILER OF OKAY-OKAY', 'RETAILER', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-1ee9', 'APPROVED', 'PROCESSOR OF NATA DE COCO', 'PROCESSOR', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-1f01', 'APPROVED', 'MOTOR PARTS', 'DEALERS', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-1f19', 'APPROVED', 'MICROFINANCING', 'FINANCIAL_INSTITUTIONS', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-1f31', 'APPROVED', 'PRINTSHOP SERVICES', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-1f49', 'APPROVED', 'RETAILER OF MEAT VENDOR', 'RETAILER', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-1f5e', 'APPROVED', 'MASSAGE / REFLEX', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-1f86', 'APPROVED', 'LUMBER SUPPLY', 'DEALERS', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-3650', 'APPROVED', 'LENDING INSTITUTIONS', 'FINANCIAL_INSTITUTIONS', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-3668', 'APPROVED', 'RETAILER OF LECHON MANOK', 'RETAILER', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-3684', 'APPROVED', 'RETAILER OF LECHON', 'RETAILER', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-36b1', 'APPROVED', 'KINDERGARTEN SCHOOL', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-36cf', 'APPROVED', 'JUNKSHOP', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-36ef', 'APPROVED', 'INTERNET CAFE', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-3726', 'APPROVED', 'RETAILER OF ICE CREAM PARLOR', 'RETAILER', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-3749', 'APPROVED', 'HOLLOW BLOCK MAKING', 'MANUFACTURER', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-3760', 'APPROVED', 'HERBAL MEDICINES', 'DEALERS', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-3778', 'APPROVED', 'HAULING SERVICES', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-3794', 'APPROVED', 'HARDWARE', 'WHOLESALERS', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-37b2', 'APPROVED', 'GENERAL MERCHANDISE', 'WHOLESALERS', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-37cf', 'APPROVED', 'GENERAL HOUSEKEEPING SERVICES', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-3890', 'APPROVED', 'GASOLINE STATION', 'DISTRIBUTOR', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-3945', 'APPROVED', 'FURNITURE MAKING', 'MANUFACTURER', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-3a07', 'APPROVED', 'FURNITURE/UPHOLSTERY REPAIR', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-3a3b', 'APPROVED', 'RETAILER OF FRIED CHICKEN', 'RETAILER', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-3a50', 'APPROVED', 'RETAILER OF FOOD VENDOR', 'RETAILER', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-3a68', 'APPROVED', 'FITNESS CENTER', 'AMUSEMENT', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-3a80', 'APPROVED', 'RETAILER OF FISH VENDOR', 'RETAILER', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-3aa7', 'APPROVED', 'RETAILER OF FEEDS', 'RETAILER', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-3b52', 'APPROVED', 'FINANCE AND INVESTMENT ', 'FINANCIAL_INSTITUTIONS', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-3b76', 'APPROVED', 'DISTRIBUTOR OF FARM PRODUCTS', 'DISTRIBUTOR', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-3b8e', 'APPROVED', 'DISTRIBUTOR OF ELECTRICAL PRODUCTS', 'DISTRIBUTOR', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-3ba3', 'APPROVED', 'EDUCATIONAL INSTITUTION', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-3bbf', 'APPROVED', 'EATERY', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-742f', 'APPROVED', 'RETAILER OF DRY GOODS', 'RETAILER', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-745d', 'APPROVED', 'RETAILER OF DRIED FISH VENDOR', 'RETAILER', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-7475', 'APPROVED', 'DRESS SHOP', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-749f', 'APPROVED', 'DISTRIBUTOR OF CEMENT', 'DISTRIBUTOR', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-74b7', 'APPROVED', 'DEALER OF SOFTDRINKS', 'DEALERS', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-74cc', 'APPROVED', 'DEALER OF FROZEN FOODS', 'DEALERS', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-74f9', 'APPROVED', 'COPRA BUYING', 'DEALERS', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-750e', 'APPROVED', 'COPIER SERVICES', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-752a', 'APPROVED', 'COOPERATIVE', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-7554', 'APPROVED', 'RETAILER OF CONSTRUCTION SUPPLY', 'RETAILER', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-756c', 'APPROVED', 'COMPUTER SERVICES', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-759a', 'APPROVED', 'COMPUTER GAMES', 'AMUSEMENT', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-fdc', 'APPROVED', 'RETAILER OF PLASTIC WARES', 'RETAILER', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB63ece70a:150c58eb6a5:-ff6', 'APPROVED', 'PIGGERY', 'DEALERS', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB690b69b6:176df6cc6b7:-471', 'APPROVED', 'REF-AIRCON AND ELECTRICAL SERVICES', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB70a2ad6b:150b17245f0:-1aad', 'APPROVED', 'COCKPIT ARENA', 'AMUSEMENT', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB70a2ad6b:150b17245f0:-624c', 'APPROVED', 'RETAILER OF SARI-SARI', 'RETAILER', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOB7e4a6308:176da2885cd:-4213', 'APPROVED', 'MOTORCYCLE SHOP', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOBd8b0606:15bc67a8f51:-706c', 'APPROVED', 'TOUR SERVICES', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOBdb44826:150b62146e5:-5939', 'APPROVED', 'MOTORELA', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOBdb44826:150b62146e5:-5962', 'APPROVED', 'BREAD MAKING', 'MANUFACTURER', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOBdb44826:150b62146e5:-597b', 'APPROVED', 'BOUTIQUE & GIFT SHOP', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOBdb44826:150b62146e5:-62b6', 'APPROVED', 'MAHJONG', 'AMUSEMENT', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOBdb44826:150b62146e5:-62d2', 'APPROVED', 'BILLIARD', 'AMUSEMENT', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOBdb44826:150b62146e5:-62f0', 'APPROVED', 'BEAUTY SALON', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOBdb44826:150b62146e5:-63b5', 'APPROVED', 'BARBER SHOP', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOBdb44826:150b62146e5:-6bb7', 'APPROVED', 'BAKERY', 'MANUFACTURER', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOBdb44826:150b62146e5:-6bcf', 'APPROVED', 'AUTO REPAIR SHOP', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOBdb44826:150b62146e5:-6be9', 'APPROVED', 'APARTMENT/HOUSE FOR RENT', 'SERVICES', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOBdb44826:150b62146e5:-6c10', 'APPROVED', 'RETAILER OF AGRIVET', 'RETAILER', NULL, NULL);
INSERT INTO `lob` (`objid`, `state`, `name`, `classification_objid`, `psic`, `psic_objid`) VALUES ('LOBdb44826:150b62146e5:-6c5e', 'APPROVED', 'AGRI BUSINESS', 'DEALERS', NULL, NULL);


INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('ALONG_MAINROAD', 'APPROVED', 'ALONG_MAINROAD', 'string_array', 'BUSINESS LOCATION', NULL, '[\"YES\",\"NO\"]', '0', '1', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('AREA_DOUBLE', 'DRAFT', 'AREA_DOUBLE', 'integer', '(DOUBLE) BILLBOARD AREA IN SQM ?', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('AREA_SINGLE', 'DRAFT', 'AREA_SINGLE', 'integer', '(SINGLE) BILLBOARD AREA IN SQM ?', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('AREA_SQM', 'DRAFT', 'AREA_SQM', 'decimal', 'BUSINESS AREA IN SQ METERS', NULL, '[]', '1', '0', 'BUSINESS AREA', NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('ASK_ALONG_MAINROAD', 'APPROVED', 'ASK_ALONG_MAINROAD', 'string_array', 'ALONG_MAINROAD', NULL, '[\"YES\",\"NO\"]', '0', '1', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('ASSET_SIZE', 'DRAFT', 'ASSET_SIZE', 'decimal', 'ASSET SIZE', 'ASSET SIZE', '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('BANK', 'APPROVED', 'BANK', 'string_array', 'BANK', NULL, '[\"MAIN\",\"BRANCH\"]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('BANK_BRANCH', 'DRAFT', 'BANK_BRANCH', 'integer', 'BANK BRANCH', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('BANK_MAIN', 'DRAFT', 'BANK_MAIN', 'integer', 'BANK MAIN', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('BUILDING_TYPE', 'DRAFT', 'BUILDING_TYPE', 'string_array', 'BUILDING TYPE', 'FOR USE IN LOCATIONAL CLEARANCE', '[\"RESIDENTIAL\",\"APARTMENT\",\"DORMITORY\",\"INSTITUTIONAL\",\"COMMERCIAL\",\"SPECIAL\"]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('BUSINESS_CHARACTERISTIC', 'DRAFT', 'BUSINESS_CHARACTERISTIC', 'string', 'BUSINESS CHARACTERISTIC', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('BUSINESS_CHARACTERISTIC_SUBCATEGORY', 'APPROVED', 'BUSINESS_CHARACTERISTIC_SUBCATEGORY', 'string', 'BUSINESS SUB-CATEGORY', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('BUSINESS_SIZE', 'APPROVED', 'BUSINESS_SIZE', 'string_array', 'BUSINESS SIZE ?', NULL, '[\"SMALL\",\"MEDIUM\",\"LARGE\",\"MICRO\"]', '0', '1', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('CAPITAL', 'DRAFT', 'CAPITAL', 'decimal', 'CAPITAL', NULL, '[]', '1', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('COST_OF_BUILDING', 'DRAFT', 'COST_OF_BUILDING', 'decimal', 'COST OF BUILDING', 'FOR USE IN LOCATIONAL CLEARANCE', '[]', '0', '1', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('DECLARED_CAPITAL', 'DRAFT', 'DECLARED_CAPITAL', 'decimal', 'DECLARED CAPITAL', NULL, '[]', '1', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('DECLARED_GROSS', 'DRAFT', 'DECLARED_GROSS', 'decimal', 'DECLARED GROSS', NULL, '[]', '1', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('FINANCIAL_SIZE', 'DRAFT', 'FINANCIAL_SIZE', 'string_array', 'FINANCIAL SIZE', NULL, '[\"PRINCIPAL\",\"BRANCH\",\"INDIVIDUAL - SMALL\",\"INDIVIDUAL - MEDIUM\",\"INDIVIDUAL - LARGE\"]', '0', '1', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('FOREIGN_LIQUORS', 'DRAFT', 'FOREIGN_LIQUORS', 'boolean', 'FOREIGN LIQUORS', 'FOREIGN LIQUORS', '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('GARBAGE_ESTABLISHMENT', 'DRAFT', 'GARBAGE_ESTABLISHMENT', 'string_array', 'GARBAGE ESTABLISHMENT', 'GARBAGE ESTABLISHMENT', '[\"LARGE - DAILY\",\"LARGE - SCHEDULE\",\"MEDIUM - DAILY\",\"MEDIUM - SCHEDULE\",\"SMALL - DAILY\",\"SMALL - SCHEDULE\",\"NONE\"]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('GARBAGE_FEE', 'DRAFT', 'GARBAGE_FEE', 'integer', 'GARBAGE FEE', 'GARBAGE FEE', '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('GARBAGE_INDUSTRIAL', 'DRAFT', 'GARBAGE_INDUSTRIAL', 'string_array', 'GARBAGE INDUSTRIAL', 'GARBAGE INDUSTRIAL', '[\"LARGE - DAILY\",\"LARGE - SCHEDULE\",\"MEDIUM - DAILY\",\"MEDIUM - SCHEDULE\",\"SMALL - DAILY\",\"SMALL - SCHEDULE\"]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('GARBAGE_INSTITUTIONS', 'DRAFT', 'GARBAGE_INSTITUTIONS', 'string_array', 'GARBAGE INSTITUTIONS', 'GARBAGE INSTITUTIONS', '[\"NONE\",\"LARGE - DAILY\",\"LARGE - SCHEDULE\",\"SMALL - DAILY\",\"SMALL - SCHEDULE\"]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('GARBAGE_RESTAURANT', 'DRAFT', 'GARBAGE_RESTAURANT', 'string_array', 'GARBAGE RESTAURANT', 'GARBAGE RESTAURANT', '[\"WITH IN PUBLIC MARKET\",\"LARGE - DAILY\",\"LARGE - SCHEDULE\",\"SMALL - DAILY\",\"SMALL - SCHEDULE\",\"MICRO - DAILY\",\"MICRO - SCHEDULE\"]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('GROSS', 'DRAFT', 'GROSS', 'decimal', 'GROSS', NULL, '[]', '1', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('HAS_BUSINESS_TAX_CERTIFICATE', 'DRAFT', 'HAS_BUSINESS_TAX_CERTIFICATE', 'string_array', 'HAS BUSINESS TAX CERTIFICATE?', NULL, '[\"YES\",\"NO\"]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('HAS_GARBAGE_FEE', 'DRAFT', 'HAS_GARBAGE_FEE', 'string_array', 'HAS GARBAGE FEE', 'HAS GARBAGE FEE', '[\"NONE\",\"EXEMPT\",\"LARGE - DAILY\",\"LARGE - SCHEDULE\",\"MEDIUM - DAILY\",\"MEDIUM - SCHEDULE\",\"SMALL - DAILY\",\"SMALL - SCHEDULE\"]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('HAS_GENERATOR', 'DRAFT', 'HAS_GENERATOR', 'string_array', 'HAS GENERATOR', 'HAS GENERATOR', '[\"YES\",\"NO\"]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('HAS_STATIONARY_ENGINE_MACHINE', 'DRAFT', 'HAS_STATIONARY_ENGINE_MACHINE', 'string_array', 'HAS STATIONARY ENGINE MACHINE', 'HAS STATIONARY ENGINE MACHINE', '[\"YES\",\"NO\"]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('HAS_TAX_INCENTIVE', 'DRAFT', 'HAS_TAX_INCENTIVE', 'boolean', 'HAS TAX INCENTIVE?', NULL, '[]', '1', '0', 'GENERAL', NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('LM_ONE_METER_OR_BELOW', 'DRAFT', 'LM_ONE_METER_OR_BELOW', 'integer', 'LINEAR METER (BELOW 1M)', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('LM_OVER_ONE_METER', 'DRAFT', 'LM_OVER_ONE_METER', 'integer', 'LINEAR METER (OVER 1M)', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('MOTORELA_TAX_QUARTER', 'DRAFT', 'MOTORELA_TAX_QUARTER', 'string_array', 'MOTORELA TAX', NULL, '[\"1ST QUARTER\",\"2ND QUARTER\",\"3RD QUARTER\",\"4TH QUARTER\"]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('NO_HAULING_VEHICLE', 'DRAFT', 'NO_HAULING_VEHICLE', 'integer', 'NO. OF HAULING VEHICLE?', NULL, '[]', '0', '1', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('NO_OF_ADDL_UNITS', 'DRAFT', 'NO_OF_ADDL_UNITS', 'integer', 'NO OF ADDITIONAL UNITS', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('NO_OF_AIRPLANE', 'DRAFT', 'NO_OF_AIRPLANE', 'integer', 'NO OF AIRPLANE', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('NO_OF_BACKHOE', 'DRAFT', 'NO_OF_BACKHOE', 'integer', 'NO OF BACKHOE', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('NO_OF_BET_MANAGER', 'DRAFT', 'NO_OF_BET_MANAGER', 'integer', 'NO OF BET MANAGER', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('NO_OF_BET_TAKER', 'DRAFT', 'NO_OF_BET_TAKER', 'integer', 'NO OF BET TAKER', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('NO_OF_BULDOZERS', 'DRAFT', 'NO_OF_BULDOZERS', 'integer', 'NO OF BULDOZERS', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('NO_OF_BUS', 'DRAFT', 'NO_OF_BUS', 'integer', 'NO OF BUS', 'NO OF BUS', '[]', '0', '500', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('NO_OF_CARGO_TRUCKS', 'DRAFT', 'NO_OF_CARGO_TRUCKS', 'integer', 'NO OF CARGO TRUCKS', 'NO OF CARGO TRUCKS', '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('NO_OF_CASHIER', 'DRAFT', 'NO_OF_CASHIER', 'integer', 'NO OF CASHIER', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('NO_OF_CRANE', 'DRAFT', 'NO_OF_CRANE', 'integer', 'NO OF CRANE', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('NO_OF_DELIVERY_VEHICLE', 'DRAFT', 'NO_OF_DELIVERY_VEHICLE', 'integer', 'NO OF DELIVERY VEHICLE', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('NO_OF_DUMPTRUCKS_10WHEELS', 'DRAFT', 'NO_OF_DUMPTRUCKS_10WHEELS', 'integer', 'NO OF DUMPTRUCKS (10WHEELS)', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('NO_OF_DUMPTRUCKS_6WHEELS', 'DRAFT', 'NO_OF_DUMPTRUCKS_6WHEELS', 'integer', 'NO OF DUMPTRUCKS (6WHEELS)', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('NO_OF_ENGINE_MACHINE_11HP_TO_14HP', 'DRAFT', 'NO_OF_ENGINE_MACHINE_11HP_TO_14HP', 'integer', 'NO OF ENGINE MACHINE (11HP TO 14HP)', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('NO_OF_ENGINE_MACHINE_15HP_ABOVE', 'DRAFT', 'NO_OF_ENGINE_MACHINE_15HP_ABOVE', 'integer', 'NO OF ENGINE MACHINE (15HP ABOVE)', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('NO_OF_ENGINE_MACHINE_2HP_BELOW', 'DRAFT', 'NO_OF_ENGINE_MACHINE_2HP_BELOW', 'integer', 'NO OF ENGINE MACHINE (2HP BELOW)', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('NO_OF_ENGINE_MACHINE_3HP_TO_5HP', 'DRAFT', 'NO_OF_ENGINE_MACHINE_3HP_TO_5HP', 'integer', 'NO OF ENGINE MACHINE (3HP TO 5HP)', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('NO_OF_ENGINE_MACHINE_6HP_TO_10HP', 'DRAFT', 'NO_OF_ENGINE_MACHINE_6HP_TO_10HP', 'integer', 'NO OF ENGINE MACHINE (6HP TO 10HP)', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('NO_OF_FARM_TRACTORS', 'DRAFT', 'NO_OF_FARM_TRACTORS', 'integer', 'NO OF FARM TRACTORS', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('NO_OF_FORKLIFT', 'DRAFT', 'NO_OF_FORKLIFT', 'integer', 'NO OF FORKLIFT', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('NO_OF_GAFFER', 'DRAFT', 'NO_OF_GAFFER', 'integer', 'NO OF GAFFER', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('NO_OF_HAULING_VEHICLE', 'DRAFT', 'NO_OF_HAULING_VEHICLE', 'integer', 'NO. OF HAULING VEHICLE ?', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('NO_OF_LITERS', 'DRAFT', 'NO_OF_LITERS', 'integer', 'NO OF LITERS', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('NO_OF_MECHANICAL_DRYER', 'DRAFT', 'NO_OF_MECHANICAL_DRYER', 'integer', 'NO OF MECHANICAL DRYER', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('NO_OF_MINI_BUS', 'DRAFT', 'NO_OF_MINI_BUS', 'integer', 'NO OF MINI BUS', 'NO OF MINI BUS', '[]', '0', '501', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('NO_OF_MIXER', 'DRAFT', 'NO_OF_MIXER', 'integer', 'NO OF MIXER', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('NO_OF_PACKING_PLANT', 'DRAFT', 'NO_OF_PACKING_PLANT', 'integer', 'NO OF PACKING PLANT', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('NO_OF_PAYLOADER', 'DRAFT', 'NO_OF_PAYLOADER', 'integer', 'NO OF PAYLOADER', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('NO_OF_PIT_MANAGER', 'DRAFT', 'NO_OF_PIT_MANAGER', 'integer', 'NO OF PIT MANAGER', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('NO_OF_PROMOTERS', 'DRAFT', 'NO_OF_PROMOTERS', 'integer', 'NO OF PROMOTERS', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('NO_OF_REFEREE', 'DRAFT', 'NO_OF_REFEREE', 'integer', 'NO OF REFEREE', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('NO_OF_TAMARAWS_JEEPNEY_FLERAS', 'DRAFT', 'NO_OF_TAMARAWS_JEEPNEY_FLERAS', 'integer', 'NO OF TAMARAWS JEEPNEY FLERAS', 'NO OF TAMARAWS JEEPNEY FLERAS', '[]', '0', '502', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('NO_OF_TAXI_VAN', 'DRAFT', 'NO_OF_TAXI_VAN', 'integer', 'NO OF TAXI VAN', 'NO OF TAXI VAN', '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('NO_OF_UNITS', 'DRAFT', 'NO_OF_UNITS', 'integer', 'NO OF UNITS', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('NO_OF_VAN_TRUCK_10WHEELS', 'DRAFT', 'NO_OF_VAN_TRUCK_10WHEELS', 'integer', 'NO OF VAN TRUCK (10WHEELS)', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('NO_OF_VAN_TRUCK_6WHEELS', 'DRAFT', 'NO_OF_VAN_TRUCK_6WHEELS', 'integer', 'NO OF VAN TRUCK (6WHEELS)', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('NO_OF_VIDEOKE', 'DRAFT', 'NO_OF_VIDEOKE', 'integer', 'NO OF VIDEOKE', 'NO OF VIDEOKE', '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('NO_TABLES', 'DRAFT', 'NO_TABLES', 'integer', 'NO. OF TABLES ?', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('NUMBER_EMPLOYEES', 'DRAFT', 'NUMBER_EMPLOYEES', 'integer', 'NUMBER OF EMPLOYEES ?', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('NUM_EMPLOYEE', 'DRAFT', 'NUM_EMPLOYEE', 'integer', 'NO. OF EMPLOYEES', NULL, '[]', '1', '0', 'EMPLOYEE INFO', NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('NUM_EMPLOYEE_FEMALE', 'DRAFT', 'NUM_EMPLOYEE_FEMALE', 'integer', 'NO. OF FEMALE EMPLOYEES', NULL, '[]', '1', '0', 'EMPLOYEE INFO', NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('NUM_EMPLOYEE_MALE', 'DRAFT', 'NUM_EMPLOYEE_MALE', 'integer', 'NO. OF MALE EMPLOYEES', NULL, '[]', '1', '0', 'EMPLOYEE INFO', NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('NUM_EMPLOYEE_RESIDENT', 'DRAFT', 'NUM_EMPLOYEE_RESIDENT', 'integer', 'NO. OF RESIDENT EMPLOYEES', NULL, '[]', '1', '0', 'EMPLOYEE RESIDING IN LGU', NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('NUM_TRESSER', 'DRAFT', 'NUM_TRESSER', 'integer', 'NUM TRESSER', 'NUM TRESSER', '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('OFFICE_TYPE', 'DRAFT', 'OFFICE_TYPE', 'string_array', 'OFFICE TYPE', NULL, '[\"MAIN\",\"BRANCH\"]', '1', '0', 'GENERAL', NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('PEDDLERS', 'DRAFT', 'PEDDLERS', 'string_array', 'PEDDLERS', NULL, '[\"PERSON\",\"VEHICLE\"]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('SANITARY_PERMIT', 'DRAFT', 'SANITARY_PERMIT', 'integer', 'SANITARY_PERMIT', 'SANITARY_PERMIT', '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('STORAGE_CAPACITY_DIESEL', 'DRAFT', 'STORAGE_CAPACITY_DIESEL', 'integer', 'STORAGE CAPACITY DIESEL', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('STORAGE_CAPACITY_KEROSINE', 'DRAFT', 'STORAGE_CAPACITY_KEROSINE', 'integer', 'STORAGE CAPACITY KEROSINE', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('STORAGE_CAPACITY_PREMIUM', 'DRAFT', 'STORAGE_CAPACITY_PREMIUM', 'integer', 'STORAGE CAPACITY PREMIUM', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('STORAGE_CAPACITY_REGULAR', 'DRAFT', 'STORAGE_CAPACITY_REGULAR', 'integer', 'STORAGE CAPACITY REGULAR', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('STORAGE_CAPACITY_UNLEADED', 'DRAFT', 'STORAGE_CAPACITY_UNLEADED', 'integer', 'STORAGE CAPACITY UNLEADED', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('TYPE_OF_INSTITUTION_?', 'DRAFT', 'TYPE_OF_INSTITUTION_?', 'string_array', 'TYPE OF INSTITUTION ?', 'TYPE OF INSTITUTION ?', '[\"LARGE \",\"SMALL\"]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('WITHIN_TOWNCENTER', 'DRAFT', 'WITHIN_TOWNCENTER', 'string_array', 'WITHIN TOWNCENTER?', 'WITHIN TOWN CENTER?', '[\"YES\",\"NO\"]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('WT_300KG_TO_BELOW_3000KG', 'DRAFT', 'WT_300KG_TO_BELOW_3000KG', 'integer', 'NO OF WEIGHTS (300KG- 3000KG BELOW)', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('WT_30KG_BELOW', 'DRAFT', 'WT_30KG_BELOW', 'integer', 'NO OF WEIGHTS (30KG BELOW)', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('WT_30KG_TO_BELOW_300KG', 'DRAFT', 'WT_30KG_TO_BELOW_300KG', 'integer', 'NO OF WEIGHTS (30KG- 300KG BELOW)', NULL, '[]', '0', '0', NULL, NULL);
INSERT INTO `businessvariable` (`objid`, `state`, `name`, `datatype`, `caption`, `description`, `arrayvalues`, `system`, `sortorder`, `category`, `handler`) VALUES ('WT_OVER_300KG', 'DRAFT', 'WT_OVER_300KG', 'integer', 'NO OF WEIGHTS (OVER 3000KG)', NULL, '[]', '0', '0', NULL, NULL);


CREATE TABLE `online_business_application_doc` (
  `objid` varchar(50) NOT NULL,
  `parentid` varchar(50) NOT NULL,
  `doc_type` varchar(50) NOT NULL,
  `doc_title` varchar(255) NOT NULL,
  `attachment_objid` varchar(50) NOT NULL,
  `attachment_name` varchar(255) NOT NULL,
  `attachment_path` varchar(255) NOT NULL,
  `fs_filetype` varchar(10) NOT NULL,
  `fs_filelocid` varchar(50) DEFAULT NULL,
  `fs_fileid` varchar(50) DEFAULT NULL,
  `lockid` varchar(50) DEFAULT NULL,
  `fs_state` varchar(20) NOT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_parentid` (`parentid`) USING BTREE,
  KEY `ix_attachment_objid` (`attachment_objid`) USING BTREE,
  KEY `ix_fs_filelocid` (`fs_filelocid`) USING BTREE,
  KEY `ix_fs_fileid` (`fs_fileid`) USING BTREE,
  KEY `ix_lockid` (`lockid`) USING BTREE,
  CONSTRAINT `online_business_application_doc_ibfk_1` FOREIGN KEY (`parentid`) REFERENCES `online_business_application` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

CREATE TABLE `online_business_application_doc_fordownload` (
  `objid` varchar(50) NOT NULL,
  `scheduledate` datetime NOT NULL,
  `msg` text,
  `filesize` int(11) NOT NULL DEFAULT '0',
  `bytesprocessed` int(11) NOT NULL DEFAULT '0',
  `lockid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_scheduledate` (`scheduledate`) USING BTREE,
  KEY `ix_lockid` (`lockid`) USING BTREE,
  CONSTRAINT `online_business_application_doc_fordownload_ibfk_1` FOREIGN KEY (`objid`) REFERENCES `online_business_application_doc` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;


set foreign_key_checks = 1
;