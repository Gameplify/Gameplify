

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
   <g:if test="${session?.user}">
                       <div class="ui two row stackable grid">
                          <div class="column">
                                  <div class="row">
                                        <div class="ui segment" style=" height: 120px; width: 270px; padding-top: 20px; margin-left: 40px; margin-top:0px;">
                                                                <img class="ui tiny left floated image" src="${resource(dir: 'images', file: 'nan.jpg')}">
                                                               
															        <span>${session?.user?.name}</span>
															        <g:link class="ui primary button" style=" margin-top: 10px; margin-right: 0px; width: 140px;" controller="user" action="logout">Logout</g:link>

															   
                                                              	 </div> 
                                  </div> 
                            </div>
                      </div>
       			</g:if>
       			<g:else>
                <div class="ui two row stackable grid">
                                <div class="column">
                                        <div class="row">
                                         <div id="login" class="ui segment" style="display:block; height: 355px; width: 270px; padding-top: 20px; margin-left: 40px; margin-top:0px;">
                                                                      <h5 style="margin-left: 70px;">ACCESS PORTAL</h5>
                                                                      <g:form class="ui tiny form" style="margin-bottom: 19px;" url="[controller:'user',action:'login']">
                                                                            <g:if test="${flash.message}">
																	          <div class="message">${flash.message}</div>
																	      </g:if>
		                                                                        <div class="field">
                                                                                <label for="username">User name</label>
                                                                                <g:textField name="username" />
                                                                              
                                                                            </div>
                                                                            <div class="field">
                                                                                <label for="password">Password</label>
       																			 <g:passwordField name="password" />
                                                                             
                                                                            </div>
                                                                             <g:submitButton class="ui fluid large blue submit button" name="submitButton" value="Login" />
                                                                          
                                                                          <div class="ui error message"></div>

                                                                    </g:form>
                                                                      Create an account 
                                                                       <g:link class="ui fluid large blue submit button" controller="user" action="register">Register</g:link>
                                              </div> 
                                          
                                        </div> 
                                      </div>
               </div>
               </g:else>
 </body>
 </html>