<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width initial-scale=1.0">
    <title>Profile</title>
    <!-- GLOBAL MAINLY STYLES-->

    <link href="<c:url value="${pageContext.request.contextPath}/vendors/bootstrap/dist/css/bootstrap.min.css"/>" rel="stylesheet" />
    <link href="<c:url value="${pageContext.request.contextPath}/vendors/font-awesome/css/font-awesome.min.css"/>" rel="stylesheet" />
    <link href="<c:url value="${pageContext.request.contextPath}/vendors/themify-icons/css/themify-icons.css"/>" rel="stylesheet" />

    <!-- THEME STYLES-->
    <link href="<c:url value="${pageContext.request.contextPath}/css/main.min.css"/>" rel="stylesheet" />

    <script src="${pageContext.request.contextPath}/js/form_validations.js"></script>
    <script src="${pageContext.request.contextPath}/js/date_validations.js"></script>

    <script>
        var openFile = function(event) {
            var input = event.target;
            var output = document.getElementById('photoData');
            $('#photoData').attr('style','visibility: visible');

            var reader = new FileReader();
            reader.onload = function() {
                output.src = reader.result;
                output.width = 80;
                output.height = 90;
            };
            reader.readAsDataURL(input.files[0]);
        };

        function checkData(type,obj, targetId) {
            if(obj.value.length > 0) {
                var url = '/recruitment/profile/' + type + '/' + obj.value;
                var message;
                $.ajax( {
                    type: "GET",
                    url:url,
                    cache: false,
                    success: function(response) {
                        $("#wait").html("");
                        var response = jQuery.parseJSON(response);

                        if(type == "getSkills") {
							if(response.skillsExists == "true") {
								var skills = JSON.parse(response.skills.replace(/'/g,"\""));
                                var options = "<option selected=\"selected\" value=\"0\">Select</option>";
								$.each(skills, function(val, text) {
									options+="<option value="+val+">"+text+"</option>";
								});
								var select2 = document.getElementById(targetId);
                                select2.innerHTML = options;
							}
						} else {
                            var valueExists = response.valueExists;
                            if(valueExists == "true")
                            {
                                var message = response.message;
                                $("#wait").html("<center style='font-size: 14px' ><span id='loading' style='font-size: 14px; color:red'><b>" + message + "</b></span></center><BR>");
                                document.getElementById(targetId).value = "";
                            }
                        }

                    }, error: function(response) {
                        $("#wait").html("<center style='font-size: 14px' ><span id='loading' style='font-size: 14px; color:red'><i class='fa fa-spinner fa-spin' style='font-size:24px'></i> <b>" + response.error + "</b></span></center>");
                    },
                    beforeSend: function( event, ui ) {
                        $("#wait").html("<center style='font-size: 14px' ><span id='loading' style='font-size: 14px; color:red'><i class='fa fa-spinner fa-spin' style='font-size:24px'></i> <b>Loading... </b></span></center>");
                    }
                });
            }
        }

        function addRow(id) {

		    if(id == 'jobSeekerQualifications') {
				var tbl = document.getElementById(id);
				var lastRow = tbl.rows.length-1;
				var str="";
				str+="<tr id=\"qlyRow"+(lastRow+1)+"\">";
				str+="<td align=\"center\">"+(lastRow+1)+"</td>";
				str+="<td><input type=\"text\" id=\"userQualifications["+lastRow+"].qualification\" name=\"userQualifications["+lastRow+"].qualification\" class=\"span2\" onkeyup=\"charOnly(this)\" maxlength=\"100\"> </td>";
				str+="<td><input type=\"text\" id=\"userQualifications["+lastRow+"].specialization\" name=\"userQualifications["+lastRow+"].specialization\" class=\"span2\" onkeyup=\"charOnly(this)\" maxlength=\"100\"> </td>";
				str+="<td><input type=\"text\" id=\"userQualifications["+lastRow+"].instituteName\" name=\"userQualifications["+lastRow+"].instituteName\" class=\"span2\" onkeyup=\"charOnly(this)\" maxlength=\"100\"> </td>";
				str+="<td><input type=\"text\" id=\"userQualifications["+lastRow+"].boardUniversity\" name=\"userQualifications["+lastRow+"].boardUniversity\" class=\"span2\" onkeyup=\"charOnly(this)\" maxlength=\"100\"> </td>";
				str+="<td><input type=\"text\" id=\"userQualifications["+lastRow+"].percentage\" name=\"userQualifications["+lastRow+"].percentage\" class=\"span1\" onkeyup=\"intOnly(this)\" maxlength=\"5\"> </td>";
				str+="<td><input type=\"text\" id=\"userQualifications["+lastRow+"].startDate\" name=\"userQualifications["+lastRow+"].startDate\" class=\"span2\" onkeyup=\"buildDate(this)\" onblur=\"isValidDate(this);\"> </td>";
				str+="<td><input type=\"text\" id=\"userQualifications["+lastRow+"].completionDate\" name=\"userQualifications["+lastRow+"].completionDate\" class=\"span2\" onkeyup=\"buildDate(this)\" onblur=\"isValidDate(this);\"> </td>";
				str+="<td style=\"text-align:center\">";
				str+="<a href='javaScript:void()' onclick=\"submitData()\"><i class=\"icon-ok\" style=\"color:green\"></i></a>";
				str+="<a href='javaScript:void()' onclick=\"deleteRow('jobSeekerQualifications', "+(lastRow+1)+")\"><i class=\"icon-trash\" style=\"color:red\"></i></a></td>";

				str+="</tr>";
				$("#jobSeekerQualifications > tbody").append(str);

			} else if(id == 'jobSeekerExperiences') {
				var tbl = document.getElementById(id);
				var lastRow = tbl.rows.length-1;
				var str="";
				str+="<tr id=\"expRow"+(lastRow+1)+"\">";
				str+="<td align=\"center\">"+(lastRow+1)+"</td>";
				str+="<td><input type=\"text\" id=\"userExperiences["+lastRow+"].company\" name=\"userExperiences["+lastRow+"].company\" class=\"span2\" onkeyup=\"charOnly(this)\" maxlength=\"100\"> </td>";
				str+="<td><input type=\"text\" id=\"userExperiences["+lastRow+"].expMonths\" name=\"userExperiences["+lastRow+"].expMonths\" class=\"span1\" onkeyup=\"intOnly(this)\" maxlength=\"3\"> </td>";
				str+="<td><input type=\"text\" id=\"userExperiences["+lastRow+"].fromDate\" name=\"userExperiences["+lastRow+"].fromDate\" class=\"span2\" onkeyup=\"buildDate(this)\" onblur=\"isValidDate(this);\"> </td>";
				str+="<td><input type=\"text\" id=\"userExperiences["+lastRow+"].toDate\" name=\"userExperiences["+lastRow+"].toDate\" class=\"span2\" onkeyup=\"buildDate(this)\" onblur=\"isValidDate(this);\"> </td>";
				str+="<td><input type=\"text\" id=\"userExperiences["+lastRow+"].designation\" name=\"userExperiences["+lastRow+"].designation\" class=\"span2\" onkeyup=\"charOnly(this)\"> </td>";
				str+="<td><input type=\"text\" id=\"userExperiences["+lastRow+"].jobLocation\" name=\"userExperiences["+lastRow+"].jobLocation\" class=\"span2\" onkeyup=\"charOnly(this)\"> </td>";
				str+="<td><input type=\"checkbox\" id=\"userExperiences["+lastRow+"].isCurrentJob\" name=\"userExperiences["+lastRow+"].isCurrentJob\" class=\"checkbox\"></td>";
				str+="<td style=\"text-align:center\">";
				str+="<a href='javaScript:void()' onclick=\"submitData()\"><i class=\"icon-ok\" style=\"color:green\"></i></a>";
				str+="<a href='javaScript:void()' onclick=\"deleteRow('jobSeekerExperiences', "+(lastRow+1)+")\"><i class=\"icon-trash\" style=\"color:red\"></i></a></td>";
				str+="</tr>";
				$("#jobSeekerExperiences > tbody").append(str);
			} else if(id == 'jobSeekerSkills') {
			    var tbl = document.getElementById(id);
				var lastRow = tbl.rows.length-1;
				var str="";
				str+="<tr id=\"skillRow"+(lastRow+1)+"\">";
				str+="<td align=\"center\">"+(lastRow+1)+"</td>";
                str+="<td><select id=\"userSkills["+lastRow+"].skillTypeId\" name=\"userSkills["+lastRow+"].skillTypeId\" class=\"span2\" onchange=\"checkData('getSkills', this, 'userSkills["+lastRow+"].skillId')\"></select></td>";
                str+="<td><select id=\"userSkills["+lastRow+"].skillId\" name=\"userSkills["+lastRow+"].skillId\" class=\"span3\"><option value=\"0\" selected=\"selected\">Select</option></select></td>";
                str+="<td><input type=\"text\" id=\"userSkills["+lastRow+"].expMonths\" name=\"userSkills["+lastRow+"].expMonths\" class=\"span1\" onkeyup=\"intOnly(this)\" maxlength=\"3\"/></td>";
                str+="<td><input type=\"text\" id=\"userSkills["+lastRow+"].skillLevel\" name=\"userSkills["+lastRow+"].skillLevel\" class=\"span1\" onkeyup=\"intOnly(this)\" maxlength=\"3\"/></td>";
                str+="<td style=\"text-align:center\">";
                str+="<a href='javaScript:void()' onclick=\"submitData()\"> <i class=\"fa fa-check text-success\" style=\"color:green\"></i></a>";
                str+="<a href='javaScript:void()' onclick=\"deleteRow('jobSeekerSkills', "+(lastRow+1)+")\"> <i class=\"fa fa-trash font-14\" style=\"color:red\"></i> </a>";
				str+="</td></tr>";
                $("#jobSeekerSkills > tbody").append(str);

                var select1 = document.getElementById("userSkills[0].skillTypeId");
                var select2 = document.getElementById("userSkills["+lastRow+"].skillTypeId");
                select2.innerHTML = select2.innerHTML+select1.innerHTML;
			}
		}

		function deleteRow(type, index) {
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
				} else if(type == 'jobSeekerSkills') {
					var element =  document.getElementById("userSkills["+(index-1)+"].id");
					if (typeof(element) != 'undefined' && element != null) {
						updatePreferences(type, element.value);
					} else {
						$("#skillRow"+index).remove();
					}
				}
			}
		}

		function updatePreferences(type, id) {

			var form = document.getElementById('personal-details-form');
			form.action = '/recruitment/profile/' + type + '/' + id;
			form.method = "POST";
			form.submit();
        }

        function submitData() {
			var form = document.getElementById('personal-details-form');
			form.submit();
		}

    </script>
<style>
    input {
        font-size: small !important;
    }

</style>

</head>



<body class="fixed-navbar sidebar-mini">
    <div class="page-wrapper">
            <!-- START PAGE CONTENT-->
            <!--<div class="page-heading">

            </div>-->
            <div class="page-content fade-in-up">
                <form:form id="personal-details-form" action="/recruitment/profile" method="POST"
                           modelAttribute="jobSeekerDto" enctype="multipart/form-data">

                    <div class="span12">
                        <div class="err-message" style="text-align:center; color:red" id="wait"> ${message}</div>
                    </div>

                    <!--<div class="row">
                        <div class="col-sm-6 form-group">-->
                            <!--<c:if test="${empty photoData}">
                                <span class="help-inline">
                                    <img src="data:photo;base64,${photoData }" id="photoData"
                                         style='border: 1px solid black; visibility: collapse'
                                         width='80px' class="img-circle"
                                         height='80px'>
                                </span>
                            </c:if>
                            <c:if test="${not empty photoData}">
                                <span class="help-inline">
                                    <img src="data:photo;base64,${photoData }" id="photoData"
                                         style='border: 1px solid black; visibility: visible'
                                         width='80px' class="img-circle"
                                         height='80px'>
                                </span>
                            </c:if>-->
                        <!--</div>-->
                        <!--<div class="col-sm-6 form-group">
                            <h3 class="page-title">${personName}</h3>
                        </div>-->
                    <!--</div>-->
                    <div class="row">
                        <div class="col-lg-12 col-md-12">
                            <div class="ibox">
                                <div class="ibox-body">
                                    <div class="row">
                                        <div class="col-lg-10 col-md-10">
                                            <ul class="nav nav-tabs tabs-line">
                                                <li class="nav-item">
                                                    <a class="nav-link active" href="#tab-1" data-toggle="tab"><i class="ti-bar-chart"></i> Personal Details</a>
                                                </li>
                                                <li class="nav-item">
                                                    <a class="nav-link" href="#tab-2" data-toggle="tab"><i class="ti-bar-chart"></i> Qualifications</a>
                                                </li>
                                                <li class="nav-item">
                                                    <a class="nav-link" href="#tab-3" data-toggle="tab"><i class="ti-settings"></i> Professional Experience</a>
                                                </li>
                                                <li class="nav-item">
                                                    <a class="nav-link" href="#tab-4" data-toggle="tab"><i class="ti-announcement"></i> Skills</a>
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="col-lg-2 col-md-2">
                                            <div class="nav-item pull-right">
                                                <button class="btn btn-info btn-block" type="submit">Update</button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tab-content">
                                        <div class="tab-pane fade show active" id="tab-1">
                                            <!--<h5 class="text-info m-b-20 m-t-10"><i class="fa fa-bar-chart"></i> Personal Details</h5>-->

                                                <div class="row">
                                                    <div class="col-sm-6 form-group">
                                                        <label>First Name</label>
                                                        <form:input path="firstName" name="firstName" id="firstName"
                                                                    cssClass="form-control" maxlength="25"
                                                                    placeholder="First Name"
                                                                    value="${jobSeekerDto.firstName}"
                                                                    onkeyup="charOnly(this)" />
                                                    </div>
                                                    <div class="col-sm-6 form-group">
                                                        <label>Last Name</label>
                                                        <form:input path="lastName" name="lastName" id="lastName"
                                                                    cssClass="form-control" maxlength="25"
                                                                    placeholder="Last Name"
                                                                    value="${jobSeekerDto.lastName}"
                                                                    onkeyup="charOnly(this)" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-sm-6 form-group">
                                                        <label>Father Name</label>
                                                        <form:input path="fatherName" name="fatherName" id="fatherName"
                                                                    cssClass="form-control" maxlength="25"
                                                                    placeholder="Father Name"
                                                                    value="${jobSeekerDto.fatherName}"
                                                                    onkeyup="charOnly(this)" />
                                                    </div>
                                                    <div class="col-sm-6 form-group">
                                                        <label>Email</label>
                                                        <form:input path="email" name="email" id="email"
                                                                    maxlength="50"
                                                                    cssClass="form-control"
                                                                    onblur="checkEmail(this);"
                                                                    onChange="checkData('email', this, this.id)"
                                                                    placeholder="Email"
                                                        />
                                                    </div>

                                                </div>
                                                <div class="row">
                                                    <div class="col-sm-6 form-group">
                                                        <label>Date of Birth</label>
                                                        <form:input path="dob" name="dob" id="dob"
                                                                    cssClass="form-control" maxlength="10"
                                                                    placeholder="Date of Birth"
                                                                    value="${jobSeekerDto.dob}"
                                                                    onkeyup="buildDate(this)"
                                                                    onblur="isValidDate(this);" />
                                                    </div>
                                                    <div class="col-sm-6 form-group">
                                                        <label>Gender</label>
                                                        <br>
                                                        <!--<label class="ui-radio ui-radio-inline">-->
                                                            <form:radiobutton path="gender" value="MALE" id="gender"/> Male
                                                        <!--<label class="ui-radio ui-radio-inline">-->
                                                            <form:radiobutton path="gender" value="FEMALE" id="gender"/> Female
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="col-sm-6 form-group">
                                                        <label>Mobile</label>
                                                        <form:input path="mobile" name="mobile" id="mobile"
                                                                    cssClass="form-control"
                                                                    placeholder="Mobile"
                                                                    maxlength="10"
                                                                    onkeyup="intOnly(this)"
                                                                    onChange="checkData('mobileNo.', this, this.id)"
                                                        />
                                                    </div>
                                                    <div class="col-sm-6 form-group">
                                                        <label>Alternate Contact</label>
                                                        <form:input path="alternateNo" name="alternateNo" id="alternateNo"
                                                                    cssClass="form-control"
                                                                    placeholder="Alternate Contact No."
                                                                    maxlength="10"
                                                                    onkeyup="intOnly(this)"
                                                        />
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="col-sm-6 form-group">
                                                        <label>Aadhar</label>
                                                        <form:input path="aadhar" name="aadhar"
                                                                    id="aadhar" maxlength="12"
                                                                    cssClass="form-control"
                                                                    placeholder="Aadhar"
                                                                    onkeyup="intOnly(this)"
                                                                    onChange="checkData('aadhar', this, this.id)"
                                                        />
                                                    </div>
                                                    <div class="col-sm-6 form-group">
                                                        <label>Postal Code</label>
                                                        <form:input path="postalCode" name="postalCode" id="postalCode"
                                                                    cssClass="form-control"
                                                                    placeholder="Postal Code"
                                                                    maxlength="12"
                                                                    onkeyup="intOnly(this)"
                                                        />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-sm-6 form-group">
                                                        <label>Photo</label>
                                                        <input type="file" name="photo" id="photo" class="form-control" onchange="openFile(event)" />
                                                        <!--<div id="applicantPhotoName" ></div>-->
                                                    </div>
                                                    <div class="col-sm-6 form-group">
                                                        <label>Resume</label>
                                                        <input type="file" name="resume" id="resume" class="form-control" onchange="openFile(event)" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label>Address</label>
                                                    <form:textarea path="address" name="address" id="address"
                                                                   cssClass="form-control" rows="3"
                                                                   cssStyle="height: 100px"/>
                                                </div>
                                        </div>

                                        <div class="tab-pane fade" id="tab-2">
                                                    <!--<h5 class="text-info m-b-20 m-t-10"><i class="fa fa-bar-chart"></i> Qualifications</h5>-->
                                            <table class="table table-striped table-bordered table-hover table-condensed table-sm" id="jobSeekerQualifications">
                                                <thead>
                                                <tr>
                                                    <th>#</th>
                                                    <th>Qualification</th>
                                                    <th>Specialization</th>
                                                    <th>Institute Name</th>
                                                    <th>Board / University</th>
                                                    <th>Percentage</th>
                                                    <th>Start Date</th>
                                                    <th>Completion Date</th>
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
                                                                        onkeyup="charOnly(this)"
                                                            />
                                                        </td>
                                                        <td>
                                                            <form:input path="userQualifications[${row.index}].percentage"
                                                                        name="userQualifications[${row.index}].percentage"
                                                                        id="userQualifications[${row.index}].percentage"
                                                                        value="${qly.percentage}"
                                                                        maxlength="5"
                                                                        onkeyup="intOnly(this)"
                                                            />
                                                        </td>
                                                        <td>
                                                            <form:input path="userQualifications[${row.index}].startDate"
                                                                        name="userQualifications[${row.index}].startDate"
                                                                        id="userQualifications[${row.index}].startDate"
                                                                        value="${qly.startDate}"
                                                                        onkeyup="buildDate(this)"
                                                                        onblur="isValidDate(this);"
                                                            />
                                                        </td>
                                                        <td>
                                                            <form:input path="userQualifications[${row.index}].completionDate"
                                                                        name="userQualifications[${row.index}].completionDate"
                                                                        id="userQualifications[${row.index}].completionDate"
                                                                        value="${qly.completionDate}"
                                                                        onkeyup="buildDate(this)"
                                                                        onblur="isValidDate(this);"
                                                            />
                                                        </td>

                                                        <td style="text-align:center">
                                                            <a href='javaScript:void()' onclick="submitData()">
                                                                <i class="fa fa-check text-success" style="color:green"></i>
                                                            </a>
                                                            <a href='javaScript:void()' onclick="deleteRow('jobSeekerQualifications', ${row.count})">
                                                                <i class="fa fa-trash font-14" style="color:red"></i>
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                                </tbody>
                                            </table>

                                        </div>

                                        <div class="tab-pane fade" id="tab-3">
                                            <!--<h5 class="text-info m-b-20 m-t-20"><i class="fa fa-bullhorn"></i> Professional Experience</h5>-->
                                            <table class="table table-striped table-bordered table-hover table-condensed table-sm" id="jobSeekerExperiences">
                                                <thead>
                                                    <tr>
                                                        <th>#</th>
                                                        <th>Company</th>
                                                        <th>Exp. in Months</th>
                                                        <th>From Date <BR><spring:message code="dateFormat"/></th>
                                                        <th>To Date <BR><spring:message code="dateFormat"/></th>
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
                                                                <a href='javaScript:void()' onclick="submitData()">
                                                                    <i class="fa fa-check text-success" style="color:green"></i>
                                                                </a>
                                                                <a href='javaScript:void()' onclick="deleteRow('jobSeekerExperiences', ${row.count})">
                                                                    <i class="fa fa-trash font-14" style="color:red"></i>
                                                                </a>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>

                                        <div class="tab-pane fade" id="tab-4">
                                            <table class="table table-striped table-bordered table-hover table-condensed table-sm" id="jobSeekerSkills">
                                                <thead>
                                                <tr>
                                                    <th>#</th>
                                                    <th>Skill Type</th>
                                                    <th>Skill</th>
                                                    <th>Exp. in Months</th>
                                                    <th>Level<BR></th>
                                                    <th><input type="button" value="Add Row" onclick="addRow('jobSeekerSkills')" class="btn btn-primary buttony .inputy" /></th>-
                                                </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach items="${jobSeekerDto.userSkills}" var="skill" varStatus="row">
                                                        <tr id="skillRow${row.count}">
                                                            <td align="center">
                                                                ${row.count}
                                                                <form:hidden path="userSkills[${row.index}].id"
                                                                             id="userSkills[${row.index}].id"
                                                                             value="${skill.id}"
                                                                />
                                                            </td>
                                                            <td>
                                                                <form:select path="userSkills[${row.index}].skillTypeId"
                                                                             id="userSkills[${row.index}].skillTypeId"
                                                                             multiple="false"
                                                                             cssClass="span3"
                                                                             onchange="checkData('getSkills', this, 'userSkills[${row.index}].skillId')"
                                                                >
                                                                <form:option value="0" label="Select" />
                                                                <form:options items="${skillTypes}" />
                                                                </form:select>
                                                            </td>
                                                            <td>
                                                                <form:select path="userSkills[${row.index}].skillId"
                                                                             id="userSkills[${row.index}].skillId"
                                                                             multiple="false"
                                                                             cssClass="span3">
                                                                    <form:option value="0" label="Select" />
                                                                    <form:options items="${skills}" />
                                                                </form:select>
                                                            </td>
                                                            <td>
                                                                <form:input path="userSkills[${row.index}].expMonths"
                                                                            id="userSkills[${row.index}].expMonths"
                                                                            value="${skill.expMonths}"
                                                                            maxlength="3"
                                                                            cssClass="span1"
                                                                            onkeyup="intOnly(this)"
                                                                />
                                                            </td>
                                                            <td>
                                                                <form:input path="userSkills[${row.index}].skillLevel"
                                                                            id="userSkills[${row.index}].skillLevel"
                                                                            value="${skill.skillLevel}"
                                                                            maxlength="3"
                                                                            cssClass="span1"
                                                                            onkeyup="intOnly(this)"
                                                                />
                                                            </td>
                                                            <td style="text-align:center">
                                                                <a href='javaScript:void()' onclick="submitData()">
                                                                    <i class="fa fa-check text-success" style="color:green"></i>
                                                                </a>
                                                                <a href='javaScript:void()' onclick="deleteRow('jobSeekerSkills', ${row.count})">
                                                                    <i class="fa fa-trash font-14" style="color:red"></i>
                                                                </a>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </form:form>

            </div>
            <!-- END PAGE CONTENT-->
        </div>

    <!-- BEGIN PAGA BACKDROPS-->
    <div class="sidenav-backdrop backdrop"></div>
    <div class="preloader-backdrop">
        <div class="page-preloader">Loading</div>
    </div>
    <!--<script src="./assets/vendors/chart.js/dist/Chart.min.js" type="text/javascript"></script>
    <script src="./assets/js/scripts/profile-demo.js" type="text/javascript"></script>-->

    <script type="text/javascript">
        $(function() {
            $('#register-form').validate({
                errorClass: "help-block",
                rules: {
                    firstName: {
                        required: true,
                        minlength: 2
                    },
                    lastName: {
                        required: true,
                        minlength: 2
                    },
                    fatherName: {
                        required: true,
                        minlength: 2
                    },
                    email: {
                        required: true,
                        email: true
                    },
                    dob: {
                        required: true,
                        minlength: 10
                    },
                    mobile: {
                        required: true,
                        minlength: 10
                    },
                    aadhar: {
                        required: true,
                        minlength: 12
                    },
                    postalCode: {
                        required: true,
                        minlength: 5
                    },
                    address: {
                        required: true,
                        minlength: 50
                    },
                    photo: {
                        required: true
                    },
                    resume: {
                        required: true
                    }
                },
                highlight: function(e) {
                    $(e).closest(".form-group").addClass("has-error")
                },
                unhighlight: function(e) {
                    $(e).closest(".form-group").removeClass("has-error")
                },
            });
        });
    </script>
</body>

</html>