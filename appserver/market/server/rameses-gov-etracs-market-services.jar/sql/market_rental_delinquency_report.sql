[getReport]
SELECT z.objid,
z.acctno,
z.acctname,
z.paymentmode,
z.unitno,
z.centerid,
z.center_name,
z.orgunit_name,
z.classification_name,
z.rate,
z.ratetype,
z.year,
z.month,
z.yearmonth - IFNULL(z.unpaidyearmonth, z.yearmonth) AS unpaidmonths, 
IFNULL(z.unpaidbalance,0) AS unpaidbalance, 
IFNULL(z.surcharge,0) AS surcharge,
IFNULL(z.interest,0) AS interest,
IFNULL(z.currentamount,0) AS currentamount,
z.balance

FROM 
(SELECT 
ma.objid,
mb.state,
ma.acctno,
mai.acctname,
mai.paymentmode,
mu.code AS unitno,
ou.centerid,
mc.name AS center_name,
ou.name AS orgunit_name,
mrr.rate AS rate,
mrr.ratetype AS ratetype,
mbs.year,
mbs.month,
((mbs.year*12)+mbs.month) AS yearmonth,
(
   SELECT ((year*12)+month)    
   FROM vw_market_billitem 
   WHERE billid = mb.objid AND year > 0 AND balance>0
   ORDER BY year ASC, month ASC  LIMIT 1
) AS unpaidyearmonth,

( 
	SELECT SUM(balance) 
	FROM vw_market_billitem 
	WHERE billid = mb.objid AND forwarded = 1 
) AS unpaidbalance, 

( 
	SELECT SUM(balance) 
	FROM vw_market_penalty_billitem 
	WHERE billid = mb.objid AND type = 'SURCHARGE'	  
) AS surcharge, 

( 
	SELECT SUM(balance) 
	FROM vw_market_penalty_billitem 
	WHERE billid = mb.objid AND type = 'INTEREST'	  
) AS interest, 

( 
	SELECT SUM(balance) 
	FROM vw_market_billitem 
	WHERE billid = mb.objid AND forwarded = 0 
) AS currentamount, 

( 
	SELECT SUM(amount - amtpaid) 
	FROM market_abstract_billitem 
	WHERE billid = mb.objid 
) AS balance 

FROM market_bill mb 
INNER JOIN market_rental_bill mrb ON mb.objid = mrb.objid
INNER JOIN market_billschedule mbs ON mb.billscheduleid = mbs.objid 
INNER JOIN market_account ma ON mb.acctid = ma.objid 
INNER JOIN market_account_info mai ON ma.acctinfoid  = mai.objid 
INNER JOIN market_rental_unit mu ON mai.unitid = mu.objid
INNER JOIN market_rental_rate mrr ON mrb.rateid = mrr.objid 
INNER JOIN market_orgunit ou ON mu.orgunitid = ou.objid
INNER JOIN market_center mc ON ou.centerid = mc.objid 
WHERE mb.state <> 'CLOSED'
) z
ORDER BY z.center_name, z.classification_name, z.orgunit_name, z.acctno, z.acctname
