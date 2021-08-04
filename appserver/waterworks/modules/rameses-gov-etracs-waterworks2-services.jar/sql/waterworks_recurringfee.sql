[updateAmtBilled]
UPDATE waterworks_recurringfee wf
SET wf.amtbilled = IFNULL( (  
	SELECT SUM( bi.amount ) 
	FROM waterworks_billitem bi 
	WHERE bi.recurringfeeid = wf.objid 
	AND bi.billid = $P{billid}
), 0)
WHERE wf.acctid = $P{acctid}
AND wf.type IN ('once', 'installment') 


[updateAmtBilledByBillItem]
UPDATE waterworks_recurringfee wf
SET wf.amtbilled = IFNULL( (  
	SELECT SUM( bi.amount ) 
	FROM waterworks_billitem bi 
	WHERE bi.recurringfeeid = wf.objid 
	AND bi.objid = $P{billitemid}
), 0)
WHERE wf.objid = $P{recurringfeeid}