package gameplify



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class GameController {

	def gameService
	def gameCategoryService
	def userService
	static scaffold = true
	static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

	def showNavbar(){
		def categories = gameCategoryService.listGame()
		render(template: '../navbar', model:[categories:categories])
	}

	def report(){
		def userId = params.userId
		def type = params.type
		gameService.report(type,userId)
	}

	def rating(){
		def rating = params.rating
		def user = session.user
		def gameId = params.gameId
		log.println("yey ni sud ngari")
		log.println("rating: " +rating)
		log.println("userId: " +user.id)
		log.println("gameId: " +gameId)
		gameService.rate(rating,user.id,gameId)
		Game game = Game.get(gameId)	
		def averageRating = game.averageRating
		log.println(averageRating)
		[averageRating:averageRating]		
	}

	def editReview(){
		def review = gameService.getReview(params.reviewId)
		[review:review]
	}

	def saveNewReview(){
		gameService.editReview(params.review, params.reviewId)
		redirect(action: "gameProfile", params: [gameTitle: params.gameTitle] )
	}

	def addReview(){
		def gameTitle = params.gameTitle
		gameService.addReview(params.review,  params.gameId, session.user.id)
		redirect(action: "gameProfile", params: [gameTitle: gameTitle] )
	}

	def addComment(){
		def gameTitle = params.gameTitle
		gameService.addComment(params.comment,  params.gameId, session.user.id, params.reviewId)
		redirect(action: "gameProfile", params: [gameTitle: gameTitle] )
	}



	def gameProfile(){
		def rating
		def currentUser
		def game = gameService.listGameInfo(params.gameTitle)
		if(session.user){
			currentUser = userService.findUser(session.user.id)
			rating = gameService.getUserRating(game.id,session.user.id)
			if(rating == null){
				rating = 0
			}
		} else {
			rating = 0
		}

		def reviews = gameService.listReview(params.gameTitle, currentUser)
		def comments= gameService.listComment(params.gameTitle, params.reviewId)
		def platforms = gameService.listPlatform()
		def categories = gameCategoryService.listGame()
//		def releaseDate = 
		[game:game, reviews:reviews, comments:comments, platforms:platforms, categories:categories, rating:rating]
	}

	def addGame(){
		def checkedCategory = params.list('category')
		def categories = GameCategory.getAll(checkedCategory)
		def checkGame = gameService.listGameInfo(params.gameTitle.trim())
		def screenshots = params.list('screenshots')
		def releaseDate = Date.parse("yyyy-MM-dd",params.releaseDate)
		if(checkGame != null && checkGame.status != "deleted"){
			flash.message = "Game already exist"
			//		} else if(checkGame.status == "deleted"){
			//			gameService.editGame()
		}
		else if(categories.isEmpty()) {
			flash.message = "You must select at least one category"
		} else {
			gameService.addGame(params.gameTitle.trim(), params.gameLogo, params.gamePrice, params.gameDescription, releaseDate, params.platformId, categories, session.user.id, screenshots)
			flash.success = "Game successfully added!"
		}
		redirect(action:"gameManagement", params:[categoryName:params.currentCategory])
	}
	def editGame(){
		def uncheckedCategory = params.list('formerCategory') - params.list('newCategory')
		def checkedCategory = params.list('newCategory')
		def categories = GameCategory.getAll(checkedCategory)
		def removeCat = GameCategory.getAll(uncheckedCategory)
		def checkGame = gameService.listGameInfo(params.gameTitle.trim())
		def previousTitle = Game.get(params.gameId)
		def releaseDate = Date.parse("yyyy-MM-dd", params.releaseDate)
		def screenshots = params.list('screenshots')
		log.println(params.formerPlatformId)
	
		if(previousTitle.gameTitle == params.gameTitle.trim()){
			if(categories.isEmpty()) {
				flash.error = "You must select at least one category"
			} else {
				gameService.editGame(params.gameId, params.gameTitle.trim(), params.gameLogo, params.gamePrice, params.gameDescription, releaseDate, params.formerPlatformId, params.platformId, categories, removeCat, session.user.id,screenshots)
			}
		}else if(checkGame != null && checkGame.status != "deleted"){
			flash.error = "Game title already exist"
			//		} else if(checkGame.status == "deleted"){
			//			gameService.editGame()
		}else if(categories.isEmpty()) {
			flash.error = "You must select at least one category"
		} else {
			gameService.editGame(params.gameId, params.gameTitle.trim(), params.gameLogo, params.gamePrice, params.gameDescription, releaseDate, params.formerPlatformId, params.platformId, categories, removeCat, session.user.id,screenshots)
		}
		redirect(action:"gameProfile", params:[gameTitle:params.realGameTitle])
	}

	def deleteGame(){
		def currentCategory = params.categoryName
		gameService.deleteGame(params.gameTitle, session.user.id)
		redirect(action: "gameManagement", params:[categoryName:currentCategory])
	}

	def gameManagement(){
		if((!(session.user))||session?.user?.role != "Admin"){
			flash.message = "You do not have permission to access this page"
			redirect(controller:"game", action: "index")
		} else {
			def how = 'asc'
			def what = 'gameTitle'
			def platforms = gameService.listPlatform()
			def currentCategory = params.categoryName
			def max = params.max ?: 10
			def categories = gameCategoryService.listGame()
			def offset = params.offset ?: 0
			def chosenPlatform = params.platform
			def games = gameService.listGame(currentCategory, chosenPlatform, max, offset,what, how)
			[currentCategory:currentCategory, games:games, chosenPlatform:chosenPlatform, platforms:platforms, gameCount:games.totalCount,categories:categories]
		}
	}

	def listGame(){

		def how = 'asc'
		def what = 'gameTitle'
		def platforms = gameService.listPlatform()
		def currentCategory = params.categoryName
		def max = params.max ?: 10
		def offset = params.offset ?: 0
		def chosenPlatform = params.platform
		def games = gameService.listGame(currentCategory, chosenPlatform, max, offset, what, how)
		log.println(games)
		[currentCategory:currentCategory, games:games, chosenPlatform:chosenPlatform, platforms:platforms, gameCount:games.totalCount]
	}

	def sortList(){
		def how
		def what
		if(params.how){
			how = params.how
			what = params.what
		} else {
			how = 'asc'
			what = 'gameTitle'
		}
		def platforms = gameService.listPlatform()
		def currentCategory = params.categoryName
		def max = params.max ?: 10
		def offset = params.offset ?: 0
		def chosenPlatform = params.platform
		def games = gameService.listGame(currentCategory, chosenPlatform, max, offset, what, how)
		log.println(games)
		[currentCategory:currentCategory, games:games, chosenPlatform:chosenPlatform, platforms:platforms, gameCount:games.totalCount]
	}

	def index() {
		def platform = gameService.listPlatform()
		def max = params.max ?: 10
		def offset = params.offset ?: 0
		def chosenPlatform = params.platform
		def taskList = gameService.listGamePlat(chosenPlatform,max,offset)
		def taskL = gameService.whatsHot(chosenPlatform,max,offset)
		def bool= params.bool
		def now = new Date()
		def dateString = now.toTimestamp()
		def lYear = now[Calendar.YEAR] -1
		def lDate = now[Calendar.DATE]
		def prevMonth = now[Calendar.MONTH]
		def lastYear=now.updated(year: lYear, date: lDate, month: prevMonth)
		def dateStrng = lastYear.toTimestamp()
		[now: dateString,bool:bool, last:dateStrng, games:taskL, bb:taskList, chosenPlatform:chosenPlatform, platforms:platform, gameCount:taskL.totalCount, gameCont:taskList.totalCount] 
		

	}

	def list() {
		def taskList = Game.createCriteria().list(params){
			if ( params.query) {
				ilike("gameTitle", "%${params.query}%")
				and { eq("status", "okay") }
			}
			
			order("gameTitle", "asc")
		}

		def userList = User.createCriteria().list(params){
			if ( params.query) {
				ilike("name", "%${params.query}%")
				and {
					eq("role", "User")
					eq("status", "okay")
				}
			}
			order("name", "asc")
		}

		def uuu = User.createCriteria().list(params){
			if ( params.query) {
				ilike("name", "%${params.query}%")
				and {
					eq("role", "User")
					eq("status", "okay")
				}
			}
			order("name", "asc")
		}

		def ggg = Game.createCriteria().list(params){
			if ( params.query) {
				ilike("gameTitle", "%${params.query}%")
				and { eq("status", "okay") }
			}
			order("gameTitle", "asc")
		}

		def total= userList.totalCount + taskList.totalCount

		[ gam:ggg, gamet: ggg.totalCount , uses:uuu, usert: uuu.totalCount ,users:userList, totals:total,  userInstanceTotal: userList.totalCount, games: taskList, taskInstanceTotal: taskList.totalCount]
	}
}
