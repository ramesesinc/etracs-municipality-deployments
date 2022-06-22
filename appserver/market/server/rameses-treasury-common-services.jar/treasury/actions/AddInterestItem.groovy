package treasury.actions;

import com.rameses.rules.common.*;
import com.rameses.util.*;
import java.util.*;
import treasury.facts.*;
import com.rameses.osiris3.common.*;


public class AddInterestItem extends AbstractAddBillSubItem {

	public BillSubItem createSubItem( def acctid, params ) {
		return new InterestItem( acctid: acctid );
	}


}