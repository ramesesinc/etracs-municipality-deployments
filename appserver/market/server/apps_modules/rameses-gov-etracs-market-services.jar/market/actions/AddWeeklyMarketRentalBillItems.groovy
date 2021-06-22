package market.actions;

import com.rameses.rules.common.*;
import market.facts.*;
import com.rameses.util.*;
import java.util.*;
import com.rameses.osiris3.common.*;
import com.rameses.functions.*;

public class AddWeeklyMarketRentalBillItems extends AbstractAddMarketRentalBillItems {

    public void execute(def params, def drools) {
        def ct = RuleExecutionContext.getCurrentContext();
        def facts = ct.facts;

        def fromdate = params.fromdate;
        def todate = params.todate;

        if( fromdate == null ) 
            throw new Exception("fromdate is required in AddWeeklyMarketRentalBillItems rule");
        if( todate == null ) 
            throw new Exception("todate is required in AddWeeklyMarketRentalBillItems rule");

        int ord = 1;
        if( params.ordinal ) {
            ord = params.ordinal.toInteger();
        }

        int dow = 1;
        if( params.dow != null ) {
            dow = super.getDayOfWeek( params.dow );                
        }

        //based on the fromdate, find the week of year where it belongs
        def cal = Calendar.instance;
        cal.setTime(fromdate);
        //find the week of year of the fromdate.
        int weekofyear = cal.get(Calendar.WEEK_OF_YEAR);
        //set the ordinal and day of week for the date.
        cal.set(Calendar.DAY_OF_WEEK, dow );     
        cal.set(Calendar.DAY_OF_WEEK_IN_MONTH, ord);
        cal.set(Calendar.WEEK_OF_YEAR, weekofyear);
        cal.set(Calendar.HOUR, 0 );  
        cal.set(Calendar.MINUTE, 0 );  
        cal.set(Calendar.SECOND, 0 );  
        cal.set(Calendar.MILLISECOND, 0 ); 

        int yr1 = cal.get(Calendar.YEAR);
        int mon1 = cal.get(Calendar.MONTH)+1;

        def startdate = cal.getTime();

        cal.setTime(todate);
        int yr2 = cal.get(Calendar.YEAR);
        int mon2 = cal.get(Calendar.MONTH)+1;
        int day2 = cal.get(Calendar.DATE);

        weekofyear = cal.get(Calendar.WEEK_OF_YEAR);
        cal.set(Calendar.DAY_OF_WEEK, dow);
        cal.set(Calendar.DAY_OF_WEEK_IN_MONTH, ord);
        cal.set(Calendar.WEEK_OF_YEAR, weekofyear);
        def enddate = DateFunc.getDayAdd( cal.getTime(), 6 );

        def items = super.buildBillItems( yr1, mon1, yr2, mon2 );
        items.each {
            int yr = it.year;
            int mon = it.month;
            it.fromdate = DateFunc.dayOfMonth( ord, dow, mon, yr );   
            def _mon = mon + 1;
            def _yr = yr ;
            if( _mon > 12) {
                _mon = 1;
                _yr = _yr + 1;
            };
            it.todate = DateFunc.getDayAdd( DateFunc.dayOfMonth( ord, dow, _mon, _yr ), -1);  
        };

        def firstItem = items.first();
        firstItem.fromdate = startdate;
        firstItem.first = true;

        def lastItem = items.last();
        lastItem.todate = enddate;
        lastItem.last = true;

        facts.addAll( items );

    }


}