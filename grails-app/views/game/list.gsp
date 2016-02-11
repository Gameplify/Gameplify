
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
      <g:include action="showNavbar"/>
 </div>
     <div class="background blue-purple"></div>
<div class="background green-blue"></div>



<div class="svg-wrapper">
 
        <div class="ui two column stackable grid">
              <div class="row" style="margin-left: 0px;">
                      <div class="ui segment" style="width: 802px;height: auto;">
                      <h3 style="margin-bottom: 57px;margin-top: 10px;">Search Results</h3>
                                   
                                	
                                	 <g:if test="${userInstanceTotal > 0}">
                                	     <g:if test="${taskInstanceTotal >0}">
                                	      <div class="ui two column stackable grid">
			                                   			<div class="column" style="width: 378px;" >
			                                                            <div class="ui segment" style="overflow:scroll; width: 392px;height: 567px; padding-left: 22px;">
																						<h3>Games Found</h3>
			                                                                            <div class="ui three column stackable grid">
			                                                                                     <div class="ui cards" style="margin-bottom: 20px;margin-left: 50px;margin-right: 50px;margin-top: 20px;height: 453px;">
																                                 	 	<g:each in="${games}" status="i" var="game">
																	                                 	<g:link action="gameProfile" params="${[gameTitle: "${game.gameTitle}"]}">                             		
																												 <div class="ui segment" style="width: 314px;height: 163px; padding-left: 22px;margin-top: 0px;margin-bottom: 8px;left: -18px;">
																		                                              		<div class="ui grid" style="float:right;margin-right: 1px;margin-top: 0px;width: 298px;margin-bottom: 7px;">
																		                                              		 	<g:each in="${gamess}" status="r" var="sss">
																		                                              		 	<g:if test="${r <10}">
																		                                              		 	<g:if test="${sss.averageRating >0}">
																																	<g:set var="gaa" value="${game.gameTitle}" />
																																	<g:if test="${sss.gameTitle==gaa }">
																																		<img class="ui tiny centered image"
																																		style="width: 25px;height: 25px;padding-right: 0px;margin-right: 0px;margin-left: 0px;right: -260px;"
																																		src="${resource(dir:'images', file: "hot.png")}"/>
																																	</g:if>
																																</g:if>
																																</g:if>
																																</g:each>
																																<g:each in="${bb}" status="w" var="aaa">
																																<g:if test="${w<10}">
																																	<g:set var="daa" value="${game.gameTitle}" />
																																	<g:if test="${aaa.gameTitle==daa }">
																																		<img class="ui tiny centered image"
																																		style="width: 25px;height: 25px;padding-right: 0px;margin-right: 0px;margin-left: 0px;right: -259px;"
																																		src="${resource(dir: 'images', file: "neww.png")}"/>
																																	</g:if>
																																</g:if>
																																</g:each>
																															</div>
																															
																	                                              		<img class="ui tiny left floated image" style="margin-top: 3px;" src="${resource(dir: 'images', file: "${game.gameLogo}")}">
																	                                                    <h5 >${game.gameTitle }</h5>
																	                                                    <div class="row" style="">
														                                 									<g:each var="category" in="${game.categories}">
														                                 									<a  style=""> ${category.categoryName }</a> 
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
			                                                            <div class="ui segment" style=" overflow:scroll; width: 378px;height: 567px;padding-left: 22px;left: 14px;">
			                                                                  <h3>User's Found</h3>
			                                                                             <div class="ui three column stackable grid">
			                                                                                     <div class="ui cards" style="margin-bottom: 20px;margin-left: 50px;margin-right: 50px;margin-top: 20px;">
																	                                 	 	<g:each in="${users}" status="i" var="user">
																		                                 	<g:link class = "author" controller = "user" action ="userProfile" params="${[userId:"${user.id}"]}">                               		
																													 <div class="ui segment" style="  height:104px; width: 270px; padding-top: 14px; margin-left: 0px; margin-top:0px;">
																		                                                   <g:if test="${user.avatar}"><img class="ui tiny left floated image" src="${createLink(controller:'user', action:'avatar_image', id:"${user.id}" )}" />
																		                                                    </g:if>
																		                                                    <g:else>
																													    <img class="ui tiny left floated image" src="${resource(dir: 'images', file: "nan.jpg")}">
																													    </g:else>
																													    <h5 style="    padding-left: 10px; margin-top: 0px; margin-bottom: 0px;">${user.name }</h5>
																		                                                    <div class="row" style="padding-bottom: 13px;padding-top: 5px;border-top-width: 5px;margin-top: 0px;margin-left: 3px;">
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
                            </g:if>
                            <g:else>
									   <div class="ui segment"  style="width: 770px; height: auto;">
                                     		<div class="ui cards" style="margin-bottom: 20px;margin-left: 50px;margin-right: 50px;margin-top: 20px;">
			                                 	 	<g:each in="${users}" status="i" var="user">
			                                 	 	<g:if test="${(i)<10}">
				                                 	<g:link class = "author" controller = "user" action ="userProfile" params="${[userId:"${user.id}"]}">                               		
															 <div class="ui segment" style="  height: 120px; width: 270px; padding-top: 14px;margin-left: 7px; margin-top:0px;">
				                                                    <g:if test="${user.avatar}">
				                                                    	<img class="ui tiny left floated image" src="${createLink(controller:'user', action:'avatar_image', id:"${user.id}" )}" />
				                                                    </g:if>
				                                                    <g:else>
																    	<img class="ui tiny left floated image" src="${resource(dir: 'images', file: "nan.jpg")}">
																    </g:else>
				                                                    <h5 style="    padding-left: 10px; margin-top: 0px; margin-bottom: 0px;">${user.name }</h5>
				                                                    <div class="row" style="padding-bottom: 13px;padding-top: 5px;border-top-width: 5px;margin-top: 0px;margin-left: 3px;">
	                                 								 </div>   
				                                              </div> 
				                                    </g:link>
				                                    </g:if>
				                                   </g:each>
                                           </div>
											<div class="pagination" style="text-align: center;">
												<g:paginate total="${usert}" max="10" offset="0"  params="${params}"/>
											</div>
									</div>	
									</div>
							</g:else>
                            </g:if>
                                    
											
                                     <g:elseif test="${taskInstanceTotal > 0}">
	                                      <div class="ui segment"  style="width: 770px; height: auto;">
	                                     		<div class="ui cards" style="margin-bottom: 20px;margin-left: 50px;margin-right: 50px;margin-top: 20px;">
				                                 	 	<g:each in="${gam}" status="i" var="game">
				                                 	 	<g:if test="${(i)<10}">
					                                 	<g:link action="gameProfile" params="${[gameTitle: "${game.gameTitle}"]}"> 
					                                 	 <div class="ui segment" style="height: 162px;width: 313px; padding-top: 14px;margin-left: 7px; margin-top:0px;">
														                                              		<div class="ui grid" style=" style="float:right;margin-right: 1px;margin-top: 0px;width: 298px;margin-bottom: 7px;om: 4px;">
																		                                              		 	<g:each in="${gamess}" status="g" var="ss">
																		                                              		 	<g:if test="${ss.averageRating >0}">
																		                                              		 	<g:if test="${gg<10}">
																																	<g:set var="ga" value="${game.gameTitle}" />
																																	<g:if test="${ss.gameTitle==ga }">
																																		<img class="ui tiny centered image"
																																		style="width: 25px;height: 25px;padding-right: 0px;margin-right: 0px;margin-left: 0px;left: 281px;"
																																		src="${resource(dir: 'images', file: "hot.png")}"/>
																																	</g:if>
																																</g:if>
																																</g:if>
																																</g:each>
																																<g:each in="${bb}" status="h" var="aa">
																																 <g:if test="${h<10}">
																																	<g:set var="da" value="${game.gameTitle}" />
																																	<g:if test="${aa.gameTitle==da }">
																																		<img class="ui tiny centered image"
																																		style="width: 25px;height: 25px;padding-right: 0px;margin-right: 0px;margin-left: 0px;left: 232px;"
																																		src="${resource(dir: 'images', file: "neww.png")}"/>
																																	</g:if>
																																 </g:if>
																																</g:each>
																											</div>	
																		<img class="ui tiny left floated image" style="margin-top: 27px;" src="${resource(dir: 'images', file: "${game.gameLogo}")}">
							           									<h5>${game.gameTitle }</h5>
							                                                 <div class="row" >
				                                 									<g:each var="category" in="${game.categories}">
				                                 									<a  style="margin-bottom: 5px;margin-left: 7px;"> ${category.categoryName }</a> 
				                                                                    </g:each>
				                                                             </div>  
				                                          </div>
					                                    </g:link>
					                                    </g:if>
					                                   </g:each>
	                                           </div>
	                                   
												<div class="pagination" style="text-align: center;">
													<g:paginate total="${gamet}" max="10" offset="0" params="${params}"/>
												</div>	
												</div>
										</div>
									</g:elseif>
									  
									<g:else>
										 <div class="ui segment"  style="width: 770px; height: auto;">
										   <h5>No Results Found</h5>
										 </div> 
										 </div>
									</g:else>
                    
              
               <g:include controller="user" action="showUserAuthentication"/>
            </div>
                    </div>
                    
</body>
</html>
