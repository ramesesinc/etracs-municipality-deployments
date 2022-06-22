package treasury.actions;

import com.rameses.rules.common.*;
import com.rameses.util.*;
import java.util.*;
import com.rameses.osiris3.common.*;
import treasury.facts.*;

class SplitBillItemByQtr implements RuleActionHandler {

	public void execute(def params, def drools) {
		if(!params.billitem) throw new Exception("billitem is required in SplitBillItemByQtr");
		if(!params.year) throw new Exception("year is required in SplitBillItemByQtr");

		def billitem = params.billitem;
		def year = params.year;
		
		def ct = RuleExecutionContext.getCurrentContext();		
		def facts = ct.facts;

		def qtrFacts = facts.findAll{ it instanceof QtrBillItem };
		def exists = qtrFacts.find{ it.billitemrefid == billitem.objid };
		if(exists) return;

		//split the billitem into 4 qtrs;
		def balance = billitem.amount;
		def qtramt =  NumberUtil.round( balance / 4 );

		(1..4).each {  q ->
			def bq = new QtrBillItem();
			bq.objid = billitem.objid +"_Q"+q;
			bq.acctid = billitem.acctid;
			bq.acctname = billitem.acctname;
			bq.billitemrefid = billitem.objid;
			bq.billitem = billitem;
			bq.year = year;
			bq.qtr = q;
			bq.amount = (q<4) ? qtramt : balance;
			facts << bq;
			balance = NumberUtil.round(balance - qtramt);
		}

		//we need to remove the original item from the facts
		
	}


}