package market.actions;

import com.rameses.rules.common.*;
import market.facts.*;
import com.rameses.util.*;
import java.util.*;
import com.rameses.osiris3.common.*;
import com.rameses.functions.*;

public class AddMonthlyMarketRentalBillItems extends AbstractAddMarketRentalBillItems {

    public void execute(def params, def drools) {
        def ct = RuleExecutionContext.getCurrentContext();
        def facts = ct.facts;

        def fromdate = params.fromdate;
        def todate = params.todate;
        int startdayofmonth = 1;
        if( params.startdayofmonth != null ) {
            startdayofmonth = params.startdayofmonth.toInteger();
        }

        if( fromdate == null ) 
            throw new Exception("fromdate is required in AddMonthlyMarketRentalBillItems rule");
        if( todate == null ) 
            throw new Exception("todate is required in AddMonthlyMarketRentalBillItems rule");

        def cal = Calendar.instance;
        cal.setTime(fromdate);
        int yr1 = cal.get(Calendar.YEAR);
        int mon1 = cal.get(Calendar.MONTH)+1;

        cal.setTime(todate);
        int yr2 = cal.get(Calendar.YEAR);
        int mon2 = cal.get(Calendar.MONTH)+1;
        int day2 = cal.get(Calendar.DATE);

        def items = super.buildBillItems( yr1, mon1, yr2, mon2 );
        super.setMonthPeriod(items, startdayofmonth);

        def firstItem = items.first();
        firstItem.first = true;

        def lastItem = items.last();
        lastItem.last = true;

        facts.addAll( items );

    }

}