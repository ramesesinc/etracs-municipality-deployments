DROP VIEW IF EXISTS vw_market_penalty_billitem;
CREATE VIEW vw_market_penalty_billitem AS 
SELECT
abi.*,
(abi.amount - abi.amtpaid) AS balance,
pbi.type,
pbi.billdate AS billdate 

FROM market_abstract_billitem abi
INNER JOIN market_penalty_billitem pbi ON pbi.objid = abi.objid 

