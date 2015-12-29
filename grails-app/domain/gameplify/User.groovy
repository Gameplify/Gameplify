package gameplify

class User {
	// properties
	String emailAddress
	String name
	String username
	String password
	String confirm
	String role
	byte[] avatar
	String avatarType
	int totalNumberOfReviews
	static hasMany = [reviews:Review, comment:Comment]
	// transients
	static transients = ['confirm']
	
	static mapping ={
		userPhoto	defaultValue:"'nan.jpg'"
		totalNumberOfReviews	defaultValue: "0"
	}
	
    static constraints = {
        name 			blank:false
        emailAddress  	blank:false, email:true, unique:true
        username  		blank:false, size:5..50, matches:/[\S]+/
        password  		blank:false, size:5..50, matches:/[\S]+/
		avatar(nullable:true, maxSize: 16384 /* 16K */)
		avatarType(nullable:true)
		
	}
	static searchable =true
}