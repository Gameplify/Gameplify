<div>
	<a class="ui red ribbon label"> ${game.averageRating}
	</a>
	<div class="ui grid"
		style="float: right; margin-right: 1px; margin-top: 0px;">
		<g:each in="${games}" status="g" var="ss">
			<g:if test="${ss.averageRating >0}">
				<g:set var="ga" value="${game.gameTitle}" />
				<g:if test="${ss.gameTitle==ga }">
					<img class="ui tiny centered image"
						style="width: 25px; height: 25px; padding-right: 0px;"
						src="${resource(dir: 'images', file: "hot.png")}"/>
				</g:if>
			</g:if>
		</g:each>
		<g:each in="${bb}" status="h" var="aa">
			<g:set var="da" value="${game.gameTitle}" />
			<g:if test="${aa.gameTitle==da }">
				<img class="ui tiny centered image"
					style="width: 25px; height: 25px; padding-right: 0px;"
					src="${resource(dir: 'images', file: "neww.png")}" />
			</g:if>
		</g:each>
	</div>
</div>
<img class="ui tiny centered image" style="width: 150px; height: 150px;"
	src="${resource(dir: 'images', file: "$game.gameLogo")}">
<div class="center aligned column">
	<h4 class="title">
		${game.gameTitle }
	</h4>
	<h5 class="price">
		$
		${game.gamePrice }

	</h5>
	<h5 class="title">
		${game.numberOfRaters }

	</h5>
</div>