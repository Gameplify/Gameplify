	<div class="ui two row stackable grid">
					<div class="column">
						<div class="row">

							<div id="register" class="registration">
								<h5 style="margin-left: 70px;">JOIN NOW</h5>
								<g:form class="ui tiny form" style="margin-bottom: 20px; height:auto;" 
									controller='user' action='register'>

								<g:if test="${flash.cnt>0||user}">
									<div class="errors">
										<g:hasErrors bean="${user}">
											<div class="moreErr">
												<g:renderErrors bean="${user}" />
											</div>
										</g:hasErrors>
									
										<div class="moreErr">
										<g:if test="${flash.message}">
										
												${flash.message}
												</g:if>
												<g:if test="${flash.username}">
												${flash.username }
												</g:if>
												<g:if test="${flash.email}">
												${flash.email }
												</g:if>
												<g:if test="${flash.integer}">
												${flash.integer}
												</g:if>
												<g:if test="${flash.user}">
												${flash.user}
												</g:if>
												<g:if test="${flash.emailInv}">
												${flash.emailInv}
												</g:if>
										
										</div>
										
									</div>
									</g:if>
									<div class="field">
										<label for="name">Name</label>
										<g:textField name="name" required="" maxlength="50" />
									</div>

									<div class="field">
										<label for="emailAddress">Email Address</label>
										<g:textField name="emailAddress" required="" maxlength="50"/>
									</div>

									<div class="field">
										<label for="username">User name</label>
										<g:textField name="username" required="" maxlength="50"/>
									</div>

									<div class="field">
										<label for="password">Password</label>
										<g:field type="password" required="" name="password" maxlength="50" />
									</div>

									<div class="field">
										<label for="confirm">Confirm Password</label>
										<g:field type="password" required="" name="confirm" maxlength="50" />
									</div>
									<g:submitButton class="ui fluid large blue submit button"
										name="submitButton" value="Register" />
								</g:form>
								
								
								
							</div>
						</div>
					</div>
				</div>