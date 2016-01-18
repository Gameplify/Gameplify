
<g:form class="ui reply form">
	<div class="field">
		<g:textArea id="text" name="review" />
		<input name="gameId" value="${game.id}" type="hidden" /> <input
			name="gameTitle" value="${game.gameTitle}" type="hidden" />
	</div>
	<div id="counter"></div>
	<g:actionSubmit id="reviewButton" action="addReview" value="Review"
		class="ui blue labeled submit icon button">

	</g:actionSubmit>
</g:form>