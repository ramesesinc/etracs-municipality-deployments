package market.util;

import com.rameses.util.*;
import com.rameses.service.*;

public class MarketBatchBillServiceDelegate  {

	def conf;
	def service;

	public MarketBatchBillServiceDelegate(def c) {
		this.conf = c;
		this.service = new DefaultScriptServiceProxy( "MarketBatchBillingService", this.conf, [:] );	
	}

	public def invoke(String methodName) {
		return this.service.invoke( methodName  );			
	}

	public def invoke(String methodName, def params) {
		return this.service.invoke( methodName, [ params ] as Object[] );			
	}

	public void startBatchRun( def o ) {
		invoke( "startBatchRun", o );	
	}

	public def getBatchAccountList(def o) {
		return invoke( "getBatchAccountList", o );	
	} 

	public void endBatchRun( def o ) {
		invoke( "endBatchRun", o );	
	}

	public void updateStatus( def o ) {
		invoke( "updateStatus", o );	
	}

	public void addNewBill(def o ) {
		invoke( "addNewBill", o );	
	}
	
	public def getBatchBillsForProcessing() {
		return invoke( "getBatchBillsForProcessing" );	
	}

	public def getExpiredBatchBills() {
		return invoke( "getExpiredBatchBills" );	
	}

	def _persistenceSvc;
	private def getPersistenceService() {
		if(_persistenceSvc==null) {
			_persistenceSvc = new DefaultScriptServiceProxy( "PersistenceService", this.conf, [:] );
		}
		return _persistenceSvc;
	}

	public void regenerateBatch( def b ) {
		println "REGENERATE BATCH " + [prevbatchid: b.objid ];
		def m = [_schemaname: "market_batch_bill"];
		m.prevbatchid = b.objid;
		getPersistenceService().invoke("create", [m] as Object[] );
	}

}
