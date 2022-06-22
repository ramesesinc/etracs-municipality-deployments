package market.actions;

import com.rameses.rules.common.*;
import com.rameses.util.*;
import java.util.*;
import market.facts.*;
import com.rameses.osiris3.common.*;

public class AddMarketBillSchedule implements RuleActionHandler {

	public void execute(def params, def drools) {
		if(!params.year) throw new Exception("Year is required in AddMarketBillSchedule"); 
		if(!params.month) throw new Exception("Month is required in AddMarketBillSchedule");

		def billSchedule = new MarketBillSchedule();
		billSchedule.year = params.year.intValue;
		billSchedule.month = params.month.intValue;

		def ct = RuleExecutionContext.getCurrentContext();
		ct.facts.add( billSchedule );
		drools.insert( billSchedule );
	}
}


