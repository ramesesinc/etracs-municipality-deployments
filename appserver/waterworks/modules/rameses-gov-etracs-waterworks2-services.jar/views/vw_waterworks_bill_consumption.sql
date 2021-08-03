DROP VIEW if exists vw_waterworks_bill_consumption;
CREATE VIEW vw_waterworks_bill_consumption AS
SELECT  
	wc.objid,
	wc.billid,
	wc.reading AS reading,
	wc.volume,
	wc.amount,
	wc.hold,
	wc.reason,
	wc.readingdate,
	wc.reader_objid,
	wc.reader_name,
	prev.reading AS prev_reading,
	wb.batchid

FROM waterworks_consumption wc 
LEFT JOIN waterworks_bill wb ON wc.billid = wb.objid
LEFT JOIN waterworks_consumption prev 
ON prev.acctid = wc.acctid AND prev.meterid = wc.meterid  AND (( prev.year*12 )+prev.month) = ( (wc.year*12)+wc.month-1)