DROP VIEW IF EXISTS vw_waterworks_batch_billing_error
;
CREATE VIEW vw_waterworks_batch_billing_error AS 
SELECT   
  err.*, 
  wa.seqno,
  wa.acctno,
  wai.acctname
FROM waterworks_batch_billing_error err 
INNER JOIN waterworks_account wa ON wa.objid = err.acctid
INNER JOIN waterworks_account_info wai ON wai.objid = wa.acctinfoid
