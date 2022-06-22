package treasury.actions;

import com.rameses.rules.common.*;
import com.rameses.util.*;
import java.util.*;
import treasury.facts.*;
import com.rameses.osiris3.common.*;


/***
* Description: Replace some simple values in the billitem properties 
* Parameters:
*    billitem
*    fieldname
*    value 
****/
class SetBillItemProperty  implements RuleActionHandler  {

	public void execute(def params, def drools) {
		if( !params.billitem ) throw new Exception("billitem is required in SetBillItemProperty");
		if( !params.fieldname ) throw new Exception("fieldname is required in SetBillItemProperty");
		if( !params.value ) throw new Exception("value is required in SetBillItemProperty");

		def billitem = params.billitem;
		def propname = params.fieldname;
		def value = params.value.eval();

		billitem[(propname)] = value;
	}

}