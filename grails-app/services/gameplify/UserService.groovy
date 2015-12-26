package gameplify

import grails.transaction.Transactional

@Transactional
class UserService {

	def findUser(userId){
		def user = User.get(userId)
		return user
	}
	def listAdmins(){
		def admins = User.where{
			role == "Admin"
		}.list()
		return admins
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
