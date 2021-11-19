DROP VIEW IF EXISTS vw_vehicle_permit;
CREATE VIEW vw_vehicle_permit AS
SELECT 
   vp.*,
   vf.controlno,
   va.objid AS appid,
   va.appno, 
   va.appdate,
   vg.owner_objid,
   vg.owner_name,
   vg.owner_address_text,
   vg.phoneno,
   vg.email,
   vg.mobileno,
   vg.barangay_objid,
   vg.barangay_name,   
   vfy.year,
    vt.objid AS vehicletype_objid,
    vt.title AS vehicletype_title 
FROM vehicle_permit vp
INNER JOIN vehicle_application va ON vp.objid = va.permitid
INNER JOIN vehicle_franchise_generalinfo vg ON va.geninfoid = vg.objid
INNER JOIN vehicle_franchise_year vfy ON va.franchiseyearid = vfy.objid
INNER JOIN vehicle_franchise vf ON vfy.franchiseid = vf.objid
INNER JOIN vehicletype vt ON vf.vehicletypeid = vt.objid