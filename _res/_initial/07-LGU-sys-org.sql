
INSERT INTO `sys_org` (`objid`, `name`, `orgclass`, `parent_objid`, `parent_orgclass`, `code`, `root`, `txncode`) 
VALUES ('047', 'BOHOL', 'PROVINCE', NULL, NULL, '047', '0', NULL);

INSERT INTO `sys_org` (`objid`, `name`, `orgclass`, `parent_objid`, `parent_orgclass`, `code`, `root`, `txncode`) 
VALUES ('047-18', 'DANAO', 'MUNICIPALITY', '047', 'PROVINCE', '047-18', '0', NULL);


INSERT INTO `province` (`objid`, `state`, `indexno`, `pin`, `name`, `governor_title`, `governor_office`, `assessor_title`, `assessor_office`, `treasurer_title`, `treasurer_office`, `address`, `fullname`) 
VALUES ('047', 'DRAFT', '047', '047', 'BOHOL', 'GOVERNOR', 'OFFICE OF THE GOVERNOR', 'PROVINCIAL ASSESSOR', 'PROVINCIAL ASSESSORS OFFICE', 'PROVINCIAL TREASURER', 'PROVINCIAL TREASURY OFFICE', 'NEW CAPITOL, GOV. LINO I. CHATTO DRIVE, COGON DISTRICT, TAGBILARAN CITY, BOHOL', 'PROVINCE OF BOHOL');

INSERT INTO `municipality` (`objid`, `state`, `indexno`, `pin`, `name`, `mayor_title`, `mayor_office`, `assessor_title`, `assessor_office`, `treasurer_title`, `treasurer_office`, `address`, `fullname`) 
VALUES ('047-18', 'DRAFT', '18', '047-18', 'DANAO', 'MUNICIPAL MAYOR', 'OFFICE OF THE MUNICIPAL MAYOR', 'MUNICIPAL ASSESSOR', 'OFFICE OF THE MUNICIPAL ASSESSOR', 'ACTING MUNICIPAL TREASURER', 'OFFICE OF THE MUNICIPAL TREASURER', 'DANAO', 'MUNICIPALITY OF DANAO');


DELETE FROM sys_org WHERE objid = '00000';
DELETE FROM sys_org WHERE objid = '000';
