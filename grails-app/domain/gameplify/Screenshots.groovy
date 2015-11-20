package gameplify

class Screenshots {
	String photo
	static belongsTo = [game : Game]
    static constraints = {
    }
}
