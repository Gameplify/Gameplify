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
                                        <div class="ui segment" style=" height: 120px; width: 270px; padding-top: 20px; margin-left: 40px; margin-top:0px;">
                                                                <img class="ui tiny left floated image" src="${resource(dir: 'images', file: 'nan.jpg')}">
                                                                <span>User</span>
                                                                <Button class="ui primary button" style=" margin-top: 10px; margin-right: 0px; width: 140px;">Logout</Button>
                                        </div> 
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
                                <h3 class="ui dividing header"   style="width: 770px;"> Number of Reviews</h3>
                                <div class="ui segment"  style="width: 770px;">
                                	<h4>Write a Review</h4>
                                	  <form class="ui reply form">
                                                    <div class="field">
                                                      <textarea></textarea>
                                                    </div>
                                                    <div class="ui blue labeled submit icon button">
                                                      <i class="icon edit"></i> Add Review
                                                    </div>
                                                </form>
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
                                                  <a class="Comment">Report</a>
                                          </div>
                                        </div>
                                        <div class="comments">
                                          <div class="comment">
                                            <a class="avatar">
                                              <img src="${resource(dir: 'images', file: 'nan.jpg')}">
                                            </a>
                                            <div class="content">
                                              <a class="author">Jenny Hess</a>
                                              <div class="metadata">
                                                <span class="date">Today at 5:00 PM</span>
                                              </div>
                                              <div class="text">
                                                Elliot you are always so right :)
                                              </div>
                                               <div class="actions">
                                                  <a class="Comment">Report</a>
                                               </div>
                                               <form class="ui comment form">
                                                    <div class="field">
                                                      <textarea></textarea>
                                                    </div>
                                                    <div class="ui blue labeled submit icon button">
                                                      <i class="icon edit"></i> Add Comment
                                                    </div>
                                                </form>
                                            </div>
                                          </div>
                                        </div>
                                      </div>
                                      </g:each>
                                     
                    </div>
        </div>
      </div>
</div>
<script>
 function showImage(imgName) {
       var curImage = document.getElementById('currentImg');
       var thePath = 'images/';
       var theSource =  imgName;
       curImage.src = theSource;
     }
 </script>
</body>
</html>