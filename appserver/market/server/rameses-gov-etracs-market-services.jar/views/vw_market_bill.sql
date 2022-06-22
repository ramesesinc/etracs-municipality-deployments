DROP VIEW IF EXISTS vw_market_bill;
CREATE VIEW vw_market_bill AS 
SELECT
mb.*,
mru.code AS unitno,
ma.acctno,
mai.acctname,
mbs.year,
mbs.month,
mbs.fromdate,
mbs.todate,
mbs.duedate,
mbs.expirydate,
mbs.billgroupid,
(mb.balanceforward + mb.interest + mb.surcharge + mb.amount) - (mb.totalpayment + mb.discount) AS balance,
ou.name AS orgunit_name,
ou.fullpath AS orgunit_fullpath,
mc.name AS center_name,
mai.owner_objid,
mai.owner_name

FROM market_bill mb
INNER JOIN market_billschedule mbs ON mb.billscheduleid = mbs.objid 
INNER JOIN market_account ma ON mb.acctid = ma.objid 
INNER JOIN market_account_info mai ON mb.acctinfoid = mai.objid 
INNER JOIN market_rental_unit mru ON mai.unitid = mru.objid 
INNER JOIN market_orgunit ou ON mru.orgunitid = ou.objid
INNER JOIN market_center mc ON ou.centerid = mc.objid