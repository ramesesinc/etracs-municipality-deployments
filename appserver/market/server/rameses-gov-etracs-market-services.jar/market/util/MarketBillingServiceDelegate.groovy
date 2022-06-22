package market.util;

import com.rameses.util.*;
import com.rameses.service.*;

public class MarketBillingServiceDelegate  {

	def conf;
	def service;

	public MarketBillingServiceDelegate(def c) {
		this.conf = c;
		this.service = new DefaultScriptServiceProxy( "MarketBillingService", this.conf, [:] );	
	}

	public def invoke(String methodName) {
		return this.service.invoke( methodName, [ [:] ] as Object[] );			
	}

	public def invoke(String methodName, def params) {
		return this.service.invoke( methodName, [ params ] as Object[] );			
	}


}
