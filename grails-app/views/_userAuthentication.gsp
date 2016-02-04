<g:if test="${session?.user}">
	<div class="ui two row stackable grid">
		<div class="column">
			<div class="row">
				<div class="useraccount">
					<g:link controller="user" action="userProfile"
						params="${[userId:"${session?.user?.id}"]}">
						<g:if test="${session?.user?.avatar}">
							<img class="ui tiny left floated image" style="width:70px;"
								src="${createLink(controller:'user', action:'avatar_image', id:"${session?.user?.id}" )}" />
						</g:if>
						<g:else>
							<img class="ui tiny left floated image" style="width:70px;"
								src="${resource(dir: 'images', file: "nan.jpg")}">
						</g:else>
						<span>
							${session?.user?.name}
						</span>
						<g:if test="${session?.user?.status == "blocked"}">
							<img class="block"
								src="${resource(dir: 'images', file: "block.png")}"
								title="You are blocked">

						</g:if>
						<g:link class="ui primary button"
							style=" margin-top: 10px; margin-right: 0px; width: 140px;"
							controller="user" action="logout">Logout</g:link>
					</g:link>

				</div>
			</div>
		</div>
	</div>
</g:if>
<g:else>
	<div class="ui two row stackable grid">
		<div class="column">
			<div class="row">
				<div id="login" class="ui segment"
					style="display: block; height: 370px; width: 270px; padding-top: 20px; margin-left: 40px; margin-top: 0px;">
					<h5 style="margin-left: 70px;">ACCESS PORTAL</h5>
					<g:form class="ui tiny form" style="margin-bottom: 19px;"
						url="[controller:'user',action:'login']">
						<g:if test="${flash.message}">
							<div class="err">
								${flash.message}
							</div>
						</g:if>
						<div class="field">
							<label for="username">User name</label>
							<g:textField name="username" required="" maxlength="50" />

						</div>
						<div class="field">
							<label for="password">Password</label>
							<g:passwordField name="password" required="" maxlength="50"/>

						</div>
						<g:submitButton class="ui fluid large blue submit button"
							name="submitButton" value="Login" />

					</g:form>
					Create an account
					<g:link class="ui fluid large blue submit button" controller="user"
						action="register">Register</g:link>
				</div>

			</div>
		</div>
	</div>
</g:else>
