[findAccountListCount]
SELECT 
   COUNT(*) AS itemcount
FROM market_batch_bill bb
INNER JOIN market_billgroup_unit bgu ON bb.billgroupid = bgu.billgroupid 
INNER JOIN market_rental_unit mru ON bgu.unitid = mru.objid 
INNER JOIN market_electricity_subaccount esa ON mru.currentacctid = esa.acctid 
WHERE bb.objid = $P{batchid}

[getUnprocessedAccountList]
SELECT 
   esa.acctid AS acctid
FROM market_batch_bill bb
INNER JOIN market_billgroup_unit bgu ON bb.billgroupid = bgu.billgroupid 
INNER JOIN market_rental_unit mru ON bgu.unitid = mru.objid 
INNER JOIN market_electricity_subaccount esa ON mru.currentacctid = esa.acctid 
WHERE bb.objid = $P{batchid}
AND esa.acctid NOT IN 
( SELECT acctid FROM market_bill WHERE batchid = bb.objid ) 
