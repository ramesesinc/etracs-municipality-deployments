package market.actions;

import com.rameses.rules.common.*;
import market.facts.*;
import com.rameses.util.*;
import java.util.*;
import com.rameses.osiris3.common.*;
import com.rameses.functions.*;

public class SetMarketRentalBillItemAmount implements RuleActionHandler {

    public void execute(def params, def drools) {
        def ct = RuleExecutionContext.getCurrentContext();
        def facts = ct.facts;

        def billitem = params.billitem;
        def vrate = params.rentalrate;
        def account = params.account;

        if(billitem == null )
            throw new Exception("fromdate is required in AddDailyMarketRentalBillItems rule");

        if(vrate == null )
            throw new Exception("rentalrate is required in AddDailyMarketRentalBillItems rule");

        if(account == null )
            throw new Exception("account is required in AddDailyMarketRentalBillItems rule");

        double partialbalance = account.partialbalance;
        double rate = vrate.rate;

        billitem.rate = rate;
        billitem.ratetype = vrate.ratetype;
        if( account.paymentmode == "MONTHLY" ){
            if( partialbalance > 0 && billitem.first == true ) {
                billitem.amount = partialbalance;
            }
            else if ( vrate.ratetype == "DAY") {
                billitem.amount = billitem.numdays * rate; 
            }
            else {
                billitem.amount = vrate.rate;
            }
        }
        else if( account.paymentmode == "WEEKLY") {
            def dr = rate; //dr = daily rate
            if( vrate.ratetype != "DAY") {
                dr = rate / 7;        
            }
            if( partialbalance > 0 && billitem.first == true ) {
                billitem.amount = ((billitem.numdays - 7) * dr) + partialbalance; 
            }
            else {
                billitem.amount = billitem.numdays * dr;
            }
            billitem.rate = dr * 7;            
        }
        else {
            if( partialbalance > 0 && billitem.first == true ) {
                billitem.amount = ((billitem.numdays-1) * rate) + partialbalance; 
            }    
            else {
                billitem.amount = billitem.numdays * rate; 
            }            
        }
        

    }

}