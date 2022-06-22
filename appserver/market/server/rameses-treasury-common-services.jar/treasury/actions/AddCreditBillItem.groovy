package treasury.actions;

import com.rameses.rules.common.*;
import com.rameses.util.*;
import java.util.*;
import treasury.facts.*;
import com.rameses.osiris3.common.*;
import java.rmi.server.*;

class AddCreditBillItem extends AddBillItem  {

	public void execute(def params, def drools) {
		if( !params.account && !params.billcode ) throw new Exception("account or billcode is required in AddBillItem");
		if( !params.amount ) {
			throw new Exception("amount is required in AddCreditBillItem");	
		}
		
		def acct = [:];	
		if(params.account) {
			acct.key = params.account.key;
			acct.value = params.account.value;
		}
		else {
			acct.key = params.billcode;
			acct.value = params.billcode;
		}

		def billitem =  new CreditBillItem(acctid: acct.key);
		billitem.objid = "CRDTBILLITM" + new UID();
		billitem.acctname = acct.value;
		
		def amt = params.amount.decimalValue;
		billitem.amount = amt;
		
		def ct = RuleExecutionContext.getCurrentContext();
		def facts = ct.facts;
		facts << billitem;

	}

}