package gameplify

import javax.websocket.Session;

import grails.transaction.Transactional

@Transactional
class GameService {

	def userService



	def report(type,userId){
		def rep = Report.find{user.id == userId}
		if(rep){
			def curRep = Report.get(rep.id)
			numberOfReports:curRep.numberOfReports++
			status:"okay"
			curRep.save(flush:true)
		} else {
			def user = User.get(userId)
			Date date = new Date()
			Report report = new Report(
					date:date,
					type:type,
					user:user,
					status:"okay",
					numberOfReports:1
					)
			report.save()
			user.addToReports(report)
			user.save(flush:true)
		}
	}

	def getUserRating(gameId, userId){
		def rating = Rating.find{
			game.id == gameId
			user.id == userId
		}
		if(rating){
			return rating.rating
		}
	}
	def getRatingId(gameId, userId){
		def rating = Rating.find{
			game.id == gameId
			user.id == userId
		}
		if(rating){
			return rating.id
		}
	}

	def rate(rating, userId, gameId){
		def game = Game.get(gameId)
		def user = User.get(userId)
		def id = getRatingId(gameId, userId)
		if(id){
			log.println("ni sud sa edit")
			def newRate = Rating.get(id)
			log.println(rating)
			newRate.rating = rating
			newRate.rating = newRate.rating-48
			log.println("newrate: " +newRate.rating)
			newRate.save(flush:true)
			def averageRating = getAverageRating(gameId)
			game.averageRating = averageRating
			game.save(flush:true)
		} else {
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
	}

	def getAverageRating(gameId){
		def sum = 0
		def x = 0
		Rating.where { game.id == gameId }.list().each{
			sum += it.rating
			x++
		}
		log.println(x)
		return (sum/x)
	}

	def listGamePlat( chosenPlatform, max, offset){
		def games
		def now = new Date()
		def dateString = now.toTimestamp()
		def lYear = now[Calendar.YEAR] -1
		def lDate = now[Calendar.DATE]
		def prevMonth = now[Calendar.MONTH]
		def lastYear=now.updated(year: lYear, date: lDate, month: prevMonth)
		def dateStrng = lastYear.toTimestamp()
		if(chosenPlatform){
			games = Game.where {
				platform.platformName == chosenPlatform
				status == "okay"
				releaseDate>=dateStrng && releaseDate<=dateString
			}.list(sort: 'releaseDate', order: 'desc', max: max, offset: offset )
		} else if(!chosenPlatform){
			games = Game.where {
				 status == "okay"
				 releaseDate>=dateStrng && releaseDate<=dateString
		    }.list(sort: 'releaseDate', order: 'desc', max: max, offset: offset )
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
			}.list(sort: 'averageRating', order: 'desc', max: max, offset: offset)
		} else if(!chosenPlatform){
			games = Game.where { 
				status == "okay" 
			}.list(sort: 'averageRating', order: 'desc', max: max, offset: offset)
		}
		return games
	}

	def editReview(newReview, reviewId){
		Date date = new Date()
		def review = Review.get(reviewId)
		review.review = newReview
		review.date = date
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


	def addGame(gameTitle, gameLogo, gamePrice, gameDescription, releaseDate, platformId, categories,adminId){
		Platform platform = Platform.get(platformId)
		Game game = new Game(
				gameTitle:gameTitle,
				gameLogo:gameLogo,
				gamePrice:gamePrice,
				gameDescription:gameDescription,
				releaseDate:releaseDate,
				averageRating:0,
				numberOfReviews:0,
				numberOfRaters:0,
				status:"okay"
				)
		game.save(failOnError: true)
		Screenshots ss = new Screenshots(
				photo:"ss1.jpg",
				game:game
				)
		ss.save()
		game.addToScreenshot(ss)
		game.save(flush:true)
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
		userService.addAdminActivity(adminId,"added " +gameTitle)
	}
	def editGame(gameId, gameTitle, gameLogo, gamePrice, gameDescription, releaseDate, platformId, categories, removeCat, adminId){
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

		userService.addAdminActivity(adminId,"edited " +gameTitle)
	}

	def deleteGame(gameTitle,adminId){
		def game = Game.get(gameTitle)
		game.status ="deleted"
		game.save(flush:true)
		userService.addAdminActivity(adminId,"deleted: " +game.gameTitle)
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




	def listGame(currentCategory, chosenPlatform, max, offset, what, how){
		def games
		def h = how
		def w = what
		if (how == 'asc'){
			games = sortByAsc(currentCategory, chosenPlatform, max, offset, what)
		} else if (how == 'desc'){
			games = sortByDesc(currentCategory, chosenPlatform, max, offset, what)
		}

		return games
	}

	def sortByAsc(currentCategory, chosenPlatform, max, offset, what){
		def games
		if(what == 'gameTitle'){
			if(chosenPlatform){
				games = Game.where {
					categories.categoryName == currentCategory
					platform.platformName == chosenPlatform
					status == "okay"
				}.list(sort: 'gameTitle', order: "asc", max: max, offset: offset)
			} else if(!chosenPlatform){
				games = Game.where {
					categories.categoryName == currentCategory
					status == "okay"
				}.list(sort: 'gameTitle', order: "asc", max: max, offset: offset)
			}
		} else if (what == 'gamePrice'){
			if(chosenPlatform){
				games = Game.where {
					categories.categoryName == currentCategory
					platform.platformName == chosenPlatform
					status == "okay"
				}.list(sort: 'gamePrice', order: "asc", max: max, offset: offset)
			} else if(!chosenPlatform){
				games = Game.where {
					categories.categoryName == currentCategory
					status == "okay"
				}.list(sort: 'gamePrice', order: "asc", max: max, offset: offset)
			}
		} else if (what == 'averageRating'){
			if(chosenPlatform){
				games = Game.where {
					categories.categoryName == currentCategory
					platform.platformName == chosenPlatform
					status == "okay"
				}.list(sort: 'gamePrice', order: "asc", max: max, offset: offset)
			} else if(!chosenPlatform){
				games = Game.where {
					categories.categoryName == currentCategory
					status == "okay"
				}.list(sort: 'gamePrice', order: "asc", max: max, offset: offset)
			}
		} else {
			if(chosenPlatform){
				games = Game.where {
					categories.categoryName == currentCategory
					platform.platformName == chosenPlatform
					status == "okay"
				}.list(sort: 'gamePrice', order: "asc", max: max, offset: offset)
			} else if(!chosenPlatform){
				games = Game.where {
					categories.categoryName == currentCategory
					status == "okay"
				}.list(sort: 'gamePrice', order: "asc", max: max, offset: offset)
			}
		}
		log.println("ni sud sa ascend")
		return games
	}

	def sortByDesc(currentCategory, chosenPlatform, max, offset, what){
		def games
		if(what == 'gameTitle'){
			if(chosenPlatform){
				games = Game.where {
					categories.categoryName == currentCategory
					platform.platformName == chosenPlatform
					status == "okay"
				}.list(sort: 'gameTitle', order: "desc", max: max, offset: offset)
			} else if(!chosenPlatform){
				games = Game.where {
					categories.categoryName == currentCategory
					status == "okay"
				}.list(sort: 'gameTitle', order: "desc", max: max, offset: offset)
			}
		} else if (what == 'gamePrice'){
			if(chosenPlatform){
				games = Game.where {
					categories.categoryName == currentCategory
					platform.platformName == chosenPlatform
					status == "okay"
				}.list(sort: 'gamePrice', order: "desc", max: max, offset: offset)
			} else if(!chosenPlatform){
				games = Game.where {
					categories.categoryName == currentCategory
					status == "okay"
				}.list(sort: 'gamePrice', order: "desc", max: max, offset: offset)
			}
		} else if (what == 'averageRating'){
			if(chosenPlatform){
				games = Game.where {
					categories.categoryName == currentCategory
					platform.platformName == chosenPlatform
					status == "okay"
				}.list(sort: 'gamePrice', order: "desc", max: max, offset: offset)
			} else if(!chosenPlatform){
				games = Game.where {
					categories.categoryName == currentCategory
					status == "okay"
				}.list(sort: 'gamePrice', order: "desc", max: max, offset: offset)
			}
		} else {
			if(chosenPlatform){
				games = Game.where {
					categories.categoryName == currentCategory
					platform.platformName == chosenPlatform
					status == "okay"
				}.list(sort: 'gamePrice', order: "desc", max: max, offset: offset)
			} else if(!chosenPlatform){
				games = Game.where {
					categories.categoryName == currentCategory
					status == "okay"
				}.list(sort: 'gamePrice', order: "desc", max: max, offset: offset)
			}
		}
		log.println("ni sud sa descend")
		return games
	}




	def serviceMethod() {
	}
}
