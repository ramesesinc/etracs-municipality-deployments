[getPostCreditPayments]
SELECT 
   mp.objid
FROM market_payment_bill mpb 
INNER JOIN market_payment mp ON mpb.parentid = mp.objid 
WHERE mpb.billid = $P{billid}
AND mp.reftype = 'creditmemo' 
AND mp.refdate >= $P{refdate} 
ORDER BY mp.refdate DESC 