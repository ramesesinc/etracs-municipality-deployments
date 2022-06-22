package treasury.actions;

import com.rameses.rules.common.*;
import com.rameses.util.*;
import java.util.*;
import treasury.facts.*;
import com.rameses.osiris3.common.*;

/***
* Changes the value of the billitem using type operation ADD or REPLACE
*    billitem
*    amount 
****/
class UpdateBillItemAmount implements RuleActionHandler {

	public void execute(def params, def drools) {
		if( !params.billitem ) throw new Exception("billitem is required in UpdateBillItemAmount");
		if( !params.amount ) throw new Exception("amount is required in UpdateBillItemAmount");
		
		def amt = params.amount.decimalValue;
		def bi = params.billitem;
		def type = params.type;

		if( type == 'ADD' ) {
			bi.amount += amt;	
		}
		else {
			bi.amount = amt;	
		}
	}

}