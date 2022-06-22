[getNodeListCount]
SELECT 
  sn.name AS state, 
  (SELECT COUNT(*) FROM vw_market_batch_bill WHERE task_state = sn.name  AND billtype = $P{billtype} ) AS count
FROM sys_wf_node sn 
WHERE sn.processname = 'market_batch_bill'
AND sn.name NOT IN ( 'start', 'end' )