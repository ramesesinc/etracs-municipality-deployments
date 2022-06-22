[addUnits]
INSERT INTO market_billgroup_unit  
(objid, billgroupid, billtype, unitid, state)

SELECT 
CONCAT( mru.objid, '_', mbg.billtype ) AS objid,
mbg.objid,
mbg.billtype,
mru.objid AS unitid,
'ACTIVE' AS state 

FROM market_rental_unit mru,

(SELECT objid, billtype 
 FROM market_billgroup WHERE objid = $P{billgroupid}) mbg 

WHERE mru.centerid LIKE $P{centerid}
AND mru.orgunitid LIKE $P{orgunitid}
AND mru.code LIKE $P{unit}
AND mru.objid NOT IN (
    SELECT unitid 
    FROM market_billgroup_unit 
    WHERE billtype = mbg.billtype 
) 
