DROP VIEW IF EXISTS vw_waterworks_change_request;
CREATE VIEW vw_waterworks_change_request AS 
SELECT   
  wcr.*,
  wa.acctno AS account_acctno, 

 t.state AS task_state,
 t.startdate AS task_startdate,
 t.enddate AS task_enddate,
 t.assignee_objid AS task_assignee_objid,
 t.assignee_name AS task_assignee_name,
 t.actor_objid AS task_actor_objid,
 t.actor_name AS task_actor_name,
 (SELECT title FROM sys_wf_node WHERE processname = 'waterworks_change_request' AND name=t.state) AS task_title

FROM waterworks_change_request wcr 
INNER JOIN waterworks_change_request_task t ON wcr.taskid = t.taskid 
INNER JOIN waterworks_account wa ON wcr.acctid = wa.objid  
