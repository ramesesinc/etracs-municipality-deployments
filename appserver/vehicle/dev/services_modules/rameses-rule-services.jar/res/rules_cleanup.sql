[delete]
DELETE FROM sys_rule_action_param 
WHERE parentid IN (
	SELECT objid FROM sys_rule_action WHERE parentid IN 
		(SELECT objid FROM sys_rule WHERE ruleset = {ruleset} )
);

DELETE FROM sys_rule_action WHERE parentid IN 
	(SELECT objid FROM sys_rule WHERE ruleset = {ruleset} );

DELETE FROM sys_rule_condition_var WHERE parentid IN (
	SELECT objid FROM sys_rule_condition WHERE parentid IN 
		(SELECT objid FROM sys_rule WHERE ruleset = {ruleset} )
);

DELETE FROM sys_rule_condition_constraint WHERE parentid IN (
	SELECT objid FROM sys_rule_condition WHERE parentid IN 
		(SELECT objid FROM sys_rule WHERE ruleset = {ruleset} )
);

DELETE FROM sys_rule_condition WHERE parentid IN 
	(SELECT objid FROM sys_rule WHERE ruleset = {ruleset} );

DELETE FROM sys_rule_deployed WHERE objid IN 
(SELECT objid FROM sys_rule WHERE ruleset =  {ruleset} );


DELETE FROM sys_rule WHERE ruleset = {ruleset};


[delete-defs]
DELETE FROM sys_rule_actiondef_param;
DELETE FROM sys_rule_fact_field;

DELETE FROM sys_ruleset_fact;
DELETE FROM sys_ruleset_actiondef;
DELETE FROM sys_rule_actiondef;
DELETE FROM sys_rule_fact;

DELETE FROM sys_rulegroup;
DELETE FROM sys_ruleset;