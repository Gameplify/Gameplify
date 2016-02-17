
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



	<div class="svg-wrapper">

		<div class="ui two column stackable grid">
			<div class="row" style="margin-left: 0px;">
				<div class="ui segment" style="width: 800px; height: auto">
					<div class="ui three column stackable grid">
						<div class="column" style="    width: 98.333333%;">
						<g:if test="${flash.reg}">
									<script>alert("You have successfully registered!")</script>
								</g:if>
							<div class="ui grid" style="float: right;margin-top: 0px;">
								<g:each in="${platform }" var="plat">
									<g:link action="platform"
										params="${[ platform:plat.platformName, paginates:'Foo', paginate:'Bar']}">
										<button class="ui icon button">
											<img class="platformpic"
												src="${resource(dir: 'images', file: "${plat.pic}")}">
										</button>
									</g:link>
								</g:each>
							</div>
							
						</div>
					</div>
					<div class="ui two column stackable grid">
						<div class="column" style="width: 378px;">
							<div class="ui segment"
								style="width: 392px;height: 558px; padding-left: 30px;">

								<div class="ui three column stackable grid" style="height:391px;">
									<div class="rows" style="width: 325px;">
										<div class="column" style="width: 378px;">
											<h3>What's HOT</h3>
										</div>
										
										<g:each in="${fooList}" status="i" var="game">
										<g:if test="${game.averageRating >0}">
										<g:if test="${(i)<3}">
										<g:link action="gameProfile"
												params="${[gameTitle: "${game.gameTitle}"]}">

												<div class="ui segment"
													style="height: auto; width: 339px; padding-top: 14px; margin-top: 14px; margin-bottom: 14px;">
													<a class="ui red right ribbon label 1" style="left: 253px;">
														${game.averageRating }
													</a>
													<g:link action="gameProfile"
														params="${[gameTitle: "${game.gameTitle}"]}">
														<img class="ui tiny left floated image"
															style="top: 27px;"
															src="${resource(dir: 'images', file: "${game.gameLogo}")}">
													</g:link>
													<g:link action="gameProfile"
														params="${[gameTitle: "${game.gameTitle}"]}">
														<h5
															style="padding-left: 10px; margin-top: 0px; margin-bottom: 0px;">
															${game.gameTitle }
														</h5>
													</g:link>
													<g:link action="gameProfile"
														params="${[gameTitle: "${game.gameTitle}"]}">
														<div class="row"
															style="padding-bottom: 13px; padding-top: 5px; border-top-width: 5px; margin-top: 0px;margin-left: 82px;height: 84px;">
															<g:each var="category" in="${game.categories}">
																<a style="margin-bottom: 5px; margin-left: 7px;"> ${category.categoryName }</a>
															</g:each>
														</div>
													</g:link>
												</div>

											</g:link>
											</g:if>
											</g:if>
										</g:each>

										</div>
									</div>
								</div>

											<div class="pagination" style="margin-right: 16px;text-align: center;margin-top: 15px;">
												<g:if test="${totalFoos<=9}">
												<g:paginate total="${totalFoos}" max="3" offset="${session.fooPagination?.offset}"  params="${[chosenPlatform:"${chosenPlatform}",paginate:'Foo']}"/>
												</g:if>
												<g:else>
												<g:paginate total="9" max="3" offset="${session.fooPagination?.offset}"  params="${[chosenPlatform:"${chosenPlatform}",paginate:'Foo']}"/>
												</g:else>
											</div>
						</div>
						
						
						
						<div class="column" style="width: 378px;">
							<div class="ui segment"
								style=" width: 392px;height: 558px; padding-left: 30px;">

								<div class="ui three column stackable grid">
								
									<div class="rows" style="height: 391px; width: 325px;">
															
						<div class="column" style="width: 140px;">
							<h3>What's NEW</h3>
						</div>
										<g:each in="${barList}" status="i" var="games">
										<g:if test="${(i)<3}">
											<g:link action="gameProfile"
												params="${[gameTitle: "${games.gameTitle}"]}">

												<div class="ui segment"
													style="height: auto; width: 339px; padding-top: 14px; margin-top: 14px; margin-bottom: 14px;">
													<a class="ui red right ribbon label 1" style="left: 253px;">
														${games.averageRating }
													</a>
													<g:link action="gameProfile"
														params="${[gameTitle: "${games.gameTitle}"]}">
														<img class="ui tiny left floated image"
														style="top:27px;"
															src="${resource(dir: 'images', file: "${games.gameLogo}")}">
													</g:link>
													<g:link action="gameProfile"
														params="${[gameTitle: "${games.gameTitle}"]}">
														<h5
															style="padding-left: 10px; margin-top: 0px; margin-bottom: 0px;">
															${games.gameTitle }
														</h5>
													</g:link>
													<g:link action="gameProfile"
														params="${[gameTitle: "${games.gameTitle}"]}">
														<div class="row"
															style="padding-bottom: 13px; padding-top: 5px; border-top-width: 5px; margin-top: 0px;margin-left: 82px;height: 84px;">
															<g:each var="category" in="${games.categories}">
																<a style="margin-bottom: 5px; margin-left: 7px;"> ${category.categoryName }</a>
															</g:each>
														</div>
													</g:link>
												</div>

											</g:link>
											</g:if>
										</g:each>
										
									</div>
									</div>
									</div>
											<div class="pagination" style="margin-right: 16px;text-align: center;margin-top: 15px;">
											<g:if test="${totalBars<=9}">
											  <g:paginate total="${totalBars}" max="3" offset="${session.barPagination?.offset}" params="${[chosenPlatform:"${chosenPlatform}",paginate:'Bar']}"/>
											</g:if>
											<g:else>
											<g:paginate total="9" max="3" offset="${session.barPagination?.offset}" params="${[chosenPlatform:"${chosenPlatform}",paginate:'Bar']}"/>
											</g:else>
											
											</div>

								

							
						</div>

					</div>
				<div class="ui two row stackable grid">
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
										<g:textField name="emailAddress" required="" maxlength="50"/>
									</div>

									<div class="field">
										<label for="username">User name</label>
										<g:textField name="username" required="" minlength= "5" maxlength="50"/>
									</div>

									<div class="field">
										<label for="password">Password</label>
										<g:field type="password" required="" name="password" minlength= "5" maxlength="50" />
									</div>

									<div class="field">
										<label for="confirm">Confirm Password</label>
										<g:field type="password" required="" name="confirm" maxlength="50" />
									</div>
									<g:submitButton class="ui fluid large blue submit button"
										name="submitButton" value="Register" />
								</g:form>
								
								
								
							</div>
						</div>
					</div>
				</div>
			</div>
		
</body>
</html>
