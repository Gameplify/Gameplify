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
	href="${resource(dir:'dist/components', file:'rating.min.css')}">

<script src="${resource(dir:'dist', file:'semantic.min.js')}"></script>
<script src="${resource(dir:'dist/components', file:'rating.min.js')}"></script>
<script src="${resource(dir:'dist', file:'jquery-2.1.4.min.js')}"></script>

</head>

<body>
	<div class="ui fixed inverted menu">
	<g:include action="showNavbar" />
	</div>
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
							<img id="currentImg"
								src="${resource(dir: 'images', file: "${game.screenshot.first().photo}")}">
						</div>
						<div class="column">
							<p>
								${game.gameDescription }
							</p>
						</div>
					</div>
				</div>
			</div>

			<div class="ui two row stackable grid" style="position: fixed">
				<div class="column">
					<div class="row">

						<g:include controller="user" action="showUserAuthentication" />

					</div>
					<div class="ui segment"
						style="margin-left: 40px; margin-top: 20px; height: 344px; width: 272px;">
						<div class="column" style="width: 270px; height: 330px;">
							<a class="ui red ribbon label"> ${game.rating }
							</a> <img class="ui tiny centered image" style="width: 120px;"
								src="${resource(dir: 'images', file: "$game.gameLogo")}">
							<div class="center aligned column">
								<h4 class="title">
									${game.gameTitle }
								</h4>
								<h5 class="price">
									$
									${game.gamePrice }
								</h5>
							</div>
							<div class="ui star rating" data-rating="3">
								<i class="icon"></i> <i class="icon"></i> <i class="icon"></i> <i
									class="icon"></i> <i class="icon"></i>
							</div>

							<h5 class="rate">0 raters</h5>
							<h5 class="published">
								<g:formatDate format="MM-dd-yyyy" date="${game.releaseDate}" />
							</h5>
							<g:if test="${session?.user?.role == "Admin"}">
								<button class="ui blue button" id="editGame"
									style="margin-left: 92px;">Edit</button>
							</g:if>
							<div class="ui two column stackable grid"
								style="margin-left: 62px; margin-bottom: 0px; margin-right: 0px;">
								<div class="row">

									<g:each in="${game.categories}" status="i" var="cat">
										<label class="ui blue label"> ${cat.categoryName }
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
								<h4>Write a Review</h4>
								<g:form class="ui reply form">
									<div class="field">
										<g:textArea id="text" name="review" />
										<input name="gameId" value="${game.id}" type="hidden" /> <input
											name="gameTitle" value="${game.gameTitle}" type="hidden" />
									</div>
									<div id="counter"></div>
									<g:actionSubmit id="reviewButton" action="addReview"
										value="Add Review" class="ui blue labeled submit icon button">
										<i class="icon edit"></i> Add Review
	                                             
	                                                </g:actionSubmit>

								</g:form>

							</g:if>
							<div style="height: auto; max-height: 600; overflow-y: auto;">
								<ul>
									<g:each in="${reviews}" status="i" var="review">
										<li>
											<div class="comment">
												<a class="avatar"> <img
													src="${createLink(controller:'user', action:'avatar_image', id:"${review.user.id}" )}" />
												</a>
												<div class="content">
													<g:link class="author" controller="user"
														action="userProfile"
														params="${[userId:"${review.user.id}"]}">
														${review.user.name }
													</g:link>
													<div class="metadata">
														<span class="date"> ${review.date }
														</span>
													</div>
													<div class="text">
														<p>
															${review.review }

														</p>
													</div>
													<div class="actions">Report</div>
													<ul class="myList">
														<g:each in="${review.comment.sort{it.date}.reverse(true)}"
															status="k" var="comment">
															<li class="comment" style="display: none;"><a
																class="avatar"> <img
																	src="${createLink(controller:'user', action:'avatar_image', id:"${comment.user.id}" )}" />
															</a>
																<div class="content">
																	<g:link class="author" controller="user"
																		action="userProfile"
																		params="${[userId:"${comment.user.id}"]}">
																		${comment.user.name }
																	</g:link>
																	</a>
																	<div class="metadata">
																		<span class="date"> ${comment.date }
																		</span>
																	</div>
																	<div class="text">
																		${comment.comment }
																	</div>
																	<div class="actions">
																		<a class="Comment">Report</a>
																	</div>

																</div></li>
														</g:each>
													</ul>
													<g:if test="${ review.comment.size() > 3}">
														<div class="loadMore" style="text-align: center;">Load
															more</div>
													</g:if>

													<g:if test="${session?.user}">
														<g:form class="ui comment form">
															<div class="field">
																<g:textArea name="comment" required="" />
																<g:hiddenField name="gameId" value="${game.id}" />
																<g:hiddenField name="gameTitle"
																	value="${game.gameTitle}" />
																<g:hiddenField name="reviewId" value="${review.id}" />
															</div>
															<g:actionSubmit action="addComment" value="Add Comment"
																class="ui blue labeled submit icon button">
																<i class="icon edit"></i> Add Comment
	                                             
	                                                </g:actionSubmit>
														</g:form>
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
					<g:form class="ui equal width form" id="form" style="padding:10px"
						controller='game' action='editGame'>
						<img class="ui centered small image" id="image"
							src="${resource(dir: 'images', file: "$game.gameLogo")}"
							alt="Game Logo">
						<g:field type="file" name="gameLogo" accept="image/*"
							value="${game.gameLogo}" />
						<div class="field">
							<g:hiddenField name="gameId" value="${game.id }"></g:hiddenField>
							<g:textField placeholder="Game Title*" name="gameTitle"
								required="" value="${game.gameTitle}" />
						</div>
						<div class="fields">
							<div class="field" style="width: 200px;">
								<label for="releaseDate">Released On*</label>
								<g:datePicker name="releaseDate" value="${game.releaseDate}"
									precision="day"
									years="${Calendar.instance.get(Calendar.YEAR)..1950}" />
							</div>
							<div class="field">
								<label for="price">Price*</label>
								<g:field type="number" name="gamePrice" required=""
									value="${game.gamePrice }" />
							</div>
							<div class="field">
								<label for="platform">Platform</label>
								<g:select from="${platforms}" class="ui dropdown"
									name="platformId" optionKey="id" optionValue="platformName" />
							</div>
						</div>
						<div class="field">
							<g:textArea rows="3" name="gameDescription"
								placeholder="Description*" required=""
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
						<div class="actions" style="text-align: center; margin-top: 30px;">
							<g:submitButton class="ui button" name="addButton"
								value="Add Game" style="margin-left: -1.75em;"></g:submitButton>
						</div>
					</g:form>
				</div>
				<script>
$(document).ready(function () {

	
    size_li = $("#myList li").size();
    x=3;
    $('#myList li:lt('+x+')').show();
    $('#loadMore').click(function () {
        x= (x+5 <= size_li) ? x+5 : size_li;
        $('#myList li:lt('+x+')').show();
    });
	$('#editGame').click(function(){
		$('.modal').modal('show');
	});
	document.getElementById("gameLogo").onchange = function () {
	    var reader = new FileReader();

	    reader.onload = function (e) {
	        // get loaded data and render thumbnail.
	        document.getElementById("image").src = e.target.result;
	    };

	    // read the image file as a data URL.
	    reader.readAsDataURL(this.files[0]);
	};
	i=0;
	w=0;
	x=0;
	var myArr = new Array();
	size_li=0;
		
	$('.myList').each(function() {
	    var count = $('> li', this).length;
	    myArr.push(count);
	    $('.myList li').slice(w, w+3).show();
	    w+= myArr[i]; 
	   	i++;
	});
    
	  $('.loadMore').click(function () {
	   val=$('.loadMore').index(this);
		   val2=val;
		   size_li=0;
			if(val!=0){
			   	while(val>0){
			   	 val--; 
			   	size_li+=myArr[val];
		  	   	myArr[val2]+= myArr[val];
		  	 
		   }			 
		   }
			size_li= size_li+3; 
	       	if ( size_li  < myArr[val2]) {
	           $('.myList li').slice(size_li, myArr[val2]).show();
	        }else{
	        	size_li=3; 
		        $('.myList li').slice(size_li, myArr[val2]).show();
	        	$('.loadMore').eq($('.loadMore').index(this)).hide();	
		    }
	    	if ( size_li  < myArr[val2]) {
	    		$('.loadMore').eq($('.loadMore').index(this)).hide();
	    	}
		   
	    });
   



	
	$("#counter").css("color","red");
    document.getElementById("reviewButton").disabled = true;
    $("#counter").append("<strong> 0 </strong> characters ");
    $("#text").keyup(function(){
 
	    var reviewLength = $(this).val().length;
	    $("#counter").html(" <strong>"+  reviewLength+"</strong> characters");
	    if(reviewLength < 100){
	    	document.getElementById("reviewButton").disabled = true;
	    }
	    if(reviewLength >= 100){
	    	document.getElementById("reviewButton").disabled = false;
	    }
	    if(reviewLength <= 100)
	    {
	        $("#counter").css("color","red");
	    }
	    else
	    {
	        $("#counter").css("color","black");
	    }
    });

    $("#submitButton").click(function(){
		alert("hsadi");
	})
});



 function showImage(imgName) {
       var curImage = document.getElementById('currentImg');
       var thePath = 'images/';
       var theSource =  imgName;
       curImage.src = theSource;
     }
 </script>
</body>
</html>