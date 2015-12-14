package gameplify



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class GameController {

	def gameService
	def gameCategoryService
	def userService
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index() {
		
    }
	
	def showNavbar(){
		def categories = gameCategoryService.listGame()
		render(template: '../navbar', model:[categories:categories])
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
		def currentUser	
		if(session.user){
			currentUser = userService.findUser(session.user.id)
		}
		def game = gameService.listGameInfo(params.gameTitle)
		def reviews = gameService.listReview(params.gameTitle, currentUser)
		def comments= gameService.listComment(params.gameTitle, params.reviewId)
<<<<<<< HEAD
		
		[game:game, reviews:reviews, comments:comments]
=======
		def platforms = gameService.listPlatform()
		def categories = gameCategoryService.listGame()
		[game:game, reviews:reviews, comments:comments, platforms:platforms, categories:categories]
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
			gameService.addGame(params.gameTitle, params.gameLogo, params.gamePrice, params.gameDescription, params.releaseDate, params.platformId, categories)		
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
			gameService.editGame(params.gameId, params.gameTitle, params.gameLogo, params.gamePrice, params.gameDescription, params.releaseDate, params.platformId, categories, removeCat)
		}
		redirect(action:"gameProfile", params:[gameTitle:params.gameTitle])
	}
	
	def deleteGame(){
		def currentCategory = params.categoryName
		gameService.deleteGame(params.gameTitle, params.categoryName)
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
>>>>>>> c640b3876a7f1109827955baa6179cefdf40f507
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
  

    
}
