package market.facts;

import java.util.*;
import com.rameses.util.*;
import treasury.facts.*;

public class MarketBillSubItem extends BillSubItem   {

	String objid;
	String billitemrefid;
	String billid;
	int year;
	int month;
	Date billdate;

	public MarketBillSubItem(d) {
		this.objid = d.objid;
		this.amount = d.amount;
		this.billitemrefid = d.billitemrefid;
		this.billcode = d.billcode;
		this.billid = d.billid;
		if(d.year) this.year = d.year;
		if(d.month) this.month = d.month;
		if(d.billdate) this.billdate = d.billdate;
		if(d.itemtype) this.txntype = d.itemtype.toLowerCase();
	}
	
	public int hashCode() {
		return this.objid.hashCode();
	}


}	