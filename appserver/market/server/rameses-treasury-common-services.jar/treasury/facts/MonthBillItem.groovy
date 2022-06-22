package treasury.facts;

import java.util.*;
import com.rameses.util.*;
import com.rameses.functions.*;

public class MonthBillItem extends BillItem {

    int year;
    int month;

    public MonthBillItem( def m ) {
        super(m);
        if(m.year) year = m.year;
        if(m.month) month = m.month;
    }

    public MonthBillItem() {;}

    def toMap() {
        def m = super.toMap();
        m.year = year;
       	m.month = month;
        return m;
    }

    def getMonthName( int mon ) {
        if(mon==1) return "JANUARY";
        else if(mon==2) return "FEBRUARY";
        else if(mon==3) return "MARCH";
        else if(mon==4) return "APRIL";
        else if(mon==5) return "MAY";
        else if(mon==6) return "JUNE";
        else if(mon==7) return "JULY";
        else if(mon==8) return "AUGUST";
        else if(mon==9) return "SEPTEMBER";
        else if(mon==10) return "OCTOBER";
        else if(mon==11) return "NOVEMBER";
        else if(mon==12) return "DECEMBER";
    }

    public String getUid() {
        return (acctid + "_" + year + "_" + month);
    }

    public int getYearMonth() {
        return ((year*12)+month);
    }

}