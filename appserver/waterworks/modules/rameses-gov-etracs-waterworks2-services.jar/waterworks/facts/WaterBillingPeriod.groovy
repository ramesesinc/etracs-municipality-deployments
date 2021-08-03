package waterworks.facts;

import java.util.*;
import com.rameses.util.*;
import treasury.facts.*;

public class WaterBillingPeriod  {

	int year;
	int month;

	Date fromdate;
	Date todate;
	Date readingdate;
	Date readingenddate;
	Date billdate;
	Date billingenddate;
	Date discdate;
	Date duedate;
	Date billexpirydate;

	public Map toMap() {
		def m = [:];
		m.year = year;
		m.month = month;
		m.fromdate=fromdate;
		m.todate=todate;
		m.readingdate=readingdate;
		m.readingenddate=readingenddate;
		m.billdate=billdate;		
		m.billingenddate=billingenddate;
		m.discdate=discdate;
		m.duedate=duedate;
		m.billexpirydate = billexpirydate;
		return m;
	}

	public WaterBillingPeriod() {}

	public WaterBillingPeriod(def m) {
		if(m.year) year = m.year;
		if(m.month) month = m.month;
		if(m.fromdate) fromdate = m.fromdate;
		if(m.todate) todate = m.todate;
		if(m.readingdate) readingdate = m.readingdate;
		if(m.readingenddate) readingenddate = m.readingenddate;
		if(m.billdte) billdate = m.billdate;					
		if(m.billingenddate) billingenddate = m.billingenddate;
		if(m.discdate) discdate = m.discdate;
		if(m.duedate) duedate = m.duedate;
		if(m.billexpirydate) billexpirydate = m.billexpirydate;
	}

}	