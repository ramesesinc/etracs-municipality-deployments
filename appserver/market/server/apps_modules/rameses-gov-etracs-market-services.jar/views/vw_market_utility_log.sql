DROP VIEW IF EXISTS vw_market_utility_log;
CREATE VIEW vw_market_utility_log AS
SELECT me.*,
prev.objid AS prev_objid,
prev.reading AS prev_reading,
prev.month AS prev_month,
prev.year AS prev_year,
((me.year *12) + me.month) AS yearmonth,
(me.amount - me.amtpaid) AS balance
FROM market_utility me 
LEFT JOIN market_utility prev ON me.previd = prev.objid



