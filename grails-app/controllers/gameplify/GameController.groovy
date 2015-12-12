package gameplify



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class GameController {

	def gameService
	def gameCategoryService
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
		def game = gameService.listGameInfo(params.gameTitle)
		def reviews = gameService.listReview(params.gameTitle)
		def comments= gameService.listComment(params.gameTitle, params.reviewId)
		[game:game, reviews:reviews, comments:comments]
	}
	
	def addGame(){
		def checkedCategory = params.list('category')
		def categories = GameCategory.getAll(checkedCategory)
		log.println(params.platformId)
		gameService.addGame(params.gameTitle, params.gameLogo, params.gamePrice, params.gameDescription, params.releaseDate, params.platformId, categories)	
		redirect(action:"gameManagement", params:[categoryName:params.currentCategory])	
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
		}
		else{
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
  

    
}
