package treasury.actions;

import com.rameses.rules.common.*;
import com.rameses.util.*;
import java.util.*;
import treasury.facts.*;
import com.rameses.osiris3.common.*;


public class RemoveBillItem implements RuleActionHandler {

	public void execute(def params, def drools) {
		if( !params.billitem ) throw new Exception("billitem is required in RemoveBillItem");
		
		def billitem = params.billitem;
		def ct = RuleExecutionContext.getCurrentContext();
		def facts = ct.facts;	
		
		if(billitem instanceof BillItem ) {
			billitem.items.each { b->
				facts.remove( b );
			}	
		};		
		facts.remove( billitem );
	}

}
