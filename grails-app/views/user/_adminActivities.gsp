<g:each in="${activities}" status="i" var="activity">

<div class="ui segment"
	style="width: 770px; height: auto; margin-top: 10px">
	<div class="ui grid">
		<div class="three wide column">
			${activity.action }
		</div>
	</div>
</div>

</g:each>