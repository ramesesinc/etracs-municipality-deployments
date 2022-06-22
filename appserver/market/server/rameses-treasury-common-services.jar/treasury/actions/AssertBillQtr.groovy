package treasury.actions;

import com.rameses.rules.common.*;
import com.rameses.util.*;
import java.util.*;
import com.rameses.osiris3.common.*;
import com.rameses.functions.*;
import java.text.*;
import treasury.facts.*;

//usually this is called if you need to split a bill into quarters
public class AssertBillQtr implements RuleActionHandler {
	

	public void execute(def params, def drools) {

		def yr = params.year;
		def startperiod = params.startperiod;
		def df = new SimpleDateFormat("yyyy-MM-dd");

		if(!startperiod) {
			//if startperiod not specified start at Jan 1.
			startperiod = df.parse( yr+"-01-01" );
		}	
		
		def mon = (new SimpleDateFormat("MM")).format(startperiod).toInteger();

		def ct = RuleExecutionContext.getCurrentContext();
		def facts = ct.facts;	

		(1..4).each {
			def bq = new BillQtr( qtr: it, year: yr );
			if( facts.contains(bq) ) return;

			facts << bq;
			
			//so it can be immediately evaluated
			drools.insert(bq);

			bq.startmonth = mon;
			bq.fromdate = df.parse( yr+"-"+mon+"-01" );

			def tomonth = mon + 2;
			def toyear = yr;
			if( tomonth > 12  ) {
				tomonth = 1;
				toyear = toyear + 1;
			}

			bq.todate = DateFunc.monthEnd(  df.parse( toyear +"-"+tomonth+"-01" ) ); 
			
			//increment to next qtr
			mon = mon + 3;
			if( mon > 12 ) {
				mon = 1;
				yr = yr + 1;
			}
		}

	}
	
	
}