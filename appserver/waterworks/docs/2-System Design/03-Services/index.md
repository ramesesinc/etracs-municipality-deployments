<div style="font-size: 8px;">

# Services #

![services] <br />
<br />

** actions marked calls the updateTotals

## WaterworksBillService ##
| Method  | Params | Description |
|:---     |:---     |:---        |
|* updateBalanceForward | objid | 1) Capture initial bill in client after adding previous billitems or credits; 2) called when creating new online bill |
|* updateBillFees | objid | 1) Capture initial bill during current items buildup; 2) Creating online bill; 3) During payment if validitydate is expired |  
|* addConsumptionBill | objid | 1) Capture initial bill in client during current items buildup; 2) Adding reading in online bill; 3) Post in batch billing |

## WaterworksPaymentService ##
| Method  | Params | Description |
|:---     |:---     |:---        |
|* postPayment |       |1)Capture payment 2) Apply credit 3) cashreceipt posting | 
|* voidPayment |       |called by cashreceipt void service |
|applyCredits|       |1) Capture initial bill   |
|cancelPayment|      |1) Capture initial bill   |

</div>

[services]: ./images/waterworks_services.gif
