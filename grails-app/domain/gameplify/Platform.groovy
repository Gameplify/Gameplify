package gameplify

class Platform {
	String platformName
	static hasMany = [game:Game]
	String toString(){
		"${platformName}"
	}
    static constraints = {
    }
}
