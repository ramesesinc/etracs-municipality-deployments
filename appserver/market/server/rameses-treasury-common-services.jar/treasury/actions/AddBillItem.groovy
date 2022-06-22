package treasury.actions;

import com.rameses.rules.common.*;
import com.rameses.util.*;
import java.util.*;
import treasury.facts.*;
import com.rameses.osiris3.common.*;
import java.rmi.server.*;

/***
* Description: Simple Add of Item. Item is unique based on the account. 
* Parameters:
*    account 
*    amount
****/
class AddBillItem implements RuleActionHandler  {

	public def createBillItem(def acctid, def params ) {
		return new BillItem(acctid: acctid);
	}

	public void execute(def params, def drools) {
		if( !params.account && !params.billcode ) throw new Exception("account or billcode is required in AddBillItem");
		if( !params.amount  ) {
			if(!params.amtpaid) {
				throw new Exception("amount or amtpaid is required in AddBillItem");	
			}
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

		def billitem = createBillItem(acct.key, params);
		billitem.objid = "BILLITM" + new UID();
		billitem.acctname = acct.value;
		
		if( params.amount ) {
			def amt = params.amount.decimalValue;
			billitem.amount = amt;
		} 
		else {
			def amtpaid = params.amtpaid.decimalValue;
			billitem.amtpaid = amtpaid;			
		}

		def ct = RuleExecutionContext.getCurrentContext();
		def facts = ct.facts;

		if( !facts.find{ it.hashCode() == billitem.hashCode() } ) {
			facts << billitem;
		}

	}

}