<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width initial-scale=1.0">

    <%-- For CSRF Tokens--%>
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>

    <title>User Login</title>
    <!-- GLOBAL MAINLY STYLES-->

    <link href="<c:url value="${pageContext.request.contextPath}/vendors/bootstrap/dist/css/bootstrap.min.css"/>" rel="stylesheet" />
    <link href="<c:url value="${pageContext.request.contextPath}/vendors/font-awesome/css/font-awesome.min.css"/>" rel="stylesheet" />
    <link href="<c:url value="${pageContext.request.contextPath}/vendors/themify-icons/css/themify-icons.css"/>" rel="stylesheet" />
    <!-- THEME STYLES-->
    <link href="<c:url value="${pageContext.request.contextPath}/css/main.css"/>" rel="stylesheet" />
    <!-- PAGE LEVEL STYLES-->
    <link href="<c:url value="${pageContext.request.contextPath}/css/pages/auth-light.css"/>" rel="stylesheet" />

    <!-- PAGE LEVEL STYLES-->

    <script src="<c:url value="${pageContext.request.contextPath}/vendors/jquery/dist/jquery.min.js"/>" type="text/javascript"></script>
    <!--<script src="<c:url value="${pageContext.request.contextPath}/webjars/jquery/3.5.1/jquery.min.js" />"></script>-->
    <script src="<c:url value="${pageContext.request.contextPath}/vendors/popper.js/dist/umd/popper.min.js"/>" type="text/javascript"></script>
    <!--<script src="<c:url value="${pageContext.request.contextPath}/webjars/bootstrap/4.0.0/js/bootstrap.min.js" />"></script>-->

    <script src="${pageContext.request.contextPath}/vendors/metisMenu/dist/metisMenu.js"></script>

    <script src="<c:url value="${pageContext.request.contextPath}/vendors/bootstrap/dist/js/bootstrap.min.js"/>" type="text/javascript"></script>
    <!-- PAGE LEVEL PLUGINS -->
    <script src="<c:url value="${pageContext.request.contextPath}/vendors/jquery-validation/dist/jquery.validate.min.js"/>" type="text/javascript"></script>
    <!-- CORE SCRIPTS-->
    <script src="<c:url value="${pageContext.request.contextPath}/js/app.js"/>" type="text/javascript"></script>
</head>

<body class="bg-silver-300" >
<!--onload="document.getElementById('username').focus()"-->

    <tiles:insertAttribute name="body" />

</body>



</html>