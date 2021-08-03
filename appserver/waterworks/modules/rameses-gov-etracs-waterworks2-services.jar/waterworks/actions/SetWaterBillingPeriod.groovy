package waterworks.actions;

import com.rameses.rules.common.*;
import com.rameses.util.*;
import java.util.*;
import treasury.facts.*;
import com.rameses.osiris3.common.*;

public class SetWaterBillingPeriod implements RuleActionHandler {

	public void execute(def params, def drools) {
		def billPeriod = params.billingperiod;
		if(!billPeriod) throw new Exception("Billing Period is required in SetBillingPeriod")
		if(params.fromdate!=null) billPeriod.fromdate = params.fromdate.eval();
		if(params.todate!=null) billPeriod.todate = params.todate.eval();
		if(params.readingdate!=null) billPeriod.readingdate = params.readingdate.eval();
		if(params.readingenddate!=null) billPeriod.readingenddate = params.readingenddate.eval();
		if(params.billdate!=null) billPeriod.billdate = params.billdate.eval();
		if(params.billingenddate!=null) billPeriod.billingenddate = params.billingenddate.eval();
		if(params.discdate!=null) billPeriod.discdate = params.discdate.eval();
		if(params.duedate!=null) billPeriod.duedate = params.duedate.eval();
		if(params.billexpirydate!=null) billPeriod.billexpirydate = params.billexpirydate.eval();

	}
}


