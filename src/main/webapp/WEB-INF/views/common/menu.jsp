<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<nav class="page-sidebar" id="sidebar">
	<div id="sidebar-collapse">
		<div class="admin-block d-flex">
			<div>
				<!--<img src="./assets/img/admin-avatar.png" width="45px" /> -->
			</div>
			<div class="admin-info">
				<div class="font-strong">${personName}</div>
				<!--<small>Administrator</small>-->
			</div>
		</div>
		<ul class="side-menu metismenu">
			<c:forEach items="${servicesMenu}" var="service">

			        <c:if test="${service.parentId eq 0 && service.hasChilds eq true}">

						<li><a href="${service.serviceUrl}"><i
								class="sidebar-item-icon fa fa-file-text"></i> <span
								class="nav-label">${service.serviceName}</span><i
								class="fa fa-angle-left arrow"></i></a>
							<ul class="nav-2-level collapse">
                                <c:forEach items="${servicesMenu}" var="inner_service">

									<c:if test="${service.serviceId eq inner_service.parentId }">
										<li><a href="${inner_service.serviceUrl }"><i
												class="sidebar-item-icon fa fa-file-text"></i>
												${inner_service.serviceName}</a></li>
									</c:if>
								</c:forEach>
							</ul>
						</li>
					</c:if>
					<c:if test="${service.parentId eq 0 && service.hasChilds eq false}">

						<li><a href="${service.serviceUrl }"><i
								class="sidebar-item-icon fa fa-th-large"></i> <span
								class="nav-label">${service.serviceName}</span> </a></li>
                    </c:if>
            </c:forEach>
		</ul>

	</div>
</nav>