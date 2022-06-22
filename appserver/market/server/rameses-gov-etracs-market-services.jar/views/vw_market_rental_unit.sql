DROP VIEW IF EXISTS vw_market_rental_unit;
CREATE VIEW vw_market_rental_unit AS 
SELECT
mu.*,
mc.objid AS center_objid,
mc.name AS center_name,
ou.objid AS orgunit_objid,
ou.name AS orgunit_name,
ou.leftindex AS orgunit_leftindex,
ou.rightindex AS orgunit_rightindex,

ou.fullpath AS orgunit_fullpath,

ma.acctno AS account_acctno,
ma.objid AS account_objid,
mai.acctname AS account_acctname,

mbgu.billgroupid,
( SELECT objid FROM market_rental_rate 
	WHERE unitid = mu.objid  
	AND effectivedate <= NOW()
	ORDER BY effectivedate DESC LIMIT 1 ) AS rateid 

FROM market_rental_unit mu 
INNER JOIN market_center mc ON mu.centerid = mc.objid 
INNER JOIN market_orgunit ou ON mu.orgunitid = ou.objid
 
LEFT JOIN market_account ma ON mu.currentacctid = ma.objid 
LEFT JOIN market_account_info mai ON ma.acctinfoid = mai.objid 


LEFT JOIN market_billgroup_unit mbgu ON (mu.objid = mbgu.unitid AND mbgu.billtype = 'RENTAL')