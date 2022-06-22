package market.facts;

import com.rameses.util.*;

public class MarketAccount {

	double rate;
	String ratetype;
	String paymentmode;
	String accttype;
	String unitno;

	public MarketAccount( def o ) {
		if( o.rate ) rate = o.rate;
		if(o.unitno) unitno = o.unitno;
		ratetype = o.ratetype;
		paymentmode = o.paymentmode;
		if( o.accttype ) {
			this.accttype = o.accttype.toUpperCase();
		}
	}

}
