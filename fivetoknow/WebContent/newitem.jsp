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
	<title>Edit Item</title>
	<f:subview id="s_inc_head">
		<jsp:include page="/snippets/inc_head.jsp" />
	</f:subview>
	</head>
	<body onLoad="document.getElementById('answerinput<%=now%>').focus()">
	<f:loadBundle basename="org.stoevesand.brain.i18n.MessagesBundle" var="bundle" />
	<f:subview id="s_headline">
		<jsp:include page="/snippets/headline.jsp" />
	</f:subview>
	<!-- LAYOUT-BLOCK 2-1 START -->
	<t:div styleClass="outer grey">
		<t:div styleClass="block">
			<t:div styleClass="content_col">
				<t:div styleClass="content">
					<t:div styleClass="content_pad">
						<!-- ### CONTENT-START ### -->
						<h1><h:outputText value="#{bundle.newitem}" /></h1>
						<h:form enctype="UTF-8" acceptcharset="UTF-8">
							<h:panelGrid columns="2">
								<h:outputText value="Question" styleClass="font2" />
								<h:inputTextarea id="cutin" value="#{BrainSession.currentItem.text}" cols="40" rows="4" required="true" />
								<h:outputText value="" />
								<h:message for="cutin"></h:message>
								<h:outputText value="Answers" styleClass="font2" />
								<h:panelGroup>
									<t:inputTextarea value="#{BrainSession.currentItem.newAnswerText}" cols="40" rows="4" />
								</h:panelGroup>
								<h:outputText value="Chapter" styleClass="font2" />
								<h:inputText value="#{BrainSession.currentItem.chapter}" size="5" />
								<h:outputText value="" />
								<h:panelGroup>
									<h:commandButton styleClass="font5 naked c4" value=">OK" action="#{BrainSession.saveCurrentItem}" />
									<h:commandButton styleClass="font5 naked c2" value=">Cancel" action="#{BrainSession.currentItem.rollbackAction}" />
								</h:panelGroup>
							</h:panelGrid>
						</h:form>
						<!-- ### CONTENT-END ### -->
					</t:div>
				</t:div>
			</t:div>
			<t:div styleClass="sidebar_col">
				<t:div styleClass="sidebar">
					<t:div styleClass="content_pad">
						<!-- ### SIDEBAR-START ### -->
						<h1>Sidebar</h1>
						<f:subview id="i_s_left">
							<jsp:include page="/snippets/left.jsp" />
						</f:subview>
						<!-- ### SIDEBAR-END ### -->
					</t:div>
				</t:div>
			</t:div>
		</t:div>
	</t:div>
	<!-- LAYOUT-BLOCK 2-1 END -->
	</body>
	</html>
</f:view>