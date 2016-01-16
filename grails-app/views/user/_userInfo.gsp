<g:if test="${type == "report"}">
	<div class="ui segment"
		style="margin-left: 40px; margin-top: 20px; width: 272px;">
		<div class="column">
			<img class="ui small centered image"
				src="${createLink(controller:'user', action:'avatar_image', id:"${user.id}" )}" />
			<div class="center aligned column">
				<h4 style="text-align: center; margin-bottom: auto;">
					${user.username}
				</h4>
				<h5 style="text-align: center; margin-top: auto;">
					${user.totalNumberOfReviews}
					Reviews
				</h5>
				<g:form controller="user" action="blockUser">
					<g:hiddenField name="userId" value="${user.id}" />
					<g:hiddenField name="reportId" value="${report}"/>
					<g:submitButton class="fluid ui red button" value="BLOCK"
						name="block"
						onclick="return confirm('Are you sure you want to block this user?')"></g:submitButton>
				</g:form>
			</div>
		</div>
	</div>
</g:if>
<g:else>
	<div class="ui segment"
		style="margin-left: 40px; margin-top: 20px; width: 272px;">
		<div class="column">
			<img class="ui small centered image"
				src="${createLink(controller:'user', action:'avatar_image', id:"${user.id}" )}" />
			<div class="center aligned column">
				<h4 style="text-align: center; margin-bottom: auto;">
					${user.username}
				</h4>
				<h5 style="text-align: center; margin-top: auto;">
					${user.totalNumberOfReviews}
					Reviews
				</h5>
				<g:form controller="user" action="unblockUser">
					<g:hiddenField name="userId" value="${user.id}" />
					<g:hiddenField name="reportId" value="${report}"/>
					<g:submitButton class="fluid ui red button" value="UNBLOCK"
						name="unblock"
						onclick="return confirm('Are you sure you want to unblock this user?')"></g:submitButton>
				</g:form>
			</div>
		</div>
	</div>
</g:else>