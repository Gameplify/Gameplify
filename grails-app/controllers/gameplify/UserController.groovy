package gameplify
class UserController {
		def index={
			redirect(action:"login")
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
			   if (! u.save()) {
				   // validation failed, render registration page again
				   return [user:u]
			   } else {
				   // validate/save ok, store user in session, redirect to homepage
				   session.user = u
				   log.error "You have successfully registered."
				   u.errors.allErrors.each {log.error it.defaultMessage}
				   redirect(controller:'user')
				  
				   
			   }
		   } else if (session.user) {
			   // don't allow registration while user is logged in
				   log.error "There was an error in registration process. Please try again later."
				   u.errors.allErrors.each {log.error it.defaultMessage}
		   		   redirect(controller:'user')
		   }
	   }
	
	   def login = {
		   if (request.method == 'POST') {
			   User user = User.find{username==params.username}
			   if (!user) {
				  flash.message = "Username does not exist."
				  redirect(action:'login')
				  return
			   }
			   User us = User.find{
				   	username==params.username &&
					password== params.password.encodeAsPassword() 
			   }
			   //user = User.findByUsernameAndPasswordHashed(params.username, passwordHashed)
			   if (!us) {
				  flash.message = "Invalid input."
				  redirect(action:'login')
				  return
			   }
			   
			   
			   if(user.role=="User"){
				   session.user = user
				   redirect( action:'login')
			   }else{
			   	   session.user = user
			   	   redirect( action:'admin')
			   }
		   }
	   }
	
	   def admin={
		   
	   }
	   
	   def logout = {
		   session.invalidate()
		   redirect(action:'login')
	   }
   }

