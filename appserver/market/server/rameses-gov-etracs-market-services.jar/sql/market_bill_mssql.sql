[findLastBill]
SELECT mb.objid 
FROM market_bill mb
INNER JOIN market_billschedule mbs ON mb.billscheduleid = mbs.objid 
ORDER BY mbs.year DESC, mbs.month DESC 

[updateBalanceForward]
UPDATE  mb
SET mb.balanceforward = ISNULL((
	SELECT SUM(amount - amtpaid) 
	FROM market_abstract_billitem 
	WHERE billid = $P{billid} AND forwarded = 1
), 0)
FROM market_bill mb
WHERE mb.objid = $P{billid}

[updateBillTotals]
UPDATE mb 
SET mb.amount = ISNULL((
	SELECT SUM(bi.amount) 
	FROM market_abstract_billitem bi
	INNER JOIN market_billitem mbi ON bi.objid=mbi.objid
	WHERE bi.billid = $P{billid} AND forwarded = 0
), 0),
mb.surcharge = ISNULL((
	SELECT SUM(bi.amount) 
	FROM market_abstract_billitem bi
	INNER JOIN market_penalty_billitem mpi ON bi.objid=mpi.objid   
	WHERE bi.billid = $P{billid} AND forwarded = 0
	AND mpi.type = 'SURCHARGE' 
), 0),
mb.interest = ISNULL((
	SELECT SUM(bi.amount) 
	FROM market_abstract_billitem bi
	INNER JOIN market_penalty_billitem mpi ON bi.objid=mpi.objid   
	WHERE bi.billid = $P{billid} AND forwarded = 0
	AND mpi.type = 'INTEREST' 
), 0)
FROM market_bill mb
WHERE mb.objid = $P{billid}

[updateTotalPayment]
UPDATE mb
SET mb.totalpayment = ISNULL(
	(SELECT SUM(mb1.amount) 
	FROM market_payment_bill mb1 
	INNER JOIN market_payment mp1 ON mb1.parentid = mp1.objid 
	WHERE mp1.voided = 0 AND mb1.billid = $P{billid}
	AND mp1.reftype <> 'creditmemo')
,0) 
FROM market_bill mb
WHERE mb.objid = $P{billid}

[getBillItems]
SELECT 
   y.objid,
   y.year,
   y.month,
   y.billdate,
   y.particulars,
   y.txndate, 
   y.amount,
   y.surcharge,
   y.interest,
   (y.amtpaid + y.surchargepaid + y.interestpaid) AS amtpaid,
   (y.amount+y.surcharge+y.interest) - (y.amtpaid + y.surchargepaid + y.interestpaid) AS balance
   
FROM (SELECT z.*, 
	ISNULL(( SELECT SUM(amount)  
		FROM market_penalty_billitem _mpi
		INNER JOIN market_abstract_billitem _mbi ON _mpi.objid = _mbi.objid 
		WHERE _mpi.billitemrefid = z.objid  
		AND _mpi.type = 'SURCHARGE'), 0) AS surcharge,
	ISNULL(( SELECT SUM(amtpaid)  
		FROM market_penalty_billitem _mpi
		INNER JOIN market_abstract_billitem _mbi ON _mpi.objid = _mbi.objid 
		WHERE _mpi.billitemrefid = z.objid  
		AND _mpi.type = 'SURCHARGE'), 0) AS surchargepaid,
	ISNULL(( SELECT SUM(amount)  
			FROM market_penalty_billitem _mpi
			INNER JOIN market_abstract_billitem _mbi ON _mpi.objid = _mbi.objid 
			WHERE _mpi.billitemrefid = z.objid  
			AND _mpi.type = 'INTEREST'), 0) AS interest,
	ISNULL(( SELECT SUM(amtpaid)  
			FROM market_penalty_billitem _mpi
			INNER JOIN market_abstract_billitem _mbi ON _mpi.objid = _mbi.objid 
			WHERE _mpi.billitemrefid = z.objid  
			AND _mpi.type = 'INTEREST'), 0) AS interestpaid
	FROM
		(
		SELECT
			mbi.objid,
			mbi.year,
			mbi.month,
			mbi.billdate,
			mai.title AS particulars,
			mbi.billdate AS txndate,
			abi.amount,
		    abi.amtpaid,
		    abi.forwarded
		FROM market_billitem mbi 
		INNER JOIN market_abstract_billitem abi ON abi.objid = mbi.objid 
		INNER JOIN market_itemaccount mai ON abi.itemid = mai.objid 
		WHERE abi.billid = $P{billid} 

		UNION ALL

		SELECT 
			mbi.objid,
			mbs.year,
			mbs.month,
			mbs.billdate as billdate,
		    mai.title AS particulars, 
		    mbs.billdate AS txndate,
		    mbi.amount,
			mbi.amtpaid,
			mbi.forwarded
		FROM market_credit_billitem mri 
		INNER JOIN market_abstract_billitem mbi ON mbi.objid = mri.objid 
		INNER JOIN market_itemaccount mai ON mbi.itemid = mai.objid 
		INNER JOIN market_bill mb ON mbi.billid = mb.objid 
		INNER JOIN market_billschedule mbs ON mb.billscheduleid = mbs.objid 
		WHERE mbi.billid =  $P{billid}
		AND mbi.forwarded = 1
		AND mbi.amount <> mbi.amtpaid 

		UNION ALL 

		SELECT 
			mbi.objid,
			mbs.year,
			mbs.month,
			mp.refdate AS billdate,
		    mai.title AS particulars, 
		    mp.refdate AS txndate,
		    mbi.amount,
			mbi.amtpaid,
			mbi.forwarded
		FROM market_credit_billitem mri 
		INNER JOIN market_abstract_billitem mbi ON mbi.objid = mri.objid 
		INNER JOIN market_itemaccount mai ON mbi.itemid = mai.objid 
		INNER JOIN market_payment_bill mpb ON mri.paymentid = mpb.objid 
		INNER JOIN market_payment mp ON mpb.parentid = mp.objid 
		INNER JOIN market_bill mb ON mbi.billid = mb.objid 
		INNER JOIN market_billschedule mbs ON mb.billscheduleid = mbs.objid 
		WHERE mbi.billid = $P{billid}
		AND mbi.forwarded = 0
		AND mbi.amount <> mbi.amtpaid 

		) z
) y
ORDER BY y.txndate


[getStatement]
SELECT x.*,
	(x.amount + x.surcharge + x.interest - x.amtpaid) AS total
FROM
	(
	SELECT y.*
	FROM
		(
		SELECT 
			mcb.objid,
			'BALANCE FORWARD(ADVANCE)' AS particulars,
			mbs.fromdate AS txndate,
			0 AS amount,
			mbi.amtpaid, 
			-1 AS sindex,
			mbs.year,
			mbs.month,
			0 AS surcharge,
			0 AS interest
		FROM market_credit_billitem mcb
		INNER JOIN market_abstract_billitem mbi ON mcb.objid = mbi.objid 
		INNER JOIN market_bill mb ON mbi.billid = mb.objid  
		INNER JOIN market_billschedule mbs ON mb.billscheduleid = mbs.objid
		WHERE mb.objid = $P{billid}
		AND mbi.forwarded = 1

		UNION ALL	
		SELECT z.*,
			ISNULL(( SELECT SUM(amount)  
			FROM market_penalty_billitem _mpi
			INNER JOIN market_abstract_billitem _mbi ON _mpi.objid = _mbi.objid 
			WHERE _mpi.billitemrefid = z.objid  
			AND _mpi.type = 'SURCHARGE'), 0) AS surcharge,

			ISNULL(( SELECT SUM(amount)  
			FROM market_penalty_billitem _mpi
			INNER JOIN market_abstract_billitem _mbi ON _mpi.objid = _mbi.objid 
			WHERE _mpi.billitemrefid = z.objid  
			AND _mpi.type = 'INTEREST'), 0) AS interest

			FROM ( 	
				SELECT
					mbi.objid,
					CASE WHEN abi.remarks IS NULL
					   THEN mai.title
					   ELSE CONCAT( mai.title, ' (',  abi.remarks , ')' )
					END AS particulars,
				    mbi.billdate AS txndate,
				    abi.amount,
				    0 AS amtpaid,
				    1 AS sindex,
				    mbi.year,
				    mbi.month
				FROM market_billitem mbi 
				INNER JOIN market_abstract_billitem abi ON abi.objid = mbi.objid 
				INNER JOIN market_itemaccount mai ON abi.itemid = mai.objid 
				WHERE abi.billid = $P{billid} 
			) z	
		) y
		UNION ALL 
		SELECT 
			mp.objid,
			CONCAT( mp.reftype, ' ', mp.refno ) AS particulars,
			mp.refdate AS txndate,
			0 AS amount,
			mpb.amount AS amtpaid, 
			3 AS sindex,
			mbs.year,
			mbs.month,
			0 AS surcharge,
			0 AS interest
		FROM market_payment_bill mpb
		INNER JOIN market_bill mb ON mpb.billid = mb.objid
		INNER JOIN market_billschedule mbs ON mb.billscheduleid = mbs.objid
		INNER JOIN  market_payment mp ON  mpb.parentid = mp.objid
		WHERE mpb.billid = $P{billid}
		AND mp.reftype <> 'creditmemo'	
    )x
ORDER BY x.txndate, x.sindex

