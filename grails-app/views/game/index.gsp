
<!DOCTYPE html>
<html>
<head>
  <!-- Standard Meta -->
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">

  <!-- Site Properities -->
  <title>Game List</title>
  
<link rel="stylesheet" type="text/css"
	href="${resource(dir:'dist', file:'bg.css')}">
    <link rel="stylesheet" type="text/css" href="${resource(dir:'css', file:'semantic.css')}">
 <link rel="stylesheet" type="text/css" href="${resource(dir:'dist', file:'semantic.css')}">
  <script src="${resource(dir:'dist/components', file:'semantic.min.js')}"></script>
 
</head>
<body>
<div class="ui fixed inverted menu">
      <g:include controller="game" action="showNavbar"/>
 </div>
     	<div class="background blue-purple"></div>
<div class="background green-blue"></div>



<div class="svg-wrapper">
 
        <div class="ui two column stackable grid">
              <div class="row" style="margin-left: 0px;">
                      <div class="ui segment" style="width:800px; height: auto">
                      		  <div class="ui three column stackable grid">
                      		       <div class="column" style="width: 378px;" >
                      		        <h3>What's HOT</h3>
                      		       </div>
                        		   <div class="column" style="width: 140px;" >
                      		        <h3>What's NEW</h3>
                      		       </div>
                      		       	<div class="column"  >
		                                   <div class="ui grid" style="float:right">
		                                                  			
		                                                        <g:each in="${platforms }" var="platform">
		                                                        <g:link action="index" params="${[ platform:platform.platformName] }">
		                                                        <button class="ui icon button">
		                                                        	   <img class="platformpic" src="${resource(dir: 'images', file: "${platform.pic}")}">
		                                                           
		                                                          </button>
		                                                          </g:link>	
		                                                          </g:each>
		                                   </div>
		                            </div>
                              </div>
                       <div class="ui two column stackable grid">
			                                   			<div class="column" style="width: 378px;" >
			                                                
			                                                  <div class="ui segment" style="overflow:scroll; width: 392px;height: 436px; padding-left: 22px;">
		
																		       <div class="ui three column stackable grid">
																		       				<div class="rows"    style=" width: 325px;"> 
																		       			 		  <g:each in="${Hot}" status="i" var="game">
																								  <g:link action="gameProfile" params="${[gameTitle: "${game.gameTitle}"]}">
																								 		    	<div class="ui segment"  style=" height: 110px;width: 351px;padding-left: 30px;padding-top: 24px;">
															                                                        <a class="ui red right ribbon label 1" style="left: 240px;">${game.rating }</a>
															                                                        <img class="ui tiny left floated image" src="${resource(dir: 'images', file: "${game.gameLogo}")}">
																												    <h5 style="    padding-left: 10px; margin-top: 0px; margin-bottom: 0px; ">${game.gameTitle }</h5>
																													<div class="row" style="padding-bottom: 13px;padding-top: 5px;border-top-width: 5px;margin-top: 0px;margin-left: 3px;">
																														<g:each var="category" in="${game.categories}">
																															<a  style="margin-bottom: 5px;margin-left: 7px;"> ${category.categoryName }</a> 
																														</g:each>
																													</div>
																												</div>  
																											
																											
																									</g:link>
																									</g:each>
																							</div>
																													
																									
																						
																		         </div>
																		                                                          
															 </div> 
			                                  			</div>
			                                 			 <div class="column" style="width: 378px;" >
			                                                   <div class="ui segment" style="overflow:scroll; width: 392px;height: 436px; padding-left: 22px;">
		
																		       <div class="ui three column stackable grid">
																		       				<div class="rows"    style=" width: 325px;"> 
																		       			 		  <g:each in="${New}" status="i" var="gam">
																								  <g:link action="gameProfile" params="${[gameTitle: "${gam.gameTitle}"]}">
																								 		    	<div class="ui segment"  style=" height: 110px;width: 351px;padding-left: 30px;padding-top: 24px;">
															                                                        <a class="ui red right ribbon label 1" style="left: 240px;">${gam.rating }</a>
															                                                        <img class="ui tiny left floated image" src="${resource(dir: 'images', file: "${gam.gameLogo}")}">
																												    <h5 style="    padding-left: 10px; margin-top: 0px; margin-bottom: 0px; ">${gam.gameTitle }</h5>
																													<div class="row" style="padding-bottom: 13px;padding-top: 5px;border-top-width: 5px;margin-top: 0px;margin-left: 3px;">
																														<g:each var="category" in="${gam.categories}">
																															<a  style="margin-bottom: 5px;margin-left: 7px;"> ${category.categoryName }</a> 
																														</g:each>
																													</div>
																												</div>  
																											
																											
																									</g:link>
																									</g:each>
																							</div>
																													
																									
																						
																		         </div>
																		                                                          
															 </div>           	       
			                                     		 </div>
			                                     		 
			               	   </div>
			                  </div>
                <g:include controller="user" action="showUserAuthentication"/>
        
                    </div>
</body>
</html>
