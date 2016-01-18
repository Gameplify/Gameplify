package gameplify

class Rating {
	int rating
	static belongsTo = [user:User, game:Game]
    static constraints = {
    }
}