DROP VIEW IF EXISTS vw_waterworks_compromise;
CREATE VIEW vw_waterworks_compromise AS 
SELECT   
  wcr.*,
  wcr.amount - wcr.downpayment AS balance,
  wa.acctno AS acctno, 

 t.state AS task_state,
 t.startdate AS task_startdate,
 t.enddate AS task_enddate,
 t.assignee_objid AS task_assignee_objid,
 t.assignee_name AS task_assignee_name,
 t.actor_objid AS task_actor_objid,
 t.actor_name AS task_actor_name,
 (SELECT title FROM sys_wf_node WHERE processname = 'waterworks_compromise' AND name=t.state) AS task_title

FROM waterworks_compromise wcr 
INNER JOIN waterworks_compromise_task t ON wcr.taskid = t.taskid 
INNER JOIN waterworks_account wa ON wcr.acctid = wa.objid  
