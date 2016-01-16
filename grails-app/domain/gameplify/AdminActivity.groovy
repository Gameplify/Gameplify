package gameplify

class AdminActivity {
	String action
	static belongsTo = [admin:User,game:Game,user:User]
    static constraints = {
		game(nullable:true)
		user(nullable:true)
    }
}
