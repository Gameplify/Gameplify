
<!DOCTYPE html>
<html>
<head>
  <!-- Standard Meta -->
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">

  <!-- Site Properities -->
  <title>Game List</title>
    <link rel="stylesheet" type="text/css" href="${resource(dir:'css', file:'semantic.css')}">
 <link rel="stylesheet" type="text/css" href="${resource(dir:'dist', file:'semantic.css')}">
 <link rel="stylesheet" type="text/css"
	href="${resource(dir:'dist', file:'bg.css')}">
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
                      <div class="ui segment" style="height: auto">
                                  <div class="ui grid" style="width: 800px; padding: 20px; ">
                                     
                                  </div>
                               
                                 <div class="ui segment"  style="width: 770px; height: auto;">
                                 
                                    <div class="ui cards" style="margin-left: 50px;margin-right: 50px;margin-top: 20px;">
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
                                           
                                   </g:each>

                                           </div>
                                   
									
                                   </div>
                    </div>
                <div class="ui two row stackable grid">
                                <div class="column">
                                        <div class="row">
                                         
                                           <div id="register" class="registration" >
                                                                      <h5 style="margin-left: 70px;">JOIN NOW</h5>
                                                                      <g:form class="ui tiny form" style="margin-bottom: 19px;" controller='user' action='register'>
                                                                      
                                                                      
																		   <div class="errors">
                                                                        	<g:hasErrors bean="${user}">
                                                                        		<div class="moreErr">
																		        <g:renderErrors bean="${user}"/>
																		        </div>
																		    </g:hasErrors>
																		    
                                                                      			<g:if test="${flash.message}">
																		        	<div class="moreErr">${flash.message}</div>
																		        </g:if>
																		   </div>
                                                                             <div class="field">
                                                                            <label for="name">Name</label>
                                                                            <g:textField name="name" required=""  />
                                                                            </div>
                                                                            
                                                                            <div class="field">
                                                                            <label for="emailAddress">Email Address</label>
                                                                            <g:textField name="emailAddress" required=""   />
                                                                            </div>
                                                                            
                                                                            <div class="field">
                                                                            <label for="username">User name</label>
                                                                            <g:textField name="username" required="" />
                                                                            </div>
                                                                            
                                                                            <div class="field">
                                                                            <label for="password">Password</label>
                                                                            <g:field type="password" required="" name="password"   />  
                                                                            </div>
                                                                           	
                                                                           	<div class="field">
                                                                            <label for="confirm">Confirm Password</label>
                                                                            <g:field type="password" required="" name="confirm"   />
                                                                           </div>
                                                                             <g:submitButton class="ui fluid large blue submit button" name="submitButton" value="Register" />
                                                                          
                                                                        
																		
                                                                    </g:form>
                                                                   
                                              </div> 
                                        </div> 
                                      </div>
               </div>
            </div>
       </div>
       </div>
                   
</body>
</html>
