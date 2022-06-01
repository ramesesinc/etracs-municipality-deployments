drop view if exists vw_report_orc
;


create view vw_report_orc as 
select 
	f.objid,
	f.state,
	e.objid as taxpayerid,
	e.name as taxpayer_name,
	e.address_text as taxpayer_address,
  	o.name as lgu_name,
	o.code as lgu_indexno,
	f.dtapproved,
	r.rputype,
	pc.code as classcode,
	pc.name as classification,
	f.fullpin as pin,
	f.titleno,
	rp.cadastrallotno,
	f.tdno,
	'' as arpno,
	f.prevowner,
	b.name as location,
	r.totalareaha,
	r.totalareasqm,
	r.totalmv, 
	r.totalav,
	case when f.state = 'CURRENT' then '' else 'CANCELLED' end as remarks
from faas f
inner join rpu r on f.rpuid = r.objid 
inner join realproperty rp on f.realpropertyid = rp.objid 
inner join propertyclassification pc on r.classification_objid = pc.objid 
inner join entity e on f.taxpayer_objid = e.objid 
inner join sys_org o on rp.lguid = o.objid 
inner join barangay b on rp.barangayid = b.objid 
where f.state in ('CURRENT', 'CANCELLED')
;



create index ix_year on rptpayment_item (year)
;
create index ix_revperiod on rptpayment_item (revperiod)
;
create index ix_revtype on rptpayment_item (revtype)
;


create index ix_year on rptpayment_share (year)
;
create index ix_revperiod on rptpayment_share (revperiod)
;
create index ix_revtype on rptpayment_share (revtype)
;



update sys_sequence set objid = CONCAT('TDNO-', objid ) where objid REGEXP('^[0-9][0-9]') = 1
;

CREATE TABLE `faas_requested_series` (
  `objid` varchar(50) NOT NULL,
  `parentid` varchar(50) NOT NULL,
  `series` varchar(255) NOT NULL,
  `requestedby_name` varchar(255) NOT NULL,
  `requestedby_date` date NOT NULL,
  `createdby_name` varchar(255) NOT NULL,
  `createdby_date` datetime NOT NULL,
  PRIMARY KEY (`objid`),
  KEY `fk_faas_requested_series_sys_sequence` (`parentid`),
  CONSTRAINT `fk_faas_requested_series_sys_sequence` FOREIGN KEY (`parentid`) REFERENCES `sys_sequence` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;


drop table if exists rpt_syncdata_item_completed;
drop table if exists rpt_syncdata_completed;
drop table if exists rpt_syncdata_forsync;
drop table if exists rpt_syncdata_fordownload;
drop table if exists rpt_syncdata_error;
drop table if exists rpt_syncdata_item;
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
  KEY `ix_state` (`state`) USING BTREE,
  KEY `ix_refid` (`refid`) USING BTREE,
  KEY `ix_refno` (`refno`) USING BTREE,
  KEY `ix_orgid` (`orgid`) USING BTREE
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
  `error` text,
  `filekey` varchar(1200) DEFAULT NULL,
  `etag` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_parentid` (`parentid`) USING BTREE,
  KEY `ix_state` (`state`) USING BTREE,
  KEY `ix_refid` (`refid`) USING BTREE,
  KEY `ix_refno` (`refno`) USING BTREE,
  CONSTRAINT `rpt_syncdata_item_ibfk_1` FOREIGN KEY (`parentid`) REFERENCES `rpt_syncdata` (`objid`)
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
  KEY `ix_refno` (`refno`) USING BTREE,
  KEY `ix_orgid` (`orgid`) USING BTREE,
  KEY `ix_state` (`state`) USING BTREE
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
  `state` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_refid` (`refid`) USING BTREE,
  KEY `ix_refno` (`refno`) USING BTREE,
  KEY `ix_filekey` (`filekey`(255)) USING BTREE,
  KEY `ix_remote_orgid` (`remote_orgid`) USING BTREE,
  KEY `ix_remote_orgcode` (`remote_orgcode`) USING BTREE,
  KEY `ix_state` (`state`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

CREATE TABLE `rpt_syncdata_completed` (
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
  KEY `ix_state` (`state`) USING BTREE,
  KEY `ix_refid` (`refid`) USING BTREE,
  KEY `ix_refno` (`refno`) USING BTREE,
  KEY `ix_orgid` (`orgid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

CREATE TABLE `rpt_syncdata_item_completed` (
  `objid` varchar(255) NOT NULL,
  `parentid` varchar(50) NOT NULL,
  `state` varchar(50) DEFAULT NULL,
  `refid` varchar(50) DEFAULT NULL,
  `reftype` varchar(50) DEFAULT NULL,
  `refno` varchar(50) DEFAULT NULL,
  `action` varchar(100) DEFAULT NULL,
  `idx` int(255) DEFAULT NULL,
  `info` text,
  `error` text,
  PRIMARY KEY (`objid`),
  KEY `ix_refno` (`refno`) USING BTREE,
  KEY `ix_refid` (`refid`) USING BTREE,
  KEY `ix_remote_orgid` (`parentid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

drop TABLE if exists `cashreceipt_rpt_share_forposting_repost`
;

CREATE TABLE `cashreceipt_rpt_share_forposting_repost` (
  `objid` varchar(100) NOT NULL,
  `rptpaymentid` varchar(50) NOT NULL,
  `receiptid` varchar(50) NOT NULL,
  `receiptdate` date NOT NULL,
  `rptledgerid` varchar(50) NOT NULL,
  `error` int(11) DEFAULT NULL,
  `msg` text,
  PRIMARY KEY (`objid`),
  UNIQUE KEY `ux_receiptid_rptledgerid` (`receiptid`,`rptledgerid`) USING BTREE,
  KEY `fk_rptshare_repost_rptledgerid` (`rptledgerid`) USING BTREE,
  KEY `fk_rptshare_repost_cashreceiptid` (`receiptid`) USING BTREE,
  CONSTRAINT `cashreceipt_rpt_share_forposting_repost_ibfk_1` FOREIGN KEY (`receiptid`) REFERENCES `cashreceipt` (`objid`),
  CONSTRAINT `cashreceipt_rpt_share_forposting_repost_ibfk_2` FOREIGN KEY (`rptledgerid`) REFERENCES `rptledger` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

drop TABLE if exists `rpt_syncdata_completed` 
;

CREATE TABLE `rpt_syncdata_completed` (
  `objid` varchar(50) NOT NULL,
  `idx` int,
  `action` varchar(50) ,
  `refid` varchar(50) ,
  `reftype` varchar(50) ,
  `refno` varchar(50) ,
  `parent_orgid` varchar(50) ,
  `sender_name` varchar(255) DEFAULT NULL,
  `sender_title` varchar(80) DEFAULT NULL,
  `dtcreated` datetime,
  `info` text,
  PRIMARY KEY (`objid`),
  KEY `ix_refid` (`refid`) USING BTREE,
  KEY `ix_refno` (`refno`) USING BTREE,
  KEY `ix_parent_orgid` (`parent_orgid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;


alter table cashreceipt_rpt_share_forposting_repost add receipttype varchar(10)
;

alter table cashreceipt_rpt_share_forposting_repost drop foreign key cashreceipt_rpt_share_forposting_repost_ibfk_1
;


/* MACHUSE: TAXABLE SUPPORT  */

alter table machuse add taxable int
;
update machuse set taxable = 1 where taxable is null
;
create unique index ux_actualuseid_taxable on machuse(machrpuid, actualuse_objid, taxable)
;


/* SYNCDATA: pre-download file */

drop table if exists rpt_syncdata_item_completed;
drop table if exists rpt_syncdata_completed;
drop table if exists rpt_syncdata_item;
drop table if exists rpt_syncdata;
drop table if exists rpt_syncdata_forsync;
drop table if exists rpt_syncdata_fordownload;

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
  KEY `ix_refno` (`refno`) USING BTREE,
  KEY `ix_orgid` (`orgid`) USING BTREE,
  KEY `ix_state` (`state`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

CREATE TABLE `rpt_syncdata_fordownload` (
  `objid` varchar(255) NOT NULL,
  `etag` varchar(64) NOT NULL,
  `error` int(255) NOT NULL,
  `state` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_error` (`error`) USING BTREE,
  KEY `ix_state` (`state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

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
  KEY `ix_state` (`state`) USING BTREE,
  KEY `ix_refid` (`refid`) USING BTREE,
  KEY `ix_refno` (`refno`) USING BTREE,
  KEY `ix_orgid` (`orgid`) USING BTREE
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
  `error` text,
  `filekey` varchar(1200) DEFAULT NULL,
  `etag` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_parentid` (`parentid`) USING BTREE,
  KEY `ix_state` (`state`) USING BTREE,
  KEY `ix_refid` (`refid`) USING BTREE,
  KEY `ix_refno` (`refno`) USING BTREE,
  CONSTRAINT `rpt_syncdata_item_ibfk_1` FOREIGN KEY (`parentid`) REFERENCES `rpt_syncdata` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

CREATE TABLE `rpt_syncdata_completed` (
  `objid` varchar(50) NOT NULL,
  `action` varchar(50) NOT NULL,
  `refid` varchar(50) NOT NULL,
  `reftype` varchar(50) NOT NULL,
  `refno` varchar(50) NOT NULL,
  `sender_name` varchar(255) DEFAULT NULL,
  `sender_title` varchar(80) DEFAULT NULL,
  `dtcreated` datetime DEFAULT NULL,
  `info` text,
  `dtfiled` datetime DEFAULT NULL,
  `orgid` varchar(50) DEFAULT NULL,
  `sender_objid` varchar(50) DEFAULT NULL,
  `remote_orgid` varchar(50) DEFAULT NULL,
  `remote_orgcode` varchar(25) DEFAULT NULL,
  `remote_orgclass` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_refid` (`refid`) USING BTREE,
  KEY `ix_refno` (`refno`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

CREATE TABLE `rpt_syncdata_item_completed` (
  `objid` varchar(255) NOT NULL,
  `parentid` varchar(50) NOT NULL,
  `refid` varchar(50) DEFAULT NULL,
  `reftype` varchar(50) DEFAULT NULL,
  `refno` varchar(50) DEFAULT NULL,
  `action` varchar(100) DEFAULT NULL,
  `idx` int(255) DEFAULT NULL,
  `info` text,
  PRIMARY KEY (`objid`),
  KEY `ix_refno` (`refno`) USING BTREE,
  KEY `ix_refid` (`refid`) USING BTREE,
  KEY `ix_remote_orgid` (`parentid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;




/* RPT CERTIFICATION WORKFLOW */
delete from sys_wf_node where processname = 'rptcertification';
delete from sys_wf_transition where processname = 'rptcertificastion';

INSERT INTO `sys_wf_node` (`name`, `processname`, `title`, `nodetype`, `idx`, `salience`, `domain`, `role`, `properties`, `ui`, `tracktime`) VALUES ('start', 'rptcertification', 'Start', 'start', '1', NULL, NULL, NULL, '[:]', '[fillColor:\"#00ff00\",size:[32,32],pos:[102,127],type:\"start\"]', NULL);
INSERT INTO `sys_wf_node` (`name`, `processname`, `title`, `nodetype`, `idx`, `salience`, `domain`, `role`, `properties`, `ui`, `tracktime`) VALUES ('receiver', 'rptcertification', 'Received', 'state', '2', NULL, 'RPT', 'CERTIFICATION_ISSUER', '[:]', '[fillColor:\"#c0c0c0\",size:[114,40],pos:[206,127],type:\"state\"]', '1');
INSERT INTO `sys_wf_node` (`name`, `processname`, `title`, `nodetype`, `idx`, `salience`, `domain`, `role`, `properties`, `ui`, `tracktime`) VALUES ('verifier', 'rptcertification', 'For Verification', 'state', '3', NULL, 'RPT', 'CERTIFICATION_VERIFIER', '[:]', '[fillColor:\"#c0c0c0\",size:[129,44],pos:[412,127],type:\"state\"]', '1');
INSERT INTO `sys_wf_node` (`name`, `processname`, `title`, `nodetype`, `idx`, `salience`, `domain`, `role`, `properties`, `ui`, `tracktime`) VALUES ('approver', 'rptcertification', 'For Approval', 'state', '4', NULL, 'RPT', 'CERTIFICATION_APPROVER', '[:]', '[fillColor:\"#c0c0c0\",size:[118,42],pos:[604,141],type:\"state\"]', '1');
INSERT INTO `sys_wf_node` (`name`, `processname`, `title`, `nodetype`, `idx`, `salience`, `domain`, `role`, `properties`, `ui`, `tracktime`) VALUES ('assign-releaser', 'rptcertification', 'Releasing', 'state', '6', NULL, 'RPT', 'CERTIFICATION_RELEASER', '[:]', '[fillColor:\"#c0c0c0\",size:[118,42],pos:[604,141],type:\"state\"]', '1');
INSERT INTO `sys_wf_node` (`name`, `processname`, `title`, `nodetype`, `idx`, `salience`, `domain`, `role`, `properties`, `ui`, `tracktime`) VALUES ('releaser', 'rptcertification', 'For Release', 'state', '7', NULL, 'RPT', 'CERTIFICATION_RELEASER', '[:]', '[fillColor:\"#c0c0c0\",size:[118,42],pos:[604,141],type:\"state\"]', '1');
INSERT INTO `sys_wf_node` (`name`, `processname`, `title`, `nodetype`, `idx`, `salience`, `domain`, `role`, `properties`, `ui`, `tracktime`) VALUES ('released', 'rptcertification', 'Released', 'end', '8', NULL, 'RPT', 'CERTIFICATION_RELEASER', '[:]', '[fillColor:\"#ff0000\",size:[32,32],pos:[797,148],type:\"end\"]', '1');

INSERT INTO `sys_wf_transition` (`parentid`, `processname`, `action`, `to`, `idx`, `eval`, `properties`, `permission`, `caption`, `ui`) VALUES ('start', 'rptcertification', 'assign', 'receiver', '1', NULL, '[:]', NULL, 'Assign', '[size:[72,0],pos:[134,142],type:\"arrow\",points:[134,142,206,142]]');
INSERT INTO `sys_wf_transition` (`parentid`, `processname`, `action`, `to`, `idx`, `eval`, `properties`, `permission`, `caption`, `ui`) VALUES ('receiver', 'rptcertification', 'cancelissuance', 'end', '5', NULL, '[caption:\'Cancel Issuance\', confirm:\'Cancel issuance?\',closeonend:true]', NULL, 'Cancel Issuance', '[size:[559,116],pos:[258,32],type:\"arrow\",points:[262,127,258,32,817,40,813,148]]');
INSERT INTO `sys_wf_transition` (`parentid`, `processname`, `action`, `to`, `idx`, `eval`, `properties`, `permission`, `caption`, `ui`) VALUES ('receiver', 'rptcertification', 'submit', 'verifier', '6', NULL, '[caption:\'Submit to Verifier\', confirm:\'Submit to verifier?\', messagehandler:\'rptmessage:info\',targetrole:\'RPT.CERTIFICATION_VERIFIER\']', NULL, 'Submit to Verifier', '[size:[92,0],pos:[320,146],type:\"arrow\",points:[320,146,412,146]]');
INSERT INTO `sys_wf_transition` (`parentid`, `processname`, `action`, `to`, `idx`, `eval`, `properties`, `permission`, `caption`, `ui`) VALUES ('verifier', 'rptcertification', 'return_receiver', 'receiver', '10', NULL, '[caption:\'Return to Issuer\', confirm:\'Return to issuer?\', messagehandler:\'default\']', NULL, 'Return to Receiver', '[size:[160,63],pos:[292,64],type:\"arrow\",points:[452,127,385,64,292,127]]');
INSERT INTO `sys_wf_transition` (`parentid`, `processname`, `action`, `to`, `idx`, `eval`, `properties`, `permission`, `caption`, `ui`) VALUES ('verifier', 'rptcertification', 'submit', 'approver', '11', NULL, '[caption:\'Submit for Approval\', confirm:\'Submit for approval?\', messagehandler:\'rptmessage:sign\',targetrole:\'RPT.CERTIFICATION_APPROVER\']', NULL, 'Submit to Approver', '[size:[63,4],pos:[541,152],type:\"arrow\",points:[541,152,604,156]]');
INSERT INTO `sys_wf_transition` (`parentid`, `processname`, `action`, `to`, `idx`, `eval`, `properties`, `permission`, `caption`, `ui`) VALUES ('approver', 'rptcertification', 'return_receiver', 'receiver', '15', NULL, '[caption:\'Return to Issuer\', confirm:\'Return to issuer?\', messagehandler:\'default\']', NULL, 'Return to Receiver', '[size:[333,113],pos:[285,167],type:\"arrow\",points:[618,183,414,280,285,167]]');
INSERT INTO `sys_wf_transition` (`parentid`, `processname`, `action`, `to`, `idx`, `eval`, `properties`, `permission`, `caption`, `ui`) VALUES ('approver', 'rptcertification', 'submit', 'assign-releaser', '16', NULL, '[caption:\'Approve\', confirm:\'Approve?\', messagehandler:\'rptmessage:sign\']', NULL, 'Approve', '[size:[75,0],pos:[722,162],type:\"arrow\",points:[722,162,797,162]]');
INSERT INTO `sys_wf_transition` (`parentid`, `processname`, `action`, `to`, `idx`, `eval`, `properties`, `permission`, `caption`, `ui`) VALUES ('assign-releaser', 'rptcertification', 'assign', 'releaser', '20', NULL, '[caption:\'Assign to Me\', confirm:\'Assign task to you?\']', NULL, 'Assign To Me', '[size:[63,4],pos:[541,152],type:\"arrow\",points:[541,152,604,156]]');
INSERT INTO `sys_wf_transition` (`parentid`, `processname`, `action`, `to`, `idx`, `eval`, `properties`, `permission`, `caption`, `ui`) VALUES ('releaser', 'rptcertification', 'submit', 'released', '100', '', '[caption:\'Release Certification\', confirm:\'Release certifications?\', closeonend:false, messagehandler:\'rptmessage:info\']', '', 'Release Certification', '[:]');

INSERT IGNORE INTO  `sys_usergroup` (`objid`, `title`, `domain`, `userclass`, `orgclass`, `role`) VALUES ('RPT.CERTIFICATION_APPROVER', 'CERTIFICATION_APPROVER', 'RPT', NULL, NULL, 'CERTIFICATION_APPROVER');
INSERT IGNORE INTO  `sys_usergroup` (`objid`, `title`, `domain`, `userclass`, `orgclass`, `role`) VALUES ('RPT.CERTIFICATION_ISSUER', 'CERTIFICATION_ISSUER', 'RPT', 'usergroup', NULL, 'CERTIFICATION_ISSUER');
INSERT IGNORE INTO  `sys_usergroup` (`objid`, `title`, `domain`, `userclass`, `orgclass`, `role`) VALUES ('RPT.CERTIFICATION_RELEASER', 'RPT CERTIFICATION_RELEASER', 'RPT', NULL, NULL, 'CERTIFICATION_RELEASER');
INSERT IGNORE INTO  `sys_usergroup` (`objid`, `title`, `domain`, `userclass`, `orgclass`, `role`) VALUES ('RPT.CERTIFICATION_VERIFIER', 'RPT CERTIFICATION_VERIFIER', 'RPT', NULL, NULL, 'CERTIFICATION_VERIFIER');


alter table rptcertification add taskid varchar(50)
;

CREATE TABLE `rptcertification_task` (
  `objid` varchar(50) NOT NULL DEFAULT '',
  `refid` varchar(50) DEFAULT NULL,
  `parentprocessid` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `startdate` datetime DEFAULT NULL,
  `enddate` datetime DEFAULT NULL,
  `assignee_objid` varchar(50) DEFAULT NULL,
  `assignee_name` varchar(100) DEFAULT NULL,
  `assignee_title` varchar(80) DEFAULT NULL,
  `actor_objid` varchar(50) DEFAULT NULL,
  `actor_name` varchar(100) DEFAULT NULL,
  `actor_title` varchar(80) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `signature` longtext,
  `returnedby` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_refid` (`refid`) USING BTREE,
  KEY `ix_assignee_objid` (`assignee_objid`) USING BTREE,
  CONSTRAINT `rptcertification_task_ibfk_1` FOREIGN KEY (`refid`) REFERENCES `rptcertification` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;