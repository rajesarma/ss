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

<!--			str+="<td>"+lastRow+"<input type=\"hidden\" id=\"userExperiences["+lastRow+"].id\" name=\"userExperiences["+lastRow+"].id\" ></td>";-->

		function addRow (id) {
			var tbl = document.getElementById(id);
		   	var lastRow = tbl.rows.length-1;
		   	var str="";
			str+="<tr>";
			str+="<td>"+(lastRow+1)+"</td>";
			str+="<td><input type=\"text\" id=\"userExperiences["+lastRow+"].company\" name=\"userExperiences["+lastRow+"].company\" class=\"span2\" onkeyup=\"charOnly(this)\" maxlength=\"100\"> </td>";
			str+="<td><input type=\"text\" id=\"userExperiences["+lastRow+"].expMonths\" name=\"userExperiences["+lastRow+"].expMonths\" class=\"span2\" onkeyup=\"intOnly(this)\" maxlength=\"3\"> </td>";
			str+="<td><input type=\"text\" id=\"userExperiences["+lastRow+"].fromDate\" name=\"userExperiences["+lastRow+"].fromDate\" class=\"span2\" onkeyup=\"buildDate(this)\" onblur=\"isValidDate(this);\"> </td>";
			str+="<td><input type=\"text\" id=\"userExperiences["+lastRow+"].toDate\" name=\"userExperiences["+lastRow+"].toDate\" class=\"span2\" onkeyup=\"buildDate(this)\" onblur=\"isValidDate(this);\"> </td>";
			str+="</tr>";
			$("#jobSeekerExperiences > tbody").append(str);
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
			<form:hidden path="fullName" name="fullName" id="fullName" />
			<form:hidden path="password" name="password" id="password" />
			<form:hidden path="fatherName" name="fatherName" id="fatherName" />
			<form:hidden path="dob" name="dob" id="dob" />
			<form:hidden path="mobile" name="mobile" id="mobile" />
			<form:hidden path="alternateNo" name="alternateNo" id="alternateNo" />
			<form:hidden path="aadhar" name="aadhar" id="aadhar" />
			<form:hidden path="email" name="email" id="email" />
			<form:hidden path="gender" name="gender" id="gender" />
			<form:hidden path="address" name="address" id="address" />

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
								<table class="table table-striped table-bordered table-hover table-condensed" id="jobSeekerExperiences">
									<thead>
										<tr>
											<th>#</th>
											<th>Company</th>
											<th>Exp. in Months</th>
											<th>From Date <spring:message code="dateFormat"/></th>
											<th>To Date <spring:message code="dateFormat"/></th>
											<th><input type="button" value="Add Row" onclick="addRow('jobSeekerExperiences')" class="btn btn-primary buttony .inputy" /></th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${jobSeekerDto.userExperiences}" var="exp" varStatus="row">
											<tr>
												<td align="center">
													${row.count}
													<form:hidden path="userExperiences[${row.index}].id"
																 name="userExperiences[${row.index}].id"
																 id="userExperiences[${row.index}].id"
																 value="${exp.id}"
													/>
												</td>
												<td>
													<form:input path="userExperiences[${row.index}].company"
																name="userExperiences[${row.index}].company"
																id="userExperiences[${row.index}].company"
																value="${exp.company}"
																maxlength="100"
																cssClass="span3"
																onkeyup="charOnly(this)"
													/>
												</td>
												<td>
													<form:input path="userExperiences[${row.index}].expMonths"
																name="userExperiences[${row.index}].expMonths"
																id="userExperiences[${row.index}].expMonths"
																value="${exp.expMonths}"
																maxlength="3"
																cssClass="span1"
																onkeyup="intOnly(this)"
													/>
												</td>
												<td>
													<form:input path="userExperiences[${row.index}].fromDate"
																name="userExperiences[${row.index}].fromDate"
																id="userExperiences[${row.index}].fromDate"
																value="${exp.fromDate}"
																cssClass="span2"
																onkeyup="buildDate(this)"
																onblur="isValidDate(this);"
													/>
												</td>
												<td>
													<form:input path="userExperiences[${row.index}].toDate"
																name="userExperiences[${row.index}].toDate"
																id="userExperiences[${row.index}].toDate"
																value="${exp.toDate}"
																cssClass="span2"
																onkeyup="buildDate(this)"
																onblur="isValidDate(this);"
													/>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
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