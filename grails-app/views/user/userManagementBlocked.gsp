<html>
<head>
<%@ page import="java.util.Calendar"%>
<!-- Standard Meta -->
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0">

<!-- Site Properities -->
<title>Blocked</title>
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
					<g:link class="item" id="reports" action="userManagementReports"> Reports </g:link>
					<g:link class="item active" id="blocked"
						action="userManagementBlocked">
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
						<g:each in="${block}" status="i" var="blocked">
							<g:remoteLink controller="user" action="showUserInfo"
								update="userInfo" id="${blocked.user.id}" update="userInfo"
								params="${[type:"blocked", userId:blocked.user.id, reportId:blocked.id]}">
								<div class="ui segment"
									style="height: 160px; width: 640px; padding-top: 20px; margin-top: 0px;">
									<g:if test="${blocked.user.avatar}">
										<img class="ui tiny left floated image"
											src="${createLink(controller:'user', action:'avatar_image', id:"${blocked.user.id}" )}" />
									</g:if>
									<g:else>
										<img class="ui tiny left floated image"
											src="${resource(dir: 'images', file: "nan.jpg")}">
									</g:else>
									<div class="ui 3 column stackable grid"
										style="margin-left: 62px; margin-bottom: 0px; margin-right: 0px; margin-top: 0px;">
										<h5 style="padding-left: 10px; margin-bottom: 0px;">
											${blocked.user.name }
										</h5>
										<div class="row"
											style="padding-bottom: 13px; padding-top: 5px; border-top-width: 5px; margin-top: 0px; margin-left: 3px;">
											<a style="margin-bottom: 5px; margin-left: 7px;"> ${blocked.type}</a>
										</div>
									</div>
								</div>
							</g:remoteLink>
						</g:each>
					</div>
					<div class="pagination" style="text-align: center;">
						<g:paginate action="userManagementBlocked" max="10" offset="0" total='${blockedCount }'/>

					</div>
				</div>
				<div class="ui two row stackable grid" >
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
				<i class="close icon"></i>
				<div class="header">
					${flash.success }
				</div>
			</div>
		</div>
	</g:if>
	<g:javascript>

	</g:javascript>
</body>
</html>
<script>
$('.ui.small.modal').modal('show');
</script>