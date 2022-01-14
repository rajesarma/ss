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

        function addRow(id) {

		    if(id == 'jobRoles') {
				var tbl = document.getElementById(id);
				var lastRow = tbl.rows.length;
				var str="";
				str+="<tr id=\"roleRow"+(lastRow+1)+"\">";
				str+="<td align=\"center\">"+(lastRow+1)+"</td>";
				str+="<td><input type=\"hidden\" id=\"jobPostingRoles["+lastRow+"].id\" name=\"jobPostingRoles["+lastRow+"].id\" >";
				str+="<input type=\"hidden\" id=\"jobPostingRoles["+lastRow+"].deleteFlag\" name=\"jobPostingRoles["+lastRow+"].deleteFlag\" >";
				str+="<input type=\"text\" id=\"jobPostingRoles["+lastRow+"].roleResponsibility\" name=\"jobPostingRoles["+lastRow+"].roleResponsibility\" class=\"form-control\" placeholder=\"Roles / Responsibility\" maxlength=\"100\"> </td>";
				str+="<td style=\"text-align:center\">";
				str+="<a href=\"javaScript:void()\" onclick=\"deleteRow('jobRoles', "+(lastRow+1)+")\"><i class=\"fa fa-trash font-14\" style=\"color:red\"></i></a></td>";
				str+="</tr>";
				$("#jobRoles > tbody").append(str);

			} else if(id == 'jobSkills') {
				var tbl = document.getElementById(id);
				var lastRow = tbl.rows.length;
				var str="";
				str+="<tr id=\"skillRow"+(lastRow+1)+"\">";
				str+="<td align=\"center\">"+(lastRow+1)+"</td>";
				str+="<td><input type=\"hidden\" id=\"jobPostingSkills["+lastRow+"].id\" name=\"jobPostingSkills["+lastRow+"].id\" >";
				str+="<input type=\"hidden\" id=\"jobPostingSkills["+lastRow+"].deleteFlag\" name=\"jobPostingSkills["+lastRow+"].deleteFlag\" >";
				str+="<input type=\"text\" id=\"jobPostingSkills["+lastRow+"].skill\" name=\"jobPostingSkills["+lastRow+"].skill\" class=\"form-control\" placeholder=\"Skill\" maxlength=\"100\"> </td>";
				str+="<td style=\"text-align:center\">";
				str+="<a href=\"javaScript:void()\" onclick=\"deleteRow('jobSkills', "+(lastRow+1)+")\"><i class=\"fa fa-trash font-14\" style=\"color:red\"></i></a></td>";
				str+="</tr>";
				$("#jobSkills > tbody").append(str);
			}
		}

		function deleteRow(type, index) {
			var lastRow;
			var tb1 = document.getElementById(type);

			lastRow = tb1.rows.length;

			if(lastRow==1) {
				alert("You Cann\'t Delete This Row");
				return false;
			} else {
				// if id present for a row, then send request to controller, else just remove the row
				if(type == 'jobRoles') {
					let deleteFlagElement =  document.getElementById("jobPostingRoles["+index+"].deleteFlag");
					deleteFlagElement.value=true;
					$("#roleRow"+(index+1)).hide();
				} else if(type == 'jobSkills') {
					let deleteFlagElement =  document.getElementById("jobPostingSkills["+index+"].deleteFlag");
					deleteFlagElement.value=true;
					$("#skillRow"+(index+1)).hide();
				}
			}
		}

		function updatePreferences(type, id) {

			var form = document.getElementById('job-posting-form');
			form.action = '/recruitment/jobPosting/' + type + '/' + id;
			form.method = "POST";
			form.submit();
        }

        function createJobPosting() {
            let jId = document.getElementById('jobId');
			jId.value = "";

            $("#id").val('');
            $("#jobId").val('');
            $("#title").val('');
            $("#experience").val('');
            $("#location").val('');
            $("#description").val('');
            $("#lastDateToApply").val('');
            $("#mailTo").val('');
            $("#qualifications").val('');
            $("#otherDetails").val('');
            $("#salary").val('');
			$('#company').val('');

			$("#jobRoles > tbody").html("");
            let roleStr = "<tr id=\"roleRow1\">";
            roleStr+="<td align=\"center\">1</td>";
            roleStr+="<td><input type=\"hidden\" id=\"jobPostingRoles[0].id\" name=\"jobPostingRoles[0].id\" >";
            roleStr+="<input type=\"hidden\" id=\"jobPostingRoles[0].deleteFlag\" name=\"jobPostingRoles[0].deleteFlag\" >";
            roleStr+="<input type=\"text\" id=\"jobPostingRoles[0].roleResponsibility\" name=\"jobPostingRoles[0].roleResponsibility\" class=\"form-control\" placeholder=\"Roles / Responsibility\" maxlength=\"100\"> </td>";
            roleStr+="<td style=\"text-align:center\">";
            roleStr+="<a href=\"javaScript:void()\" onclick=\"deleteRow('jobRoles', '1')\"><i class=\"fa fa-trash font-14\" style=\"color:red\"></i></a></td>";
            roleStr+="</tr>";
            $("#jobRoles > tbody").append(roleStr);

            $("#jobSkills > tbody").html("");
            let skillStr="<tr id=\"skillRow1\">";
            skillStr+="<td align=\"center\">1</td>";
            skillStr+="<td><input type=\"hidden\" id=\"jobPostingSkills[0].id\" name=\"jobPostingSkills[0].id\" >";
            skillStr+="<input type=\"hidden\" id=\"jobPostingSkills[0].deleteFlag\" name=\"jobPostingSkills[0].deleteFlag\" >";
            skillStr+="<input type=\"text\" id=\"jobPostingSkills[0].skill\" name=\"jobPostingSkills[0].skill\" class=\"form-control\" placeholder=\"Skill\" maxlength=\"100\"> </td>";
            skillStr+="<td style=\"text-align:center\">";
            skillStr+="<a href=\"javaScript:void()\" onclick=\"deleteRow('jobSkills', '1')\"><i class=\"fa fa-trash font-14\" style=\"color:red\"></i></a></td>";
            skillStr+="</tr>";
            $("#jobSkills > tbody").append(skillStr);

			 $("#myModal").modal('toggle');
        }

        function viewJobPosting(jobPostId) {
            let jId = document.getElementById('jobId');
			jId.value = jobPostId;
            let url = '/recruitment/jobPosting/'+jobPostId;
            $.ajax( {
                type: "GET",
                url:url,
                cache: false,
                success: function(response) {
                    $("#wait").html("");
                     response = JSON.parse(response);

                     $('#id').val(response.id);
                     $('#jobId').val(response.jobId);
                     $('#title').val(response.title);
                     $('#experience').val(response.experience);
                     $('#location').val(response.location);
                     $('#description').val(response.description);
                     $('#lastDateToApply').val(response.lastDateToApply);
                     $('#mailTo').val(response.mailTo);
                     $('#qualifications').val(response.qualifications);
                     $('#otherDetails').val(response.otherDetails);
                     $('#salary').val(response.salary);
                     $('#company').val(response.company);

                     let jobPostingRoles = response.jobPostingRoles;

                     if(typeof(jobPostingRoles)!='undefined') {
                        $("#jobRoles > tbody").html("");
                        let str = "";
                        for(var rowValue=0; rowValue < jobPostingRoles.length; rowValue++ ) {
                             let rId = jobPostingRoles[rowValue].id;
                             let rValue = jobPostingRoles[rowValue].roleResponsibility;
                             str+="<tr id=\"roleRow"+(rowValue+1)+"\">";
                             str+="<td align=\"center\">"+(rowValue+1)+"</td>";
                             str+="<td><input type=\"hidden\" id=\"jobPostingRoles["+rowValue+"].id\" name=\"jobPostingRoles["+rowValue+"].id\" value="+rId+" ";

                             if(rId.length > 0) {
                                str+="value=\""+rId+"\"";
                             }
                             str+=" >";
                             str+="<input type=\"hidden\" id=\"jobPostingRoles["+rowValue+"].deleteFlag\" name=\"jobPostingRoles["+rowValue+"].deleteFlag\">";

                             str+="<input type=\"text\" id=\"jobPostingRoles["+rowValue+"].roleResponsibility\" name=\"jobPostingRoles["+rowValue+"].roleResponsibility\" class=\"form-control\" placeholder=\"Roles / Responsibility\" maxlength=\"100\" ";

                             if(rValue.length > 0) {
                                str+="value=\""+rValue+"\"";
                             }
                             str+=" > </td>";

                             str+="<td style=\"text-align:center\">";
                             str+="<a href=\"javaScript:void()\" onclick=\"deleteRow('jobRoles', "+rowValue+")\"><i class=\"fa fa-trash font-14\" style=\"color:red\"></i></a></td>";
                             str+="</tr>";
                        }
                        $("#jobRoles > tbody").append(str);
                     }

                     let jobPostingSkills = response.jobPostingSkills;

                     if(typeof(jobPostingSkills)!='undefined') {
                        $("#jobSkills > tbody").html("");
                        let str = "";
                        for(var rowValue=0; rowValue < jobPostingSkills.length; rowValue++ ) {
                             let sId = jobPostingSkills[rowValue].id;
                             let sValue = jobPostingSkills[rowValue].skill;
                             str+="<tr id=\"skillRow"+(rowValue+1)+"\">";
                             str+="<td align=\"center\">"+(rowValue+1)+"</td>";
                             str+="<td><input type=\"hidden\" id=\"jobPostingSkills["+rowValue+"].id\" name=\"jobPostingSkills["+rowValue+"].id\" value="+sId+" ";

                             if(sId.length > 0) {
                                str+="value=\""+sId+"\"";
                             }
                             str+=" >";
                             str+="<input type=\"hidden\" id=\"jobPostingSkills["+rowValue+"].deleteFlag\" name=\"jobPostingSkills["+rowValue+"].deleteFlag\">";
                             str+="<input type=\"text\" id=\"jobPostingSkills["+rowValue+"].roleResponsibility\" name=\"jobPostingSkills["+rowValue+"].skill\" class=\"form-control\" placeholder=\"Skill\" maxlength=\"100\" ";

                             if(sValue.length > 0) {
                                str+="value=\""+sValue+"\"";
                             }
                             str+=" > </td>";

                             str+="<td style=\"text-align:center\">";
                             str+="<a href=\"javaScript:void()\" onclick=\"deleteRow('jobSkills', "+rowValue+")\"><i class=\"fa fa-trash font-14\" style=\"color:red\"></i></a></td>";
                             str+="</tr>";
                        }
                        $("#jobSkills > tbody").append(str);
                     }

                     $("#myModal").modal('toggle');

                }, error: function(response) {
                    $("#wait").html("<center style='font-size: 14px' ><span id='loading' style='font-size: 14px; color:red'><i class='fa fa-spinner fa-spin' style='font-size:24px'></i> <b>" + response.error + "</b></span></center>");
                }
            });
        }
    </script>
    <style>
        input {
            font-size: small !important;
        }

        .modal-content {
                -webkit-border-top-left-radius: 5px;
                -webkit-border-top-right-radius: 5px;
                -moz-border-radius-topleft: 5px;
                -moz-border-radius-topright: 5px;
                border-top-left-radius: 5px;
                border-top-right-radius: 5px;
        }

        .modal-header {
            padding:9px 15px;
            border-bottom:1px solid #eee;
            background-color: #0480be;
            -webkit-border-top-left-radius: 5px;
            -webkit-border-top-right-radius: 5px;
            -moz-border-radius-topleft: 5px;
            -moz-border-radius-topright: 5px;
             border-top-left-radius: 5px;
             border-top-right-radius: 5px;
             color: #fff;
         }

    </style>

</head>

<body class="fixed-navbar sidebar-mini">
    <div class="page-wrapper">

        <div class="page-content fade-in-up">
            <form:form id="job-posting-form" action="/recruitment/jobPosting" modelAttribute="jobPostingDto" method="POST">
                <form:hidden path="jobId" id="jobId" value="${jobPostingDto.jobId}" />
                <form:hidden path="id" id="id" value="${jobPostingDto.id}" />
                <div class="span12">
                    <div class="err-message" style="text-align:center; color:red" id="wait"> ${message}</div>
                </div>

                <div class="row">
                    <div class="col-lg-12 col-md-12">
                        <div class="ibox">
                            <div class="ibox-body">
                                <div class="row">
                                    <div class="col-lg-10 col-md-10">
                                        <ul class="nav nav-tabs tabs-line">
                                            <li class="nav-item">
                                                <a class="nav-link active" href="#tab-1" data-toggle="tab"><i class="fa fa-bullhorn"></i> Job Postings</a>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="col-lg-2 col-md-2">
                                        <div class="nav-item pull-right">
                                            <input type ="button" class="btn btn-primary btn-sm" onclick="createJobPosting()" value="Create New">
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-content">
                                    <div class="tab-pane fade show active" id="tab-1">
                                        <div class="table-responsive">
                                            <table class="table table-striped table-bordered table-hover table-condensed table-sm" id="jobPostingList">
                                                <thead>
                                                    <tr>
                                                        <th width="50px">#</th>
                                                        <th style="text-align: center">Title</th>
                                                        <th style="text-align: center">Location</th>
                                                        <th style="text-align: center">Experience (years)</th>
                                                        <th style="text-align: center">Last Date to Apply</th>
                                                        <th style="text-align: center">Actions</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach items="${jobsList}" var="posting" varStatus="row">
                                                            <tr>
                                                                <td align="center">${row.count}</td>
                                                                <td>${posting.title}</td>
                                                                <td>${posting.location}</td>
                                                                <td>${posting.experience}</td>
                                                                <td>${posting.lastDateToApply}</td>
                                                                <td style="text-align:center">
                                                                    <a href='javaScript:void()' onclick="viewJobPosting('${posting.jobId}')">
                                                                        <i class="fa fa-edit"></i>
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
                    </div>


                    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                        <div class="modal-dialog modal-lg" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Job Post</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body" id="jobInfo">
                                    <div class="row">
                                        <div class="col-sm-3 form-group">
                                            <label>Title</label>
                                            <form:input path="title" id="title"
                                                        cssClass="form-control" maxlength="50"
                                                        placeholder="Title"
                                                        value="${jobPostingDto.title}"
                                                        onkeyup="charOnly(this)" />
                                        </div>
                                        <div class="col-sm-3 form-group">
                                            <label>Experience (In Years)</label>
                                            <form:input path="experience" id="experience"
                                                        cssClass="form-control"
                                                        placeholder="Experience"
                                                        value="${jobPostingDto.experience}"
                                                        maxlength="2"
                                                        onkeyup="intOnly(this)"
                                            />
                                        </div>
                                        <div class="col-sm-3 form-group">
                                            <label>Location</label>
                                            <form:input path="location" id="location"
                                                        cssClass="form-control" maxlength="50"
                                                        placeholder="Location"
                                                        value="${jobPostingDto.location}"
                                                        onkeyup="charOnly(this)" />
                                        </div>
                                        <div class="col-sm-3 form-group">
                                            <label>Last Date to Apply</label>
                                            <form:input path="lastDateToApply" id="lastDateToApply"
                                                        cssClass="form-control" maxlength="10"
                                                        placeholder="Last Date to Apply"
                                                        value="${jobPostingDto.lastDateToApply}"
                                                        onkeyup="buildDate(this)"
                                                        onblur="isValidDate(this);" />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-3 form-group">
                                            <label>Salary (Per Month)</label>
                                            <form:input path="salary" id="salary"
                                                        maxlength="50"
                                                        value="${jobPostingDto.salary}"
                                                        cssClass="form-control"
                                                        onkeyup="intOnly(this)"
                                                        placeholder="Salary"
                                            />
                                        </div>
                                        <div class="col-sm-3 form-group">
                                            <label>Mail To</label>
                                            <form:input path="mailTo" id="mailTo"
                                                        maxlength="50"
                                                        value="${jobPostingDto.mailTo}"
                                                        cssClass="form-control"
                                                        onblur="checkEmail(this);"
                                                        placeholder="E mail"
                                            />
                                        </div>

                                        <div class="col-sm-3 form-group">
                                            <label>Company</label>
                                            <form:input path="company" id="company"
                                                        maxlength="50"
                                                        value="${jobPostingDto.company}"
                                                        cssClass="form-control"
                                                        onkeyup="charOnly(this)"
                                                        placeholder="Company"
                                            />
                                        </div>
                                        <div class="col-sm-3 form-group">
                                            <label>Qualifications</label>
                                            <form:input path="qualifications" id="qualifications"
                                                        cssClass="form-control" maxlength="100"
                                                        placeholder="Qualifications"
                                                        value="${jobPostingDto.qualifications}"
                                            />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-6 form-group">
                                            <label>Description</label>
                                            <form:textarea path="description" id="description"
                                                           cssClass="form-control" rows="3"
                                                           cssStyle="height: 100px"/>
                                        </div>
                                        <div class="col-sm-6 form-group">
                                            <label>Other Details</label>
                                            <form:textarea path="otherDetails" id="otherDetails"
                                                           cssClass="form-control" rows="3"
                                                           cssStyle="height: 100px"/>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="ibox">
                                                <div class="row">
                                                    <div class="col-lg-10 col-md-10">
                                                        <div class="ibox-title"><b>Roles</b></div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-2 input-group-sm">
                                                        <div class="nav-item pull-right">
                                                            <a href='javaScript:void()' onclick="addRow('jobRoles')">
                                                                <i class="fa fa-plus font-14"></i>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                                <table class="table table-sm" id="jobRoles">
                                                    <tbody>
                                                    <c:forEach items="${jobPostingDto.jobPostingRoles}" var="rol" varStatus="row">
                                                        <tr id="roleRow${row.count}">
                                                            <td align="center">
                                                                ${row.count}
                                                                <form:hidden path="jobPostingRoles[${row.index}].id"
                                                                             id="jobPostingRoles[${row.index}].id"
                                                                             value="${rol.id}"
                                                                />
                                                                <form:hidden path="jobPostingRoles[${row.index}].deleteFlag"
                                                                             id="jobPostingRoles[${row.index}].deleteFlag"
                                                                             value="${rol.deleteFlag}"
                                                                />
                                                            </td>
                                                            <td>
                                                                <form:input path="jobPostingRoles[${row.index}].roleResponsibility"
                                                                            id="jobPostingRoles[${row.index}].roleResponsibility"
                                                                            cssClass="form-control"
                                                                            maxlength="100"
                                                                            placeholder="Roles / Responsibility"
                                                                            value="${jobPostingRoles.roleResponsibility}"
                                                                />
                                                            </td>
                                                            <td style="text-align:center">
                                                                <a href='javaScript:void()' onclick="deleteRow('jobRoles', ${row.count})">
                                                                    <i class="fa fa-trash font-14" style="color:red"></i>
                                                                </a>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="ibox">
                                                <div class="row">
                                                    <div class="col-lg-10 col-md-10">
                                                        <div class="ibox-title"><b>Skills</b></div>
                                                    </div>
                                                    <div class="col-lg-2 col-md-2 input-group-sm">
                                                        <div class="nav-item pull-right">
                                                            <a href='javaScript:void()' onclick="addRow('jobSkills')">
                                                                <i class="fa fa-plus font-14"></i>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                                <table class="table table-sm" id="jobSkills">
                                                    <tbody>
                                                    <c:forEach items="${jobPostingDto.jobPostingSkills}" var="skil" varStatus="row">
                                                        <tr id="skillRow${row.count}">
                                                            <td align="center">
                                                                ${row.count}
                                                                <form:hidden path="jobPostingSkills[${row.index}].id"
                                                                             id="jobPostingSkills[${row.index}].id"
                                                                             value="${skil.id}"
                                                                />
                                                                <form:hidden path="jobPostingSkills[${row.index}].deleteFlag"
                                                                             id="jobPostingSkills[${row.index}].deleteFlag"
                                                                             value="${skil.deleteFlag}"
                                                                />
                                                            </td>
                                                            <td>
                                                                <form:input path="jobPostingSkills[${row.index}].skill"
                                                                            id="jobPostingSkills[${row.index}].skill"
                                                                            cssClass="form-control"
                                                                            maxlength="100"
                                                                            placeholder="Skill"
                                                                            value="${jobPostingSkills.skill}"
                                                                />
                                                            </td>
                                                            <td style="text-align:center">
                                                                <a href='javaScript:void()' onclick="deleteRow('jobSkills', ${row.count})">
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
                                <div class="modal-footer">
                                    <button class="btn btn-info" type="submit">Submit</button>
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form:form>
            </div>
        </div>
        <!-- END PAGE CONTENT-->
    </div>

    <!-- BEGIN PAGA BACKDROPS-->
    <div class="sidenav-backdrop backdrop"></div>
    <div class="preloader-backdrop">
        <div class="page-preloader">Loading</div>
    </div>

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


<!--displayData+="<div class=\"card\" style=\"width:300px;\">";
    displayData+="<div class=\"card-header\">";
        displayData+="<h6 class=\"m-0\">"+response.title+"</h6><small class=\"text-muted\">Last Date: "+response.lastDateToApply+"</small></div>";
    displayData+="<div class=\"card-body\">";
        displayData+="<h4 class=\"card-title\">Jane Smith</h4>";
        displayData+="<div>Some quick example text.</div>";
        displayData+="</div>";
    displayData+="<ul class=\"list-group list-group-divider no-margin\">";
    displayData+="<li class=\"list-group-item\" style=\"border-top-color:#e1eaec;\">Sales";
        displayData+="<span class=\"badge badge-danger badge-circle float-right\">4</span>";
        displayData+="</li>";
    displayData+="<li class=\"list-group-item\">Photos";
        displayData+="<span class=\"badge badge-info badge-circle float-right\">7</span>";
        displayData+="</li>";
    displayData+="<li class=\"list-group-item\">Friends";
        displayData+="<span class=\"badge badge-warning badge-circle float-right\">24</span>";
        displayData+="</li>";
    displayData+="</ul>";
    displayData+="<div class=\"card-footer\">";
        displayData+="<a class=\"text-info\"><i class=\"fa fa-star\"></i> Follow</a>";
        displayData+="<span class=\"pull-right text-muted font-13\">Joined in 12.01</span>";
        displayData+="</div>";
    displayData+="</div>";-->

</html>