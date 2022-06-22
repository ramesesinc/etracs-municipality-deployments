[findAccountListCount]
SELECT 
   COUNT(*) AS itemcount
FROM market_batch_bill bb
INNER JOIN market_billgroup_unit bgu ON bb.billgroupid = bgu.billgroupid 
INNER JOIN market_rental_unit mru ON bgu.unitid = mru.objid 
INNER JOIN market_account ma ON mru.currentacctid = ma.objid 
WHERE bb.objid = $P{batchid}
AND ma.state = 'ACTIVE'

[getUnprocessedAccountList]
SELECT 
   ma.objid AS acctid
FROM market_batch_bill bb
INNER JOIN market_billgroup_unit bgu ON bb.billgroupid = bgu.billgroupid 
INNER JOIN market_rental_unit mru ON bgu.unitid = mru.objid 
INNER JOIN market_account ma ON mru.currentacctid = ma.objid 
WHERE bb.objid = $P{batchid}
AND ma.state = 'ACTIVE'
AND ma.objid NOT IN 
( SELECT acctid FROM market_bill WHERE batchid = bb.objid ) 
