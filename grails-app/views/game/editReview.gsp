<g:form class="ui reply form">
	<div class="field">
		<g:textArea id="text" name="review"> ${review.review}</g:textArea>
		<input name="reviewId" value="${review.id}" type="hidden" /> <input
			name="gameTitle" value="${review.game.gameTitle}" type="hidden" />
	</div>
	<div id="counter"></div>
	<g:actionSubmit id="reviewButton" action="saveNewReview" value="Edit Review"
		class="ui blue labeled submit icon button">
	</g:actionSubmit>
</g:form>
<script src="${resource(dir:'js', file:'javascript.js') }"></script>