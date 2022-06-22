SET FOREIGN_KEY_CHECKS = 0;
UPDATE market_credit_billitem SET paymentid = NULL, creditmemoid = NULL;
DELETE FROM market_payment_item;
DELETE FROM market_payment_bill;
DELETE FROM market_payment;
DELETE FROM market_penalty_billitem;
DELETE FROM market_billitem;
DELETE FROM market_credit_billitem;
DELETE FROM market_abstract_billitem;

UPDATE market_batch_bill SET taskid = NULL;
DELETE FROM market_batch_bill_error;
DELETE FROM market_batch_bill_task;


DELETE FROM market_rental_bill;
DELETE FROM market_water_bill;
DELETE FROM market_electricity_bill;
DELETE FROM market_bill;
UPDATE market_billgroup SET batchid = NULL;
DELETE FROM market_batch_bill;

DELETE FROM market_electricity_subaccount;
DELETE FROM market_water_subaccount;

UPDATE market_account_info SET acctid = NULL;
UPDATE market_rental_unit SET currentacctid = NULL;

DELETE FROM market_recurringfee;
DELETE FROM market_account;
DELETE FROM market_rental_rate;

DELETE FROM market_account_info;
DELETE FROM market_billgroup_unit;
DELETE FROM market_billschedule;
DELETE FROM market_billgroup;
DELETE FROM market_rental_unit;

UPDATE market_orgunit SET parentid = NULL;
DELETE FROM market_orgunit;
DELETE FROM market_center;

SET FOREIGN_KEY_CHECKS = 1;

