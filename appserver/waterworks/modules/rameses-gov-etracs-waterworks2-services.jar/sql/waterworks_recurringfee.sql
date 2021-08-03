[getOpenRecurringItems]
SELECT rf.* 
FROM waterworks_recurringfee rf 
WHERE rf.acctid = $P{acctid}
AND rf.state = 'ACTIVE'
AND (amount - amtbilled) > 0
AND ((startyear*12)+startmonth) <= $P{yearmonth}

[updateAmtBilled]
UPDATE waterworks_recurringfee wf
SET wf.amtbilled = IFNULL( (  
	SELECT SUM( bi.amount ) 
	FROM waterworks_billitem bi 
	WHERE bi.recurringfeeid = wf.objid 
), 0)
WHERE wf.acctid = $P{acctid}
AND wf.type IN ('once') 
