package treasury.facts;

import java.util.*;
import com.rameses.util.*;
import com.rameses.functions.*;

public class DailyBillItem extends MonthBillItem {

   
    int day;
  
    def toMap() {
        def m = super.toMap();
        m.day = day;
        return m;
    }

    public String getUid() {
        return (acctid + "_" + year + "_" + month + "_" + day);
    }

    public String getParticulars() {
        return super.getParticulars() + " ("+ getMonthName( month ) +  " " + day + " " + year + ")";    
    }

}