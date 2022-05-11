/* MACHUSE: TAXABLE SUPPORT  */

alter table machuse add taxable int
go
update machuse set taxable = 1 where taxable is null
go
create unique index ux_actualuseid_taxable on machuse(machrpuid, actualuse_objid, taxable)
go


/* SYNCDATA: pre-download file */

if exists(select * from sysobjects where id = object_id('rpt_syncdata_item_completed'))
begin
  drop table rpt_syncdata_item_completed
end 
go 
if exists(select * from sysobjects where id = object_id('rpt_syncdata_completed'))
begin
  drop table rpt_syncdata_completed
end 
go 
if exists(select * from sysobjects where id = object_id('rpt_syncdata_item'))
begin
  drop table rpt_syncdata_item
end 
go 
if exists(select * from sysobjects where id = object_id('rpt_syncdata'))
begin
  drop table rpt_syncdata
end 
go 
if exists(select * from sysobjects where id = object_id('rpt_syncdata_forsync'))
begin
  drop table rpt_syncdata_forsync
end 
go 
if exists(select * from sysobjects where id = object_id('rpt_syncdata_fordownload'))
begin
  drop table rpt_syncdata_fordownload
end 
go 

CREATE TABLE rpt_syncdata_forsync (
  objid varchar(50) NOT NULL,
  reftype varchar(50) NOT NULL,
  refno varchar(50) NOT NULL,
  action varchar(50) NOT NULL,
  orgid varchar(50) NOT NULL,
  dtfiled datetime NOT NULL,
  createdby_objid varchar(50) DEFAULT NULL,
  createdby_name varchar(255) DEFAULT NULL,
  createdby_title varchar(50) DEFAULT NULL,
  remote_orgid varchar(15) DEFAULT NULL,
  state varchar(25) DEFAULT NULL,
  info text,
  PRIMARY KEY (objid)
) 
go 

create index ix_refno on rpt_syncdata_forsync (refno)
go
create index ix_orgid on rpt_syncdata_forsync (orgid)
go
create index ix_state on rpt_syncdata_forsync (state)
go

CREATE TABLE rpt_syncdata_fordownload (
  objid varchar(255) NOT NULL,
  etag varchar(64) NOT NULL,
  error int NOT NULL,
  state varchar(50) DEFAULT NULL,
  PRIMARY KEY (objid)
) 
go

create index ix_error on rpt_syncdata_fordownload (error)
go
create index ix_state on rpt_syncdata_fordownload (state)
go

CREATE TABLE rpt_syncdata (
  objid varchar(50) NOT NULL,
  state varchar(25) NOT NULL,
  refid varchar(50) NOT NULL,
  reftype varchar(50) NOT NULL,
  refno varchar(50) NOT NULL,
  action varchar(50) NOT NULL,
  dtfiled datetime NOT NULL,
  orgid varchar(50) NOT NULL,
  remote_orgid varchar(50) DEFAULT NULL,
  remote_orgcode varchar(5) DEFAULT NULL,
  remote_orgclass varchar(25) DEFAULT NULL,
  sender_objid varchar(50) DEFAULT NULL,
  sender_name varchar(255) DEFAULT NULL,
  sender_title varchar(80) DEFAULT NULL,
  info text,
  PRIMARY KEY (objid)
)
go

create index ix_state on rpt_syncdata (state)
go
create index ix_refid on rpt_syncdata (refid)
go
create index ix_refno on rpt_syncdata (refno)
go
create index ix_orgid on rpt_syncdata (orgid)
go

CREATE TABLE rpt_syncdata_item (
  objid varchar(50) NOT NULL,
  parentid varchar(50) NOT NULL,
  state varchar(25) NOT NULL,
  refid varchar(50) NOT NULL,
  reftype varchar(50) NOT NULL,
  refno varchar(50) NOT NULL,
  action varchar(50) NOT NULL,
  idx int NOT NULL,
  info text,
  error text,
  filekey varchar(1200) DEFAULT NULL,
  etag varchar(255) DEFAULT NULL,
  PRIMARY KEY (objid)
) 
go 

create index ix_parentid on rpt_syncdata_item (parentid)
go
create index ix_state on rpt_syncdata_item (state)
go
create index ix_refid on rpt_syncdata_item (refid)
go
create index ix_refno on rpt_syncdata_item (refno)
go
alter table rpt_syncdata_item 
add CONSTRAINT rpt_syncdata_item_ibfk_1 FOREIGN KEY (parentid) REFERENCES rpt_syncdata (objid)
go 

CREATE TABLE rpt_syncdata_completed (
  objid varchar(50) NOT NULL,
  action varchar(50) NOT NULL,
  refid varchar(50) NOT NULL,
  reftype varchar(50) NOT NULL,
  refno varchar(50) NOT NULL,
  sender_name varchar(255) DEFAULT NULL,
  sender_title varchar(80) DEFAULT NULL,
  dtcreated datetime DEFAULT NULL,
  info text,
  dtfiled datetime DEFAULT NULL,
  orgid varchar(50) DEFAULT NULL,
  sender_objid varchar(50) DEFAULT NULL,
  remote_orgid varchar(50) DEFAULT NULL,
  remote_orgcode varchar(25) DEFAULT NULL,
  remote_orgclass varchar(25) DEFAULT NULL,
  PRIMARY KEY (objid)
) 
go

create index ix_refid on rpt_syncdata_completed (refid)
go
create index ix_refno on rpt_syncdata_completed (refno)
go

CREATE TABLE rpt_syncdata_item_completed (
  objid varchar(255) NOT NULL,
  parentid varchar(50) NOT NULL,
  refid varchar(50) DEFAULT NULL,
  reftype varchar(50) DEFAULT NULL,
  refno varchar(50) DEFAULT NULL,
  action varchar(100) DEFAULT NULL,
  idx int DEFAULT NULL,
  info text,
  PRIMARY KEY (objid)
) 
go 

create index ix_refno on rpt_syncdata_item_completed (refno)
go
create index ix_refid on rpt_syncdata_item_completed (refid)
go
create index ix_remote_orgid on rpt_syncdata_item_completed (parentid)
go





/* RPT CERTIFICATION WORKFLOW */
delete from sys_wf_node where processname = 'rptcertification';
delete from sys_wf_transition where processname = 'rptcertificastion';

INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role], [properties], [ui], [tracktime]) VALUES ('start', 'rptcertification', 'Start', 'start', '1', NULL, NULL, NULL, '[:]', '[fillColor:''#00ff00'',size:[32,32],pos:[102,127],type:''start'']', NULL)
GO
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role], [properties], [ui], [tracktime]) VALUES ('receiver', 'rptcertification', 'Received', 'state', '2', NULL, 'RPT', 'CERTIFICATION_ISSUER', '[:]', '[fillColor:''#c0c0c0'',size:[114,40],pos:[206,127],type:''state'']', '1')
GO
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role], [properties], [ui], [tracktime]) VALUES ('verifier', 'rptcertification', 'For Verification', 'state', '3', NULL, 'RPT', 'CERTIFICATION_VERIFIER', '[:]', '[fillColor:''#c0c0c0'',size:[129,44],pos:[412,127],type:''state'']', '1')
GO
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role], [properties], [ui], [tracktime]) VALUES ('approver', 'rptcertification', 'For Approval', 'state', '4', NULL, 'RPT', 'CERTIFICATION_APPROVER', '[:]', '[fillColor:''#c0c0c0'',size:[118,42],pos:[604,141],type:''state'']', '1')
GO
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role], [properties], [ui], [tracktime]) VALUES ('assign-releaser', 'rptcertification', 'Releasing', 'state', '6', NULL, 'RPT', 'CERTIFICATION_RELEASER', '[:]', '[fillColor:''#c0c0c0'',size:[118,42],pos:[604,141],type:''state'']', '1')
GO
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role], [properties], [ui], [tracktime]) VALUES ('releaser', 'rptcertification', 'For Release', 'state', '7', NULL, 'RPT', 'CERTIFICATION_RELEASER', '[:]', '[fillColor:''#c0c0c0'',size:[118,42],pos:[604,141],type:''state'']', '1')
GO
INSERT INTO sys_wf_node ([name], [processname], [title], [nodetype], [idx], [salience], [domain], [role], [properties], [ui], [tracktime]) VALUES ('released', 'rptcertification', 'Released', 'end', '8', NULL, 'RPT', 'CERTIFICATION_RELEASER', '[:]', '[fillColor:''#ff0000'',size:[32,32],pos:[797,148],type:''end'']', '1')
GO

INSERT INTO sys_wf_transition ([parentid], [processname], [action], [to], [idx], [eval], [properties], [permission], [caption], [ui]) VALUES ('start', 'rptcertification', 'assign', 'receiver', '1', NULL, '[:]', NULL, 'Assign', '[size:[72,0],pos:[134,142],type:''arrow'',points:[134,142,206,142]]')
GO
INSERT INTO sys_wf_transition ([parentid], [processname], [action], [to], [idx], [eval], [properties], [permission], [caption], [ui]) VALUES ('receiver', 'rptcertification', 'cancelissuance', 'end', '5', NULL, '[caption:''Cancel Issuance'', confirm:''Cancel issuance?'',closeonend:true]', NULL, 'Cancel Issuance', '[size:[559,116],pos:[258,32],type:''arrow'',points:[262,127,258,32,817,40,813,148]]')
GO
INSERT INTO sys_wf_transition ([parentid], [processname], [action], [to], [idx], [eval], [properties], [permission], [caption], [ui]) VALUES ('receiver', 'rptcertification', 'submit', 'verifier', '6', NULL, '[caption:''Submit to Verifier'', confirm:''Submit to verifier?'', messagehandler:''rptmessage:info'',targetrole:''RPT.CERTIFICATION_VERIFIER'']', NULL, 'Submit to Verifier', '[size:[92,0],pos:[320,146],type:''arrow'',points:[320,146,412,146]]')
GO
INSERT INTO sys_wf_transition ([parentid], [processname], [action], [to], [idx], [eval], [properties], [permission], [caption], [ui]) VALUES ('verifier', 'rptcertification', 'return_receiver', 'receiver', '10', NULL, '[caption:''Return to Issuer'', confirm:''Return to issuer?'', messagehandler:''default'']', NULL, 'Return to Receiver', '[size:[160,63],pos:[292,64],type:''arrow'',points:[452,127,385,64,292,127]]')
GO
INSERT INTO sys_wf_transition ([parentid], [processname], [action], [to], [idx], [eval], [properties], [permission], [caption], [ui]) VALUES ('verifier', 'rptcertification', 'submit', 'approver', '11', NULL, '[caption:''Submit for Approval'', confirm:''Submit for approval?'', messagehandler:''rptmessage:sign'',targetrole:''RPT.CERTIFICATION_APPROVER'']', NULL, 'Submit to Approver', '[size:[63,4],pos:[541,152],type:''arrow'',points:[541,152,604,156]]')
GO
INSERT INTO sys_wf_transition ([parentid], [processname], [action], [to], [idx], [eval], [properties], [permission], [caption], [ui]) VALUES ('approver', 'rptcertification', 'return_receiver', 'receiver', '15', NULL, '[caption:''Return to Issuer'', confirm:''Return to issuer?'', messagehandler:''default'']', NULL, 'Return to Receiver', '[size:[333,113],pos:[285,167],type:''arrow'',points:[618,183,414,280,285,167]]')
GO
INSERT INTO sys_wf_transition ([parentid], [processname], [action], [to], [idx], [eval], [properties], [permission], [caption], [ui]) VALUES ('approver', 'rptcertification', 'submit', 'assign-releaser', '16', NULL, '[caption:''Approve'', confirm:''Approve?'', messagehandler:''rptmessage:sign'']', NULL, 'Approve', '[size:[75,0],pos:[722,162],type:''arrow'',points:[722,162,797,162]]')
GO
INSERT INTO sys_wf_transition ([parentid], [processname], [action], [to], [idx], [eval], [properties], [permission], [caption], [ui]) VALUES ('assign-releaser', 'rptcertification', 'assign', 'releaser', '20', NULL, '[caption:''Assign to Me'', confirm:''Assign task to you?'']', NULL, 'Assign To Me', '[size:[63,4],pos:[541,152],type:''arrow'',points:[541,152,604,156]]')
GO
INSERT INTO sys_wf_transition ([parentid], [processname], [action], [to], [idx], [eval], [properties], [permission], [caption], [ui]) VALUES ('releaser', 'rptcertification', 'submit', 'released', '100', '', '[caption:''Release Certification'', confirm:''Release certifications?'', closeonend:false, messagehandler:''rptmessage:info'']', '', 'Release Certification', '[:]')
GO

INSERT INTO  sys_usergroup ([objid], [title], [domain], [userclass], [orgclass], [role]) VALUES ('RPT.CERTIFICATION_APPROVER', 'CERTIFICATION_APPROVER', 'RPT', NULL, NULL, 'CERTIFICATION_APPROVER')
GO
INSERT INTO  sys_usergroup ([objid], [title], [domain], [userclass], [orgclass], [role]) VALUES ('RPT.CERTIFICATION_ISSUER', 'CERTIFICATION_ISSUER', 'RPT', 'usergroup', NULL, 'CERTIFICATION_ISSUER')
GO
INSERT INTO  sys_usergroup ([objid], [title], [domain], [userclass], [orgclass], [role]) VALUES ('RPT.CERTIFICATION_RELEASER', 'RPT CERTIFICATION_RELEASER', 'RPT', NULL, NULL, 'CERTIFICATION_RELEASER')
GO
INSERT INTO  sys_usergroup ([objid], [title], [domain], [userclass], [orgclass], [role]) VALUES ('RPT.CERTIFICATION_VERIFIER', 'RPT CERTIFICATION_VERIFIER', 'RPT', NULL, NULL, 'CERTIFICATION_VERIFIER')
GO


alter table rptcertification add taskid varchar(50)
go

CREATE TABLE rptcertification_task (
  objid varchar(50) NOT NULL,
  refid varchar(50) DEFAULT NULL,
  parentprocessid varchar(50) DEFAULT NULL,
  state varchar(50) DEFAULT NULL,
  startdate datetime DEFAULT NULL,
  enddate datetime DEFAULT NULL,
  assignee_objid varchar(50) DEFAULT NULL,
  assignee_name varchar(100) DEFAULT NULL,
  assignee_title varchar(80) DEFAULT NULL,
  actor_objid varchar(50) DEFAULT NULL,
  actor_name varchar(100) DEFAULT NULL,
  actor_title varchar(80) DEFAULT NULL,
  message varchar(255) DEFAULT NULL,
  signature text,
  returnedby varchar(100) DEFAULT NULL,
  PRIMARY KEY (objid)
) 
go 

create index ix_refid on rptcertification_task (refid)
go 

create index ix_assignee_objid on rptcertification_task (assignee_objid)
go 

alter table rptcertification_task 
add CONSTRAINT rptcertification_task_ibfk_1 FOREIGN KEY (refid) REFERENCES rptcertification (objid)
go 