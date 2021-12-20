<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
		 pageEncoding="ISO-8859-1" %>


<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Error</title>

	<style>
        .content {
            max-width: 500px;
            margin: 0 auto;
            text-align: center;
        }

        .content h1 {
            font-size: 100px
        }

        .error-title {
            font-size: 22px;
            font-weight: 500;
            margin-top: 30px
        }
    </style>

</head>

<body class="bg-silver-100">
	<div class="content">
		<h1 class="m-t-20">500</h1>
		<p class="error-title">Something Went Wrong</p>
		<h4 class="m-b-20">${message}</h4>
		<p class="m-b-20">We're sorry, but the server was unable to complete your request. You can
			contact support</p>
	</div>

	<div class="sidenav-backdrop backdrop"></div>
	<div class="preloader-backdrop">
		<div class="page-preloader">Loading</div>
	</div>
</body>
</html>