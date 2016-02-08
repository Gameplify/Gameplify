
<!DOCTYPE html>
<html>
<head>
<!-- Standard Meta -->
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0">

<!-- Site Properities -->
<title>Game List</title>

<link rel="stylesheet" type="text/css"
	href="${resource(dir:'dist', file:'bg.css')}">
<link rel="stylesheet" type="text/css"
	href="${resource(dir:'css', file:'semantic.css')}">
<link rel="stylesheet" type="text/css"
	href="${resource(dir:'dist', file:'semantic.css')}">
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
						<g:if test="${flash.reg}">${flash.reg}</g:if>
							<div class="ui grid" style="float: right">

								<g:each in="${platforms }" var="platform">
									<g:link action="index"
										params="${[ platform:platform.platformName] }">
										<button class="ui icon button">
											<img class="platformpic"
												src="${resource(dir: 'images', file: "${platform.pic}")}">
										</button>
									</g:link>
								</g:each>
							</div>
						</div>
					</div>
					<div class="ui two column stackable grid">
						<div class="column" style="width: 378px;">
							
							<div class="ui segment"
								style="overflow-x: hidden; overflow-y: auto; width: 392px; height: 436px; padding-left: 30px;">

								<div class="ui three column stackable grid" style="height:391px;">
									<div class="rows" style="width: 325px;">
									<div class="column" style="width: 378px;">
										<h3>What's HOT</h3>
									</div>
										<g:if test="${bool=='true' }">
										<g:each in="${games}" status="i" var="game">
										<g:if test="${(i)<3}" >
										<g:if test="${game.averageRating != 0 }">
											<g:link action="gameProfile"
												params="${[gameTitle: "${game.gameTitle}"]}">

												<div class="ui segment"
													style="height: 104px; width: 339px; padding-top: 14px; margin-top: 14px; margin-bottom: 14px;">
													<a class="ui red right ribbon label 1" style="left: 253px;">
														${game.averageRating }
													</a>
													<g:link action="gameProfile"
														params="${[gameTitle: "${game.gameTitle}"]}">
														<img class="ui tiny left floated image"
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
															style="padding-bottom: 13px; padding-top: 5px; border-top-width: 5px; margin-top: 0px; margin-left: 3px;">
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
										</g:if>
										<g:elseif test="${bool=='false' }">
											<g:set var="counter" value="${gameCount-3}" />
											<g:each in="${games}" status="i" var="game">
										<g:if test="${i>=counter}">
										<g:if test="${game.averageRating != 0 }">
											<g:link action="gameProfile"
												params="${[gameTitle: "${game.gameTitle}"]}">

												<div class="ui segment"
													style="height: 104px; width: 339px; padding-top: 14px; margin-top: 14px; margin-bottom: 14px;">
													<a class="ui red right ribbon label 1" style="left: 253px;">
														${game.averageRating }
													</a>
													<g:link action="gameProfile"
														params="${[gameTitle: "${game.gameTitle}"]}">
														<img class="ui tiny left floated image"
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
															style="padding-bottom: 13px; padding-top: 5px; border-top-width: 5px; margin-top: 0px; margin-left: 3px;">
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
										</g:elseif>
										<g:else>
										<g:each in="${games}" status="i" var="game">
										<g:if test="${(i)<3}" >
										<g:if test="${game.averageRating != 0 }">
											<g:link action="gameProfile"
												params="${[gameTitle: "${game.gameTitle}"]}">

												<div class="ui segment"
													style="height: 104px; width: 339px; padding-top: 14px; margin-top: 14px; margin-bottom: 14px;">
													<a class="ui red right ribbon label 1" style="left: 253px;">
														${game.averageRating }
													</a>
													<g:link action="gameProfile"
														params="${[gameTitle: "${game.gameTitle}"]}">
														<img class="ui tiny left floated image"
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
															style="padding-bottom: 13px; padding-top: 5px; border-top-width: 5px; margin-top: 0px; margin-left: 3px;">
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
											</g:else>
										 
									</div>
									</div>
									</div>

											<div class="pagination" style="margin-right: 16px;text-align: center;margin-top: 15px;">
												<g:link action="index" params="${[chosenPlatform:"${chosenPlatform}", bool:"true"]}">First</g:link>
												<g:paginate action="index" total="${gameCount}"  offset="0" max="3" params="${[chosenPlatform:"${chosenPlatform}", bool:"true"]}"/>
												<g:link action="index" params="${[chosenPlatform:"${chosenPlatform}", bool:"false"]}">Last</g:link>
											</div>


						</div>
						<div class="column" style="width: 378px;">
							<div class="ui segment"
								style="overflow-x: hidden; overflow-y: auto; width: 392px; height: 436px; padding-left: 30px;">

								<div class="ui three column stackable grid">
								
									<div class="rows" style="height: 391px; width: 325px;">
															
						<div class="column" style="width: 140px;">
							<h3>What's NEW</h3>
						</div>
										<g:if test="${bool=='true' }">
										<g:each in="${bb}" status="i" var="games">
										<g:if test="${(i)<3}">
											<g:link action="gameProfile"
												params="${[gameTitle: "${games.gameTitle}"]}">

												<div class="ui segment"
													style="height: 104px; width: 339px; padding-top: 14px; margin-top: 14px; margin-bottom: 14px;">
													<a class="ui red right ribbon label 1" style="left: 253px;">
														${games.averageRating }
													</a>
													<g:link action="gameProfile"
														params="${[gameTitle: "${games.gameTitle}"]}">
														<img class="ui tiny left floated image"
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
															style="padding-bottom: 13px; padding-top: 5px; border-top-width: 5px; margin-top: 0px; margin-left: 3px;">
															<g:each var="category" in="${games.categories}">
																<a style="margin-bottom: 5px; margin-left: 7px;"> ${category.categoryName }</a>
															</g:each>
														</div>
													</g:link>
												</div>

											</g:link>
											</g:if>
										</g:each>
										</g:if>
										<g:elseif test="${bool=='false' }">
											<g:set var="counter" value="${gameCont-3}" />
											<g:each in="${bb}" status="i" var="games">
											<g:if test="${i>=counter}">
											<g:link action="gameProfile"
												params="${[gameTitle: "${games.gameTitle}"]}">

												<div class="ui segment"
													style="height: 104px; width: 339px; padding-top: 14px; margin-top: 14px; margin-bottom: 14px;">
													<a class="ui red right ribbon label 1" style="left: 253px;">
														${games.averageRating }
													</a>
													<g:link action="gameProfile"
														params="${[gameTitle: "${games.gameTitle}"]}">
														<img class="ui tiny left floated image"
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
															style="padding-bottom: 13px; padding-top: 5px; border-top-width: 5px; margin-top: 0px; margin-left: 3px;">
															<g:each var="category" in="${games.categories}">
																<a style="margin-bottom: 5px; margin-left: 7px;"> ${category.categoryName }</a>
															</g:each>
														</div>
													</g:link>
												</div>

											</g:link>
											</g:if>
										</g:each>
										</g:elseif>
										<g:else>
										<g:each in="${bb}" status="i" var="games">
										<g:if test="${(i)<3}">
											<g:link action="gameProfile"
												params="${[gameTitle: "${games.gameTitle}"]}">

												<div class="ui segment"
													style="height: 104px; width: 339px; padding-top: 14px; margin-top: 14px; margin-bottom: 14px;">
													<a class="ui red right ribbon label 1" style="left: 253px;">
														${games.averageRating }
													</a>
													<g:link action="gameProfile"
														params="${[gameTitle: "${games.gameTitle}"]}">
														<img class="ui tiny left floated image"
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
															style="padding-bottom: 13px; padding-top: 5px; border-top-width: 5px; margin-top: 0px; margin-left: 3px;">
															<g:each var="category" in="${games.categories}">
																<a style="margin-bottom: 5px; margin-left: 7px;"> ${category.categoryName }</a>
															</g:each>
														</div>
													</g:link>
												</div>

											</g:link>
											</g:if>
										</g:each>
										</g:else>
										
										
									</div>
									</div>
									</div>
											<div class="pagination" style="margin-right: 16px;text-align: center;margin-top: 15px;">
												<g:link action="index" params="${[chosenPlatform:"${chosenPlatform}", bool:"true"]}">First</g:link>
												<g:paginate action="index" total="${gameCount}"  offset="0" max="3" params="${[chosenPlatform:"${chosenPlatform}", bool:"true"]}"/>
												<g:link action="index" params="${[chosenPlatform:"${chosenPlatform}", bool:"false"]}">Last</g:link>
											</div>

								

							
						</div>

					</div>
				</div>
				<g:include controller="user" action="showUserAuthentication" />

			</div>
</body>
</html>
