<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
		 pageEncoding="ISO-8859-1" %>


<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Insert title here</title>

</head>
<body data-spy="scroll" data-target=".bs-docs-sidebar">
<header>
	<!-- Navbar
	================================================== -->
	<div class="navbar navbar-fixed-top">
		<div class="navbar-inner">
			<div class="container">
				<!-- logo -->
				<a class="brand logo" href="/home"><img src="/img/logo.png" alt=""/></a>
				<!-- end logo -->
				<!-- top menu -->
				<div class="navigation pull-right">
					<nav>
						<ul class="sm sm-blue pull-left">
							<li >
								<a href="/home">Home</a>
							</li>
							<li >
								<a href="/logout">Logout</a>
							</li>
						</ul>
					</nav>
				</div>
				<!-- end menu -->
			</div>
		</div>
	</div>
</header>
<!-- Subhead
================================================== -->
<section id="subintro">
	<div class="jumbotron subhead" id="overview">
		<div class="container">
			<div class="row">
				<div class="span12">
					<div class="centered">
						<h3 >Something Went Wrong</h3>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<section id="maincontent">
	<div class="container">
		<div class="row">
			<div class="span12">
				<div class="centered">
					<%--<h3 class="error">400</h3>--%>
					<h4>${message}</h4>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- Footer
================================================== -->




</body>
</html>