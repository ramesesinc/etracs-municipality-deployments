<style>
.table1 th:first-child  {
	width: 100px;
}
.table1 td {
	vertical-align: top;
	font-size:11px;
}
</style>

# Payment #

The following are the types of payments:

> __cashreceipt__ = paid in cash referenced by cash receipt. It can be manually captured or automatically captured by the treasury cash receipt system
> __applycredit__ = this is system generated and bill items are paid using the advance payments such as deposits. This is applied during the billing run before the readings are made. This is not displayed in the statement
> __compromise__ = in some instances where the customer applies compromise payment. The items are paid and transferred to the recurring fee where it is billed on an installment basis. This is reflected in the statement
> __compromisedefault__ = in some instances where the customer who previously applied for a compromise payment and was not able to pay the items. This payment will write off the installment bills



![alt text][create1]

[create1]: ./images/bill/create1.png
[create2]: ./images/bill/create2.png
[create3]: ./images/bill/create3.png
[create4]: ./images/bill/create4.png

