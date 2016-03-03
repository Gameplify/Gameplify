package gameplify
class UserController {
	def userService
	def gameService
	private static final okcontents = ['image/png', 'image/jpeg', 'image/gif']
	def index={ redirect(action:"login") }

	def userProfile(){
		def user = userService.findUser(params.userId)
		log.println(params.userId)
		if (user.role == "Admin"){
			redirect(action:"adminProfile" ,params:[adminId:params.userId])
		}
		[user:user]
	}

def avatar_image() {
			def avatarUser = User.get(params.id)
			if (!avatarUser || !avatarUser.avatar || !avatarUser.avatarType) {
			  response.sendError(404)
			  return
			}
			response.contentType = avatarUser.avatarType
			response.contentLength = avatarUser.avatar.size()
			OutputStream out = response.outputStream
			out.write(avatarUser.avatar)
			out.close()
		  }
		
		def upload_avatar() {
			def f = request.getFile('avatar') 		
			if (!okcontents.contains(f.getContentType())) {
			  flash.message = "Avatar must be one of: ${okcontents}"
			  redirect(uri: request.getHeader('referer') )
			  return
			}
		  
			
			if(!userService.uploadAvatar(session.user.id, f)){
			flash.message = "Image too big"
			  redirect(uri: request.getHeader('referer') )
			  return
		}
			
			redirect(uri: request.getHeader('referer') )
		  }

	def getUserRating(){
		def rating = userService.getUserRating(params.gameId, params.userId)
		[rating:rating]
	}
	def adminActivities(){
		def activities = userService.getAdminActivity(params.adminId)
		render(template: 'adminActivities', model:[activities:activities])
	}




	def showUserAuthentication(){
		render(template: '../userAuthentication')
	}
	
	def registerTemplate(){
		render(template: '../registerTemplate')
	}

	
	def register = {
		int count=0
		// new user posts his registration details
		if (request.method == 'POST') {

			
			if(params.name =~ ".*\\d+.*"){
				flash.integer= "Name must contain alpha characters only."
				count=1
			}
			 if(params.emailAddress!=~ "^[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}\$."){
				 flash.emailInv="Email Address is invalid."
				 count=1
				 
			 }
			
			
			
			User user1 = User.find{emailAddress==params.emailAddress}
			if (user1) {
				flash.email = "Email Address already exists."
				count=1
			}
			
			User user = User.find{username==params.username}
			if (user) {
				flash.username = "Username already exists."
				count=1
			}
		
		
			// create domain object and assign parameters using data binding
			def u = new User(params)
			u.role="User"
			if (params.password != params.confirm) {
				flash.message = "Password mismatch."
				count=1
			}
			flash.cnt= count
			if(count){
			redirect(action:'register')
			}else{
			u.password=params.password.encodeAsPassword()
			u.status = "okay"
			if (! u.save()) {
				// validation failed, render registration page again
				return [user:u]
			} else {
				// validate/save ok, store user in session, redirect to homepage
				session.user = u
				flash.reg= "You have successfully registered."
				u.errors.allErrors.each {log.error it.defaultMessage}
				redirect(controller:"game", action: "index")


			}
			}
		} else if (session.user) {
			// don't allow registration while user is logged in
			log.error "There was an error in registration process. Please try again later."
			u.errors.allErrors.each {log.error it.defaultMessage}
			redirect(controller:"game", action: "index")
		}
	}

	def login = {
		if (request.method == 'POST') {
			User user = User.find{username==params.username}
			if (!user) {
				flash.message = "Username does not exist."
				redirect(uri: request.getHeader('referer') )
				return
			}
			User us = User.find{
				username==params.username &&
						password== params.password.encodeAsPassword()
			}
			//user = User.findByUsernameAndPasswordHashed(params.username, passwordHashed)
			if (!us) {
				flash.message = "Invalid input."
				redirect(uri: request.getHeader('referer') )
				return
			}


			session.user = user
			if(session.user.role == "Admin"){
				redirect(controller: 'game', action:'index')
			} else {
				redirect(uri: request.getHeader('referer') )
			}
		}
	}



	def adminProfile(){
		if((!(session.user))||session?.user?.role != "Admin"){
			flash.message = "You do not have permission to access this page"
			redirect(controller:"game", action: "index")
		} else {
			def admin = userService.findUser(params.adminId)			
			def admins = userService.listAdmins()
			[admin:admin, admins:admins]
		}
	}

	def logout = {
		session.invalidate()
		redirect(controller: "game", action:"index" )
	}

	def userManagementReports(){
		if((!(session.user))||session?.user?.role != "Admin"){
			flash.message = "You do not have permission to access this page"
			redirect(controller:"game", action: "index")
		} else {
			def max = params.max ?: 10
			def offset = params.offset ?: 0
			def reports = userService.listReports(max, offset)
			log.println(reports.user.id)
			if(reports){
				[reports:reports, reportCount:reports.totalCount]
			}else{
				flash.error = "No results found"
				[reportCount:0]
			}
		}
	}

	def userManagementBlocked(){
		if((!(session.user))||session?.user?.role != "Admin"){
			flash.message = "You do not have permission to access this page"
			redirect(controller:"game", action: "index")
		} else {
			def max = params.max ?: 10
			def offset = params.offset ?: 0
			def blocked = userService.listBlocked(max, offset)
			if(blocked){
				log.println("bogo")
				[block:blocked, blockedCount:blocked.totalCount]
			}else{
				flash.error = "No results found"
				[blockedCount:0]
			}
		}
	}

	def showUserInfo(){
		def user = userService.findUser(params.userId)
		def report = Report.get(params.reportId)
		render(template: "userInfo", model:[user:user, type:params.type, report:report])
	}

	def reportUser(){

	}
	def blockUser(){
		userService.blockUser(params.userId, params.reportId, session.user.id)
		def user = User.get(params.userId)
		flash.success = "You have blocked "+user.name+"!"
		redirect(action:"userManagementReports")
	}

	def ignoreReport(){
		userService.ignoreReport(params.reportId, session.user.id)
		flash.success="Report ignored successfully"
		redirect(action:"userManagementReports")
	}

	def unblockUser(){
		userService.unblockUser(params.userId, params.reportId, session.user.id)
		def user = User.get(params.userId)
		flash.success = "You have unblocked "+user.name+"!"
		redirect(action:"userManagementBlocked")
	}


}

