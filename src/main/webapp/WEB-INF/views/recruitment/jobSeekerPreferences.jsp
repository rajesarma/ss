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
			var form = document.getElementById('jobSeekerPreferences');
			form.action = action;
			form.method = method;
			form.submit();
		}

		function addRow(id) {

		if(id == 'jobSeekerQualifications') {
				var tbl = document.getElementById(id);
				var lastRow = tbl.rows.length-1;
				var str="";
				str+="<tr id=\"qlyRow"+(lastRow+1)+"\">";
				str+="<td>"+(lastRow+1)+"</td>";
				str+="<td><input type=\"text\" id=\"userQualifications["+lastRow+"].qualification\" name=\"userQualifications["+lastRow+"].qualification\" class=\"span2\" onkeyup=\"charOnly(this)\" maxlength=\"100\"> </td>";
				str+="<td><input type=\"text\" id=\"userQualifications["+lastRow+"].specialization\" name=\"userQualifications["+lastRow+"].specialization\" class=\"span2\" onkeyup=\"charOnly(this)\" maxlength=\"100\"> </td>";
				str+="<td><input type=\"text\" id=\"userQualifications["+lastRow+"].instituteName\" name=\"userQualifications["+lastRow+"].instituteName\" class=\"span2\" onkeyup=\"charOnly(this)\" maxlength=\"100\"> </td>";
				str+="<td><input type=\"text\" id=\"userQualifications["+lastRow+"].boardUniversity\" name=\"userQualifications["+lastRow+"].boardUniversity\" class=\"span2\" onkeyup=\"charOnly(this)\" maxlength=\"100\"> </td>";
				str+="<td><input type=\"text\" id=\"userQualifications["+lastRow+"].percentage\" name=\"userQualifications["+lastRow+"].percentage\" class=\"span1\" onkeyup=\"intOnly(this)\" maxlength=\"5\"> </td>";
				str+="<td><input type=\"text\" id=\"userQualifications["+lastRow+"].startDate\" name=\"userQualifications["+lastRow+"].startDate\" class=\"span2\" onkeyup=\"buildDate(this)\" onblur=\"isValidDate(this);\"> </td>";
				str+="<td><input type=\"text\" id=\"userQualifications["+lastRow+"].completionDate\" name=\"userQualifications["+lastRow+"].completionDate\" class=\"span2\" onkeyup=\"buildDate(this)\" onblur=\"isValidDate(this);\"> </td>";
				str+="<td style=\"text-align:center\">";
				str+="<a href='javaScript:void()' onclick=\"submitData('${action}', '${method}')\"><i class=\"icon-ok\" style=\"color:green\"></i></a>";
				str+="<a href='javaScript:void()' onclick=\"deleteRow('jobSeekerQualifications', "+(lastRow+1)+")\"><i class=\"icon-trash\" style=\"color:red\"></i></a></td>";

				str+="</tr>";
				$("#jobSeekerQualifications > tbody").append(str);

			} else if(id == 'jobSeekerExperiences') {
				var tbl = document.getElementById(id);
				var lastRow = tbl.rows.length-1;
				var str="";
				str+="<tr id=\"expRow"+(lastRow+1)+"\">";
				str+="<td>"+(lastRow+1)+"</td>";
				str+="<td><input type=\"text\" id=\"userExperiences["+lastRow+"].company\" name=\"userExperiences["+lastRow+"].company\" class=\"span2\" onkeyup=\"charOnly(this)\" maxlength=\"100\"> </td>";
				str+="<td><input type=\"text\" id=\"userExperiences["+lastRow+"].expMonths\" name=\"userExperiences["+lastRow+"].expMonths\" class=\"span1\" onkeyup=\"intOnly(this)\" maxlength=\"3\"> </td>";
				str+="<td><input type=\"text\" id=\"userExperiences["+lastRow+"].fromDate\" name=\"userExperiences["+lastRow+"].fromDate\" class=\"span2\" onkeyup=\"buildDate(this)\" onblur=\"isValidDate(this);\"> </td>";
				str+="<td><input type=\"text\" id=\"userExperiences["+lastRow+"].toDate\" name=\"userExperiences["+lastRow+"].toDate\" class=\"span2\" onkeyup=\"buildDate(this)\" onblur=\"isValidDate(this);\"> </td>";
				str+="<td><input type=\"text\" id=\"userExperiences["+lastRow+"].designation\" name=\"userExperiences["+lastRow+"].designation\" class=\"span2\" onkeyup=\"charOnly(this)\"> </td>";
				str+="<td><input type=\"text\" id=\"userExperiences["+lastRow+"].jobLocation\" name=\"userExperiences["+lastRow+"].jobLocation\" class=\"span2\" onkeyup=\"charOnly(this)\"> </td>";
				str+="<td><input type=\"checkbox\" id=\"userExperiences["+lastRow+"].isCurrentJob\" name=\"userExperiences["+lastRow+"].isCurrentJob\" class=\"checkbox\"></td>";
				str+="<td style=\"text-align:center\">";
				str+="<a href='javaScript:void()' onclick=\"submitData('${action}', '${method}')\"><i class=\"icon-ok\" style=\"color:green\"></i></a>";
				str+="<a href='javaScript:void()' onclick=\"deleteRow('jobSeekerExperiences', "+(lastRow+1)+")\"><i class=\"icon-trash\" style=\"color:red\"></i></a></td>";
				str+="</tr>";
				$("#jobSeekerExperiences > tbody").append(str);

			}
		}

		function deleteRow(type, index)
		{
			var lastRow;
			var tb1 = document.getElementById(type);

			lastRow = tb1.rows.length-1;

			if(lastRow==1) {
				alert("You Cann\'t Delete This Row");
				return false;
			} else {
				// if id present for a row, then send request to controller, else just remove the row
				if(type == 'jobSeekerQualifications') {
					var element =  document.getElementById("userQualifications["+(index-1)+"].id");
					if (typeof(element) != 'undefined' && element != null) {
						updatePreferences(type, element.value);
					} else {
						$("#qlyRow"+index).remove();
					}
				} else if(type == 'jobSeekerExperiences') {
					var element =  document.getElementById("userExperiences["+(index-1)+"].id");
					if (typeof(element) != 'undefined' && element != null) {
						updatePreferences(type, element.value);
					} else {
						$("#expRow"+index).remove();
					}
				}
			}
		}

		function updatePreferences(type, id) {

			var form = document.getElementById('jobSeekerPreferences');
			form.action = '/recruitment/jobSeekerPreferences/' + type + '/' + id;
			form.method = "POST";
			form.submit();
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
			<form:form action="/recuitment/jobSeekerPreferences" id="jobSeekerPreferences" method="${method}"
					   modelAttribute="jobSeekerDto" enctype="multipart/form-data"
					   cssClass="form-horizontal">

			<form:hidden path="id" name="id" id="id" />
			<form:hidden path="firstName" name="firstName" id="firstName" />
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
								<li><label><strong>Full Name : </strong>${jobSeekerDto.firstName}</label></li>
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
								<table class="table table-striped table-bordered table-hover table-condensed" id="jobSeekerQualifications">
									<thead>
									<tr>
										<th>#</th>
										<th>Qualification</th>
										<th>Specialization</th>
										<th>Institute Name</th>
										<th>Board / University</th>
										<th>Percentage</th>
										<th><input type="button" value="Add Row" onclick="addRow('jobSeekerQualifications')" class="btn btn-primary buttony .inputy" /></th>
									</tr>
									</thead>
									<tbody>
									<c:forEach items="${jobSeekerDto.userQualifications}" var="qly" varStatus="row">
										<tr id="qlyRow${row.count}">
											<td align="center">
												${row.count}
												<form:hidden path="userQualifications[${row.index}].id"
															 name="userQualifications[${row.index}].id"
															 id="userQualifications[${row.index}].id"
															 value="${qly.id}"
												/>
											</td>
											<td>
												<form:input path="userQualifications[${row.index}].qualification"
															name="userQualifications[${row.index}].qualification"
															id="userQualifications[${row.index}].qualification"
															value="${qly.qualification}"
															maxlength="100"
															cssClass="span2"
															onkeyup="charOnly(this)"
												/>
											</td>

											<td>
												<form:input path="userQualifications[${row.index}].specialization"
															name="userQualifications[${row.index}].specialization"
															id="userQualifications[${row.index}].specialization"
															value="${qly.specialization}"
															cssClass="span2"
															onkeyup="charOnly(this)"
												/>
											</td>

											<td>
												<form:input path="userQualifications[${row.index}].instituteName"
															name="userQualifications[${row.index}].instituteName"
															id="userQualifications[${row.index}].instituteName"
															value="${qly.instituteName}"
															cssClass="span2"
															onkeyup="charOnly(this)"
												/>
											</td>

											<td>
												<form:input path="userQualifications[${row.index}].boardUniversity"
															name="userQualifications[${row.index}].boardUniversity"
															id="userQualifications[${row.index}].boardUniversity"
															value="${qly.boardUniversity}"
															cssClass="span2"
															onkeyup="charOnly(this)"
												/>
											</td>
											<td>
												<form:input path="userQualifications[${row.index}].percentage"
															name="userQualifications[${row.index}].percentage"
															id="userQualifications[${row.index}].percentage"
															value="${qly.percentage}"
															maxlength="5"
															cssClass="span1"
															onkeyup="intOnly(this)"
												/>
											</td>
											<td>
												<form:input path="userQualifications[${row.index}].startDate"
															name="userQualifications[${row.index}].startDate"
															id="userQualifications[${row.index}].startDate"
															value="${qly.startDate}"
															cssClass="span2"
															onkeyup="buildDate(this)"
															onblur="isValidDate(this);"
												/>
											</td>
											<td>
												<form:input path="userQualifications[${row.index}].completionDate"
															name="userQualifications[${row.index}].completionDate"
															id="userQualifications[${row.index}].completionDate"
															value="${qly.completionDate}"
															cssClass="span2"
															onkeyup="buildDate(this)"
															onblur="isValidDate(this);"
												/>
											</td>

											<td style="text-align:center">
												<a href='javaScript:void()' onclick="submitData('${action}', '${method}')"><i class="icon-ok" style="color:green"></i></a>
												<a href='javaScript:void()' onclick="deleteRow('jobSeekerQualifications', ${row.count})"><i class="icon-trash" style="color:red"></i></a>
											</td>
										</tr>
									</c:forEach>
									</tbody>
								</table>
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
											<th>Designation</th>
											<th>Job Location</th>
											<th>Is Current Job</th>
											<th><input type="button" value="Add Row" onclick="addRow('jobSeekerExperiences')" class="btn btn-primary buttony .inputy" /></th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${jobSeekerDto.userExperiences}" var="exp" varStatus="row">
											<tr id="expRow${row.count}">
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
																cssClass="span2"
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

												<td>
													<form:input path="userExperiences[${row.index}].designation"
																name="userExperiences[${row.index}].designation"
																id="userExperiences[${row.index}].designation"
																value="${exp.designation}"
																cssClass="span2"
																onkeyup="charOnly(this)"
													/>
												</td>

												<td>
													<form:input path="userExperiences[${row.index}].jobLocation"
																name="userExperiences[${row.index}].jobLocation"
																id="userExperiences[${row.index}].jobLocation"
																value="${exp.jobLocation}"
																cssClass="span2"
																onkeyup="charOnly(this)"
													/>
												</td>
												<td>
													<form:checkbox path="userExperiences[${row.index}].isCurrentJob"
																   name="userExperiences[${row.index}].isCurrentJob"
																   id="userExperiences[${row.index}].isCurrentJob"
																   value="${exp.isCurrentJob}"
																   cssClass="checkbox"/>
												</td>
												<td style="text-align:center">
													<a href='javaScript:void()' onclick="submitData('${action}', '${method}')"><i class="icon-ok" style="color:green"></i></a>
													<a href='javaScript:void()' onclick="deleteRow('jobSeekerExperiences', ${row.count})"><i class="icon-trash" style="color:red"></i></a>
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