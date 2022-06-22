[findAccountListCount]
SELECT 
   COUNT(*) AS itemcount
FROM market_batch_bill bb
INNER JOIN market_billgroup_unit bgu ON bb.billgroupid = bgu.billgroupid 
INNER JOIN market_rental_unit mru ON bgu.unitid = mru.objid 
INNER JOIN market_water_subaccount wsa ON mru.currentacctid = wsa.acctid 
WHERE bb.objid = $P{batchid}

[getUnprocessedAccountList]
SELECT 
   wsa.acctid AS acctid
FROM market_batch_bill bb
INNER JOIN market_billgroup_unit bgu ON bb.billgroupid = bgu.billgroupid 
INNER JOIN market_rental_unit mru ON bgu.unitid = mru.objid 
INNER JOIN market_water_subaccount wsa ON mru.currentacctid = wsa.acctid 
WHERE bb.objid = $P{batchid}
AND wsa.acctid NOT IN 
( SELECT acctid FROM market_bill WHERE batchid = bb.objid ) 


