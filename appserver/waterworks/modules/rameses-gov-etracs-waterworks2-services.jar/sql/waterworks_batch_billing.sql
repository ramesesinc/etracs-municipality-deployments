[getAccountsForBilling]
SELECT wa.objid, wbb.year, wbb.month, wbb.scheduleid
FROM vw_waterworks_account wa
INNER JOIN waterworks_batch_billing wbb ON wa.subareaid = wbb.subareaid
WHERE wbb.objid = $P{batchid} 
AND wa.state IN ('DRAFT','ACTIVE')
AND (wa.excludeinbatch IS NULL OR wa.excludeinbatch=0)
AND wa.objid NOT IN (
	SELECT acctid FROM waterworks_bill WHERE batchid = $P{batchid}
)
AND wa.objid NOT IN (
	SELECT acctid FROM waterworks_batch_billing_error WHERE batchid = $P{batchid}	
)
LIMIT ${start}, ${limit}
 
[findForBillingCount]
SELECT COUNT(*) AS count
FROM vw_waterworks_account wa
INNER JOIN waterworks_batch_billing wbb ON wa.subareaid = wbb.subareaid
WHERE wbb.objid = $P{batchid}
AND wa.state IN ('DRAFT','ACTIVE')
AND (wa.excludeinbatch IS NULL OR wa.excludeinbatch=0)
AND wa.objid NOT IN (
	SELECT acctid FROM waterworks_bill WHERE batchid = $P{batchid}
)
AND wa.objid NOT IN (
	SELECT acctid FROM waterworks_batch_billing_error WHERE batchid = $P{batchid}	
)

[resetExcludeInBatchAccounts]
UPDATE waterworks_account wa, waterworks_account_info wi
SET wa.excludeinbatch = 0
WHERE wa.acctinfoid = wi.objid 
AND wi.subareaid = $P{subareaid}
