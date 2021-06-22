package market.actions;

import com.rameses.rules.common.*;
import market.facts.*;
import com.rameses.util.*;
import java.util.*;
import com.rameses.osiris3.common.*;
import com.rameses.functions.*;

public class AddDailyMarketRentalBillItems extends AbstractAddMarketRentalBillItems {

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
            throw new Exception("fromdate is required in AddDailyMarketRentalBillItems rule");
        if( todate == null ) 
            throw new Exception("todate is required in AddDailyMarketRentalBillItems rule");

        //we need to determine the months where the fromdate and enddate belongs
        def cal = Calendar.instance;
        cal.setTime(fromdate);
        int yr1 = cal.get(Calendar.YEAR);
        int mon1 = cal.get(Calendar.MONTH)+1;

        //if startdate is greater than fromdate we need to deduct one month from startdate
        int day1 = cal.get(Calendar.DATE);
        if( day1 < startdayofmonth ) {
            mon1 = mon1 - 1;
            if(mon1 <= 0) {
                mon1 = 12;
                yr1 = yr1 - 1;
            }
        }

        //find the possible end date of the month. add first an additional month to enddate. 
        //test if enddate > todate then deduct one month else retain
        cal.setTime(todate);
        int yr2 = cal.get(Calendar.YEAR);
        int mon2 = cal.get(Calendar.MONTH)+1;
        int day2 = cal.get(Calendar.DATE);

        if( day2 < startdayofmonth ) {
            mon2 = mon2 - 1;
            if( mon2 <= 0 ) {
                mon2 = 12;
                yr2 = yr2 - 1;
            }
        }

        def items = super.buildBillItems( yr1, mon1, yr2, mon2 );
        super.setMonthPeriod(items, startdayofmonth);

        def firstItem = items.first();
        firstItem.fromdate = fromdate;
        firstItem.first = true;

        def lastItem = items.last();
        lastItem.todate = todate;
        lastItem.last = true;

        facts.addAll( items );

        /*
        def acct = params.account;
        def billingInfo = params.billinginfo;        
        def day = params.day;
        def ord = params.ordinal;
        def dow = params.dow;

        if( billitem == null )
            throw new Exception("billitem is required in SetMarketRentalMonthPeriod rule");
        if( account == null )
            throw new Exception("account is required in SetMarketRentalMonthPeriod rule");
        if( billingInfo == null )
            throw new Exception("billinginfo is required in SetMarketRentalMonthPeriod rule");

        //if day of week specified, prioritize it over day    
        if( dow ) {
            day = null;
            if( ord ==null ) ord = 1;            
        }    
        else if(day == null ) {
            day = 1;
        }     

        int yr = billitem.year;
        int mon = billitem.month;
        def enddate = billitem.todate;

        def fromdate = null;
        if( day !=null ) {
            fromdate = DateFunc.getDate( yr, mon, day );      
        }
        else {
            def idow = 1;
            if( dow == "SUNDAY" ) idow = Calendar.SUNDAY;
            else if( dow == "MONDAY" ) idow = Calendar.MONDAY;
            else if( dow == "TUESDAY" ) idow = Calendar.TUESDAY;
            else if( dow == "WEDNESDAY" ) idow = Calendar.WEDNESDAY;
            else if( dow == "THURSDAY" ) idow = Calendar.THURSDAY;
            else if( dow == "FRIDAY" ) idow = Calendar.FRIDAY;
            else if( dow == "SATURDAY" ) idow = Calendar.SATURDAY;

            fromdate = DateFunc.dayOfMonth( ord, idow, mon, yr );
        }    
        //calculate the end date
        def mon2 = mon + 1;
        def yr2 = yr ;
        if(mon2 > 12) {
            mon2 = 1;
            yr2 = yr2 + 1;
        }
        int day = DateFunc.getDay( fromdate );
        def todate = DateFunc.getDayAdd( DateFunc.getDate( yr2, mon2, day ), -1 );

        //we will try to correct if DAILY or WEEKLY based on specified startdate and enddate
        def partialBalance = acct.partialbalance;
        def startdate = billingInfo.startdate;
        def enddate = billingInfo.enddate;

        if( acct.paymentmode == "DAILY" ) {
            if( billitem.first ) fromdate = startdate;
            if( billitem.last ) todate = enddate;
        }
        else if( acct.paymentmode == "WEEKLY" ) {
            if( billitem.last ) {
                //find the week where the todate belongs basing it on the todate    
                //loop fromdate + 7 until it reaches the date
                def sdate = fromdate;
                def result = fromdate;
                while( (sdate = DateFunc.getDayAdd(sdate, 7 )) < enddate ) {
                    result = sdate; 
                }                
                todate = result;
            }
        }
        
        billitem.fromdate = fromdate;
        billitem.todate = todate;
        */
    }

}