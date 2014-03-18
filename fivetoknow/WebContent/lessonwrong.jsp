<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Strict//EN">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@ taglib uri="http://myfaces.apache.org/trinidad/html" prefix="trh"%>
<f:view locale="#{BrainSession.currentLocale}">
	<html>
	<head>
	<title>Notonto - UserLesson</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<f:subview id="s_inc_head">
		<jsp:include page="/snippets/inc_head.jsp" />
	</f:subview>
	</head>
	<body onLoad="document.getElementById('nextfrm:nextbtn').focus()">
	<f:loadBundle basename="org.stoevesand.brain.i18n.MessagesBundle" var="bundle" />
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
						<t:htmlTag value="h1">
							<h:outputText value="#{BrainSession.currentUserLesson.lesson.description}" />
						</t:htmlTag>
						<h:panelGrid columns="2" styleClass="tstd" columnClasses="font2,">
							<h:outputText value="Level #{BrainSession.currentUserItem.showLevel}" />
							<h:outputText value="" />
							<h:outputText styleClass="red" value="" />
							<h:outputText value="#{BrainSession.currentUserItem.item.formattedText}" escape="false" styleClass="red font4" rendered="#{BrainSession.currentUserLesson.lesson.lessonType==0}" />
							<h:outputText value="#{BrainSession.currentUserItem.item.formattedText}" escape="false" styleClass="red fontsym" rendered="#{BrainSession.currentUserLesson.lesson.lessonType==1}" />
							<h:outputText value="" styleClass="font1" rendered="#{BrainSession.currentUserLesson.lesson.lessonType==1}" />
							<h:outputText value="#{BrainSession.currentUserItem.item.comment}" styleClass="red font4" rendered="#{BrainSession.currentUserLesson.lesson.lessonType==1}" />
							<h:outputText styleClass="red" value="Ihre Antwort" />
							<h:outputText styleClass="red font4" escape="false" value="#{BrainSystem.markedText}"></h:outputText>
							<h:outputText value="Mögliche Antworten" />
							<t:dataList value="#{BrainSession.currentUserItem.item.answers}" var="answer" itemStyleClass="font5" layout="orderedList" styleClass="plainlist font5">
								<h:outputText value="#{answer.text}" />
							</t:dataList>
						</h:panelGrid>
						<h:form id="nextfrm">
							<h:panelGrid columns="2" columnClasses="w150, w400">
								<h:outputText value="" />
								<h:commandLink id="nextbtn" action="#{BrainSystem.getNextItem}" styleClass="btn btn_blue">
									<h:outputText value="#{bundle.btn_next}" />
								</h:commandLink>
								<h:outputText value="" />
								<h:commandLink id="iknowlink" action="#{BrainSystem.forceAnswer}" styleClass="btn btn_green">
									<h:outputText value="#{bundle.btn_force}" />
								</h:commandLink>
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
						<!-- ### SIDEBAR-END ### -->
					</t:div>
				</t:div>
			</t:div>
		</t:div>
	</t:div>
	<!-- LAYOUT-BLOCK 2-1 END -->
	<f:subview id="i_s_left_ol_comment">
		<jsp:include page="/snippets/ol_comment.jsp" />
	</f:subview>
	</body>
	</html>
</f:view>
