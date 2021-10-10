package rptis.bldg.actions;

import com.rameses.rules.common.*;
import rptis.bldg.facts.*;


public class SummarizeDepreciation implements RuleActionHandler {
	def request
	def NS

	public void execute(def params, def drools) {
		def rpu = params.rpu 
		def bu = params.bldguse 
		rpu.depreciationvalue += bu.depreciationvalue
	}
}