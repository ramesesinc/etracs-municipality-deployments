[getBillItemsWithoutSchedule]
SELECT a.* 
FROM
(SELECT DISTINCT
   sa.schedulegroupid AS scheduleid,	
   wbi.year,
   wbi.month  
FROM waterworks_billitem wbi
INNER JOIN waterworks_account wa ON wbi.acctid = wa.objid 
INNER JOIN waterworks_account_info wai ON wa.acctinfoid = wai.objid 
INNER JOIN waterworks_subarea sa ON wai.subareaid = sa.objid 
WHERE wbi.billid IS NULL) a 
LEFT JOIN waterworks_billing_period wpp ON a.year = wpp.year AND a.month=wpp.month
WHERE wpp.objid IS NULL

[getReportData]
SELECT b.*,
CASE WHEN b.daysdiff <= 30 THEN b.amtdue ELSE 0 END AS d30,
CASE WHEN b.daysdiff > 30 AND b.daysdiff<=60 THEN b.amtdue ELSE 0 END AS d60,
CASE WHEN b.daysdiff > 60 AND b.daysdiff<=90 THEN b.amtdue ELSE 0 END AS d90,
CASE WHEN b.daysdiff > 90 THEN b.amtdue ELSE 0 END AS dover90,
CASE b.month
	WHEN 1 THEN 'Jan'
	WHEN 2 THEN 'Feb'
	WHEN 3 THEN 'Mar'
	WHEN 4 THEN 'Apr'
	WHEN 5 THEN 'May'
	WHEN 6 THEN 'Jun'
	WHEN 7 THEN 'Jul'
	WHEN 8 THEN 'Aug'
	WHEN 9 THEN 'Sep'
	WHEN 10 THEN 'Oct'
	WHEN 11 THEN 'Nov'
	WHEN 12 THEN 'Dec'
END AS monthname

FROM (
	SELECT 
	wa.acctno,
	wai.acctname,
	wai.address_text,
	DATEDIFF( NOW(), a.duedate ) AS daysdiff,
	a.*
	FROM  
	( 
	   SELECT 
		 wb.acctid,	 
		 wb.billno, 	 
	   wbp.year,
		 wbp.month, 
		 wbp.duedate,
	   SUM(wbi.amount - wbi.amtpaid) AS amtdue
	   FROM waterworks_billitem wbi 
	   INNER JOIN waterworks_bill wb ON wbi.billid = wb.objid 
	   INNER JOIN waterworks_billing_period wbp ON wb.year=wbp.year AND wb.month=wbp.month AND wb.scheduleid=wbp.scheduleid
	   WHERE wbi.amount- wbi.amtpaid > 0 AND NOT(wbi.billid IS NULL) 
	   GROUP BY wb.acctid, wb.billno, wbp.year, wbp.month, wbp.duedate    
		 
		 UNION ALL 
	   SELECT 
		 wbi.acctid, 
		 '-' AS billno,
		 wbi.year,
		 wbi.month,
		 NULL AS duedate, 
		 SUM(wbi.amount - wbi.amtpaid) AS amtdue
		 FROM waterworks_billitem wbi
	   WHERE wbi.amount- wbi.amtpaid > 0 AND wbi.billid IS NULL
		 GROUP BY wbi.acctid, wbi.year, wbi.month  
	) a
	INNER JOIN waterworks_account wa ON a.acctid = wa.objid 
	INNER JOIN waterworks_account_info wai ON wa.acctinfoid = wai.objid
	INNER JOIN waterworks_subarea sa ON wai.subareaid = sa.objid 
	ORDER BY wa.acctno, a.year, a.month 
) b	