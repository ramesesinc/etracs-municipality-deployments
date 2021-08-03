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

__waterworks_schedule_group__

<div class="table1">

|Name  	|Type	|Required |Description 						|
|:---   |:---   |---      |:---|
| objid | string | Yes | primary key | 
| description | string | Yes | short description | 

</div>

##Referenced By##
- waterworks_billing_period
_ waterworks_subarea