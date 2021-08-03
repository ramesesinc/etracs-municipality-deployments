# Introduction #

The __Waterworks Module__ is one of the plugins of ETRACS system to manage the operations of water utility usually run by the Economic Enterprise of an LGU. It mainly comprises the management of accounts of customers as well as billings and collection. Since this is connected with ETRACS, the user administration, taxpayer records and collection is handled by ETRACS while all the other operations specific to water management is handled by this module. 

To better understand the system, it is important first to know how it handles the billing cycles. All the customer information, meter readings, ledgers and payments for each customer are recorded in a __Customer Account__. The customer account is created in two ways: 

- 1. Through the New Connection application 
- 2. Capture Account (for existing records)

Once created, the accounts are associated to __Sub Areas__. These are groupings that share the same billing cycle and schedule. This grouping is important because most of the time, with some exception, bill preparation will be done in batches. The Sub Areas will be associated with a pre-defined schedule, i.e. the billing period, the reading dates, due dates, etc. This is updated to the next period after processing a batch billing.  

Water sales and payment transactions are recorded in __Bills__. Bills are prepared per customer account per month and has a duration or bill expiry date. Once expired, succeeding payments will be referenced to the next open bill. There will only be one open bill at a time for an account.   

Since the number of customer accounts will be many, bills are usually prepared in batches. __Batch billing__ is done per sub area. To process a batch, it first collects all customer accounts under the same sub area. On running the batch process,a bill will be created for each customer account. To create a bill, it does the following: 

- 1. Retrieves the bill of the previous month, gets the balance and closes it. Closing would mean checking if there are unpaid amounts in the previous bill, runs the surcharges and penalties if necessary and summarizes the total amount to a __Balance Forward__. This balance forward may be positive which means there is still an unpaid balance or negative meaning there is excess or overpayment. Once done, the previous bill is closed and the balance will be forwarded to the new bill. 

- 2. Once the new bill is open, succeeding transactions will be referenced to this new bill. The new bill can be open even if it has not yet completed the batch billing process. This is to accomodate payments from customers since the previous bill will already be closed.

- 3. After the bill preparation, the next step is to record the new consumptions for the period. A list will be prepared indicating all accounts in the batch for the reading. If the mobile reading app is acquired, the batch records are downloaded into the app. With a mobile app, the reading can be recorded and uploaded to the system once completed from the field, otherwise it is entered manually. The reading will be verified and amounts computed. Once approved, the amount will be recorded to the ledger and immediately reflected in the bill. If there are credits or overpayments, the system will make adjustments to record this. For example, there may be discounts for qualified accounts. 

- 4. After the consumption and other fees are posted to the billing, the billings can now be printed for distribution to the clients.

- 5. After the whole process is complete, the batch is closed. 

Other transactions of the waterworks system are also done to complete the other operations of the enterprise.


