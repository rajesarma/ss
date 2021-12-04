<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>

</head>

<body class="bg-silver-300" onload="document.getElementById('username').focus()">
    <div class="content">

		<c:if test="${not empty sessionScope.SPRING_SECURITY_LAST_EXCEPTION}">
									<hr>
									<div class="err-message" style="text-align:center"> <%--alert alert-error--%>
											<%--Reason: ${sessionScope.SPRING_SECURITY_LAST_EXCEPTION.message}--%>
										${SPRING_SECURITY_LAST_EXCEPTION.message}
									</div>
									<hr>
								</c:if>

								<div class="err-message">
									${message}
								</div>

        <div class="brand">
            <a class="link" href="index.html">AdminCAST</a>
        </div>

		<form:form action="/login" method="post" modelAttribute="user" cssClass="form-horizontal" id="login-form">

            <h2 class="login-title">Log in</h2>
            <div class="form-group">
                <div class="input-group-icon right">
                    <div class="input-icon"><i class="fa fa-envelope"></i></div>

					<form:input path="username" name="username" id="username" cssClass="form-control" placeholder="User Name"  autocomplete="off"/>
                </div>
            </div>
            <div class="form-group">
                <div class="input-group-icon right">
                    <div class="input-icon"><i class="fa fa-lock font-16"></i></div>
					<form:password path="password" name="password" id="password" cssClass="form-control" placeholder="Password" />
                </div>
            </div>
            <div class="form-group d-flex justify-content-between">
                <label class="ui-checkbox ui-checkbox-info">
                    <input type="checkbox">
                    <span class="input-span"></span>Remember me</label>
                <a href="forgot_password.html">Forgot password?</a>
            </div>
            <div class="form-group">
                <button class="btn btn-info btn-block" type="submit">Login</button>
            </div>
            <!--
            <div class="social-auth-hr">
                <span>Or login with</span>
            </div>
            <div class="text-center social-auth m-b-20">
                <a class="btn btn-social-icon btn-twitter m-r-5" href="javascript:;"><i class="fa fa-twitter"></i></a>
                <a class="btn btn-social-icon btn-facebook m-r-5" href="javascript:;"><i class="fa fa-facebook"></i></a>
                <a class="btn btn-social-icon btn-google m-r-5" href="javascript:;"><i class="fa fa-google-plus"></i></a>
                <a class="btn btn-social-icon btn-linkedin m-r-5" href="javascript:;"><i class="fa fa-linkedin"></i></a>
                <a class="btn btn-social-icon btn-vk" href="javascript:;"><i class="fa fa-vk"></i></a>
            </div>
            -->
            <div class="text-center">Not a member?
                <a class="color-blue" href="/recruitment/jobSeeker">Create account</a>
            </div>
        </form:form>
    </div>
    <!-- BEGIN PAGA BACKDROPS-->
    <div class="sidenav-backdrop backdrop"></div>
    <div class="preloader-backdrop">
        <div class="page-preloader">Loading</div>
    </div>
    <!-- END PAGA BACKDROPS-->
    <!-- CORE PLUGINS -->
    <script src="<c:url value="${pageContext.request.contextPath}/vendors/jquery/dist/jquery.min.js"/>" type="text/javascript"></script>
    <script src="<c:url value="${pageContext.request.contextPath}/vendors/popper.js/dist/umd/popper.min.js"/>" type="text/javascript"></script>
    <script src="<c:url value="${pageContext.request.contextPath}/vendors/bootstrap/dist/js/bootstrap.min.js"/>" type="text/javascript"></script>
    <!-- PAGE LEVEL PLUGINS -->
    <script src="<c:url value="${pageContext.request.contextPath}/vendors/jquery-validation/dist/jquery.validate.min.js"/>" type="text/javascript"></script>
    <!-- CORE SCRIPTS-->
    <script src="<c:url value="${pageContext.request.contextPath}/js/app.js"/>" type="text/javascript"></script>
    <!-- PAGE LEVEL SCRIPTS-->
    <script type="text/javascript">
        $(function() {
            $('#login-form').validate({
                errorClass: "help-block",
                rules: {
                    email: {
                        required: true,
                        email: true
                    },
                    password: {
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