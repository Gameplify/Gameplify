package gameplify

import grails.transaction.Transactional

@Transactional
class UserService {

	def findUser(userId){
		def user = User.get(userId)
		return user
	}
	
	def getAdminActivity(userId){
		def admin = findUser(userId)
		def activities = AdminActivity.where{
			admin == admin
		}.list()
		log.println("ni sud sa service")
		log.println(admin.adminActivity)
		return activities
	}
	def listAdmins(){
		def admins = User.where{
			role == "Admin"
		}.list()
		return admins
	}
	
	def getUserRating(gameId, userId){
		def game = Game.get(gameId)
		def user = User.get(userId)
		def rating = game.userRating(user)
	}
	

	def uploadAvatar(id,f){
		def user = User.get(id)
		user.avatar = f.bytes
		user.avatarType = f.contentType
		log.info("File uploaded: $user.avatarType")
		user.save(flush:true)	
	}
	
    def serviceMethod() {

    }
	
}
