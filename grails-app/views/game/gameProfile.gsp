<html>
<head>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="${resource(dir:'css', file:'semantic.css')}">
 <link rel="stylesheet" type="text/css" href="${resource(dir:'dist', file:'semantic.css')}">

  <script src="${resource(dir:'dist/components', file:'semantic.min.js')}"></script>

</head>


<body>
<div class="ui fixed inverted menu">
      <g:include action="showNavbar"/>
      </div>
  <div class="ui two column stackable grid">
        <div class="row" style="margin-left: 0px;">
                <div class="ui segment">
                        <div class="ui grid" style="width: 800px; padding: 20px;  ">
                                  <div class="column">                                  	
                                        <div class="ui five column stackable grid">
                                                <g:each in="${game.screenshot}" status="i" var="screenshot">
                                                	<div class = "rows"	>
                                                      <img id= "smallerImg" src="${resource(dir: 'images', file: "${screenshot.photo}")}"  onclick="showImage('${resource(dir: 'images', file: "${screenshot.photo}")}');" />
                                                	</div>
                                                </g:each>
                                        </div>
                                  </div>
                                  <div class="eight wide column">
                                             <div class="column">
                                                      <img id="currentImg" src="${resource(dir: 'images', file: "${game.screenshot.first().photo}")}">
                                            </div> 
                                            <div class="column">
                                                      <p> ${game.gameDescription } </p>
                                            </div> 
                                  </div>
                       </div>
                </div>

                       <div class="ui two row stackable grid">
                          <div class="column">
                                  <div class="row">
                                       
                                                 <g:include controller="user" action="showUserAuthentication"/>
                                     
                                  </div> 
                                  <div class="ui segment" style="margin-left: 40px;margin-top: 20px; height: 344px;width: 272px;">
                                        <div class="column" style="width: 270px; height: 330px;" > 
                                                     <a class="ui red ribbon label">${game.rating }</a>
                                                    <img class="ui tiny centered image" style="width: 120px;margin-right: 87px; margin-top:10px;" src="${resource(dir: 'images', file: "$game.gameLogo")}">
                                                    <div class="center aligned column">
                                                        <h4 class="title">${game.gameTitle }</h4>
                                                        <h5 class="price">$ ${game.gamePrice }</h5>
                                                    </div>
                                                  <div class="ui star rating">
                                                      <i class="icon"></i>
                                                      <i class="icon"></i>
                                                      <i class="icon"></i>
                                                      <i class="icon"></i>
                                                      <i class="icon"></i>
                                                  </div>
                                                  
                                                   <h5 class="rate"> 0 raters</h5>
                                                   <h5 class="published"><g:formatDate format="MM-dd-yyyy" date="${game.releaseDate}"/> </h5> 
                                                  <div class="ui two column stackable grid" style="margin-left: 62px;margin-bottom: 0px;margin-right: 0px;">
                                         		  <div class ="row">
                                         		  
                                                  	<g:each in="${game.categories}" status="i" var="cat">	                                                         
                                                         <label class="ui blue label">${cat.categoryName }</label> 
                                                         
                                                        
                                                  	</g:each>
                                                  </div>
                                                  
                                         </div>
                                 </div>
                            </div>
                      </div>
        </div>
        <div class="row">
          <div class="ui segment"  style="width: 800px;">
                      <div class="ui minimal comments"  style="width: 800px;">
                                <h3 class="ui dividing header"   style="width: 770px;">  ${game.numberOfReviews } reviews</h3>
                                <div class="ui segment"  style="width: 770px;">
                                	<h4>Write a Review</h4>
                                	  <g:form class="ui reply form">
                                                    <div  class="field">
                                                      <g:textArea name="review"/>
                                                      	<input name="gameId" value="${game.id}" type="hidden" />
														<input name="gameTitle" value="${game.gameTitle}" type="hidden" />
                                                    </div>                                                    
	                                                    <g:actionSubmit action="addReview"  value="Add Review" class="ui blue labeled submit icon button">
	                                                      <i class="icon edit"></i> Add Review
	                                             
	                                                </g:actionSubmit>
                                       </g:form>
                                	<g:each in="${reviews}" status="i" var="review">                                                    
                                      <div class="comment">
                                        <a class="avatar">
                                          <img src="${resource(dir: 'images', file: "${review.user.userPhoto}")}">                   
                                        </a>
                                        <div class="content">
                                          <a class="author">${review.user.name }</a>
                                          <div class="metadata">
                                            <span class="date">${review.date }</span>
                                          </div>
                                          <div class="text">
                                             <p>
                                             	${review.review }
                                             
                                             </p>
                                           </div>
                                          <div class="actions">
											Report
                                        </div>
                                        <ul id="myList">
                                        <g:each in="${review.comment.sort{it.date}.reverse(true)}" status="k" var="comment"> 
                                          <li class="comment" style="display:none;">
                                            <a class="avatar">
                                              <img src="${resource(dir: 'images', file: "${comment.user.userPhoto}")}">
                                            </a>
                                            <div class="content">
                                              <a class="author">${comment.user.name }
                                             </a>
                                              <div class="metadata">
                                                <span class="date">${comment.date }
                                            	</span>
                                              </div>
                                              <div class="text">
                                              		${comment.comment }
                                              </div>
                                               <div class="actions">
                                                  <a class="Comment">Report</a>
                                               </div>
                                             
                                            </div>
                                          </li>
                                              </g:each>
                                        </ul>
                                          <g:if test="${ review.comment.size() > 0}">
                                        <div id="loadMore" style="text-align:center;">Load more</div>
                                        </g:if>
                                     
                                            <g:form class="ui comment form">
                                                    <div  class="field">
                                                      <g:textArea name="comment" required=""/>
                                                      	<g:hiddenField  name="gameId" value="${game.id}"  />
														<g:hiddenField  name="gameTitle" value="${game.gameTitle}" />
														<g:hiddenField  name="reviewId" value="${review.id}"  />
                                                    </div>                                                    
	                                                    <g:actionSubmit action="addComment"  value="Add Comment" class="ui blue labeled submit icon button">
	                                                      <i class="icon edit"></i> Add Comment
	                                             
	                                                </g:actionSubmit>
                                       			</g:form>
                                             
                                        
                                        
                                        </div>
                                      </div>
                                      </g:each>
                                     
                    </div>
        </div>
      </div>
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