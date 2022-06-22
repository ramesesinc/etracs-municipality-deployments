[updateUnitRates]
UPDATE mu 
SET mu.rateid = mbr.objid 
FROM market_rental_rate mbr, market_rental_unit mu
WHERE mbr.unitid = mu.objid 
AND mbr.batchid = $P{batchid}