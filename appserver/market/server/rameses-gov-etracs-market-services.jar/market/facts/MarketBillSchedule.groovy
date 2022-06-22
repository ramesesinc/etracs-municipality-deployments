package market.facts;

import java.util.*;
import com.rameses.util.*;
import treasury.facts.*;

public class MarketBillSchedule  {

	int year;
	int month;
	int day;

	Date fromdate;
	Date todate;
	Date billdate;
	Date readingdate;
	Date discdate;
	Date duedate;
	Date expirydate;


	public Map toMap() {
		def m = [:];
		m.year = year;
		m.month = month;
		m.fromdate=fromdate;
		m.todate=todate;
		m.billdate=billdate;		
		m.discdate=discdate;
		m.duedate=duedate;
		m.expirydate = expirydate;
		m.readingdate = readingdate;
		return m;
	}

	public MarketBillSchedule() {}

	public MarketBillSchedule(def m) {
		if(m.year) year = m.year;
		if(m.month) month = m.month;
		if(m.day) day = m.day;
 		if(m.fromdate) fromdate = m.fromdate;
		if(m.todate) todate = m.todate;
		if(m.billdate) billdate = m.billdate;
		if(m.readingdate) readingdate = m.readingdate;
		if(m.discdate) discdate = m.discdate;
		if(m.duedate) duedate = m.duedate;
		if(m.expirydate) expirydate = m.expirydate;
	}

}	