use etracs255_bayombong
go 

alter table itemaccount_tag add objid varchar(50) null 
go
update aa set 
	aa.objid = ('IATAG-'+ convert(varchar(50), HashBytes('MD5', (aa.acctid + aa.tag)), 2)) 
from itemaccount_tag aa 
where aa.objid is null 
go 
alter table itemaccount_tag alter column objid varchar(50) not null 
go
alter table itemaccount_tag drop constraint PK__itemacco__F0D46B2B5EAA0504
go 
alter table itemaccount_tag add constraint pk_itemaccount_tag primary key (objid) 
go 
create index ix_acctid on itemaccount_tag (acctid)
go 
