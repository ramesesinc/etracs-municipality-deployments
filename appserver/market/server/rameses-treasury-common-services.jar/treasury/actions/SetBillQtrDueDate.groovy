package treasury.actions;

import com.rameses.rules.common.*;
import com.rameses.util.*;

public class SetBillQtrDueDate implements RuleActionHandler {
	
	public void execute(def params, def drools) {
		def bq = params.billqtr;
		bq.duedate = params.duedate.eval();
		/*
		def itemEm = EntityManagerUtil.lookup("bplsexpiry");
		def dt = itemEm.find( [qtr:bq.qtr, year: yr] ).first();
		if( dt ) {
			bq.duedate = dt.duedate;
		}
		*/
	}
}