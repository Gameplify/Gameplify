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
			games = Game.where {
				categories.categoryName == currentCategory
				status == "okay"
			}.list(max: max, offset: offset)
		}
		return games
	}

	def rate(rating, userId, gameId){
		def game = Game.get(gameId)
		def user = User.get(userId)
		log.println("wew")
		log.println("naa nay rating")
		Rating rate = new Rating(
				rating : rating,
				user : user,
				game : game
				)
		rate.save()

		game.addToRating(rate)
		user.addToRating(rate)
		user.save(flush:true)
		game.save(flush:true)
		def averageRating = getAverageRating(gameId)
		game.averageRating = averageRating
		game.save(flush:true)
	}

	def getAverageRating(gameId){
		def sum = 0
		def x = 0
		Rating.where { game.id == gameId }.list().each{
			sum += it.rating
			x++
		}
		log.println(x)
		return sum/x
	}

	def listGamePlat( chosenPlatform, max, offset){
		def games
		if(chosenPlatform){
			games = Game.where {
				platform.platformName == chosenPlatform
				status == "okay"
			}.list(max: max, offset: offset)
		} else if(!chosenPlatform){
			games = Game.where { status == "okay" }.list(sort: 'releaseDate', order: 'desc', max: max, offset: offset )
		}
		return games
	}

	def getReview(reviewId){
		def review = Review.get(reviewId)
	}



	def whatsHot( chosenPlatform, max, offset){
		def games
		if(chosenPlatform){
			games = Game.where {
				platform.platformName == chosenPlatform
				status == "okay"
			}.list(max: max, offset: offset)
		} else if(!chosenPlatform){
			games = Game.where { status == "okay" }.list(sort: 'rating', order: 'desc', max: max, offset: offset)
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
		game.numberOfReviews +=1
		user.totalNumberOfReviews +=1
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

	def listComment(gameTitle, reviewId){
		def comment = Comment.where {
			game.gameTitle == gameTitle
			review.id == reviewId
		}.list()
		return comment
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

	def deleteGame(gameTitle){
		def game = Game.get(gameTitle)
		game.status ="deleted"
		game.save(flush:true)
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
			}.sort{ it.date }.reverse(true)

			otherReviews = Review.where{
				user.id != currentUser.id &&
						game.gameTitle == title
			}.sort{ it.date }.reverse(true)
			allReviews = userReviews + otherReviews
		} else {
			allReviews  = Review.where{ game.gameTitle == title }.sort{ it.date }.reverse(true)
		}

		return allReviews
	}

	def serviceMethod() {
	}
}
