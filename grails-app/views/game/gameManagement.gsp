<html>
<head>
	<%@ page import="java.util.Calendar"%>
  <!-- Standard Meta -->
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">

  <!-- Site Properities -->
  <title>Game Management</title>
    <link rel="stylesheet" type="text/css" href="${resource(dir:'css', file:'semantic.css')}">
 <link rel="stylesheet" type="text/css" href="${resource(dir:'dist', file:'semantic.css')}">
  <script src="${resource(dir:'dist', file:'semantic.min.js')}"></script>
 
</head>


<body>
<div class="ui fixed inverted menu">
      <g:include action="showNavbar"/>
      </div>
  <div class="ui two column stackable grid">
              <div class="row" style="margin-left: 0px;">
                      <div class="ui segment" style="height: auto">
                                  <div class="ui grid" style="width: 800px; padding: 20px; ">
                                      <h3 style="width: 770px;  margin-bottom: 0px;"> ${currentCategory } </h3>
                                                  <div class="ui grid" style="margin-left: 510px; margin-top: -35px;">
                                                   <g:if test="${flash.message}">
														<div class="message" style="width: 200px; margin-left: -171px;">${flash.message }</div>
													</g:if>
													<button class="ui icon button" id="addGame" style ="height:28px; width:28px; padding:0;">
                                                  		<i class= "big green add square icon" style ="height:28px; width:28px;"></i>
                                                  	</button>
                                                  	<button class="ui icon button" id="deleteGame" style ="height:28px; width:28px; margin-left:30px; padding:0;">
                                                  		<i class= "big red trash icon" style ="height:28px; width:28px;"></i>
                                                  	</button>
                                                  </div>
                                                  
                                                  <div class="ui grid" style="margin-left: 610px; margin-top: -35px;">
                                                  			
                                                          
                                                        <g:each in="${platforms }" var="platform">
                                                        <g:link action="gameManagement" params="${[ platform:platform.platformName, categoryName: currentCategory] }">
                                                        <button class="ui icon button">
                                                            ${platform.platformName }
                                                          </button>
                                                          </g:link>	
                                                          </g:each>
                                                  </div>
                                       </h3>
                                  </div>
                               
                                 <div class="ui segment"  style="width: 770px; height: auto;">
                                 
                                           <div class="ui cards" style="margin-bottom: 20px;margin-left: 50px;margin-right: 50px;margin-top: 20px;">
                                 	<g:each in="${games}" status="i" var="game">
                                 	<g:link action="gameProfile" params="${[gameTitle: "${game.gameTitle}"]}">                             		
                                              <div class="ui segment" style=" height: 120px; width: 270px; padding-top: 20px; margin-left: 40px; margin-top:0px;">
                                                                      <img class="ui tiny left floated image" src="${resource(dir: 'images', file: "${game.gameLogo}")}">
                                                                      <div class="ui 3 column stackable grid" style="margin-left: 62px;margin-bottom: 0px;margin-right: 0px; margin-top:0px;">
                                                                                <h5 style="    padding-left: 10px;margin-bottom: 0px;">${game.gameTitle }</h5>
                                                                                <div class="row" style="padding-bottom: 13px;padding-top: 5px;border-top-width: 5px;margin-top: 0px;margin-left: 3px;">
                                 									                  <g:each var="category" in="${game.categories}">
                                 									                  <a  style="margin-bottom: 5px;margin-left: 7px;"> ${category.categoryName }</a> 
                                                                                    
                                                                                      </g:each>
                                                                                </div>
                                                                      </div>
                                              </div> 
                                           </g:link>
                                        <g:link action="deleteGame" params="${[gameTitle:"${game.id}",categoryName:currentCategory, gameCategory:"${game.categories}"] }">
											<button class="ui icon button delete" id="delete" style ="display:none;padding:0;margin-top:4px;margin-left: -267px;">
              									<i class= "small red delete icon"></i>
											</button>
										</g:link>    
                                   </g:each>

                                           </div>
                                   
									<div class="pagination" style="text-align: center;">
				<g:paginate action="gameManagement" total="${gameCount}" params="${[chosenPlatform:"${chosenPlatform}", categoryName: currentCategory]}" ></g:paginate>
							</div>
                                   </div>
                    </div>
               
               <g:include controller="user" action="showUserAuthentication"/>
            </div>
       </div>

<div class="ui modal addGame">
  <i class="close icon"></i>
  <g:form class="ui equal width form" id="form" style="padding:10px" controller='game' action='addGame'>
  	<img class="ui centered small image" id="image" src="#" alt="Game Logo">
  	<g:field type="file" name="gameLogo" accept="image/*" required=""/>
  	<div class="field">
  		<g:hiddenField  name="currentCategory" value="${currentCategory}"/>
      	<g:textField placeholder="Game Title*" name="gameTitle" required=""/>
    </div>
  	<div class="fields">
    	<div class="field" style="width:200px;">
      		<label for="releaseDate">Released On*</label>
      		<g:datePicker name="releaseDate" value="${new Date()}" precision="day" years="${Calendar.instance.get(Calendar.YEAR)..1950}"/>
    	</div>
    	<div class="field">
      		<label for = "price">Price*</label>
      		<g:field type="number" name="gamePrice" required=""/>
    	</div>
    	<div class="field">
			<label for="platform">Platform</label>
    		<g:select from="${platforms}" class="ui dropdown" name="platformId" optionKey="id" optionValue="platformName"/>
  		</div>
  	</div>
  	<div class="field">
  		<g:textArea rows="3" name="gameDescription" placeholder="Description*" required=""/>
  	</div>
  	<div class="field">
  		<label for="category">Category(Select at least one)</label>
  		<div class="ui grid">
			<g:each in="${categories}" status="i" var="cat">
			<div class = "four wide column" style="padding:0px;margin-left:10px;margin-top:12px;">
				<div class="ui checkbox">
					<g:checkBox name="category" value="${cat.id}" checked="false"/>
					<label>${cat.categoryName}</label>
				</div>
			</div>		
			</g:each>
		</div>	
	</div>	
  	<div class="actions" style="text-align:center;margin-top:30px;">
    	<g:submitButton class="ui button" name="addButton" value ="Add Game" style="margin-left: -1.75em;"></g:submitButton>
  	</div>
	</g:form>
</div>
<script>

$(function(){
	$('#addGame').click(function(){
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
	$('#deleteGame').click(function(){
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

</script>        
</body>
</html>