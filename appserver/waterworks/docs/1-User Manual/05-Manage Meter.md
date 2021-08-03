<style>
.table1 th:first-child  {
	width: 100px;
}
.table1 td {
	vertical-align: top;
	font-size:11px;
}
</style>

# Manage Meter #

Meters are the devices that are used to measure the volume of water. Some meters are provided by the customer while some are provided by the enterprise. These meters will be associated to the customer account once it is used. To carry out the transactions in the  succeeding section, you need the ff. role:

`WATERWORKS.MASTER`

## Adding Meter ##
To view the list of meters, go to the explorer Main Menu and select __Master > Waterworks > Meter__.  From the list you will be able to see the ff. screen:

![alt text][meterlist] 

- __Stock__ - means meter is in stock or provided by the enterprise;
- __Non Stock__ - means meter is in stock or provided by the customer;

To create a new meter, click on `New` button. This should open the screen below:

![alt text][meter] 

- __Serial No__ - is the serial no. of the meter. This should be a unique value;
- __Brand Name__ - enter the meter's brand;
- __Stock Type__ - STOCK or NONSTOCK. STOCK means it is provided by the enterprise or in stock. Non stock means it is provided by the customer;
- __Meter size__ - Select from the drop down list of meter sizes. This is important because for some enterprises this influences the rate of consumption;
- __Capacity__ - Select from the dropdown list of capacity. This is used for the reading. The reading should not be bigger than this number otherwise it will reset back to zero.
- __Reading__ - Is the initial reading. This value is optional. The system will update this value after the readings are posted. 


[meterlist]: ./images/meterlist.png
[meter]: ./images/meter.png
