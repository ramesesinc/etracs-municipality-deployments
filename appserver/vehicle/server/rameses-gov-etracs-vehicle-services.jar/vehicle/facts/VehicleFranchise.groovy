package vehicle.facts;

import java.util.*;

public class VehicleFranchise {
	
	String controlno;
	Date startdate;

	def fixDate( def dt ) {
		if( dt instanceof String ) {
			def df = new java.text.SimpleDateFormat( "yyyy-MM-dd");
			dt = df.parse( dt );
		}
		return dt;
	}

	public VehicleFranchise( def m ) {
		controlno = m.controlno;
		if( m.startdate ) {
			startdate = fixDate( m.startdate );
		}	
	}

}