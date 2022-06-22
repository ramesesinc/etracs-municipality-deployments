package market.facts;

import java.util.*;
import com.rameses.util.*;

public class MarketUtilityConsumption {

    int volume = 0;
    boolean hold;
    double rate;
    String billtype;

    boolean updated = false;

    public MarketUtilityConsumption(def o) {
	    if(o.volume)  volume = o.volume;
	    if(o.hold!=null && o.hold == 1 ) hold = true; 
	    billtype = o.billtype;
    }

}
