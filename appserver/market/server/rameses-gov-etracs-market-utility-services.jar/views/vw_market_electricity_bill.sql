DROP VIEW IF EXISTS vw_market_electricity_bill;
CREATE VIEW vw_market_electricity_bill AS 
SELECT
mb.*,
esa.acctno,
ma.acctno AS superacctno,
mru.centerid,
mru.code AS unitno,
mai.acctname,
mai.owner_objid,
mai.owner_name,
mai.owner_address_text,
mbs.year,
mbs.month,
mbs.fromdate,
mbs.todate,
mbs.duedate,
mbs.expirydate,
mbs.billgroupid,

eb.reading,
eb.readingdate,
eb.reader_objid,
eb.volume,
eb.rate,

IFNULL(CASE 
	WHEN prev.objid IS NULL THEN eb.initialreading
	WHEN mai.unitid = prev.unitid THEN  prev.reading 
	ELSE eb.initialreading 
END,0) AS prevreading,
esa.capacity,
ou.name AS orgunit_name,
mc.name AS center_name

FROM market_electricity_bill eb
INNER JOIN market_bill mb ON eb.objid = mb.objid 
INNER JOIN market_account ma ON mb.acctid = ma.objid
INNER JOIN market_account_info mai ON mb.acctinfoid = mai.objid  
INNER JOIN market_rental_unit mru ON mai.unitid = mru.objid

INNER JOIN market_orgunit ou ON mru.orgunitid = ou.objid
INNER JOIN market_center mc ON ou.centerid = mc.objid

INNER JOIN market_billschedule mbs ON mb.billscheduleid = mbs.objid
INNER JOIN market_electricity_subaccount esa ON eb.subacctid = esa.objid  

LEFT JOIN vw_market_electricity_prevbill prev ON mb.prevbillid = prev.objid
