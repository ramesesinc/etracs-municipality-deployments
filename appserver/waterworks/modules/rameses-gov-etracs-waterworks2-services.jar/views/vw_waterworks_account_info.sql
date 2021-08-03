DROP VIEW IF EXISTS vw_waterworks_account_info;
CREATE VIEW vw_waterworks_account_info AS 
SELECT   
  ai.objid, 
  ai.acctname AS acctname,
  ai.owner_objid AS owner_objid,
  ai.owner_name AS owner_name,
  ai.address_type AS address_type,
  ai.address_text AS address_text,
  ai.address_barangay_objid AS address_barangay_objid,
  ai.address_barangay_name AS address_barangay_name,
  ai.address_city AS address_city,
  ai.address_province AS address_province,
  ai.address_municipality AS address_municipality,
  ai.address_unitno AS address_unitno,
  ai.address_street AS address_street,
  ai.address_subdivision AS address_subdivision,
  ai.address_bldgno AS address_bldgno,
  ai.address_bldgname AS address_bldgname,
  ai.address_pin AS address_pin,
  ai.stuboutid AS stuboutid,
  ai.subareaid AS subareaid,
  ai.meterid AS meterid,
  ai.classificationid AS classification_objid,
  ai.units AS units,
  ai.attributes AS attributes,
  ai.meterstate AS meterstate,
  ai.mobileno AS mobileno,
  ai.email AS email,
  ai.phoneno AS phoneno,
  wm.serialno AS meter_serialno,
  wm.capacity AS meter_capacity,
  wm.brand AS meter_brand,
  wms.title AS meter_size,
  sa.code AS subarea_code,
  a.code AS subarea_area_code,
  so.code AS stubout_code

FROM waterworks_account_info ai 
LEFT JOIN waterworks_subarea sa ON ai.subareaid = sa.objid 
LEFT JOIN waterworks_area a ON sa.areaid = a.objid
LEFT JOIN waterworks_stubout so ON ai.stuboutid = so.objid
LEFT JOIN waterworks_meter wm ON ai.meterid = wm.objid
LEFT JOIN waterworks_metersize wms ON wm.sizeid = wms.objid
