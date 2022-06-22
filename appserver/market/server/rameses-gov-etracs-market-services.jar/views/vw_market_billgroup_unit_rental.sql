DROP VIEW IF EXISTS vw_market_billgroup_unit_rental;
CREATE VIEW vw_market_billgroup_unit_rental AS 
SELECT mru.objid, mru.code, ou.fullpath, mbgu.billgroupid  
FROM market_rental_unit mru
INNER JOIN market_orgunit ou ON mru.orgunitid = ou.objid 
LEFT JOIN market_billgroup_unit mbgu ON mbgu.unitid = mru.objid AND mbgu.billtype = 'RENTAL'