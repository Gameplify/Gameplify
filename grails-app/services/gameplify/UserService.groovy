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
    def serviceMethod() {

    }
}
