package gameplify

class User {
	// properties
	String emailAddress
	String name
	String username
	String password
	String confirm
	String role
	String userPhoto
	static hasMany = [reviews:Review, comment:Comment]
	// transients
	static transients = ['confirm']
	
	static mapping ={
		userPhoto	defaultValue:"'nan.jpg'"
	}
	
    static constraints = {
        name 			blank:false, size:5..50
        emailAddress  	blank:false, email:true, unique:true, size:5..50
        username  		blank:false, size:5..50, matches:/[\S]+/, unique:true
        password  		blank:false, size:5..50, matches:/[\S]+/
		userPhoto		nullable:true
		
	}
}