[getList]
SELECT
	mp.objid,
	mp.refid,
	mp.refno,
	mp.reftype,
	mp.refdate,
	mp.txnmode,
	mp.voided,
	mp.remarks,
	mpb.amount,
	mpb.discount
FROM market_payment mp 
INNER JOIN market_payment_bill mpb ON mp.objid = mpb.parentid 
WHERE mpb.billid = $P{billid}
ORDER BY mp.refdate DESC

[getPostCredits]
SELECT DISTINCT mp.objid, mp.reftype 
FROM market_payment_bill mpb
INNER JOIN market_payment mp ON mpb.parentid = mp.objid  
WHERE mpb.billid = $P{billid}  
AND mp.reftype = 'creditmemo'
AND mpb.objid IN 
(
    SELECT mpi.parentid 
	FROM market_payment_item mpi 
	INNER JOIN market_abstract_billitem mbi ON mpi.billitemid = mbi.objid
	INNER JOIN market_billitem mrb ON mbi.objid = mrb.objid 	
	WHERE mbi.billid =  $P{billid} 
	AND mrb.billdate >= $P{txndate}
)
