package market.facts;

import java.util.*;
import com.rameses.util.*;
import com.rameses.functions.*;
import treasury.facts.*;

class MarketRentalBillItem extends BillItem {

	double rate;
	Date fromdate;
	Date todate;
	String ratetype;

	boolean first;
	boolean last;

	public def toMap() {
		def m = super.toMap();
		m.fromdate = fromdate;
		m.todate = todate;
		m.numdays = getNumdays();
		m.rate = rate;
		m.ratetype = ratetype;
		m.type = "market_rental";
		m.txntype = "market_rental";
		if( m.surcharge == null ) m.surcharge = 0;
		if(m.interest ==null) m.interest = 0;
		if(m.discount==null) m.discount = 0;
		return m;
	}	

	public int getNumdays() {
		return DateUtil.diff( fromdate, todate, Calendar.DATE )+1;   
	}


}