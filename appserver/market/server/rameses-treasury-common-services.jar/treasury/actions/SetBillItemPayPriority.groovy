package treasury.actions;

import com.rameses.rules.common.*;
import com.rameses.util.*;
import java.util.*;
import treasury.facts.*;
import com.rameses.osiris3.common.*;

class SetBillItemPayPriority implements RuleActionHandler  {

	public void execute(def params, def drools) {
		if( !params.billitem ) throw new Exception("billitem is required in SetBillItemPayPriority");
		if( !params.paypriority ) throw new Exception("paypriority is required in SetBillItemPayPriority");

		def billitem = params.billitem;
		def paypriority = params.paypriority.intValue;

		billitem.paypriority = paypriority;

	}

}	