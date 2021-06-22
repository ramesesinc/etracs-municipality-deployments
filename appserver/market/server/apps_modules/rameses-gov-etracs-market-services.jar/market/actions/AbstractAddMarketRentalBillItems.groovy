package market.actions;

import com.rameses.rules.common.*;
import market.facts.*;
import com.rameses.util.*;
import java.util.*;
import com.rameses.osiris3.common.*;
import com.rameses.functions.*;

//import treasury.facts.*;
//import treasury.utils.*;
//import treasury.actions.*;

public abstract class AbstractAddMarketRentalBillItems implements RuleActionHandler {

    public List buildBillItems(  int yr1, int mon1, int yr2, int mon2 ) {
        def list = [];
        (((yr1*12) + mon1)..((yr2*12)+mon2)).each {
            int y = (int)(it / 12);
            int m = it % 12;
            if( m == 0 ) {
                y = y - 1;
                m = 12;
            }
            list << new MarketRentalBillItem( year: y, month: m );
        }
        return list;
    }

    public void setMonthPeriod( def items, int startdayofmonth ) {
        items.each { entry ->
            int yr = entry.year;
            int mon = entry.month;
            entry.fromdate = DateFunc.getDate( yr, mon, startdayofmonth );

            def mon2 = mon + 1;
            def yr2 = yr ;
            if(mon2 > 12) {
                mon2 = 1;
                yr2 = yr2 + 1;
            }
            entry.todate = DateFunc.getDayAdd( DateFunc.getDate( yr2, mon2, startdayofmonth ), -1 );
        }
    }

    public int getDayOfWeek( String dow ) {
        def idow = 1;
        if( dow == "SUNDAY" ) idow = Calendar.SUNDAY;
        else if( dow == "MONDAY" ) idow = Calendar.MONDAY;
        else if( dow == "TUESDAY" ) idow = Calendar.TUESDAY;
        else if( dow == "WEDNESDAY" ) idow = Calendar.WEDNESDAY;
        else if( dow == "THURSDAY" ) idow = Calendar.THURSDAY;
        else if( dow == "FRIDAY" ) idow = Calendar.FRIDAY;
        else if( dow == "SATURDAY" ) idow = Calendar.SATURDAY;
        return idow;
    }

}