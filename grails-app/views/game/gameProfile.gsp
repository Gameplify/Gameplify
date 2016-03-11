<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
<link rel="stylesheet" type="text/css"
	href="${resource(dir:'css', file:'semantic.css')}">
<link rel="stylesheet" type="text/css"
	href="${resource(dir:'dist', file:'semantic.css')}">
<link rel="stylesheet" type="text/css"
	href="${resource(dir:'dist', file:'bg.css')}">


<script src="${resource(dir:'dist', file:'semantic.js')}"></script>
<script src="${resource(dir:'dist', file:'jquery-2.1.4.min.js')}"></script>
<script src="${resource(dir:'js', file:'javascript.js') }"></script>



</head>
<title>Game Profile</title>
<body>

	<div class="ui fixed inverted menu">
		<g:include action="showNavbar" />
	</div>
	<div class="background blue-purple"></div>
	<div class="background green-blue"></div>



	<div class="svg-wrapper">


		<div class="ui two column stackable grid">
			<div class="row" style="margin-left: 0px;">
				<div class="ui segment">
					<div class="ui grid" style="width: 800px; padding: 20px;">
						<div class="column">
							<div class="ui five column stackable grid">
								<g:each in="${game.screenshot}" status="i" var="screenshot">
									<div class="rows">
										<img id="smallerImg"
											src="${resource(dir: 'images', file: "${screenshot.photo}")}"
											onclick="showImage('${resource(dir: 'images', file: "${screenshot.photo}")}');" />
									</div>
								</g:each>
							</div>
						</div>
						<div class="eight wide column">
							<div class="column">
								<g:if test="${game.screenshot.photo }">
									<img id="currentImg" style="height: 300px;" class="ui image"
										src="${resource(dir: 'images', file: "${game.screenshot.first().photo}")}">
								</g:if>
							</div>
							<div class="column">
								<p>
									${game.gameDescription }
								</p>
							</div>
						</div>
					</div>
				</div>

				<div class="ui two row stackable grid">
					<div class="column">
						<div class="row">

							<g:include controller="user" action="showUserAuthentication" />

						</div>
						<div class="ui segment"
							style="margin-left: 40px; margin-top: 20px; height: auto; width: 278px;">
							<div class="column" style="width: 258px; height: auto;">

								<div id="updateMe">
									<a class="ui red ribbon label"> ${game.averageRating}
									</a>
									<div class="ui grid"
										style="float: right; margin-right: 1px; margin-top: 0px;">
										<g:each in="${games}" status="g" var="ss">
											<g:if test="${ss.averageRating >4.5}">
												<g:set var="ga" value="${game.gameTitle}" />
												<g:if test="${ss.gameTitle==ga }">
													<img class="ui tiny centered image"
														style="width: 25px; height: 25px; padding-right: 0px;"
														src="${resource(dir: 'images', file: "hot.png")}" />
												</g:if>
											</g:if>
										</g:each>
										<g:each in="${bb}" status="h" var="aa">
											<g:set var="da" value="${game.gameTitle}" />
											<g:if test="${aa.gameTitle==da }">
												<img class="ui tiny centered image"
													style="width: 25px; height: 25px; padding-right: 0px;"
													src="${resource(dir: 'images', file: "neww.png")}" />
											</g:if>
										</g:each>
									</div>

									<img class="ui tiny centered image"
										style="width: 150px; height: 150px;"
										src="${resource(dir: 'images', file: "$game.gameLogo")}">
									<div class="center aligned column">
										<h4 class="title">
											${game.gameTitle }
										</h4>
										<h5 class="price">
											$
											${game.gamePrice }

										</h5>
										<h5 class="title">
											Number of raters: ${game.numberOfRaters }

										</h5>
									</div>
								</div>
								<g:if test="${session?.user }">
									<g:if test="${session?.user?.status != "blocked"}">
										<div class="ui large star rating" data-rating=${rating
											}
									data-max-rating="5"></div>
									</g:if>
								</g:if>


								<h5 class="published">
									<g:formatDate format="MM-dd-yyyy" date="${game.releaseDate}" />
								</h5>
								<g:if test="${session?.user?.role == "Admin"}">
									<button class="ui blue button" id="editGame" name="edit"
										style="margin-left: 92px;">Edit</button>
								</g:if>
								<div class="ui two column stackable grid"
									style="margin: auto; display: table-cell; padding: -10px; padding-top: 0px;">
									<div class="row"
										style="width: 270px; height: auto; padding-top: 0px; bottom: 5px; top: 5px;">

										<g:each in="${game.categories}" status="i" var="cat">
											<label class="ui blue label"
												style="padding-top: 7px; bottom: 13px; margin-bottom: 5px;">
												${cat.categoryName }
											</label>


										</g:each>
									</div>

								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="ui segment" style="width: 800px;">
						<div class="ui minimal comments" style="width: 800px;">
							<h3 class="ui dividing header" style="width: 770px;">
								${game.numberOfReviews }
								reviews
							</h3>
							<div class="ui segment" style="width: 770px;">
								<g:if test="${session?.user}">
									<g:if test="${session?.user?.status != "blocked"}">
										<h4>Write a Review</h4>
										<div id="reviewForm">
											<g:render template="reviewForm" />
										</div>



									</g:if>
								</g:if>
								<div style="height: auto; max-height: 600px; overflow-y: auto;">
									<ul>
										<g:each in="${reviews}" status="i" var="review">
											<li>
												<div class="comment">
													<a class="avatar"> <g:if test="${review.user.avatar }">
															<img
																src="${createLink(controller:'user', action:'avatar_image', id:"${review.user.id}" )}" />
														</g:if> <g:else>
															<img class="photo"
																src="${resource(dir: 'images', file: "nan.jpg")}">
														</g:else>
													</a>
													<div class="content">
														<g:link class="author" controller="user"
															action="userProfile"
															params="${[userId:"${review.user.id}"]}">
															${review.user.name }
														</g:link>
														<div class="metadata">
															<span class="date"> <g:formatDate date="${review.date }" type="datetime"/>
															</span>
														</div>
														<div class="text">
															<p>
																${review.review }
															</p>
														</div>
														<g:if test="${"${review.user}" == "${session?.user }"}">
															<div class="actions">
																<g:remoteLink
																	url="[controller:'game', action:'editReview']"
																	update="reviewForm" value="Edit"
																	params="${[reviewId:"${review.id}"]}"
																	onSuccess="focusDiv();">edit</g:remoteLink>
															</div>
														</g:if>
														<g:else>
															<g:if
																test="${session?.user?.status != "blocked" && session?.user != "${review.user}" 
																	&& session?.user && "${review.user.role}" != "Admin"}"> 
																<div class="reportUser">
																	<g:remoteLink
																		url="[controller:'game', action:'report']"
																		value="Report"
																		before="if(!confirm('Are you sure you want to report this user?')) return false"
																		params="${[type:"${review.review}", userId:"${review.user.id}"]}">Report</g:remoteLink>
																</div>
															</g:if>
														

														</g:else>
														<ul class="myList">
															<g:each
																in="${review.comment.sort{it.date}.reverse(true)}"
																status="k" var="comment">
																<li class="comment" style="display: none;"><a
																	class="avatar"> <g:if test="${review.user.avatar }">
																			<img
																				src="${createLink(controller:'user', action:'avatar_image', id:"${comment.user.id}" )}" />
																		</g:if> <g:else>
																			<img class="photo"
																				src="${resource(dir: 'images', file: "nan.jpg")}">
																		</g:else>

																</a>
																	<div class="content">
																		<g:link class="author" controller="user"
																			action="userProfile"
																			params="${[userId:"${comment.user.id}"]}">
																			${comment.user.name }
																		</g:link>

																		<div class="metadata">
																			<span class="date"> <g:formatDate date="${comment.date }" type="datetime"/>
																			</span>
																		</div>
																		<div class="text">
																			${comment.comment }
																		</div>
																		<g:if
																			test="${session?.user?.status != "blocked" && "${session?.user}" != "${comment.user}" 
																	&& session?.user && "${comment.user.role}" != "Admin"}"> 
																			<div class="reportUser">
																				<g:remoteLink	
																					url="[controller:'game', action:'report']"
																					value="Report"
																					before="if(!confirm('Are you sure you want to report this user?')) return false"
																					params="${[type:"${comment.comment}", userId:"${comment.user.id}"]}">Report</g:remoteLink>
																			</div>
																		</g:if>


																	</div></li>
															</g:each>
														</ul>
														<g:if test="${ review.comment.size() > 3}">



															<div class="loadMore" onclick="myFunc()"
																style="text-align: center;">Load more</div>
														</g:if>
														<g:else>
															<div class="loadMore" onclick="myFunc()"
																style="text-align: center; visibility: hidden;">Load
																more</div>

														</g:else>
														<g:if test="${ review.comment.size() == 0}">

															<div
																style="text-align: center; font-style: italic; color: dimgrey;">
																---------- No existing comments. ----------</div>
														</g:if>
														<g:if test="${session?.user}">
															<g:if test="${session?.user?.status != "blocked"}">
																<g:form class="ui comment form">
																	<div class="field">
																		<g:textArea class="textbox" name="comment" required=""
																			maxlength="100" />
																		<g:hiddenField name="gameId" value="${game.id}" />
																		<g:hiddenField name="gameTitle"
																			value="${game.gameTitle}" />
																		<g:hiddenField name="reviewId" value="${review.id}" />
																	</div>

																	<g:actionSubmit action="addComment" value=" Comment"
																		id="commentButton"
																		class="ui blue labeled submit icon button" disabled="" />



																</g:form>
															</g:if>
														</g:if>
													</div>
												</div>
											</li>
										</g:each>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>





				<div class="ui modal addGame">
					<i class="close icon"></i>
					<g:form class="ui equal width form" id="form" style="padding:20px"
						controller='game' action='editGame' onsubmit="return check()">
						<img class="ui centered small image" id="image"
							src="${resource(dir: 'images', file: "$game.gameLogo")}"
							alt="Game Logo">
						<g:field type="file" name="gameLogo" class="superMegaClass"
							accept="image/jpeg, image/png, image/jpg"
							value="${game.gameLogo}" style="margin: 10px;" />
						<div class="field">
							<g:hiddenField name="gameId" value="${game.id }"></g:hiddenField>
							<g:hiddenField name="realGameTitle"	 value="${game.gameTitle }" />
							<g:textField placeholder="Game Title*" id="gameTitle"
								name="gameTitle"  value="${game.gameTitle}" />
						</div>
						<div class="fields">
							<div class="field" style="width: 200px;">
								<label for="releaseDate">Released On*</label> <input type="date"
									id="datePicker"
									value="${formatDate(format:'yyyy-MM-dd',date:game.releaseDate) }"
									oninput="assDate();" required />
								<g:hiddenField name="releaseDate" id="releaseDate"
									value="${game.releaseDate }" />
							</div>
							<div class="field">
								<label for="price">Price*</label>
								<g:field type="number" name="gamePrice" required=""
									value="${game.gamePrice }" step=".01" style="font-size: 14px;" />
							</div>
							<div class="field">
								<label for="platform">Platform</label>
								<g:each in="${platforms}" status="i" var="platform">
									<g:if test="${platform in game.platform }">
										<g:hiddenField name="formerPlatformId" value="${platform.id}" />
									</g:if>
								</g:each>

								<g:select class="ui dropdown"from="${platforms}" name="platformId" optionKey="id"
									optionValue="platformName"  value="${game.platform.id }"/>
							</div>
						</div>
						<div class="field">
							<g:textArea rows="3" name="gameDescription"
								placeholder="Description*" id="gameDesc" required=""
								value="${game.gameDescription }" />
						</div>
						<div class="field">
							<label for="category">Category(Select at least one)</label>
							<div class="ui grid">

								<g:each in="${categories}" status="i" var="cat">
									<div class="four wide column"
										style="padding: 0px; margin-left: 10px; margin-top: 12px;">
										<div class="ui checkbox">
											<g:if test="${cat in game.categories}">
												<g:hiddenField name="formerCategory" value="${cat.id}" />
												<g:checkBox name="newCategory" value="${cat.id}"
													checked="true" />
											</g:if>
											<g:else>
												<g:checkBox name="newCategory" value="${cat.id}"
													checked="false" />
											</g:else>
											<label> ${cat.categoryName}
											</label>
										</div>
									</div>
								</g:each>
							</div>
						</div>
						<div class="field" style="margin-top: 20px;">
							<label for="screenshot">Screenshot/s</label>
							<g:field type="file" name="screenshots" class="superMegaClass"
								accept="image/jpeg, image/png, image/jpg" multiple="multiple"
								style="margin: 10px;" />
						</div>
						<div class="actions" style="text-align: center; margin-top: 30px;">
							<g:submitButton class="ui button" name="editGame" id="editButton"
								value="Save Changes" style="margin-left: -1.75em;"></g:submitButton>
						</div>
					</g:form>
				</div>
				<g:if test="${flash.error }">
					<div class="ui small modal">
						<div class="ui negative message">

							<div class="header">
								${flash.error }
							</div>
						</div>
					</div>
				</g:if>
				<g:if test="${flash.success }">
					<div class="ui small modal">
						<div class="ui positive message">

							<div class="header">
								${flash.success }
							</div>
						</div>
					</div>
				</g:if>
			</div>
		</div>
	</div>
	<script>


	
$('.ui.rating')
.rating('setting', 'onRate', function(value) {
    var rating = value;
    var gameId = ${game.id}	
    ${remoteFunction(controller: 'game' , update: 'updateMe',  action: 'rating', params: '\'rating=\' + rating +  \'&gameId=\' + gameId')}
});

var i=0;
var w=0;
var x=0;
var Arr= new Array();
var myArr = new Array();
var size_li=0;

$('.myList').each(function(){
	var count = $('> li', this).length;

    myArr.push(count); //number of comments per review
    
    Arr.push(3);
    $('.myList li').slice(w, w+3).show();
    w+= myArr[i]; 
   	i++;
});

	
$('.ui.small.modal').modal('show');
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

