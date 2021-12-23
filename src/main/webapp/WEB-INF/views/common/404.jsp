<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
		 pageEncoding="ISO-8859-1" %>


<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Page Not Found</title>

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
		<h1 class="m-t-20">404</h1>
		<p class="error-title">PAGE NOT FOUND</p>
		<p class="m-b-20">Sorry, the page you were looking for could not found. Please check the URL and try your luck again.
			<a class="color-green" href="/home">Go homepage</a> or try the search bar below.</p>
		<form action="javascript:;">
			<div class="input-group">
				<input class="form-control" type="text" placeholder="Search for page">
				<div class="input-group-btn">
					<button class="btn btn-success" type="button">Search</button>
				</div>
			</div>
		</form>
	</div>

	<div class="sidenav-backdrop backdrop"></div>
	<div class="preloader-backdrop">
		<div class="page-preloader">Loading</div>
	</div>




</body>
</html>