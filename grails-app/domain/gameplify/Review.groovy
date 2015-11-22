package gameplify

class Review {
	String review
	Date date
	int numberOfComments
	String status
	static belongsTo = [game:Game, user:User]
	static hasMany=[comment:Comment]
	static mapping ={
		numberOfComments	defaultValue: "0"

	}
	
    static constraints = {
    }
}
