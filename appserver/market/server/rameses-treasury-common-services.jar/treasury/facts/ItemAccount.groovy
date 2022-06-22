package treasury.facts;

import java.util.*;
import com.rameses.util.*;

public class ItemAccount {

	String objid;
    String title;
   

    public ItemAccount( String sobjid, String stitle ) {
        this.objid = sobjid;
        this.title = stitle;
    }    
    
    public ItemAccount( def m ) {
        if(m.objid) this.objid = m.objid;
        if(m.title) this.title = m.title;
    }

    public ItemAccount(){;}

    public int hashCode() {
        return this.objid.hashCode();
    }

    def toMap() {
        def m = [:];
        m.objid = objid;
        m.title = title;
        return m;
    }


}