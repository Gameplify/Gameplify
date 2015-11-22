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
	
	def addComment(comment, gameId, userId, reviewId){
		
		User user = User.get(userId)
		Game game = Game.get(gameId)
		Review review= Review.get(reviewId)
		def num = review.numberOfComments
		num = num+1
		Date date = new Date()
		Comment com = new Comment(
			comment:comment,
			date:date,
			user:user,
			game:game,
			review:review,
			status:"okay"
		)
		review.numberOfComments = num
		com.save()
	
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
	
	def listComment(title, reviewId){
		def comment = Comment.where {
			game.gameTitle == title
			review.id == reviewId
		}
		return comment
	}
	
	
    def serviceMethod() {

    }
}
