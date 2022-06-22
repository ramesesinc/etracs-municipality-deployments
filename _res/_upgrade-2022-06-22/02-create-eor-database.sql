create database [eor]
go

use [eor]
go

--
-- TABLE STRUCTURES 
--

CREATE TABLE [dbo].[eor] ( 
   [objid] varchar(50) NOT NULL, 
   [receiptno] varchar(50) NULL, 
   [receiptdate] date NULL, 
   [txndate] datetime NULL, 
   [state] varchar(10) NULL, 
   [partnerid] varchar(50) NULL, 
   [txntype] varchar(20) NULL, 
   [traceid] varchar(50) NULL, 
   [tracedate] datetime NULL, 
   [refid] varchar(50) NULL, 
   [paidby] varchar(255) NULL, 
   [paidbyaddress] varchar(255) NULL, 
   [payer_objid] varchar(50) NULL, 
   [paymethod] varchar(20) NULL, 
   [paymentrefid] varchar(50) NULL, 
   [remittanceid] varchar(50) NULL, 
   [remarks] varchar(255) NULL, 
   [amount] decimal(16,4) NULL, 
   [lockid] varchar(50) NULL,
   CONSTRAINT [pk_eor] PRIMARY KEY ([objid])
) 
GO

CREATE UNIQUE INDEX [uix_eor_receiptno] ON [dbo].[eor] ([receiptno])
GO
CREATE INDEX [ix_lockid] ON [dbo].[eor] ([lockid])
GO
CREATE INDEX [ix_paidby] ON [dbo].[eor] ([paidby])
GO
CREATE INDEX [ix_partnerid] ON [dbo].[eor] ([partnerid])
GO
CREATE INDEX [ix_payer_objid] ON [dbo].[eor] ([payer_objid])
GO
CREATE INDEX [ix_paymentrefid] ON [dbo].[eor] ([paymentrefid])
GO
CREATE INDEX [ix_receiptdate] ON [dbo].[eor] ([receiptdate])
GO
CREATE INDEX [ix_refid] ON [dbo].[eor] ([refid])
GO
CREATE INDEX [ix_remittanceid] ON [dbo].[eor] ([remittanceid])
GO
CREATE INDEX [ix_traceid] ON [dbo].[eor] ([traceid])
GO
CREATE INDEX [ix_txndate] ON [dbo].[eor] ([txndate])
GO


CREATE TABLE [dbo].[eor_for_email] ( 
   [objid] varchar(50) NOT NULL, 
   [txndate] datetime NULL, 
   [email] varchar(255) NULL, 
   [mobileno] varchar(50) NULL, 
   [state] int NULL, 
   [dtsent] datetime NULL, 
   [errmsg] varchar(255) NULL,
   CONSTRAINT [pk_eor_for_email] PRIMARY KEY ([objid])
) 
GO


CREATE TABLE [dbo].[eor_item] ( 
   [objid] varchar(50) NOT NULL, 
   [parentid] varchar(50) NULL, 
   [item_objid] varchar(50) NULL, 
   [item_code] varchar(100) NULL, 
   [item_title] varchar(100) NULL, 
   [amount] decimal(16,4) NULL, 
   [remarks] varchar(255) NULL, 
   [item_fund_objid] varchar(50) NULL,
   CONSTRAINT [pk_eor_item] PRIMARY KEY ([objid])
) 
GO

CREATE INDEX [fk_eoritem_eor] ON [dbo].[eor_item] ([parentid])
GO
CREATE INDEX [ix_item_fund_objid] ON [dbo].[eor_item] ([item_fund_objid])
GO
CREATE INDEX [ix_item_objid] ON [dbo].[eor_item] ([item_objid])
GO


CREATE TABLE [dbo].[eor_manual_post] ( 
   [objid] varchar(50) NOT NULL, 
   [state] varchar(10) NULL, 
   [paymentorderno] varchar(50) NULL, 
   [amount] decimal(16,4) NULL, 
   [txntype] varchar(50) NULL, 
   [paymentpartnerid] varchar(50) NULL, 
   [traceid] varchar(50) NULL, 
   [tracedate] datetime NULL, 
   [reason] text NULL, 
   [createdby_objid] varchar(50) NULL, 
   [createdby_name] varchar(255) NULL, 
   [dtcreated] datetime NULL,
   CONSTRAINT [pk_eor_manual_post] PRIMARY KEY ([objid])
) 
GO

CREATE UNIQUE INDEX [uix_eor_manual_post_paymentorderno] ON [dbo].[eor_manual_post] ([paymentorderno])
GO


CREATE TABLE [dbo].[eor_number] ( 
   [objid] varchar(255) NOT NULL, 
   [currentno] int NOT NULL DEFAULT 1,
   CONSTRAINT [pk_eor_number] PRIMARY KEY ([objid])
) 
GO


CREATE TABLE [dbo].[eor_payment_error] ( 
   [objid] varchar(50) NOT NULL, 
   [txndate] datetime NOT NULL, 
   [paymentrefid] varchar(50) NOT NULL, 
   [errmsg] text NOT NULL, 
   [errdetail] text NULL, 
   [errcode] int NULL, 
   [laststate] int NULL,
   CONSTRAINT [pk_eor_payment_error] PRIMARY KEY ([objid])
) 
GO

CREATE UNIQUE INDEX [ix_paymentrefid] ON [dbo].[eor_payment_error] ([paymentrefid])
GO
CREATE INDEX [ix_txndate] ON [dbo].[eor_payment_error] ([txndate])
GO


CREATE TABLE [dbo].[eor_paymentorder] ( 
   [objid] varchar(50) NOT NULL, 
   [txndate] datetime NULL, 
   [txntype] varchar(50) NULL, 
   [txntypename] varchar(100) NULL, 
   [payer_objid] varchar(50) NULL, 
   [payer_name] text NULL, 
   [paidby] text NULL, 
   [paidbyaddress] varchar(150) NULL, 
   [particulars] varchar(500) NULL, 
   [amount] decimal(16,2) NULL, 
   [expirydate] date NULL, 
   [refid] varchar(50) NULL, 
   [refno] varchar(50) NULL, 
   [info] text NULL, 
   [origin] varchar(100) NULL, 
   [controlno] varchar(50) NULL, 
   [locationid] varchar(25) NULL, 
   [items] text NULL, 
   [state] varchar(32) NULL, 
   [email] varchar(255) NULL, 
   [mobileno] varchar(25) NULL,
   CONSTRAINT [pk_eor_paymentorder] PRIMARY KEY ([objid])
) 
GO

CREATE INDEX [ix_state] ON [dbo].[eor_paymentorder] ([state])
GO


CREATE TABLE [dbo].[eor_paymentorder_cancelled] ( 
   [objid] varchar(50) NOT NULL, 
   [txndate] datetime NULL, 
   [txntype] varchar(50) NULL, 
   [txntypename] varchar(100) NULL, 
   [payer_objid] varchar(50) NULL, 
   [payer_name] text NULL, 
   [paidby] text NULL, 
   [paidbyaddress] varchar(150) NULL, 
   [particulars] text NULL, 
   [amount] decimal(16,2) NULL, 
   [expirydate] date NULL, 
   [refid] varchar(50) NULL, 
   [refno] varchar(50) NULL, 
   [info] text NULL, 
   [origin] varchar(100) NULL, 
   [controlno] varchar(50) NULL, 
   [locationid] varchar(25) NULL, 
   [items] text NULL, 
   [state] varchar(10) NULL, 
   [email] varchar(255) NULL, 
   [mobileno] varchar(50) NULL,
   CONSTRAINT [pk_eor_paymentorder_cancelled] PRIMARY KEY ([objid])
) 
GO

CREATE INDEX [ix_controlno] ON [dbo].[eor_paymentorder_cancelled] ([controlno])
GO
CREATE INDEX [ix_expirydate] ON [dbo].[eor_paymentorder_cancelled] ([expirydate])
GO
CREATE INDEX [ix_locationid] ON [dbo].[eor_paymentorder_cancelled] ([locationid])
GO
CREATE INDEX [ix_payer_objid] ON [dbo].[eor_paymentorder_cancelled] ([payer_objid])
GO
CREATE INDEX [ix_refid] ON [dbo].[eor_paymentorder_cancelled] ([refid])
GO
CREATE INDEX [ix_refno] ON [dbo].[eor_paymentorder_cancelled] ([refno])
GO
CREATE INDEX [ix_txndate] ON [dbo].[eor_paymentorder_cancelled] ([txndate])
GO
CREATE INDEX [ix_txntype] ON [dbo].[eor_paymentorder_cancelled] ([txntype])
GO


CREATE TABLE [dbo].[eor_paymentorder_paid] ( 
   [objid] varchar(50) NOT NULL, 
   [txndate] datetime NULL, 
   [txntype] varchar(50) NULL, 
   [txntypename] varchar(100) NULL, 
   [payer_objid] varchar(50) NULL, 
   [payer_name] text NULL, 
   [paidby] text NULL, 
   [paidbyaddress] varchar(150) NULL, 
   [particulars] text NULL, 
   [amount] decimal(16,2) NULL, 
   [expirydate] date NULL, 
   [refid] varchar(50) NULL, 
   [refno] varchar(50) NULL, 
   [info] text NULL, 
   [origin] varchar(100) NULL, 
   [controlno] varchar(50) NULL, 
   [locationid] varchar(25) NULL, 
   [items] text NULL, 
   [state] varchar(10) NULL, 
   [email] varchar(255) NULL, 
   [mobileno] varchar(50) NULL,
   CONSTRAINT [pk_eor_paymentorder_paid] PRIMARY KEY ([objid])
) 
GO

CREATE INDEX [ix_controlno] ON [dbo].[eor_paymentorder_paid] ([controlno])
GO
CREATE INDEX [ix_expirydate] ON [dbo].[eor_paymentorder_paid] ([expirydate])
GO
CREATE INDEX [ix_locationid] ON [dbo].[eor_paymentorder_paid] ([locationid])
GO
CREATE INDEX [ix_payer_objid] ON [dbo].[eor_paymentorder_paid] ([payer_objid])
GO
CREATE INDEX [ix_refid] ON [dbo].[eor_paymentorder_paid] ([refid])
GO
CREATE INDEX [ix_refno] ON [dbo].[eor_paymentorder_paid] ([refno])
GO
CREATE INDEX [ix_txndate] ON [dbo].[eor_paymentorder_paid] ([txndate])
GO
CREATE INDEX [ix_txntype] ON [dbo].[eor_paymentorder_paid] ([txntype])
GO


CREATE TABLE [dbo].[eor_remittance] ( 
   [objid] varchar(50) NOT NULL, 
   [state] varchar(50) NULL, 
   [controlno] varchar(50) NULL, 
   [partnerid] varchar(50) NULL, 
   [controldate] date NULL, 
   [dtcreated] datetime NULL, 
   [createdby_objid] varchar(50) NULL, 
   [createdby_name] varchar(255) NULL, 
   [amount] decimal(16,4) NULL, 
   [dtposted] datetime NULL, 
   [postedby_objid] varchar(50) NULL, 
   [postedby_name] varchar(255) NULL, 
   [lockid] varchar(50) NULL,
   CONSTRAINT [pk_eor_remittance] PRIMARY KEY ([objid])
) 
GO


CREATE TABLE [dbo].[eor_remittance_fund] ( 
   [objid] varchar(100) NOT NULL, 
   [remittanceid] varchar(50) NULL, 
   [fund_objid] varchar(50) NULL, 
   [fund_code] varchar(50) NULL, 
   [fund_title] varchar(255) NULL, 
   [amount] decimal(16,4) NULL, 
   [bankaccount_objid] varchar(50) NULL, 
   [bankaccount_title] varchar(255) NULL, 
   [bankaccount_bank_name] varchar(255) NULL, 
   [validation_refno] varchar(50) NULL, 
   [validation_refdate] date NULL,
   CONSTRAINT [pk_eor_remittance_fund] PRIMARY KEY ([objid])
) 
GO

CREATE INDEX [fk_eor_remittance_fund_remittance] ON [dbo].[eor_remittance_fund] ([remittanceid])
GO


CREATE TABLE [dbo].[eor_share] ( 
   [objid] varchar(50) NOT NULL, 
   [parentid] varchar(50) NOT NULL, 
   [refitem_objid] varchar(50) NULL, 
   [refitem_code] varchar(25) NULL, 
   [refitem_title] varchar(255) NULL, 
   [payableitem_objid] varchar(50) NULL, 
   [payableitem_code] varchar(25) NULL, 
   [payableitem_title] varchar(255) NULL, 
   [amount] decimal(16,4) NULL, 
   [share] decimal(16,2) NULL, 
   [receiptitemid] varchar(50) NULL, 
   [refitem_fund_objid] varchar(100) NULL, 
   [payableitem_fund_objid] varchar(100) NULL,
   CONSTRAINT [pk_eor_share] PRIMARY KEY ([objid])
) 
GO

CREATE INDEX [ix_payableitem_fund_objid] ON [dbo].[eor_share] ([payableitem_fund_objid])
GO
CREATE INDEX [ix_refitem_fund_objid] ON [dbo].[eor_share] ([refitem_fund_objid])
GO


CREATE TABLE [dbo].[epayment_plugin] ( 
   [objid] varchar(50) NOT NULL, 
   [connection] varchar(50) NULL, 
   [servicename] varchar(255) NULL,
   CONSTRAINT [pk_epayment_plugin] PRIMARY KEY ([objid])
) 
GO


CREATE TABLE [dbo].[fund] ( 
   [objid] varchar(100) NOT NULL, 
   [state] varchar(10) NULL, 
   [code] varchar(50) NULL, 
   [title] varchar(255) NULL, 
   [type] varchar(20) NULL, 
   [special] int NULL, 
   [system] int NULL, 
   [depositoryfundid] varchar(100) NULL, 
   [group_objid] varchar(50) NULL, 
   [group_title] varchar(255) NULL, 
   [group_indexno] int NULL,
   CONSTRAINT [pk_fund] PRIMARY KEY ([objid])
) 
GO

CREATE INDEX [ix_code] ON [dbo].[fund] ([code])
GO
CREATE INDEX [ix_depositoryfundid] ON [dbo].[fund] ([depositoryfundid])
GO
CREATE INDEX [ix_group_objid] ON [dbo].[fund] ([group_objid])
GO
CREATE INDEX [ix_title] ON [dbo].[fund] ([title])
GO


CREATE TABLE [dbo].[jev] ( 
   [objid] varchar(150) NOT NULL, 
   [jevno] varchar(50) NULL, 
   [jevdate] date NULL, 
   [fundid] varchar(50) NULL, 
   [dtposted] datetime NULL, 
   [txntype] varchar(50) NULL, 
   [refid] varchar(50) NULL, 
   [refno] varchar(50) NULL, 
   [reftype] varchar(50) NULL, 
   [amount] decimal(16,4) NULL, 
   [state] varchar(32) NULL, 
   [postedby_objid] varchar(50) NULL, 
   [postedby_name] varchar(255) NULL, 
   [verifiedby_objid] varchar(50) NULL, 
   [verifiedby_name] varchar(255) NULL, 
   [dtverified] datetime NULL, 
   [batchid] varchar(50) NULL, 
   [refdate] date NULL,
   CONSTRAINT [pk_jev] PRIMARY KEY ([objid])
) 
GO

CREATE INDEX [ix_batchid] ON [dbo].[jev] ([batchid])
GO
CREATE INDEX [ix_dtposted] ON [dbo].[jev] ([dtposted])
GO
CREATE INDEX [ix_dtverified] ON [dbo].[jev] ([dtverified])
GO
CREATE INDEX [ix_fundid] ON [dbo].[jev] ([fundid])
GO
CREATE INDEX [ix_jevdate] ON [dbo].[jev] ([jevdate])
GO
CREATE INDEX [ix_jevno] ON [dbo].[jev] ([jevno])
GO
CREATE INDEX [ix_postedby_objid] ON [dbo].[jev] ([postedby_objid])
GO
CREATE INDEX [ix_refdate] ON [dbo].[jev] ([refdate])
GO
CREATE INDEX [ix_refid] ON [dbo].[jev] ([refid])
GO
CREATE INDEX [ix_refno] ON [dbo].[jev] ([refno])
GO
CREATE INDEX [ix_reftype] ON [dbo].[jev] ([reftype])
GO
CREATE INDEX [ix_verifiedby_objid] ON [dbo].[jev] ([verifiedby_objid])
GO


CREATE TABLE [dbo].[jevitem] ( 
   [objid] varchar(150) NOT NULL, 
   [jevid] varchar(150) NULL, 
   [accttype] varchar(50) NULL, 
   [acctid] varchar(50) NULL, 
   [acctcode] varchar(32) NULL, 
   [acctname] varchar(255) NULL, 
   [dr] decimal(16,4) NULL, 
   [cr] decimal(16,4) NULL, 
   [particulars] varchar(255) NULL, 
   [itemrefid] varchar(255) NULL,
   CONSTRAINT [pk_jevitem] PRIMARY KEY ([objid])
) 
GO

CREATE INDEX [ix_acctcode] ON [dbo].[jevitem] ([acctcode])
GO
CREATE INDEX [ix_acctid] ON [dbo].[jevitem] ([acctid])
GO
CREATE INDEX [ix_acctname] ON [dbo].[jevitem] ([acctname])
GO
CREATE INDEX [ix_itemrefid] ON [dbo].[jevitem] ([itemrefid])
GO
CREATE INDEX [ix_jevid] ON [dbo].[jevitem] ([jevid])
GO
CREATE INDEX [ix_ledgertype] ON [dbo].[jevitem] ([accttype])
GO


CREATE TABLE [dbo].[paymentpartner] ( 
   [objid] varchar(50) NOT NULL, 
   [code] varchar(50) NULL, 
   [name] varchar(100) NULL, 
   [branch] varchar(255) NULL, 
   [contact] varchar(255) NULL, 
   [mobileno] varchar(32) NULL, 
   [phoneno] varchar(32) NULL, 
   [email] varchar(255) NULL, 
   [indexno] varchar(3) NULL,
   CONSTRAINT [pk_paymentpartner] PRIMARY KEY ([objid])
) 
GO


CREATE TABLE [dbo].[sys_email_queue] ( 
   [objid] varchar(50) NOT NULL, 
   [refid] varchar(50) NOT NULL, 
   [state] int NOT NULL, 
   [reportid] varchar(50) NULL, 
   [dtsent] datetime NOT NULL, 
   [to] varchar(255) NOT NULL, 
   [subject] varchar(255) NOT NULL, 
   [message] text NOT NULL, 
   [errmsg] text NULL, 
   [connection] varchar(50) NULL,
   CONSTRAINT [pk_sys_email_queue] PRIMARY KEY ([objid])
) 
GO

CREATE INDEX [ix_dtsent] ON [dbo].[sys_email_queue] ([dtsent])
GO
CREATE INDEX [ix_refid] ON [dbo].[sys_email_queue] ([refid])
GO
CREATE INDEX [ix_reportid] ON [dbo].[sys_email_queue] ([reportid])
GO
CREATE INDEX [ix_state] ON [dbo].[sys_email_queue] ([state])
GO


CREATE TABLE [dbo].[sys_email_template] ( 
   [objid] varchar(50) NOT NULL, 
   [subject] varchar(255) NOT NULL, 
   [message] text NOT NULL,
   CONSTRAINT [pk_sys_email_template] PRIMARY KEY ([objid])
) 
GO


CREATE TABLE [dbo].[unpostedpayment] ( 
   [objid] varchar(50) NOT NULL, 
   [txndate] datetime NOT NULL, 
   [txntype] varchar(50) NOT NULL, 
   [txntypename] varchar(150) NOT NULL, 
   [paymentrefid] varchar(50) NOT NULL, 
   [amount] decimal(16,2) NOT NULL, 
   [orgcode] varchar(20) NOT NULL, 
   [partnerid] varchar(50) NOT NULL, 
   [traceid] varchar(100) NOT NULL, 
   [tracedate] datetime NOT NULL, 
   [refno] varchar(50) NULL, 
   [origin] varchar(50) NULL, 
   [paymentorder] text NULL, 
   [errmsg] text NOT NULL, 
   [errdetail] text NULL,
   CONSTRAINT [pk_unpostedpayment] PRIMARY KEY ([objid])
) 
GO

CREATE UNIQUE INDEX [ix_paymentrefid] ON [dbo].[unpostedpayment] ([paymentrefid])
GO
CREATE INDEX [ix_origin] ON [dbo].[unpostedpayment] ([origin])
GO
CREATE INDEX [ix_partnerid] ON [dbo].[unpostedpayment] ([partnerid])
GO
CREATE INDEX [ix_refno] ON [dbo].[unpostedpayment] ([refno])
GO
CREATE INDEX [ix_tracedate] ON [dbo].[unpostedpayment] ([tracedate])
GO
CREATE INDEX [ix_traceid] ON [dbo].[unpostedpayment] ([traceid])
GO
CREATE INDEX [ix_txndate] ON [dbo].[unpostedpayment] ([txndate])
GO
CREATE INDEX [ix_txntype] ON [dbo].[unpostedpayment] ([txntype])
GO



--
-- FOREIGN KEYS 
--

ALTER TABLE [dbo].[eor] ADD CONSTRAINT [fk_eor_remittanceid] 
   FOREIGN KEY ([remittanceid]) REFERENCES [dbo].[eor_remittance] ([objid])
GO


ALTER TABLE [dbo].[eor_item] ADD CONSTRAINT [fk_eoritem_eor] 
   FOREIGN KEY ([parentid]) REFERENCES [dbo].[eor] ([objid])
GO


ALTER TABLE [dbo].[eor_remittance_fund] ADD CONSTRAINT [fk_eor_remittance_fund_remittance] 
   FOREIGN KEY ([remittanceid]) REFERENCES [dbo].[eor_remittance] ([objid])
GO


ALTER TABLE [dbo].[jevitem] ADD CONSTRAINT [fk_jevitem_jevid] 
   FOREIGN KEY ([jevid]) REFERENCES [dbo].[jev] ([objid])
GO


CREATE VIEW vw_remittance_eor_item AS 
select 
   c.remittanceid AS remittanceid,
   r.controldate AS remittance_controldate,
   r.controlno AS remittance_controlno,
   cri.parentid AS receiptid,
   c.receiptdate AS receiptdate,
   c.receiptno AS receiptno,
   c.paidby AS paidby,
   c.paidbyaddress AS paidbyaddress,
   cri.item_fund_objid AS fundid,
   cri.item_objid AS acctid,
   cri.item_code AS acctcode,
   cri.item_title AS acctname,
   cri.remarks AS remarks,
   cri.amount AS amount 
from eor_remittance r 
   inner join eor c on c.remittanceid = r.objid 
   inner join eor_item cri on cri.parentid = c.objid 
go 

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
   cri.payableitem_objid AS acctid,
   cri.payableitem_code AS acctcode,
   cri.payableitem_title AS acctname,
   cri.share AS amount 
from eor_remittance r 
   inner join eor c on c.remittanceid = r.objid 
   inner join eor_share cri on cri.parentid = c.objid 
go 

INSERT INTO paymentpartner (objid, code, name, branch, contact, mobileno, phoneno, email, indexno) VALUES ('DBP', '101', 'DEVELOPMENT BANK OF THE PHILIPPINES', NULL, NULL, NULL, NULL, NULL, '101');
INSERT INTO paymentpartner (objid, code, name, branch, contact, mobileno, phoneno, email, indexno) VALUES ('LBP', '102', 'LAND BANK OF THE PHILIPPINES', NULL, NULL, NULL, NULL, NULL, '102');
INSERT INTO paymentpartner (objid, code, name, branch, contact, mobileno, phoneno, email, indexno) VALUES ('PAYMAYA', '103', 'PAYMAYA', NULL, NULL, NULL, NULL, NULL, '103');
INSERT INTO paymentpartner (objid, code, name, branch, contact, mobileno, phoneno, email, indexno) VALUES ('GCASH', '104', 'GCASH', NULL, NULL, NULL, NULL, NULL, '104');

INSERT INTO epayment_plugin (objid, connection, servicename) VALUES ('bpls', 'bpls', 'OnlineBusinessBillingService');
INSERT INTO epayment_plugin (objid, connection, servicename) VALUES ('rptcol', 'rpt', 'OnlineLandTaxBillingService');
INSERT INTO epayment_plugin (objid, connection, servicename) VALUES ('rpttaxclearance', 'landtax', 'OnlineRealtyTaxClearanceService');

INSERT INTO sys_email_template (objid, subject, message) VALUES ('eor', 'EOR No ${receiptno}', 'Dear valued customer <br>Please see attached Electronic OR. This is an electronic transaction. Do not reply');



-- ## patches

DROP VIEW vw_remittance_eor_share 
GO 
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
go 
