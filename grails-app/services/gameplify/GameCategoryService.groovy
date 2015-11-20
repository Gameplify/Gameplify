package gameplify

import grails.transaction.Transactional

@Transactional
class GameCategoryService {
	def listGame(){
		def categories = GameCategory.list()
		return categories
	}
    def serviceMethod() {

    }
}
