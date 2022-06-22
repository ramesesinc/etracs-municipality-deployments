package treasury.facts;

import java.util.*;
import com.rameses.util.*;
import com.rameses.functions.*;

public class QtrBillItem extends BillItem {

    BillItem billitem;
    String billitemrefid;
    int year;
    int qtr;

    def toMap() {
        def m = super.toMap();
        m.billitemrefid = billitemrefid;
       	m.year = year;
       	m.qtr = qtr;
        return m;
    }

    public String getUid() {
        return (billitemrefid + "_" + year + "_" + qtr);
    }

    public String getParticulars() {
        return billitem.getParticulars() + " Q"+qtr;    
    }

}