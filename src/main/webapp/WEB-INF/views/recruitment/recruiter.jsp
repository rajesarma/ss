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

        function checkData(type,obj, targetId) {
            if(obj.value.length > 0) {
                var url = '/recruitment/recruiter/' + type + '/' + obj.value;
                var message;
                $.ajax( {
                    type: "GET",
                    url:url,
                    cache: false,
                    success: function(response) {
                        $("#wait").html("");
                        var response = jQuery.parseJSON(response);

                        var valueExists = response.valueExists;
                        if(valueExists == "true") {
                            var message = response.message;
                            $("#wait").html("<center style='font-size: 14px' ><span id='loading' style='font-size: 14px; color:red'><b>" + message + "</b></span></center><BR>");
                            document.getElementById(targetId).value = "";
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

		function updatePreferences(type, id) {

			var form = document.getElementById('personal-details-form');
			form.action = '/recruitment/recruiter/' + type + '/' + id;
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

            </div>
            <div class="page-content fade-in-up">
                <form:form id="personal-details-form" action="/recruitment/recruiter" method="POST"
                           modelAttribute="registerDto" enctype="multipart/form-data">

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
                                                    <a class="nav-link active" href="#tab-1" data-toggle="tab"><i class="ti-bar-chart"></i> Company Details</a>
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
                                                        <label>Company Name</label>
                                                        <form:input path="companyName" name="companyName" id="companyName"
                                                                    cssClass="form-control" maxlength="25"
                                                                    placeholder="Company Name"
                                                                    value="${jobSeekerDto.companyName}"
                                                                    onkeyup="charOnly(this)" />
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
                                                <div class="form-group">
                                                    <label>Address</label>
                                                    <form:textarea path="address" name="address" id="address"
                                                                   cssClass="form-control" rows="3"
                                                                   cssStyle="height: 100px"/>
                                                </div>
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
                    companyName: {
                        required: true,
                        minlength: 2
                    },
                    email: {
                        required: true,
                        email: true
                    },
                    address: {
                        required: true,
                        minlength: 50
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