DROP VIEW IF EXISTS vw_waterworks_account
;
CREATE VIEW vw_waterworks_account AS 
SELECT   
  wa.*, 
  ai.acctname,
  ai.owner_objid,
  ai.owner_name,
  ai.address_type,
  ai.address_text,
  ai.address_barangay_objid,
  ai.address_barangay_name,
  ai.address_city,
  ai.address_province,
  ai.address_municipality,
  ai.address_unitno,
  ai.address_street,
  ai.address_subdivision,
  ai.address_bldgno,
  ai.address_bldgname,
  ai.address_pin,
  ai.stuboutid,
  ai.subareaid,
  ai.meterid,
  ai.classificationid,
  ai.units,
  ai.attributes,
  ai.meterstate,

  ai.mobileno,
  ai.email,
  ai.phoneno

FROM waterworks_account wa 
INNER JOIN waterworks_account_info ai ON wa.acctinfoid = ai.objid  
LEFT JOIN waterworks_meter wm ON ai.meterid = wm.objid