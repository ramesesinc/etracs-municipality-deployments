DROP VIEW IF EXISTS vw_waterworks_payment_item;

CREATE VIEW vw_waterworks_payment_item AS 
SELECT wpi.objid,wbi.year,wbi.month,ia.title AS item_title,ia.sortorder AS item_sortorder,wpi.amount,wpi.discount, wpi.parentid AS pmtid  
FROM waterworks_payment_item wpi
INNER JOIN waterworks_billitem wbi ON wpi.refid = wbi.objid  
INNER JOIN waterworks_itemaccount ia ON wbi.itemid = ia.objid
UNION ALL 
SELECT cr.objid,wb.year,wb.month,'ADVANCE PAYMENT (CREDIT)' AS item_title, 100 AS item_sortorder, cr.dr AS amount,0 AS discount, wp.objid AS pmtid  
FROM waterworks_credit cr
INNER JOIN waterworks_payment wp ON wp.objid = cr.paymentrefid
INNER JOIN waterworks_bill wb ON wp.billid = wb.objid 
AND cr.dr > 0 
