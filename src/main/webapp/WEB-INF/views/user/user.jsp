<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<html>
<head>
	<meta charset="UTF-8">
	<title>User</title>

	<script>
		function submitData(action, method)
		{
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
	<div class="page-wrapper">
		<div class="page-content fade-in-up">

			<div class="ibox">
				<div class="ibox-head">
					<div class="ibox-title">Create User</div>
				</div>

				<div class="ibox-body">
					<div class="span12">
						<div class="err-message" style="text-align:center; color:red"> ${message}</div>
						<div id="wait" class="err-message"></div>
					</div>

					<form:form action="/admin/user" id="user" method="${method}"
							   modelAttribute="userDto" enctype="multipart/form-data">
						<form:hidden path="userId" name="userId" id="userId" />

						<div class="row">
							<div class="col-sm-3 form-group">
								<label>User Name</label>
								<form:input path="username"
											name="username"
											id="username"
											maxlength="25"
											placeholder="User Name"
											cssClass="form-control"
											onkeyup="charOnly(this)"
								/>
								<span class="help-block">
									<form:errors path="username" cssClass="error" />
								</span>
							</div>
							<div class="col-sm-3 form-group">
								<label>Password</label>
								<form:password path="password"
											   name="password"
											   id="password"
											   maxlength="20"
											   placeholder="Password"
											   cssClass="form-control" />
								<span class="help-inline">
									<form:errors path="password" cssClass="error" />
								</span>
							</div>

							<div class="col-sm-3 form-group">
								<label>E-Mail</label>
								<form:input path="email"
											name="email"
											id="email"
											maxlength="50"
											placeholder="E-Mail"
											cssClass="form-control" />
								<span class="help-inline">
									<form:errors path="email" cssClass="error" />
								</span>
							</div>

							<div class="col-sm-3 form-group">
								<label>Is Active</label>
								<br />
								<form:radiobutton path="disabled" value="false" id="disabled"/> Yes
								<form:radiobutton path="disabled" value="true" id="disabled"/> No
								<form:errors path="disabled" cssClass="error" />
							</div>
						</div>
						<div class="row">
							<div class="col-sm-3 form-group">
								<label class="control-label align-left" for="roles">
									<spring:message code="user.roles"/>
								</label>
								<form:select path="roles" name="roles" id="roles" multiple="true"
										 cssClass="form-control" cssStyle="height: 100px">
									<c:forEach items="${roles}" var="role">
										<option value="${role.key}"
											<c:forEach items="${selectedRoleIds}" var="selectedRoleId">
												<c:if test="${role.key eq selectedRoleId}">selected="true"</c:if>
											</c:forEach>
											> ${role.value}
										</option>
									</c:forEach>
								</form:select>
								<span class="help-inline">
									<form:errors path="roles" cssClass="error" />
								</span>
							</div>

							<div class="col-sm-9 form-group">
								<label class="control-label align-left" >
									<spring:message code="user.userDesc"/>
								</label>

								<form:textarea path="userDesc" id="userDesc"
											   cssClass="form-control" rows="3"
											   cssStyle="height: 100px"/>

								<span class="help-inline">
									<form:errors path="userDesc" cssClass="error" />
								</span>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12 form-group" align="center">
								<input type="button" class="btn btn-primary" value="${buttonValue }"
									   onclick="submitData('${action}', '${method}')" />
							</div>
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>