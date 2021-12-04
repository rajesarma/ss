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
    <title>User Login</title>
    <!-- GLOBAL MAINLY STYLES-->

    <link href="<c:url value="${pageContext.request.contextPath}/vendors/bootstrap/dist/css/bootstrap.min.css"/>" rel="stylesheet" />
    <link href="<c:url value="${pageContext.request.contextPath}/vendors/font-awesome/css/font-awesome.min.css"/>" rel="stylesheet" />
    <link href="<c:url value="${pageContext.request.contextPath}/vendors/themify-icons/css/themify-icons.css"/>" rel="stylesheet" />
    <!-- THEME STYLES-->
    <link href="<c:url value="${pageContext.request.contextPath}/css/main.css"/>" rel="stylesheet" />
    <!-- PAGE LEVEL STYLES-->
    <link href="<c:url value="${pageContext.request.contextPath}/css/pages/auth-light.css"/>" rel="stylesheet" />
</head>

<body class="bg-silver-300" onload="document.getElementById('username').focus()">

    <tiles:insertAttribute name="body" />

</body>

</html>