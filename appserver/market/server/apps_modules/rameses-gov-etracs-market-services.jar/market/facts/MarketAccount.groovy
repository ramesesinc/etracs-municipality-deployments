package market.facts;

import java.util.*;
import com.rameses.util.*;
import com.rameses.functions.*;

class MarketAccount {

	String objid;
	String acctno;
	double extrate;
	double extarea;

	String paymentmode;	//MARKET_PAYMENTMODE
	Date startdate;
	double partialbalance = 0;
	
	/*
	public MarketAccount(def mm) {
		objid = mm.objid;
		acctno = mm.acctno;
		payfrequency = mm.payfrequency;
		partialbalance = mm.partialbalance;
		lastdatepaid = mm.lastdatepaid;
		if(mm.extrate) extrate = mm.extrate;
		if(mm.dtstarted) startdate = mm.dtstarted;
		if(mm.extarea) extarea = mm.extarea;
	}
	*/

	public String toString() {
		return "payment mode " + paymentmode;
	}

}