package waterworks.facts;

import java.util.*;
import com.rameses.util.*;
import treasury.facts.*;

public class WaterBillItem extends BillItem {

	def monthNames = ['JAN','FEB','MAR','APR','MAY','JUN','JUL','AUG','SEP','OCT','NOV','DEC'];

	def objid;
	def recurringfeeid;

	public WaterBillItem(def o) {
		super(o);
		if(o.objid) this.objid = o.objid;
	}

	public WaterBillItem() {}

	public def toMap() { 
		def m = super.toMap(); 
		if(objid) m.objid = objid;
		//we have to fix this. if discount is negative it should be positive
		if( m.discount == null ) m.discount = 0;
		m.monthname = getMonthname();
		if( recurringfeeid ) m.recurringfeeid = recurringfeeid;
		return m;
	}	

	public int hashCode() {
		def buff = new StringBuilder();
		buff.append( yearMonth );
		buff.append( "-" + billcode );
		return buff.toString().hashCode();
	}

	public int getPaypriority() {
		return (yearMonth +""+ ( 1000 + sortorder )).toInteger();
	}

	public String getMonthname() { 
		def idx = month-1; 
		if ( idx >= 0 && idx < monthNames.size() ) {
			return monthNames[ idx ]; 
		}
		return null; 
    }

    //this is a workaround
    public int getYearmonth() {
    	return (year*12)+month;
    }

}	