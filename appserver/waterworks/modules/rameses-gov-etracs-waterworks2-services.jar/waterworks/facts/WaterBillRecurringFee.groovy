package waterworks.facts;

import java.util.*;
import com.rameses.util.*;
import treasury.facts.*;

public class WaterBillRecurringFee {

	String objid;
	int startyear;
	int startmonth;
	String type;	//installment or onetime or recurring

	String billcode;
	double installmentamount;
	int term; 		  	// no. of months
	double amount; 	  	//amt due
	double amtdue;    	//this is amount - amtpaid
	double principal;	//principal

	public WaterBillRecurringFee() {}

	public WaterBillRecurringFee( def m ) {
		if(m.startyear) this.startyear = m.startyear
		if(m.startmonth) this.startmonth = m.startmonth
		if(m.type) this.type = m.type
		if(m.item) this.billcode = m.item.objid;
		if(m.installmentamount) this.installmentamount = m.installmentamount;
		if(m.term) this.term = m.term
		if(m.amount) this.amount = m.amount;
		if(m.principal) this.principal = m.principal;
		this.amtdue = m.balance;
		this.objid = m.objid;
	}

}	
