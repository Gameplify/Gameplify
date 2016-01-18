package gameplify

class AdminActivity {
	String action
	Date date
	static belongsTo = [admin:User,game:Game,user:User]
    static constraints = {
		game(nullable:true)
		user(nullable:true)
    }
}
