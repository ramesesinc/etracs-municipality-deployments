DROP VIEW IF EXISTS vw_market_recurringfee;
CREATE VIEW vw_market_recurringfee AS 
SELECT
mf.*,
mbs.year,
mbs.month,
mbs.billdate
FROM market_recurringfee mf
INNER JOIN market_billschedule mbs ON mf.billscheduleid = mbs.objid


