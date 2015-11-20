package gameplify

class GameList {
	static belongsTo = [game : Game , category : GameCategory]	
    static constraints = {
    }
}
