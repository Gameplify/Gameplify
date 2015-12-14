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
				status == "okay"
			}.list(max: max, offset: offset)
		} else if(!chosenPlatform){
<<<<<<< HEAD
			games = Game.where { categories.categoryName == currentCategory					 }.list(max: max, offset: offset)
=======
<<<<<<< HEAD
			games = Game.where { categories.categoryName == currentCategory					 }.list(max: max, offset: offset)
=======
			games = Game.where {
				categories.categoryName == currentCategory	
				status == "okay"
			}.list(max: max, offset: offset)
>>>>>>> c640b3876a7f1109827955baa6179cefdf40f507
>>>>>>> 5b6ba28baf4dbe0be210cf15032a6a66ce6a9d0d
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
<<<<<<< HEAD
=======
	}
	
	def addGame(gameTitle, gameLogo, gamePrice, gameDescription, releaseDate, platformId, categories){
		Platform platform = Platform.get(platformId)
		Game game = new Game(
			gameTitle:gameTitle,
			gameLogo:gameLogo,
			gamePrice:gamePrice,
			gameDescription:gameDescription,
			releaseDate:releaseDate,
			rating:0,
			numberOfReviews:0,
			numberOfRaters:0,
			status:"okay"
			
		)		
		game.save(failOnError: true)
		platform.addToGame(game)
		log.println (categories)
		categories.each {
			GameCategory gameCategory = GameCategory.get(it.id)
			log.println(gameCategory.categoryName)
			gameCategory.addToGames(game)
			gameCategory.save(flush:true)
		}
		platform.save(flush:true)
		log.println(platform.platformName)
	}
	def editGame(gameId, gameTitle, gameLogo, gamePrice, gameDescription, releaseDate, platformId, categories, removeCat){
		Platform platform = Platform.get(platformId)
		Game game = Game.get(gameId)
		game.gameTitle = gameTitle
		game.gamePrice = gamePrice.toFloat()
		game.gameDescription = gameDescription
		game.releaseDate = releaseDate
		if(gameLogo){
			game.gameLogo = gameLogo
		}
		game.save(flush: true)
		platform.addToGame(game)
		log.println (categories)
		removeCat.each {
			GameCategory gameCategory = GameCategory.get(it.id)
			log.println(gameCategory.categoryName)
			gameCategory.removeFromGames(game)
			gameCategory.save(flush:true)
		}
		
		categories.each {
			GameCategory gameCategory = GameCategory.get(it.id)
			log.println(gameCategory.categoryName)
			gameCategory.addToGames(game)
			gameCategory.save(flush:true)
			
		}
		platform.save(flush:true)
		log.println(platform.platformName)
	}
	
	def deleteGame(gameTitle, gameCategory){		
		def game = Game.findByGameTitle(gameTitle)
		game.status ="deleted"	
		game.save()
>>>>>>> 5b6ba28baf4dbe0be210cf15032a6a66ce6a9d0d
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
