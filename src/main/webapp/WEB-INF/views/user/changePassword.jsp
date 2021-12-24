<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" %>
<!DOCTYPE html>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width initial-scale=1.0">
	<title>Change Password</title>
	<!-- GLOBAL MAINLY STYLES-->

	<script src="${pageContext.request.contextPath}/js/custom/form_validations.js"></script>

	<script>
		function submitData(action, method) {
			var user = document.getElementById('user');
			user.action = action;
			user.method = method;
			user.submit();
		}
	</script>
	<style>
		.error {
			color: #ff0000;
			font-style: italic;
			font-weight: bold;
			font-size: 10px;
		}

		.align-left {
			text-align: left !important;
		}

		.content {
			max-width: 400px;
			margin:0 auto;
		}
		.content form {
			padding: 15px 20px 20px 20px;
			background-color: #fff;
		}

		.login-title {
			margin-bottom: 25px;
			margin-top: 20px;
			text-align: center;
		}
	</style>
</head>
<body class="fixed-navbar sidebar-mini">
	<div class="page-content fade-in-up">
		<div class="content">
			<form:form id="user" action="/changePassword" method="${method}"
						   modelAttribute="userDto">

				<form:hidden path="userId" name="userId" id="userId" />

				<h4 class="login-title">Change Password</h4>

				<div class="span12">
					<div class="err-message" style="text-align:center; color:red"> ${message}</div>
				</div>

				<div class="ibox">
					<div class="ibox-body">
						<div class="form-group">
							<form:password path="password"
										   name="password"
										   id="password"
										   maxlength="20"
										   placeholder="Password"
										   autocomplete="off"
										   cssClass="form-control" />
							<span class="help-block">
								<form:errors path="password" cssClass="error" />
							</span>
						</div>
						<div class="form-group">
							<form:password path="newPassword"
										   name="newPassword"
										   id="newPassword"
										   maxlength="20"
										   placeholder="New Password"
										   autocomplete="off"
										   cssClass="form-control" />
						</div>
						<div class="form-group">
							<input type="button" class="btn btn-info btn-block" value="${buttonValue }"
								   onclick="submitData('${action}', '${method}')" />
						</div>
					</div>
				</div>
			</form:form>
		</div>
	</div>
</body>
</html>