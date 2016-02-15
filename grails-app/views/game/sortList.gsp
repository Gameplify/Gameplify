<div class="ui cards"
	style="margin-bottom: 20px; margin-left: 50px; margin-right: 50px; margin-top: 20px;">

	<g:each in="${games}" status="i" var="game">
		<g:link action="gameProfile"
			params="${[gameTitle: "${game.gameTitle}"]}">

			<div class="ui segment"
				style="height: 120px; width: 270px; padding-top: 20px; margin-left: 40px; margin-top: 0px;">
				<img class="ui tiny left floated image"
					src="${resource(dir: 'images', file: "${game.gameLogo}")}">
					<div class="ui grid"
										style="float: right; margin-right: 1px; margin-top: 0px;">
										<g:each in="${taskL}" status="g" var="ss">
											<g:if test="${ss.averageRating >0}">
												<g:set var="ga" value="${game.gameTitle}" />
												<g:if test="${ss.gameTitle==ga }">
													<img class="ui tiny centered image"
														style="width: 25px; height: 25px; padding-right: 0px;"
														src="${resource(dir: 'images', file: "hot.png")}" />
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
				<div class="ui 3 column stackable grid"
					style="margin-left: 62px; margin-bottom: 0px; margin-right: 0px; margin-top: 0px;">
					<h5 style="padding-left: 10px; margin-bottom: 0px;">
						${game.gameTitle }
					<br>$   ${game.gamePrice }
					</h5>
					<div class="row"
						style="padding-bottom: 13px; padding-top: 5px; border-top-width: 5px; margin-top: 0px; margin-left: 3px;">
						<g:each var="category" in="${game.categories}">
							<a style="margin-bottom: 5px; margin-left: 7px;"> ${category.categoryName }</a>

						</g:each>
					</div>
				</div>
			</div>
		</g:link>

	</g:each>

</div>