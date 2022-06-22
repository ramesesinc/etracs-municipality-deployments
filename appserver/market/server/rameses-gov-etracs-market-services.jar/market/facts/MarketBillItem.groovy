package market.facts;

import java.util.*;
import com.rameses.util.*;
import treasury.facts.*;

public class MarketBillItem extends MonthBillItem  {

    String billid;
	Date billdate;
    boolean forwarded;
    Date duedate;

    public MarketBillItem(def m ) {
        super(m);
        if(m.billdate) this.billdate = m.billdate;
        if(m.forwarded) this.forwarded = m.forwarded;
        if(m.billid) this.billid = m.billid;
        if(m.duedate) this.duedate = m.duedate;
    }

    public MarketBillItem(){;}


	def toMap() {
        def m = super.toMap();
        m.billdate = billdate;
        m.forwarded = forwarded;
        m.duedate = duedate;
        return m;
    }

    /*
    public String getParticulars() {
		def df = new java.text.SimpleDateFormat("yyyy-MMM-dd");
		return super.getParticulars() + " (" + df.format(billdate) + ")";
    }
    */

	public String getUid() {
        def df = new java.text.SimpleDateFormat("yyyyMMdd")
        def suid = acctid + "_" + df.format(billdate);
        return suid;
    }

    public int getYearmonth() {
        return ((year*12)+month);
    }

}	