SET FOREIGN_KEY_CHECKS = 0;

DELETE FROM market_payment_item;
DELETE FROM market_payment_bill;
DELETE FROM market_payment;

DELETE FROM market_credit_billitem;
DELETE FROM market_penalty_billitem;
DELETE FROM market_billitem;
DELETE FROM market_abstract_billitem;

DELETE FROM market_rental_bill;
DELETE FROM market_electricity_bill;
DELETE FROM market_water_bill;

DELETE FROM market_bill;
DELETE FROM market_compromise;

UPDATE market_batch_bill SET taskid = NULL; 
DELETE FROM market_batch_bill_task;
DELETE FROM market_batch_bill_error;
DELETE FROM market_batch_bill;

UPDATE market_billgroup SET state = 'INACTIVE';

SET FOREIGN_KEY_CHECKS = 1;







