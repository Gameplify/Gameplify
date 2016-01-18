package gameplify

class Rating {
	float rating
	static belongsTo = [user:User, game:Game]
    static constraints = {
    }
}