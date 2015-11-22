package gameplify

import java.util.Date;

class Comment {
	String comment
	Date date
	String status
	static belongsTo = [game:Game, user:User, review:Review]
	
	static constraints = {
	}
}
