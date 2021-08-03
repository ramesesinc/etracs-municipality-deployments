[cleanupAll]
SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM waterworks_account;
DELETE FROM waterworks_account_attribute;
DELETE FROM waterworks_account_info;
DELETE FROM waterworks_area;
DELETE FROM waterworks_batch_billing;
DELETE FROM waterworks_batch_billing_task;
DELETE FROM waterworks_bill;
DELETE FROM waterworks_billing_period;
DELETE FROM waterworks_billitem;
DELETE FROM waterworks_consumption;
DELETE FROM waterworks_credit;
DELETE FROM waterworks_meter;
DELETE FROM waterworks_metersize;
DELETE FROM waterworks_payment;
DELETE FROM waterworks_payment_item;
DELETE FROM waterworks_recurringfee;
DELETE FROM waterworks_schedule_group;
DELETE FROM waterworks_stubout;
DELETE FROM waterworks_subarea;
SET FOREIGN_KEY_CHECKS = 1;

[cleanupBill]
UPDATE waterworks_account SET billid = NULL, state='DRAFT';
UPDATE waterworks_bill SET consumptionid = NULL;
DELETE FROM waterworks_credit;
DELETE FROM waterworks_payment_item;
DELETE FROM waterworks_payment;
DELETE FROM waterworks_billitem;
DELETE FROM waterworks_consumption;
DELETE FROM waterworks_bill;
DELETE FROM waterworks_recurringfee;


[cleanupBatchBill]
UPDATE waterworks_batch_billing SET taskid = NULL;
DELETE FROM waterworks_batch_billing_task;
DELETE FROM waterworks_batch_billing;
