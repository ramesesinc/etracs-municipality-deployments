<style>
.table1 th:first-child  {
	width: 100px;
}
.table1 td {
	vertical-align: top;
	font-size:12px;
}
</style>

# Billing Period and Schedule #

The billing period specifies the dates per each billing cycle. These are the ff. data of a billing period:

<div class="table1">

__Billing Period__
|Field  	|Description 						|
|:---   	|:---        						|
|fromdate      |The start date of the period  | 	
|todate        |The end date of the period   |  	 
|readingdate   |The date when reading shoud start  |             
|readingenddate|The reading should be completed and uploaded before this date. This data is optional. |             
|billdate      |The billing date for the period |
|billingenddate   |The billing should be completed before this date and the bills must have already been sent to the customers. This data is optional. |
|discdate      |If payment made before this date a discount will be provided if applicable |
|duedate       |Non-payment after this date will trigger penalties if applicable |
|billexpirydate|Payments after this date will be invalid. Instead the payments will be posted to the next bill |  

</div>

The billing period has to be defined per month. Because this is very tedious to do, this is done by setting up rules so we do not have to do this manually. Normally the flow of rules is as follows: 

```
Determine the from date and to date of a period given the year and month and a schedule group.  

Bill expiry date will be one month from the period's to date.

Add 2 days from period to date for the reading date and additional 2 days for the end date of reading.

Add 5 days from period to date for the billing date and additional 2 days for the end of billing. 

Add 10 days from period to date for the discount date.

Add 15 days from period to date for the due date. 

```

Before we start defining the rules we need to create first the schedule groups. Because some enterprises have so many customer accounts, it is natural to divide this into  groups with different schedules to manage it better. Usually the group name corresponds with the start date for a group. For example, group 1 might start at first day of the month, group 5 might start at the fifth day of the month and so on. 

To perform the succeeding sections, you need the ff. roles:

`WATERWORKS.MASTER`
`WATERWORKS.RULE_AUTHOR`

## Billing Schedule Group ##

Click on the explorer Main Menu. Then go to __Master > Waterworks > Billing Schedule Groups__. This will display the list of groups. Click on the `New` button to add an entry.   

![alt text][skedlist] <br />

This will open the Billing Schedule Group form. Fill out the form as follows: 

![alt text][skedform] <br />

For the ID field, enter a short code name that can be easily remembered. It is alphanumeric but must start with a letter, not a number. Enter a short description for the entry. Click on `Save` button to continue. Next we need to build up the dates for each period.

## Billing Period Schedule Rules ##
To add convenience and consistency in creating your schedules, a rule based system is used. Given the month, year and the schedule group, the rule system should determine the dates. The result is stored in the billing period. 

We will use the example scenario above to generate the rule. Click on the explorer Main Menu then go to __Rule Management > Waterworks > Waterworks Billing Schedule Rules__. This will open up the rules list. For more information on rule management, go to ETRACS rule management. 

![alt text][skedrulelist] <br />

There are two rule groups for this rule. __initial__ and __post initial__. The initial group should contain the rules that will compute _fromdate_, _todate_ and _billexpirydate_ while the rest of the rules for other dates should be in the post initial. It is very important to be consistent at all times when computing for the dates. For example, when we say the reading date should be one day after the period's to date, it should be consistent for all schedules regardless of what day it starts. If you have inconsistent rules or there is no pattern in your methods, the rules will be very hard to configure and will become unwieldy and hard to manage.

### Adding From Date, To Date and Bill Expiry Date rule ###
The first rule that we will make is a rule that determines the from date, to date and bill expiry date of a period. To do this, from the rules list click on the `New ` button. Select rule group `initial`. Add a rulename. It is alphanuemric but should start with a letter, not a number and there should be no special characters in it except underscore and spaces. It should be short, concise and descriptive for the rule that we will be making. In this case, since this is for our selected group, we name this __S1_BILLING_PERIOD__. Add also a short description of what the rule does so you will remember. 

![alt text][skedrule1] 

Click `Next` button. Click on `Add Condition` button.  Then select *Water Schedule Group* fact. Once the condition page is opened, click `Add Constraint` button and select *ID*. Click OK to add and in the operator column, select `is any of the following` in the dropdown list. Then select the billing schedule group S1, which is the record we created in the previous section. This should resemble the screen below:

![alt text][skedrule2] 

Next we add a second condition since we need the year and month as parameter. To do this click `Add Condition` again and this time select *Water Billing Period*. Add 2 constraints, Year and Month. Assign variable names __YR__ to Year and __MON__ for month. we will need this to calculate our period. This should resemble the screen below:

![alt text][skedrule3] 

Next we will add an action. From the rule screen, click `Add Action` button. There is only one selectable action, *Set Waterworks Billing Period*. Select that and click `Next`. On the action screen, click on `Parameters [Add]` and select *Billing Period*. Choose whatever is displayed in dropdown box. This should reference our Water Billing Period Fact from which we will store the dates. Add another 3 parameters and select the parameters: *From Date*, *To Date* and *Bill Expiry Date*. 

In the From Date section, click the `fX` button which is just below the From Date text display. This will show the *Expression Editor* screen. In the text area type the following expression:

```
@DATE( YR, MON, 1)
```
This assigns the 1st or day 1 of whatever year and month was specified. The @DATE is a function that converts values to date in year, month, day format to the from date of the period. (<i>For more functions, you can also check out the Functions from the Expression Editor</i>) . 

![alt text][skedrule4] 

Next, on the To Date section, add the ff. expression: 

```
@MONTHEND(@DATE( YR, MON, 1))
```
This expression first converts the date (the 1 here is arbitrary, you can specify any day) then the @MONTHEND function computes the end day of the month. We need this to be dynamic because there are different maximum days in a month. The function can specifically return the end date whatever year or month it is. Last but not the least, we specify the bill expiry date which is at one month from the period's to date. To do this follow the ff. expression :
```
@MONTHEND(@DATE( YR, MON+1, 1))
```
Once completed, the screen should resemble something like this:

![alt text][skedrule5] 

Click `OK` to save the action. This should return to the screen like below. (If the screen does not look like it, click on the `Refresh` button).

![alt text][skedrule6] 

Once completed. Click on `Deploy` button. You have completed the first rule. This rule is already activated in the system. However, we cannot yet test it because we need to complete the other rule in the following section:

### Adding Reading, Billing, Discount and Due Dates rule ###

The next rule will be for the computation of the other dates. The first rule must be executed first because we need the to date value before we can run this rule. That is why the first rule must run in the initial rule group because it is executed before the post-initial. Ideally, if you have consistent pattern of finding the dates, this rule should be created only once. To do this, follow the same procedure from the first with a few changes:

Add a new rule. Name it __BILLING_PERIOD_OTHER_DATES__ or any name you prefer and add description. Select the post-initial rule group. This is important. 
Next add one condition. Select the Water Billing Period fact. Add constraint *To Date*. Assign a variable name __TODATE__. <i>(Variable names should not have spaces)</i>. This should be like the screen below:

![alt text][skedrule7] 

After saving the condition, add action. Select *Set Waterworks Billing Period* action. Just like the previous, add the *Billing Period* parameter and select whatever is in the dropdown list provided. Add the ff. parameters with the corresponding expressions <i>(The @DAYADD functions adds days specified to the date)</i>:

Reading Date
```@DAYADD( TODATE , 2 )```

Reading End Date
```@DAYADD( TODATE , 4 )``` 

Bill Date
```@DAYADD( TODATE , 5 )``` 

Billing End Date
```@DAYADD( TODATE , 7 )``` 

Discount Date
```@DAYADD( TODATE , 10 )``` 

Due Date
```@DAYADD( TODATE , 15 )``` 

Save the action. The final screen should look like the ff:

![alt text][skedrule8] 

Deploy the rule and close. If there are no errors, we are now ready to test the rules.

### Testing the rules ###
To test the rules, we need to go back to the schedule group. Go to __Master > Waterworks > Billing Schedule Groups__ and search the billing schedule group, in this case S1. Once you have seen that on the list, select the item by pointing the mouse and double click. Alternatively, you can select the item press Ctrl-O to open or click on the `Open` button from the list toolbar. Once open, you will be able to see the Billing Period Tab.

![alt text][skedrule9] 

Click on the `Add Period` button. A popup will display prompting you for a year and month. Click OK to finish. 

![alt text][skedrule10] 

The result will be displayed on the Billing Period list. 

![alt text][skedrule11] 

If you want to edit the values, select the item on the list and double click to open or click the `Open` folder button. This should display the billing period information. Click the `Edit` button to make the fields editable. Then once finished click `Save`. 

![alt text][skedrule12]

You do not have to specify the billing period dates. The system will automatically fill them as the need arises during billing if it does not yet exist. However, if you already created one on purpose, the system will not override it. This schedule group will be referenced by the sub area. 

[skedlist]: ./images/groupskedlist.png
[skedform]: ./images/groupskedform.png
[skedrulelist]: ./images/skedrulelist.png
[skedrule1]: ./images/skedrule1.png
[skedrule2]: ./images/skedrule2.png
[skedrule3]: ./images/skedrule3.png
[skedrule4]: ./images/skedrule4.png
[skedrule5]: ./images/skedrule5.png
[skedrule6]: ./images/skedrule6.png
[skedrule7]: ./images/skedrule7.png
[skedrule8]: ./images/skedrule8.png
[skedrule9]: ./images/skedrule9.png
[skedrule10]: ./images/skedrule10.png
[skedrule11]: ./images/skedrule11.png
[skedrule12]: ./images/skedrule12.png

