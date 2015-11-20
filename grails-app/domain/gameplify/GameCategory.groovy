package gameplify

class GameCategory {
	String categoryName
	String icon
	String toString(){
		"${categoryName}"
	}
	static hasMany = [ games:Game]
    static constraints = {
    }
}
