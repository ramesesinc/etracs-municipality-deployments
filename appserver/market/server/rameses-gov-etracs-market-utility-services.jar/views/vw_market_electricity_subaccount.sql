DROP VIEW IF EXISTS vw_market_electricity_subaccount;
CREATE VIEW vw_market_electricity_subaccount AS 
SELECT
sa.*,
ma.acctno AS parentacctno,
mu.code AS unitno,
mai.acctname,
mai.owner_objid,
mai.owner_name,
mai.owner_address_text,
ou.objid AS orgunitid,
ou.name AS orgunit_name,
ctr.objid AS centerid,
ctr.name AS center_name ,
mbgu.billgroupid

FROM market_electricity_subaccount sa
INNER JOIN market_account ma ON sa.acctid = ma.objid 
INNER JOIN market_account_info mai ON ma.acctinfoid = mai.objid  
INNER JOIN market_rental_unit mu ON mai.unitid = mu.objid 
INNER JOIN market_orgunit ou ON mu.orgunitid = ou.objid 
INNER JOIN market_center ctr ON ou.centerid = ctr.objid 

LEFT JOIN market_billgroup_unit mbgu ON (mu.objid = mbgu.unitid AND mbgu.billtype = 'ELECTRICITY' )