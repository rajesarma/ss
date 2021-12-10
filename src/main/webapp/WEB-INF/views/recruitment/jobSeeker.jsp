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

		function submitData(action, method) {
			var user = document.getElementById('jobSeeker');
			user.action = action;
			user.method = method;
			user.submit();
		}

		function checkData(type,obj, targetId) {
            if(obj.value.length > 0) {
                var url = '/recruitment/jobSeeker/' + type + '/' + obj.value;
                var message;
                $.ajax( {
                    type: "GET",
                    url:url,
                    cache: false,
                    success: function(response) {
                        $("#wait").html("");
                        var response = jQuery.parseJSON(response);
                        var valueExists = response.valueExists;
                        if(valueExists == "true")
                        {
                            var message = response.message;
                            $("#wait").html("<center style='font-size: 14px' ><span id='loading' style='font-size: 14px; color:red'><i class='fa fa-spinner fa-spin' style='font-size:24px'></i> <b>" + message + "</b></span></center>");
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
			<form:form action="/recuitment/jobSeeker" id="jobSeeker" method="${method}"
					   modelAttribute="jobSeekerDto" enctype="multipart/form-data"
					   cssClass="form-horizontal">
			<form:hidden path="id" name="id" id="id" />

			<div class="row ">
				<div class="span12">
					<div class="err-message" style="text-align:center"> ${message}</div>

					<div class="err-message" id="wait" ></div>
				</div>

				<div class="span6">
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
                                <form:input path="dob" name="dob" id="dob" maxlength="10"
                                            cssClass="span2"
                                            onkeyup="buildDate(this)" onblur="isValidDate(this);"/>
                                <span class="help-inline date-format">
                                    <spring:message code="dateFormat"/>
                                </span>
                                <span class="help-inline">
                                    <form:errors path="dob" cssClass="error" />
                                </span>
                            </div>
						</div>

                        <div class="control-group">
                            <label class="control-label align-left" for="mobile">
                                <spring:message code="jobSeeker.mobile"/>
                            </label>
                            <div class="controls">
                                <form:input path="mobile" name="mobile" id="mobile"
                                            cssClass="span3" maxlength="10"
                                            onkeyup="intOnly(this)"
                                            onChange="checkData('mobileNo.', this, this.id)"
                                />
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
                                <form:input path="alternateNo" name="alternateNo"
                                            id="alternateNo" maxlength="10"
                                            cssClass="span3" onkeyup="intOnly(this)"/>
                                <span class="help-inline">
                                    <form:errors path="alternateNo" cssClass="error" />
                                </span>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label align-left" for="aadhar">
                                <spring:message code="jobSeeker.aadhar"/>
                            </label>
                            <div class="controls">
                                <form:input path="aadhar" name="aadhar"
                                            id="aadhar" maxlength="12"
                                            cssClass="span3" onkeyup="intOnly(this)"
                                onChange="checkData('aadhar', this, this.id)"
                                />
                                <span class="help-block">
									<form:errors path="aadhar" cssClass="error" />
								</span>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label align-left" for="postalCode">
                                <spring:message code="jobSeeker.postalCode"/>
                            </label>
                            <div class="controls">
                                <form:input path="postalCode" name="postalCode"
                                            id="postalCode" maxlength="12"
                                            cssClass="span3" onkeyup="intOnly(this)"
                                />
                                <span class="help-block">
									<form:errors path="postalCode" cssClass="error" />
								</span>
                            </div>
                        </div>


                        <div class="control-group">
                            <label class="control-label align-left" for="email">
                                <spring:message code="jobSeeker.email"/>
                            </label>
                            <div class="controls">
                                <form:input path="email" name="email" id="email"
                                            maxlength="50"
                                            cssClass="span3" onblur="checkEmail(this);"
                                            onChange="checkData('email', this, this.id)"
                                />
                                <span class="help-inline">
                                    <form:errors path="email" cssClass="error" />
                                </span>
                            </div>
                        </div>

					</div>
				</div>

				<div class="span6">
				    <div class="centered">


                        <div class="control-group">
                            <label class="control-label align-left" >
                                <spring:message code="jobSeeker.gender"/>
                            </label>
                            <div class="controls">
                                <label class="radio inline" for="gender">
                                    <form:radiobutton path="gender" value="MALE" id="gender"/> Male
                                </label>
                                <label class="radio inline" for="gender">
                                    <form:radiobutton path="gender" value="FEMALE" id="gender"/> Female
                                </label>
                                <span class="help-inline">
                                    <form:errors path="gender" cssClass="error" />
                                </span>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label align-left" >
                                <spring:message code="jobSeeker.address"/>
                            </label>
                            <div class="controls">
                                <form:textarea path="address" name="address" id="address"
                                               cssClass="span3" rows="3"
                                               cssStyle="height: 100px"/>
                                <span class="help-block">
									<form:errors path="address" cssClass="error" />
								</span>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label align-left" for="email">
                                <spring:message code="jobSeeker.resume"/>
                            </label>
                            <div class="controls">
                                <input type="file" name="resume" id="resume"
                                       cssClass="span3" onchange="openFile(event)" />

                                <span class="help-inline">
                                    <form:errors path="resume" cssClass="error" />
                                </span>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label align-left" for="email">
                                <spring:message code="jobSeeker.photo"/>
                            </label>
                            <div class="controls">
                                <input type="file" name="photo" id="photo"
                                       cssClass="span3" onchange="openFile(event)" />
                                <!--<form:hidden path="photoData" name="photoData" id="photoData" />-->

                                <div id="applicantPhotoName" ></div>
                                <span class="help-inline">
                                    <form:errors path="photo" cssClass="error" />
                                </span>

                                <c:if test="${empty photoData}">
                                    <span class="help-inline">
                                        <img src="data:photo;base64,${photoData }" id="photoData"
                                             style='border: 1px solid black; visibility: collapse'
                                             width='80px' class="img-polaroid"
                                             height='80px'>
                                    </span>
                                </c:if>
                                <c:if test="${not empty photoData}">
                                    <span class="help-inline">
                                        <img src="data:photo;base64,${photoData }" id="photoData"
                                             style='border: 1px solid black; visibility: visible'
                                             width='80px' class="img-polaroid"
                                             height='80px'>
                                    </span>
                                </c:if>

                            </div>
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