package gameplify

class Game{
	String gameTitle
	String gameLogo
	float gamePrice
	String gameDescription
	Date releaseDate
	float averageRating
	int numberOfRaters
	int numberOfReviews
	String status
	String toString(){
		"${gameTitle}"
	}
	static hasMany = [categories: GameCategory , screenshot: Screenshots , platform:Platform, reviews:Review, comment:Comment,rating:Rating]
	static belongsTo = [GameCategory ,Platform]  
	 static constraints = {
    }
	 static searchable =true
}
