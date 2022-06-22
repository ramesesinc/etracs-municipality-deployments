DROP VIEW IF EXISTS vw_market_electricity_prevbill;
CREATE VIEW vw_market_electricity_prevbill AS 
SELECT
mb.objid,
mb.acctid,
mai.unitid, 
eb.reading,
mbs.year,
mbs.month,
((mbs.year*12) + mbs.month) AS yearmonth
FROM market_electricity_bill eb
INNER JOIN market_bill mb ON eb.objid = mb.objid
INNER JOIN market_billschedule mbs ON mb.billscheduleid = mbs.objid 
INNER JOIN market_account_info mai ON mb.acctinfoid = mai.objid  


