
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
	href="${resource(dir:'css', file:'semantic.css')}">
<link rel="stylesheet" type="text/css"
	href="${resource(dir:'dist', file:'semantic.css')}">
<link rel="stylesheet" type="text/css"
	href="${resource(dir:'dist', file:'bg.css')}">
<script src="${resource(dir:'dist/components', file:'semantic.min.js')}"></script>

</head>
<body>
	<div class="ui fixed inverted menu">
		<g:include action="showNavbar" />
	</div>
	<div class="background blue-purple"></div>
	<div class="background green-blue"></div>



	<div class="svg-wrapper">

		<div class="ui two column stackable grid">
			<div class="row" style="margin-left: 0px;">
				<div class="ui segment" style="height: auto">
					<div class="ui grid" style="width: 800px; padding: 20px;">
						<h3 style="width: 770px; margin-bottom: 0px;">
							${currentCategory }
							<div class="ui grid" style="float: right">

								<g:each in="${platforms }" var="platform">
									<g:link action="listGame"
										params="${[ platform:platform.platformName, categoryName: currentCategory] }">
										<button class="ui icon button">
											<img class="platformpic"
												src="${resource(dir: 'images', file: "${platform.pic}")}">
										</button>
									</g:link>
								</g:each>
							</div>
						</h3>
					</div>
					<g:if test="${gameCount > 0 }">
						<div class="ui segment" style="width: 770px; height: auto;">

							<div class="ui cards"
								style="margin-bottom: 20px; margin-left: 50px; margin-right: 50px; margin-top: 20px;">

								<g:each in="${games}" status="i" var="game">
									<g:link action="gameProfile"
										params="${[gameTitle: "${game.gameTitle}"]}">

										<g:include controller="user" action="showUserAuthentication" />
							</div>
						</div>
				</div>

				<div class="pagination" style="text-align: center;">
					<g:paginate action="listGame" total="${gameCount}"
						params="${[chosenPlatform:"${chosenPlatform}", categoryName: currentCategory]}"></g:paginate>
				</div>
			</div>
		</div>
		</g:if>
		<g:else>
			<div class="ui segment" style="width: 770px; height: auto;">
				<h5>No Results Found</h5>
			</div>
		</g:else>
</body>
</html>
