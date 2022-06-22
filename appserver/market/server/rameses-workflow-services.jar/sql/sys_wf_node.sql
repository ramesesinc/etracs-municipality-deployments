[getWorkflowRoles]
SELECT DISTINCT role, processname 
FROM sys_wf_node 
WHERE domain = $P{domain}
ORDER BY processname

[getTaskCount]
SELECT bt.state, COUNT(*) AS count, sn.role  
FROM ${processname}_task bt 
INNER JOIN ${processname} app ON app.taskid=bt.taskid
INNER JOIN sys_wf_node sn ON sn.processname = '${processname}' AND sn.name = bt.state 
WHERE bt.assignee_objid IS NULL
AND bt.enddate IS NULL 
AND sn.tracktime = 1
AND sn.role IN ( ${roles} )
GROUP BY bt.state, sn.role