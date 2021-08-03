[updateOpenItems]
UPDATE waterworks_compromise_fee cf, waterworks_compromise c 
SET cf.billid = $P{billid}, cf.txndate = $P{txndate} 
WHERE cf.parentid = c.objid 
AND c.acctid = $P{acctid}
AND cf.duedate <= $P{billdate}


[updateCompromisedBillItems]
UPDATE waterworks_billitem bi, waterworks_compromise_billitem cbi 
SET bi.amtpaid = bi.amount
WHERE cbi.billitemid = bi.objid 
AND cbi.parentid = $P{compromiseid}
