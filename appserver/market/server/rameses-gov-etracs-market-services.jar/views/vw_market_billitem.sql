DROP VIEW IF EXISTS vw_market_billitem;
CREATE VIEW vw_market_billitem AS 
SELECT
mbi.*,
CASE WHEN mri.billdate IS NULL 
THEN CONCAT( mai.title, ' ', mri.year, ' ', mri.month  )
ELSE CONCAT(mai.title, ' (', mri.billdate , ')') 
END AS particulars,
(mbi.amount - mbi.amtpaid) AS balance,
mri.year,
mri.month,
mri.billdate AS billdate 

FROM market_abstract_billitem mbi
INNER JOIN market_billitem mri ON mri.objid = mbi.objid 
INNER JOIN market_itemaccount mai ON mbi.itemid = mai.objid  

