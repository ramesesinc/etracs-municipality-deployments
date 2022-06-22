DROP VIEW IF EXISTS vw_market_compromise_billitem;
CREATE VIEW vw_market_compromise_billitem AS 
SELECT
mbi.objid,
mbs.year,
mbs.month, 
abi.itemid,
abi.amount,
mbi.compromiseid, 
mbi.billdate,
mb.billno

FROM market_billitem mbi 
INNER JOIN market_abstract_billitem abi ON mbi.objid = abi.objid  
INNER JOIN market_bill mb ON abi.billid = mb.objid 
INNER JOIN market_billschedule mbs ON mb.billscheduleid = mbs.objid 
WHERE NOT(mbi.compromiseid IS NULL) 