
use eor; 

CREATE VIEW `vw_remittance_eor_item` AS select `c`.`remittanceid` AS `remittanceid`,`r`.`controldate` AS `remittance_controldate`,`r`.`controlno` AS `remittance_controlno`,`cri`.`parentid` AS `receiptid`,`c`.`receiptdate` AS `receiptdate`,`c`.`receiptno` AS `receiptno`,`c`.`paidby` AS `paidby`,`c`.`paidbyaddress` AS `paidbyaddress`,`cri`.`item_fund_objid` AS `fundid`,`cri`.`item_objid` AS `acctid`,`cri`.`item_code` AS `acctcode`,`cri`.`item_title` AS `acctname`,`cri`.`remarks` AS `remarks`,`cri`.`amount` AS `amount` from ((`eor_remittance` `r` join `eor` `c` on((`c`.`remittanceid` = `r`.`objid`))) join `eor_item` `cri` on((`cri`.`parentid` = `c`.`objid`))) ;

CREATE VIEW `vw_remittance_eor_share` AS select `c`.`remittanceid` AS `remittanceid`,`r`.`controldate` AS `remittance_controldate`,`r`.`controlno` AS `remittance_controlno`,`cri`.`parentid` AS `receiptid`,`c`.`receiptdate` AS `receiptdate`,`c`.`receiptno` AS `receiptno`,`c`.`paidby` AS `paidby`,`c`.`paidbyaddress` AS `paidbyaddress`,`cri`.`refitem_objid` AS `refacctid`,`cri`.`refitem_code` AS `refacctcode`,`cri`.`refitem_title` AS `refaccttitle`,`cri`.`payableitem_objid` AS `acctid`,`cri`.`payableitem_code` AS `acctcode`,`cri`.`payableitem_title` AS `acctname`,`cri`.`share` AS `amount` from ((`eor_remittance` `r` join `eor` `c` on((`c`.`remittanceid` = `r`.`objid`))) join `eor_share` `cri` on((`cri`.`parentid` = `c`.`objid`))) ;


INSERT INTO `paymentpartner` (`objid`, `code`, `name`, `branch`, `contact`, `mobileno`, `phoneno`, `email`, `indexno`) VALUES ('DBP', '101', 'DEVELOPMENT BANK OF THE PHILIPPINES', NULL, NULL, NULL, NULL, NULL, '101');
INSERT INTO `paymentpartner` (`objid`, `code`, `name`, `branch`, `contact`, `mobileno`, `phoneno`, `email`, `indexno`) VALUES ('LBP', '102', 'LAND BANK OF THE PHILIPPINES', NULL, NULL, NULL, NULL, NULL, '102');
INSERT INTO `paymentpartner` (`objid`, `code`, `name`, `branch`, `contact`, `mobileno`, `phoneno`, `email`, `indexno`) VALUES ('PAYMAYA', '103', 'PAYMAYA', NULL, NULL, NULL, NULL, NULL, '103');
INSERT INTO `paymentpartner` (`objid`, `code`, `name`, `branch`, `contact`, `mobileno`, `phoneno`, `email`, `indexno`) VALUES ('GCASH', '104', 'GCASH', NULL, NULL, NULL, NULL, NULL, '104');



-- ## 2021-11-23

alter table eor_share 
  add refitem_fund_objid varchar(100) null, 
  add payableitem_fund_objid varchar(100) null
;
create index ix_refitem_fund_objid on eor_share (refitem_fund_objid)
;
create index ix_payableitem_fund_objid on eor_share (payableitem_fund_objid)
;



drop view if exists vw_remittance_eor_share
; 
CREATE VIEW vw_remittance_eor_share AS 
select 
  c.remittanceid AS remittanceid,
  r.controldate AS remittance_controldate,
  r.controlno AS remittance_controlno,
  cri.parentid AS receiptid,
  c.receiptdate AS receiptdate,
  c.receiptno AS receiptno,
  c.paidby AS paidby,
  c.paidbyaddress AS paidbyaddress,
  cri.refitem_objid AS refacctid,
  cri.refitem_code AS refacctcode,
  cri.refitem_title AS refaccttitle,
  cri.refitem_fund_objid as reffundid, 
  cri.payableitem_objid AS acctid,
  cri.payableitem_code AS acctcode,
  cri.payableitem_title AS acctname,
  cri.payableitem_fund_objid AS fundid,
  cri.amount AS amount,
  c.txntype  
from eor_remittance r 
  inner join eor c on c.remittanceid = r.objid 
  inner join eor_share cri on cri.parentid = c.objid
;



-- ## 2021-11-24

CREATE TABLE `fund` (
  `objid` varchar(100) NOT NULL,
  `state` varchar(10) NULL,
  `code` varchar(50) NULL,
  `title` varchar(255) NULL,
  `type` varchar(20) NULL,
  `special` int NULL,
  `system` int NULL,
  `depositoryfundid` varchar(100) NULL,
  `group_objid` varchar(50) NULL,
  `group_title` varchar(255) NULL,
  `group_indexno` int NULL,
  constraint pk_fund PRIMARY KEY (`objid`),
  KEY `ix_code` (`code`),
  KEY `ix_title` (`title`),
  KEY `ix_group_objid` (`group_objid`),
  KEY `ix_depositoryfundid` (`depositoryfundid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
; 
