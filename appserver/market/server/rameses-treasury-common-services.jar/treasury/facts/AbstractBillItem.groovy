package treasury.facts;

import java.util.*;
import com.rameses.util.*;

public abstract class AbstractBillItem {

	String objid;
    double amount;
    double amtpaid;
    String remarks;

    ItemAccount item = new ItemAccount();
    
    public AbstractBillItem( def m ) {
        if(m.objid) this.objid = m.objid;
        if(m.acctid) this.item.objid = m.acctid;
        if(m.acctname) this.item.title = m.acctname;
        if(m.amount) this.amount = m.amount;
        if(m.amtpaid) this.amtpaid = m.amtpaid;
        if(m.remarks) this.remarks = m.remarks;        
    }

    public AbstractBillItem(){;}

    //this is to support existing items
    public String getAcctid() {
        return item.objid;
    }

    public String getBillcode() {
        return item.objid;
    }

    public void setAcctid( String id ) {
        this.item.objid = id;
    }

    public String getAcctname() {
        return this.item.title;
    }

    public void setAcctname( String n ) {
        this.item.title = n;
    }

    //this is to mark if this was aded before rule execution so we will know what we need to save in the database
    boolean input = false;
    
    public String getParticulars() {
        if(remarks) {
            return acctname + "( " + remarks + ")";
        }
        else {
            return acctname;     
        }
    }

    public String getUid() {
        return acctid;
    }

    public int hashCode() {
        return getUid().hashCode();
    }

    def toMap() {
        def m = [:];
        m.objid = objid;
        m.amount = amount;
        m.amtpaid = amtpaid;
        m.item = item.toMap();
        m.remarks = remarks;
        m.particulars = getParticulars();
        m.uid = getUid();
        return m;
    }


}