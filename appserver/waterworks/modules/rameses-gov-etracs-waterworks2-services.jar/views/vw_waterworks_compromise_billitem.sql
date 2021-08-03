DROP VIEW IF EXISTS vw_waterworks_compromise_billitem;
CREATE VIEW vw_waterworks_compromise_billitem AS 
SELECT   
  wcb.*,
  bi.year,
  bi.month, 
  ia.title AS item_title

FROM waterworks_compromise_billitem wcb 
INNER JOIN waterworks_billitem bi ON  wcb.billitemid = bi.objid 
INNER JOIN waterworks_itemaccount ia ON bi.itemid = ia.objid