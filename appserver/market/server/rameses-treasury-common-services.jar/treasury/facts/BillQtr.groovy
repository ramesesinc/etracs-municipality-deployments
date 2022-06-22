package treasury.facts;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

class BillQtr {

	int qtr;
	int year;
	int startmonth;

	//just in case it does not start on jan 1.
	Date fromdate;
	Date todate;

	Date duedate;

	public int getStartyearmonth() {
    	return  ((year*12)+startmonth);    
    }

    public int hashCode() {
    	return ("" + year + "_" + qtr).hashCode();
    }

}