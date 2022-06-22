package market.util;

import com.rameses.util.*;
import com.rameses.service.*;

public class MarketBatchRateServiceDelegate  {

	def conf;
	
	public MarketBatchRateServiceDelegate(def c) {
		this.conf = c;
	}

	def _persistenceSvc;
	private def getPersistenceService() {
		if(_persistenceSvc==null) {
			_persistenceSvc = new DefaultScriptServiceProxy( "PersistenceService", this.conf, [:] );
		}
		return _persistenceSvc;
	}

	def _qrySvc;
	private def getQueryService() {
		if(_qrySvc==null) {
			_qrySvc = new DefaultScriptServiceProxy( "QueryService", this.conf, [:] );
		}
		return _qrySvc;
	}

	public def getExpiredIdleList() {
		def m = [_schemaname: "market_batch_rental_rate"];
		m.where = [ "nextdate <= NOW() AND state = 'IDLE' " ];
		return getQueryService().invoke( "getList", [m] as Object[] );
	}

	public void deployBatch(def batch) {
		def z = [_schemaname: "market_batch_rental_rate"];
        z.objid = batch.objid;
        z._action = "deploy";
        getPersistenceService().invoke( "doAction", [z] as Object[] );
    }
        
}
