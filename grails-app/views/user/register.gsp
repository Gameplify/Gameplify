
<!DOCTYPE html>
<html>
<head>
<!-- Standard Meta -->
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0">

<!-- Site Properities -->
<title>Register</title>
<link rel="stylesheet" type="text/css"
	href="${resource(dir:'css', file:'semantic.css')}">
<link rel="stylesheet" type="text/css"
	href="${resource(dir:'dist', file:'semantic.css')}">
<link rel="stylesheet" type="text/css"
	href="${resource(dir:'dist', file:'bg.css')}">
<script src="${resource(dir:'dist/components', file:'semantic.min.js')}"></script>

</head>
<body>
	<div class="ui fixed inverted menu">
		<g:include controller="game" action="showNavbar" />
	</div>
	<div class="background blue-purple"></div>
	<div class="background green-blue"></div>





	
				
				
							<g:if test="${flash.reg}">
								<script>
									alert("You have successfully registered!")
								</script>
							</g:if>
						

			<div class="ui two row stackable grid" style="width:40%; margin-left:auto; margin-right:auto">
				<div class="column">
					<div class="row">

						<div id="register" class="registration">
							<h5 style="margin-left: 70px;">JOIN NOW</h5>
							<g:form class="ui tiny form" style="margin-bottom: 19px;"
								controller='user' action='register'>

								<g:if test="${flash.cnt>0}">
									<div class="errors">


										<div class="moreErr">
											<g:if test="${flash.message}">

												${flash.message}
											</g:if>
											<g:if test="${flash.username}">
												${flash.username }
											</g:if>
											<g:if test="${flash.email}">
												${flash.email }
											</g:if>
											<g:if test="${flash.integer}">
												${flash.integer}
											</g:if>
											<g:if test="${flash.user}">
												${flash.user}
											</g:if>

										</div>

									</div>
								</g:if>
								<div class="field">
									<label for="name">Name</label>
									<g:textField name="name" required="" maxlength="50" />
								</div>

								<div class="field">
									<label for="emailAddress">Email Address</label>
									<g:textField name="emailAddress" required="" maxlength="50" />
								</div>

								<div class="field">
									<label for="username">User name</label>
									<g:textField name="username" required="" minlength="5"
										maxlength="50" />
								</div>

								<div class="field">
									<label for="password">Password</label>
									<g:field type="password" required="" name="password"
										minlength="5" maxlength="50" />
								</div>

								<div class="field">
									<label for="confirm">Confirm Password</label>
									<g:field type="password" required="" name="confirm"
										maxlength="50" />
								</div>
								<g:submitButton class="ui fluid large blue submit button"
									name="submitButton" value="Register" />
							</g:form>



						</div>
					</div>
				</div>
			</div>
	
</body>
</html>
