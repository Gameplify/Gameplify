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
	
	def gameProfile(){
		def game = gameService.listGameInfo(params.gameTitle)
		def reviews = gameService.listReview(params.gameTitle)
		[game:game, reviews:reviews]
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
  

    def show(Game gameInstance) {
        respond gameInstance
    }

    def create() {
        respond new Game(params)
    }

    @Transactional
    def save(Game gameInstance) {
        if (gameInstance == null) {
            notFound()
            return
        }

        if (gameInstance.hasErrors()) {
            respond gameInstance.errors, view:'create'
            return
        }

        gameInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'game.label', default: 'Game'), gameInstance.id])
                redirect gameInstance
            }
            '*' { respond gameInstance, [status: CREATED] }
        }
    }

    def edit(Game gameInstance) {
        respond gameInstance
    }

    @Transactional
    def update(Game gameInstance) {
        if (gameInstance == null) {
            notFound()
            return
        }

        if (gameInstance.hasErrors()) {
            respond gameInstance.errors, view:'edit'
            return
        }

        gameInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Game.label', default: 'Game'), gameInstance.id])
                redirect gameInstance
            }
            '*'{ respond gameInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Game gameInstance) {

        if (gameInstance == null) {
            notFound()
            return
        }

        gameInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Game.label', default: 'Game'), gameInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'game.label', default: 'Game'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
