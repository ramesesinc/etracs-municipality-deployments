use etracs255_bayombong
go 

-- ## 2020-03-02
alter table account_maingroup alter column [title] varchar(255) NOT NULL
go 
alter table account_maingroup alter column [version] int NOT NULL
go 


drop index ix_name on af_allocation
go 
alter table af_allocation alter column [name] varchar(100) NOT NULL
go 
create index ix_name on af_allocation (name) 
go 


-- alter table af_control alter column [fund_objid] varchar(50) NULL 
-- go 
-- alter table af_control add constraint fk_af_control_fund_objid 
--   foreign key (fund_objid) references fund (objid) 
-- go 


drop index ix_state on afrequest 
go 
alter table afrequest alter column [state] varchar(25) NOT NULL 
go 
create index ix_state on afrequest (state) 
go 
-- alter table afrequest add 
--   [dtapproved] datetime NULL ,
--   [approvedby_objid] varchar(50) NULL ,
--   [approvedby_name] varchar(160) NULL 
-- go 


-- alter table afunit drop constraint DF__afunit__interval__2E66C05C
-- go 
-- alter table afunit alter column [interval] int NULL
-- go 
-- alter table afunit add default 1 for [interval]
-- go 


alter table bankaccount alter column [fund_objid] varchar(50) NOT NULL 
go 
-- create index ix_fund_objid on bankaccount (fund_objid) 
-- go 
-- alter table bankaccount add constraint fk_bankaccount_fund_objid 
--   foreign key (fund_objid) references fund (objid)
-- go 


alter table bankaccount_ledger alter column [objid] varchar(150) NOT NULL
go 

drop index ix_jevid on bankaccount_ledger 
go 
alter table bankaccount_ledger alter column [jevid] varchar(150) NOT NULL
go 
create index ix_jevid on bankaccount_ledger (jevid) 
go 

drop index ix_bankacctid on bankaccount_ledger 
go 
alter table bankaccount_ledger alter column [bankacctid] varchar(50) NOT NULL
go 
create index ix_bankacctid on bankaccount_ledger (bankacctid) 
go 

drop index ix_itemacctid on bankaccount_ledger
go 
alter table bankaccount_ledger alter column [itemacctid] varchar(50) NOT NULL
go 
create index ix_itemacctid on bankaccount_ledger (itemacctid) 
go 

alter table bankaccount_ledger alter column [dr] decimal(16,4) NOT NULL
go 
alter table bankaccount_ledger alter column [cr] decimal(16,4) NOT NULL
go 


drop index ix_batchcapture_collection_entry_parentid on batchcapture_collection_entry 
go 
-- alter table batchcapture_collection_entry alter column [parentid] varchar(50) NOT NULL
-- go 
-- create index ix_parentid on batchcapture_collection_entry (parentid) 
-- go 


drop index ix_batchcapture_collection_entry_item_parentid on batchcapture_collection_entry_item 
go 
-- alter table batchcapture_collection_entry_item alter column [parentid] varchar(50) NOT NULL
-- go 
-- create index ix_parentid on batchcapture_collection_entry_item (parentid) 
-- go 
alter table batchcapture_collection_entry_item add constraint fk_batchcapture_collection_entry_item_parentid 
  foreign key (parentid) references batchcapture_collection_entry (objid) 
go 


drop index item_objid on batchcapture_collection_entry_item
go 
-- alter table batchcapture_collection_entry_item alter column [item_objid] varchar(50) NOT NULL 
-- go 
-- create index ix_item_objid on batchcapture_collection_entry_item (item_objid)
-- go 


drop index ix_batchcapture_collection_entry_item_item_code on batchcapture_collection_entry_item
go 
alter table batchcapture_collection_entry_item alter column [item_code] varchar(50) NOT NULL
go 
create index ix_item_code on batchcapture_collection_entry_item (item_code)
go 


alter table batchcapture_collection_entry_item alter column [item_title] varchar(255) NOT NULL
go 
drop index fund_objid on batchcapture_collection_entry_item
go 
-- alter table batchcapture_collection_entry_item alter column [fund_objid] varchar(50) NOT NULL
-- go 
-- create index ix_fund_objid on batchcapture_collection_entry_item  (fund_objid)
-- go 
alter table batchcapture_collection_entry_item alter column [fund_code] varchar(50) NOT NULL
go 
alter table batchcapture_collection_entry_item alter column [fund_title] varchar(255) NOT NULL
go 
alter table batchcapture_collection_entry_item alter column [amount] decimal(16,2) NOT NULL
go 


alter table batchcapture_collection_entry_item add constraint fk_batchcapture_collection_entry_item_item_objid 
  foreign key (item_objid) references itemaccount (objid) 
go 
alter table batchcapture_collection_entry_item add constraint fk_batchcapture_collection_entry_fund_objid 
  foreign key (fund_objid) references fund (objid) 
go 


CREATE TABLE [dbo].[billitem_txntype] (
[objid] varchar(50) NOT NULL ,
[title] varchar(150) NULL ,
[category] varchar(100) NULL ,
CONSTRAINT [pk_billitem_txntype] PRIMARY KEY ([objid])
)
GO
CREATE INDEX [ix_title] ON [dbo].[billitem_txntype] ([title] ASC) 
GO
CREATE INDEX [ix_category] ON [dbo].[billitem_txntype] ([category] ASC) 
GO


alter table lobclassification alter column state varchar(25) not null 
go 


-- create index ix_classification_objid on lob (classification_objid) 
-- go 
alter table lob add constraint fk_lob_classification_objid 
  foreign key (classification_objid) references lobclassification (objid) 
go 


update aa set 
  aa.permit_objid = bb.objid 
from business_application aa, ( 
  select objid, applicationid 
  from business_permit 
  where state = 'ACTIVE' 
)bb 
where aa.objid = bb.applicationid 
go 

alter table business_application add constraint fk_business_application_permit_objid 
  foreign key (permit_objid) references business_permit (objid) 
go 



alter table collectiongroup_account alter column [account_title] varchar(255) NOT NULL 
go 
alter table collectiongroup_account alter column [sortorder] int NOT NULL 
go 


alter table creditmemoitem alter column [amount] decimal(16,2) NOT NULL
go 



alter table deposit_fund_transfer alter column [fromdepositvoucherfundid] varchar(150) NOT NULL
go 
alter table deposit_fund_transfer alter column [todepositvoucherfundid] varchar(150) NOT NULL 
go 
alter table deposit_fund_transfer alter column [amount] decimal(16,4) NOT NULL
go 


alter table depositvoucher_fund alter column [amount] decimal(16,4) NOT NULL 
go 
alter table depositvoucher_fund alter column [amountdeposited] decimal(16,4) NOT NULL 
go 

update depositvoucher_fund set totaldr = 0.0 where totaldr is null 
go 
alter table depositvoucher_fund alter column [totaldr] decimal(16,4) NOT NULL 
go 

update depositvoucher_fund set totalcr = 0.0 where totalcr is null 
go 
alter table depositvoucher_fund alter column [totalcr] decimal(16,4) NOT NULL 
go 


alter table eftpayment alter column [amount] decimal(16,4) NOT NULL 
go 



alter table entity alter column [email] varchar(255) NULL 
go 

update entity set state = 'ACTIVE' where state IS NULL 
go 



CREATE TABLE [dbo].[entityidcard] (
[objid] varchar(50) NOT NULL ,
[entityid] varchar(50) NOT NULL ,
[idtype] varchar(50) NOT NULL ,
[idno] varchar(25) NOT NULL ,
[expiry] varchar(50) NULL ,
CONSTRAINT [pk_entityidcard] PRIMARY KEY ([objid])
)
GO
CREATE UNIQUE INDEX [ux_entityidcard_entityid_idtype_idno] ON [dbo].[entityidcard]
([entityid] ASC, [idtype] ASC, [idno] ASC) 
GO
CREATE INDEX [FK_entityidcard_entity] ON [dbo].[entityidcard]
([entityid] ASC) 
GO


alter table entityprofile alter column [address] varchar(MAX) NULL
go 


DROP TABLE [dbo].[paymentorder]
GO 

CREATE TABLE [dbo].[paymentorder] (
[objid] varchar(50) NOT NULL ,
[txndate] datetime NULL ,
[payer_objid] varchar(50) NULL ,
[payer_name] varchar(MAX) NULL ,
[paidby] varchar(MAX) NULL ,
[paidbyaddress] varchar(150) NULL ,
[particulars] varchar(MAX) NULL ,
[amount] decimal(16,2) NULL ,
[txntype] varchar(50) NULL ,
[expirydate] date NULL ,
[refid] varchar(50) NULL ,
[refno] varchar(50) NULL ,
[info] varchar(MAX) NULL ,
[txntypename] varchar(255) NULL ,
[locationid] varchar(50) NULL ,
[origin] varchar(50) NULL ,
[issuedby_objid] varchar(50) NULL ,
[issuedby_name] varchar(150) NULL ,
[org_objid] varchar(50) NULL ,
[org_name] varchar(255) NULL ,
[items] text NULL ,
[collectiontypeid] varchar(50) NULL ,
[queueid] varchar(50) NULL ,
CONSTRAINT [pk_paymentorder] PRIMARY KEY ([objid])
)
GO
CREATE INDEX [ix_collectiontypeid] ON [dbo].[paymentorder]
([collectiontypeid] ASC) 
GO
CREATE INDEX [ix_locationid] ON [dbo].[paymentorder]
([locationid] ASC) 
GO
CREATE INDEX [ix_issuedby_objid] ON [dbo].[paymentorder]
([issuedby_objid] ASC) 
GO
CREATE INDEX [ix_issuedby_name] ON [dbo].[paymentorder]
([issuedby_name] ASC) 
GO
CREATE INDEX [ix_org_objid] ON [dbo].[paymentorder]
([org_objid] ASC) 
GO
CREATE INDEX [ix_org_name] ON [dbo].[paymentorder]
([org_name] ASC) 
GO



drop table sync_data_pending 
go 
drop table sync_data_forprocess
go 
drop table sync_data
go 

CREATE TABLE [dbo].[sync_data] (
[objid] varchar(50) NOT NULL ,
[parentid] varchar(50) NOT NULL ,
[refid] varchar(50) NOT NULL ,
[reftype] varchar(50) NOT NULL ,
[action] varchar(50) NOT NULL ,
[orgid] varchar(50) NULL ,
[remote_orgid] varchar(50) NULL ,
[remote_orgcode] varchar(20) NULL ,
[remote_orgclass] varchar(20) NULL ,
[dtfiled] datetime NOT NULL ,
[idx] int NOT NULL ,
[sender_objid] varchar(50) NULL ,
[sender_name] varchar(150) NULL ,
[refno] varchar(50) NULL ,
CONSTRAINT [pk_sync_data] PRIMARY KEY ([objid])
)
GO
CREATE INDEX [ix_sync_data_refid] ON [dbo].[sync_data]
([refid] ASC) 
GO
CREATE INDEX [ix_sync_data_reftype] ON [dbo].[sync_data]
([reftype] ASC) 
GO
CREATE INDEX [ix_sync_data_orgid] ON [dbo].[sync_data]
([orgid] ASC) 
GO
CREATE INDEX [ix_sync_data_dtfiled] ON [dbo].[sync_data]
([dtfiled] ASC) 
GO


CREATE TABLE [dbo].[sync_data_forprocess] (
[objid] varchar(50) NOT NULL ,
CONSTRAINT [pk_sync_data_forprocess] PRIMARY KEY ([objid]) ,
CONSTRAINT [fk_sync_data_forprocess_sync_data] FOREIGN KEY ([objid]) REFERENCES [dbo].[sync_data] ([objid]) 
)
GO

CREATE TABLE [dbo].[sync_data_pending] (
[objid] varchar(50) NOT NULL ,
[error] text NULL ,
[expirydate] datetime NULL ,
CONSTRAINT [pk_sync_data_pending] PRIMARY KEY ([objid]),
CONSTRAINT [fk_sync_data_pending_sync_data] FOREIGN KEY ([objid]) REFERENCES [dbo].[sync_data] ([objid]) 
)
GO
CREATE INDEX [ix_expirydate] ON [dbo].[sync_data_pending]
([expirydate] ASC) 
GO


drop table sys_report_admin
go
drop table sys_report_member
go
drop table sys_report
go
drop table sys_report_folder 
go


CREATE TABLE [dbo].[sys_report_folder] (
[objid] varchar(50) NOT NULL ,
[name] varchar(255) NULL ,
[title] varchar(255) NULL ,
[parentid] varchar(50) NULL ,
CONSTRAINT [pk_sys_report_folder] PRIMARY KEY ([objid])
)
GO

CREATE TABLE [dbo].[sys_report] (
[objid] varchar(50) NOT NULL ,
[folderid] varchar(50) NULL ,
[title] varchar(255) NULL ,
[filetype] varchar(25) NULL ,
[dtcreated] datetime NULL ,
[createdby_objid] varchar(50) NULL ,
[createdby_name] varchar(255) NULL ,
[datasetid] varchar(50) NULL ,
[template] varchar(MAX) NULL ,
[outputtype] varchar(50) NULL ,
[system] int NULL ,
CONSTRAINT [pk_sys_report] PRIMARY KEY ([objid]),
CONSTRAINT [fk_sys_report_datasetid] FOREIGN KEY ([datasetid]) REFERENCES [dbo].[sys_dataset] ([objid]) 
)
GO

CREATE INDEX [FK_sys_report_dataset] ON [dbo].[sys_report]
([datasetid] ASC) 
GO
CREATE INDEX [FK_sys_report_entry_folder] ON [dbo].[sys_report]
([folderid] ASC) 
GO

CREATE TABLE [dbo].[sys_report_member] (
[objid] varchar(50) NOT NULL ,
[reportfolderid] varchar(50) NULL ,
[userid] varchar(50) NULL ,
[usergroupid] varchar(50) NULL ,
[exclude] varchar(MAX) NULL ,
CONSTRAINT [pk_sys_report_member] PRIMARY KEY ([objid]),
CONSTRAINT [fk_sys_report_member_reportfolderid] FOREIGN KEY ([reportfolderid]) REFERENCES [dbo].[sys_report_folder] ([objid]) ,
CONSTRAINT [fk_sys_report_member_usergroupid] FOREIGN KEY ([usergroupid]) REFERENCES [dbo].[sys_usergroup] ([objid]) ,
CONSTRAINT [fk_sys_report_member_userid] FOREIGN KEY ([userid]) REFERENCES [dbo].[sys_user] ([objid]) 
)
GO

CREATE INDEX [FK_sys_report_member_folder] ON [dbo].[sys_report_member]
([reportfolderid] ASC) 
GO
CREATE INDEX [FK_sys_report_member_user] ON [dbo].[sys_report_member]
([userid] ASC) 
GO
CREATE INDEX [FK_sys_report_member_usergroup] ON [dbo].[sys_report_member]
([usergroupid] ASC) 
GO

CREATE TABLE [dbo].[sys_report_admin] (
[objid] varchar(50) NOT NULL ,
[userid] varchar(50) NULL ,
[reportfolderid] varchar(50) NULL ,
[exclude] varchar(MAX) NULL ,
CONSTRAINT [pk_sys_report_admin] PRIMARY KEY ([objid]),
CONSTRAINT [fk_sys_report_admin_reportfolderid] FOREIGN KEY ([reportfolderid]) REFERENCES [dbo].[sys_report_folder] ([objid]) ,
CONSTRAINT [fk_sys_report_admin_userid] FOREIGN KEY ([userid]) REFERENCES [dbo].[sys_user] ([objid]) ON DELETE NO ACTION ON UPDATE NO ACTION
)
GO

CREATE INDEX [FK_sys_report_admin_folder] ON [dbo].[sys_report_admin]
([reportfolderid] ASC) 
GO
CREATE INDEX [FK_sys_report_admin_user] ON [dbo].[sys_report_admin]
([userid] ASC) 
GO


alter table sys_rule_action_param alter column [actiondefparam_objid] varchar(255) NOT NULL
go 

alter table sys_rule_actiondef alter column [actionclass] varchar(255) NULL
go 

alter table sys_rule_actiondef_param alter column [objid] varchar(255) NOT NULL
go 

alter table sys_rule_condition_constraint alter column [field_objid] varchar(255) NULL
go 

alter table sys_rule_fact_field alter column [objid] varchar(255) NOT NULL
go 




if object_id('dbo.sys_user_role', 'V') IS NOT NULL 
  drop view dbo.sys_user_role; 
go 
CREATE VIEW sys_user_role AS 
select  
u.objid AS objid, 
u.lastname AS lastname, 
u.firstname AS firstname, 
u.middlename AS middlename, 
u.username AS username,
(u.lastname +', '+ u.firstname +(case when u.middlename is null then '' else (' '+ u.middlename) end)) AS name, 
ug.role AS role, 
ug.domain AS domain, 
ugm.org_objid AS orgid, 
u.txncode AS txncode, 
u.jobtitle AS jobtitle, 
ugm.objid AS usergroupmemberid, 
ugm.usergroup_objid AS usergroup_objid 
from sys_usergroup_member ugm 
  inner join sys_usergroup ug on ug.objid = ugm.usergroup_objid 
  inner join sys_user u on u.objid = ugm.user_objid 
go 


if object_id('dbo.vw_af_control_detail', 'V') IS NOT NULL 
  drop view dbo.vw_af_control_detail; 
go 
CREATE VIEW vw_af_control_detail AS 
select  
  afd.objid AS objid, 
  afd.state AS state, 
  afd.controlid AS controlid, 
  afd.indexno AS indexno, 
  afd.refid AS refid, 
  afd.aftxnitemid AS aftxnitemid, 
  afd.refno AS refno, 
  afd.reftype AS reftype, 
  afd.refdate AS refdate, 
  afd.txndate AS txndate, 
  afd.txntype AS txntype, 
  afd.receivedstartseries AS receivedstartseries, 
  afd.receivedendseries AS receivedendseries, 
  afd.beginstartseries AS beginstartseries, 
  afd.beginendseries AS beginendseries, 
  afd.issuedstartseries AS issuedstartseries, 
  afd.issuedendseries AS issuedendseries, 
  afd.endingstartseries AS endingstartseries, 
  afd.endingendseries AS endingendseries, 
  afd.qtyreceived AS qtyreceived, 
  afd.qtybegin AS qtybegin, 
  afd.qtyissued AS qtyissued, 
  afd.qtyending AS qtyending, 
  afd.qtycancelled AS qtycancelled, 
  afd.remarks AS remarks, 
  afd.issuedto_objid AS issuedto_objid, 
  afd.issuedto_name AS issuedto_name, 
  afd.respcenter_objid AS respcenter_objid, 
  afd.respcenter_name AS respcenter_name, 
  afd.prevdetailid AS prevdetailid, 
  afd.aftxnid AS aftxnid, 
  afc.afid AS afid, 
  afc.unit AS unit, 
  af.formtype AS formtype, 
  af.denomination AS denomination, 
  af.serieslength AS serieslength, 
  afu.qty AS qty, 
  afu.saleprice AS saleprice, 
  afc.startseries AS startseries, 
  afc.endseries AS endseries, 
  afc.currentseries AS currentseries, 
  afc.stubno AS stubno, 
  afc.prefix AS prefix, 
  afc.suffix AS suffix, 
  afc.cost AS cost, 
  afc.batchno AS batchno, 
  afc.state AS controlstate, 
  afd.qtyending AS qtybalance 
from af_control_detail afd 
  inner join af_control afc on afc.objid = afd.controlid 
  inner join af on af.objid = afc.afid 
  inner join afunit afu on (afu.itemid = af.objid and afu.unit = afc.unit)
go 



if object_id('dbo.vw_af_inventory_summary', 'V') IS NOT NULL 
  drop view dbo.vw_af_inventory_summary; 
go
CREATE VIEW vw_af_inventory_summary AS 
select  
  af.objid AS objid, 
  af.title AS title, 
  u.unit AS unit,
  (select count(0) from af_control where af_control.afid = af.objid and af_control.state in ('OPEN','RETURN')) AS countopen,
  (select count(0) from af_control where af_control.afid = af.objid and af_control.state = 'ISSUED') AS countissued,
  (select count(0) from af_control where af_control.afid = af.objid and af_control.state = 'CLOSED') AS countclosed,
  (select count(0) from af_control where af_control.afid = af.objid and af_control.state = 'SOLD') AS countsold,
  (select count(0) from af_control where af_control.afid = af.objid and af_control.state = 'PROCESSING') AS countprocessing 
from af 
  inner join afunit u on af.objid = u.itemid 
go 


if object_id('dbo.vw_afunit', 'V') IS NOT NULL 
  drop view dbo.vw_afunit; 
go
CREATE VIEW vw_afunit AS 
select  
u.objid AS objid, 
af.title AS title, 
af.usetype AS usetype, 
af.serieslength AS serieslength, 
af.system AS system, 
af.denomination AS denomination, 
af.formtype AS formtype, 
u.itemid AS itemid, 
u.unit AS unit, 
u.qty AS qty, 
u.saleprice AS saleprice, 
u.interval AS interval, 
u.cashreceiptprintout AS cashreceiptprintout, 
u.cashreceiptdetailprintout AS cashreceiptdetailprintout 
from afunit u 
  inner join af on af.objid = u.itemid
go 


if object_id('dbo.vw_cashreceipt_itemaccount', 'V') IS NOT NULL 
  drop view dbo.vw_cashreceipt_itemaccount; 
go
CREATE VIEW vw_cashreceipt_itemaccount AS 
select  
  itemaccount.objid AS objid, 
  itemaccount.state AS state, 
  itemaccount.code AS code, 
  itemaccount.title AS title, 
  itemaccount.description AS description, 
  itemaccount.type AS type, 
  itemaccount.fund_objid AS fund_objid, 
  itemaccount.fund_code AS fund_code, 
  itemaccount.fund_title AS fund_title, 
  itemaccount.defaultvalue AS defaultvalue, 
  itemaccount.valuetype AS valuetype, 
  itemaccount.sortorder AS sortorder, 
  itemaccount.org_objid AS orgid, 
  itemaccount.hidefromlookup AS hidefromlookup 
from itemaccount 
where itemaccount.state = 'ACTIVE' 
  and itemaccount.type in ('REVENUE','NONREVENUE','PAYABLE') 
  and isnull(itemaccount.generic,0) = 0 
go 


if object_id('dbo.vw_cashreceipt_itemaccount_collectiontype', 'V') IS NOT NULL 
  drop view dbo.vw_cashreceipt_itemaccount_collectiontype; 
go
CREATE VIEW vw_cashreceipt_itemaccount_collectiontype AS 
select  
  ia.objid AS objid, 
  ia.state AS state, 
  ia.code AS code, 
  ia.title AS title, 
  ia.description AS description, 
  ia.type AS type, 
  ia.fund_objid AS fund_objid, 
  ia.fund_code AS fund_code, 
  ia.fund_title AS fund_title, 
  ca.defaultvalue AS defaultvalue,
  (case when ca.valuetype is null then 'ANY' else ca.valuetype end) AS valuetype,
  (case when ca.sortorder is null then 0 else ca.sortorder end) AS sortorder,
  NULL AS orgid, 
  ca.collectiontypeid AS collectiontypeid, 0 AS hasorg, 
  ia.hidefromlookup AS hidefromlookup 
from collectiontype ct 
  inner join collectiontype_account ca on ca.collectiontypeid = ct.objid 
  inner join itemaccount ia on ia.objid = ca.account_objid 
  left join collectiontype_org o on o.collectiontypeid = ca.objid 
where o.objid is null 
  and ia.state = 'ACTIVE' 
  and ia.type in ('REVENUE','NONREVENUE','PAYABLE') 
union all 
select  
  ia.objid AS objid, 
  ia.state AS state, 
  ia.code AS code, 
  ia.title AS title, 
  ia.description AS description, 
  ia.type AS type, 
  ia.fund_objid AS fund_objid, 
  ia.fund_code AS fund_code, 
  ia.fund_title AS fund_title, 
  ca.defaultvalue AS defaultvalue,
  (case when ca.valuetype is null then 'ANY' else ca.valuetype end) AS valuetype,
  (case when ca.sortorder is null then 0 else ca.sortorder end) AS sortorder, 
  o.org_objid AS orgid, 
  ca.collectiontypeid AS collectiontypeid, 1 AS hasorg, 
  ia.hidefromlookup AS hidefromlookup 
from collectiontype ct 
  inner join collectiontype_org o on o.collectiontypeid = ct.objid 
  inner join collectiontype_account ca on ca.collectiontypeid = ct.objid 
  inner join itemaccount ia on ia.objid = ca.account_objid 
where ia.state = 'ACTIVE' 
  and ia.type in ('REVENUE','NONREVENUE','PAYABLE')
go 


if object_id('dbo.vw_cashreceiptpayment_noncash', 'V') IS NOT NULL 
  drop view dbo.vw_cashreceiptpayment_noncash; 
go
CREATE VIEW vw_cashreceiptpayment_noncash AS 
select  
  nc.objid AS objid, 
  nc.receiptid AS receiptid, 
  nc.refno AS refno, 
  nc.refdate AS refdate, 
  nc.reftype AS reftype, 
  nc.amount AS amount, 
  nc.particulars AS particulars, 
  nc.account_objid AS account_objid, 
  nc.account_code AS account_code, 
  nc.account_name AS account_name, 
  nc.account_fund_objid AS account_fund_objid, 
  nc.account_fund_name AS account_fund_name, 
  nc.account_bank AS account_bank, 
  nc.fund_objid AS fund_objid, 
  nc.refid AS refid, 
  nc.checkid AS checkid, 
  nc.voidamount AS voidamount, 
  v.objid AS void_objid,
  (case when v.objid is null then 0 else 1 end) AS voided, 
  c.receiptno AS receipt_receiptno, 
  c.receiptdate AS receipt_receiptdate, 
  c.amount AS receipt_amount, 
  c.collector_objid AS receipt_collector_objid, 
  c.collector_name AS receipt_collector_name, 
  c.remittanceid AS remittanceid, 
  rem.objid AS remittance_objid, 
  rem.controlno AS remittance_controlno, 
  rem.controldate AS remittance_controldate 
from cashreceiptpayment_noncash nc 
  inner join cashreceipt c on c.objid = nc.receiptid 
  left join cashreceipt_void v on v.receiptid = c.objid 
  left join remittance rem on rem.objid = c.remittanceid 
go 


if object_id('dbo.vw_cashreceiptpayment_noncash_liquidated', 'V') IS NOT NULL 
  drop view dbo.vw_cashreceiptpayment_noncash_liquidated; 
go
CREATE VIEW vw_cashreceiptpayment_noncash_liquidated AS 
select  
  nc.objid AS objid, 
  nc.receiptid AS receiptid, 
  nc.refno AS refno, 
  nc.refdate AS refdate, 
  nc.reftype AS reftype, 
  nc.amount AS amount, 
  nc.particulars AS particulars, 
  nc.account_objid AS account_objid, 
  nc.account_code AS account_code, 
  nc.account_name AS account_name, 
  nc.account_fund_objid AS account_fund_objid, 
  nc.account_fund_name AS account_fund_name, 
  nc.account_bank AS account_bank, 
  nc.fund_objid AS fund_objid, 
  nc.refid AS refid, 
  nc.checkid AS checkid, 
  nc.voidamount AS voidamount, 
  v.objid AS void_objid, 
  (case when v.objid is null then 0 else 1 end) AS voided, 
  c.receiptno AS receipt_receiptno, 
  c.receiptdate AS receipt_receiptdate, 
  c.amount AS receipt_amount, 
  c.collector_objid AS receipt_collector_objid, 
  c.collector_name AS receipt_collector_name, 
  c.remittanceid AS remittanceid, 
  r.objid AS remittance_objid, 
  r.controlno AS remittance_controlno, 
  r.controldate AS remittance_controldate, 
  r.collectionvoucherid AS collectionvoucherid, 
  cv.objid AS collectionvoucher_objid, 
  cv.controlno AS collectionvoucher_controlno, 
  cv.controldate AS collectionvoucher_controldate, 
  cv.depositvoucherid AS depositvoucherid 
from collectionvoucher cv 
  inner join remittance r on r.collectionvoucherid = cv.objid 
  inner join cashreceipt c on c.remittanceid = r.objid 
  inner join cashreceiptpayment_noncash nc on nc.receiptid = c.objid 
  left join cashreceipt_void v on v.receiptid = c.objid
go 


if object_id('dbo.vw_collectiongroup', 'V') IS NOT NULL 
  drop view dbo.vw_collectiongroup; 
go
CREATE VIEW vw_collectiongroup AS 
select  
  cg.objid AS objid, 
  cg.name AS name, 
  cg.sharing AS sharing, 
  NULL AS orgid 
from collectiongroup cg 
  left join collectiongroup_org co on co.collectiongroupid = cg.objid 
where cg.state = 'ACTIVE' 
  and co.objid is null 
union 
select  
  cg.objid AS objid, 
  cg.name AS name, 
  cg.sharing AS sharing, 
  co.org_objid AS orgid 
from collectiongroup cg 
  inner join collectiongroup_org co on co.collectiongroupid = cg.objid 
where cg.state = 'ACTIVE'
go 


if object_id('dbo.vw_collectiontype', 'V') IS NOT NULL 
  drop view dbo.vw_collectiontype; 
go
CREATE VIEW vw_collectiontype AS 
select  
  c.objid AS objid, 
  c.state AS state, 
  c.name AS name, 
  c.title AS title, 
  c.formno AS formno, 
  c.handler AS handler, 
  c.allowbatch AS allowbatch, 
  c.barcodekey AS barcodekey, 
  c.allowonline AS allowonline, 
  c.allowoffline AS allowoffline, 
  c.sortorder AS sortorder, 
  o.org_objid AS orgid, 
  c.fund_objid AS fund_objid, 
  c.fund_title AS fund_title, 
  c.category AS category, 
  c.queuesection AS queuesection, 
  c.system AS system, 
  af.formtype AS af_formtype, 
  af.serieslength AS af_serieslength, 
  af.denomination AS af_denomination, 
  af.baseunit AS af_baseunit, 
  c.allowpaymentorder AS allowpaymentorder, 
  c.allowkiosk AS allowkiosk, 
  c.allowcreditmemo AS allowcreditmemo 
from collectiontype_org o 
  inner join collectiontype c on c.objid = o.collectiontypeid 
  inner join af on af.objid = c.formno 
where c.state = 'ACTIVE' 
union 
select  
  c.objid AS objid, 
  c.state AS state, 
  c.name AS name, 
  c.title AS title, 
  c.formno AS formno, 
  c.handler AS handler, 
  c.allowbatch AS allowbatch, 
  c.barcodekey AS barcodekey, 
  c.allowonline AS allowonline, 
  c.allowoffline AS allowoffline, 
  c.sortorder AS sortorder,NULL AS orgid, 
  c.fund_objid AS fund_objid, 
  c.fund_title AS fund_title, 
  c.category AS category, 
  c.queuesection AS queuesection, 
  c.system AS system, 
  af.formtype AS af_formtype, 
  af.serieslength AS af_serieslength, 
  af.denomination AS af_denomination, 
  af.baseunit AS af_baseunit, 
  c.allowpaymentorder AS allowpaymentorder, 
  c.allowkiosk AS allowkiosk, 
  c.allowcreditmemo AS allowcreditmemo 
from collectiontype c 
  inner join af on af.objid = c.formno 
  left join collectiontype_org o on c.objid = o.collectiontypeid 
where c.state = 'ACTIVE' 
  and o.objid is null 
go 



if object_id('dbo.vw_collectiontype_account', 'V') IS NOT NULL 
  drop view dbo.vw_collectiontype_account; 
go
CREATE VIEW vw_collectiontype_account AS 
select  
  ia.objid AS objid, 
  ia.code AS code, 
  ia.title AS title, 
  ia.fund_objid AS fund_objid, 
  fund.code AS fund_code, 
  fund.title AS fund_title, 
  cta.collectiontypeid AS collectiontypeid, 
  cta.tag AS tag, 
  cta.valuetype AS valuetype, 
  cta.defaultvalue AS defaultvalue 
from collectiontype_account cta 
  inner join itemaccount ia on ia.objid = cta.account_objid 
  inner join fund on fund.objid = ia.fund_objid 
go 


if object_id('dbo.vw_remittance_cashreceipt', 'V') IS NOT NULL 
  drop view dbo.vw_remittance_cashreceipt; 
go
CREATE VIEW vw_remittance_cashreceipt AS 
select  
  r.objid AS remittance_objid, 
  r.controldate AS remittance_controldate, 
  r.controlno AS remittance_controlno, 
  c.remittanceid AS remittanceid, 
  r.collectionvoucherid AS collectionvoucherid, 
  c.controlid AS controlid, 
  af.formtype AS formtype, 
  (case when af.formtype = 'serial' then 0 else 1 end) AS formtypeindexno, 
  c.formno AS formno, 
  c.stub AS stubno, 
  c.series AS series, 
  c.receiptno AS receiptno, 
  c.receiptdate AS receiptdate, 
  c.amount AS amount, 
  c.totalnoncash AS totalnoncash,
  (c.amount - c.totalnoncash) AS totalcash,
  (case when v.objid is null then 0 else 1 end) AS voided, 
  (case when v.objid is null then 0 else c.amount end) AS voidamount, 
  c.paidby AS paidby, 
  c.paidbyaddress AS paidbyaddress, 
  c.payer_objid AS payer_objid, 
  c.payer_name AS payer_name, 
  c.collector_objid AS collector_objid, 
  c.collector_name AS collector_name, 
  c.collector_title AS collector_title, 
  c.objid AS receiptid, 
  c.collectiontype_objid AS collectiontype_objid, 
  c.org_objid AS org_objid 
from remittance r 
  inner join cashreceipt c on c.remittanceid = r.objid 
  inner join af on af.objid = c.formno 
  left join cashreceipt_void v on v.receiptid = c.objid 
go 



if object_id('dbo.vw_remittance_cashreceipt_af', 'V') IS NOT NULL 
  drop view dbo.vw_remittance_cashreceipt_af; 
go
CREATE VIEW vw_remittance_cashreceipt_af AS 
select  
  cr.remittanceid AS remittanceid, 
  cr.collector_objid AS collector_objid, 
  cr.controlid AS controlid,
  min(cr.receiptno) AS fromreceiptno,
  max(cr.receiptno) AS toreceiptno,
  min(cr.series) AS fromseries,
  max(cr.series) AS toseries,
  count(cr.objid) AS qty,
  sum(cr.amount) AS amount, 0 AS qtyvoided, 
  0.0 AS voidamt,0 AS qtycancelled, 0.0 AS cancelledamt, 
  af.formtype AS formtype, 
  af.serieslength AS serieslength, 
  af.denomination AS denomination, 
  cr.formno AS formno, 
  afc.stubno AS stubno, 
  afc.startseries AS startseries, 
  afc.endseries AS endseries, 
  afc.prefix AS prefix, 
  afc.suffix AS suffix 
from cashreceipt cr join remittance rem on rem.objid = cr.remittanceid 
  inner join af_control afc on cr.controlid = afc.objid 
  inner join af on afc.afid = af.objid 
group by 
  cr.remittanceid,cr.collector_objid,cr.controlid,af.formtype,
  af.serieslength,af.denomination,cr.formno,afc.stubno,
  afc.startseries,afc.endseries,afc.prefix,afc.suffix 
union all 
select  
  cr.remittanceid AS remittanceid, 
  cr.collector_objid AS collector_objid, 
  cr.controlid AS controlid, 
  NULL AS fromreceiptno, NULL AS toreceiptno, 
  NULL AS fromseries, NULL AS toseries, 
  0 AS qty, 0.0 AS amount, 
  count(cr.objid) AS qtyvoided, 
  sum(cr.amount) AS voidamt, 
  0 AS qtycancelled, 
  0.0 AS cancelledamt, 
  af.formtype AS formtype, 
  af.serieslength AS serieslength, 
  af.denomination AS denomination, 
  cr.formno AS formno, 
  afc.stubno AS stubno, 
  afc.startseries AS startseries, 
  afc.endseries AS endseries, 
  afc.prefix AS prefix, 
  afc.suffix AS suffix 
from cashreceipt cr 
  inner join cashreceipt_void cv on cv.receiptid = cr.objid 
  inner join remittance rem on rem.objid = cr.remittanceid 
  inner join af_control afc on cr.controlid = afc.objid 
  inner join af on afc.afid = af.objid 
group by 
  cr.remittanceid,cr.collector_objid,cr.controlid,af.formtype,
  af.serieslength,af.denomination,cr.formno,afc.stubno,
  afc.startseries,afc.endseries,afc.prefix,afc.suffix 
union all 
select  
  cr.remittanceid AS remittanceid, 
  cr.collector_objid AS collector_objid, 
  cr.controlid AS controlid,
  NULL AS fromreceiptno, NULL AS toreceiptno, 
  NULL AS fromseries, NULL AS toseries, 
  0 AS qty, 0.0 AS amount, 0 AS qtyvoided, 
  0.0 AS voidamt, count(cr.objid) AS qtycancelled, 
  sum(cr.amount) AS cancelledamt, 
  af.formtype AS formtype, 
  af.serieslength AS serieslength, 
  af.denomination AS denomination, 
  cr.formno AS formno, 
  afc.stubno AS stubno, 
  afc.startseries AS startseries, 
  afc.endseries AS endseries, 
  afc.prefix AS prefix, 
  afc.suffix AS suffix 
from cashreceipt cr 
  inner join remittance rem on rem.objid = cr.remittanceid 
  inner join af_control afc on cr.controlid = afc.objid 
  inner join af on afc.afid = af.objid 
where cr.state = 'CANCELLED' 
group by 
  cr.remittanceid,cr.collector_objid,cr.controlid,af.formtype,
  af.serieslength,af.denomination,cr.formno,afc.stubno,
  afc.startseries,afc.endseries,afc.prefix,afc.suffix
go 


if object_id('dbo.vw_remittance_cashreceipt_afsummary', 'V') IS NOT NULL 
  drop view dbo.vw_remittance_cashreceipt_afsummary; 
go
CREATE VIEW vw_remittance_cashreceipt_afsummary AS 
select 
  (v.remittanceid +'|'+ v.collector_objid +'|'+ v.controlid) AS objid, 
  v.remittanceid AS remittanceid, 
  v.collector_objid AS collector_objid, 
  v.controlid AS controlid, 
  min(v.fromreceiptno) AS fromreceiptno, max(v.toreceiptno) AS toreceiptno, 
  min(v.fromseries) AS fromseries, max(v.toseries) AS toseries, 
  sum(v.qty) AS qty, sum(v.amount) AS amount, 
  sum(v.qtyvoided) AS qtyvoided, sum(v.voidamt) AS voidamt, 
  sum(v.qtycancelled) AS qtycancelled, sum(v.cancelledamt) AS cancelledamt, 
  v.formtype AS formtype, 
  v.serieslength AS serieslength, 
  v.denomination AS denomination, 
  v.formno AS formno, 
  v.stubno AS stubno, 
  v.startseries AS startseries, 
  v.endseries AS endseries, 
  v.prefix AS prefix, 
  v.suffix AS suffix 
from vw_remittance_cashreceipt_af v 
group by 
  v.remittanceid,v.collector_objid,v.controlid,v.formtype,
  v.serieslength,v.denomination,v.formno,v.stubno,
  v.startseries,v.endseries,v.prefix,v.suffix
go 


if object_id('dbo.vw_remittance_cashreceiptitem', 'V') IS NOT NULL 
  drop view dbo.vw_remittance_cashreceiptitem; 
go
CREATE VIEW vw_remittance_cashreceiptitem AS 
select  
  c.remittanceid AS remittanceid, 
  r.controldate AS remittance_controldate, 
  r.controlno AS remittance_controlno, 
  r.collectionvoucherid AS collectionvoucherid, 
  c.collectiontype_objid AS collectiontype_objid, 
  c.collectiontype_name AS collectiontype_name, 
  c.org_objid AS org_objid, 
  c.org_name AS org_name, 
  c.formtype AS formtype, 
  c.formno AS formno, 
  (case when c.formtype = 'serial' then 0 else 1 end) AS formtypeindex, 
  cri.receiptid AS receiptid, 
  c.receiptdate AS receiptdate, 
  c.receiptno AS receiptno, 
  c.paidby AS paidby, 
  c.paidbyaddress AS paidbyaddress, 
  c.collector_objid AS collectorid, 
  c.collector_name AS collectorname, 
  c.collector_title AS collectortitle, 
  cri.item_fund_objid AS fundid, 
  cri.item_objid AS acctid, 
  cri.item_code AS acctcode, 
  cri.item_title AS acctname, 
  cri.remarks AS remarks, 
  (case when v.objid is null then cri.amount else 0.0 end) AS amount,
  (case when v.objid is null then 0 else 1 end) AS voided,
  (case when v.objid is null then 0.0 else cri.amount end) AS voidamount 
from remittance r 
  inner join cashreceipt c on c.remittanceid = r.objid 
  inner join cashreceiptitem cri on cri.receiptid = c.objid 
  left join cashreceipt_void v on v.receiptid = c.objid
go 


if object_id('dbo.vw_remittance_cashreceiptpayment_noncash', 'V') IS NOT NULL 
  drop view dbo.vw_remittance_cashreceiptpayment_noncash; 
go
CREATE VIEW vw_remittance_cashreceiptpayment_noncash AS 
select  
  nc.objid AS objid, 
  nc.receiptid AS receiptid, 
  nc.refno AS refno, 
  nc.refdate AS refdate, 
  nc.reftype AS reftype, 
  nc.particulars AS particulars, 
  nc.refid AS refid, 
  nc.amount AS amount, 
  (case when v.objid is null then 0 else 1 end) AS voided, 
  (case when v.objid is null then 0.0 else nc.amount end) AS voidamount, 
  cp.bankid AS bankid, 
  cp.bank_name AS bank_name, 
  c.remittanceid AS remittanceid, 
  r.collectionvoucherid AS collectionvoucherid 
from remittance r 
  inner join cashreceipt c on c.remittanceid = r.objid 
  inner join cashreceiptpayment_noncash nc on (nc.receiptid = c.objid and nc.reftype = 'CHECK') 
  inner join checkpayment cp on cp.objid = nc.refid 
  left join cashreceipt_void v on v.receiptid = c.objid 
union all 
select  
  nc.objid AS objid, 
  nc.receiptid AS receiptid, 
  nc.refno AS refno, 
  nc.refdate AS refdate,'EFT' AS reftype, 
  nc.particulars AS particulars, 
  nc.refid AS refid, 
  nc.amount AS amount, 
  (case when v.objid is null then 0 else 1 end) AS voided, 
  (case when v.objid is null then 0.0 else nc.amount end) AS voidamount, 
  ba.bank_objid AS bankid, 
  ba.bank_name AS bank_name, 
  c.remittanceid AS remittanceid, 
  r.collectionvoucherid AS collectionvoucherid 
from remittance r 
  inner join cashreceipt c on c.remittanceid = r.objid 
  inner join cashreceiptpayment_noncash nc on (nc.receiptid = c.objid and nc.reftype = 'EFT') 
  inner join eftpayment eft on eft.objid = nc.refid 
  inner join bankaccount ba on ba.objid = eft.bankacctid 
  left join cashreceipt_void v on v.receiptid = c.objid 
go 


if object_id('dbo.vw_remittance_cashreceiptshare', 'V') IS NOT NULL 
  drop view dbo.vw_remittance_cashreceiptshare; 
go
CREATE VIEW vw_remittance_cashreceiptshare AS 
select 
  c.remittanceid AS remittanceid,
  r.controldate AS remittance_controldate,
  r.controlno AS remittance_controlno,
  r.collectionvoucherid AS collectionvoucherid,
  c.formno AS formno,
  c.formtype AS formtype,
  cs.receiptid AS receiptid,
  c.receiptdate AS receiptdate,
  c.receiptno AS receiptno,
  c.paidby AS paidby,
  c.paidbyaddress AS paidbyaddress,
  c.org_objid AS org_objid,
  c.org_name AS org_name,
  c.collectiontype_objid AS collectiontype_objid,
  c.collectiontype_name AS collectiontype_name,
  c.collector_objid AS collectorid,
  c.collector_name AS collectorname,
  c.collector_title AS collectortitle,
  cs.refitem_objid AS refacctid,
  ia.fund_objid AS fundid,
  ia.objid AS acctid,
  ia.code AS acctcode,
  ia.title AS acctname,
  (case when v.objid is null then cs.amount else 0.0 end) AS amount, 
  (case when v.objid is null then 0 else 1 end) AS voided, 
  (case when v.objid is null then 0.0 else cs.amount end) AS voidamount 
from remittance r 
  inner join cashreceipt c on c.remittanceid = r.objid 
  inner join cashreceipt_share cs on cs.receiptid = c.objid 
  inner join itemaccount ia on ia.objid = cs.payableitem_objid 
  left join cashreceipt_void v on v.receiptid = c.objid 
go 


if object_id('dbo.vw_collectionvoucher_cashreceiptitem', 'V') IS NOT NULL 
  drop view dbo.vw_collectionvoucher_cashreceiptitem; 
go
CREATE VIEW vw_collectionvoucher_cashreceiptitem AS 
select  
  cv.controldate AS collectionvoucher_controldate, 
  cv.controlno AS collectionvoucher_controlno, 
  v.remittanceid AS remittanceid, 
  v.remittance_controldate AS remittance_controldate, 
  v.remittance_controlno AS remittance_controlno, 
  v.collectionvoucherid AS collectionvoucherid, 
  v.collectiontype_objid AS collectiontype_objid, 
  v.collectiontype_name AS collectiontype_name, 
  v.org_objid AS org_objid, 
  v.org_name AS org_name, 
  v.formtype AS formtype, 
  v.formno AS formno, 
  v.formtypeindex AS formtypeindex, 
  v.receiptid AS receiptid, 
  v.receiptdate AS receiptdate, 
  v.receiptno AS receiptno, 
  v.paidby AS paidby, 
  v.paidbyaddress AS paidbyaddress, 
  v.collectorid AS collectorid, 
  v.collectorname AS collectorname, 
  v.collectortitle AS collectortitle, 
  v.fundid AS fundid, 
  v.acctid AS acctid, 
  v.acctcode AS acctcode, 
  v.acctname AS acctname, 
  v.amount AS amount, 
  v.voided AS voided, 
  v.voidamount AS voidamount 
from collectionvoucher cv 
  inner join vw_remittance_cashreceiptitem v on v.collectionvoucherid = cv.objid 
go 


if object_id('dbo.vw_collectionvoucher_cashreceiptshare', 'V') IS NOT NULL 
  drop view dbo.vw_collectionvoucher_cashreceiptshare; 
go
CREATE VIEW vw_collectionvoucher_cashreceiptshare AS 
select 
  cv.controldate AS collectionvoucher_controldate,
  cv.controlno AS collectionvoucher_controlno,
  v.remittanceid AS remittanceid,
  v.remittance_controldate AS remittance_controldate,
  v.remittance_controlno AS remittance_controlno,
  v.collectionvoucherid AS collectionvoucherid,
  v.formno AS formno,
  v.formtype AS formtype,
  v.receiptid AS receiptid,
  v.receiptdate AS receiptdate,
  v.receiptno AS receiptno,
  v.paidby AS paidby,
  v.paidbyaddress AS paidbyaddress,
  v.org_objid AS org_objid,
  v.org_name AS org_name,
  v.collectiontype_objid AS collectiontype_objid,
  v.collectiontype_name AS collectiontype_name,
  v.collectorid AS collectorid,
  v.collectorname AS collectorname,
  v.collectortitle AS collectortitle,
  v.refacctid AS refacctid,
  v.fundid AS fundid,
  v.acctid AS acctid,
  v.acctcode AS acctcode,
  v.acctname AS acctname,
  v.amount AS amount,
  v.voided AS voided,
  v.voidamount AS voidamount 
from collectionvoucher cv 
  inner join vw_remittance_cashreceiptshare v on v.collectionvoucherid = cv.objid 
go 


if object_id('dbo.vw_deposit_fund_transfer', 'V') IS NOT NULL 
  drop view dbo.vw_deposit_fund_transfer; 
go
CREATE VIEW vw_deposit_fund_transfer AS 
select  
  dft.objid AS objid, 
  dft.amount AS amount, 
  dft.todepositvoucherfundid AS todepositvoucherfundid, 
  tof.objid AS todepositvoucherfund_fund_objid, 
  tof.code AS todepositvoucherfund_fund_code, 
  tof.title AS todepositvoucherfund_fund_title, 
  dft.fromdepositvoucherfundid AS fromdepositvoucherfundid, 
  fromf.objid AS fromdepositvoucherfund_fund_objid, 
  fromf.code AS fromdepositvoucherfund_fund_code, 
  fromf.title AS fromdepositvoucherfund_fund_title 
from deposit_fund_transfer dft 
  inner join depositvoucher_fund todv on dft.todepositvoucherfundid = todv.objid 
  inner join fund tof on todv.fundid = tof.objid 
  inner join depositvoucher_fund fromdv on dft.fromdepositvoucherfundid = fromdv.objid 
  inner join fund fromf on fromdv.fundid = fromf.objid 
go  


if object_id('dbo.vw_entityindividual', 'V') IS NOT NULL 
  drop view dbo.vw_entityindividual; 
go
CREATE VIEW vw_entityindividual AS 
select  
  ei.objid AS objid, 
  ei.lastname AS lastname, 
  ei.firstname AS firstname, 
  ei.middlename AS middlename, 
  ei.birthdate AS birthdate, 
  ei.birthplace AS birthplace, 
  ei.citizenship AS citizenship, 
  ei.gender AS gender, 
  ei.civilstatus AS civilstatus, 
  ei.profession AS profession, 
  ei.tin AS tin, 
  ei.sss AS sss, 
  ei.height AS height, 
  ei.weight AS weight, 
  ei.acr AS acr, 
  ei.religion AS religion, 
  ei.photo AS photo, 
  ei.thumbnail AS thumbnail, 
  ei.profileid AS profileid, 
  e.entityno AS entityno, 
  e.type AS type, 
  e.name AS name, 
  e.entityname AS entityname, 
  e.mobileno AS mobileno, 
  e.phoneno AS phoneno, 
  e.address_objid AS address_objid, 
  e.address_text AS address_text 
from entityindividual ei 
  inner join entity e on e.objid = ei.objid 
go 


if object_id('dbo.vw_entity_relation', 'V') IS NOT NULL 
  drop view dbo.vw_entity_relation; 
go
CREATE VIEW vw_entity_relation AS 
select  
  er.objid AS objid, 
  er.entity_objid AS ownerid, 
  ei.objid AS entityid, 
  ei.entityno AS entityno, 
  ei.name AS name, 
  ei.firstname AS firstname, 
  ei.lastname AS lastname, 
  ei.middlename AS middlename, 
  ei.birthdate AS birthdate, 
  ei.gender AS gender, 
  er.relation_objid AS relationship 
from entity_relation er 
  inner join vw_entityindividual ei on er.relateto_objid = ei.objid 
union all 
select  
  er.objid AS objid, 
  er.relateto_objid AS ownerid, 
  ei.objid AS entityid, 
  ei.entityno AS entityno, 
  ei.name AS name, 
  ei.firstname AS firstname, 
  ei.lastname AS lastname, 
  ei.middlename AS middlename, 
  ei.birthdate AS birthdate, 
  ei.gender AS gender, 
  (case 
    when ei.gender = 'M' then et.inverse_male 
    when ei.gender = 'F' then et.inverse_female 
    else et.inverse_any 
  end) AS relationship 
from entity_relation er 
  inner join vw_entityindividual ei on er.entity_objid = ei.objid 
  inner join entity_relation_type et on er.relation_objid = et.objid
go 



if object_id('dbo.vw_entityindividual_lookup', 'V') IS NOT NULL 
  drop view dbo.vw_entityindividual_lookup; 
go
CREATE VIEW vw_entityindividual_lookup AS 
select  
  e.objid AS objid, 
  e.entityno AS entityno, 
  e.name AS name, 
  e.address_text AS addresstext, 
  e.type AS type, 
  ei.lastname AS lastname, 
  ei.firstname AS firstname, 
  ei.middlename AS middlename, 
  ei.gender AS gender, 
  ei.birthdate AS birthdate, 
  e.mobileno AS mobileno, 
  e.phoneno AS phoneno 
from entity e 
  inner join entityindividual ei on ei.objid = e.objid 
go 


if object_id('dbo.vw_entityrelation_lookup', 'V') IS NOT NULL 
  drop view dbo.vw_entityrelation_lookup; 
go
CREATE VIEW vw_entityrelation_lookup AS 
select  
  er.objid AS objid, 
  er.entity_objid AS entity_objid, 
  er.relateto_objid AS relateto_objid, 
  er.relation_objid AS relation_objid, 
  e.entityno AS entityno, 
  e.name AS name, 
  e.address_text AS addresstext, 
  e.type AS type, 
  ei.lastname AS lastname, 
  ei.firstname AS firstname, 
  ei.middlename AS middlename, 
  ei.gender AS gender, 
  ei.birthdate AS birthdate, 
  e.mobileno AS mobileno, 
  e.phoneno AS phoneno 
from entity_relation er 
  inner join entityindividual ei on ei.objid = er.relateto_objid 
  inner join entity e on e.objid = ei.objid 
go 


if object_id('dbo.vw_income_ledger', 'V') IS NOT NULL 
  drop view dbo.vw_income_ledger; 
go
CREATE VIEW vw_income_ledger AS 
select  
  year(jev.jevdate) AS year, 
  month(jev.jevdate) AS  month,
  jev.fundid AS  fundid,
  l.itemacctid AS  itemacctid,
  l.cr AS  amount, 
  l.jevid AS  jevid,
  l.objid AS objid 
from income_ledger l 
  inner join jev on jev.objid = l.jevid 
union all 
select  
  year(jev.jevdate) AS year, 
  month(jev.jevdate) AS month, 
  jev.fundid AS fundid, 
  l.refitemacctid AS itemacctid, 
  (l.cr - l.dr) AS amount, 
  l.jevid AS  jevid, 
  l.objid AS objid 
from payable_ledger l 
  inner join jev on jev.objid = l.jevid 
go 



if object_id('dbo.vw_account_item_mapping', 'V') IS NOT NULL 
  drop view dbo.vw_account_item_mapping; 
go
CREATE VIEW vw_account_item_mapping AS 
select  
  a.objid AS objid, 
  a.maingroupid AS maingroupid, 
  a.code AS code, 
  a.title AS title, 
  a.groupid AS groupid, 
  a.type AS type, 
  a.leftindex AS leftindex, 
  a.rightindex AS rightindex, 
  a.level AS level, 
  l.amount AS amount, 
  l.fundid AS fundid, 
  l.year AS year, 
  l.month AS month, 
  aim.itemid AS itemid, 
  ia.code AS itemcode, 
  ia.title AS itemtitle 
from account_item_mapping aim 
  inner join account a on a.objid = aim.acctid 
  inner join itemaccount ia on ia.objid = aim.itemid 
  inner join vw_income_ledger l on l.itemacctid = aim.itemid 
go 


if object_id('dbo.vw_account_income_summary', 'V') IS NOT NULL 
  drop view dbo.vw_account_income_summary; 
go
CREATE VIEW vw_account_income_summary AS 
select  
  a.objid AS objid, 
  a.maingroupid AS maingroupid, 
  a.code AS code, 
  a.title AS title, 
  a.groupid AS groupid, 
  a.type AS type, 
  a.leftindex AS leftindex, 
  a.rightindex AS rightindex, 
  a.level AS level, 
  inc.amount AS amount, 
  inc.acctid AS acctid, 
  inc.fundid AS fundid, 
  inc.collectorid AS collectorid, 
  inc.refdate AS refdate, 
  inc.remittancedate AS remittancedate, 
  inc.liquidationdate AS liquidationdate, 
  ia.type AS accttype 
from account_item_mapping aim 
  inner join account a on a.objid = aim.acctid 
  inner join itemaccount ia on ia.objid = aim.itemid 
  inner join income_summary inc on inc.acctid = ia.objid 
go 


if object_id('dbo.vw_cashreceipt_itemaccount_collectiongroup', 'V') IS NOT NULL 
  drop view dbo.vw_cashreceipt_itemaccount_collectiongroup; 
go 
CREATE VIEW vw_cashreceipt_itemaccount_collectiongroup AS 
select  
  ia.objid AS objid, 
  ia.state AS state, 
  ia.code AS code, 
  ia.title AS title, 
  ia.description AS description, 
  ia.type AS type, 
  ia.fund_objid AS fund_objid, 
  ia.fund_code AS fund_code, 
  ia.fund_title AS fund_title,
  (case when ca.defaultvalue = 0 then ia.defaultvalue else ca.defaultvalue end) AS defaultvalue,
  (case when ca.defaultvalue = 0 then ia.valuetype else ca.valuetype end) AS valuetype, 
  ca.sortorder AS sortorder, 
  ia.org_objid AS orgid, 
  ca.collectiongroupid AS collectiongroupid, 
  ia.generic AS generic 
from collectiongroup_account ca 
  inner join itemaccount ia on ia.objid = ca.account_objid 
go 


if object_id('dbo.vw_cashbook_cashreceipt', 'V') IS NOT NULL 
  drop view dbo.vw_cashbook_cashreceipt; 
go
CREATE VIEW vw_cashbook_cashreceipt AS select  
  c.objid AS objid, 
  c.txndate AS txndate,
  cast(c.receiptdate as date) AS refdate, 
  c.objid AS refid, 
  c.receiptno AS refno,'cashreceipt' AS reftype,
  (ct.name +' ('+ c.paidby +')') AS particulars, 
  ci.item_fund_objid AS fundid, 
  c.collector_objid AS collectorid, 
  ci.amount AS dr,0.0 AS cr, 
  c.formno AS formno, 
  c.formtype AS formtype, 
  c.series AS series, 
  c.controlid AS controlid, 
  c.txndate AS sortdate, 
  c.receiptdate AS receiptdate, 
  c.objid AS receiptid 
from cashreceipt c 
  inner join collectiontype ct on ct.objid = c.collectiontype_objid
  inner join cashreceiptitem ci on ci.receiptid = c.objid
go 


if object_id('dbo.vw_cashbook_cashreceipt_share', 'V') IS NOT NULL 
  drop view dbo.vw_cashbook_cashreceipt_share; 
go
CREATE VIEW vw_cashbook_cashreceipt_share AS 
select  
  c.objid AS objid, 
  c.txndate AS txndate,
  cast(c.receiptdate as date) AS refdate, 
  c.objid AS refid, 
  c.receiptno AS refno,'cashreceipt' AS reftype,
  (ct.name +' ('+ c.paidby +')') AS particulars, 
  ia.fund_objid AS fundid, 
  c.collector_objid AS collectorid, 
  cs.amount AS dr,0.0 AS cr, 
  c.formno AS formno, 
  c.formtype AS formtype, 
  c.series AS series, 
  c.controlid AS controlid, 
  c.txndate AS sortdate, 
  c.receiptdate AS receiptdate, 
  c.objid AS receiptid, 
  cs.refitem_objid AS refitemid 
from cashreceipt c 
  inner join collectiontype ct on ct.objid = c.collectiontype_objid 
  inner join cashreceipt_share cs on cs.receiptid = c.objid 
  inner join itemaccount ia on ia.objid = cs.payableitem_objid 
go 


if object_id('dbo.vw_cashbook_cashreceiptvoid', 'V') IS NOT NULL 
  drop view dbo.vw_cashbook_cashreceiptvoid; 
go
CREATE VIEW vw_cashbook_cashreceiptvoid AS 
select  
  v.objid AS objid, 
  v.txndate AS txndate,
  cast(v.txndate as date) AS refdate, 
  v.objid AS refid, 
  c.receiptno AS refno, 
  'cashreceipt:void' AS reftype,
  ('VOID '+ v.reason) AS particulars, 
  ci.item_fund_objid AS fundid, 
  c.collector_objid AS collectorid, 
  (ci.amount * -(1.0)) AS dr,
  (case 
    when r.liquidatingofficer_objid is null then 0.0 
    when v.txndate >= r.dtposted and cast(v.txndate as date) >= cast(r.controldate as date) then (ci.amount * -(1.0)) 
    else 0.0 
  end) AS cr, 
  c.formno AS formno, 
  c.formtype AS formtype, 
  c.series AS series, 
  c.controlid AS controlid, 
  v.txndate AS sortdate 
from cashreceipt_void v 
  inner join cashreceipt c on c.objid = v.receiptid 
  inner join cashreceiptitem ci on ci.receiptid = c.objid 
  inner join collectiontype ct on ct.objid = c.collectiontype_objid 
  left join remittance r on r.objid = c.remittanceid 
go 


if object_id('dbo.vw_cashbook_remittance', 'V') IS NOT NULL 
  drop view dbo.vw_cashbook_remittance; 
go
CREATE VIEW vw_cashbook_remittance AS 
select  
  rem.objid AS objid, 
  rem.dtposted AS txndate, 
  rem.controldate AS refdate, 
  rem.objid AS refid, 
  rem.controlno AS refno, 
  'remittance' AS reftype, 
  'REMITTANCE' AS particulars, 
  remf.fund_objid AS fundid, 
  rem.collector_objid AS collectorid, 
  0.0 AS dr, 
  remf.amount AS cr, 
  'remittance' AS formno,
  'remittance' AS formtype,
  NULL AS series,
  NULL AS controlid, 
  rem.dtposted AS sortdate 
from remittance rem 
  inner join remittance_fund remf on remf.remittanceid = rem.objid 
go 


if object_id('dbo.vw_cashreceipt_itemaccount_collectiongroup', 'V') IS NOT NULL 
  drop view dbo.vw_cashreceipt_itemaccount_collectiongroup; 
go 
CREATE VIEW vw_cashreceipt_itemaccount_collectiongroup AS 
select  
  ia.objid AS objid, 
  ia.state AS state, 
  ia.code AS code, 
  ia.title AS title, 
  ia.description AS description, 
  ia.type AS type, 
  ia.fund_objid AS fund_objid, 
  ia.fund_code AS fund_code, 
  ia.fund_title AS fund_title,
  (case when ca.defaultvalue = 0 then ia.defaultvalue else ca.defaultvalue end) AS defaultvalue,
  (case when ca.defaultvalue = 0 then ia.valuetype else ca.valuetype end) AS valuetype, 
  ca.sortorder AS sortorder, 
  ia.org_objid AS orgid, 
  ca.collectiongroupid AS collectiongroupid, 
  ia.generic AS generic 
from collectiongroup_account ca 
  inner join itemaccount ia on ia.objid = ca.account_objid 
go 


if object_id('dbo.vw_account_mapping', 'V') IS NOT NULL 
  drop view dbo.vw_account_mapping; 
go 
create view vw_account_mapping as  
select a.*, m.itemid, m.acctid  
from account_item_mapping m 
  inner join account a on a.objid = m.acctid
go  



INSERT INTO sys_usergroup (objid, title, domain, userclass, orgclass, role) 
select * 
from ( 
  SELECT 
    'RULEMGMT.DEV' as objid, 'RULEMGMT DEVELOPER' as title, 
    'RULEMGMT' as domain, 'usergroup' as userclass, NULL as orgclass, 
    'DEV' as role
  union all 
  SELECT 
    'WORKFLOW.DEV' as objid, 'WORKFLOW DEVELOPER' as title, 
    'WORKFLOW' as domain, 'usergroup' as userclass, NULL as orgclass, 
    'DEV' as role
)t1
where t1.objid not in (select objid from sys_usergroup where objid = t1.objid)
;

update sys_usergroup_permission set usergroup_objid='RULEMGMT.DEV' where usergroup_objid = 'RULEMGMT.MASTER'
;
update sys_usergroup_member set usergroup_objid='RULEMGMT.DEV' where usergroup_objid = 'RULEMGMT.MASTER'
;
delete from sys_usergroup where objid = 'RULEMGMT.MASTER'
; 


update sys_usergroup_permission set usergroup_objid='WORKFLOW.DEV' where usergroup_objid = 'WORKFLOW.MASTER'
;
update sys_usergroup_member set usergroup_objid='WORKFLOW.DEV' where usergroup_objid = 'WORKFLOW.MASTER'
;
delete from sys_usergroup where objid = 'WORKFLOW.MASTER'
; 



if object_id('dbo.vw_income_summary', 'V') IS NOT NULL 
  drop view dbo.vw_income_summary; 
go 
create view vw_income_summary as 
select 
  inc.*, fund.groupid as fundgroupid, 
  ia.objid as itemid, ia.code as itemcode, ia.title as itemtitle, ia.type as itemtype  
from income_summary inc 
  inner join fund on fund.objid = inc.fundid 
  inner join itemaccount ia on ia.objid = inc.acctid 

GO



if object_id('dbo.sys_user_role', 'V') IS NOT NULL 
  drop view dbo.sys_user_role; 
go 
create view sys_user_role AS 
select  
  u.objid AS objid, 
  u.lastname AS lastname, 
  u.firstname AS firstname, 
  u.middlename AS middlename, 
  u.username AS username,
  (u.lastname +', '+ u.firstname +(case when u.middlename is null then '' else (' '+ u.middlename) end)) AS name, 
  ug.role AS role, 
  ug.domain AS domain, 
  ugm.org_objid AS orgid, 
  u.txncode AS txncode, 
  u.jobtitle AS jobtitle, 
  ugm.objid AS usergroupmemberid, 
  ugm.usergroup_objid AS usergroup_objid,
  ugm.org_objid as respcenter_objid, 
  ugm.org_name as respcenter_name 
from sys_usergroup_member ugm 
  inner join sys_usergroup ug on ug.objid = ugm.usergroup_objid 
  inner join sys_user u on u.objid = ugm.user_objid 
go 



-- ## 2020-04-21
if object_id('dbo.vw_cashbook_cashreceipt', 'V') IS NOT NULL 
  drop view dbo.vw_cashbook_cashreceipt; 
go 
CREATE VIEW vw_cashbook_cashreceipt AS 
select  
  c.objid AS objid, 
  c.txndate AS txndate,
  cast(c.receiptdate as date) AS refdate, 
  c.objid AS refid, 
  c.receiptno AS refno,
  'cashreceipt' AS reftype, 
  (ct.name +' ('+ c.paidby +')') AS particulars, 
  ci.item_fund_objid AS fundid, 
  c.collector_objid AS collectorid, 
  ci.amount AS dr, 0.0 AS cr, 
  c.formno AS formno, 
  c.formtype AS formtype, 
  c.series AS series, 
  c.controlid AS controlid, 
  c.txndate AS sortdate, 
  c.receiptdate AS receiptdate, 
  c.objid AS receiptid, 
  c.remittanceid, 
  r.controldate as remittancedate, 
  r.dtposted as remittancedtposted
from cashreceipt c 
  inner join collectiontype ct on ct.objid = c.collectiontype_objid
  inner join cashreceiptitem ci on ci.receiptid = c.objid
  left join remittance r on r.objid = c.remittanceid 
go 


if object_id('dbo.vw_cashbook_cashreceipt_share', 'V') IS NOT NULL 
  drop view dbo.vw_cashbook_cashreceipt_share; 
go 
CREATE VIEW vw_cashbook_cashreceipt_share AS 
select  
  c.objid AS objid, 
  c.txndate AS txndate,
  cast(c.receiptdate as date) AS refdate, 
  c.objid AS refid, 
  c.receiptno AS refno, 
  'cashreceipt' AS reftype, 
  (ct.name +' ('+ c.paidby +')') AS particulars, 
  ia.fund_objid AS fundid, 
  c.collector_objid AS collectorid, 
  cs.amount AS dr, 0.0 AS cr, 
  c.formno AS formno, 
  c.formtype AS formtype, 
  c.series AS series, 
  c.controlid AS controlid, 
  c.txndate AS sortdate, 
  c.receiptdate AS receiptdate, 
  c.objid AS receiptid, 
  cs.refitem_objid AS refitemid, 
  c.remittanceid, 
  r.controldate as remittancedate, 
  r.dtposted as remittancedtposted   
from cashreceipt c 
  inner join collectiontype ct on ct.objid = c.collectiontype_objid 
  inner join cashreceipt_share cs on cs.receiptid = c.objid 
  inner join itemaccount ia on ia.objid = cs.refitem_objid 
  left join remittance r on r.objid = c.remittanceid 
go 


if object_id('dbo.vw_cashbook_cashreceipt_share_payable', 'V') IS NOT NULL 
  drop view dbo.vw_cashbook_cashreceipt_share_payable; 
go 
CREATE VIEW vw_cashbook_cashreceipt_share_payable AS 
select  
  c.objid AS objid, 
  c.txndate AS txndate,
  cast(c.receiptdate as date) AS refdate, 
  c.objid AS refid, 
  c.receiptno AS refno, 
  'cashreceipt' AS reftype, 
  (ct.name +' ('+ c.paidby +')') AS particulars, 
  ia.fund_objid AS fundid, 
  c.collector_objid AS collectorid, 
  cs.amount AS dr, 0.0 AS cr, 
  c.formno AS formno, 
  c.formtype AS formtype, 
  c.series AS series, 
  c.controlid AS controlid, 
  c.txndate AS sortdate, 
  c.receiptdate AS receiptdate, 
  c.objid AS receiptid, 
  cs.payableitem_objid AS payableitemid, 
  c.remittanceid, 
  r.controldate as remittancedate, 
  r.dtposted as remittancedtposted   
from cashreceipt c 
  inner join collectiontype ct on ct.objid = c.collectiontype_objid 
  inner join cashreceipt_share cs on cs.receiptid = c.objid 
  inner join itemaccount ia on ia.objid = cs.payableitem_objid  
  left join remittance r on r.objid = c.remittanceid 
go 


if object_id('dbo.vw_cashbook_remittance', 'V') IS NOT NULL 
  drop view dbo.vw_cashbook_remittance; 
go 
CREATE VIEW vw_cashbook_remittance AS 
select  
  r.objid AS objid, 
  r.dtposted AS txndate, 
  r.controldate AS refdate, 
  r.objid AS refid, 
  r.controlno AS refno, 
  'remittance' AS reftype, 
  'REMITTANCE' AS particulars, 
  ci.item_fund_objid AS fundid, 
  r.collector_objid AS collectorid, 
  0.0 AS dr, ci.amount as cr, 
  'remittance' AS formno,
  'remittance' AS formtype,
  NULL AS series, 
  NULL AS controlid, 
  r.dtposted AS sortdate, 
  r.liquidatingofficer_objid, 
  r.liquidatingofficer_name, 
  v.objid as voidid, 
  v.txndate as voiddate 
from remittance r 
  inner join cashreceipt c on c.remittanceid = r.objid 
  inner join cashreceiptitem ci on ci.receiptid = c.objid 
  left join cashreceipt_void v on v.receiptid = c.objid 
go 


if object_id('dbo.vw_cashbook_remittance_share', 'V') IS NOT NULL 
  drop view dbo.vw_cashbook_remittance_share; 
go 
CREATE VIEW vw_cashbook_remittance_share AS 
select  
  r.objid AS objid, 
  r.dtposted AS txndate, 
  r.controldate AS refdate, 
  r.objid AS refid, 
  r.controlno AS refno, 
  'remittance' AS reftype, 
  'REMITTANCE' AS particulars, 
  ia.fund_objid AS fundid, 
  r.collector_objid AS collectorid, 
  0.0 AS dr, cs.amount as cr, 
  'remittance' AS formno,
  'remittance' AS formtype,
  NULL AS series,
  NULL AS controlid, 
  r.dtposted AS sortdate, 
  r.liquidatingofficer_objid, 
  r.liquidatingofficer_name,   
  v.objid as voidid, 
  v.txndate as voiddate 
from remittance r 
  inner join cashreceipt c on c.remittanceid = r.objid 
  inner join cashreceipt_share cs on cs.receiptid = c.objid 
  inner join itemaccount ia on ia.objid = cs.refitem_objid 
  left join cashreceipt_void v on v.receiptid = c.objid 
go 

if object_id('dbo.vw_cashbook_remittance_share_payable', 'V') IS NOT NULL 
  drop view dbo.vw_cashbook_remittance_share_payable; 
go 
CREATE VIEW vw_cashbook_remittance_share_payable AS 
select  
  r.objid AS objid, 
  r.dtposted AS txndate, 
  r.controldate AS refdate, 
  r.objid AS refid, 
  r.controlno AS refno, 
  'remittance' AS reftype, 
  'REMITTANCE' AS particulars, 
  ia.fund_objid AS fundid, 
  r.collector_objid AS collectorid, 
  0.0 AS dr, cs.amount as cr, 
  'remittance' AS formno,
  'remittance' AS formtype,
  NULL AS series,
  NULL AS controlid, 
  r.dtposted AS sortdate, 
  r.liquidatingofficer_objid, 
  r.liquidatingofficer_name,   
  v.objid as voidid, 
  v.txndate as voiddate 
from remittance r 
  inner join cashreceipt c on c.remittanceid = r.objid 
  inner join cashreceipt_share cs on cs.receiptid = c.objid 
  inner join itemaccount ia on ia.objid = cs.payableitem_objid
  left join cashreceipt_void v on v.receiptid = c.objid 
go 


if object_id('dbo.vw_cashbook_cashreceiptvoid', 'V') IS NOT NULL 
  drop view dbo.vw_cashbook_cashreceiptvoid; 
go 
CREATE VIEW vw_cashbook_cashreceiptvoid AS 
select  
  v.objid AS objid, 
  v.txndate AS txndate,
  cast(v.txndate as date) AS refdate, 
  v.objid AS refid, 
  c.receiptno AS refno, 
  'cashreceipt:void' AS reftype,
  ('VOID '+ v.reason) AS particulars, 
  ci.item_fund_objid AS fundid, 
  c.collector_objid AS collectorid, 
  ci.amount as dr, 
  (
    case 
      when r.liquidatingofficer_objid is null then 0.0 
      when v.txndate > r.dtposted then ci.amount 
      else 0.0  
    end
  ) AS cr, 
  c.formno AS formno, 
  c.formtype AS formtype, 
  c.series AS series, 
  c.controlid AS controlid, 
  v.txndate AS sortdate, 
  c.receiptdate, 
  c.remittanceid, 
  r.controldate as remittancedate, 
  r.dtposted as remittancedtposted 
from cashreceipt_void v 
  inner join cashreceipt c on c.objid = v.receiptid 
  inner join cashreceiptitem ci on ci.receiptid = c.objid 
  inner join collectiontype ct on ct.objid = c.collectiontype_objid 
  left join remittance r on r.objid = c.remittanceid 
go 

if object_id('dbo.vw_cashbook_cashreceiptvoid_share', 'V') IS NOT NULL 
  drop view dbo.vw_cashbook_cashreceiptvoid_share; 
go 
CREATE VIEW vw_cashbook_cashreceiptvoid_share AS 
select  
  v.objid AS objid, 
  v.txndate AS txndate,
  cast(v.txndate as date) AS refdate, 
  v.objid AS refid, 
  c.receiptno AS refno, 
  'cashreceipt:void' AS reftype,
  ('VOID '+ v.reason) AS particulars, 
  ia.fund_objid AS fundid, 
  c.collector_objid AS collectorid, 
  cs.amount as dr, 
  (
    case 
      when r.liquidatingofficer_objid is null then 0.0 
      when v.txndate > r.dtposted then cs.amount 
      else 0.0  
    end
  ) AS cr, 
  c.formno AS formno, 
  c.formtype AS formtype, 
  c.series AS series, 
  c.controlid AS controlid, 
  v.txndate AS sortdate, 
  c.receiptdate, 
  c.remittanceid, 
  r.controldate as remittancedate, 
  r.dtposted as remittancedtposted 
from cashreceipt_void v 
  inner join cashreceipt c on c.objid = v.receiptid 
  inner join cashreceipt_share cs on cs.receiptid = c.objid 
  inner join itemaccount ia on ia.objid = cs.refitem_objid 
  inner join collectiontype ct on ct.objid = c.collectiontype_objid 
  left join remittance r on r.objid = c.remittanceid 
go

if object_id('dbo.vw_cashbook_cashreceiptvoid_share_payable', 'V') IS NOT NULL 
  drop view dbo.vw_cashbook_cashreceiptvoid_share_payable; 
go 
CREATE VIEW vw_cashbook_cashreceiptvoid_share_payable AS 
select  
  v.objid AS objid, 
  v.txndate AS txndate,
  cast(v.txndate as date) AS refdate, 
  v.objid AS refid, 
  c.receiptno AS refno, 
  'cashreceipt:void' AS reftype,
  ('VOID '+ v.reason) AS particulars, 
  ia.fund_objid AS fundid, 
  c.collector_objid AS collectorid, 
  cs.amount as dr, 
  (
    case 
      when r.liquidatingofficer_objid is null then 0.0 
      when v.txndate > r.dtposted then cs.amount 
      else 0.0  
    end
  ) AS cr, 
  c.formno AS formno, 
  c.formtype AS formtype, 
  c.series AS series, 
  c.controlid AS controlid, 
  v.txndate AS sortdate, 
  c.receiptdate, 
  c.remittanceid, 
  r.controldate as remittancedate, 
  r.dtposted as remittancedtposted 
from cashreceipt_void v 
  inner join cashreceipt c on c.objid = v.receiptid 
  inner join cashreceipt_share cs on cs.receiptid = c.objid 
  inner join itemaccount ia on ia.objid = cs.payableitem_objid 
  inner join collectiontype ct on ct.objid = c.collectiontype_objid 
  left join remittance r on r.objid = c.remittanceid 
go 



-- ## 2020-04-29
update aa set 
  aa.receivedstartseries = bb.issuedstartseries, aa.receivedendseries = bb.issuedendseries, aa.qtyreceived = bb.qtyissued, 
  aa.issuedstartseries = null, aa.issuedendseries = null, aa.qtyissued = 0 
from af_control_detail aa, ( 
    select objid, issuedstartseries, issuedendseries, qtyissued 
    from af_control_detail d 
    where d.reftype = 'ISSUE' and d.txntype = 'COLLECTION' 
      and d.qtyreceived = 0 
  )bb 
where aa.objid = bb.objid 
; 

update af_control_detail set receivedstartseries = null where receivedstartseries = 0 ; 
update af_control_detail set receivedendseries = null where receivedendseries  = 0 ; 
update af_control_detail set beginstartseries = null where beginstartseries = 0 ; 
update af_control_detail set beginendseries = null where beginendseries = 0 ; 
update af_control_detail set issuedstartseries = null where issuedstartseries = 0 ; 
update af_control_detail set issuedendseries = null where issuedendseries = 0 ; 
update af_control_detail set endingstartseries = null where endingstartseries = 0 ; 
update af_control_detail set endingendseries = null where endingendseries = 0 ; 


update aa set 
  aa.remarks = 'COLLECTION' 
from af_control_detail aa, ( 
    select d.objid 
    from af_control_detail d 
      inner join af_control a on a.objid = d.controlid 
    where d.reftype = 'ISSUE' and d.txntype = 'COLLECTION' 
      and d.remarks = 'SALE' 
  )bb 
where aa.objid = bb.objid 
;

update aa set 
  aa.beginstartseries = bb.receivedstartseries, aa.beginendseries = bb.receivedendseries, aa.qtybegin = bb.qtyreceived, 
  aa.receivedstartseries = null, aa.receivedendseries = null, aa.qtyreceived = 0 
from af_control_detail aa, ( 
    select rd.objid, rd.receivedstartseries, rd.receivedendseries, rd.qtyreceived 
    from ( 
      select tt.*, (
          select top 1 objid from af_control_detail 
          where controlid = tt.controlid and reftype in ('ISSUE','MANUAL_ISSUE') 
          order by refdate, txndate, indexno 
        ) as pdetailid, (
          select top 1 objid from af_control_detail 
          where controlid = tt.controlid and refdate = tt.refdate 
            and reftype = tt.reftype and txntype = tt.txntype and qtyreceived > 0 
          order by refdate, txndate, indexno 
        ) as cdetailid 
      from ( 
        select d.controlid, d.reftype, d.txntype, min(d.refdate) as refdate  
        from af_control_detail d 
        where d.reftype = 'remittance' and d.txntype = 'remittance' 
        group by d.controlid, d.reftype, d.txntype 
      )tt 
    )tt 
      inner join af_control_detail rd on rd.objid = tt.cdetailid 
      inner join af_control_detail pd on pd.objid = tt.pdetailid 
    where pd.refdate <> rd.refdate 
  )bb 
where aa.objid = bb.objid 
;



-- ## 2020-05-04
update aa set 
  aa.refdate = bb.receiptdate 
from af_control_detail aa, (
    select t2.*, (select min(receiptdate) from cashreceipt where controlid = t2.controlid) as receiptdate 
    from ( 
      select t1.* 
      from ( 
        select d.controlid, d.refdate, d.reftype, d.refid, d.objid as cdetailid, (
          select top 1 objid from af_control_detail 
            where controlid = d.controlid 
              order by refdate, txndate, indexno 
          ) as firstdetailid 
        from aftxn aft 
          inner join aftxnitem afi on afi.parentid = aft.objid 
          inner join af_control_detail d on d.aftxnitemid = afi.objid 
        where aft.txntype = 'FORWARD' 
      )t1, af_control_detail d 
      where d.objid = t1.firstdetailid 
        and d.objid <> t1.cdetailid 
    )t2 
  )bb 
where aa.objid = bb.cdetailid 
  and bb.receiptdate is not null 
; 



-- ## 2020-05-15
if object_id('dbo.vw_remittance_cashreceiptitem', 'V') IS NOT NULL 
  drop view dbo.vw_remittance_cashreceiptitem; 
go 
create view vw_remittance_cashreceiptitem AS 
select 
  c.remittanceid AS remittanceid, 
  r.controldate AS remittance_controldate, 
  r.controlno AS remittance_controlno, 
  r.collectionvoucherid AS collectionvoucherid, 
  c.collectiontype_objid AS collectiontype_objid, 
  c.collectiontype_name AS collectiontype_name, 
  c.org_objid AS org_objid, 
  c.org_name AS org_name, 
  c.formtype AS formtype, 
  c.formno AS formno, 
  (case when (c.formtype = 'serial') then 0 else 1 end) AS formtypeindex, 
  cri.receiptid AS receiptid, 
  c.receiptdate AS receiptdate, 
  c.receiptno AS receiptno, 
  c.controlid as controlid, 
  c.series as series, 
  c.paidby AS paidby, 
  c.paidbyaddress AS paidbyaddress, 
  c.collector_objid AS collectorid, 
  c.collector_name AS collectorname, 
  c.collector_title AS collectortitle, 
  cri.item_fund_objid AS fundid, 
  cri.item_objid AS acctid, 
  cri.item_code AS acctcode, 
  cri.item_title AS acctname, 
  cri.remarks AS remarks, 
  (case when v.objid is null then cri.amount else 0.0 end) AS amount, 
  (case when v.objid is null then 0 else 1 end) AS voided, 
  (case when v.objid is null then 0.0 else cri.amount end) AS voidamount  
from remittance r 
  inner join cashreceipt c on c.remittanceid = r.objid 
  inner join cashreceiptitem cri on cri.receiptid = c.objid 
  left join cashreceipt_void v on v.receiptid = c.objid 
go 


if object_id('dbo.vw_collectionvoucher_cashreceiptitem', 'V') IS NOT NULL 
  drop view dbo.vw_collectionvoucher_cashreceiptitem; 
go 
create view vw_collectionvoucher_cashreceiptitem AS 
select 
  cv.controldate AS collectionvoucher_controldate, 
  cv.controlno AS collectionvoucher_controlno, 
  v.remittanceid AS remittanceid, 
  v.remittance_controldate AS remittance_controldate, 
  v.remittance_controlno AS remittance_controlno, 
  v.collectionvoucherid AS collectionvoucherid, 
  v.collectiontype_objid AS collectiontype_objid, 
  v.collectiontype_name AS collectiontype_name, 
  v.org_objid AS org_objid, 
  v.org_name AS org_name, 
  v.formtype AS formtype, 
  v.formno AS formno, 
  v.formtypeindex AS formtypeindex, 
  v.receiptid AS receiptid, 
  v.receiptdate AS receiptdate, 
  v.receiptno AS receiptno, 
  v.controlid as controlid,
  v.series as series,
  v.paidby AS paidby, 
  v.paidbyaddress AS paidbyaddress, 
  v.collectorid AS collectorid, 
  v.collectorname AS collectorname, 
  v.collectortitle AS collectortitle, 
  v.fundid AS fundid, 
  v.acctid AS acctid, 
  v.acctcode AS acctcode, 
  v.acctname AS acctname, 
  v.amount AS amount, 
  v.voided AS voided, 
  v.voidamount AS voidamount, 
  v.remarks as remarks 
from collectionvoucher cv 
  inner join vw_remittance_cashreceiptitem v on v.collectionvoucherid = cv.objid 
go 



-- ## 2020-06-04
-- drop index ix_bankid on checkpayment
-- go
-- alter table checkpayment alter column bankid varchar(50) null 
-- go 
-- create index ix_bankid on checkpayment (bankid)
-- go
alter table checkpayment add constraint fk_checkpayment_bankid 
  foreign key (bankid) references bank (objid) 
go 



-- ## 2020-06-06
alter table aftxn add lockid varchar(50) null 
go 

-- alter table af_control add constraint fk_af_control_afid 
--  foreign key (afid) references af (objid) 
-- go 

alter table af_control add constraint fk_af_control_allocid 
  foreign key (allocid) references af_allocation (objid) 
go 

if object_id('dbo.vw_af_inventory_summary', 'V') IS NOT NULL 
  drop view dbo.vw_af_inventory_summary; 
go 

create view vw_af_inventory_summary as 
select top 100 percent 
  af.objid, af.title, u.unit, af.formtype, 
  (case when af.formtype='serial' then 0 else 1 end) as formtypeindex, 
  (select count(0) from af_control where afid = af.objid and state = 'OPEN') AS countopen, 
  (select count(0) from af_control where afid = af.objid and state = 'ISSUED') AS countissued, 
  (select count(0) from af_control where afid = af.objid and state = 'ISSUED' and currentseries > endseries) AS countclosed, 
  (select count(0) from af_control where afid = af.objid and state = 'SOLD') AS countsold, 
  (select count(0) from af_control where afid = af.objid and state = 'PROCESSING') AS countprocessing, 
  (select count(0) from af_control where afid = af.objid and state = 'HOLD') AS counthold
from af, afunit u 
where af.objid = u.itemid
order by (case when af.formtype='serial' then 0 else 1 end), af.objid 
go 

alter table af_control add salecost decimal(16,2) not null default '0.0'
go 



insert into sys_usergroup (
  objid, title, domain, role, userclass
) values (
  'TREASURY.AFO_ADMIN', 'TREASURY AFO ADMIN', 'TREASURY', 'AFO_ADMIN', 'usergroup' 
)
go  

insert into sys_usergroup_permission (
  objid, usergroup_objid, object, permission, title 
) values ( 
  'TREASURY-AFO-ADMIN-aftxn-changetxntype', 'TREASURY.AFO_ADMIN', 'aftxn', 'changeTxnType', 'Change Txn Type'
); 




-- ## 2020-06-09

insert into sys_usergroup (
  objid, title, domain, role, userclass
) values (
  'TREASURY.COLLECTOR_ADMIN', 'TREASURY COLLECTOR ADMIN', 'TREASURY', 'COLLECTOR_ADMIN', 'usergroup' 
); 

insert into sys_usergroup_permission (
  objid, usergroup_objid, object, permission, title 
) values ( 
  'TREASURY-COLLECTOR-ADMIN-aftxn-changetxntype', 'TREASURY.COLLECTOR_ADMIN', 'remittance', 'rebuildFund', 'Rebuild Remittance Fund'
); 



-- ## 2020-06-10
update af_control_detail set reftype = 'ISSUE' where txntype='SALE' and reftype <> 'ISSUE' 
; 

update aa set 
  aa.issuedstartseries = bb.endingstartseries, aa.issuedendseries = bb.endingendseries, aa.qtyissued = bb.qtyending, 
  aa.endingstartseries = null, aa.endingendseries = null, aa.qtyending = 0 
from af_control_detail aa, ( 
    select 
      (select count(*) from cashreceipt where controlid = d.controlid) as receiptcount, 
      d.objid, d.controlid, d.endingstartseries, d.endingendseries, d.qtyending 
    from af_control_detail d 
    where d.txntype='SALE' 
      and d.qtyending > 0
  )bb 
where aa.objid = bb.objid 
  and bb.receiptcount = 0 
;

update aa set 
  aa.reftype = 'ISSUE', aa.txntype = 'COLLECTION', aa.remarks = 'COLLECTION' 
from af_control_detail aa, ( 
    select 
      (select count(*) from cashreceipt where controlid = d.controlid) as receiptcount, 
      d.objid, d.controlid, d.endingstartseries, d.endingendseries, d.qtyending 
    from af_control_detail d 
    where d.txntype='SALE' 
      and d.qtyending > 0
  )bb 
where aa.objid = bb.objid 
  and bb.receiptcount > 0 
;


insert into sys_usergroup_permission (
  objid, usergroup_objid, object, permission, title 
) values ( 
  'TREASURY-COLLECTOR-ADMIN-remittance-modifyCashBreakdown', 'TREASURY.COLLECTOR_ADMIN', 'remittance', 'modifyCashBreakdown', 'Modify Remittance Cash Breakdown'
); 



-- ## 2020-06-11

update aa set 
  aa.receivedstartseries = bb.issuedstartseries, aa.receivedendseries = bb.issuedendseries, aa.qtyreceived = bb.qtyissued, 
  aa.beginstartseries = null, aa.beginendseries = null, aa.qtybegin = 0 
from af_control_detail aa, ( 
    select objid, issuedstartseries, issuedendseries, qtyissued 
    from af_control_detail 
    where txntype='sale' 
      and qtyissued > 0 
  ) bb  
where aa.objid = bb.objid 
; 

update aa set 
  aa.currentdetailid = null, aa.currentindexno = 0 
from af_control aa, ( 
    select a.objid 
    from af_control a 
    where a.objid not in (
      select distinct controlid from af_control_detail where controlid = a.objid
    ) 
  )bb 
where aa.objid = bb.objid 
; 


update aa set 
  aa.currentseries = aa.endseries+1 
from  af_control aa, ( 
    select d.controlid 
    from af_control_detail d, af_control a 
    where d.txntype = 'SALE' 
      and d.controlid = a.objid 
      and a.currentseries <= a.endseries 
  )bb 
where aa.objid = bb.controlid 
; 


update af_control set 
  currentindexno = (select indexno from af_control_detail where objid = af_control.currentdetailid)
where currentdetailid is not null 
; 


insert into sys_usergroup_permission (
  objid, usergroup_objid, object, permission, title 
) values ( 
  'TREASURY-COLLECTOR-ADMIN-remittance-voidReceipt', 'TREASURY.COLLECTOR_ADMIN', 'remittance', 'voidReceipt', 'Void Receipt'
); 



-- ## 2020-06-12

insert into sys_usergroup (
  objid, title, domain, role, userclass
) values (
  'TREASURY.LIQ_OFFICER_ADMIN', 'TREASURY LIQ. OFFICER ADMIN', 
  'TREASURY', 'LIQ_OFFICER_ADMIN', 'usergroup' 
); 

insert into sys_usergroup_permission (
  objid, usergroup_objid, object, permission, title 
) values ( 
  'UGP-d2bb69a6769517e0c8e672fec41f5fd7', 'TREASURY.LIQ_OFFICER_ADMIN', 
  'collectionvoucher', 'changeLiqOfficer', 'Change Liquidating Officer'
); 

insert into sys_usergroup_permission (
  objid, usergroup_objid, object, permission, title 
) values ( 
  'UGP-3219ec222220f68d1f69d4d1d76021e0', 'TREASURY.LIQ_OFFICER_ADMIN', 
  'collectionvoucher', 'modifyCashBreakdown', 'Modify Cash Breakdown'
); 

insert into sys_usergroup_permission (
  objid, usergroup_objid, object, permission, title 
) values ( 
  'UGP-4e508bdd04888894926f677bbc0be374', 'TREASURY.LIQ_OFFICER_ADMIN', 
  'collectionvoucher', 'rebuildFund', 'Rebuild Fund Summary'
); 

insert into sys_usergroup_permission (
  objid, usergroup_objid, object, permission, title 
) values ( 
  'UGP-cf543fabc2aca483c6e5d3d48c39c4cc', 'TREASURY.LIQ_OFFICER_ADMIN', 
  'incomesummary', 'rebuild', 'Rebuild Income Summary'
); 




-- ## 2020-10-13

-- CREATE TABLE cashreceipt_plugin ( 
--    objid varchar(50) NOT NULL, 
--    connection varchar(150) NOT NULL, 
--    servicename varchar(255) NOT NULL,
--    CONSTRAINT pk_cashreceipt_plugin PRIMARY KEY (objid)
-- ) 
-- go 

update cashreceipt_plugin set connection = objid where connection is null 
go 



-- ## 2020-11-06
CREATE TABLE sys_email_queue (
  objid varchar(50) NOT NULL,
  refid varchar(50) NOT NULL,
  state int NOT NULL,
  reportid varchar(50) NULL,
  dtsent datetime NOT NULL,
  [to] varchar(255) NOT NULL,
  subject varchar(255) NOT NULL,
  message text NOT NULL,
  errmsg varchar(MAX) NULL,
  connection varchar(50) NULL,
  constraint pk_sys_email_queue PRIMARY KEY (objid)
) 
go 
create index ix_refid on sys_email_queue (refid)
go
create index ix_state on sys_email_queue (state)
go
create index ix_reportid on sys_email_queue (reportid)
go
create index ix_dtsent on sys_email_queue (dtsent)
go



-- ## 2020-11-12

CREATE TABLE online_business_application (
  objid varchar(50) NOT NULL,
  state varchar(20) NOT NULL,
  dtcreated datetime NOT NULL,
  createdby_objid varchar(50) NOT NULL,
  createdby_name varchar(100) NOT NULL,
  controlno varchar(25) NOT NULL,
  prevapplicationid varchar(50) NOT NULL,
  business_objid varchar(50) NOT NULL,
  appyear int NOT NULL,
  apptype varchar(20) NOT NULL,
  appdate date NOT NULL,
  lobs text NOT NULL,
  infos varchar(MAX) NOT NULL,
  requirements varchar(MAX) NOT NULL,
  step int NOT NULL DEFAULT '0',
  dtapproved datetime NULL,
  approvedby_objid varchar(50) NULL,
  approvedby_name varchar(150) NULL,
  approvedappno varchar(25) NULL,
  constraint pk_online_business_application PRIMARY KEY (objid)
) 
go 

create index ix_state on online_business_application (state)
go 
create index ix_dtcreated on online_business_application (dtcreated)
go 
create index ix_controlno on online_business_application (controlno)
go 
create index ix_prevapplicationid on online_business_application (prevapplicationid)
go 
create index ix_business_objid on online_business_application (business_objid)
go 
create index ix_appyear on online_business_application (appyear)
go 
create index ix_appdate on online_business_application (appdate)
go 
create index ix_dtapproved on online_business_application (dtapproved)
go 
create index ix_approvedby_objid on online_business_application (approvedby_objid)
go 
create index ix_approvedby_name on online_business_application (approvedby_name)
go 

alter table online_business_application add CONSTRAINT fk_online_business_application_business_objid 
  FOREIGN KEY (business_objid) REFERENCES business (objid) 
go 
alter table online_business_application add CONSTRAINT fk_online_business_application_prevapplicationid 
  FOREIGN KEY (prevapplicationid) REFERENCES business_application (objid) 
go 



CREATE VIEW vw_online_business_application AS 
select 
  oa.objid AS objid, 
  oa.state AS state, 
  oa.dtcreated AS dtcreated, 
  oa.createdby_objid AS createdby_objid, 
  oa.createdby_name AS createdby_name, 
  oa.controlno AS controlno, 
  oa.apptype AS apptype, 
  oa.appyear AS appyear, 
  oa.appdate AS appdate, 
  oa.prevapplicationid AS prevapplicationid, 
  oa.business_objid AS business_objid, 
  b.bin AS bin, 
  b.tradename AS tradename, 
  b.businessname AS businessname, 
  b.address_text AS address_text, 
  b.address_objid AS address_objid, 
  b.owner_name AS owner_name, 
  b.owner_address_text AS owner_address_text, 
  b.owner_address_objid AS owner_address_objid, 
  b.yearstarted AS yearstarted, 
  b.orgtype AS orgtype, 
  b.permittype AS permittype, 
  b.officetype AS officetype, 
  oa.step AS step 
from online_business_application oa 
  inner join business_application a on a.objid = oa.prevapplicationid 
  inner join business b on b.objid = a.business_objid
go 




-- ## 2020-12-22

alter table online_business_application add 
  contact_name varchar(255) not null, 
  contact_address varchar(255) not null, 
  contact_email varchar(255) not null, 
  contact_mobileno varchar(15) null 
go 



-- ## 2020-12-23

alter table business_recurringfee add txntype_objid varchar(50) null 
go 

create index ix_txntype_objid on business_recurringfee  (txntype_objid)
go 

alter table business_recurringfee add constraint fk_business_recurringfee_txntype_objid 
  foreign key (txntype_objid) references business_billitem_txntype (objid)
go 




-- ## 2020-12-24

select 'BPLS' as domain, 'OBO' as role, t1.*, 
  (select title from itemaccount where objid = t1.acctid) as title, 
  (
    select top 1 r.taxfeetype 
    from business_receivable r, business_application a 
    where r.account_objid = t1.acctid 
      and a.objid = r.applicationid 
    order by a.txndate desc 
  ) as feetype 
into ztmp_fix_business_billitem_txntype 
from ( select distinct account_objid as acctid from business_recurringfee )t1 
where t1.acctid not in ( 
  select acctid from business_billitem_txntype where acctid = t1.acctid 
) 
go 

insert into business_billitem_txntype (
  objid, title, acctid, feetype, domain, role
) 
select 
  acctid, title, acctid, feetype, domain, role
from ztmp_fix_business_billitem_txntype
go 

update aa set 
  aa.txntype_objid = (
    select top 1 objid 
    from business_billitem_txntype 
    where acctid = aa.account_objid 
  ) 
from business_recurringfee aa 
where aa.txntype_objid is null 
go 

drop table ztmp_fix_business_billitem_txntype
go 



alter table online_business_application add partnername varchar(50) not null 
go




-- ## 2021-01-06

if object_id('dbo.vw_collectionvoucher_cashreceiptitem', 'V') IS NOT NULL
  drop view vw_collectionvoucher_cashreceiptitem; 
go 
if object_id('dbo.vw_remittance_cashreceiptitem', 'V') IS NOT NULL
    drop view vw_remittance_cashreceiptitem
go 

create view vw_remittance_cashreceiptitem AS 
select 
  c.remittanceid AS remittanceid, 
  r.controldate AS remittance_controldate, 
  r.controlno AS remittance_controlno, 
  r.collectionvoucherid AS collectionvoucherid, 
  c.collectiontype_objid AS collectiontype_objid, 
  c.collectiontype_name AS collectiontype_name, 
  c.org_objid AS org_objid, 
  c.org_name AS org_name, 
  c.formtype AS formtype, 
  c.formno AS formno, 
  cri.receiptid AS receiptid, 
  c.receiptdate AS receiptdate, 
  c.receiptno AS receiptno, 
  c.controlid as controlid, 
  c.series as series, 
  c.stub as stubno, 
  c.paidby AS paidby, 
  c.paidbyaddress AS paidbyaddress, 
  c.collector_objid AS collectorid, 
  c.collector_name AS collectorname, 
  c.collector_title AS collectortitle, 
  cri.item_fund_objid AS fundid, 
  cri.item_objid AS acctid, 
  cri.item_code AS acctcode, 
  cri.item_title AS acctname, 
  cri.remarks AS remarks, 
  (case when v.objid is null then cri.amount else 0.0 end) AS amount, 
  (case when v.objid is null then 0 else 1 end) AS voided, 
  (case when v.objid is null then 0.0 else cri.amount end) AS voidamount,   
  (case when (c.formtype = 'serial') then 0 else 1 end) AS formtypeindex
from remittance r 
  inner join cashreceipt c on c.remittanceid = r.objid 
  inner join cashreceiptitem cri on cri.receiptid = c.objid 
  left join cashreceipt_void v on v.receiptid = c.objid 
go 

create view vw_collectionvoucher_cashreceiptitem AS 
select 
  cv.controldate AS collectionvoucher_controldate, 
  cv.controlno AS collectionvoucher_controlno, 
  v.*  
from collectionvoucher cv 
  inner join vw_remittance_cashreceiptitem v on v.collectionvoucherid = cv.objid 
go 



if object_id('dbo.vw_collectionvoucher_cashreceiptshare', 'V') IS NOT NULL
  drop view vw_collectionvoucher_cashreceiptshare
go 

if object_id('dbo.vw_remittance_cashreceiptshare', 'V') IS NOT NULL
  drop view vw_remittance_cashreceiptshare
go 

create view vw_remittance_cashreceiptshare AS 
select 
  c.remittanceid AS remittanceid, 
  r.controldate AS remittance_controldate, 
  r.controlno AS remittance_controlno, 
  r.collectionvoucherid AS collectionvoucherid, 
  c.formno AS formno, 
  c.formtype AS formtype, 
  c.controlid as controlid, 
  cs.receiptid AS receiptid, 
  c.receiptdate AS receiptdate, 
  c.receiptno AS receiptno, 
  c.paidby AS paidby, 
  c.paidbyaddress AS paidbyaddress, 
  c.org_objid AS org_objid, 
  c.org_name AS org_name, 
  c.collectiontype_objid AS collectiontype_objid, 
  c.collectiontype_name AS collectiontype_name, 
  c.collector_objid AS collectorid, 
  c.collector_name AS collectorname, 
  c.collector_title AS collectortitle, 
  cs.refitem_objid AS refacctid, 
  ia.fund_objid AS fundid, 
  ia.objid AS acctid, 
  ia.code AS acctcode, 
  ia.title AS acctname, 
  (case when v.objid is null then cs.amount else 0.0 end) AS amount, 
  (case when v.objid is null then 0 else 1 end) AS voided, 
  (case when v.objid is null then 0.0 else cs.amount end) AS voidamount, 
  (case when (c.formtype = 'serial') then 0 else 1 end) AS formtypeindex  
from remittance r 
  inner join cashreceipt c on c.remittanceid = r.objid 
  inner join cashreceipt_share cs on cs.receiptid = c.objid 
  inner join itemaccount ia on ia.objid = cs.payableitem_objid 
  left join cashreceipt_void v on v.receiptid = c.objid 
go 

create view vw_collectionvoucher_cashreceiptshare AS 
select 
  cv.controldate AS collectionvoucher_controldate, 
  cv.controlno AS collectionvoucher_controlno, 
  v.* 
from collectionvoucher cv 
  inner join vw_remittance_cashreceiptshare v on v.collectionvoucherid = cv.objid 
go 




if object_id('dbo.vw_remittance_cashreceiptpayment_noncash', 'V') IS NOT NULL
  drop view vw_remittance_cashreceiptpayment_noncash
go 

create view vw_remittance_cashreceiptpayment_noncash AS 
select 
  nc.objid AS objid, 
  nc.receiptid AS receiptid, 
  nc.refno AS refno, 
  nc.refdate AS refdate, 
  nc.reftype AS reftype, 
  nc.particulars AS particulars, 
  nc.fund_objid as fundid, 
  nc.refid AS refid, 
  nc.amount AS amount, 
  (case when v.objid is null then 0 else 1 end) AS voided, 
  (case when v.objid is null then 0.0 else nc.amount end) AS voidamount, 
  cp.bankid AS bankid, 
  cp.bank_name AS bank_name, 
  c.remittanceid AS remittanceid, 
  r.collectionvoucherid AS collectionvoucherid  
from remittance r 
  inner join cashreceipt c on c.remittanceid = r.objid 
  inner join cashreceiptpayment_noncash nc on (nc.receiptid = c.objid and nc.reftype = 'CHECK') 
  inner join checkpayment cp on cp.objid = nc.refid 
  left join cashreceipt_void v on v.receiptid = c.objid 
union all 
select 
  nc.objid AS objid, 
  nc.receiptid AS receiptid, 
  nc.refno AS refno, 
  nc.refdate AS refdate, 
  'EFT' AS reftype, 
  nc.particulars AS particulars, 
  nc.fund_objid as fundid, 
  nc.refid AS refid, 
  nc.amount AS amount, 
  (case when v.objid is null then 0 else 1 end) AS voided, 
  (case when v.objid is null then 0.0 else nc.amount end) AS voidamount, 
  ba.bank_objid AS bankid, 
  ba.bank_name AS bank_name, 
  c.remittanceid AS remittanceid, 
  r.collectionvoucherid AS collectionvoucherid  
from remittance r 
  inner join cashreceipt c on c.remittanceid = r.objid 
  inner join cashreceiptpayment_noncash nc on (nc.receiptid = c.objid and nc.reftype = 'EFT') 
  inner join eftpayment eft on eft.objid = nc.refid 
  inner join bankaccount ba on ba.objid = eft.bankacctid 
  left join cashreceipt_void v on v.receiptid = c.objid 
go 




-- ## 2021-01-08

INSERT INTO sys_ruleset (name, title, packagename, domain, role, permission) 
VALUES ('firebpassessment', 'Fire Assessment Rules', NULL, 'bpls', 'DATAMGMT', NULL);

INSERT INTO sys_rulegroup (name, ruleset, title, sortorder) 
VALUES ('firefee', 'firebpassessment', 'Fire Fee Computation', '0');

INSERT INTO sys_rulegroup (name, ruleset, title, sortorder) 
VALUES ('postfirefee', 'firebpassessment', 'Post Fire Fee Computation', '1');

insert into sys_ruleset_actiondef (
  ruleset, actiondef 
) 
select t1.* 
from ( 
  select 'firebpassessment' as ruleset, actiondef 
  from sys_ruleset_actiondef 
  where ruleset='bpassessment'
)t1 
  left join sys_ruleset_actiondef a on (a.ruleset = t1.ruleset and a.actiondef = t1.actiondef) 
where a.ruleset is null 
; 

insert into sys_ruleset_fact (
  ruleset, rulefact  
) 
select t1.* 
from ( 
  select 'firebpassessment' as ruleset, rulefact  
  from sys_ruleset_fact 
  where ruleset='bpassessment'
)t1 
  left join sys_ruleset_fact a on (a.ruleset = t1.ruleset and a.rulefact = t1.rulefact) 
where a.ruleset is null 
; 



CREATE TABLE sys_domain (
  name varchar(50) NOT NULL,
  connection varchar(50) NOT NULL,
  constraint pk_sys_domain PRIMARY KEY (name)
) 
go 



-- ## 2021-01-11

alter table business add lockid varchar(50) null 
go 



-- ## 2021-01-16

INSERT INTO sys_usergroup (objid, title, domain, userclass, orgclass, role) 
VALUES ('BPLS.ONLINE_DATA_APPROVER', 'BPLS - ONLINE DATA APPROVER', 'BPLS', 'usergroup', NULL, 'ONLINE_DATA_APPROVER')
;


if object_id('dbo.vw_online_business_application', 'V') IS NOT NULL
  drop view vw_online_business_application
go 
CREATE VIEW vw_online_business_application AS 
select 
  oa.objid AS objid, 
  oa.state AS state, 
  oa.dtcreated AS dtcreated, 
  oa.createdby_objid AS createdby_objid, 
  oa.createdby_name AS createdby_name, 
  oa.controlno AS controlno, 
  oa.apptype AS apptype, 
  oa.appyear AS appyear, 
  oa.appdate AS appdate, 
  oa.prevapplicationid AS prevapplicationid, 
  oa.business_objid AS business_objid, 
  b.bin AS bin, 
  b.tradename AS tradename, 
  b.businessname AS businessname, 
  b.address_text AS address_text, 
  b.address_objid AS address_objid, 
  b.owner_name AS owner_name, 
  b.owner_address_text AS owner_address_text, 
  b.owner_address_objid AS owner_address_objid, 
  b.yearstarted AS yearstarted, 
  b.orgtype AS orgtype, 
  b.permittype AS permittype, 
  b.officetype AS officetype, 
  oa.step AS step 
from online_business_application oa 
  inner join business_application a on a.objid = oa.prevapplicationid 
  inner join business b on b.objid = a.business_objid
go


-- ## 2021-01-31

alter table cashreceipt_share add receiptitemid varchar(50) null 
go

create index ix_receiptitemid on cashreceipt_share (receiptitemid) 
go



-- ## 2021-06-04

delete from sys_usergroup where objid = 'FINANCIAL.COLLECTOR'; 

select ugm.* 
into ztmp_duplicate_usergroupmember  
from ( 
  select tmp1.*, 
    (
      select top 1 objid 
      from sys_usergroup_member 
      where user_objid = tmp1.user_objid
        and usergroup_objid = tmp1.usergroup_objid 
        and isnull(org_objid,'') = isnull(tmp1.org_objid,'') 
    ) as ugm_objid 
  from ( 
    select user_objid, usergroup_objid, org_objid, count(*) as icount 
    from sys_usergroup_member 
    group by user_objid, usergroup_objid, org_objid 
    having count(*) > 1
  )tmp1 
)tmp2, sys_usergroup_member ugm 
where ugm.user_objid = tmp2.user_objid 
  and ugm.usergroup_objid = tmp2.usergroup_objid 
  and isnull(ugm.org_objid,'') = isnull(tmp2.org_objid,'') 
  and ugm.objid <> tmp2.ugm_objid 
go 
delete from sys_usergroup_member where objid in (
  select objid from ztmp_duplicate_usergroupmember
)
go 
drop table ztmp_duplicate_usergroupmember
go 


insert into sys_usergroup_member ( 
  objid, usergroup_objid, user_objid, user_username, user_firstname, user_lastname 
) 
select tmp1.* 
from ( 
  select 
    ('UGM-'+ convert(varchar(50), HashBytes('MD5', (u.objid + ug.objid)), 2)) as objid, 
    ug.objid as usergroup_objid, u.objid as user_objid, 
    u.username as user_username, u.firstname as user_firstname, u.lastname as user_lastname 
  from 
    ( 
      select * from sys_usergroup 
      where domain = 'TREASURY' 
        and role in ('AFO_ADMIN','COLLECTOR_ADMIN','LIQ_OFFICER_ADMIN','APPROVER') 
    ) ug, 
    (
      select * from sys_user where username = 'ADMIN' 
    ) u 
)tmp1 
where (
    select count(*) from sys_usergroup_member 
    where user_objid = tmp1.user_objid 
      and usergroup_objid = tmp1.usergroup_objid 
  ) = 0 
go 

if object_id('dbo.vw_entityrelation', 'V') IS NOT NULL 
  drop view dbo.vw_entityrelation; 
go
