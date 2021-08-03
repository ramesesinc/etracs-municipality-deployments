DROP VIEW if exists vw_waterworks_consumption;
CREATE VIEW vw_waterworks_consumption AS
SELECT wc.*, 
	prev.reading AS prev_reading,
	prev.month AS prev_month,
	prev.year AS prev_year,
	wb.batchid

FROM waterworks_consumption wc
LEFT JOIN waterworks_bill wb ON wb.objid = wc.billid 
LEFT JOIN waterworks_consumption prev 
ON prev.acctid = wc.acctid AND prev.meterid = wc.meterid  AND (( prev.year*12 )+prev.month) = ( (wc.year*12)+wc.month-1)