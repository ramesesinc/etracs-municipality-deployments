<style>
.table1 th:first-child  {
	width: 100px;
}
.table1 td {
	vertical-align: top;
	font-size:11px;
}
</style>

# Areas, Sub Areas and Stubouts #

The system organizes accounts into billing groups for better managment. The groups are as follows in the following heirarchical order:

- __Areas__ - is the major grouping. An area will be composed of several sub areas. 

- __Sub Area__ - is the group that is associated directly to a customer account. Customer accounts with the same sub area will have the same billing cycle. Some enterprises might term this as zones and some as blocks. Anyway, a more general term is used in the system so as not to create bias with existing terminologies. The batch billing will be per sub area. 

- __Stubout__ - the term refers to the cluster of meters within a sub area. This will be used in the ordering when doing readings. However this data is optional and some customer accounts may not belong to stubout.

Areas must be created first before sub area, and sub area before stubouts. Before performing the next section you need to have the ff. role 

`WATERWORKS.MASTER`

## Adding an Area ##

Go the explorer Main Menu and select __Master > Waterworks > Area__. It will open up the list of areas.  Click on `New` button to add an entry. Adding an area is quite simple. You just need to specify the code. The code is alphanumeric but you must start with a letter, not a number. Avoid also using special characters. Click on `Save` when finished.

![alt text][area1]

## Adding Sub Area ##

There are two ways in adding sub areas. 
1) From an area 
2) From the list

For adding sub area from an area, open first the area.  Go to __Master > Waterworks > Area__. Search area from the list and open it. Once opened, click on the *Sub Areas* Tab. 

![alt text][area2]

From this list, click `New` button. This will open a new sub area form for entry. 

![alt text][area3]

The ff. fields are as follows:
- __Area__ - This will already be specified based on the area where this subarea was created. If this was created from the sub area list, you need to select the area.
- __Code__ - Enter a unique code for this subarea. This is alphanumeric. As usual, start with letters not numbers;
- __Description__ - Enter a short description for this sub area;
- __Barangay__ - This is a lookup for barangay. Click on the magnifying glass near it or enter the cursor on the field and press enter. Select a barangay from the lookup list;
- __Schedule Group__ - Select a schedule group from the lookup list;

After saving the sub area, the `Add Billing Period` button will appear. Click this to assign the current period for this sub area. This will be the billing period during batch bill preparation. This can be changed by clicking the `Change Billing Period`. Although this can be changed, it is not advisable to change this especially if there are already billings made.

![alt text][area4]

## Viewing Sub Area List ##

You can also view the sub areas from the list. Go __Master > Waterworks > Sub Area__. This will display the list of sub areas. On the left side of the list you will also notice that there are different views as follows:

- __All__ - displays all sub areas;
- __For Billing__ - lists all sub areas where the current date exceeds the next period todate, meaning it is now due for billing;
- __Active__ - lists all sub areas that is currenly active, or the current date does not yet exceed the next period todate;
- __No period__ - lists all sub areas that does not yet a next period assigned;

## Stubout ##

Stubout here refers to the meters clustered together. This makes readings easier as the readers do not have to go to each house. There are some meters however that do not belong to a cluster, thus, the stubout is optional for some accounts. A stubout can belong only to one sub area. To add a stubout, there are two ways: 

1) From the sub area
2) From the stubout list


For adding stubout from a sub area, open first the sub area.  Go to __Master > Waterworks > Sub Area__. Search the sub area from the __All__ list and open it. Once opened, click on the *Stubouts* Tab. 

![alt text][area5]

From the stubout list, click `New` button. This will open a new stubout form for entry. 

![alt text][stuboutnew]

The ff. fields are as follows:
- __Sub Area__ - This will already be specified based on the sub area where this stubout was created. If this was created from the stubout list, you need to select the sub area.
- __Code__ - Enter a unique code for this subarea. This is alphanumeric. As usual, start with letters not numbers;
- __Description__ - Enter a short description for this sub area;
- __Barangay__ - This is a lookup for barangay. Click on the magnifying glass near it or enter the cursor on the field and press enter. Select a barangay from the lookup list;

After saving the stubout, you can also retrieve thus from the master stubout list. Go to __Master > Waterworks > Stubout__  to do this.

[area1]: ./images/subarea/area1.png
[area2]: ./images/subarea/area2.png
[area3]: ./images/subarea/area3.png
[area4]: ./images/subarea/area4.png
[area5]: ./images/subarea/area5.png
[area4]: ./images/subarea/area4.png
[stuboutnew]: ./images/subarea/stuboutnew.png





