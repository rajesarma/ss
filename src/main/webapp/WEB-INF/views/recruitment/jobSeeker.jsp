<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<html>
<head>
	<meta charset="ISO-8859-1">
	<title>User</title>

	<script>
		function submitData(action, method)
		{
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
								<spring:message code="jobSeeker.operations"/>
							</h3>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<section id="maincontent">
		<div class="container">
			<form:form action="/recuitment/jobSeeker" id="jobSeeker" method="${method}"
					   modelAttribute="jobSeekerDto" enctype="multipart/form-data"
					   cssClass="form-horizontal">
			<form:hidden path="id" name="id" id="id" />

			<div class="row ">
				<div class="span12">
					<div class="err-message" style="text-align:center"> ${message}</div>

					<div class="err-message" id="wait" ></div>
				</div>

				<div class="span6 offset4">
					<div class="centered">

						<div class="control-group">
							<label class="control-label align-left" for="fullName">
								<spring:message code="jobSeeker.fullName"/>
							</label>

							<div class="controls">
								<form:input path="fullName" name="fullName" id="fullName"
											cssClass="span3" maxlength="25"
											onkeyup="charOnly(this)" />
								<span class="help-inline">
									<form:errors path="fullName" cssClass="error" />
								</span>
							</div>
						</div>

						<div class="control-group">

							<label class="control-label align-left" for="password">
								<spring:message code="jobSeeker.password"/>
							</label>
							<div class="controls">
								<form:password path="password" name="password"
										id="password" maxlength="20"
											cssClass="span3" />
								<span class="help-inline">
									<form:errors path="password" cssClass="error" />
								</span>
							</div>
						</div>

						<div class="control-group">
                            <label class="control-label align-left" for="fatherName">
                                <spring:message code="jobSeeker.fatherName"/>
                            </label>

                            <div class="controls">
                                <form:input path="fatherName" name="fatherName" id="fatherName"
                                            cssClass="span3" maxlength="25"
                                            onkeyup="charOnly(this)" />
                                <span class="help-inline">
                                    <form:errors path="fatherName" cssClass="error" />
                                </span>
                            </div>
                        </div>


						<div class="control-group">
							<label class="control-label align-left" for="dob">
								<spring:message code="jobSeeker.dob"/>
							</label>

							<div class="controls">

								<%--<div class="input-prepend"> <span class="add-on"><i class="icon-envelope"></i></span>--%>
								<form:input path="dob" name="dob" id="dob" maxlength="50" cssClass="span3" />
								<span class="help-inline">
									<form:errors path="dob" cssClass="error" />
								</span>
							</div>
						</div>

					</div>
				</div>

				<div class="span6 offset4">

				<div class="control-group">

                    <label class="control-label align-left" for="mobile">
                        <spring:message code="jobSeeker.mobile"/>
                    </label>
                    <div class="controls">
                        <form:password path="mobile" name="mobile" id="mobile" maxlength="20" cssClass="span3" />
                        <span class="help-inline">
                            <form:errors path="mobile" cssClass="error" />
                        </span>
                    </div>
                </div>

                <div class="control-group">

                    <label class="control-label align-left" for="alternateNo">
                        <spring:message code="jobSeeker.alternateNo"/>
                    </label>
                    <div class="controls">
                        <form:password path="alternateNo" name="alternateNo"
                                id="alternateNo" maxlength="20"
                                    cssClass="span3" />
                        <span class="help-inline">
                            <form:errors path="alternateNo" cssClass="error" />
                        </span>
                    </div>
                </div>

                <div class="control-group">

                    <label class="control-label align-left" for="email">
                        <spring:message code="jobSeeker.email"/>
                    </label>
                    <div class="controls">
                        <form:password path="email" name="email"
                                id="password" maxlength="20"
                                    cssClass="span3" />
                        <span class="help-inline">
                            <form:errors path="email" cssClass="error" />
                        </span>
                    </div>
                </div>

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