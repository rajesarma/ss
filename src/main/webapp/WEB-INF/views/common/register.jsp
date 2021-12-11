<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width initial-scale=1.0">
    <title>Register</title>
    <!-- GLOBAL MAINLY STYLES-->

    <link href="<c:url value="${pageContext.request.contextPath}/vendors/bootstrap/dist/css/bootstrap.min.css"/>" rel="stylesheet" />
    <link href="<c:url value="${pageContext.request.contextPath}/vendors/font-awesome/css/font-awesome.min.css"/>" rel="stylesheet" />
    <link href="<c:url value="${pageContext.request.contextPath}/vendors/themify-icons/css/themify-icons.css"/>" rel="stylesheet" />

    <!-- THEME STYLES-->
    <link href="<c:url value="${pageContext.request.contextPath}/css/main.min.css"/>" rel="stylesheet" />
    <link href="<c:url value="${pageContext.request.contextPath}/css/pages/auth-light.css"/>" rel="stylesheet" />

    <script src="${pageContext.request.contextPath}/js/form_validations.js"></script>
    <script src="${pageContext.request.contextPath}/js/date_validations.js"></script>

	<script>

		function submitData() {
			var frm = document.getElementById('register-form');
			frm.submit();
		}

		function checkData(type,obj, targetId) {
            if(obj.value.length > 0) {
                var url = '/register/' + type + '/' + obj.value;
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
                        $("#wait").html("<center style='font-size: 14px' ><span id='loading' style='font-size: 14px; color:red'><b>" + response.error + "</b></span></center>");
                    },
                    beforeSend: function( event, ui ) {
                        $("#wait").html("<center style='font-size: 14px' ><span id='loading' style='font-size: 14px; color:red'><i class='fa fa-spinner fa-spin' style='font-size:24px'></i> <b>Checking... </b></span></center>");
                    }
                });
            }
            $("#wait").html("");
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
<body class="bg-silver-300">

    <div class="content">
        <div class="brand">
            <a class="link" href="${pageContext.request.contextPath}/home">AdminCAST</a>
        </div>

        <form:form id="register-form" action="/register" method="post"
                   modelAttribute="jobSeekerDto" enctype="multipart/form-data">

            <h2 class="login-title">Sign Up</h2>

            <div class="span12">
                <div class="err-message" style="text-align:center; color:red"> ${message}</div>
                <br>
                <div class="err-message" id="wait" ></div>
            </div>

            <div class="row">
                <div class="col-6">
                    <div class="form-group">
                        <form:input path="firstName" name="firstName" id="firstName"
                                    cssClass="form-control" maxlength="25"
                                    onkeyup="charOnly(this)"
                                    placeholder="First Name"
                        />
                    </div>
                </div>
                <div class="col-6">
                    <div class="form-group">
                        <form:input path="lastName" name="lastName" id="lastName"
                                    cssClass="form-control" maxlength="25"
                                    onkeyup="charOnly(this)"
                                    placeholder="Last Name"
                        />
                    </div>
                </div>
            </div>
            <div class="form-group">
                <form:input path="email" name="email" id="email"
                            maxlength="50"
                            cssClass="form-control" onblur="checkEmail(this);"
                            onChange="checkData('email', this, this.id)"
                            placeholder="Email"
                            autocomplete="off"
                />
            </div>
            <div class="form-group">
                <form:password path="password" name="password"
                               id="password" maxlength="20"
                               cssClass="form-control"
                               placeholder="Password"/>
            </div>
            <div class="form-group">
                <form:password path="confirmPassword" name="confirmPassword"
                               id="confirmPassword" maxlength="20"
                               cssClass="form-control"
                               placeholder="Confirm Password"/>

            </div>
            <div class="form-group text-left">
                <label class="ui-checkbox ui-checkbox-info">
                    <input type="checkbox" name="agree">
                    <span class="input-span"></span>I agree the terms and policy</label>
            </div>
            <div class="form-group">
                <input type="button" class="btn btn-info btn-block" value="Sign up"
                       onclick="submitData()" />
            </div>
            <div class="social-auth-hr">
                <span>Or Sign up with</span>
            </div>
            <div class="text-center">Already a member?
                <a class="color-blue" href="${pageContext.request.contextPath}/home">Login here</a>
            </div>
        </form:form>
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
                    email: {
                        required: true,
                        email: true
                    },
                    password: {
                        required: true,
                        confirmed: true
                    },
                    password_confirmation: {
                        equalTo: password
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