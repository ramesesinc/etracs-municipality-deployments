package waterworks.actions;

import com.rameses.rules.common.*;
import com.rameses.util.*;
import java.util.*;
import treasury.facts.*;
import com.rameses.osiris3.common.*;
import waterworks.facts.*;


public class AddRecurringWaterBillItem implements RuleActionHandler {

	public void execute(def params, def drools) {
		if(!params.year) throw new Exception("Error AddWaterBillItem year is required");
		if(!params.month) throw new Exception("Error AddWaterBillItem month is required");
		if(!params.refitem) throw new Exception("Error AddWaterBillItem refitem is required");
		if(!params.amount) throw new Exception("Error AddWaterBillItem amount is required");

		def year = params.year;
		def month = params.month;
		def refitem = params.refitem;
		def billcode = refitem.billcode;

		//we already compute so that users will not decide how to do this.
		def amt = params.amount.eval();
		amt = NumberUtil.round(amt).doubleValue();	

		def ct = RuleExecutionContext.getCurrentContext();
		def facts = ct.facts;

		def addItem = { 
			def bi = new WaterBillItem();
			bi.billcode = billcode;
			bi.amount = amt;
			bi.year = year;
			bi.month = month;
			bi.recurringfeeid = refitem.objid;
			facts << bi;
		}

		def billitems = facts.findAll{ it instanceof WaterBillItem };
		if( !billitems.find{ it.year == year && it.month == month && it.billcode == billcode }  ) {
			addItem();
		}

	}
}