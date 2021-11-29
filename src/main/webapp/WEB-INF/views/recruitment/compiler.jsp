<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
		 pageEncoding="ISO-8859-1" %>
<!DOCTYPE html>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Compiler</title>

</head>
<body>
	<section id="subintro">
        <div class="jumbotron subhead" id="overview">
            <div class="container">
                <div class="row">
                    <div class="span12">
                        <div class="centered">
                            <h3>
                                Java Compiler
                            </h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <section id="maincontent">
        <div class="container">
            <div class="row ">
                <div class="span12">
                    <div class="centered">
                        <aside>
                            <div data-pym-src="https://www.jdoodle.com/embed/v0/2?stdin=0&arg=0&rw=1"></div>
                        </aside>
                    </div>
                </div>
            </div>
        </div>
    </section>

</body>

<!-- https://www.jdoodle.com/assets/jdoodle-pym.min.js -->
<script src="<c:url value="${pageContext.request.contextPath}/js/recruitment/jdoodle/jdoodle-pym.min.js" />"></script>
<script src="<c:url value="${pageContext.request.contextPath}/js/recruitment/jdoodle/ace.min.js" />"></script>
<script src="<c:url value="${pageContext.request.contextPath}/js/recruitment/jdoodle/ext-language_tools.js" />"></script>
<script src="<c:url value="${pageContext.request.contextPath}/js/recruitment/jdoodle/ext-static_highlight.js" />"></script>
</html>