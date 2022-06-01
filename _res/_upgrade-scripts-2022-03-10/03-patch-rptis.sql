drop table if exists rpt_syncdata_fordownload;
drop table if exists rpt_syncdata_item;
drop table if exists rpt_syncdata_forsync;
drop table if exists rpt_syncdata_error;
drop table if exists rpt_syncdata_completed;
drop table if exists rpt_syncdata;

CREATE TABLE `rpt_syncdata` (
  `objid` varchar(50) NOT NULL,
  `state` varchar(25) NOT NULL,
  `refid` varchar(50) NOT NULL,
  `reftype` varchar(50) NOT NULL,
  `refno` varchar(50) NOT NULL,
  `action` varchar(50) NOT NULL,
  `dtfiled` datetime NOT NULL,
  `orgid` varchar(50) NOT NULL,
  `remote_orgid` varchar(50) DEFAULT NULL,
  `remote_orgcode` varchar(5) DEFAULT NULL,
  `remote_orgclass` varchar(25) DEFAULT NULL,
  `sender_objid` varchar(50) DEFAULT NULL,
  `sender_name` varchar(255) DEFAULT NULL,
  `sender_title` varchar(80) DEFAULT NULL,
  `info` text,
  PRIMARY KEY (`objid`),
  KEY `ix_state` (`state`),
  KEY `ix_refid` (`refid`),
  KEY `ix_refno` (`refno`),
  KEY `ix_orgid` (`orgid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

CREATE TABLE `rpt_syncdata_item` (
  `objid` varchar(50) NOT NULL,
  `parentid` varchar(50) NOT NULL,
  `state` varchar(25) NOT NULL,
  `refid` varchar(50) NOT NULL,
  `reftype` varchar(50) NOT NULL,
  `refno` varchar(50) NOT NULL,
  `action` varchar(50) NOT NULL,
  `idx` int(11) NOT NULL,
  `info` text,
  PRIMARY KEY (`objid`),
  KEY `ix_parentid` (`parentid`),
  KEY `ix_state` (`state`),
  KEY `ix_refid` (`refid`),
  KEY `ix_refno` (`refno`),
  CONSTRAINT `FK_parentid_rpt_syncdata` FOREIGN KEY (`parentid`) REFERENCES `rpt_syncdata` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

CREATE TABLE `rpt_syncdata_forsync` (
  `objid` varchar(50) NOT NULL,
  `reftype` varchar(50) NOT NULL,
  `refno` varchar(50) NOT NULL,
  `action` varchar(50) NOT NULL,
  `orgid` varchar(50) NOT NULL,
  `dtfiled` datetime NOT NULL,
  `createdby_objid` varchar(50) DEFAULT NULL,
  `createdby_name` varchar(255) DEFAULT NULL,
  `createdby_title` varchar(50) DEFAULT NULL,
  `remote_orgid` varchar(15) DEFAULT NULL,
  `state` varchar(25) DEFAULT NULL,
  `info` text,
  PRIMARY KEY (`objid`),
  KEY `ix_refno` (`refno`),
  KEY `ix_orgid` (`orgid`),
  KEY `ix_state` (`state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

CREATE TABLE `rpt_syncdata_error` (
  `objid` varchar(50) NOT NULL,
  `filekey` varchar(1000) NOT NULL,
  `error` text,
  `refid` varchar(50) NOT NULL,
  `reftype` varchar(50) NOT NULL,
  `refno` varchar(50) NOT NULL,
  `action` varchar(50) NOT NULL,
  `idx` int(11) NOT NULL,
  `info` text,
  `parent` text,
  `remote_orgid` varchar(50) DEFAULT NULL,
  `remote_orgcode` varchar(5) DEFAULT NULL,
  `remote_orgclass` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_refid` (`refid`),
  KEY `ix_refno` (`refno`),
  KEY `ix_filekey` (`filekey`(255)),
  KEY `ix_remote_orgid` (`remote_orgid`),
  KEY `ix_remote_orgcode` (`remote_orgcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

CREATE TABLE `rpt_syncdata_completed` (
  `objid` varchar(255) NOT NULL,
  `idx` int(255) DEFAULT NULL,
  `action` varchar(100) DEFAULT NULL,
  `refno` varchar(50) DEFAULT NULL,
  `refid` varchar(50) DEFAULT NULL,
  `reftype` varchar(50) DEFAULT NULL,
  `parent_orgid` varchar(50) DEFAULT NULL,
  `sender_name` varchar(255) DEFAULT NULL,
  `sender_title` varchar(255) DEFAULT NULL,
  `dtcreated` datetime DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_refno` (`refno`),
  KEY `ix_refid` (`refid`),
  KEY `ix_parent_orgid` (`parent_orgid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

CREATE TABLE `rpt_syncdata_fordownload` (
  `objid` varchar(255) NOT NULL,
  `etag` varchar(64) NOT NULL,
  `error` int(255) NOT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_error` (`error`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

alter table rptcompromise_item add qtr int
;

alter table rpu add stewardparentrpumasterid varchar(50)
;

drop view if exists vw_batchgr
;

create view `vw_batchgr` as 
select `bg`.`objid` as `objid`,`bg`.`state` as `state`,`bg`.`ry` as `ry`,`bg`.`lgu_objid` as `lgu_objid`,`bg`.`barangay_objid` as `barangay_objid`,`bg`.`rputype` as `rputype`,`bg`.`classification_objid` as `classification_objid`,`bg`.`section` as `section`,`bg`.`memoranda` as `memoranda`,`bg`.`txntype_objid` as `txntype_objid`,`bg`.`txnno` as `txnno`,`bg`.`txndate` as `txndate`,`bg`.`effectivityyear` as `effectivityyear`,`bg`.`effectivityqtr` as `effectivityqtr`,`bg`.`originlgu_objid` as `originlgu_objid`,`l`.`name` as `lgu_name`,`b`.`name` as `barangay_name`,`b`.`pin` as `barangay_pin`,`pc`.`name` as `classification_name`,`t`.`objid` as `taskid`,`t`.`state` as `taskstate`,`t`.`assignee_objid` as `assignee_objid` from ((((`batchgr` `bg` join `sys_org` `l` on((`bg`.`lgu_objid` = `l`.`objid`))) left join `barangay` `b` on((`bg`.`barangay_objid` = `b`.`objid`))) left join `propertyclassification` `pc` on((`bg`.`classification_objid` = `pc`.`objid`))) left join `batchgr_task` `t` on(((`bg`.`objid` = `t`.`refid`) and isnull(`t`.`enddate`))))
;

drop view if exists vw_landtax_report_rptdelinquency_detail
;
drop view if exists vw_landtax_report_rptdelinquency
;

CREATE VIEW `vw_landtax_report_rptdelinquency_detail` AS select `ri`.`objid` AS `objid`,`ri`.`rptledgerid` AS `rptledgerid`,`ri`.`barangayid` AS `barangayid`,`ri`.`year` AS `year`,`ri`.`qtr` AS `qtr`,`r`.`dtgenerated` AS `dtgenerated`,`r`.`dtcomputed` AS `dtcomputed`,`r`.`generatedby_name` AS `generatedby_name`,`r`.`generatedby_title` AS `generatedby_title`,(case when (`ri`.`revtype` = 'basic') then `ri`.`amount` else 0 end) AS `basic`,(case when (`ri`.`revtype` = 'basic') then `ri`.`interest` else 0 end) AS `basicint`,(case when (`ri`.`revtype` = 'basic') then `ri`.`discount` else 0 end) AS `basicdisc`,(case when (`ri`.`revtype` = 'basic') then (`ri`.`interest` - `ri`.`discount`) else 0 end) AS `basicdp`,(case when (`ri`.`revtype` = 'basic') then ((`ri`.`amount` + `ri`.`interest`) - `ri`.`discount`) else 0 end) AS `basicnet`,(case when (`ri`.`revtype` = 'basicidle') then `ri`.`amount` else 0 end) AS `basicidle`,(case when (`ri`.`revtype` = 'basicidle') then `ri`.`interest` else 0 end) AS `basicidleint`,(case when (`ri`.`revtype` = 'basicidle') then `ri`.`discount` else 0 end) AS `basicidledisc`,(case when (`ri`.`revtype` = 'basicidle') then (`ri`.`interest` - `ri`.`discount`) else 0 end) AS `basicidledp`,(case when (`ri`.`revtype` = 'basicidle') then ((`ri`.`amount` + `ri`.`interest`) - `ri`.`discount`) else 0 end) AS `basicidlenet`,(case when (`ri`.`revtype` = 'sef') then `ri`.`amount` else 0 end) AS `sef`,(case when (`ri`.`revtype` = 'sef') then `ri`.`interest` else 0 end) AS `sefint`,(case when (`ri`.`revtype` = 'sef') then `ri`.`discount` else 0 end) AS `sefdisc`,(case when (`ri`.`revtype` = 'sef') then (`ri`.`interest` - `ri`.`discount`) else 0 end) AS `sefdp`,(case when (`ri`.`revtype` = 'sef') then ((`ri`.`amount` + `ri`.`interest`) - `ri`.`discount`) else 0 end) AS `sefnet`,(case when (`ri`.`revtype` = 'firecode') then `ri`.`amount` else 0 end) AS `firecode`,(case when (`ri`.`revtype` = 'firecode') then `ri`.`interest` else 0 end) AS `firecodeint`,(case when (`ri`.`revtype` = 'firecode') then `ri`.`discount` else 0 end) AS `firecodedisc`,(case when (`ri`.`revtype` = 'firecode') then (`ri`.`interest` - `ri`.`discount`) else 0 end) AS `firecodedp`,(case when (`ri`.`revtype` = 'firecode') then ((`ri`.`amount` + `ri`.`interest`) - `ri`.`discount`) else 0 end) AS `firecodenet`,(case when (`ri`.`revtype` = 'sh') then `ri`.`amount` else 0 end) AS `sh`,(case when (`ri`.`revtype` = 'sh') then `ri`.`interest` else 0 end) AS `shint`,(case when (`ri`.`revtype` = 'sh') then `ri`.`discount` else 0 end) AS `shdisc`,(case when (`ri`.`revtype` = 'sh') then (`ri`.`interest` - `ri`.`discount`) else 0 end) AS `shdp`,(case when (`ri`.`revtype` = 'sh') then ((`ri`.`amount` + `ri`.`interest`) - `ri`.`discount`) else 0 end) AS `shnet`,((`ri`.`amount` + `ri`.`interest`) - `ri`.`discount`) AS `total` from (`report_rptdelinquency_item` `ri` join `report_rptdelinquency` `r` on((`ri`.`parentid` = `r`.`objid`)))
;

CREATE VIEW `vw_landtax_report_rptdelinquency` AS select `ri`.`objid` AS `objid`,`ri`.`rptledgerid` AS `rptledgerid`,`ri`.`barangayid` AS `barangayid`,`ri`.`year` AS `year`,`ri`.`qtr` AS `qtr`,`r`.`dtgenerated` AS `dtgenerated`,`r`.`dtcomputed` AS `dtcomputed`,`r`.`generatedby_name` AS `generatedby_name`,`r`.`generatedby_title` AS `generatedby_title`,(case when (`ri`.`revtype` = 'basic') then `ri`.`amount` else 0 end) AS `basic`,(case when (`ri`.`revtype` = 'basic') then `ri`.`interest` else 0 end) AS `basicint`,(case when (`ri`.`revtype` = 'basic') then `ri`.`discount` else 0 end) AS `basicdisc`,(case when (`ri`.`revtype` = 'basic') then (`ri`.`interest` - `ri`.`discount`) else 0 end) AS `basicdp`,(case when (`ri`.`revtype` = 'basic') then ((`ri`.`amount` + `ri`.`interest`) - `ri`.`discount`) else 0 end) AS `basicnet`,(case when (`ri`.`revtype` = 'basicidle') then `ri`.`amount` else 0 end) AS `basicidle`,(case when (`ri`.`revtype` = 'basicidle') then `ri`.`interest` else 0 end) AS `basicidleint`,(case when (`ri`.`revtype` = 'basicidle') then `ri`.`discount` else 0 end) AS `basicidledisc`,(case when (`ri`.`revtype` = 'basicidle') then (`ri`.`interest` - `ri`.`discount`) else 0 end) AS `basicidledp`,(case when (`ri`.`revtype` = 'basicidle') then ((`ri`.`amount` + `ri`.`interest`) - `ri`.`discount`) else 0 end) AS `basicidlenet`,(case when (`ri`.`revtype` = 'sef') then `ri`.`amount` else 0 end) AS `sef`,(case when (`ri`.`revtype` = 'sef') then `ri`.`interest` else 0 end) AS `sefint`,(case when (`ri`.`revtype` = 'sef') then `ri`.`discount` else 0 end) AS `sefdisc`,(case when (`ri`.`revtype` = 'sef') then (`ri`.`interest` - `ri`.`discount`) else 0 end) AS `sefdp`,(case when (`ri`.`revtype` = 'sef') then ((`ri`.`amount` + `ri`.`interest`) - `ri`.`discount`) else 0 end) AS `sefnet`,(case when (`ri`.`revtype` = 'firecode') then `ri`.`amount` else 0 end) AS `firecode`,(case when (`ri`.`revtype` = 'firecode') then `ri`.`interest` else 0 end) AS `firecodeint`,(case when (`ri`.`revtype` = 'firecode') then `ri`.`discount` else 0 end) AS `firecodedisc`,(case when (`ri`.`revtype` = 'firecode') then (`ri`.`interest` - `ri`.`discount`) else 0 end) AS `firecodedp`,(case when (`ri`.`revtype` = 'firecode') then ((`ri`.`amount` + `ri`.`interest`) - `ri`.`discount`) else 0 end) AS `firecodenet`,(case when (`ri`.`revtype` = 'sh') then `ri`.`amount` else 0 end) AS `sh`,(case when (`ri`.`revtype` = 'sh') then `ri`.`interest` else 0 end) AS `shint`,(case when (`ri`.`revtype` = 'sh') then `ri`.`discount` else 0 end) AS `shdisc`,(case when (`ri`.`revtype` = 'sh') then (`ri`.`interest` - `ri`.`discount`) else 0 end) AS `shdp`,(case when (`ri`.`revtype` = 'sh') then ((`ri`.`amount` + `ri`.`interest`) - `ri`.`discount`) else 0 end) AS `shnet`,((`ri`.`amount` + `ri`.`interest`) - `ri`.`discount`) AS `total` from (`report_rptdelinquency_item` `ri` join `report_rptdelinquency` `r` on((`ri`.`parentid` = `r`.`objid`)))
;

drop table if exists vw_rptpayment_item_detail
;

drop view if exists vw_rptpayment_item_detail
;


CREATE VIEW `vw_rptpayment_item_detail` AS select `rpi`.`objid` AS `objid`,`rpi`.`parentid` AS `parentid`,`rpi`.`rptledgerfaasid` AS `rptledgerfaasid`,`rpi`.`year` AS `year`,`rpi`.`qtr` AS `qtr`,`rpi`.`revperiod` AS `revperiod`,(case when (`rpi`.`revtype` = 'basic') then `rpi`.`amount` else 0 end) AS `basic`,(case when (`rpi`.`revtype` = 'basic') then `rpi`.`interest` else 0 end) AS `basicint`,(case when (`rpi`.`revtype` = 'basic') then `rpi`.`discount` else 0 end) AS `basicdisc`,(case when (`rpi`.`revtype` = 'basic') then (`rpi`.`interest` - `rpi`.`discount`) else 0 end) AS `basicdp`,(case when (`rpi`.`revtype` = 'basic') then ((`rpi`.`amount` + `rpi`.`interest`) - `rpi`.`discount`) else 0 end) AS `basicnet`,(case when (`rpi`.`revtype` = 'basicidle') then ((`rpi`.`amount` + `rpi`.`interest`) - `rpi`.`discount`) else 0 end) AS `basicidle`,(case when (`rpi`.`revtype` = 'basicidle') then `rpi`.`interest` else 0 end) AS `basicidleint`,(case when (`rpi`.`revtype` = 'basicidle') then `rpi`.`discount` else 0 end) AS `basicidledisc`,(case when (`rpi`.`revtype` = 'basicidle') then (`rpi`.`interest` - `rpi`.`discount`) else 0 end) AS `basicidledp`,(case when (`rpi`.`revtype` = 'sef') then `rpi`.`amount` else 0 end) AS `sef`,(case when (`rpi`.`revtype` = 'sef') then `rpi`.`interest` else 0 end) AS `sefint`,(case when (`rpi`.`revtype` = 'sef') then `rpi`.`discount` else 0 end) AS `sefdisc`,(case when (`rpi`.`revtype` = 'sef') then (`rpi`.`interest` - `rpi`.`discount`) else 0 end) AS `sefdp`,(case when (`rpi`.`revtype` = 'sef') then ((`rpi`.`amount` + `rpi`.`interest`) - `rpi`.`discount`) else 0 end) AS `sefnet`,(case when (`rpi`.`revtype` = 'firecode') then ((`rpi`.`amount` + `rpi`.`interest`) - `rpi`.`discount`) else 0 end) AS `firecode`,(case when (`rpi`.`revtype` = 'sh') then `rpi`.`amount` else 0 end) AS `sh`,(case when (`rpi`.`revtype` = 'sh') then `rpi`.`interest` else 0 end) AS `shint`,(case when (`rpi`.`revtype` = 'sh') then `rpi`.`discount` else 0 end) AS `shdisc`,(case when (`rpi`.`revtype` = 'sh') then (`rpi`.`interest` - `rpi`.`discount`) else 0 end) AS `shdp`,(case when (`rpi`.`revtype` = 'sh') then ((`rpi`.`amount` + `rpi`.`interest`) - `rpi`.`discount`) else 0 end) AS `shnet`,((`rpi`.`amount` + `rpi`.`interest`) - `rpi`.`discount`) AS `amount`,`rpi`.`partialled` AS `partialled` from `rptpayment_item` `rpi`
;


DROP VIEW IF EXISTS `vw_rptpayment_item` 
;

CREATE VIEW `vw_rptpayment_item` AS select `x`.`parentid` AS `parentid`,`x`.`rptledgerfaasid` AS `rptledgerfaasid`,`x`.`year` AS `year`,`x`.`qtr` AS `qtr`,`x`.`revperiod` AS `revperiod`,sum(`x`.`basic`) AS `basic`,sum(`x`.`basicint`) AS `basicint`,sum(`x`.`basicdisc`) AS `basicdisc`,sum(`x`.`basicdp`) AS `basicdp`,sum(`x`.`basicnet`) AS `basicnet`,sum(`x`.`basicidle`) AS `basicidle`,sum(`x`.`basicidleint`) AS `basicidleint`,sum(`x`.`basicidledisc`) AS `basicidledisc`,sum(`x`.`basicidledp`) AS `basicidledp`,sum(`x`.`sef`) AS `sef`,sum(`x`.`sefint`) AS `sefint`,sum(`x`.`sefdisc`) AS `sefdisc`,sum(`x`.`sefdp`) AS `sefdp`,sum(`x`.`sefnet`) AS `sefnet`,sum(`x`.`firecode`) AS `firecode`,sum(`x`.`sh`) AS `sh`,sum(`x`.`shint`) AS `shint`,sum(`x`.`shdisc`) AS `shdisc`,sum(`x`.`shdp`) AS `shdp`,sum(`x`.`amount`) AS `amount`,max(`x`.`partialled`) AS `partialled` from `vw_rptpayment_item_detail` `x` group by `x`.`parentid`,`x`.`rptledgerfaasid`,`x`.`year`,`x`.`qtr`,`x`.`revperiod`
;

DROP VIEW IF EXISTS `vw_newly_assessed_property`
;
DROP TABLE IF EXISTS `vw_newly_assessed_property`
;
CREATE VIEW `vw_newly_assessed_property` AS select `f`.`objid` AS `objid`,`f`.`owner_name` AS `owner_name`,`f`.`tdno` AS `tdno`,`b`.`name` AS `barangay`,(case when (`f`.`rputype` = 'land') then 'LAND' when (`f`.`rputype` = 'bldg') then 'BUILDING' when (`f`.`rputype` = 'mach') then 'MACHINERY' when (`f`.`rputype` = 'planttree') then 'PLANT/TREE' else 'MISCELLANEOUS' end) AS `rputype`,`f`.`totalav` AS `totalav`,`f`.`effectivityyear` AS `effectivityyear` from (`faas_list` `f` join `barangay` `b` on((`f`.`barangayid` = `b`.`objid`))) where ((`f`.`state` in ('CURRENT','CANCELLED')) and (`f`.`txntype_objid` = 'ND'))
;


DROP VIEW IF EXISTS `vw_real_property_payment`
;
DROP TABLE IF EXISTS `vw_real_property_payment`
;
CREATE VIEW `vw_real_property_payment` AS select `cv`.`controldate` AS `cv_controldate`,`rem`.`controldate` AS `rem_controldate`,`rl`.`owner_name` AS `owner_name`,`rl`.`tdno` AS `tdno`,`pc`.`name` AS `classification`,(case when (`rl`.`rputype` = 'land') then 'LAND' when (`rl`.`rputype` = 'bldg') then 'BUILDING' when (`rl`.`rputype` = 'mach') then 'MACHINERY' when (`rl`.`rputype` = 'planttree') then 'PLANT/TREE' else 'MISCELLANEOUS' end) AS `rputype`,`b`.`name` AS `barangay`,((`rpi`.`amount` + `rpi`.`interest`) - `rpi`.`discount`) AS `amount`,(case when isnull(`v`.`objid`) then 0 else 1 end) AS `voided` from ((((((((`collectionvoucher` `cv` join `remittance` `rem` on((`cv`.`objid` = `rem`.`collectionvoucherid`))) join `cashreceipt` `cr` on((`rem`.`objid` = `cr`.`remittanceid`))) join `rptpayment` `rp` on((`cr`.`objid` = `rp`.`receiptid`))) join `rptpayment_item` `rpi` on((`rp`.`objid` = `rpi`.`parentid`))) join `rptledger` `rl` on((`rp`.`refid` = `rl`.`objid`))) join `barangay` `b` on((`rl`.`barangayid` = `b`.`objid`))) join `propertyclassification` `pc` on((`rl`.`classification_objid` = `pc`.`objid`))) left join `cashreceipt_void` `v` on((`cr`.`objid` = `v`.`receiptid`)))
;

DROP VIEW IF EXISTS `vw_newly_assessed_property`
;
DROP TABLE IF EXISTS `vw_newly_assessed_property`
;
CREATE VIEW `vw_newly_assessed_property` AS select `f`.`objid` AS `objid`,`f`.`owner_name` AS `owner_name`,`f`.`tdno` AS `tdno`,`b`.`name` AS `barangay`,(case when (`f`.`rputype` = 'land') then 'LAND' when (`f`.`rputype` = 'bldg') then 'BUILDING' when (`f`.`rputype` = 'mach') then 'MACHINERY' when (`f`.`rputype` = 'planttree') then 'PLANT/TREE' else 'MISCELLANEOUS' end) AS `rputype`,`f`.`totalav` AS `totalav`,`f`.`effectivityyear` AS `effectivityyear` from (`faas_list` `f` join `barangay` `b` on((`f`.`barangayid` = `b`.`objid`))) where ((`f`.`state` in ('CURRENT','CANCELLED')) and (`f`.`txntype_objid` = 'ND'))
;



