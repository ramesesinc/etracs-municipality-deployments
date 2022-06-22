DROP VIEW IF EXISTS vw_market_batch_bill;
CREATE VIEW vw_market_batch_bill AS 
SELECT
mb.*,
mbt.state AS task_state,
mbt.dtcreated AS task_dtcreated,
mbt.startdate AS task_startdate,
mbt.enddate AS task_enddate,
mbt.assignee_objid AS task_assignee_objid,
mbt.assignee_name AS task_assignee_name,
mbt.actor_objid AS task_actor_objid,
mbt.actor_name AS task_actor_name,
sn.title AS task_title,
sn.tracktime AS task_tracktime,
sn.properties AS task_properties,
bs.year,
bs.month,
bs.fromdate,
bs.billdate,
bs.todate,
bs.discdate,
bs.duedate,
bs.expirydate

FROM market_batch_bill mb
INNER JOIN market_batch_bill_task mbt ON mb.taskid=mbt.taskid 
INNER JOIN sys_wf_node sn ON sn.processname = 'market_batch_bill' AND sn.name = mbt.state 
INNER JOIN market_billschedule bs ON mb.billscheduleid = bs.objid