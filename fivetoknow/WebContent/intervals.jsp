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
	<title>Notonto - Optionen</title>
	<t:stylesheet path="/css/jquery-ui-1.8.1.custom.css"></t:stylesheet>
	<f:subview id="s_inc_head">
		<jsp:include page="/snippets/inc_head.jsp" />
	</f:subview>
	<trh:script source="/js/jquery-datepicker-i18n.js" />
	<script type="text/javascript">
	$(function() {
		$.datepicker.setDefaults($.datepicker.regional['de']);
		$("#datepicker").datepicker($.datepicker.regional['de']);
	});
	</script>
	</head>
	<trh:body id="body" initialFocusId="ff1:it1">
		<f:subview id="s_headline">
			<jsp:include page="/snippets/headline.jsp" />
		</f:subview>
		<!-- LAYOUT-BLOCK 2-1 START -->
		<t:div id="shade" forceId="true" styleClass="outer">
			<t:div styleClass="block">
				<t:div styleClass="content_col">
					<t:div styleClass="content">
						<t:div styleClass="content_pad" rendered="#{Auth.isLoggedIn}">
							<!-- ### CONTENT-START ### -->
							<t:htmlTag value="h1">
								<h:outputText value="Optionen: #{BrainSession.currentUserLesson.lesson.description}" />
							</t:htmlTag>
							<t:htmlTag value="h2">
								<h:outputText value="Lernintervalle festlegen" />
							</t:htmlTag>
							<h:form>
								<t:selectOneRadio value="#{BrainSession.currentUserLesson.intervallType}" forceId="true" forceIdIndex="false" id="radios" layout="spread">
									<f:selectItem itemValue="0" itemLabel=""></f:selectItem>
									<f:selectItem itemValue="1" itemLabel=""></f:selectItem>
								</t:selectOneRadio>
								<h:panelGrid columns="2" styleClass="tstd">
									<t:radio index="0" for="radios"></t:radio>
									<h:panelGroup>
										<h:outputText value="Standard" style="display: block"></h:outputText>
										<h:outputText value="Standardverteilung nach den Erkenntnissen der Lernpsychologie."></h:outputText>
									</h:panelGroup>
									<t:radio index="1" for="radios"></t:radio>
									<h:panelGroup>
										<h:outputText value="Zieltermin" style="display: block"></h:outputText>
										<t:inputText value="#{BrainSession.currentUserLesson.targetDate}" onclick="$('input:radio[id=radios:1]').attr('checked', true)" forceId="true" id="datepicker"></t:inputText>
										<h:outputText value="#{BrainMessage.intervallsDateError}" styleClass="errortext"/>
									</h:panelGroup>
									<h:outputText />
									<h:panelGroup>
										<h:commandLink value="OK" action="#{BrainSession.currentUserLesson.saveIntervalls}" styleClass="btn btn_blue" />
									</h:panelGroup>
								</h:panelGrid>
							</h:form>
							<!-- ### CONTENT-END ### -->
						</t:div>
						<f:subview id="pleaseli">
							<jsp:include page="/snippets/pleaselogin.jsp" />
						</f:subview>
					</t:div>
				</t:div>
				<t:div styleClass="sidebar_col">
				</t:div>
			</t:div>
		</t:div>
		<!-- LAYOUT-BLOCK 2-1 END -->
	</trh:body>
	</html>
</f:view>
