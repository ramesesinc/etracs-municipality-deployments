package market.facts;

import java.util.*;
import com.rameses.util.*;
import com.rameses.functions.*;
import treasury.facts.*;

class MarketUtilityBillItem extends BillItem {

	int volume;
	double rate;
	String type; //electricity or water
	int capacity;

	Date fromdate;
	Date todate;
	Date nextbilldate;
	Date nextreadingdate;

	int reading;
	int prevreading;

	public def toMap() {
		def m = super.toMap();
		m.fromdate = fromdate;
		m.todate = todate;
		m.nextbilldate = nextbilldate;
		m.nextreadingdate = nextreadingdate;
		m.rate = rate;
		m.capacity = capacity;
		m.type = type;
		m.txntype = type;
		return m;
	}	


}