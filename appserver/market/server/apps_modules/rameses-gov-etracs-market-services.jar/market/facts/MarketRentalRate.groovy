package market.facts;

import java.util.*;
import treasury.facts.*;

class MarketRentalRate {
	
	int year;
	Date fromdate;
	Date todate;
	double rate;
	String ratetype;	//DAY OR MONTH

	public String toString() {
		return "rental rate-> " + fromdate + " to " + todate + ": " + rate + " " + ratetype;
	}

}