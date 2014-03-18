<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@ taglib uri="http://myfaces.apache.org/trinidad" prefix="tr"%>
<%
	String now = "" + System.currentTimeMillis();
%>
<f:view locale="#{BrainSession.currentLocale}">
	<html>
	<head>
	<title>Notonto - Edit Item</title>
	<t:stylesheet path="/css/style2.css"></t:stylesheet>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/code.js"></script>
	</head>
	<body onLoad="document.getElementById('answerinput<%=now%>').focus()">
	<f:loadBundle basename="org.stoevesand.brain.i18n.MessagesBundle" var="bundle" />
	<f:subview id="s_headline">
		<jsp:include page="/snippets/headline.jsp" />
	</f:subview>
	<!-- LAYOUT-BLOCK 2-1 START -->
	<t:div styleClass="block">
		<t:div styleClass="content_col">
			<t:div styleClass="content">
				<!-- ### CONTENT-START ### -->
				<h1><h:outputText value="#{bundle.edititem}" /></h1>
				<h:form enctype="UTF-8" acceptcharset="UTF-8">
					<h:panelGrid columns="2">
						<h:outputText value="Title" />
						<h:inputText value="#{BrainSession.currentNews.title}" size="40" />
						<h:outputText value="Locale" />
						<h:inputText value="#{BrainSession.currentNews.locale}" size="4" />
						<h:outputText value="Text" />
						<h:inputTextarea value="#{BrainSession.currentNews.text}" cols="40" rows="10" />
						<h:outputText value="Type" />
						<tr:selectOneChoice value="#{BrainSession.currentNews.type}">
							<tr:selectItem value="0" label="<ohne>" />
							<tr:selectItem value="1" label="Plugin" />
							<tr:selectItem value="2" label="Lektion" />
							<tr:selectItem value="3" label="Allgemein" />
						</tr:selectOneChoice>
					</h:panelGrid>
					<h:commandButton value="Cancel" action="#{BrainSession.currentNews.rollbackAction}" />
					<h:commandButton value="OK" action="#{BrainSession.currentNews.saveAction}" />
				</h:form>
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
	</body>
	</html>
</f:view>