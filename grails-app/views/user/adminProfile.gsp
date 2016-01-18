
<!DOCTYPE html>
<html>
<head>
<!-- Standard Meta -->
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0">

<!-- Site Properities -->
<title>Admin Profile</title>
<link rel="stylesheet" type="text/css"
	href="${resource(dir:'dist', file:'bg.css')}">
<link rel="stylesheet" type="text/css"
	href="${resource(dir:'css', file:'semantic.css')}">
<link rel="stylesheet" type="text/css"
	href="${resource(dir:'dist', file:'semantic.css')}">
<script src="${resource(dir:'dist', file:'semantic.min.js')}"></script>
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
				<div class="ui segment" style="height: auto">
					<div class="ui grid" style="width: 800px; padding: 20px;">
						<h3>Activities</h3>
						<div id="activityList" style="height: 600px; overflow-x: hidden; overflow-y: auto;">
							<g:render template="adminActivities" />
						</div>
					</div>

				</div>
				<div class="ui two row stackable grid">
					<div class="column">
						<div class="row">

							<div class="ui two row stackable grid">
								<div class="column">
									<div class="row">
										<div class="useraccount">
											<g:link controller="user" action="userProfile"
												params="${[userId:"${session?.user?.id}"]}">
												<g:if test="${session?.user?.avatar}">
													<img class="ui tiny left floated image"
														src="${createLink(controller:'user', action:'avatar_image', id:"${session?.user?.id}" )}" />
												</g:if>
												<g:else>
													<img class="ui tiny left floated image"
														src="${resource(dir: 'images', file: "nan.jpg")}">
												</g:else>
												<span>
													${session?.user?.name}
												</span>
												<g:uploadForm style="position:absolute; bottom:0; left:0"
													action="upload_avatar">
													<div class="image-upload">
														<label for="file-input"> <img
															style="height: 30px; width: 30px"
															src="${resource(dir: 'images', file: 'upload.png')}" />
														</label> <input id="file-input" name="avatar" id="avatar"
															type="file" />
													</div>
													<input type="submit" id="Up" style="display: none;" />
												</g:uploadForm>

												<g:link class="ui primary button"
													style=" margin-top: 10px; margin-right: 0px; width: 140px;"
													controller="user" action="logout">Logout</g:link>
											</g:link>
										</div>
									</div>
								</div>
							</div>

						</div>
						<div class="ui segment"
							style="margin-left: 40px; margin-top: 20px; height: 344px; width: 272px;">
							<div class="column">
								<h3>Admins</h3>
								<g:each in="${admins}" status="i" var="admin">
									<g:remoteLink url="[controller:'user', action:'adminActivities']"
										update="activityList" 
										params="${[adminId:"${admin.id}"]}" >
										<div class="ui segment" style="height: 80px;">
											<g:if test="${admin.avatar }">
												<img class="ui tiny left floated image"
													src="${createLink(controller:'user', action:'avatar_image', id:"${admin.id}" )}" />
											</g:if>
											<g:else>
												<img class="ui tiny left floated image"
													src="${resource(dir: 'images', file: "nan.jpg")}">
											</g:else>

											<span style="text-align: center"> ${admin.name }
											</span>
										</div>
									</g:remoteLink>
								</g:each>
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
