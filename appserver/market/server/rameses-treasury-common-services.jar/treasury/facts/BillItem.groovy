package treasury.facts;

import java.util.*;
import com.rameses.util.*;
import com.rameses.functions.*;

public class BillItem extends AbstractBillItem {
    

    String tag;
    List<BillSubItem> items = [];
    
    int paypriority;

    public BillItem( def m ) {
        super(m);
    }

    public BillItem(){;}

    def toMap() {
        def m = super.toMap();
        m.surcharge = getSurcharge();
        m.interest = getInterest();
        m.total = getTotal();
        m.paypriority = paypriority;
        return m;
    }

    public def addSubItem( BillSubItem si ) {
        si.billitemrefid = this.objid;
        si.billitem = this;

        //return null if unsuccessfully added. 
        if(!items.find{ it.hashCode() == si.hashCode() }  ) {
            items << si;
            return si;    
        }
        else {
            return null;    
        }
    }

    public double getSurcharge() {
        return NumberUtil.round(items.findAll{ it instanceof SurchargeItem }.sum{it.amount});
    }

    public double getInterest() {
        return NumberUtil.round(items.findAll{ it instanceof InterestItem }.sum{it.amount});
    }

    public double getTotal() {
        return NumberUtil.round( amount + surcharge + interest );
    }

    public double getBalance() {
        return NumberUtil.round( total - amtpaid );
    }

    public double applyPayment( def payamt ) {
        if( payamt >= total ) {
            return NumberUtil.round( payamt - total );
        }
        def _total = getTotal();
        double _amt = payamt;
        for(BillSubItem bi: items) { 
            bi.amount = NumberUtil.round( ( bi.amount / _total ) * payamt );
            _amt = NumberUtil.round(_amt - bi.amount);
        }
        this.amount = NumberUtil.round( ( this.amount / _total ) * payamt );
        _amt = NumberUtil.round( _amt - this.amount );
        return _amt;
    }
    
    public double getDiscount() {
        return 0;
    }

    public double getSurchargepaid() {
        return NumberUtil.round(items.findAll{ it instanceof SurchargeItem }.sum{it.amtpaid});
    }

    public double getInterestpaid() {
        return NumberUtil.round(items.findAll{ it instanceof InterestItem }.sum{it.amtpaid});
    }

    public double getTotalpaid() {
        return NumberUtil.round( (amtpaid - discount) + surchargepaid + interestpaid );
    }
	
}