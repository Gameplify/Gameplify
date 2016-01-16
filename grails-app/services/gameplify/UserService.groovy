package gameplify

import grails.transaction.Transactional

@Transactional
class UserService {

	def findUser(userId){
		def user = User.get(userId)
		return user
	}
	def listAdmins(){
		def admins = User.where{ role == "Admin" }.list()
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

	def listReports(max, offset){
		def reports
		reports = Report.where {
			status == "okay"
		}.list(max: max, offset: offset){
		}.sort{
			it.date
		}.reverse(true)		
	}

	def listBlocked(max, offset){
		def blocked
		blocked = Report.where {
			status == "blocked"
		}.list(max: max, offset: offset){
		}.sort{
			it.date
		}.reverse(true)
	}
	
	def blockUser(userId,reportId){
		User user = User.get(userId)
		user.status = "blocked"
		Report report = Report.get(reportId)
		report.status = "blocked"
		report.save(flush:true)
		user.save(flush:true)
	}
	
	def unblockUser(userId,reportId){
		User user = User.get(userId)
		user.status = "okay"
		Report report = Report.get(reportId)
		report.status = "managed"
		report.save(flush:true)
		user.save(flush:true)
	}
	
	def ignoreReport(reportId){
		Report report = Report.get(reportId)
		report.status = "ignored"
		report.save(flush:true)
	}
	
}
