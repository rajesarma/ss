<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<html xmlns:form="http://www.w3.org/1999/html">
<head>
	<meta charset="ISO-8859-1">
	<title>User</title>

	<script>


		function submitData(action, method) {
			var user = document.getElementById('jobSeeker');
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
	</style>
</head>
<body>

	<section id="subintro">
		<div class="jumbotron subhead" id="overview">
			<div class="container">
				<div class="row">
					<div class="span12">
						<div class="centered">
							<h3>
								<spring:message code="jobSeeker.register"/>
							</h3>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<section id="maincontent">
		<div class="container">
			<form:form action="/recuitment/jobSeekerPreferences" id="jobSeeker" method="${method}"
					   modelAttribute="jobSeekerDto" enctype="multipart/form-data"
					   cssClass="form-horizontal">
			<form:hidden path="id" name="id" id="id" />

			<div class="row ">
				<div class="span12">
					<div class="err-message" style="text-align:center"> ${message}</div>

					<div class="err-message" id="wait" ></div>
				</div>

				<div class="span3">
					<aside>
						<div class="widget">
							<h4>Your Profile <a href="${pageContext.request.contextPath}/recruitment/jobSeeker?operation=edit"><i class="icon-pencil"></i></a></h4>
							<ul>
								<li><label><strong>Full Name : </strong>${jobSeekerDto.fullName}</label></li>
								<li><label><strong>Father Name : </strong>${jobSeekerDto.fatherName}</label></li>
								<li><label><strong>Dob : </strong>${jobSeekerDto.dob}</label></li>
								<li><label><strong>Mobile : </strong>${jobSeekerDto.mobile}</label></li>
								<li><label><strong>Alternate No. : </strong>${jobSeekerDto.alternateNo}</label></li>
								<li><label><strong>Aadhar No. : </strong>${jobSeekerDto.aadhar}</label></li>
								<li><label><strong>E-Mail : </strong>${jobSeekerDto.email}</label></li>
								<li><label><strong>Gender : </strong>${jobSeekerDto.gender}</label></li>
								<li><label><strong>Address : </strong>${jobSeekerDto.address}</label></li>
							</ul>
						</div>

					</aside>
				</div>

				<div class="span9">
					<aside>
						<div class="widget">
							<h4>Your Qualifications</h4>
							<ul>
								<li><label><strong>Qualification : </strong>${jobSeekerDto.fullName}</label></li>
							</ul>
						</div>

						<div class="widget">
							<h4>Your Experiences</h4>
							<ul>
								<li><label><strong>Experience : </strong>${jobSeekerDto.fullName}</label></li>
							</ul>
						</div>
					</aside>
				</div>

				<div class="span12">
					<div align="center" style="width: 100%;">
						<input type="button" class="btn btn-primary" value="${buttonValue }"
							   onclick="submitData('${action}', '${method}')" />
					</div>
				</div>
			</div>
			</form:form>
		</div>

	</section>

</body>
</html>