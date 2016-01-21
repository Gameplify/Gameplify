
<!DOCTYPE html>
<html>
<head>
<!-- Standard Meta -->
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0">

<!-- Site Properities -->
<title>User Profile</title>
<link rel="stylesheet" type="text/css"
	href="${resource(dir:'css', file:'semantic.css')}">
<link rel="stylesheet" type="text/css"
	href="${resource(dir:'dist', file:'bg.css')}">
<link rel="stylesheet" type="text/css"
	href="${resource(dir:'dist', file:'semantic.css')}">
<script src="${resource(dir:'dist', file:'semantic.min.js')}"></script>
<script src="${resource(dir:'dist', file:'jquery-2.1.4.min.js')}"></script>

<style>
.image-upload>input {
	display: none;
}

.image-upload img {
	width: 80px;
	cursor: pointer;
}
</style>



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
				<div class="ui segment"
					style="height: 500px; overflow-x: disabled; overflow-y: auto;">
					<div class="ui grid" style="width: 800px; padding: 20px;">
						<h3>Reviews</h3>
					</div>
					<g:each in="${user.reviews}" status="i" var="review">
						
							<div class="ui segment"
								style="width: 770px; height: auto; margin-top: 10px">
								<div>
									<a class="ui red ribbon label"> ${review.game.averageRating}
									</a>
								</div>
								<g:link controller="game" action="gameProfile"
								params="${[gameTitle:"${review.game.gameTitle}"] }">
								<div class="ui grid">
									<div class="one wide column"></div>

									<div class="three wide column">
										<img class="ui centered image"
											src="${resource(dir: 'images', file: "$review.game.gameLogo")}">

									</div>

									<div class="eleven wide column" style="position: relative;">
										<h3>
											<div>
												${review.game.gameTitle}

											</div>
										</h3>
										<span> ${review.review }
										</span> <span style="bottom: 0; right: 0; position: absolute;"><g:formatDate
												format="MM-dd-yyyy" date="${review.date}" /></span>
									</div>





								</div>
							</div>
						</g:link>
					</g:each>
				</div>
				<div class="ui two row stackable grid">
					<div class="column">
						<div class="row">
							<g:include controller="user" action="showUserAuthentication" />
						</div>
						<div class="ui segment"
							style="margin-left: 40px; margin-top: 20px; height: 344px; width: 272px;">
							<div class="column">
								<div style="position: relative">
									<g:if test="${user.avatar }">
										<img style="height: 170px; width: 170px; margin: 35px; border:1px solid lightgray;"
											class="ui image"
											src="${createLink(controller:'user', action:'avatar_image', id:"${user.id}" )}" />
									</g:if>
									<g:else>
										<img class="photo" style="border:1px solid lightgray;"
											src="${resource(dir: 'images', file: "nan.jpg")}">
									</g:else>


									<div style="position: absolute; bottom: 0; right: 0">
										<g:if test="${session?.user?.id == user.id}">
											<g:uploadForm action="upload_avatar">
												<div class="image-upload">
													<label for="file-input"> <img
														style="height: 30px; width: 30px"
														src="${resource(dir: 'images', file: 'upload.png')}" />
													</label> <input id="file-input" name="avatar" id="avatar"
														type="file" />
												</div>
												<input type="submit" id="Up" style="display: none;" />
											</g:uploadForm>
										</g:if>
									</div>
								</div>
								<div class="center aligned column">
									<h4 style="text-align: center">
										${user.username }
									</h4>
									<div style="text-align: center !important;">
										${user.totalNumberOfReviews }
										Reviews
									</div>

								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script type="text/javascript">
			$("#file-input").change(function() {
				$("#Up").click();
			});
		</script>
</body>
</html>
