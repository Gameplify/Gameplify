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
		def activities = AdminActivity.where{ admin == admin }.list(sort: 'date', order: 'desc')
		log.println("ni sud sa service")
		log.println(admin.adminActivity)
		return activities
	}
	def listAdmins(){
		def admins = User.where{ role == "Admin" }.list()
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

	def listReports(max, offset){
		def reports
		reports = Report.where {
			  status == "okay"  
			  }.list(max: max, sort:'date' ,order:"desc", offset: offset)
		return reports
	}

	def listBlocked(max, offset){
		def blocked
		blocked = Report.where { status == "blocked" }.list(max: max, offset: offset){
		}.sort{ it.date }.reverse(true)
		return blocked
	}

	def blockUser(userId,reportId, adminId){
		User user = User.get(userId)
		user.status = "blocked"
		Report report = Report.get(reportId)
		report.status = "blocked"
		report.date = new Date()
		report.save(flush:true)
		user.save(flush:true)
		addAdminActivity(adminId,"Blocked " +user.username)
	}

	def unblockUser(userId,reportId, adminId){
		User user = User.get(userId)
		user.status = "okay"
		Report report = Report.get(reportId)
		report.status = "managed"
		report.save(flush:true)
		user.save(flush:true)
		addAdminActivity(adminId,"Unblocked " +user.username)
	}

	def ignoreReport(reportId, adminId){
		Report report = Report.get(reportId)
		report.status = "ignored"
		report.save(flush:true)
		addAdminActivity(adminId,"Ignored report #" +reportId)
	}

	def addAdminActivity(adminId, activity){
		User admin = User.get(adminId)
		Date date = new Date()
		AdminActivity aa = new AdminActivity(
				admin:admin,
				date:date,
				action:activity
				)
		if(aa.save()){
			log.println("it fucking worked")
		}
		admin.addToAdminActivity(aa)
		admin.save(flush:true)
	}
}
