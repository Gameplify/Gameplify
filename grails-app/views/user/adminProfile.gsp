
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
                                         			<img class="ui tiny left floated image" style = "width:50px; height:50px;"src="${resource(dir: 'images', file: "${admin.userPhoto}")}">
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
