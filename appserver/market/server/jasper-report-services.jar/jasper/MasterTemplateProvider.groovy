package jasper;

public class MasterTemplateProvider {

	public def getBlank() {
		return getClass().getResource("blank.jrxml");	
	}

} 
