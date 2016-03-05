<html>
<head>
<%@ page import="java.util.Calendar"%>
<!-- Standard Meta -->
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0">

<!-- Site Properities -->
<title>Reports</title>
<link rel="stylesheet" type="text/css"
	href="${resource(dir:'css', file:'semantic.css')}">
<link rel="stylesheet" type="text/css"
	href="${resource(dir:'dist', file:'semantic.css')}">
<link rel="stylesheet" type="text/css"
	href="${resource(dir:'dist', file:'bg.css')}">
<script src="${resource(dir:'dist/components', file:'semantic.min.js')}"></script>
<g:javascript library="prototype"></g:javascript>
</head>
<body>
	<div class="ui fixed inverted menu">
		<g:include controller="game" action="showNavbar" />
	</div>
	<div class="background blue-purple"></div>
	<div class="background green-blue"></div>
	<div class="svg-wrapper">
		<div class="ui two column stackable grid">
			<div class="row" style="margin-left: 0px;">
				<div class="ui top attached pointing tabular menu"
					style="height: auto; width: 770px;">
					<g:link class="item active" id="reports"
						action="userManagementReports"> Reports </g:link>
					<g:link class="item" id="blocked" action="userManagementBlocked">
					Blocked
				</g:link>
				</div>
				<div class="ui segment"
					style="width: 770px; height: auto; margin-top: 0px;">
					<div class="ui cards"
						style="margin-bottom: 20px; margin-left: 50px; margin-right: 50px; margin-top: 20px;">
						<g:if test="${flash.error}">
							<div class="message" style="width: 200px;">
								${flash.error }
							</div>
						</g:if>
						<g:each in="${reports}" status="i" var="report">

							<div class="ui segment"
								style="height: 160px; width: 640px; padding-top: 20px; margin-top: 0px; z-index: 1">
								<g:remoteLink controller="user" action="showUserInfo"
									id="${report.user.id }" update="userInfo"
									params="${[type:"report", userId:report.user.id, reportId:report.id]}">
									<g:if test="${report.user.avatar}">
										<img class="ui tiny left floated image"
											src="${createLink(controller:'user', action:'avatar_image', id:"${report.user.id}" )}" />
									</g:if>
									<g:else>
										<img class="ui tiny left floated image" style="width: 70px;"
											src="${resource(dir: 'images', file: "nan.jpg")}">
									</g:else>
									<div
										style="position: absolute; margin-top: 80px; width: 80; margin-left: 1px;">
										<g:form controller="user" action="ignoreReport">
											<g:hiddenField name="reportId" value="${report.id}" />
											<g:submitButton class="ui centered mini red button"
												style="position:absolute;" value="IGNORE" name="ignore"
												onclick="return confirm('Are you sure you want to ignore this report?')" />
										</g:form>
									</div>
									<div class="ui 3 column stackable grid"
										style="margin-left: 62px; margin-bottom: 0px; margin-right: 0px; margin-top: 0px;">
										<h5 style="padding-left: 10px; margin-bottom: 0px;">
											${report.user.name}
										</h5>
										<div class="row"
											style="padding-bottom: 13px; padding-top: 5px; border-top-width: 5px; margin-top: 0px; margin-left: 3px;">
											<a style="margin-bottom: 5px; margin-left: 7px;"> ${report.type }
											</a>
										</div>
									</div>
								</g:remoteLink>
							</div>

						</g:each>
					</div>
					<%--<g:each in="${reports}" var="report"></g:each>--%>
					<div class="pagination" style="text-align: center;">
						<g:paginate action="userManagementReports" max="10" offset="0"
							total='${reportCount }' />
					</div>

				</div>

				<div class="ui two row stackable grid">
					<div class="column">
						<div class="row">
							<g:include controller="user" action="showUserAuthentication" />
						</div>
						<div class="row" id="userInfo"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<g:if test="${flash.success }">
		<div class="ui small modal">
			<div class="ui positive message">
				<div class="header">
					${flash.success }
				</div>
			</div>
		</div>
	</g:if>
	<%-- Comment --%>
	
</body>
</html>
<script>
$('.ui.small.modal').modal('show');
</script>