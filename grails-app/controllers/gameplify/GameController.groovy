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
