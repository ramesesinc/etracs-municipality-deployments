<style>
.table1 th:first-child  {
	width: 100px;
}
.table1 td {
	vertical-align: top;
	font-size:11px;
}
</style>

# Customer Accounts #

A customer account holds pertinent information and all transactions of a customer including the ledger, consumptions and billing history. There are two ways to create a customer account:

- 1) __Capture Account__ - used when capturing already existing accounts. This will be discussed in this section.
- 2) __Application for New Connection__ - used when the system is already operational and adding accounts are done through a transaction. This is discussed in the *New Connection* section.

To perform the succeeding sections, you need the ff. roles:

`WATERWORKS.MASTER`

## Capture Account ##
To capture Account, click the Waterworks icon from the home screen panel. <i>Note: The screen below may not exactly look in your screen)</i>

![alt text][homelink] 

From the waterworks panel, click on the __Capture Customer Account__. The customer account screen will be displayed. 

![alt text][capture] 

- __Account status__. Indicates the current status of the account. The states could be - *DRAFT*, *ACTIVE*, *DISCONNECTED* and *CLOSED*. When capturing accounts, it will be in draft state. No transactions yet can be made until this point. By approving, it becomes active. Active transactions will be included in the billing and readings. If for some reason like nonpayment of dues, the account will be disconnected. Disconnected accounts will still be billed but will not be included in the readings anymore. Once an account is closed, it is fully deactivated and no transactions can be made anymore to the account. 


- __Account No__ - This a unique code for the account. Encode existing account no. or leave this blank. The system will automatically assign the account number if blank based on the pattern provided in the system variable __water_account_no_format__ <i>(See under System Variables)</i>.

- __Owner Name__ - Lookup from a list of taxpayers. This field is optional. If specified this will be integrated with the taxpayer's record within ETRACS.

- __Account Name__ - If owner was specified, this will display the owner's name by default. However, you can edit this for the actual name of the account that will be used to display in the billings. 

- __Account Address__ - Click on the `pencil` icon to edit the address and from there supply the necessary information. The barangay must be specified. 

- __Classification__ - The classifications are pre-defined values within and maintained by the system. Choose the most appropriate classification for the account. This is important because the classification can influence the rates to use.

- __Date Registered__ - This is an optional value used for information purposes only. This is supplied automatically if the account was created via the New Connection transaction.

- __No. of Units__ - indicates no. of units in a household. This is an optional value. Just leave this as 1. 

- __Remarks__ - Place any remarks that you need to write to remember for this account. 

- __Attributes__ - These are special variables that can be added for this account that is applicable if you have special rules that need to be included. Most common example is SENIOR_CITIZEN attribute which may have special treatment for discounts. These attributes can be included in the rules.

- __Sub Area__ - Lookup the subarea where this account belongs to. This will specify the billing cycle for this account.

- __Stubout__ - This is optional. If provided it will associate the account to this stubout. This is needed especially by the reader.

- __Seqno__ - The sequence no specifies the order by which the billings and readings are processed in a batch billing. This can also make the job of the reader easier when doing readings in the field as seqno can be based on order of reading.

- __Next Billing Period__ - This indicates the next billing year and month i.e. the active year and month is one month less than this. This value is set in the sub area associated with the account. It is important that all accounts within the same sub area must have the same billing period. If this value is not set, you must set this in the sub area before an initial billing can be made on this account.


- __Meter Serial No__ - Lookup from the list of meters. The meter must be created first before it can be looked up. A meter can only be associated once per account which means if the meter was already associated to an account, it cannot be looked up anymore. After selecting the meter, you must specify the status of the meter whether ACTIVE, DISCONNECTED or DEFECTIVE. If disconnected, it means readings will be stopped for this meter. If defective, there might be some adjustments to be done during billing. 

Once finished, click the `Save` button to save the record. This will still be in DRAFT mode which means this account can still be edited by clicking on the `Edit` button. After closing the record, you can retrieve the account by opening it from the list.


## Viewing the Account Listing ##
You can view the existing customer accounts by clicking on *View Customer Accounts* from the Waterworks Menu panel. The list below will be displayed:


![alt text][custlist] 

- __Active(Metered)__ - List of accounts that are active and has a meter. This will be the majority of transactions.

- __Active(Unmetered)__ - This is to support the needs of some enterprises wherein they have active accounts but do not have meters. Although a little bit unusual, there are some who require this.

- __Disconnected__ - List of active accounts that have been disconnected. These accounts will still be billed on a monthly basis for their past dues and additional charges but will not be serviced anymore i.e. they will not have a water sales entry.

- __Draft__ - These are accounts that have not been approved yet and is not active in the system.

- __Defective__ - List of active accounts that have known defective meters. They will still be billed but the consumption volumes will have to be adjusted.

- __Closed__ - these are accounts that are closed and inactive.

From the list you can also do some searches in the search box. To view an account, select the item and double click or click the `Open` button or press Ctrl-O. This will open up the Customer Account Form. 

![alt text][viewcust] 

The ff. tabs are displayed: 

- __General Information__ - Displays the information about the account.  
- __Consumption__ - Shows the readings / consumptions made per month;
- __Ledger__ - Shows the items and amounts charged,credits and payments made by the customer and their balances;
- __Billings__ - Shows the billings made on the account.

It also shows buttons on the form the `Approve` and `Generate Bill` Button. The approve will activate the account while the Generate Bill will generate the first bill. 


## Approving an Account ##
Transactions can only be carried for accounts that are __active__. A customer account can be activated by clicking on the `Approve` button. Once approved, the account will be ready for transactions and information of the account cannot be edited anymore. 

If this is an entirely new account that has not been billed yet, you do not need to create the initial bill. However take note of the Group Bill and Period because that will be the bill period when creating this bill. Click on Approve and a message will ask you to confirm. 

To approve an account the first bill must be generated. Further changes must be through transactions and this is discussed in the *Change Request* section. 

Before approving an account you must generate an initial billing. This is discussed to the next section.  


[homelink]: ./images/custacct/homelink.png
[capture]: ./images/custacct/capture.png
[custlist]: ./images/custacct/custlist.png
[viewcust]: ./images/custacct/viewcust.png


