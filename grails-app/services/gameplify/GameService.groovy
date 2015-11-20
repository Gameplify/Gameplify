package gameplify

import grails.transaction.Transactional

@Transactional
class GameService {

	def listGame(currentCategory, chosenPlatform, max, offset){
		def games
		if(chosenPlatform){
			games = Game.where {
				categories.categoryName == currentCategory
				platform.platformName == chosenPlatform
			}.list(max: max, offset: offset)
		} else if(!chosenPlatform){
			games = Game.where {
				categories.categoryName == currentCategory					
			}.list(max: max, offset: offset)
		}
		return games
	}
	
	def listPlatform(){
		return Platform.list()
	}
	
	def listGameInfo(title){
		def game = Game.findByGameTitle(title)
		return game
	}
	
	def listReview(title){
		def reviews = Review.where {
			game.gameTitle == title
		}
		return reviews
	}
	
	
    def serviceMethod() {

    }
}
