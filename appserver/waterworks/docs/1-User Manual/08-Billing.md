<style>
.table1 th:first-child  {
	width: 100px;
}
.table1 td {
	vertical-align: top;
}
</style>

# Billing #

The billing is prepared monthly and can be generated in two ways:
1. Manually by clicking on generate bill in the account
2. By batch billing

## Billing States ##

A bill has the ff. states:

![billstates]


- __DRAFT__ - This is the state of the first bill that is captured manually. Once approved it is set to POSTED.
- __OPEN__ - When generating a new bill, the initial state is OPEN. At this time it only contains the balance forward. If payments are made at this state and there is no unpaid amount, the amount paid will be stored in the credits.
- __POSTED__ - When the readings are approved, the current bill items will be generated. If there are credits in the open state, the credits will be automatically applied. 
- __CLOSED__ - A bill will be closed when a new bill is generated. The amount due of the closed bill will be forwarded to the next bill.

## Billing Cycle ##
Each bill follows a the process depicted in the flowchart:

![alt text][billcycle]

- Step 1. __Create Bill__ - system creates the bill. Can be done individually or through batch billing.
- Step 2. __Calculate Forward Balance__ - System captures balance from the previous bill. state is OPEN.

- Step 3. Make Readings. This is the point where the readings are done. If using a mobile reader, the bills are downloaded into the device including their balances. Upon making actual reading, the device can immediatly calculate the bill and print and give to the customer. Once returned to the office, all readings can be uploaded to the system. Without the device, readings must be encoded manually.

- Step 4. Run Billing. The system will call the run billing rules and will calculate the fees, from the readings computed and other fees. Unless approved, this items will not be visible yet during payment.

- Step 5. The bill must be approved first before it can be paid. Only the Approver can perform this task.

- Step 6. After approving, if there are credits from deposits or payments made during the OPEN state, it will be applied to the bill items. 

- Step 7. After approving, the state is changed to POSTED. This is now ready for payment.

- Step 8. __Print and Send Bill to Customer__. If there is still amount due, the bill will be sent to for printing state. After printing, the billrefno value will be supplied. The billrefno is the series no of the pre-printed paper. If there is no amount due, no need to send billing.

- Step 9. __Calculate Surcharge and Penalty__. If there were no payments made or if payments were made but still did not cover the full payment required after the due date, the surcharge will be automatically applied. The surcharge are set in the rules.

## Balance Forward Formula ##

The system will perform the ff. the following formula to arrive at the balance forward (This is applied to the previous bill)

```[Total billitems amount - amtpaid - discount]  - [Total Credits]```

You must countercheck this by checking the previous bill:
```[balance forward] + [total fees and charges] - [total payments] - [discounts]``` 

The countercheck value and the system generated value must be the same.

## Bill Information ##

Each bill contains the ff: information (only the impt information must be noted):

<div class="table1">

| Name  	   | Description|
|:-------------|:-------------------------------------------------------|
|billno		   | The unique bill number. If generated thru a batch bill this number is calculated based on the batch bill no prefix and bill sequence. If manually it is automatically generated through the bill numbering format specified in the sys_var key <i>waterworks_billno_format</i>.|
|billrefno     | Usually for manual prepared bills to reference bills in the old system |
|billdate      | The date the bill was generated |	
|acctno        | Account number of the customer |
|meter         | Serial No, meter size and capacity and state of meter if ACTIVE or DEFECTIVE |
|acctname	   | The specified name of the account |
|acctstate	   | Status of the account whether ACTIVE,DISCONNECTED or UNMETERED (meaning no meter attached) |
|address	   | Address of the account |
|period|It contains the period fromdate and todate covered by this bill. The year and month of this bill is taken from the period fromdate.|
|readingdate   | the date the a reading was made for this bill|
|due date      | The due date of payment. After this payment, the penalties will be fired. |
|billexpirydate| The date bill is expired. Usually the date before the next bill is prepared. After this date, payments cannot be made anymore. The succeeding payments will be referened in the next bill | 
|validitydate|This refers to the next valid date. This is important because this will signal the system to recompute the bill. If for example the current date is more than validity date the surcharge will automatically fire and the system will move the validity date to the next applicable date|
|readings   |The previous reading and current reading. The volume is the difference in cu. meters. The amount is calculated based on the rules ```There will be no readings if there is no attached meter``` |
|balanceforward   |Balance from previous bill. Balance can be positive which means there are still unpaid dues or negative which means there was an excess payment or zero which means there are no unpaid dues from the previous bill.  |
|other charges   |Calculated by the system. It can be fixed monthly fees, or recurring fees like installments. |
| waters sales   |The amount calculated from the consumption |

</div>

[billstates]: ./images/bill/billstates.gif
[billcycle]: ./images/bill/billcycle.gif






