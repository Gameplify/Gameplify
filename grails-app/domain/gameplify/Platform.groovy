package gameplify

class Platform {
	String platformName
	String pic
	static hasMany = [game:Game]
	String toString(){
		"${platformName}"
	}
    static constraints = {
    }
}
