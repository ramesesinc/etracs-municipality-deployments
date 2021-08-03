<style>
.table1 th:first-child  {
	width: 110px;
}
.table1 th:nth-of-type(2)  {
	width: 50px;
}
.table1 td {
	vertical-align: top;
}
.table1 {
	font-size: 12px;
}
</style>

__waterworks_billing_period__

<div class="table1">

|Name  	|Type	|Required |Description 						|
|:---   |:---   |---      |:---|
| objid | string | Yes | primary key | 
| scheduleid | string | Yes | link to schedule group | 
| year | integer | Yes | |
| month | integer | Yes | |
| fromdate | date | Yes | The start date of the period  | 
| todate | date | Yes | The end date of the period   |
| readingdate | date | Yes | |
| readingenddate | date | No | |
| billdate | date | Yes | |
| billingenddate | date | No | |
| discdate | date | Yes | Discount date |
| duedate | date | Yes | Penalty due date |
| billexpirydate | date | Yes | after this date the bill will be automatically closed |

</div>