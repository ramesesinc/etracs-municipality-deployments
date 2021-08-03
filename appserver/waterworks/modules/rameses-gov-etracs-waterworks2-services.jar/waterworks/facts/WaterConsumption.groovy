package waterworks.facts;

import java.util.*;
import com.rameses.util.*;

public class WaterConsumption {

    int volume = 0;
    double amount = 0.0;
    boolean hold;

    //this is only an internal flag. This will be set if the amount was already updated so it wont update again
    //do not remove this bec. it is a flag used by ComputeConsumption action
    boolean updated = false;

    public WaterConsumption(def o) {
	    if(o.volume)  volume = o.volume;
	    if(o.amount) amount = o.amount;
        if(o.hold!=null && o.hold == 1 ) hold = true; 
    }

}
