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


#waterworks_schedule_group#


<div class="table1">

|Field    |Type	| Required | Description   										| 	
|:---	   |:---	|:-------  |:---------------------------------------------| 
| objid    |String	|The primary key										|
| serialno | string | Yes | Unique  |
| brand | string | Yes |   |
| sizeid | string | Yes | link to waterworks_meter_size  |
| capacity | string | Yes |   |
| stocktype | string | Yes | STOCK or NONSTOCK  |
| state | string | Yes |  default:ACTIVE |
| currentacctid | string | Yes | link to waterworks_account  |
| reading | integer | No |   |

</div>