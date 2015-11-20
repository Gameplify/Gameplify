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
         
              <div class="ui container">
	              <g:link action="index">
	                <div href="#" class="header item">
	                  <img class="logo" src="${resource(dir: 'images', file: 'gameplifylogo.png')}"/>
	                  GAMEPLIFY 
	                </div>
	               </g:link>
              </div>
                <div class="ui search">
                      <div class="ui icon input">
                        <input class="prompt" type="text" placeholder="Search games...">
                        <i class="search icon"></i>
                      </div>
                      <div class="results"></div>
                </div>
                 <div id="demo_box">
            <span class="pop_ctrl"><img id= "navi" src="${resource(dir: 'icons', file: 'nav.png')}"></span>
            <ul id="demo_ul">
            	
				<g:each in="${categories}" status="i" var="cat">				 	
	                <li class="demo_li"><g:link action="listGame" params="${[categoryName: cat.categoryName]}"><img id= "icon" src="${resource(dir: 'icons', file: "${cat.icon}")}"><div>${cat.categoryName}</div></g:link></li>                	
                </g:each>
				
           		
            </ul>
        </div>
       
       
        
        <script src="${resource(dir:'js', file:'jquery.min.js')}"></script>
    <script src="${resource(dir:'js', file:'jquery.popmenu.js')}"></script>
    <script>
        $(function(){
            $('#demo_box').popmenu();
        })
    </script>
       
</body>
</html>
