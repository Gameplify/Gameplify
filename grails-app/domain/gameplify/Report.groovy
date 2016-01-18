package gameplify

class Report {
	
	String type
	Date date
	String status
	int numberOfReports
	
	static belongsTo =[user:User]
    static constraints = {
    }
}
