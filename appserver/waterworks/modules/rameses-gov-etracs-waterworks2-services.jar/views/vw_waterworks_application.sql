DROP VIEW IF EXISTS vw_waterworks_application;
CREATE VIEW vw_waterworks_application AS 
SELECT   
  app.*, 
  wa.acctno
FROM waterworks_application app 
LEFT JOIN waterworks_account wa ON app.acctid = wa.objid  