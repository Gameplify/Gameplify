
<!DOCTYPE html>
<html>
<head>
  <!-- Standard Meta -->
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">

  <!-- Site Properities -->
  <title>Admin Profile</title>
  <link rel="stylesheet" type="text/css"
	href="${resource(dir:'dist', file:'bg.css')}">
    <link rel="stylesheet" type="text/css" href="${resource(dir:'css', file:'semantic.css')}">
 <link rel="stylesheet" type="text/css" href="${resource(dir:'dist', file:'semantic.css')}">
  <script src="${resource(dir:'dist', file:'semantic.min.js')}"></script>
 
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
                                     <h3>Reviews</h3>
                                  </div>
                             	
                   		</div>
                <div class="ui two row stackable grid">
                          <div class="column">
                                  <div class="row">
                                       
                                                 <g:include controller="user" action="showUserAuthentication"/>
                                     
                                  </div> 
                                  <div class="ui segment" style="margin-left: 40px;margin-top: 20px; height: 344px;width: 272px;">
                                  	<div class="column">                         
                                     	<h3>Admins</h3>
                                         	<g:each in="${admins}" status="i" var="admin">
                                         		<div class="ui segment" style= "height: 80px;">
                                         			<g:if test="${user.avatar }">
                                     		<img style="height:170px; width:170px; margin:35px;"class="ui image" src="${createLink(controller:'user', action:'avatar_image', id:"${user.id}" )}" />
                                     		</g:if><g:else>
															    <img class="photo" src="${resource(dir: 'images', file: "nan.jpg")}">
															    </g:else>
															    
                                         			<span style = "text-align:center">${admin.name }</span>
                                         		</div>
                                         	</g:each>
                                         </div>    
                                   	</div>
                                 </div>
                            </div>
                            </div>
            </div>
       </div>
                   
</body>
</html>
