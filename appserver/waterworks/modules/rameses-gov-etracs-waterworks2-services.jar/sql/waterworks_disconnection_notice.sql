[getBillItemsWithoutPeriod]
SELECT a.* 
FROM (
	SELECT DISTINCT bi.year,bi.month, sa.schedulegroupid AS scheduleid
	FROM waterworks_billitem bi 
	INNER JOIN waterworks_account wa ON bi.acctid=wa.objid
  	INNER JOIN waterworks_account_info wai ON wa.acctinfoid=wai.objid 	
	INNER JOIN waterworks_subarea sa ON wai.subareaid=sa.objid
	WHERE bi.billid IS NULL

) a
LEFT JOIN waterworks_billing_period bp 
   ON bp.scheduleid=a.scheduleid AND bp.year=a.year AND bp.month=a.month 
WHERE bp.objid IS NULL


[getTotalDueByAcct]
SELECT 
bi.acctid, wa.acctinfoid, MIN(bp.objid) AS fromperiod, MAX(bp.objid) AS toperiod,  
SUM(bi.amount-bi.amtpaid) AS amtdue 
FROM waterworks_billitem bi 
INNER JOIN waterworks_account wa ON bi.acctid=wa.objid
INNER JOIN waterworks_account_info wai ON wa.acctinfoid=wai.objid 	
INNER JOIN waterworks_subarea sa ON wai.subareaid=sa.objid
INNER JOIN waterworks_billing_period bp ON (bi.year=bp.year AND bi.month=bp.month AND sa.schedulegroupid = bp.scheduleid )
WHERE bi.amount - bi.amtpaid > 0
AND bp.duedate < $P{refdate} 
GROUP BY bi.acctid, wa.acctinfoid


