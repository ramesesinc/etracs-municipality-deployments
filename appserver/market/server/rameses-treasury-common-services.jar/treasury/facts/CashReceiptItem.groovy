
package treasury.facts;

import java.util.*;
import com.rameses.util.*;

public class CashReceiptItem {

	ItemAccount item;
    double amount;
    String remarks;
    String uid;
    
    List<AbstractBillItem> billitems = [];

    public void addItem( AbstractBillItem abi ) {
        billitems << abi;                
    }

    public CashReceiptItem() {}

    def toMap() {
        def m = [:];
        m.amount = amount;
        m.item = item.toMap();
        m.remarks = remarks;
        return m;
    }


}