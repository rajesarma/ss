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


		function applyForJobPost(jobPostId) {
		    let jId = document.getElementById('jobId');
		    jId.value = jobPostId;

			let form = document.getElementById('job-posting-form');
			form.action = '/recruitment/jobPosts';
			form.method = "POST";
			form.submit();
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

                <c:forEach items="${jobsList}" var="posting" varStatus="row">
                    <div class="ibox">
                        <div class="ibox-head">
                            <div class="col-lg-2 col-md-2">
                                <div class="media-body">
                                    <div class="ibox-title">${posting.title}</div>
                                    <small><b>${posting.company}</b></small>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6">
                                <ul class="nav nav-tabs tabs-line pull-right">
                                    <li class="nav-item">
                                        <a class="nav-link active" href="#tab-${row.count}-1" data-toggle="tab" aria-expanded="false">Details</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="#tab-${row.count}-2" data-toggle="tab" aria-expanded="false">Qualifications</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="#tab-${row.count}-3" data-toggle="tab" aria-expanded="false">Roles</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="#tab-${row.count}-4" data-toggle="tab" aria-expanded="false">Skills</a>
                                    </li>
                                </ul>
                            </div>
                            <div class="col-lg-4 col-md-4">
                                <c:choose>
                                    <c:when test="${posting.appliedFlag == 'true'}">
                                        <span class="badge badge-success m-r-5 m-b-5">Applied</span>
                                    </c:when>
                                    <c:otherwise>
                                        <input type ="button" class="btn btn-primary btn-xs" onclick="applyForJobPost('${posting.jobId}')" value="Apply">
                                    </c:otherwise>
                                </c:choose>
                            </div>

                        </div>
                        <div class="ibox-body">
                            <div class="tab-content">
                                <div class="tab-pane fade show active" id="tab-${row.count}-1" aria-expanded="false">
                                    <div>
                                        <span class="m-r-10">
                                            <i class="fa fa-briefcase"></i> ${posting.experience} Years
                                        </span>
                                        <span class="m-r-10">
                                            <i class="fa fa-map-marker"></i> ${posting.location}
                                        </span>

                                        <span class="m-r-10">
                                            <c:choose>
                                                <c:when test="${empty posting.salary}">
                                                    <i class="fa fa-rupee"></i> Not disclosed
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="fa fa-rupee"></i> ${posting.salary}
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                    <br>
                                    <div>
                                        <span class="m-r-5"><i class="fa fa-list"></i></span>
                                        ${posting.description}
                                    </div>
                                    <br>
                                    <div>
                                        <span class="m-r-5"><i class="fa fa-list"></i></span>
                                        ${posting.otherDetails}
                                    </div>
                                    <br>
                                    <div>
                                        <span class="m-r-20">
                                            <i class="fa fa-calendar"></i> Last date ${posting.lastDateToApply}
                                        </span>
                                        <span class="m-r-10">
                                            Posted ${posting.postedDays}
                                        </span>
                                    </div>
                                </div>
                                <div class="tab-pane" id="tab-${row.count}-2" aria-expanded="false">
                                    ${posting.qualifications}
                                </div>
                                <div class="tab-pane" id="tab-${row.count}-3" aria-expanded="false">
                                    <c:forEach items="${posting.jobPostingRoles}" var="rol">
                                        <li><c:out value="${rol.roleResponsibility}"/></li>
                                    </c:forEach>
                                </div>
                                <div class="tab-pane" id="tab-${row.count}-4" aria-expanded="false">
                                    <c:forEach items="${posting.jobPostingSkills}" var="skil" varStatus="row">
                                        <li><c:out value="${skil.skill}"/></li>
                                    </c:forEach>
                                </div>
                            </div>
                            <br>
                        </div>
                    </div>
                </c:forEach>

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