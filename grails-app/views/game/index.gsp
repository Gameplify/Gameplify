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
                                                
                                        </div>
                                  </div>
                                  <div class="eight wide column">
                                         
                                  </div>
                       </div>
                </div>
  <g:if test="${session?.user}">
                       <div class="ui two row stackable grid">
                          <div class="column">
                                  <div class="row">
                                        <div class="ui segment" style=" height: 120px; width: 270px; padding-top: 20px; margin-left: 40px; margin-top:0px;">
                                                                <img class="ui tiny left floated image" src="${resource(dir: 'images', file: 'nan.jpg')}">
                                                               
															        <span>${session?.user?.name} </span>
															        <g:link class="ui primary button" style=" margin-top: 10px; margin-right: 0px; width: 140px;" controller="user" action="logout">Logout</g:link>

															   
                                                              	 </div> 
                                  </div> 
                            </div>
                      </div>
        </g:if>
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