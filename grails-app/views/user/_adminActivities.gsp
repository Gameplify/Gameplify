<g:each in="${activities}" status="i" var="activity">

<div class="ui segment" 
	style="width: 700px; height: auto; margin-top: 10px">
	<div class="ui grid">
		<div class="ten wide column">
			${activity.action }
		</div>
		<div class="five wide column">
			<g:formatDate format="h:mm a MMM d, yyyy" date="${activity.date}" />
		</div>
	</div>
</div>

</g:each>