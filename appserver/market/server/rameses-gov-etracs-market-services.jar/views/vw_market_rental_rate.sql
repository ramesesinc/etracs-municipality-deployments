DROP VIEW IF EXISTS vw_market_rental_rate;
CREATE VIEW vw_market_rental_rate AS 

SELECT 
mrr.*,
mru.code AS unitno,
mc.name AS center_name,
mou.name AS orgunit_name,
mou.fullpath AS orgunit_fullpath


FROM market_rental_rate mrr 
INNER JOIN market_rental_unit mru ON mrr.unitid = mru.objid
LEFT JOIN market_orgunit mou ON mru.orgunitid = mou.objid 
LEFT JOIN market_center mc ON mru.centerid = mc.objid 
