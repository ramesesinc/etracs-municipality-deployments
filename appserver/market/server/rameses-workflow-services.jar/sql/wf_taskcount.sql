[getNodeListTaskCount]
SELECT bt.state, COUNT(*) AS count 
FROM ${processname}_task bt 
INNER JOIN ${processname} pn ON pn.taskid = bt.taskid
INNER JOIN sys_wf_node sn ON sn.processname = '${processname}' AND sn.name = bt.state 
WHERE bt.assignee_objid IS NULL
AND sn.tracktime = 1
AND sn.role IN ( ${roles} )
GROUP BY bt.state

UNION ALL

SELECT 'mytask', COUNT(*) AS count 
FROM ${processname}_task bt 
INNER JOIN ${processname} pn ON pn.taskid = bt.taskid
WHERE bt.assignee_objid = $P{userid}
AND bt.state NOT IN ('start', 'end')

[getMyTaskCount]
SELECT COUNT(*) AS count 
FROM ${processname}_task bt 
INNER JOIN ${processname} pn ON pn.taskid = bt.taskid
WHERE bt.assignee_objid = $P{userid}
AND bt.state NOT IN ('start', 'end')