[getOpenBillItems]
SELECT 
   mbi.objid,
   abi.billid,
   mbi.year,
   mbi.month,
   mbi.billdate,
   mai.objid AS acctid,
   mai.title AS acctname,
   ( abi.amount - abi.amtpaid ) AS amount,
   mbi.billdate AS txndate,
   abi.remarks,
   abi.forwarded
   FROM market_billitem mbi 
   INNER JOIN market_abstract_billitem abi ON abi.objid = mbi.objid 
   INNER JOIN market_itemaccount mai ON abi.itemid = mai.objid 
   WHERE abi.billid = $P{billid} 
ORDER BY mbi.billdate 

[getBillItemsForBalanceForward]
SELECT z.year, z.month, z.billdate, z.item_objid, z.compromiseid, SUM(z.amount) AS amount 
FROM (
   SELECT 
      CASE 
         WHEN mbi.year IS NULL THEN mbs.year
         WHEN mbi.year = 0 THEN mbs.year
         ELSE mbi.year END
      AS year,   
      CASE 
         WHEN mbi.month IS NULL THEN mbs.month
         WHEN mbi.month = 0 THEN mbs.month
         ELSE mbi.month END
      AS month,   

      mbi.billdate AS billdate,
      abi.itemid AS item_objid, 
      abi.amount - abi.amtpaid AS amount,
      mbi.compromiseid
   FROM market_billitem mbi 
   INNER JOIN market_abstract_billitem abi ON abi.objid = mbi.objid
   INNER JOIN market_bill mb ON abi.billid = mb.objid 
   INNER JOIN market_billschedule mbs ON mb.billscheduleid = mbs.objid  
   WHERE abi.billid = $P{billid} AND (abi.amount - abi.amtpaid > 0)
) z
GROUP BY z.year, z.month, z.billdate, z.item_objid, z.compromiseid  