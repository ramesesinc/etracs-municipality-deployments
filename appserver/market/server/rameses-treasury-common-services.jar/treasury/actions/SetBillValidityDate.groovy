package treasury.actions;

import com.rameses.rules.common.*;

public class SetBillValidityDate implements RuleActionHandler {
	
	public void execute(def params, def drools) {
		if(!params.bill) throw new Exception("bill is required in treasury.actions.SetBillValidityDate");
		if(!params.date) throw new Exception("date is required in treasury.actions.SetBillValidityDate");	

		def bill = params.bill;
		def date = params.date.eval();
		bill.validitydate = date;
		drools.update( bill );
	}

}
