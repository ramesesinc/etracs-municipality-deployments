package treasury.facts;

import java.util.*;
import com.rameses.util.*;

public class Bill {

	String objid;
	String state;
	String paymentmode;
    double balanceforward;
    double amount;
    Date billdate;
    Date validitydate;
    Date expirydate;
    double balance;

    public Bill( def o ) {
		if(o.objid) this.objid = o.objid;
		if(o.state) this.state = o.state;
		if(o.paymentmode) this.paymentmode = o.paymentmode;
		if(o.balanceforward) this.balanceforward = o.balanceforward;
		if(o.amount) this.amount = o.amount;
		if(o.billdate) this.billdate = o.billdate;
		if(o.validitydate) this.validitydate = o.validitydate;
		if(o.expirydate) this.expirydate = o.expirydate;
		if(o.balance) this.balance = o.balance;
    }

}