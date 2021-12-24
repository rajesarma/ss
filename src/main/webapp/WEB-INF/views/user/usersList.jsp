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
	<title>Users List</title>

	<%--<link rel="stylesheet" type="text/css"  href="<c:url
	value="${pageContext.request.contextPath}/css/custom/dataTables.jqueryui.min.css" />" />

	<script
			src="${pageContext.request.contextPath}/js/custom/jquery.dataTables.min.js"></script>--%>

	<script>
		$(document).ready(function() {
			$('#usersList').DataTable();
		} );
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
					<div class="ibox-title">User List</div>
				</div>
				<div class="ibox-body">
					<div class="span12">
						<div class="err-message" style="text-align:center; color:red"> ${message}</div>
						<div id="wait" class="err-message"></div>
					</div>

					<form:form action="/admin/usersList" cssClass="form-inline"
							   method="post" modelAttribute="userDto" >

						<label for="roles">
							<spring:message code="user.roles"/>
						</label>
						<span style="padding: 20px"></span>

						<form:select path="roles" name="roles" id="roles" multiple="false"
									 cssClass="form-control">
							<%--<form:options items="${roles}" />--%>
							<c:forEach items="${roles}" var="role">
								<option value="${role.key}"
										<c:forEach items="${selectedRoleIds}" var="selectedRoleId">
											<c:if test="${role.key eq selectedRoleId}">selected="true"</c:if>
										</c:forEach>
								> ${role.value}
								</option>
							</c:forEach>
						</form:select>

						<span style="padding: 20px"></span>

						<button type="submit" class="btn btn-primary">
							Get Data
						</button>
					</form:form>

					<br />
					<br />

					<div class="table-responsive">
						<c:if test="${not empty message}">
							<div class="err-message" style="text-align:center"> ${message}</div>
						</c:if>
						<c:if test="${not empty usersList}">

							<table class="table table-striped table-bordered table-hover table-condensed table-sm" id="usersList">
								<thead>
									<tr>
										<th scope="row">Name</th>
										<th scope="row">e-mail</th>
										<th scope="row">Desc</th>
										<th scope="row">Is Active</th>
										<th scope="row">Action</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${usersList }" var="user" >
										<tr>
											<td>${user.username }</td>
											<td>${user.email }</td>
											<td>${user.userDesc }</td>
											<td>${user.activeStatus }</td>
											<td>
												<a style="color: green; text-decoration: underline;" href="${Role}/user/edit/${user.userId}/update
				"> <spring:message code="edit"/>
												</a>
												<span style="padding: 10px"></span>
												<a style="color: red; text-decoration: underline;"
												   href="${Role}/user/edit/${user.userId}/delete"><spring:message code="delete"/>
												</a>
												<span style="padding: 10px"></span>
													<%--<spring:url value="/article/updateArticle/${article.id }" var="updateURL" />--%>
													<%--<a class="btn btn-primary" href="${updateURL }" role="button" >Update</a>--%>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>