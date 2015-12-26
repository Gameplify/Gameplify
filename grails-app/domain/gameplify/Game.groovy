package gameplify

class Game {
	String gameTitle
	String gameLogo
	float gamePrice
	String gameDescription
	Date releaseDate
	float rating
	int numberOfRaters
	int numberOfReviews
	String status
	String toString(){
		"${gameTitle}"
	}
	static hasMany = [categories: GameCategory , screenshot: Screenshots , platform:Platform, reviews:Review, comment:Comment]
	static belongsTo = [GameCategory ,Platform]  
	 static constraints = {
    }
	 static searchable =true
}
