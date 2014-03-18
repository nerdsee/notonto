<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Strict//EN">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<f:view locale="#{BrainSession.currentLocale}">
	<f:loadBundle basename="org.stoevesand.brain.i18n.MessagesBundle" var="bundle" />
	<html>
	<head>
	<title>Notonto - Lektion</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<f:subview id="s_inc_head">
		<jsp:include page="/snippets/inc_head.jsp" />
	</f:subview>
	</head>
	<body onLoad="document.getElementById('nextfrm:nextbtn').focus()">
	<f:subview id="s_headline">
		<jsp:include page="/snippets/headline.jsp" />
	</f:subview>
	<!-- LAYOUT-BLOCK 2-1 START -->
	<t:div id="shade" forceId="true" styleClass="outer">
		<t:div styleClass="block">
			<t:div styleClass="content_col">
				<t:div styleClass="content">
					<t:div styleClass="content_pad">
						<!-- ### CONTENT-START ### -->
						<h1><h:outputText value="#{BrainSession.currentUserLesson.lesson.description}" /></h1>
						<h:form id="nextfrm">
							<h:panelGrid styleClass="table1" columns="2" columnClasses="atop w150 font1,atop w150 font1">
								<h:outputText value="Level" />
								<h:outputText value="#{BrainSession.currentUserItem.showLevel}" />
								<h:outputText styleClass="green" value="Wort" />
								<h:outputText styleClass="green" value="#{BrainSession.currentUserItem.item.text}" />
								<h:outputText styleClass="green" value="Ihre Antwort" />
								<h:outputText styleClass="green" value="#{BrainSession.answerText}" />
								<h:outputText value="Mögliche Antworten" />
								<h:dataTable value="#{BrainSession.currentUserItem.item.answers}" var="answer">
									<h:column rendered="#{answer.visible}">
										<h:outputText value="#{answer.text}" styleClass="font1" />
									</h:column>
								</h:dataTable>
								<h:outputText value="" />
								<h:commandButton id="nextbtn" action="#{BrainSystem.getNextItem}" value="next" styleClass="button" />
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
						<h:panelGrid columns="2" styleClass="box_white">
							<h:outputText value="gewusst" />
							<h:outputText value="#{BrainSession.currentUserItem.wright}"></h:outputText>
							<h:outputText value="nicht gewusst" />
							<h:outputText value="#{BrainSession.currentUserItem.wrong}"></h:outputText>
						</h:panelGrid>
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