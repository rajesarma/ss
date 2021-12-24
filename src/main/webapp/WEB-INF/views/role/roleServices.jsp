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
	<title>Role Services List</title>

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

	<script>
		function getServices(obj) {
			$.each($("#services option:selected"), function() {
				$(this).prop('selected', false);
			});

			$.ajax( {
				type : "GET",
				url : '/roleServices/' + obj.value,
				cache : false,
				success : function(response) {
					$("#wait").html("");
					$.each(response, function(i,e){
						$("#services option[value='" + e + "']").prop("selected", true);
					});
				}, error: function(response) {
					$("#wait").html("<center style='font-size: 14px' ><span id='loading' style='font-size: 14px; color:red'><i class='fa fa-spinner fa-spin' style='font-size:24px'></i> <b>" + response.error + "</b></span></center>");
				},
				beforeSend: function( event, ui ) {
					$("#wait").html("<center style='font-size: 14px' ><span id='loading' style='font-size: 14px; color:red'><i class='fa fa-spinner fa-spin' style='font-size:24px'></i> <b>Loading... </b></span></center>");
				}
			});
		}
	</script>
</head>
<body class="fixed-navbar sidebar-mini">
	<div class="page-wrapper">
		<div class="page-content fade-in-up">
			<div class="ibox">
				<div class="ibox-head">
					<div class="ibox-title">Role Services Mapping</div>
				</div>

				<div class="ibox-body">
					<div class="span12">
						<div class="err-message" style="text-align:center; color:red"> ${message}</div>
						<div id="wait" class="err-message"></div>
					</div>

					<form:form action="/super/roleServices" method="post" modelAttribute="role" class="form-inline">
						<label for="roleId">
							<spring:message code="role.role"/>
						</label>
						<span style="padding: 20px"></span>

						<form:select path="roleId" name="roleId" id="roleId" multiple="false"
									 cssClass="form-control" onChange="getServices(this)">
							<%--<form:options items="${roles}" />--%>

							<c:forEach items="${roles}" var="role">
								<option value="${role.key}"
										<c:if test="${role.key eq roleId}">selected="true"</c:if>
								> ${role.value}
								</option>
							</c:forEach>
						</form:select>
						<span style="padding-right: 20px" ></span>
						<label for="roleId">
							<spring:message code="service.services"/>
						</label>
						<span style="padding: 20px"></span>

						<form:select path="services" name="services" id="services"
									 multiple="true" cssStyle="height: 200px; width: 200px"
									 cssClass="form-control">
							<%--<form:options items="${services}" />--%>
							<c:forEach items="${services}" var="role">
								<option value="${role.key}"
										<c:forEach items="${selectedServiceIds}" var="selectedServiceId">
											<c:if test="${role.key eq selectedServiceId}">selected="true"</c:if>
										</c:forEach>
								> ${role.value}
								</option>
							</c:forEach>
						</form:select>

						<span style="padding: 20px"></span>

						<button type="submit" class="btn btn-success">
							Map
						</button>
					</form:form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>