

<div class="ui container">
	<g:link action="index">
		<div href="#" class="header item">
			<img class="logo"
				src="${resource(dir: 'images', file: 'gameplifylogo.png')}" />
			GAMEPLIFY
		</div>
	</g:link>
</div>
<g:if test="${session?.user?.role == "Admin"}">
	<div class="header item">
		<div id="demo_admin">
			<span class="pop_ctrl">Game</span>
			<ul id="demo_ul" style="margin-top: 22px; margin-left: -815px;">
				<g:each in="${categories}" status="i" var="cat">
					<li class="demo_li"><g:link action="gameManagement"
							params="${[categoryName: cat.categoryName]}">
							<img id="icon"
								src="${resource(dir: 'icons', file: "${cat.icon}")}">
							<div>
								${cat.categoryName}
							</div>
						</g:link></li>
				</g:each>
			</ul>
		</div>
	</div>
	<div class="header item"><g:link controller="user" action="userManagement_reports">User</g:link></div>
</g:if>
<div class="ui search">
	<div class="ui icon input">
		<input class="prompt" type="text" placeholder="Search games...">
		<i class="search icon"></i>
	</div>
	<div class="results"></div>
</div>
<g:if test="${session?.user?.role != "Admin"}">
	<div id="demo_box">
		<span class="pop_ctrl"><img id="navi"
			src="${resource(dir: 'icons', file: 'nav.png')}"></span>
		<ul id="demo_ul">
			<g:each in="${categories}" status="i" var="cat">
				<li class="demo_li"><g:link action="listGame"
						params="${[categoryName: cat.categoryName]}">
						<img id="icon"
							src="${resource(dir: 'icons', file: "${cat.icon}")}">
						<div>
							${cat.categoryName}
						</div>
					</g:link></li>
			</g:each>
		</ul>
	</div>
</g:if>



<script src="${resource(dir:'js', file:'jquery.min.js')}"></script>
<script src="${resource(dir:'dist', file:'semantic.min.js')}"></script>
<script src="${resource(dir:'js', file:'jquery.popmenu.js')}"></script>
<script>
	$(function() {
		$('#demo_box').popmenu();
		$('#demo_admin').popadminmenu();
	});
</script>


