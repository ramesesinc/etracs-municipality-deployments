package treasury.actions;

import com.rameses.rules.common.*;
import com.rameses.util.*;
import java.util.*;
import treasury.facts.*;
import com.rameses.osiris3.common.*;

public abstract class AbstractAddBillSubItem implements RuleActionHandler  {

	public abstract BillSubItem createSubItem(def acctid, def params );

	public void execute(def params, def drools) {
		if( !params.billitem ) throw new Exception("billitem is required in AddBillSubItem");
		if( !params.account && !params.billcode ) throw new Exception("account or billcode is required in AddBillItem");
		if( !params.amount ) throw new Exception("account is required in AddBillSubItem");

		if(!(params.billitem instanceof BillItem ))
			 throw new Exception("BillItem must be an instanceof BillItem. ");

		def amt = params.amount.decimalValue;
		

		def billdate = null;
		if( params.billdate ) billdate = params.billdate.eval();

		def parentBillitem = params.billitem;

		def acct = [:];
		if(params.account) {
			acct.key = params.account.key;
			acct.value = params.account.value;
		}
		else {
			acct.key = params.billcode;
			acct.value = params.billcode;
		}

		def billitem = createSubItem(acct.key, params);
		billitem.acctname = acct.value;
		billitem.amount = NumberUtil.round( amt );
		billitem.billdate = billdate;

		billitem = parentBillitem.addSubItem( billitem );
		if(billitem) {
			def ct = RuleExecutionContext.getCurrentContext();
			def facts = ct.facts;
			facts << billitem;				
		}

	}

}