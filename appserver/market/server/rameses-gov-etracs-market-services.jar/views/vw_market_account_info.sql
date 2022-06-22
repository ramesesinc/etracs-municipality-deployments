DROP VIEW IF EXISTS vw_market_account_info;
CREATE VIEW vw_market_account_info AS 
SELECT
mai.*,
mu.objid AS unit_objid,
mu.code AS unit_code,
mu.centerid AS unit_centerid,
mu.areasqm AS unit_areasqm


FROM market_account_info mai 
INNER JOIN market_rental_unit mu ON mai.unitid = mu.objid


