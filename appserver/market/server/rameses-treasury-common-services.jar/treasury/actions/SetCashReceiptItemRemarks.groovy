package treasury.actions;

import com.rameses.rules.common.*;
import com.rameses.util.*;
import java.util.*;
import treasury.facts.*;
import com.rameses.osiris3.common.*;

class SetCashReceiptItemRemarks implements RuleActionHandler  {

	public void execute(def params, def drools) {
		if( !params.receiptitem ) throw new Exception("receiptitem is required in SetCashReceiptItemRemarks");
		if( !params.remarks ) throw new Exception("remarks is required in SetCashReceiptItemRemarks");

		def receiptitem = params.receiptitem;
		receiptitem.remarks = params.remarks.eval()?.toString();

	}

}	