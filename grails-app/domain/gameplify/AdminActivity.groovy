package gameplify

class AdminActivity {
	String action
	Date date
	static belongsTo = [admin:User]
    static constraints = {
    }
}
