[getOpenItems]
SELECT
   mpi.objid,
   mpi.billitemrefid, 
   mpi.billdate,
   mpi.type,
   mai.objid AS acctid,
   mai.title AS acctname,
   mbi.amount - mbi.amtpaid AS amount
FROM market_penalty_billitem mpi 
INNER JOIN market_abstract_billitem mbi ON mbi.objid = mpi.objid 
INNER JOIN market_itemaccount mai ON mbi.itemid = mai.objid 
WHERE mbi.billid = $P{billid} AND mpi.billdate <= $P{txndate}


[getItemsForBalanceForward]
SELECT 
   z.year, z.month, MIN(z.billdate) AS billdate, 
   z.type, z.item_objid, z.refitemid, SUM(z.amount) AS amount 
FROM
   ( 
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

      mpi.billdate AS billdate,
      mpi.type, 
      abi.itemid AS item_objid, 
      mabi.itemid AS refitemid,
      abi.amount - abi.amtpaid AS amount
      
   FROM market_penalty_billitem mpi
   INNER JOIN market_abstract_billitem abi ON abi.objid = mpi.objid
   INNER JOIN market_billitem mbi ON mpi.billitemrefid = mbi.objid
   INNER JOIN market_abstract_billitem mabi ON mabi.objid = mbi.objid   
   INNER JOIN market_bill mb ON abi.billid = mb.objid 
   INNER JOIN market_billschedule mbs ON mb.billscheduleid = mbs.objid  
   WHERE abi.billid = $P{billid} AND ( abi.amount - abi.amtpaid > 0  )
   ) z
GROUP BY z.year, z.month, z.type, z.item_objid, z.refitemid 