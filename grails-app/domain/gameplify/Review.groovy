package gameplify

class Review {
	String review
	Date date
	int numberOfComments
	String status
	static belongsTo = [user:User, game:Game]
    static constraints = {
    }
}
