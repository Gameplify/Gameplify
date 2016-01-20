<g:each in="${activities}" status="i" var="activity">

<div class="ui segment" 
	style="width: 700px; height: auto; margin-top: 10px">
	<div class="ui grid">
		<div class="ten wide column">
			${activity.action }
		</div>
<<<<<<< HEAD
		<div class="three wide column">
			<g:formatDate format="MMM d, yyyy h:mm a" date="${activity.date}" />
=======
		<div class="five wide column">
			<g:formatDate format="h:mm a MMM d, yyyy" date="${activity.date}" />
>>>>>>> 6d98908a68f5cef5cb60c29c7f760b922e54542b
		</div>
	</div>
</div>

</g:each>