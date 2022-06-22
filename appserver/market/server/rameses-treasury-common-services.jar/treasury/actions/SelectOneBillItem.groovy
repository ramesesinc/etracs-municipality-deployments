package treasury.actions;

import com.rameses.rules.common.*;
import com.rameses.util.*;
import java.util.*;
import treasury.facts.*;
import com.rameses.osiris3.common.*;

class SelectOneBillItem implements RuleActionHandler  {

	public void execute(def params, def drools) {
		if( !params.billitem ) throw new Exception("billitem is required in SelectOneBillItem");
		if( !params.selectoption ) throw new Exception("selectoption is required in SelectOneBillItem");

		def acct = params.billitem;
		def selectoption = params.selectoption;

		def ct = RuleExecutionContext.getCurrentContext();
		def facts = ct.facts;	

		def list = facts.findAll{ it instanceof BillItem }.findAll{ it.acctid == acct.acctid };
		if(list ) {
			def selectedItem = null;	
			
			if(selectoption == "MIN" ) {
				selectedItem = list.min{ it.amount };
			} 
			else if (selectoption == "MAX") {
				selectedItem = list.max{ it.amount };
			}
			else if (selectoption == "SUM") {
				selectedItem = list.first();
				selectedItem.amount = NumberUtil.round( list.sum{it.amount} );
			} 

			def bi = new BillItem();
			bi.acctid = selectedItem.acctid;
			bi.acctname = selectedItem.acctname;
			bi.amount = selectedItem.amount;

			facts.removeAll( list );
			
			facts << bi;
		}		

	}

}	