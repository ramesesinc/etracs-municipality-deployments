update sys_sequence set objid = ('TDNO-' + objid ) where objid like '[0-9][0-9]%'
go 



create table faas_requested_series (
  objid varchar(50) not null,
  parentid varchar(50) not null,
  series varchar(255) not null,
  requestedby_name varchar(255) not null,
  requestedby_date date not null,
  createdby_name varchar(255) not null,
  createdby_date datetime not null,
  primary key (objid)
) 
go 

create index fk_faas_requested_series_sys_sequence on faas_requested_series (parentid)
go 

alter table faas_requested_series 
  add constraint fk_faas_requested_series_sys_sequence 
  foreign key (parentid) references sys_sequence (objid)
go 