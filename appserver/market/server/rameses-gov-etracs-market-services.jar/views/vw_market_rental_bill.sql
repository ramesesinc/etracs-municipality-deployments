DROP VIEW IF EXISTS vw_market_rental_bill;
CREATE VIEW vw_market_rental_bill AS 
SELECT
mb.*,
ma.acctno,
mai.acctname,
mrr.rate,
mrr.ratetype,
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
mai.paymentmode,
mru.code AS unitno,
mru.unittype AS unittype,
mru.centerid,
mru.orgunitid,
ou.name AS orgunit_name,
ou.fullpath AS orgunit_fullpath,
mc.name AS center_name,
mc.title AS center_title,
mc.address_text AS center_address_text,
mc.contactinfo AS center_contactinfo

FROM market_bill mb
INNER JOIN market_rental_bill mrb ON mrb.objid = mb.objid 
LEFT JOIN market_rental_rate mrr ON mrb.rateid = mrr.objid 
INNER JOIN market_account ma ON mb.acctid = ma.objid
INNER JOIN market_account_info mai ON ma.acctinfoid = mai.objid
INNER JOIN market_rental_unit mru ON mai.unitid = mru.objid
INNER JOIN market_orgunit ou ON mru.orgunitid = ou.objid
INNER JOIN market_center mc ON ou.centerid = mc.objid
INNER JOIN market_billschedule mbs ON mb.billscheduleid = mbs.objid
INNER JOIN market_billgroup bg ON mbs.billgroupid = bg.objid
