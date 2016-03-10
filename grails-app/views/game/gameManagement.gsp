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
							<div style="margin-top: 10px;">
								<button class="ui inverted icon button" id="addGame" name="addB"
									style="height: 28px; margin-left: -55px; width: 28px; padding: 0;">
									<i class="big green add square icon"
										style="height: 28px; width: 28px;"></i>
								</button>
								<button class="ui inverted icon button" id="deleteGame" name="deleteB"
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
						<div class="ui segment" id="updateThis"
							style="width: 770px; height: auto;">
							<div class="ui cards"
								style="margin-bottom: 20px; margin-left: 50px; margin-right: 50px; margin-top: 20px;">
								<g:each in="${games}" status="i" var="game">
									<g:link class="author" action="gameProfile"
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
												</h5>
												<div class="row"
													style="padding-bottom: 13px; padding-top: 5px; border-top-width: 5px; margin-top: 0px; margin-left: 3px;">
													<g:each var="category" in="${game.categories}">
														<a style="margin-bottom: 5px; margin-left: 3px;"> ${category.categoryName }</a>

													</g:each>
												</div>
											</div>
										</div>
									</g:link>
									<g:link action="deleteGame"
										params="${[gameTitle:"${game.id}",categoryName:currentCategory, gameCategory:"${game.categories}"] }"
										onclick="return confirm('Are you sure you want to delete this game?')">
										<button class="ui icon button delete" id="delete" name="xB"
											style="display: none; padding: 0; margin-top: 4px; margin-left: -267px;">
											<i class="small red delete icon"></i>
										</button>
									</g:link>
								</g:each>
							</div>
							<div class="pagination" style="text-align: center;">
								<g:paginate action="gameManagement" total="${gameCount}"
									params="${[chosenPlatform:"${chosenPlatform}", categoryName: currentCategory]}"></g:paginate>
							</div>
						</div>
					</g:if>
					<g:else>
						<div class="ui segment" style="width: 770px; height: auto;">
							<h5>No Results Found</h5>
						</div>
					</g:else>
				</div>
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
			controller='game' action='addGame' onsubmit="return check()">
			<img class="ui centered small image" id="image" src="#"
				alt="Game Logo">
			<g:field type="file" class="superMegaClass" name="gameLogo"
				id="gameLogo" accept="image/jpeg, image/png, im8age/jpg" required=""
				style="    margin: 10px;" />
			<div class="field">
				<g:hiddenField name="currentCategory" value="${currentCategory}" />
				<g:textField placeholder="Game Title*" id="gameTitle"
					name="gameTitle" required="" />
			</div>
			<div class="fields">
				<div class="field" style="width: 200px;">
					<label for="releaseDate">Released On*</label> <input type="date"
						id="datePicker" value="" oninput="assDate();" required />
					<g:hiddenField name="releaseDate" id="releaseDate" />
					<%--<g:datePicker name="releaseDate" value="${new Date()}"
						precision="day"
						years="${Calendar.instance.get(Calendar.YEAR)..1950}" />--%>
				</div>
				<div class="field">
					<label for="price">Price*</label>
					<g:field type="number" name="gamePrice" min="0" step=".01" required=""
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
					placeholder="Description*" id="gameDesc" required="" />
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
			<div class="field" style="margin-top: 20px;">
				<label for="screenshot">Screenshot(s)</label>
				<g:field type="file" name="screenshots" class="superMegaClass"
					accept="image/jpeg, image/png, image/jpg" required=""
					multiple="multiple" style="margin: 10px;" />
			</div>
			<div class="actions" style="text-align: center; margin-top: 30px;">
				<g:submitButton class="ui button" name="addButton" id="addButton"
					value="Add Game" style="margin-left: -1.75em;" disabled="true"></g:submitButton>
			</div>
		</g:form>
	</div>
	<g:if test="${flash.message}">
		<div class="ui small modal">
			<div class="ui negative message">

				<div class="header">
					${flash.message }
				</div>
			</div>
		</div>
	</g:if>
	<g:if test="${flash.success}">
		<div class="ui small modal">
			<div class="ui positive message">

				<div class="header">
					${flash.success }
				</div>
			</div>
		</div>
	</g:if>
	<script>
		$(function() {
			$('#addGame').click(function() {
				$('.modal.addGame').modal('show');
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

			$("#gameTitle").keyup(function(){
				
				var reviewLength = $("#gameDesc").val().trim().length;
				var reviewTitleLength= $("#gameTitle").val().trim().length;
				if(reviewTitleLength>0){
			        if ($.trim($('#gameTitle').val()) == "" && reviewLength <=0 ) {
						document.getElementById("addButton").disabled = true;
					}else if(reviewLength <=0 ) {
						document.getElementById("addButton").disabled = true;
					}else{
						document.getElementById("addButton").disabled = false;
					}
				} else {
					document.getElementById("addButton").disabled = true;
				}
			});
			
			$("#gameDesc").keyup(function(){

				var reviewLength = $("#gameTitle").val().trim().length;
				var reviewDescLength = $("#gameDesc").val().trim().length;
				if(reviewDescLength>0){
			        if ($.trim($('#gameDesc').val()) == "" ) {
						document.getElementById("addButton").disabled = true;
					}else if (reviewLength <= 0) {
						document.getElementById("addButton").disabled = true;
					}else{
						document.getElementById("addButton").disabled = false;
					}
				} else{
					document.getElementById("addButton").disabled = true;
				}
			});

			$('.ui.small.modal').modal('show');
		});

		function check() {
			var checkboxs = document.getElementsByName("category");
			var okay = false;
			var reviewLength = $("#gameTitle").val().trim().length;
			if(reviewLength>33){
					alert("Game title should be less than 32 characters");
					return false;
				}
			for (var i = 0, l = checkboxs.length; i < l; i++) {
				if (checkboxs[i].checked) {
					okay = true;
					break;
				}
			}
			if (!okay) {
				alert("Please select a category");
				return false;
			}
		
			var _validFileExtensions = [".jpg", ".jpeg", ".png"];   
			var arrInputs = onForm.getElementsByClassName("superMegaClass");
			for (var i = 0; i < arrInputs.length; i++) {
				var oInput = arrInputs[i];
				if (oInput.type == "file") {
					var sFileName = oInput.value;
					if (sFileName.length > 0) {
						var blnValid = false;
						for (var j = 0; j < _validFileExtensions.length; j++) {
							var sCurExtension = _validFileExtensions[j];
							if (sFileName.substr(
									sFileName.length - sCurExtension.length,
									sCurExtension.length).toLowerCase() == sCurExtension
									.toLowerCase()) {
								blnValid = true;
								break;
							}
						}

						if (!blnValid) {
							alert("Sorry, " + sFileName
									+ " is invalid, allowed extensions are: "
									+ _validFileExtensions.join(", "));
							return false;
						}
					}
				}
			}
		}
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
		function assDate() {
			var date1 = document.getElementById("datePicker").value;
			document.getElementById("releaseDate").value = date1;
			var date2 = document.getElementById("releaseDate").value;
			console.log(date1);
			console.log(date2);
		}
	</script>
</body>
</html>