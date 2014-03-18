<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@ taglib uri="http://myfaces.apache.org/trinidad" prefix="tr"%>
<%@ taglib uri="http://myfaces.apache.org/trinidad/html" prefix="trh"%>
<f:view locale="#{BrainSession.currentLocale}">
	<f:loadBundle basename="org.stoevesand.brain.i18n.MessagesBundle" var="bundle" />
	<html>
	<head>
	<title>Notonto - Administration</title>
	<t:stylesheet path="/css/style2.css"></t:stylesheet>
	</head>
	<trh:body id="body" initialFocusId="ff1:it1">
		<f:subview id="s_headline">
			<jsp:include page="/snippets/headline.jsp" />
		</f:subview>
		<!-- LAYOUT-BLOCK 2-1 START -->
		<t:div id="shade" forceId="true" styleClass="outer">
			<t:div styleClass="block" rendered="#{Auth.isLoggedIn && BrainSession.currentUser.isAdmin}">
				<t:div styleClass="content_col">
					<t:div styleClass="content">
						<!-- ### CONTENT-START ### -->
						<!-- ### CONTENT-END ### -->
					</t:div>
				</t:div>
				<t:div styleClass="sidebar_col">
					<f:subview id="s_sidem">
						<jsp:include page="/snippets/sidemenu_admin.jsp" />
					</f:subview>
				</t:div>
			</t:div>
			<!-- LAYOUT-BLOCK 2-1 END -->
		</t:div>
	</trh:body>
	</html>
</f:view>
