DROP VIEW IF EXISTS vw_market_utility_current;
CREATE VIEW vw_market_utility_current AS
SELECT me.*,
prev.objid AS prev_objid,
prev.reading AS prev_reading,
prev.month AS prev_month,
prev.year AS prev_year,
((me.year *12) + me.month) AS yearmonth
FROM market_utility me 
LEFT JOIN market_utility prev ON me.previd = prev.objid
WHERE me.nextid IS NULL


