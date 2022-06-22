package treasury.actions;

import com.rameses.rules.common.*;
import com.rameses.util.*;
import java.util.*;
import treasury.facts.*;
import com.rameses.osiris3.common.*;

/***
* This changes the billitem's account to another. 
* An example of this is from business tax -> business tax (manufacturter)   
****/
class SetBillItemAccount implements RuleActionHandler {

	public void execute(def params, def drools) {
		if( !params.account && !params.billcode ) throw new Exception("account or billcode is required in AddBillItem");
		if( !params.billitem ) throw new Exception("billitem is required in SetBillItemAccount");

		def billitem = params.billitem;
		def acct = [:];
		if(params.account) {
			acct.key = params.account.key;
			acct.value = params.account.value;
		}
		else {
			acct.key = params.billcode;
			acct.value = params.billcode;
		}
		
		billitem.acctid = acct.key;
		billitem.acctname = acct.value;
	}

}