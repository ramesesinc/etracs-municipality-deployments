DROP VIEW IF EXISTS vw_market_account;
CREATE VIEW vw_market_account AS 
SELECT
ma.*,
mai.acctname,
mai.owner_name,
mai.owner_address_text,
mai.owner_entitytype,
mai.owner_profileid,
mai.owner_profileno,
mai.owner_firstname,
mai.owner_lastname,
mai.owner_middlename,
mai.owner_resident,
mai.owner_address_unitno,
mai.owner_address_bldgno,
mai.owner_address_bldgname,
mai.owner_address_street,
mai.owner_address_subdivision,
mai.owner_address_barangay_objid,
mai.owner_address_barangay_name,
mai.owner_address_citymunicipality,
mai.owner_address_province,
mai.owner_tin,
mai.owner_email,
mai.owner_mobileno,
mai.owner_phoneno,
mai.owner_id_type_name,
mai.owner_id_idno,
mai.owner_id_placeissued,
mai.owner_id_dtissued,
mai.contact_mobileno,
mai.contact_email,
mai.contact_phoneno,
mai.unitid,
mai.paymentmode,	

mai.business_objid,	
mai.business_bin,	
mai.business_tradename,	

mu.code AS unitno,
mu.areasqm,
mu.centerid,
mo.name AS center_name,
mbgu.billgroupid,
ou.objid AS orgunitid,
ou.name AS orgunit_name,
ou.fullpath AS orgunit_fullpath,

( SELECT objid FROM market_rental_rate 
	WHERE unitid = mai.unitid 
	AND effectivedate <= NOW()
	ORDER BY effectivedate DESC LIMIT 1 ) AS rateid 

FROM market_account ma
INNER JOIN market_account_info mai ON ma.acctinfoid = mai.objid
INNER JOIN market_rental_unit mu ON mai.unitid = mu.objid
INNER JOIN market_orgunit ou ON mu.orgunitid = ou.objid 
INNER JOIN market_center mo ON ou.centerid = mo.objid

LEFT JOIN market_billgroup_unit mbgu ON mbgu.unitid = mai.unitid AND mbgu.billtype = 'RENTAL'


