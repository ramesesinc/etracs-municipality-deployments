DROP VIEW IF EXISTS vw_market_payment_item;
CREATE VIEW vw_market_payment_item AS
SELECT me.*,
pmt.refno AS payment_refno,
pmt.refdate AS payment_refdate,
pmt.refid AS payment_refid,
(me.year*12)+me.month AS yearmonth
FROM market_payment_item me 
INNER JOIN market_payment pmt ON me.parentid = pmt.objid 



