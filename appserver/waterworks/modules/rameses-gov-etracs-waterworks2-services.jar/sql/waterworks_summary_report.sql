[getReport]
SELECT mg.objid AS maingroup, 
wg.objid AS group, 
classificationid, 
COUNT(*) AS classcount, 
SUM( wb.amount + wb.arrears ) AS waterwsales,
SUM( wb.surcharge + wb.interest ) AS penalty, 

FROM
waterworks_account wa 
INNER JOIN waterworks_group wg ON wa.groupid = wg.objid 
INNER JOIN waterworks_maingroup mg ON wg.maingroupid = wg.objid 
INNER JOIN waterworks_billing wb ON wb.acctid = wa.objid  
INNER JOIN 
(
	SELECT wb.*
	FROM waterworks_billing wb 
	INNER JOIN waterworks_batch_billing wbb ON wb.batchid = wbb.objid 
	WHERE year=$P{year} AND month=$P{month}
) wba  ON wba.acctid = wa.objid 

GROUP BY mg.objid, wg.objid, wa.classificationid