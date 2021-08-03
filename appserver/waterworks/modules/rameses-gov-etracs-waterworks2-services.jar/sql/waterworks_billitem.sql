[getBillBeginBalanceItems]
SELECT bi.objid,bi.year,bi.month,
CASE bi.month
   WHEN 1 THEN 'JAN'
   WHEN 2 THEN 'FEB'
   WHEN 3 THEN 'MAR'
   WHEN 4 THEN 'APR'
   WHEN 5 THEN 'MAY'
   WHEN 6 THEN 'JUN'
   WHEN 7 THEN 'JUL'
   WHEN 8 THEN 'AUG'
   WHEN 9 THEN 'SEP'
   WHEN 10 THEN 'OCT'
   WHEN 11 THEN 'NOV'
   WHEN 12 THEN 'DEC'
END AS monthname,
ia.title AS item_title,bi.amount, bi.amtpaid, (bi.amount-bi.amtpaid) AS balance    
FROM waterworks_billitem bi 
INNER JOIN waterworks_bill b ON bi.refbillid = b.objid
INNER JOIN waterworks_itemaccount ia ON bi.itemid = ia.objid
WHERE b.objid = $P{refbillid} 
AND ((bi.year*12)+bi.month) < ((b.year*12)+b.month) 
ORDER BY bi.year, bi.month

[getPreviousBillItems]
SELECT c.*, ia.title AS item_title,
CASE c.month
   WHEN 1 THEN 'JAN'
   WHEN 2 THEN 'FEB'
   WHEN 3 THEN 'MAR'
   WHEN 4 THEN 'APR'
   WHEN 5 THEN 'MAY'
   WHEN 6 THEN 'JUN'
   WHEN 7 THEN 'JUL'
   WHEN 8 THEN 'AUG'
   WHEN 9 THEN 'SEP'
   WHEN 10 THEN 'OCT'
   WHEN 11 THEN 'NOV'
   WHEN 12 THEN 'DEC'
END AS monthname,
(c.amount - c.amtpaid ) AS balance 
FROM 
  (SELECT b.* FROM 
    (SELECT a.*,
      IFNULL((
          SELECT SUM(wpi.amount)+SUM(wpi.discount) 
          FROM waterworks_payment_item wpi 
          INNER JOIN waterworks_payment wp ON wpi.parentid = wp.objid  
          INNER JOIN waterworks_bill wpb ON wp.billid = wpb.objid 
          WHERE wpi.refid = a.objid 
          AND ((wpb.year*12)+wpb.month) < $P{yearmonth}
      ),0) AS amtpaid
    FROM  
      (SELECT 
      wbi.objid,
      wbi.year,
      wbi.month,
      wbi.itemid,
      wbi.amount,
      wbi.txndate
      FROM waterworks_billitem wbi 
      INNER JOIN waterworks_bill wb ON wbi.billid = wb.objid
      WHERE wb.acctid = $P{acctid}
      AND ((wb.year*12)+wb.month) < $P{yearmonth}
      UNION
      SELECT 
      wbi.objid,
      wbi.year,
      wbi.month,
      wbi.itemid,
      wbi.amount,
      wbi.txndate 
      FROM waterworks_billitem wbi 
      INNER JOIN waterworks_bill wb ON wbi.refbillid = wb.objid
      WHERE wb.acctid = $P{acctid}
      AND ((wb.year*12)+wb.month) <= $P{yearmonth}) a
      ) b 
      WHERE b.amount - b.amtpaid > 0) c
      
  INNER JOIN waterworks_itemaccount ia ON c.itemid = ia.objid
  ORDER BY c.year, c.month, ia.sortorder    

[getOpenBillItems]
SELECT bi.objid, bi.year, bi.month, bi.amount, bi.amtpaid, bi.itemid AS item_objid, ia.sortorder AS item_sortorder  
FROM waterworks_billitem bi 
INNER JOIN waterworks_bill b ON bi.billid = b.objid 
INNER JOIN waterworks_itemaccount ia ON bi.itemid = ia.objid 
WHERE bi.acctid = $P{acctid}
AND (bi.amount - bi.amtpaid) > 0
AND ((b.year*12)+b.month) <= ${yearmonth}
UNION
SELECT bi.objid, bi.year, bi.month, bi.amount, bi.amtpaid, bi.itemid AS item_objid, ia.sortorder AS item_sortorder  
FROM waterworks_billitem bi 
INNER JOIN waterworks_bill b ON bi.refbillid = b.objid 
INNER JOIN waterworks_itemaccount ia ON bi.itemid = ia.objid 
WHERE bi.acctid = $P{acctid}
AND (bi.amount - bi.amtpaid) > 0
AND ((b.year*12)+b.month) <= ${yearmonth}

