package market.actions;

import com.rameses.rules.common.*;
import com.rameses.util.*;
import java.util.*;
import market.facts.*;
import com.rameses.osiris3.common.*;
import java.rmi.server.*;

public class AddMarketBillItem  implements RuleActionHandler {

	public void execute(def params, def drools) {
		if( !params.account ) throw new Exception("account is required in AddDailyMarketBillItem");
		if( !params.amount  ) throw new Exception("amount is required in AddDailyMarketBillItem");	

		def acct = params.account;
		def amt = params.amount.decimalValue;

		def bi = new MarketBillItem(acctid: acct.key, acctname: acct.value, amount: amt );
		bi.objid = "MKTBILLITM" + new UID();
		if(params.year) bi.year = params.year;
		if(params.month) bi.month = params.month;
		if(params.billdate) bi.billdate = params.billdate.eval();

		def ct = RuleExecutionContext.getCurrentContext();
		def facts = ct.facts;

		if( !facts.find{ it.hashCode() == bi.hashCode() } ) {
			facts << bi;
		}

	}

}

