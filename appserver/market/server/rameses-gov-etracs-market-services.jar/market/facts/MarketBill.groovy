package market.facts;

import com.rameses.util.*;
import treasury.facts.Bill;

public class MarketBill extends Bill {

	int year;
	int month;
	String billtype;

	double rate;
	String ratetype;

	public MarketBill(def o ) {
		super(o);		
		if(o.year) this.year = o.year;
		if(o.month) this.month = o.month;
		billtype = o.billtype?.toUpperCase();	
		
		if( o.rate ) this.rate = o.rate;
		this.ratetype = o.ratetype;	
	}

	public int getYearmonth() {
		return ((year*12)+month);
	}

}
