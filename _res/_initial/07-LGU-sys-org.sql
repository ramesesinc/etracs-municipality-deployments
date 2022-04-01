
set @_province_pin  = '079' ;
set @_province_name = 'DAVAO DE ORO' ;

set @_municipal_index = '08' ;
set @_municipal_name  = 'MONTEVISTA' ;


--
-- begin process
-- 
INSERT INTO `sys_org` (`objid`, `name`, `orgclass`, `parent_objid`, `parent_orgclass`, `code`, `root`, `txncode`) 
VALUES (@_province_pin, @_province_name, 'PROVINCE', NULL, NULL, @_province_pin, '0', NULL);

set @muni_id  = concat(@_province_pin, @_municipal_index); 
set @muni_pin = concat(@_province_pin, '-', @_municipal_index); 

INSERT INTO `sys_org` (`objid`, `name`, `orgclass`, `parent_objid`, `parent_orgclass`, `code`, `root`, `txncode`) 
VALUES (@muni_id, @_municipal_name, 'MUNICIPALITY', @_province_pin, 'PROVINCE', @muni_pin, '1', NULL);

INSERT INTO `province` (`objid`, `state`, `indexno`, `pin`, `name`, `governor_title`, `governor_office`, `assessor_title`, `assessor_office`, `treasurer_title`, `treasurer_office`, `address`, `fullname`) 
VALUES (@_province_pin, 'DRAFT', @_province_pin, @_province_pin, @_province_name, 'GOVERNOR', 'OFFICE OF THE GOVERNOR', 'PROVINCIAL ASSESSOR', 'PROVINCIAL ASSESSORS OFFICE', 'PROVINCIAL TREASURER', 'PROVINCIAL TREASURY OFFICE', '', CONCAT('PROVINCE OF ', @_province_name));

INSERT INTO `municipality` (`objid`, `state`, `indexno`, `pin`, `name`, `mayor_title`, `mayor_office`, `assessor_title`, `assessor_office`, `treasurer_title`, `treasurer_office`, `address`, `fullname`) 
VALUES (@muni_id, 'DRAFT', @_municipal_index, @muni_pin, @_municipal_name, 'MUNICIPAL MAYOR', 'OFFICE OF THE MUNICIPAL MAYOR', 'MUNICIPAL ASSESSOR', 'OFFICE OF THE MUNICIPAL ASSESSOR', 'ACTING MUNICIPAL TREASURER', 'OFFICE OF THE MUNICIPAL TREASURER', 'DANAO', CONCAT('MUNICIPALITY OF ', @_municipal_name));

DELETE FROM sys_org WHERE objid = '00000';
DELETE FROM sys_org WHERE objid = '000';
--
-- end process
-- 
