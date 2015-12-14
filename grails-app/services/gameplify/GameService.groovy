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
			games = Game.where { categories.categoryName == currentCategory					 }.list(max: max, offset: offset)
		}
		return games
	}
	def editReview(newReview, reviewId){
		def review = Review.get(reviewId)
		review.review = newReview
		review.save(flush:true)
	}

	def addReview(review, gameId, userId){
		User user = User.get(userId)
		Game game = Game.get(gameId)
		Date date = new Date()
		Review rev = new Review(
				review:review,
				date:date,
				user:user,
				game:game,
				status:"okay"
				)
		log.println(user.totalNumberOfReviews)
		game.numberOfReviews +=1
		user.totalNumberOfReviews +=1
		log.println(user.totalNumberOfReviews)
		rev.save()
		user.addToReviews(rev)
		game.addToReviews(rev)

		game.save(flush:true)
		user.save(flush:true)
	}

	def addComment(comment, gameId, userId, reviewId){
		log.println("ni sud sa service")
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
		user.addToComment(com)
		review.addToComment(com)

		game.save(flush:true)
		review.save(flush:true)
	}

	def listComment(gameId, reviewId){
		def comment = Comment.where {
			game.id == gameId
			review.id == reviewId
		}.list()
		return comment
	}
	
	def listPlatform(){
		return Platform.list()
	}

	def listGameInfo(title){
		def game = Game.findByGameTitle(title)
		return game
	}

	def listReview(title,currentUser){
		def userReviews
		def otherReviews
		def allReviews
		if (currentUser){
			userReviews = Review.where {
				user.id == currentUser.id &&
						game.gameTitle == title
			}.sort{it.date}.reverse(true)

			otherReviews = Review.where{
				user.id != currentUser.id &&
						game.gameTitle == title
			}.sort{it.date}.reverse(true)
			allReviews = userReviews + otherReviews
		} else {
			allReviews  = Review.where{ game.gameTitle == title }.sort{it.date}.reverse(true)
		}

		return allReviews
	}



	def serviceMethod() {
	}
}
