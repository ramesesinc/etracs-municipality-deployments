<style>
.table1 th:first-child  {
	width: 110px;
}
.table1 th:nth-of-type(2)  {
	width: 50px;
}
.table1 th:nth-of-type(3)  {
	width: 70px;
}
.table1 td {
	vertical-align: top;
}
.table1 {
	font-size: 10px;
}
</style>


waterworks_bill
====================


__waterworks_bill__

 <div class="table1">

|Field     |Type	|Required | Description| 	
|:-----	    |:-----	|:----	  |:------| 
| objid     |string	|Y        |The primary key|
| batchid   |string	|N        |Link to waterworks_batch_billing.This is only filled when the bill was generated through batch processing|
| billno    |string  |Y        |auto generated. Use sys_var <i>__waterworks_billno_format__</i> |  
| refbillno |string  |N        |Filled up during batch billing. During printing, specify the first number of the bill then the system will increment the number everytime it is printed. |  
| billdate  |datetime |Y       |Date bill was created|  
| state     |string |Y        | DRAFT = state is still in draft mode. The bill is not yet active.<br>OPEN=Bill is active. Ledger items or payments can be added.<br>CLOSED=bill is closed. No transactions can be made with this bill. Succeeding transactions will be made on the next bill |
| periodid  |string  |Y        |link to waterworks_billing_period. Copied from batch if processed through batch. If manually prepared uses the subarea.period of the account |
| acctid    |string  |Y        |link to waterworks_account.  |
| acctinfoid |string  |Y        |link to the latest waterworks_account_info, in this case the waterworks_account.acctinofid|
| expirydate|date    |Y        | bill expirydate. a day before next billdate. After this date, ledger items or payments cannot be added to the bill anymore. See Note 2|
| validitydate |date |Y  | This will be calculated by the rules during billing. If the current date is greater than the validity date then the billing will be updated. Normally validity date will be due date or expirydate. |
| balanceforward |decimal    |Y  | Balance forward is computed from the balance of previous bill. See Note 3 |
| preparedby_objid |string    |N  | Copied from batch if batchid is not null. Auto filled depending on user account |
| preparedby_name |string    |N  | Copied from batch if batchid is not null. Auto filled depending on user account |
| printed |int    |N  |  0 = not printed; 1 = printed |

</div>

## Notes ##

 - 1) Expirydate is derived from nextbilldate. To do this find the next period by adding one month to the bill year and month and call `WaterworksScheduleService.getSchedule` and pass the subarea.schedulegroupid and the next month year. Get the billdate and deduct one day. Once this date is surpassed by the current date any payments made will not be accepted anymore to reference this bill. 

 - 2) balanceforward is calculated as follows:
	- Find the previous bill and close it first. Bill can be closed even if it is not yet expired. 
	- Run the rules to calculate penalties to update the ledger, update the previous bill status to 2 and lastprocessdate to currentdate.
	- Retrieve all waterworks_ledger for account where amount - amtpaid - discount > 0 and month year <= previous bill month and year
	- Summarize total of item 2 into total_unpaid
	- Get sum of waterworks_credit dr-cr and save as total_credits
	- balanceforward = total_unpaid - total_credits
	- Compare it with the ff.formula where the billid is the objid of the previous bill (amount should be equal):
	```
	   waterworks_billing.balanceforward WHERE objid = :billid 
	   + SUM(waterworks_ledger.amount) WHERE billid = :billid  
	   + SUM(waterworks_payment.amount) WHERE billid = :billid
	```    

