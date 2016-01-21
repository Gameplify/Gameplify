<html>
<head>
<%@ page import="java.util.Calendar"%>
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
						</h3>
						<div class="ui grid"
							style="margin-left: 545px; margin-top: -50px;">
							<g:if test="${flash.message}">
								<div class="message" style="width: 200px; margin-left: -171px;">
									${flash.message }
								</div>
							</g:if>
							<div style="margin-top: 10px;">
								<button class="ui inverted icon button" id="addGame"
									style="height: 28px; margin-left: -55px; width: 28px; padding: 0;">
									<i class="big green add square icon"
										style="height: 28px; width: 28px;"></i>
								</button>
								<button class="ui inverted icon button" id="deleteGame"
									style="height: 28px; width: 28px; margin-left: -35px; padding: 0;">
									<i class="big red trash icon"
										style="height: 28px; width: 28px;"></i>
								</button>


								<div class="ui grid" style="margin-top: -45px;">
									<g:each in="${platforms }" var="platform">
										<g:link action="gameManagement"
											params="${[ platform:platform.platformName, categoryName: currentCategory] }">
											<button class="ui icon button">
												<img class="platformpic"
													src="${resource(dir: 'images', file: "${platform.pic}")}">
											</button>
										</g:link>
									</g:each>
								</div>
							</div>
						</div>
						</h3>
					</div>
					<g:if test="${gameCount > 0 }">
						<div id="updateThis" class="ui segment"
							style="width: 770px; height: auto;">


							<div class="ui cards"
								style="margin-bottom: 20px; margin-left: 50px; margin-right: 50px; margin-top: 20px;">
								<g:each in="${games}" status="i" var="game">
									<g:link action="gameProfile"
										params="${[gameTitle: "${game.gameTitle}"]}">
										<div class="ui segment"
											style="height: 120px; width: 270px; padding-top: 20px; margin-left: 40px; margin-top: 0px;">
											<img class="ui tiny left floated image"
												style="width: 70px; height: 70px;"
												src="${resource(dir: 'images', file: "${game.gameLogo}")}">
											<div class="ui 3 column stackable grid"
												style="margin-left: 62px; margin-bottom: 0px; margin-right: 0px; margin-top: 0px;">
												<h5 style="padding-left: 10px; margin-bottom: 0px;">
													${game.gameTitle }
													<br>$   ${game.gamePrice }
												</h5>
												<div class="row"
													style="padding-bottom: 13px; padding-top: 5px; border-top-width: 5px; margin-top: 0px; margin-left: 3px;">
													<g:each var="category" in="${game.categories}">
														<a style="margin-bottom: 5px; margin-left: 7px;"> ${category.categoryName }</a>


													</g:each>
												</div>
											</div>
										</div>

									</div>
								</g:link>
								<%--
								<g:form controller="game"action="deleteGame">
								<g:hiddenField name="gameTitle" value="${game.id}"/>
								<g:hiddenField name="categoryName" value="${currentCategory}"/>
								<g:hiddenField name="gameCategory" value="${game.categories}"/>
								<g:submitButton class class="ui icon button delete" id="delete"
										style="display: none; padding: 0; margin-top: 4px; margin-left: -267px;" value="" name=""></g:submitButton>
								</g:form>--%>
								<g:link action="deleteGame"
									params="${[gameTitle:"${game.id}",categoryName:currentCategory, gameCategory:"${game.categories}"] }"
									onclick="return confirm('Are you sure you want to ignore this report?')">
									<button class="ui icon button delete" id="delete"
										style="display: none; padding: 0; margin-top: 4px; margin-left: -267px;">
										<i class="small red delete icon"></i>
									</button>
								</g:link>
							</g:each>

						</div>
				</div>

				</g:if>
				<g:else>
					<div class="ui segment" style="width: 770px; height: auto;">
						<h5>No Results Found</h5>
					</div>
			</div>
			</g:else>

			<div class="ui two row stackable grid">
				<div class="column">
					<div class="row">

						<g:include controller="user" action="showUserAuthentication" />

					</div>
					<div class="segments">
						<div class="ui left aligned segment"
							style="margin-left: 40px; margin-top: 20px; height: 100%; width: 87%;">
							<div style="text-align: left;">
								<h3>Sort By:</h3>
							</div>
							<div id="sort">
								<div class="segment"
									style="border: 1px solid lightgray; margin-top: 10px; padding: 5px;">
									<p>
										<g:radio name="what" value="gameTitle" onClick="myFunc();"
											checked="true" />
										A-Z<br>
										<g:radio name="what" value="gamePrice" onClick="myFunc();" />
										Price<br>
										<g:radio name="what" value="averageRating" onClick="myFunc();" />
										Rating<br>
										<g:radio name="what" value="releaseDate" onClick="myFunc();" />
										Release Date<br>
									</p>
								</div>
								<div class="segment"
									style="border: 1px solid lightgray; margin-top: 10px; padding: 5px;">
									<g:radio name="how" value="asc" checked="true"
										onClick="myFunc();" />
									Ascending<br>
									<g:radio name="how" value="desc" onClick="myFunc();" />
									Descending<br>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>

	<div class="ui modal addGame">
		<i class="close icon"></i>
		<g:form class="ui equal width form" id="form" style="padding:10px"
			controller='game' action='addGame'>
			<img class="ui centered small image" id="image" src="#"
				alt="Game Logo">
			<g:field type="file" name="gameLogo" accept="image/*" required=""
				style="    margin: 10px;" />
			<div class="field">
				<g:hiddenField name="currentCategory" value="${currentCategory}" />
				<g:textField placeholder="Game Title*" name="gameTitle" required="" />
			</div>
			<div class="fields">
				<div class="field" style="width: 200px;">
					<label for="releaseDate">Released On*</label>
					<g:datePicker name="releaseDate" value="${new Date()}"
						precision="day"
						years="${Calendar.instance.get(Calendar.YEAR)..1950}" />
				</div>
				<div class="field">
					<label for="price">Price*</label>
					<g:field type="number" name="gamePrice" required=""
						style="font-size:14px;" />
				</div>
				<div class="field">
					<label for="platform">Platform</label>
					<g:select from="${platforms}" class="ui dropdown" name="platformId"
						optionKey="id" optionValue="platformName" />
				</div>
			</div>
			<div class="field">
				<g:textArea rows="3" name="gameDescription"
					placeholder="Description*" required="" />
			</div>
			<div class="field">
				<label for="category">Category(Select at least one)</label>
				<div class="ui grid">
					<g:each in="${categories}" status="i" var="cat">
						<div class="four wide column"
							style="padding: 0px; margin-left: 10px; margin-top: 12px;">
							<div class="ui checkbox">
								<g:checkBox name="category" value="${cat.id}" checked="false" />
								<label> ${cat.categoryName}
								</label>
							</div>
						</div>
					</g:each>
				</div>
			</div>
			<div class="actions" style="text-align: center; margin-top: 30px;">
				<g:submitButton class="ui button" name="addButton" value="Add Game"
					style="margin-left: -1.75em;"></g:submitButton>
			</div>
		</g:form>
	</div>
	<script>
		$(function() {
			$('#addGame').click(function() {
				$('.modal').modal('show');
			});
			document.getElementById("gameLogo").onchange = function() {
				var reader = new FileReader();
				reader.onload = function(e) {
					// get loaded data and render thumbnail.
					document.getElementById("image").src = e.target.result;
				};
				// read the image file as a data URL.
				reader.readAsDataURL(this.files[0]);
			};
			$('#deleteGame').click(function() {
				$('.ui.icon.button.delete').toggle();
			});
	<%--$('#form').on('submit', function (e) {			
		if (document.getElementsByName("category").length === 0) {
			e.preventDefault();
			alert('Select at least one category');
			return false;
		}
	});	--%>
		});

	
		function myFunc(){
			var categoryName = "${currentCategory}";
			var what = document.getElementsByName('what');
			var what_value;
			for(var i = 0; i < what.length; i++){
			    if(what[i].checked){
			    	what_value = what[i].value;
			    }
			}
			var what = document.getElementsByName('how');
			var how_value;
			for(var i = 0; i < how.length; i++){
			    if(how[i].checked){
			    	how_value = how[i].value;
			    }
			}
			console.log(categoryName)
			console.log(how_value)
			console.log(what_value)
			
${remoteFunction(controller: 'game', update: 'updateThis', action: 'sortList', params: '\'what=\' + what_value+ \'&how=\' +how_value+  \'&categoryName=\' + categoryName ')}
			};
	
	</script>
</body>
</html>