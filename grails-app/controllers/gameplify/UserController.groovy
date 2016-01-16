package gameplify
class UserController {
	def userService
	private static final okcontents = [
		'image/png',
		'image/jpeg',
		'image/gif'
	]
	def index={ redirect(action:"login") }

	def userProfile(){
		def user = userService.findUser(params.userId)
		if (user.role == "Admin"){
			redirect(action:"adminProfile" ,parameters:[admin:user])
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

		print "wew"

		def f = request.getFile('avatar')

		if(f){
			print "yow"
		} else {
			print "you fail fucker"
		}


		if (!okcontents.contains(f.getContentType())) {
			flash.message = "Avatar must be one of: ${okcontents}"
			redirect(uri: request.getHeader('referer') )
			return
		}


		if(!userService.uploadAvatar(session.user.id, f)){
			render(view:'select_avatar', model:[user:user])
			print "too big"
			return
		}

		redirect(uri: request.getHeader('referer') )
	}

	def adminProfile(){
		def admin = params.admin
		def admins = userService.listAdmins()
		[admin:admin, admins:admins]
	}

	def showUserAuthentication(){
		render(template: '../userAuthentication')
	}

	def register = {

		// new user posts his registration details
		if (request.method == 'POST') {

			// create domain object and assign parameters using data binding
			def u = new User(params)
			u.role="User"
			if (params.password != params.confirm) {
				flash.message = "Password mismatch."
				redirect(action:'register')
			}

			u.password=params.password.encodeAsPassword()
			u.status = "okay"
			if (! u.save()) {
				// validation failed, render registration page again
				return [user:u]
			} else {
				// validate/save ok, store user in session, redirect to homepage
				session.user = u
				log.error "You have successfully registered."
				u.errors.allErrors.each {log.error it.defaultMessage}
				redirect(controller:"game", action: "index")


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
			redirect(uri: request.getHeader('referer') )
		}
	}

	def admin={

	}

	def logout = {
		session.invalidate()
		redirect(uri: request.getHeader('referer') )
	}

	def userManagement_reports(){
		if((!(session.user))||session?.user?.role != "Admin"){
			flash.message = "You do not have permission to access this page"
			redirect(controller:"game", action: "index")
		} else {
			def max = params.max ?: 3
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

	def userManagement_blocked(){
		if((!(session.user))||session?.user?.role != "Admin"){
			flash.message = "You do not have permission to access this page"
			redirect(controller:"game", action: "index")
		} else {
			def max = params.max ?: 3
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
		render(template: "userInfo", model:[user:user, type:params.type, report:params.reportId])
	}
	
	def reportUser(){
		
	}
	def blockUser(){
		userService.blockUser(params.userId, params.reportId)
		redirect(action:"userManagement_reports")
	}
	
	def ignoreReport(){
		userService.ignoreReport(params.reportId)
		redirect(action:"userManagement_reports")
	}
	
	def unblockUser(){
		userService.unblockUser(params.userId, params.reportId)
		redirect(action:"userManagement_blocked")
	}
}

