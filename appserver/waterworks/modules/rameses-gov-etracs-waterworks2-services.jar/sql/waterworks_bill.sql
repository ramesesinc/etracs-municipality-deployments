[findOutstandingForwardBalance]
SELECT 
(IFNULL( 
	(SELECT SUM( wbi.amount - wbi.amtpaid ) 
	FROM waterworks_billitem wbi 
	INNER JOIN waterworks_bill wb ON wbi.billid = wb.objid 
	WHERE wb.acctid = $P{acctid} 
	AND ((wb.year*12)+wb.month) < ${yearmonth})
,0)
+
IFNULL(
	(SELECT SUM( wbi.amount - wbi.amtpaid ) 
	FROM waterworks_billitem wbi 
	INNER JOIN waterworks_bill wb ON wbi.refbillid = wb.objid 
	WHERE wb.acctid = $P{acctid} 
	AND ((wb.year*12)+wb.month) <= ${yearmonth})
,0)
) AS amount
