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
		[game:game, reviews:reviews, comments:comments, platforms:platforms, categories:categories, rating:rating]
	}	
	
	def addGame(){
		def checkedCategory = params.list('category')
		def categories = GameCategory.getAll(checkedCategory)
		def checkGame = gameService.listGameInfo(params.gameTitle)
		if(checkGame != null && checkGame.status != "deleted"){
			flash.message = "Game already exist"
//		} else if(checkGame.status == "deleted"){
//			gameService.editGame()
		}
		else if(categories.isEmpty()) {
			flash.message = "You must select at least one category"
		} else {
			gameService.addGame(params.gameTitle, params.gameLogo, params.gamePrice, params.gameDescription, params.releaseDate, params.platformId, categories, session.user.id)		
		}
		redirect(action:"gameManagement", params:[categoryName:params.currentCategory])	
	}
	def editGame(){
		def uncheckedCategory = params.list('formerCategory') - params.list('newCategory') 
		def checkedCategory = params.list('newCategory')
		def categories = GameCategory.getAll(checkedCategory)
		def removeCat = GameCategory.getAll(uncheckedCategory)
		if(categories.isEmpty()) {
			flash.message = "You must select at least one category"
		} else {
			gameService.editGame(params.gameId, params.gameTitle, params.gameLogo, params.gamePrice, params.gameDescription, params.releaseDate, params.platformId, categories, removeCat, session.user.id)
		}
		redirect(action:"gameProfile", params:[gameTitle:params.gameTitle])
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
			def platforms = gameService.listPlatform()
			def currentCategory = params.categoryName
			def max = params.max ?: 10
			def categories = gameCategoryService.listGame()
			def offset = params.offset ?: 0
			def chosenPlatform = params.platform
			def games = gameService.listGame(currentCategory, chosenPlatform, max, offset)
			[currentCategory:currentCategory, games:games, chosenPlatform:chosenPlatform, platforms:platforms, gameCount:games.totalCount,categories:categories]
		}
	}
  
	def listGame(){
	def platforms = gameService.listPlatform()
    def currentCategory = params.categoryName
    def max = params.max ?: 10
    def offset = params.offset ?: 0
	def chosenPlatform = params.platform
	def games = gameService.listGame(currentCategory, chosenPlatform, max, offset)
    [currentCategory:currentCategory, games:games, chosenPlatform:chosenPlatform, platforms:platforms, gameCount:games.totalCount] 
  }

	def index() {
		def platform = gameService.listPlatform()
		def max = params.max ?: 10
		def offset = params.offset ?: 0
		def chosenPlatfrm = params.platform
		def taskList = gameService.listGamePlat(chosenPlatfrm,max,offset)
		def taskL = gameService.whatsHot(chosenPlatfrm,max,offset)
		 [games:taskL, bb:taskList, chosenPlatform:chosenPlatfrm, platforms:platform] 
		
	}
	
	def list() {
		  def taskList = Game.createCriteria().list(params){
			if ( params.query) {
			  ilike("gameTitle", "%${params.query}%")
			}
			order("gameTitle", "asc")
		  }
			  
		  def userList = User.createCriteria().list(params){
			if ( params.query) {
			  ilike("name", "%${params.query}%")
			}
			order("name", "asc")
		  }
		  
		  def uuu = User.createCriteria().list(params){
			  if ( params.query) {
				ilike("name", "%${params.query}%")
			  }
			  order("name", "asc")
		  }
		  
		  def ggg = Game.createCriteria().list(params){
			  if ( params.query) {
				ilike("gameTitle", "%${params.query}%")
			  }
			  order("gameTitle", "asc")
			  
		  }
		  
		  def total= userList.totalCount + taskList.totalCount

		[ gam:ggg, gamet: ggg.totalCount , uses:uuu, usert: uuu.totalCount ,users:userList, totals:total,  userInstanceTotal: userList.totalCount, games: taskList, taskInstanceTotal: taskList.totalCount]
	 }
    
}
