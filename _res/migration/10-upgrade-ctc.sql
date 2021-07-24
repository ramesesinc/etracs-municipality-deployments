use etracs255_bayombong
go

-- 
-- delete old rules and rulesets 
--  
delete from sys_rule_action_param where parentid in ( 
	select distinct ra.objid 
	from sys_ruleset rs 
		inner join sys_rule r on r.ruleset = rs.name 
		inner join sys_rule_action ra on ra.parentid = r.objid 
	where rs.name in ('ctcindividual','ctccorporate')
)
;
delete from sys_rule_action where parentid in ( 
	select distinct r.objid 
	from sys_ruleset rs 
		inner join sys_rule r on r.ruleset = rs.name 
	where rs.name in ('ctcindividual','ctccorporate')
)
;
delete from sys_rule_condition_constraint where parentid in ( 
	select rc.objid 
	from sys_ruleset rs 
		inner join sys_rule r on r.ruleset = rs.name 
		inner join sys_rule_condition rc on rc.parentid = r.objid 
	where rs.name in ('ctcindividual','ctccorporate')
)
;
delete from sys_rule_condition_var where parentid in ( 
	select rc.objid 
	from sys_ruleset rs 
		inner join sys_rule r on r.ruleset = rs.name 
		inner join sys_rule_condition rc on rc.parentid = r.objid 
	where rs.name in ('ctcindividual','ctccorporate')
)
;
delete from sys_rule_condition where parentid in ( 
	select r.objid 
	from sys_ruleset rs 
		inner join sys_rule r on r.ruleset = rs.name 
	where rs.name in ('ctcindividual','ctccorporate')
)
;
delete from sys_rule_deployed where objid in (
	select objid from sys_rule where ruleset in ('ctcindividual','ctccorporate')
)
;
delete from sys_rule where ruleset in ('ctcindividual','ctccorporate')
;



delete from sys_rule_actiondef_param where parentid in ( 
	select distinct rsa.actiondef  
	from sys_ruleset rs 
		inner join sys_ruleset_actiondef rsa on rsa.ruleset = rs.name 
	where rs.name in ('ctcindividual','ctccorporate')
)
;
delete from sys_rule_actiondef where objid in ( 
	select distinct rsa.actiondef  
	from sys_ruleset rs 
		inner join sys_ruleset_actiondef rsa on rsa.ruleset = rs.name 
	where rs.name in ('ctcindividual','ctccorporate')
)
;
delete from sys_rule_fact_field where parentid in ( 
	select distinct rsf.rulefact 
	from sys_ruleset rs 
		inner join sys_ruleset_fact rsf on rsf.ruleset = rs.name 
	where rs.name in ('ctcindividual','ctccorporate')
)
;
delete from sys_rule_fact where objid in ( 
	select distinct rsf.rulefact 
	from sys_ruleset rs 
		inner join sys_ruleset_fact rsf on rsf.ruleset = rs.name 
	where rs.name in ('ctcindividual','ctccorporate')
)
;
delete from sys_ruleset_fact where ruleset in (
	select rs.name from sys_ruleset rs 
	where rs.name in ('ctcindividual','ctccorporate')
)
;
delete from sys_ruleset_actiondef where ruleset in (
	select rs.name from sys_ruleset rs 
	where rs.name in ('ctcindividual','ctccorporate')
)
;
delete from sys_rulegroup where ruleset in ('ctcindividual','ctccorporate')
;
delete from sys_ruleset where name in ('ctcindividual','ctccorporate')
;

go 

-- 
-- insert ctcbilling rulesets
-- 
INSERT INTO sys_ruleset (name, title, packagename, domain, role, permission) VALUES ('ctcbilling', 'Community Tax Billing', 'ctc', 'CTC', 'RULE_AUTHOR', NULL);

go 

INSERT INTO sys_rulegroup (name, ruleset, title, sortorder) VALUES ('compute-bill', 'ctcbilling', 'Compute Bill', '1');
INSERT INTO sys_rulegroup (name, ruleset, title, sortorder) VALUES ('compute-discount', 'ctcbilling', 'Compute Discount', '3');
INSERT INTO sys_rulegroup (name, ruleset, title, sortorder) VALUES ('compute-interest', 'ctcbilling', 'Compute Interest', '5');
INSERT INTO sys_rulegroup (name, ruleset, title, sortorder) VALUES ('compute-surcharge', 'ctcbilling', 'Compute Surcharge', '4');
INSERT INTO sys_rulegroup (name, ruleset, title, sortorder) VALUES ('post-compute-bill', 'ctcbilling', 'Post Compute Bill', '2');
INSERT INTO sys_rulegroup (name, ruleset, title, sortorder) VALUES ('summary', 'ctcbilling', 'Summary', '6');

go 

INSERT INTO sys_rule_fact (objid, name, title, factclass, sortorder, handler, defaultvarname, dynamic, lookuphandler, lookupkey, lookupvalue, lookupdatatype, dynamicfieldname, builtinconstraints, domain, factsuperclass) VALUES ('com.rameses.rules.common.CurrentDate', 'com.rameses.rules.common.CurrentDate', 'Current Date', 'com.rameses.rules.common.CurrentDate', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SYSTEM', NULL);
INSERT INTO sys_rule_fact (objid, name, title, factclass, sortorder, handler, defaultvarname, dynamic, lookuphandler, lookupkey, lookupvalue, lookupdatatype, dynamicfieldname, builtinconstraints, domain, factsuperclass) VALUES ('ctc.facts.CorporateCTC', 'ctc.facts.CorporateCTC', 'Corporate CTC', 'ctc.facts.CorporateCTC', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'CTC', NULL);
INSERT INTO sys_rule_fact (objid, name, title, factclass, sortorder, handler, defaultvarname, dynamic, lookuphandler, lookupkey, lookupvalue, lookupdatatype, dynamicfieldname, builtinconstraints, domain, factsuperclass) VALUES ('ctc.facts.IndividualCTC', 'ctc.facts.IndividualCTC', 'Individual CTC', 'ctc.facts.IndividualCTC', '1', NULL, 'ICTC', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'CTC', NULL);
INSERT INTO sys_rule_fact (objid, name, title, factclass, sortorder, handler, defaultvarname, dynamic, lookuphandler, lookupkey, lookupvalue, lookupdatatype, dynamicfieldname, builtinconstraints, domain, factsuperclass) VALUES ('enterprise.facts.DateInfo', 'enterprise.facts.DateInfo', 'Date Info', 'enterprise.facts.DateInfo', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ENTERPRISE', 'enterprise.facts.VariableInfo');
INSERT INTO sys_rule_fact (objid, name, title, factclass, sortorder, handler, defaultvarname, dynamic, lookuphandler, lookupkey, lookupvalue, lookupdatatype, dynamicfieldname, builtinconstraints, domain, factsuperclass) VALUES ('treasury.facts.BillItem', 'treasury.facts.BillItem', 'Bill Item', 'treasury.facts.BillItem', '1', NULL, 'BILLITEM', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'TREASURY', 'treasury.facts.AbstractBillItem');
INSERT INTO sys_rule_fact (objid, name, title, factclass, sortorder, handler, defaultvarname, dynamic, lookuphandler, lookupkey, lookupvalue, lookupdatatype, dynamicfieldname, builtinconstraints, domain, factsuperclass) VALUES ('treasury.facts.DueDate', 'treasury.facts.DueDate', 'Due Date', 'treasury.facts.DueDate', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'TREASURY', NULL);

go 

INSERT INTO sys_rule_fact (objid, name, title, factclass, sortorder, handler, defaultvarname, dynamic, lookuphandler, lookupkey, lookupvalue, lookupdatatype, dynamicfieldname, builtinconstraints, domain, factsuperclass) VALUES ('ctc.facts.CorporateCTC', 'ctc.facts.CorporateCTC', 'Corporate CTC', 'ctc.facts.CorporateCTC', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'CTC', NULL);
INSERT INTO sys_rule_fact (objid, name, title, factclass, sortorder, handler, defaultvarname, dynamic, lookuphandler, lookupkey, lookupvalue, lookupdatatype, dynamicfieldname, builtinconstraints, domain, factsuperclass) VALUES ('ctc.facts.IndividualCTC', 'ctc.facts.IndividualCTC', 'Individual CTC', 'ctc.facts.IndividualCTC', '1', NULL, 'ICTC', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'CTC', NULL);
INSERT INTO sys_rule_fact (objid, name, title, factclass, sortorder, handler, defaultvarname, dynamic, lookuphandler, lookupkey, lookupvalue, lookupdatatype, dynamicfieldname, builtinconstraints, domain, factsuperclass) VALUES ('treasury.facts.DueDate', 'treasury.facts.DueDate', 'Due Date', 'treasury.facts.DueDate', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'TREASURY', NULL);

go 

CREATE TABLE [dbo].[ztmp_migration_sys_rule_fact_field] (
[objid] varchar(255) NOT NULL ,
[parentid] varchar(50) NULL ,
[name] varchar(50) NOT NULL ,
[title] varchar(160) NULL ,
[datatype] varchar(50) NULL ,
[sortorder] int NULL ,
[handler] varchar(50) NULL ,
[lookuphandler] varchar(50) NULL ,
[lookupkey] varchar(50) NULL ,
[lookupvalue] varchar(50) NULL ,
[lookupdatatype] varchar(50) NULL ,
[multivalued] int NULL ,
[required] int NULL ,
[vardatatype] varchar(50) NULL ,
[lovname] varchar(50) NULL 
)
go 

INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('com.rameses.rules.common.CurrentDate.date', 'com.rameses.rules.common.CurrentDate', 'date', 'Date', 'date', '4', 'date', NULL, NULL, NULL, NULL, NULL, NULL, 'date', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('com.rameses.rules.common.CurrentDate.day', 'com.rameses.rules.common.CurrentDate', 'day', 'Day', 'integer', '5', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('com.rameses.rules.common.CurrentDate.month', 'com.rameses.rules.common.CurrentDate', 'month', 'Month', 'integer', '3', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('com.rameses.rules.common.CurrentDate.qtr', 'com.rameses.rules.common.CurrentDate', 'qtr', 'Qtr', 'integer', '1', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('com.rameses.rules.common.CurrentDate.year', 'com.rameses.rules.common.CurrentDate', 'year', 'Year', 'integer', '2', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.CorporateCTC.additional', 'ctc.facts.CorporateCTC', 'additional', 'Is Additional?', 'boolean', '5', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.CorporateCTC.additionaltax', 'ctc.facts.CorporateCTC', 'additionaltax', 'Additional Tax', 'decimal', '9', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.CorporateCTC.basictax', 'ctc.facts.CorporateCTC', 'basictax', 'Basic Tax', 'decimal', '6', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.CorporateCTC.businessgross', 'ctc.facts.CorporateCTC', 'businessgross', 'Business Gross', 'decimal', '3', 'decimal', NULL, NULL, NULL, NULL, NULL, '0', 'decimal', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.CorporateCTC.businessgrosstax', 'ctc.facts.CorporateCTC', 'businessgrosstax', 'Business Gross Tax', 'decimal', '7', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.CorporateCTC.interest', 'ctc.facts.CorporateCTC', 'interest', 'Interest', 'decimal', '10', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.CorporateCTC.newbusiness', 'ctc.facts.CorporateCTC', 'newbusiness', 'Is New Business?', 'boolean', '4', 'boolean', NULL, NULL, NULL, NULL, NULL, '0', 'boolean', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.CorporateCTC.orgtype', 'ctc.facts.CorporateCTC', 'orgtype', 'Organization Type', 'string', '1', 'lov', NULL, NULL, NULL, NULL, NULL, '0', 'string', 'BUSINESS_ORG_TYPE');
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.CorporateCTC.propertyavtax', 'ctc.facts.CorporateCTC', 'propertyavtax', 'Property AV Tax', 'decimal', '8', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.CorporateCTC.realpropertyav', 'ctc.facts.CorporateCTC', 'realpropertyav', 'Real Property AV', 'decimal', '2', 'decimal', NULL, NULL, NULL, NULL, NULL, '0', 'decimal', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.CorporateCTC.totaltax', 'ctc.facts.CorporateCTC', 'totaltax', 'Total Tax', 'decimal', '11', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.IndividualCTC.additional', 'ctc.facts.IndividualCTC', 'additional', 'Is Additional?', 'boolean', '11', 'boolean', NULL, NULL, NULL, NULL, NULL, NULL, 'boolean', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.IndividualCTC.additionaltax', 'ctc.facts.IndividualCTC', 'additionaltax', 'Additional Tax', 'decimal', '16', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.IndividualCTC.age', 'ctc.facts.IndividualCTC', 'age', 'Age', 'integer', '19', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.IndividualCTC.annualsalary', 'ctc.facts.IndividualCTC', 'annualsalary', 'Annual Salary', 'decimal', '7', 'decimal', NULL, NULL, NULL, NULL, NULL, '0', 'decimal', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.IndividualCTC.barangayid', 'ctc.facts.IndividualCTC', 'barangayid', 'Barangay', 'string', '10', 'lookup', 'barangay:lookup', 'objid', 'name', NULL, NULL, NULL, 'string', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.IndividualCTC.basictax', 'ctc.facts.IndividualCTC', 'basictax', 'Basic Tax', 'decimal', '12', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.IndividualCTC.businessgross', 'ctc.facts.IndividualCTC', 'businessgross', 'Business Gross', 'decimal', '8', 'decimal', NULL, NULL, NULL, NULL, NULL, '0', 'decimal', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.IndividualCTC.businessgrosstax', 'ctc.facts.IndividualCTC', 'businessgrosstax', 'Business Gross Tax', 'decimal', '14', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.IndividualCTC.citizenship', 'ctc.facts.IndividualCTC', 'citizenship', 'Citizenship', 'string', '2', 'lov', NULL, NULL, NULL, NULL, NULL, '0', 'string', 'CITIZENSHIP');
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.IndividualCTC.civilstatus', 'ctc.facts.IndividualCTC', 'civilstatus', 'Civil Status', 'string', '4', 'lov', NULL, NULL, NULL, NULL, NULL, '0', 'string', 'CIVIL_STATUS');
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.IndividualCTC.gender', 'ctc.facts.IndividualCTC', 'gender', 'Gender', 'string', '3', 'lov', NULL, NULL, NULL, NULL, NULL, '0', 'string', 'GENDER');
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.IndividualCTC.interest', 'ctc.facts.IndividualCTC', 'interest', 'Interest', 'decimal', '18', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.IndividualCTC.newbusiness', 'ctc.facts.IndividualCTC', 'newbusiness', 'Is New Business?', 'boolean', '6', 'boolean', NULL, NULL, NULL, NULL, NULL, '0', 'boolean', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.IndividualCTC.profession', 'ctc.facts.IndividualCTC', 'profession', 'Profession', 'string', '1', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'string', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.IndividualCTC.propertyincome', 'ctc.facts.IndividualCTC', 'propertyincome', 'Property Income', 'decimal', '9', 'decimal', NULL, NULL, NULL, NULL, NULL, '0', 'decimal', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.IndividualCTC.propertyincometax', 'ctc.facts.IndividualCTC', 'propertyincometax', 'Property Income Tax', 'decimal', '15', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.IndividualCTC.salarytax', 'ctc.facts.IndividualCTC', 'salarytax', 'Salary Tax', 'decimal', '13', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.IndividualCTC.seniorcitizen', 'ctc.facts.IndividualCTC', 'seniorcitizen', 'Is Senior Citizen?', 'boolean', '5', 'boolean', NULL, NULL, NULL, NULL, NULL, '0', 'boolean', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('ctc.facts.IndividualCTC.totaltax', 'ctc.facts.IndividualCTC', 'totaltax', 'Total Tax', 'decimal', '17', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('enterprise.facts.DateInfo.day', 'enterprise.facts.DateInfo', 'day', 'Day', 'integer', '4', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('enterprise.facts.DateInfo.month', 'enterprise.facts.DateInfo', 'month', 'Month', 'integer', '3', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('enterprise.facts.DateInfo.name', 'enterprise.facts.DateInfo', 'name', 'Name', 'string', '5', 'lookup', 'variableinfo_date:lookup', 'name', 'name', NULL, NULL, '1', 'string', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('enterprise.facts.DateInfo.qtr', 'enterprise.facts.DateInfo', 'qtr', 'Qtr', 'integer', '1', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('enterprise.facts.DateInfo.value', 'enterprise.facts.DateInfo', 'value', 'Date', 'date', '6', 'date', NULL, NULL, NULL, NULL, NULL, '1', 'date', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('enterprise.facts.DateInfo.year', 'enterprise.facts.DateInfo', 'year', 'Year', 'integer', '2', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.BillItem.account', 'treasury.facts.BillItem', 'account', 'Account', 'string', '3', 'lookup', 'revenueitem:lookup', 'objid', 'title', NULL, NULL, NULL, 'object', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.BillItem.account.objid', 'treasury.facts.BillItem', 'account.objid', 'Account ID', 'string', '2', 'lookup', 'revenueitem:lookup', 'objid', 'title', NULL, NULL, NULL, 'string', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.BillItem.amount', 'treasury.facts.BillItem', 'amount', 'Amount', 'decimal', '1', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.BillItem.billrefid', 'treasury.facts.BillItem', 'billrefid', 'Bill Ref ID', 'string', '7', 'var', NULL, NULL, NULL, NULL, NULL, NULL, 'string', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.BillItem.discount', 'treasury.facts.BillItem', 'discount', 'Discount', 'decimal', '8', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.BillItem.duedate', 'treasury.facts.BillItem', 'duedate', 'Due Date', 'date', '4', 'date', NULL, NULL, NULL, NULL, NULL, NULL, 'date', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.BillItem.fromdate', 'treasury.facts.BillItem', 'fromdate', 'From Date', 'date', '14', 'date', NULL, NULL, NULL, NULL, NULL, NULL, 'date', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.BillItem.interest', 'treasury.facts.BillItem', 'interest', 'Interest', 'decimal', '11', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.BillItem.month', 'treasury.facts.BillItem', 'month', 'Month', 'integer', '13', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.BillItem.org', 'treasury.facts.BillItem', 'org', 'Org', 'string', '10', 'var', NULL, NULL, NULL, NULL, NULL, NULL, 'enterprise.facts.Org', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.BillItem.parentaccount', 'treasury.facts.BillItem', 'parentaccount', 'Parent Account', 'string', '9', 'lookup', 'revenueitem:lookup', 'objid', 'title', NULL, NULL, NULL, 'object', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.BillItem.paypriority', 'treasury.facts.BillItem', 'paypriority', 'Pay Priority', 'integer', '18', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.BillItem.refid', 'treasury.facts.BillItem', 'refid', 'Ref ID', 'string', '16', 'var', NULL, NULL, NULL, NULL, NULL, NULL, 'string', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.BillItem.remarks', 'treasury.facts.BillItem', 'remarks', 'Remarks', 'string', '17', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'string', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.BillItem.sortorder', 'treasury.facts.BillItem', 'sortorder', 'Sort Order', 'integer', '19', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.BillItem.surcharge', 'treasury.facts.BillItem', 'surcharge', 'Surcharge', 'decimal', '5', 'decimal', NULL, NULL, NULL, NULL, NULL, NULL, 'decimal', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.BillItem.tag', 'treasury.facts.BillItem', 'tag', 'Tag', 'string', '20', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'string', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.BillItem.todate', 'treasury.facts.BillItem', 'todate', 'To Date', 'date', '15', 'date', NULL, NULL, NULL, NULL, NULL, NULL, 'date', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.BillItem.txntype', 'treasury.facts.BillItem', 'txntype', 'Txn Type', 'string', '6', 'lookup', 'billitem_txntype:lookup', 'objid', 'title', NULL, NULL, NULL, 'string', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.BillItem.year', 'treasury.facts.BillItem', 'year', 'Year', 'integer', '12', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.DueDate.date', 'treasury.facts.DueDate', 'date', 'Date', 'date', '1', 'date', NULL, NULL, NULL, NULL, NULL, NULL, 'date', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.DueDate.day', 'treasury.facts.DueDate', 'day', 'Day', 'integer', '4', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.DueDate.month', 'treasury.facts.DueDate', 'month', 'Month', 'integer', '3', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.DueDate.qtr', 'treasury.facts.DueDate', 'qtr', 'Qtr', 'integer', '5', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL);
INSERT INTO ztmp_migration_sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) VALUES ('treasury.facts.DueDate.year', 'treasury.facts.DueDate', 'year', 'Year', 'integer', '2', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL);

INSERT INTO sys_rule_fact_field (
	objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname
) 
select  
	objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname
from ztmp_migration_sys_rule_fact_field z 
where objid not in (
	select objid from sys_rule_fact_field where objid = z.objid 
); 

drop table ztmp_migration_sys_rule_fact_field 
go 

INSERT INTO sys_rule_actiondef (objid, name, title, sortorder, actionname, domain, actionclass) VALUES ('treasury.actions.AddBillItem', 'add-billitem', 'Add Bill Item', '2', 'add-billitem', 'TREASURY', 'treasury.actions.AddBillItem');
INSERT INTO sys_rule_actiondef (objid, name, title, sortorder, actionname, domain, actionclass) VALUES ('treasury.actions.AddDueDate', 'add-duedate', 'Add Due Date', '1', 'add-duedate', 'TREASURY', 'treasury.actions.AddDueDate');
INSERT INTO sys_rule_actiondef (objid, name, title, sortorder, actionname, domain, actionclass) VALUES ('treasury.actions.UpdateFieldValue', 'update-field-value', 'Update Field Value', '0', 'update-field-value', 'TREASURY', 'treasury.actions.UpdateFieldValue');

go 

INSERT INTO sys_rule_actiondef_param (objid, parentid, name, sortorder, title, datatype, handler, lookuphandler, lookupkey, lookupvalue, vardatatype, lovname) VALUES ('treasury.actions.AddBillItem.account', 'treasury.actions.AddBillItem', 'account', '1', 'Account', NULL, 'lookup', 'revenueitem:lookup', 'objid', 'title', NULL, NULL);
INSERT INTO sys_rule_actiondef_param (objid, parentid, name, sortorder, title, datatype, handler, lookuphandler, lookupkey, lookupvalue, vardatatype, lovname) VALUES ('treasury.actions.AddBillItem.amount', 'treasury.actions.AddBillItem', 'amount', '2', 'Amount', NULL, 'expression', NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_actiondef_param (objid, parentid, name, sortorder, title, datatype, handler, lookuphandler, lookupkey, lookupvalue, vardatatype, lovname) VALUES ('treasury.actions.AddBillItem.fromdate', 'treasury.actions.AddBillItem', 'fromdate', '6', 'From Date', NULL, 'expression', NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_actiondef_param (objid, parentid, name, sortorder, title, datatype, handler, lookuphandler, lookupkey, lookupvalue, vardatatype, lovname) VALUES ('treasury.actions.AddBillItem.month', 'treasury.actions.AddBillItem', 'month', '5', 'Month', NULL, 'expression', NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_actiondef_param (objid, parentid, name, sortorder, title, datatype, handler, lookuphandler, lookupkey, lookupvalue, vardatatype, lovname) VALUES ('treasury.actions.AddBillItem.refid', 'treasury.actions.AddBillItem', 'refid', '9', 'Ref ID', NULL, 'var', NULL, NULL, NULL, 'string', NULL);
INSERT INTO sys_rule_actiondef_param (objid, parentid, name, sortorder, title, datatype, handler, lookuphandler, lookupkey, lookupvalue, vardatatype, lovname) VALUES ('treasury.actions.AddBillItem.remarks', 'treasury.actions.AddBillItem', 'remarks', '8', 'Remarks', NULL, 'expression', NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_actiondef_param (objid, parentid, name, sortorder, title, datatype, handler, lookuphandler, lookupkey, lookupvalue, vardatatype, lovname) VALUES ('treasury.actions.AddBillItem.todate', 'treasury.actions.AddBillItem', 'todate', '7', 'To Date', NULL, 'expression', NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_actiondef_param (objid, parentid, name, sortorder, title, datatype, handler, lookuphandler, lookupkey, lookupvalue, vardatatype, lovname) VALUES ('treasury.actions.AddBillItem.txntype', 'treasury.actions.AddBillItem', 'txntype', '3', 'Txn Type', NULL, 'lookup', 'billitem_txntype:lookup', 'objid', 'title', 'string', NULL);
INSERT INTO sys_rule_actiondef_param (objid, parentid, name, sortorder, title, datatype, handler, lookuphandler, lookupkey, lookupvalue, vardatatype, lovname) VALUES ('treasury.actions.AddBillItem.year', 'treasury.actions.AddBillItem', 'year', '4', 'Year', NULL, 'expression', NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_actiondef_param (objid, parentid, name, sortorder, title, datatype, handler, lookuphandler, lookupkey, lookupvalue, vardatatype, lovname) VALUES ('treasury.actions.AddDueDate.date', 'treasury.actions.AddDueDate', 'date', '1', 'Date', NULL, 'expression', NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_actiondef_param (objid, parentid, name, sortorder, title, datatype, handler, lookuphandler, lookupkey, lookupvalue, vardatatype, lovname) VALUES ('treasury.actions.AddDueDate.tag', 'treasury.actions.AddDueDate', 'tag', '2', 'Tag', 'string', 'string', NULL, NULL, NULL, 'string', NULL);
INSERT INTO sys_rule_actiondef_param (objid, parentid, name, sortorder, title, datatype, handler, lookuphandler, lookupkey, lookupvalue, vardatatype, lovname) VALUES ('treasury.actions.UpdateFieldValue.fieldname', 'treasury.actions.UpdateFieldValue', 'fieldname', '2', 'Field name', NULL, 'fieldlist', NULL, 'object', NULL, NULL, NULL);
INSERT INTO sys_rule_actiondef_param (objid, parentid, name, sortorder, title, datatype, handler, lookuphandler, lookupkey, lookupvalue, vardatatype, lovname) VALUES ('treasury.actions.UpdateFieldValue.object', 'treasury.actions.UpdateFieldValue', 'object', '1', 'Object', NULL, 'var', NULL, NULL, NULL, 'obj', NULL);
INSERT INTO sys_rule_actiondef_param (objid, parentid, name, sortorder, title, datatype, handler, lookuphandler, lookupkey, lookupvalue, vardatatype, lovname) VALUES ('treasury.actions.UpdateFieldValue.value', 'treasury.actions.UpdateFieldValue', 'value', '3', 'Value', NULL, 'expression', NULL, NULL, NULL, NULL, NULL);

go 

INSERT INTO sys_ruleset_actiondef (ruleset, actiondef) VALUES ('ctcbilling', 'treasury.actions.AddBillItem');
INSERT INTO sys_ruleset_actiondef (ruleset, actiondef) VALUES ('ctcbilling', 'treasury.actions.AddDueDate');
INSERT INTO sys_ruleset_actiondef (ruleset, actiondef) VALUES ('ctcbilling', 'treasury.actions.UpdateFieldValue');

go 

INSERT INTO sys_ruleset_fact (ruleset, rulefact) VALUES ('ctcbilling', 'com.rameses.rules.common.CurrentDate');
INSERT INTO sys_ruleset_fact (ruleset, rulefact) VALUES ('ctcbilling', 'ctc.facts.CorporateCTC');
INSERT INTO sys_ruleset_fact (ruleset, rulefact) VALUES ('ctcbilling', 'ctc.facts.IndividualCTC');
INSERT INTO sys_ruleset_fact (ruleset, rulefact) VALUES ('ctcbilling', 'enterprise.facts.DateInfo');
INSERT INTO sys_ruleset_fact (ruleset, rulefact) VALUES ('ctcbilling', 'treasury.facts.BillItem');
INSERT INTO sys_ruleset_fact (ruleset, rulefact) VALUES ('ctcbilling', 'treasury.facts.DueDate');

go


-- 
-- insert ctcbilling rules
--

INSERT INTO sys_rule (objid, state, name, ruleset, rulegroup, title, description, salience, effectivefrom, effectiveto, dtfiled, user_objid, user_name, noloop) VALUES ('RUL-476b5bbe:1641bbe1a54:-7ebc', 'DEPLOYED', 'CTC_INDIVIDUAL', 'ctcbilling', 'compute-bill', 'CTC_INDIVIDUAL', NULL, '50000', NULL, NULL, '2018-06-20 14:06:43', 'USR-ADMIN', 'ADMIN', '1');
INSERT INTO sys_rule (objid, state, name, ruleset, rulegroup, title, description, salience, effectivefrom, effectiveto, dtfiled, user_objid, user_name, noloop) VALUES ('RUL-b880e40:166bdcfa0cb:-7c8f', 'DEPLOYED', 'CTC_CORPORATE', 'ctcbilling', 'compute-bill', 'CTC_CORPORATE', NULL, '50000', NULL, NULL, '2018-10-29 11:32:08', 'USR-ADMIN', 'ADMIN', '1');
INSERT INTO sys_rule (objid, state, name, ruleset, rulegroup, title, description, salience, effectivefrom, effectiveto, dtfiled, user_objid, user_name, noloop) VALUES ('RUL17bb3bc0:16826bf0d4e:-7852', 'DEPLOYED', 'CORPORATE_CTC_ADDITIONAL', 'ctcbilling', 'post-compute-bill', 'CORPORATE CTC ADDITIONAL', NULL, '50000', NULL, NULL, '2019-01-07 14:04:34', 'USR-ADMIN', 'ADMIN', '1');
INSERT INTO sys_rule (objid, state, name, ruleset, rulegroup, title, description, salience, effectivefrom, effectiveto, dtfiled, user_objid, user_name, noloop) VALUES ('RUL4c78a9d4:16816354aab:-752c', 'DEPLOYED', 'INDIVIDUAL_CTC_SENIOR', 'ctcbilling', 'post-compute-bill', 'INDIVIDUAL_CTC_SENIOR', NULL, '50000', NULL, NULL, '2019-01-04 01:07:16', 'USR-ADMIN', 'ADMIN', '1');
INSERT INTO sys_rule (objid, state, name, ruleset, rulegroup, title, description, salience, effectivefrom, effectiveto, dtfiled, user_objid, user_name, noloop) VALUES ('RUL6729cd8:166bdeb1f30:-73c5', 'DEPLOYED', 'INDIVIDUAL_CTC_ADDITIONAL', 'ctcbilling', 'post-compute-bill', 'INDIVIDUAL CTC ADDITIONAL', NULL, '50000', NULL, NULL, '2018-10-29 11:52:30', 'USR-ADMIN', 'ADMIN', '1');
INSERT INTO sys_rule (objid, state, name, ruleset, rulegroup, title, description, salience, effectivefrom, effectiveto, dtfiled, user_objid, user_name, noloop) VALUES ('RUL48d0f0c4:169510e76b2:-59e1', 'DEPLOYED', 'CTC_CORPORATE_PENALTY', 'ctcbilling', 'compute-interest', 'CTC_CORPORATE_PENALTY', NULL, '50000', NULL, NULL, '2019-03-06 12:08:22', 'USR-ADMIN', 'ADMIN', '1');
INSERT INTO sys_rule (objid, state, name, ruleset, rulegroup, title, description, salience, effectivefrom, effectiveto, dtfiled, user_objid, user_name, noloop) VALUES ('RUL6729cd8:166bdeb1f30:-7ef6', 'DEPLOYED', 'CTC_INDIVIDUAL_PENALTY', 'ctcbilling', 'compute-interest', 'CTC INDIVIDUAL PENALTY', NULL, '50000', NULL, NULL, '2018-10-29 11:44:53', 'USR-ADMIN', 'ADMIN', '1');
INSERT INTO sys_rule (objid, state, name, ruleset, rulegroup, title, description, salience, effectivefrom, effectiveto, dtfiled, user_objid, user_name, noloop) VALUES ('RUL-b880e40:166bdcfa0cb:-77af', 'DEPLOYED', 'ADD_CORPORATE_CTC_BILL', 'ctcbilling', 'summary', 'ADD CORPORATE CTC BILL', NULL, '50000', NULL, NULL, '2018-10-29 11:36:40', 'USR-ADMIN', 'ADMIN', '1');
INSERT INTO sys_rule (objid, state, name, ruleset, rulegroup, title, description, salience, effectivefrom, effectiveto, dtfiled, user_objid, user_name, noloop) VALUES ('RUL6729cd8:166bdeb1f30:-5edf', 'DEPLOYED', 'ADD_CORPORATE_CTC_INTEREST', 'ctcbilling', 'summary', 'ADD CORPORATE CTC INTEREST', NULL, '1000', NULL, NULL, '2018-10-29 12:04:29', 'USR-ADMIN', 'ADMIN', '1');
INSERT INTO sys_rule (objid, state, name, ruleset, rulegroup, title, description, salience, effectivefrom, effectiveto, dtfiled, user_objid, user_name, noloop) VALUES ('RUL6729cd8:166bdeb1f30:-62a4', 'DEPLOYED', 'ADD_INDIVIDUAL_CTC_INTEREST', 'ctcbilling', 'summary', 'ADD INDIVIDUAL CTC INTEREST', NULL, '50000', NULL, NULL, '2018-10-29 12:03:09', 'USR-ADMIN', 'ADMIN', '1');
INSERT INTO sys_rule (objid, state, name, ruleset, rulegroup, title, description, salience, effectivefrom, effectiveto, dtfiled, user_objid, user_name, noloop) VALUES ('RUL7ff4a1a7:164fdd7d64a:-7f02', 'DEPLOYED', 'ADD_INDIVIDUAL_CTC_BILL', 'ctcbilling', 'summary', 'ADD INDIVIDUAL CTC BILL', NULL, '1000', NULL, NULL, '2018-08-03 11:33:38', 'USR-ADMIN', 'ADMIN', '1');

go 

update sys_rule set state = 'DRAFT' where ruleset='ctcbilling'; 

go 

INSERT INTO sys_rule_condition (objid, parentid, fact_name, fact_objid, varname, pos, ruletext, displaytext, dynamic_datatype, dynamic_key, dynamic_value, notexist) VALUES ('RCOND-b880e40:166bdcfa0cb:-7749', 'RUL-b880e40:166bdcfa0cb:-77af', 'ctc.facts.CorporateCTC', 'ctc.facts.CorporateCTC', NULL, '0', NULL, NULL, NULL, NULL, NULL, '0');
INSERT INTO sys_rule_condition (objid, parentid, fact_name, fact_objid, varname, pos, ruletext, displaytext, dynamic_datatype, dynamic_key, dynamic_value, notexist) VALUES ('RCOND6729cd8:166bdeb1f30:-5e3b', 'RUL6729cd8:166bdeb1f30:-5edf', 'ctc.facts.CorporateCTC', 'ctc.facts.CorporateCTC', NULL, '1', NULL, NULL, NULL, NULL, NULL, '0');
INSERT INTO sys_rule_condition (objid, parentid, fact_name, fact_objid, varname, pos, ruletext, displaytext, dynamic_datatype, dynamic_key, dynamic_value, notexist) VALUES ('RCOND7ff4a1a7:164fdd7d64a:-7ba1', 'RUL7ff4a1a7:164fdd7d64a:-7f02', 'ctc.facts.IndividualCTC', 'ctc.facts.IndividualCTC', 'ICTC', '0', NULL, NULL, NULL, NULL, NULL, '0');
INSERT INTO sys_rule_condition (objid, parentid, fact_name, fact_objid, varname, pos, ruletext, displaytext, dynamic_datatype, dynamic_key, dynamic_value, notexist) VALUES ('RCOND6729cd8:166bdeb1f30:-6250', 'RUL6729cd8:166bdeb1f30:-62a4', 'ctc.facts.IndividualCTC', 'ctc.facts.IndividualCTC', 'ICTC', '0', NULL, NULL, NULL, NULL, NULL, '0');
INSERT INTO sys_rule_condition (objid, parentid, fact_name, fact_objid, varname, pos, ruletext, displaytext, dynamic_datatype, dynamic_key, dynamic_value, notexist) VALUES ('RCOND17bb3bc0:16826bf0d4e:-7800', 'RUL17bb3bc0:16826bf0d4e:-7852', 'ctc.facts.CorporateCTC', 'ctc.facts.CorporateCTC', 'CCTC', '1', NULL, NULL, NULL, NULL, NULL, '0');
INSERT INTO sys_rule_condition (objid, parentid, fact_name, fact_objid, varname, pos, ruletext, displaytext, dynamic_datatype, dynamic_key, dynamic_value, notexist) VALUES ('RCOND-b880e40:166bdcfa0cb:-7c3d', 'RUL-b880e40:166bdcfa0cb:-7c8f', 'ctc.facts.CorporateCTC', 'ctc.facts.CorporateCTC', 'CORPCTC', '0', NULL, NULL, NULL, NULL, NULL, '0');
INSERT INTO sys_rule_condition (objid, parentid, fact_name, fact_objid, varname, pos, ruletext, displaytext, dynamic_datatype, dynamic_key, dynamic_value, notexist) VALUES ('RCb9e61ab:1694b473870:6035', 'RUL48d0f0c4:169510e76b2:-59e1', 'com.rameses.rules.common.CurrentDate', 'com.rameses.rules.common.CurrentDate', NULL, '0', NULL, NULL, NULL, NULL, NULL, '0');
INSERT INTO sys_rule_condition (objid, parentid, fact_name, fact_objid, varname, pos, ruletext, displaytext, dynamic_datatype, dynamic_key, dynamic_value, notexist) VALUES ('RCOND48d0f0c4:169510e76b2:-52c2', 'RUL48d0f0c4:169510e76b2:-59e1', 'ctc.facts.CorporateCTC', 'ctc.facts.CorporateCTC', 'CCTC', '1', NULL, NULL, NULL, NULL, NULL, '0');
INSERT INTO sys_rule_condition (objid, parentid, fact_name, fact_objid, varname, pos, ruletext, displaytext, dynamic_datatype, dynamic_key, dynamic_value, notexist) VALUES ('RCOND-476b5bbe:1641bbe1a54:-7e8c', 'RUL-476b5bbe:1641bbe1a54:-7ebc', 'ctc.facts.IndividualCTC', 'ctc.facts.IndividualCTC', 'ICTC', '0', NULL, NULL, NULL, NULL, NULL, '0');
INSERT INTO sys_rule_condition (objid, parentid, fact_name, fact_objid, varname, pos, ruletext, displaytext, dynamic_datatype, dynamic_key, dynamic_value, notexist) VALUES ('RCOND6729cd8:166bdeb1f30:-7dba', 'RUL6729cd8:166bdeb1f30:-7ef6', 'ctc.facts.IndividualCTC', 'ctc.facts.IndividualCTC', 'ICTC', '1', NULL, NULL, NULL, NULL, NULL, '0');
INSERT INTO sys_rule_condition (objid, parentid, fact_name, fact_objid, varname, pos, ruletext, displaytext, dynamic_datatype, dynamic_key, dynamic_value, notexist) VALUES ('RCOND6729cd8:166bdeb1f30:-7eb8', 'RUL6729cd8:166bdeb1f30:-7ef6', 'com.rameses.rules.common.CurrentDate', 'com.rameses.rules.common.CurrentDate', NULL, '0', NULL, NULL, NULL, NULL, NULL, '0');
INSERT INTO sys_rule_condition (objid, parentid, fact_name, fact_objid, varname, pos, ruletext, displaytext, dynamic_datatype, dynamic_key, dynamic_value, notexist) VALUES ('RCOND6729cd8:166bdeb1f30:-6ad4', 'RUL6729cd8:166bdeb1f30:-73c5', 'ctc.facts.IndividualCTC', 'ctc.facts.IndividualCTC', 'ICTC', '0', NULL, NULL, NULL, NULL, NULL, '0');
INSERT INTO sys_rule_condition (objid, parentid, fact_name, fact_objid, varname, pos, ruletext, displaytext, dynamic_datatype, dynamic_key, dynamic_value, notexist) VALUES ('RC4d8d2fa0:168164ac044:-689f', 'RUL4c78a9d4:16816354aab:-752c', 'ctc.facts.IndividualCTC', 'ctc.facts.IndividualCTC', 'ICTC', '0', NULL, NULL, NULL, NULL, NULL, '0');

go 

INSERT INTO sys_rule_condition_var (objid, parentid, ruleid, varname, datatype, pos) VALUES ('RCONST-b880e40:166bdcfa0cb:-76dc', 'RCOND-b880e40:166bdcfa0cb:-7749', 'RUL-b880e40:166bdcfa0cb:-77af', 'TOTALTAX', 'decimal', '0');
INSERT INTO sys_rule_condition_var (objid, parentid, ruleid, varname, datatype, pos) VALUES ('RCONST6729cd8:166bdeb1f30:-5dbe', 'RCOND6729cd8:166bdeb1f30:-5e3b', 'RUL6729cd8:166bdeb1f30:-5edf', 'INTEREST', 'decimal', '0');
INSERT INTO sys_rule_condition_var (objid, parentid, ruleid, varname, datatype, pos) VALUES ('RCOND7ff4a1a7:164fdd7d64a:-7ba1', 'RCOND7ff4a1a7:164fdd7d64a:-7ba1', 'RUL7ff4a1a7:164fdd7d64a:-7f02', 'ICTC', 'ctc.facts.IndividualCTC', '0');
INSERT INTO sys_rule_condition_var (objid, parentid, ruleid, varname, datatype, pos) VALUES ('RCONST7ff4a1a7:164fdd7d64a:-750e', 'RCOND7ff4a1a7:164fdd7d64a:-7ba1', 'RUL7ff4a1a7:164fdd7d64a:-7f02', 'TOTALTAX', 'decimal', '0');
INSERT INTO sys_rule_condition_var (objid, parentid, ruleid, varname, datatype, pos) VALUES ('RCOND6729cd8:166bdeb1f30:-6250', 'RCOND6729cd8:166bdeb1f30:-6250', 'RUL6729cd8:166bdeb1f30:-62a4', 'ICTC', 'ctc.facts.IndividualCTC', '0');
INSERT INTO sys_rule_condition_var (objid, parentid, ruleid, varname, datatype, pos) VALUES ('RCONST6729cd8:166bdeb1f30:-60dc', 'RCOND6729cd8:166bdeb1f30:-6250', 'RUL6729cd8:166bdeb1f30:-62a4', 'INTEREST', 'decimal', '0');
INSERT INTO sys_rule_condition_var (objid, parentid, ruleid, varname, datatype, pos) VALUES ('RCOND17bb3bc0:16826bf0d4e:-7800', 'RCOND17bb3bc0:16826bf0d4e:-7800', 'RUL17bb3bc0:16826bf0d4e:-7852', 'CCTC', 'ctc.facts.CorporateCTC', '1');
INSERT INTO sys_rule_condition_var (objid, parentid, ruleid, varname, datatype, pos) VALUES ('RCOND-b880e40:166bdcfa0cb:-7c3d', 'RCOND-b880e40:166bdcfa0cb:-7c3d', 'RUL-b880e40:166bdcfa0cb:-7c8f', 'CORPCTC', 'ctc.facts.CorporateCTC', '0');
INSERT INTO sys_rule_condition_var (objid, parentid, ruleid, varname, datatype, pos) VALUES ('RCONST-b880e40:166bdcfa0cb:-7b6d', 'RCOND-b880e40:166bdcfa0cb:-7c3d', 'RUL-b880e40:166bdcfa0cb:-7c8f', 'RPAV', 'decimal', '1');
INSERT INTO sys_rule_condition_var (objid, parentid, ruleid, varname, datatype, pos) VALUES ('RCONST-b880e40:166bdcfa0cb:-7bdf', 'RCOND-b880e40:166bdcfa0cb:-7c3d', 'RUL-b880e40:166bdcfa0cb:-7c8f', 'BGROSS', 'decimal', '0');
INSERT INTO sys_rule_condition_var (objid, parentid, ruleid, varname, datatype, pos) VALUES ('RCCb9e61ab:1694b473870:6036', 'RCb9e61ab:1694b473870:6035', 'RUL48d0f0c4:169510e76b2:-59e1', 'CYEAR', 'integer', '2');
INSERT INTO sys_rule_condition_var (objid, parentid, ruleid, varname, datatype, pos) VALUES ('RCCb9e61ab:1694b473870:6037', 'RCb9e61ab:1694b473870:6035', 'RUL48d0f0c4:169510e76b2:-59e1', 'CDATE', 'date', '1');
INSERT INTO sys_rule_condition_var (objid, parentid, ruleid, varname, datatype, pos) VALUES ('RCCb9e61ab:1694b473870:6038', 'RCb9e61ab:1694b473870:6035', 'RUL48d0f0c4:169510e76b2:-59e1', 'CMONTH', 'integer', '0');
INSERT INTO sys_rule_condition_var (objid, parentid, ruleid, varname, datatype, pos) VALUES ('RCOND48d0f0c4:169510e76b2:-52c2', 'RCOND48d0f0c4:169510e76b2:-52c2', 'RUL48d0f0c4:169510e76b2:-59e1', 'CCTC', 'ctc.facts.CorporateCTC', '1');
INSERT INTO sys_rule_condition_var (objid, parentid, ruleid, varname, datatype, pos) VALUES ('RCONST48d0f0c4:169510e76b2:-5248', 'RCOND48d0f0c4:169510e76b2:-52c2', 'RUL48d0f0c4:169510e76b2:-59e1', 'TOTALTAX', 'decimal', '0');
INSERT INTO sys_rule_condition_var (objid, parentid, ruleid, varname, datatype, pos) VALUES ('RCOND-476b5bbe:1641bbe1a54:-7e8c', 'RCOND-476b5bbe:1641bbe1a54:-7e8c', 'RUL-476b5bbe:1641bbe1a54:-7ebc', 'ICTC', 'ctc.facts.IndividualCTC', '0');
INSERT INTO sys_rule_condition_var (objid, parentid, ruleid, varname, datatype, pos) VALUES ('RCONST-476b5bbe:1641bbe1a54:-7cd4', 'RCOND-476b5bbe:1641bbe1a54:-7e8c', 'RUL-476b5bbe:1641bbe1a54:-7ebc', 'PI', 'decimal', '2');
INSERT INTO sys_rule_condition_var (objid, parentid, ruleid, varname, datatype, pos) VALUES ('RCONST-476b5bbe:1641bbe1a54:-7d87', 'RCOND-476b5bbe:1641bbe1a54:-7e8c', 'RUL-476b5bbe:1641bbe1a54:-7ebc', 'BGROSS', 'decimal', '1');
INSERT INTO sys_rule_condition_var (objid, parentid, ruleid, varname, datatype, pos) VALUES ('RCONST-476b5bbe:1641bbe1a54:-7e1d', 'RCOND-476b5bbe:1641bbe1a54:-7e8c', 'RUL-476b5bbe:1641bbe1a54:-7ebc', 'SALARY', 'decimal', '0');
INSERT INTO sys_rule_condition_var (objid, parentid, ruleid, varname, datatype, pos) VALUES ('RCOND6729cd8:166bdeb1f30:-7dba', 'RCOND6729cd8:166bdeb1f30:-7dba', 'RUL6729cd8:166bdeb1f30:-7ef6', 'ICTC', 'ctc.facts.IndividualCTC', '1');
INSERT INTO sys_rule_condition_var (objid, parentid, ruleid, varname, datatype, pos) VALUES ('RCONST6729cd8:166bdeb1f30:-7c22', 'RCOND6729cd8:166bdeb1f30:-7dba', 'RUL6729cd8:166bdeb1f30:-7ef6', 'TOTALTAX', 'decimal', '0');
INSERT INTO sys_rule_condition_var (objid, parentid, ruleid, varname, datatype, pos) VALUES ('RCONST-7ceb2c8b:167a1b28437:-7987', 'RCOND6729cd8:166bdeb1f30:-7eb8', 'RUL6729cd8:166bdeb1f30:-7ef6', 'CYEAR', 'integer', '2');
INSERT INTO sys_rule_condition_var (objid, parentid, ruleid, varname, datatype, pos) VALUES ('RCONST-7ceb2c8b:167a1b28437:-7c8e', 'RCOND6729cd8:166bdeb1f30:-7eb8', 'RUL6729cd8:166bdeb1f30:-7ef6', 'CDATE', 'date', '1');
INSERT INTO sys_rule_condition_var (objid, parentid, ruleid, varname, datatype, pos) VALUES ('RCONST6729cd8:166bdeb1f30:-7e85', 'RCOND6729cd8:166bdeb1f30:-7eb8', 'RUL6729cd8:166bdeb1f30:-7ef6', 'CMONTH', 'integer', '0');
INSERT INTO sys_rule_condition_var (objid, parentid, ruleid, varname, datatype, pos) VALUES ('RCOND6729cd8:166bdeb1f30:-6ad4', 'RCOND6729cd8:166bdeb1f30:-6ad4', 'RUL6729cd8:166bdeb1f30:-73c5', 'ICTC', 'ctc.facts.IndividualCTC', '0');
INSERT INTO sys_rule_condition_var (objid, parentid, ruleid, varname, datatype, pos) VALUES ('RC4d8d2fa0:168164ac044:-689f', 'RC4d8d2fa0:168164ac044:-689f', 'RUL4c78a9d4:16816354aab:-752c', 'ICTC', 'ctc.facts.IndividualCTC', '0');

go 

INSERT INTO sys_rule_condition_constraint (objid, parentid, field_objid, fieldname, varname, operator_caption, operator_symbol, usevar, var_objid, var_name, decimalvalue, intvalue, stringvalue, listvalue, datevalue, pos) VALUES ('RCONST-b880e40:166bdcfa0cb:-76dc', 'RCOND-b880e40:166bdcfa0cb:-7749', 'ctc.facts.CorporateCTC.totaltax', 'totaltax', 'TOTALTAX', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0');
INSERT INTO sys_rule_condition_constraint (objid, parentid, field_objid, fieldname, varname, operator_caption, operator_symbol, usevar, var_objid, var_name, decimalvalue, intvalue, stringvalue, listvalue, datevalue, pos) VALUES ('RCONST6729cd8:166bdeb1f30:-5dbe', 'RCOND6729cd8:166bdeb1f30:-5e3b', 'ctc.facts.CorporateCTC.interest', 'interest', 'INTEREST', 'greater than', '>', NULL, NULL, NULL, '0.00', NULL, NULL, NULL, NULL, '0');
INSERT INTO sys_rule_condition_constraint (objid, parentid, field_objid, fieldname, varname, operator_caption, operator_symbol, usevar, var_objid, var_name, decimalvalue, intvalue, stringvalue, listvalue, datevalue, pos) VALUES ('RCONST7ff4a1a7:164fdd7d64a:-750e', 'RCOND7ff4a1a7:164fdd7d64a:-7ba1', 'ctc.facts.IndividualCTC.totaltax', 'totaltax', 'TOTALTAX', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0');
INSERT INTO sys_rule_condition_constraint (objid, parentid, field_objid, fieldname, varname, operator_caption, operator_symbol, usevar, var_objid, var_name, decimalvalue, intvalue, stringvalue, listvalue, datevalue, pos) VALUES ('RCONST6729cd8:166bdeb1f30:-60dc', 'RCOND6729cd8:166bdeb1f30:-6250', 'ctc.facts.IndividualCTC.interest', 'interest', 'INTEREST', 'greater than', '>', NULL, NULL, NULL, '0.00', NULL, NULL, NULL, NULL, '0');
INSERT INTO sys_rule_condition_constraint (objid, parentid, field_objid, fieldname, varname, operator_caption, operator_symbol, usevar, var_objid, var_name, decimalvalue, intvalue, stringvalue, listvalue, datevalue, pos) VALUES ('RCONST17bb3bc0:16826bf0d4e:-77be', 'RCOND17bb3bc0:16826bf0d4e:-7800', 'ctc.facts.CorporateCTC.additional', 'additional', NULL, 'is true', '== true', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0');
INSERT INTO sys_rule_condition_constraint (objid, parentid, field_objid, fieldname, varname, operator_caption, operator_symbol, usevar, var_objid, var_name, decimalvalue, intvalue, stringvalue, listvalue, datevalue, pos) VALUES ('RCONST-b880e40:166bdcfa0cb:-7b6d', 'RCOND-b880e40:166bdcfa0cb:-7c3d', 'ctc.facts.CorporateCTC.realpropertyav', 'realpropertyav', 'RPAV', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1');
INSERT INTO sys_rule_condition_constraint (objid, parentid, field_objid, fieldname, varname, operator_caption, operator_symbol, usevar, var_objid, var_name, decimalvalue, intvalue, stringvalue, listvalue, datevalue, pos) VALUES ('RCONST-b880e40:166bdcfa0cb:-7bdf', 'RCOND-b880e40:166bdcfa0cb:-7c3d', 'ctc.facts.CorporateCTC.businessgross', 'businessgross', 'BGROSS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0');
INSERT INTO sys_rule_condition_constraint (objid, parentid, field_objid, fieldname, varname, operator_caption, operator_symbol, usevar, var_objid, var_name, decimalvalue, intvalue, stringvalue, listvalue, datevalue, pos) VALUES ('RCCb9e61ab:1694b473870:6036', 'RCb9e61ab:1694b473870:6035', 'com.rameses.rules.common.CurrentDate.year', 'year', 'CYEAR', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2');
INSERT INTO sys_rule_condition_constraint (objid, parentid, field_objid, fieldname, varname, operator_caption, operator_symbol, usevar, var_objid, var_name, decimalvalue, intvalue, stringvalue, listvalue, datevalue, pos) VALUES ('RCCb9e61ab:1694b473870:6037', 'RCb9e61ab:1694b473870:6035', 'com.rameses.rules.common.CurrentDate.date', 'date', 'CDATE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1');
INSERT INTO sys_rule_condition_constraint (objid, parentid, field_objid, fieldname, varname, operator_caption, operator_symbol, usevar, var_objid, var_name, decimalvalue, intvalue, stringvalue, listvalue, datevalue, pos) VALUES ('RCCb9e61ab:1694b473870:6038', 'RCb9e61ab:1694b473870:6035', 'com.rameses.rules.common.CurrentDate.month', 'month', 'CMONTH', 'greater than or equal to', '>=', NULL, NULL, NULL, NULL, '3', NULL, NULL, NULL, '0');
INSERT INTO sys_rule_condition_constraint (objid, parentid, field_objid, fieldname, varname, operator_caption, operator_symbol, usevar, var_objid, var_name, decimalvalue, intvalue, stringvalue, listvalue, datevalue, pos) VALUES ('RCONST48d0f0c4:169510e76b2:-5248', 'RCOND48d0f0c4:169510e76b2:-52c2', 'ctc.facts.CorporateCTC.totaltax', 'totaltax', 'TOTALTAX', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0');
INSERT INTO sys_rule_condition_constraint (objid, parentid, field_objid, fieldname, varname, operator_caption, operator_symbol, usevar, var_objid, var_name, decimalvalue, intvalue, stringvalue, listvalue, datevalue, pos) VALUES ('RCONST-476b5bbe:1641bbe1a54:-7cd4', 'RCOND-476b5bbe:1641bbe1a54:-7e8c', 'ctc.facts.IndividualCTC.propertyincome', 'propertyincome', 'PI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2');
INSERT INTO sys_rule_condition_constraint (objid, parentid, field_objid, fieldname, varname, operator_caption, operator_symbol, usevar, var_objid, var_name, decimalvalue, intvalue, stringvalue, listvalue, datevalue, pos) VALUES ('RCONST-476b5bbe:1641bbe1a54:-7d87', 'RCOND-476b5bbe:1641bbe1a54:-7e8c', 'ctc.facts.IndividualCTC.businessgross', 'businessgross', 'BGROSS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1');
INSERT INTO sys_rule_condition_constraint (objid, parentid, field_objid, fieldname, varname, operator_caption, operator_symbol, usevar, var_objid, var_name, decimalvalue, intvalue, stringvalue, listvalue, datevalue, pos) VALUES ('RCONST-476b5bbe:1641bbe1a54:-7e1d', 'RCOND-476b5bbe:1641bbe1a54:-7e8c', 'ctc.facts.IndividualCTC.annualsalary', 'annualsalary', 'SALARY', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0');
INSERT INTO sys_rule_condition_constraint (objid, parentid, field_objid, fieldname, varname, operator_caption, operator_symbol, usevar, var_objid, var_name, decimalvalue, intvalue, stringvalue, listvalue, datevalue, pos) VALUES ('RCONST6729cd8:166bdeb1f30:-7c22', 'RCOND6729cd8:166bdeb1f30:-7dba', 'ctc.facts.IndividualCTC.totaltax', 'totaltax', 'TOTALTAX', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0');
INSERT INTO sys_rule_condition_constraint (objid, parentid, field_objid, fieldname, varname, operator_caption, operator_symbol, usevar, var_objid, var_name, decimalvalue, intvalue, stringvalue, listvalue, datevalue, pos) VALUES ('RCONST-7ceb2c8b:167a1b28437:-7987', 'RCOND6729cd8:166bdeb1f30:-7eb8', 'com.rameses.rules.common.CurrentDate.year', 'year', 'CYEAR', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2');
INSERT INTO sys_rule_condition_constraint (objid, parentid, field_objid, fieldname, varname, operator_caption, operator_symbol, usevar, var_objid, var_name, decimalvalue, intvalue, stringvalue, listvalue, datevalue, pos) VALUES ('RCONST-7ceb2c8b:167a1b28437:-7c8e', 'RCOND6729cd8:166bdeb1f30:-7eb8', 'com.rameses.rules.common.CurrentDate.date', 'date', 'CDATE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1');
INSERT INTO sys_rule_condition_constraint (objid, parentid, field_objid, fieldname, varname, operator_caption, operator_symbol, usevar, var_objid, var_name, decimalvalue, intvalue, stringvalue, listvalue, datevalue, pos) VALUES ('RCONST6729cd8:166bdeb1f30:-7e85', 'RCOND6729cd8:166bdeb1f30:-7eb8', 'com.rameses.rules.common.CurrentDate.month', 'month', 'CMONTH', 'greater than or equal to', '>=', NULL, NULL, NULL, NULL, '3', NULL, NULL, NULL, '0');
INSERT INTO sys_rule_condition_constraint (objid, parentid, field_objid, fieldname, varname, operator_caption, operator_symbol, usevar, var_objid, var_name, decimalvalue, intvalue, stringvalue, listvalue, datevalue, pos) VALUES ('RCONST6729cd8:166bdeb1f30:-6a60', 'RCOND6729cd8:166bdeb1f30:-6ad4', 'ctc.facts.IndividualCTC.additional', 'additional', NULL, 'is true', '== true', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0');
INSERT INTO sys_rule_condition_constraint (objid, parentid, field_objid, fieldname, varname, operator_caption, operator_symbol, usevar, var_objid, var_name, decimalvalue, intvalue, stringvalue, listvalue, datevalue, pos) VALUES ('RCONST4c78a9d4:16816354aab:-5e23', 'RC4d8d2fa0:168164ac044:-689f', 'ctc.facts.IndividualCTC.businessgross', 'businessgross', NULL, 'less than or equal to', '<=', NULL, NULL, NULL, '0.00', NULL, NULL, NULL, NULL, '1');
INSERT INTO sys_rule_condition_constraint (objid, parentid, field_objid, fieldname, varname, operator_caption, operator_symbol, usevar, var_objid, var_name, decimalvalue, intvalue, stringvalue, listvalue, datevalue, pos) VALUES ('RCONST4c78a9d4:16816354aab:-7423', 'RC4d8d2fa0:168164ac044:-689f', 'ctc.facts.IndividualCTC.age', 'age', NULL, 'greater than or equal to', '>=', NULL, NULL, NULL, NULL, '60', NULL, NULL, NULL, '0');

go 

INSERT INTO sys_rule_action (objid, parentid, actiondef_objid, actiondef_name, pos) VALUES ('RACT-b880e40:166bdcfa0cb:-7690', 'RUL-b880e40:166bdcfa0cb:-77af', 'treasury.actions.AddBillItem', 'add-billitem', '0');
INSERT INTO sys_rule_action (objid, parentid, actiondef_objid, actiondef_name, pos) VALUES ('RAf84726b:166bdea1875:-7fbc', 'RUL6729cd8:166bdeb1f30:-5edf', 'treasury.actions.AddBillItem', 'add-billitem', '0');
INSERT INTO sys_rule_action (objid, parentid, actiondef_objid, actiondef_name, pos) VALUES ('RACT7ff4a1a7:164fdd7d64a:-73e7', 'RUL7ff4a1a7:164fdd7d64a:-7f02', 'treasury.actions.AddBillItem', 'add-billitem', '0');
INSERT INTO sys_rule_action (objid, parentid, actiondef_objid, actiondef_name, pos) VALUES ('RACT6729cd8:166bdeb1f30:-5fb2', 'RUL6729cd8:166bdeb1f30:-62a4', 'treasury.actions.AddBillItem', 'add-billitem', '0');
INSERT INTO sys_rule_action (objid, parentid, actiondef_objid, actiondef_name, pos) VALUES ('RACT17bb3bc0:16826bf0d4e:-7640', 'RUL17bb3bc0:16826bf0d4e:-7852', 'treasury.actions.UpdateFieldValue', 'update-field-value', '0');
INSERT INTO sys_rule_action (objid, parentid, actiondef_objid, actiondef_name, pos) VALUES ('RACT-b880e40:166bdcfa0cb:-786e', 'RUL-b880e40:166bdcfa0cb:-7c8f', 'treasury.actions.UpdateFieldValue', 'update-field-value', '0');
INSERT INTO sys_rule_action (objid, parentid, actiondef_objid, actiondef_name, pos) VALUES ('RACT-b880e40:166bdcfa0cb:-797b', 'RUL-b880e40:166bdcfa0cb:-7c8f', 'treasury.actions.UpdateFieldValue', 'update-field-value', '0');
INSERT INTO sys_rule_action (objid, parentid, actiondef_objid, actiondef_name, pos) VALUES ('RACT-b880e40:166bdcfa0cb:-7a4d', 'RUL-b880e40:166bdcfa0cb:-7c8f', 'treasury.actions.UpdateFieldValue', 'update-field-value', '0');
INSERT INTO sys_rule_action (objid, parentid, actiondef_objid, actiondef_name, pos) VALUES ('RACT48d0f0c4:169510e76b2:-510f', 'RUL48d0f0c4:169510e76b2:-59e1', 'treasury.actions.UpdateFieldValue', 'update-field-value', '0');
INSERT INTO sys_rule_action (objid, parentid, actiondef_objid, actiondef_name, pos) VALUES ('RACT-476b5bbe:1641bbe1a54:-79cd', 'RUL-476b5bbe:1641bbe1a54:-7ebc', 'treasury.actions.UpdateFieldValue', 'update-field-value', '0');
INSERT INTO sys_rule_action (objid, parentid, actiondef_objid, actiondef_name, pos) VALUES ('RACT-476b5bbe:1641bbe1a54:-7aa9', 'RUL-476b5bbe:1641bbe1a54:-7ebc', 'treasury.actions.UpdateFieldValue', 'update-field-value', '0');
INSERT INTO sys_rule_action (objid, parentid, actiondef_objid, actiondef_name, pos) VALUES ('RACT-476b5bbe:1641bbe1a54:-7b87', 'RUL-476b5bbe:1641bbe1a54:-7ebc', 'treasury.actions.UpdateFieldValue', 'update-field-value', '0');
INSERT INTO sys_rule_action (objid, parentid, actiondef_objid, actiondef_name, pos) VALUES ('RACT-476b5bbe:1641bbe1a54:-7c6d', 'RUL-476b5bbe:1641bbe1a54:-7ebc', 'treasury.actions.UpdateFieldValue', 'update-field-value', '0');
INSERT INTO sys_rule_action (objid, parentid, actiondef_objid, actiondef_name, pos) VALUES ('RACT6729cd8:166bdeb1f30:-7a26', 'RUL6729cd8:166bdeb1f30:-7ef6', 'treasury.actions.UpdateFieldValue', 'update-field-value', '0');
INSERT INTO sys_rule_action (objid, parentid, actiondef_objid, actiondef_name, pos) VALUES ('RACT6729cd8:166bdeb1f30:-6a2d', 'RUL6729cd8:166bdeb1f30:-73c5', 'treasury.actions.UpdateFieldValue', 'update-field-value', '0');
INSERT INTO sys_rule_action (objid, parentid, actiondef_objid, actiondef_name, pos) VALUES ('RA4d8d2fa0:168164ac044:-689d', 'RUL4c78a9d4:16816354aab:-752c', 'treasury.actions.UpdateFieldValue', 'update-field-value', '0');

go 

INSERT INTO sys_rule_action_param (objid, parentid, actiondefparam_objid, stringvalue, booleanvalue, var_objid, var_name, expr, exprtype, pos, obj_key, obj_value, listvalue, lov, rangeoption) VALUES ('RULACT-b880e40:166bdcfa0cb:-760d', 'RACT-b880e40:166bdcfa0cb:-7690', 'treasury.actions.AddBillItem.amount', NULL, NULL, NULL, NULL, 'TOTALTAX', 'expression', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_action_param (objid, parentid, actiondefparam_objid, stringvalue, booleanvalue, var_objid, var_name, expr, exprtype, pos, obj_key, obj_value, listvalue, lov, rangeoption) VALUES ('RULACT-b880e40:166bdcfa0cb:-765a', 'RACT-b880e40:166bdcfa0cb:-7690', 'treasury.actions.AddBillItem.account', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ITEMACCT-7115cae9:150d5d63979:-7f21', 'COMMUNITY TAX - CORPORATE', NULL, NULL, NULL);
INSERT INTO sys_rule_action_param (objid, parentid, actiondefparam_objid, stringvalue, booleanvalue, var_objid, var_name, expr, exprtype, pos, obj_key, obj_value, listvalue, lov, rangeoption) VALUES ('RAPf84726b:166bdea1875:-7fba', 'RAf84726b:166bdea1875:-7fbc', 'treasury.actions.AddBillItem.account', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ITEMACCT-7115cae9:150d5d63979:-7e49', 'COMMUNITY TAX - CORPORATE PENALTY', NULL, NULL, NULL);
INSERT INTO sys_rule_action_param (objid, parentid, actiondefparam_objid, stringvalue, booleanvalue, var_objid, var_name, expr, exprtype, pos, obj_key, obj_value, listvalue, lov, rangeoption) VALUES ('RAPf84726b:166bdea1875:-7fbb', 'RAf84726b:166bdea1875:-7fbc', 'treasury.actions.AddBillItem.amount', NULL, NULL, NULL, NULL, 'INTEREST', 'expression', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_action_param (objid, parentid, actiondefparam_objid, stringvalue, booleanvalue, var_objid, var_name, expr, exprtype, pos, obj_key, obj_value, listvalue, lov, rangeoption) VALUES ('RULACT7ff4a1a7:164fdd7d64a:-735c', 'RACT7ff4a1a7:164fdd7d64a:-73e7', 'treasury.actions.AddBillItem.amount', NULL, NULL, NULL, NULL, 'TOTALTAX', 'expression', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_action_param (objid, parentid, actiondefparam_objid, stringvalue, booleanvalue, var_objid, var_name, expr, exprtype, pos, obj_key, obj_value, listvalue, lov, rangeoption) VALUES ('RULACT7ff4a1a7:164fdd7d64a:-73b1', 'RACT7ff4a1a7:164fdd7d64a:-73e7', 'treasury.actions.AddBillItem.account', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ITEMACCT-68a62024:150ad0010ec:-75de', 'COMMUNITY TAX - INDIVIDUAL', NULL, NULL, NULL);
INSERT INTO sys_rule_action_param (objid, parentid, actiondefparam_objid, stringvalue, booleanvalue, var_objid, var_name, expr, exprtype, pos, obj_key, obj_value, listvalue, lov, rangeoption) VALUES ('RULACT6729cd8:166bdeb1f30:-5f38', 'RACT6729cd8:166bdeb1f30:-5fb2', 'treasury.actions.AddBillItem.amount', NULL, NULL, NULL, NULL, 'INTEREST', 'expression', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_action_param (objid, parentid, actiondefparam_objid, stringvalue, booleanvalue, var_objid, var_name, expr, exprtype, pos, obj_key, obj_value, listvalue, lov, rangeoption) VALUES ('RULACT6729cd8:166bdeb1f30:-5f7c', 'RACT6729cd8:166bdeb1f30:-5fb2', 'treasury.actions.AddBillItem.account', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ITEMACCT-7115cae9:150d5d63979:-7e7f', 'COMMUNITY TAX - INDIVIDUAL PENALTY', NULL, NULL, NULL);
INSERT INTO sys_rule_action_param (objid, parentid, actiondefparam_objid, stringvalue, booleanvalue, var_objid, var_name, expr, exprtype, pos, obj_key, obj_value, listvalue, lov, rangeoption) VALUES ('RULACT17bb3bc0:16826bf0d4e:-75e7', 'RACT17bb3bc0:16826bf0d4e:-7640', 'treasury.actions.UpdateFieldValue.value', NULL, NULL, NULL, NULL, '0', 'expression', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_action_param (objid, parentid, actiondefparam_objid, stringvalue, booleanvalue, var_objid, var_name, expr, exprtype, pos, obj_key, obj_value, listvalue, lov, rangeoption) VALUES ('RULACT17bb3bc0:16826bf0d4e:-7617', 'RACT17bb3bc0:16826bf0d4e:-7640', 'treasury.actions.UpdateFieldValue.fieldname', 'basictax', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_action_param (objid, parentid, actiondefparam_objid, stringvalue, booleanvalue, var_objid, var_name, expr, exprtype, pos, obj_key, obj_value, listvalue, lov, rangeoption) VALUES ('RULACT17bb3bc0:16826bf0d4e:-762f', 'RACT17bb3bc0:16826bf0d4e:-7640', 'treasury.actions.UpdateFieldValue.object', NULL, NULL, 'RCOND17bb3bc0:16826bf0d4e:-7800', 'CCTC', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_action_param (objid, parentid, actiondefparam_objid, stringvalue, booleanvalue, var_objid, var_name, expr, exprtype, pos, obj_key, obj_value, listvalue, lov, rangeoption) VALUES ('RULACT-b880e40:166bdcfa0cb:-7800', 'RACT-b880e40:166bdcfa0cb:-786e', 'treasury.actions.UpdateFieldValue.value', NULL, NULL, NULL, NULL, '500', 'expression', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_action_param (objid, parentid, actiondefparam_objid, stringvalue, booleanvalue, var_objid, var_name, expr, exprtype, pos, obj_key, obj_value, listvalue, lov, rangeoption) VALUES ('RULACT-b880e40:166bdcfa0cb:-7837', 'RACT-b880e40:166bdcfa0cb:-786e', 'treasury.actions.UpdateFieldValue.fieldname', 'basictax', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_action_param (objid, parentid, actiondefparam_objid, stringvalue, booleanvalue, var_objid, var_name, expr, exprtype, pos, obj_key, obj_value, listvalue, lov, rangeoption) VALUES ('RULACT-b880e40:166bdcfa0cb:-7856', 'RACT-b880e40:166bdcfa0cb:-786e', 'treasury.actions.UpdateFieldValue.object', NULL, NULL, 'RCOND-b880e40:166bdcfa0cb:-7c3d', 'CORPCTC', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_action_param (objid, parentid, actiondefparam_objid, stringvalue, booleanvalue, var_objid, var_name, expr, exprtype, pos, obj_key, obj_value, listvalue, lov, rangeoption) VALUES ('RULACT-b880e40:166bdcfa0cb:-790b', 'RACT-b880e40:166bdcfa0cb:-797b', 'treasury.actions.UpdateFieldValue.value', NULL, NULL, NULL, NULL, 'def d = ( BGROSS / 5000 ) * 2;\nreturn @IIF(   d > 10000, 10000, d  );', 'expression', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_action_param (objid, parentid, actiondefparam_objid, stringvalue, booleanvalue, var_objid, var_name, expr, exprtype, pos, obj_key, obj_value, listvalue, lov, rangeoption) VALUES ('RULACT-b880e40:166bdcfa0cb:-7942', 'RACT-b880e40:166bdcfa0cb:-797b', 'treasury.actions.UpdateFieldValue.fieldname', 'businessgrosstax', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_action_param (objid, parentid, actiondefparam_objid, stringvalue, booleanvalue, var_objid, var_name, expr, exprtype, pos, obj_key, obj_value, listvalue, lov, rangeoption) VALUES ('RULACT-b880e40:166bdcfa0cb:-7961', 'RACT-b880e40:166bdcfa0cb:-797b', 'treasury.actions.UpdateFieldValue.object', NULL, NULL, 'RCOND-b880e40:166bdcfa0cb:-7c3d', 'CORPCTC', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_action_param (objid, parentid, actiondefparam_objid, stringvalue, booleanvalue, var_objid, var_name, expr, exprtype, pos, obj_key, obj_value, listvalue, lov, rangeoption) VALUES ('RULACT-b880e40:166bdcfa0cb:-79df', 'RACT-b880e40:166bdcfa0cb:-7a4d', 'treasury.actions.UpdateFieldValue.value', NULL, NULL, NULL, NULL, 'def d = ( RPAV / 5000 ) * 2;\nreturn @IIF(   d > 10000, 10000, d  );', 'expression', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_action_param (objid, parentid, actiondefparam_objid, stringvalue, booleanvalue, var_objid, var_name, expr, exprtype, pos, obj_key, obj_value, listvalue, lov, rangeoption) VALUES ('RULACT-b880e40:166bdcfa0cb:-7a16', 'RACT-b880e40:166bdcfa0cb:-7a4d', 'treasury.actions.UpdateFieldValue.fieldname', 'propertyavtax', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_action_param (objid, parentid, actiondefparam_objid, stringvalue, booleanvalue, var_objid, var_name, expr, exprtype, pos, obj_key, obj_value, listvalue, lov, rangeoption) VALUES ('RULACT-b880e40:166bdcfa0cb:-7a35', 'RACT-b880e40:166bdcfa0cb:-7a4d', 'treasury.actions.UpdateFieldValue.object', NULL, NULL, 'RCOND-b880e40:166bdcfa0cb:-7c3d', 'CORPCTC', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_action_param (objid, parentid, actiondefparam_objid, stringvalue, booleanvalue, var_objid, var_name, expr, exprtype, pos, obj_key, obj_value, listvalue, lov, rangeoption) VALUES ('RULACT48d0f0c4:169510e76b2:-50a9', 'RACT48d0f0c4:169510e76b2:-510f', 'treasury.actions.UpdateFieldValue.value', NULL, NULL, NULL, NULL, '@ROUND( (@MONTH( CDATE  ) * 0.02) * TOTALTAX )', 'expression', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_action_param (objid, parentid, actiondefparam_objid, stringvalue, booleanvalue, var_objid, var_name, expr, exprtype, pos, obj_key, obj_value, listvalue, lov, rangeoption) VALUES ('RULACT48d0f0c4:169510e76b2:-50de', 'RACT48d0f0c4:169510e76b2:-510f', 'treasury.actions.UpdateFieldValue.fieldname', 'interest', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_action_param (objid, parentid, actiondefparam_objid, stringvalue, booleanvalue, var_objid, var_name, expr, exprtype, pos, obj_key, obj_value, listvalue, lov, rangeoption) VALUES ('RULACT48d0f0c4:169510e76b2:-50fb', 'RACT48d0f0c4:169510e76b2:-510f', 'treasury.actions.UpdateFieldValue.object', NULL, NULL, 'RCOND48d0f0c4:169510e76b2:-52c2', 'CCTC', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_action_param (objid, parentid, actiondefparam_objid, stringvalue, booleanvalue, var_objid, var_name, expr, exprtype, pos, obj_key, obj_value, listvalue, lov, rangeoption) VALUES ('RULACT-476b5bbe:1641bbe1a54:-7957', 'RACT-476b5bbe:1641bbe1a54:-79cd', 'treasury.actions.UpdateFieldValue.value', NULL, NULL, NULL, NULL, 'def d = ( PI / 1000 ); \nreturn @IIF( d > 5000, 5000, d.intValue() );', 'expression', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_action_param (objid, parentid, actiondefparam_objid, stringvalue, booleanvalue, var_objid, var_name, expr, exprtype, pos, obj_key, obj_value, listvalue, lov, rangeoption) VALUES ('RULACT-476b5bbe:1641bbe1a54:-7998', 'RACT-476b5bbe:1641bbe1a54:-79cd', 'treasury.actions.UpdateFieldValue.fieldname', 'propertyincometax', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_action_param (objid, parentid, actiondefparam_objid, stringvalue, booleanvalue, var_objid, var_name, expr, exprtype, pos, obj_key, obj_value, listvalue, lov, rangeoption) VALUES ('RULACT-476b5bbe:1641bbe1a54:-79b6', 'RACT-476b5bbe:1641bbe1a54:-79cd', 'treasury.actions.UpdateFieldValue.object', NULL, NULL, 'RCOND-476b5bbe:1641bbe1a54:-7e8c', 'ICTC', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_action_param (objid, parentid, actiondefparam_objid, stringvalue, booleanvalue, var_objid, var_name, expr, exprtype, pos, obj_key, obj_value, listvalue, lov, rangeoption) VALUES ('RULACT-476b5bbe:1641bbe1a54:-7a33', 'RACT-476b5bbe:1641bbe1a54:-7aa9', 'treasury.actions.UpdateFieldValue.value', NULL, NULL, NULL, NULL, 'def d = ( SALARY / 1000 ); \nreturn @IIF( d > 5000, 5000, d.intValue() );', 'expression', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_action_param (objid, parentid, actiondefparam_objid, stringvalue, booleanvalue, var_objid, var_name, expr, exprtype, pos, obj_key, obj_value, listvalue, lov, rangeoption) VALUES ('RULACT-476b5bbe:1641bbe1a54:-7a77', 'RACT-476b5bbe:1641bbe1a54:-7aa9', 'treasury.actions.UpdateFieldValue.fieldname', 'salarytax', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_action_param (objid, parentid, actiondefparam_objid, stringvalue, booleanvalue, var_objid, var_name, expr, exprtype, pos, obj_key, obj_value, listvalue, lov, rangeoption) VALUES ('RULACT-476b5bbe:1641bbe1a54:-7a95', 'RACT-476b5bbe:1641bbe1a54:-7aa9', 'treasury.actions.UpdateFieldValue.object', NULL, NULL, 'RCOND-476b5bbe:1641bbe1a54:-7e8c', 'ICTC', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_action_param (objid, parentid, actiondefparam_objid, stringvalue, booleanvalue, var_objid, var_name, expr, exprtype, pos, obj_key, obj_value, listvalue, lov, rangeoption) VALUES ('RULACT-476b5bbe:1641bbe1a54:-7b11', 'RACT-476b5bbe:1641bbe1a54:-7b87', 'treasury.actions.UpdateFieldValue.value', NULL, NULL, NULL, NULL, 'def d = ( BGROSS / 1000 ); \nreturn @IIF( d > 5000, 5000, d.intValue() );', 'expression', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_action_param (objid, parentid, actiondefparam_objid, stringvalue, booleanvalue, var_objid, var_name, expr, exprtype, pos, obj_key, obj_value, listvalue, lov, rangeoption) VALUES ('RULACT-476b5bbe:1641bbe1a54:-7b55', 'RACT-476b5bbe:1641bbe1a54:-7b87', 'treasury.actions.UpdateFieldValue.fieldname', 'businessgrosstax', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_action_param (objid, parentid, actiondefparam_objid, stringvalue, booleanvalue, var_objid, var_name, expr, exprtype, pos, obj_key, obj_value, listvalue, lov, rangeoption) VALUES ('RULACT-476b5bbe:1641bbe1a54:-7b70', 'RACT-476b5bbe:1641bbe1a54:-7b87', 'treasury.actions.UpdateFieldValue.object', NULL, NULL, 'RCOND-476b5bbe:1641bbe1a54:-7e8c', 'ICTC', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_action_param (objid, parentid, actiondefparam_objid, stringvalue, booleanvalue, var_objid, var_name, expr, exprtype, pos, obj_key, obj_value, listvalue, lov, rangeoption) VALUES ('RULACT-476b5bbe:1641bbe1a54:-7bf7', 'RACT-476b5bbe:1641bbe1a54:-7c6d', 'treasury.actions.UpdateFieldValue.value', NULL, NULL, NULL, NULL, '5', 'expression', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_action_param (objid, parentid, actiondefparam_objid, stringvalue, booleanvalue, var_objid, var_name, expr, exprtype, pos, obj_key, obj_value, listvalue, lov, rangeoption) VALUES ('RULACT-476b5bbe:1641bbe1a54:-7c3b', 'RACT-476b5bbe:1641bbe1a54:-7c6d', 'treasury.actions.UpdateFieldValue.fieldname', 'basictax', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_action_param (objid, parentid, actiondefparam_objid, stringvalue, booleanvalue, var_objid, var_name, expr, exprtype, pos, obj_key, obj_value, listvalue, lov, rangeoption) VALUES ('RULACT-476b5bbe:1641bbe1a54:-7c56', 'RACT-476b5bbe:1641bbe1a54:-7c6d', 'treasury.actions.UpdateFieldValue.object', NULL, NULL, 'RCOND-476b5bbe:1641bbe1a54:-7e8c', 'ICTC', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_action_param (objid, parentid, actiondefparam_objid, stringvalue, booleanvalue, var_objid, var_name, expr, exprtype, pos, obj_key, obj_value, listvalue, lov, rangeoption) VALUES ('RULACT6729cd8:166bdeb1f30:-79aa', 'RACT6729cd8:166bdeb1f30:-7a26', 'treasury.actions.UpdateFieldValue.value', NULL, NULL, NULL, NULL, '@ROUND( (@MONTH( CDATE  ) * 0.02) * TOTALTAX )', 'expression', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_action_param (objid, parentid, actiondefparam_objid, stringvalue, booleanvalue, var_objid, var_name, expr, exprtype, pos, obj_key, obj_value, listvalue, lov, rangeoption) VALUES ('RULACT6729cd8:166bdeb1f30:-79ef', 'RACT6729cd8:166bdeb1f30:-7a26', 'treasury.actions.UpdateFieldValue.fieldname', 'interest', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_action_param (objid, parentid, actiondefparam_objid, stringvalue, booleanvalue, var_objid, var_name, expr, exprtype, pos, obj_key, obj_value, listvalue, lov, rangeoption) VALUES ('RULACT6729cd8:166bdeb1f30:-7a0e', 'RACT6729cd8:166bdeb1f30:-7a26', 'treasury.actions.UpdateFieldValue.object', NULL, NULL, 'RCOND6729cd8:166bdeb1f30:-7dba', 'ICTC', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_action_param (objid, parentid, actiondefparam_objid, stringvalue, booleanvalue, var_objid, var_name, expr, exprtype, pos, obj_key, obj_value, listvalue, lov, rangeoption) VALUES ('RULACT6729cd8:166bdeb1f30:-69af', 'RACT6729cd8:166bdeb1f30:-6a2d', 'treasury.actions.UpdateFieldValue.value', NULL, NULL, NULL, NULL, '0', 'expression', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_action_param (objid, parentid, actiondefparam_objid, stringvalue, booleanvalue, var_objid, var_name, expr, exprtype, pos, obj_key, obj_value, listvalue, lov, rangeoption) VALUES ('RULACT6729cd8:166bdeb1f30:-69f4', 'RACT6729cd8:166bdeb1f30:-6a2d', 'treasury.actions.UpdateFieldValue.fieldname', 'basictax', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_action_param (objid, parentid, actiondefparam_objid, stringvalue, booleanvalue, var_objid, var_name, expr, exprtype, pos, obj_key, obj_value, listvalue, lov, rangeoption) VALUES ('RULACT6729cd8:166bdeb1f30:-6a15', 'RACT6729cd8:166bdeb1f30:-6a2d', 'treasury.actions.UpdateFieldValue.object', NULL, NULL, 'RCOND6729cd8:166bdeb1f30:-6ad4', 'ICTC', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_action_param (objid, parentid, actiondefparam_objid, stringvalue, booleanvalue, var_objid, var_name, expr, exprtype, pos, obj_key, obj_value, listvalue, lov, rangeoption) VALUES ('RAP4d8d2fa0:168164ac044:-689a', 'RA4d8d2fa0:168164ac044:-689d', 'treasury.actions.UpdateFieldValue.object', NULL, NULL, 'RC4d8d2fa0:168164ac044:-689f', 'ICTC', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_action_param (objid, parentid, actiondefparam_objid, stringvalue, booleanvalue, var_objid, var_name, expr, exprtype, pos, obj_key, obj_value, listvalue, lov, rangeoption) VALUES ('RAP4d8d2fa0:168164ac044:-689b', 'RA4d8d2fa0:168164ac044:-689d', 'treasury.actions.UpdateFieldValue.fieldname', 'basictax', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO sys_rule_action_param (objid, parentid, actiondefparam_objid, stringvalue, booleanvalue, var_objid, var_name, expr, exprtype, pos, obj_key, obj_value, listvalue, lov, rangeoption) VALUES ('RAP4d8d2fa0:168164ac044:-689c', 'RA4d8d2fa0:168164ac044:-689d', 'treasury.actions.UpdateFieldValue.value', NULL, NULL, NULL, NULL, '5', 'expression', NULL, NULL, NULL, NULL, NULL, NULL);

go 

update sys_rule_action_param set obj_key='FTFA00000461', obj_value='CTC- INDIVIDUAL ( MUN. COLLECTION )' where obj_key = 'ITEMACCT-68a62024:150ad0010ec:-75de'
;
update sys_rule_action_param set obj_key='SUBACCT-7c1704d5:12ee030d729:-74ce', obj_value='INTEREST CTC (MUN.COLLN)' where obj_key = 'ITEMACCT-7115cae9:150d5d63979:-7e7f'
;
update sys_rule_action_param set obj_key='SUBACCT425785b4:126f369b93f:-7fa1', obj_value='CORPORATE TAX CERTIFICATE' where obj_key = 'ITEMACCT-7115cae9:150d5d63979:-7f21'
;
update sys_rule_action_param set obj_key='SUBACCT19c48dd4:126f385d784:-7ff4', obj_value='INTEREST ( CORPORATE TAX )' where obj_key = 'ITEMACCT-7115cae9:150d5d63979:-7e49'
;

go 

INSERT INTO sys_rule_fact (objid, name, title, factclass, sortorder, handler, defaultvarname, dynamic, lookuphandler, lookupkey, lookupvalue, lookupdatatype, dynamicfieldname, builtinconstraints, domain, factsuperclass) 
VALUES ('treasury.facts.BillDate', 'BillDate', 'Bill Date', 'treasury.facts.BillDate', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'treasury', NULL);

go 

INSERT INTO sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) 
VALUES ('treasury.facts.BillDate-month', 'treasury.facts.BillDate', 'month', 'Month', 'integer', '1', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL);

INSERT INTO sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) 
VALUES ('treasury.facts.BillDate-year', 'treasury.facts.BillDate', 'year', 'Year', 'integer', '2', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL);

INSERT INTO sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) 
VALUES ('treasury.facts.BillDate-day', 'treasury.facts.BillDate', 'day', 'Day', 'integer', '3', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL);

INSERT INTO sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) 
VALUES ('treasury.facts.BillDate-date', 'treasury.facts.BillDate', 'date', 'Date', 'date', '4', 'date', NULL, NULL, NULL, NULL, NULL, NULL, 'date', NULL);

INSERT INTO sys_rule_fact_field (objid, parentid, name, title, datatype, sortorder, handler, lookuphandler, lookupkey, lookupvalue, lookupdatatype, multivalued, required, vardatatype, lovname) 
VALUES ('treasury.facts.BillDate-qtr', 'treasury.facts.BillDate', 'qtr', 'Qtr', 'integer', '5', 'integer', NULL, NULL, NULL, NULL, NULL, NULL, 'integer', NULL);

go 

INSERT INTO sys_ruleset_fact (ruleset, rulefact) 
VALUES ('ctcbilling', 'treasury.facts.BillDate');

go 
