package treasury.actions;

import com.rameses.rules.common.*;
import com.rameses.util.*;
import java.util.*;
import treasury.facts.*;
import com.rameses.osiris3.common.*;


public class AddCashReceiptItem implements RuleActionHandler {
	
	public void execute(def params, def drools) {
		if( !params.billitem ) throw new Exception("billitem is required in AddCashReceiptItem");
		
		def billitem = params.billitem;
		def ct = RuleExecutionContext.getCurrentContext();
		def facts = ct.facts;

		def itmAcct = null;
		if( params.account ) {
			itmAcct = new ItemAccount( params.account.key, params.account.value );
		}
		else if( billitem.item ) {
			itmAcct = billitem.item;
		}
		else {
			throw new Exception("Please specify a map account ");
		}

		def rItems = facts.findAll{ it instanceof CashReceiptItem };

		def uid = itmAcct.objid;
		if( params.groupid ) {
			uid = params.groupid.stringValue;
		}		

		def amt = billitem.amount;
		if( params.amount ) {
			amt = params.amount.decimalValue;
		}

		def ri = rItems.find{ it.uid == uid };
		if( !ri ) {
			ri = new CashReceiptItem();
			ri.item = itmAcct;
			ri.uid = uid;
			ri.amount = NumberUtil.round( amt );
			facts << ri;
		}
		else {
			ri.amount = NumberUtil.round( ri.amount + amt );
		}

		ri.addItem( billitem );

		if(params.remarks) {
			def prm = params.remarks.eval();
			if(prm instanceof String) {
				ri.remarks = prm;
			}
			else {
				ri.remarks = prm( ri );
			}
		}

	}

}