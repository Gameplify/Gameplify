package gameplify

import javax.websocket.Session;

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
	
	def addReview(review, gameId, userId){
		log.println("NI SUD SA SERVICE")
		log.println(userId)
		User user = User.get(userId)
		Game game = Game.get(gameId)
		def num = game.numberOfReviews
		num = num+1
		Date date = new Date()
		Review rev = new Review(
			review:review,
			date:date,
			user:user,
			game:game,
			status:"okay"
		)
		game.numberOfReviews = num
		log.println(game.numberOfReviews)
		rev.save()
		user.addToReviews(rev)	
		game.addToReviews(rev)
		user.save()
		game.save(flush:true)
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
