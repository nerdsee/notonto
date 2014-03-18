<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Strict//EN">
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
		$("#resetyesno").hide();
	});

	function sure_reset() {
		var options = {};
		$("#resetgrid").toggle('blind',options,'100');
		$("#resetyesno").toggle('blind',options,'400');
		}
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
						<t:div styleClass="content_pad">
							<t:htmlTag value="h1">
								<h:outputText value="#{bundle.lessonconf}" />
							</t:htmlTag>
							<!-- ### LERNINTERVALL ### -->
							<t:htmlTag value="h2" style="margin-top: 20px;">
								<h:outputText value="Lernintervalle festlegen" />
							</t:htmlTag>
							<h:outputText styleClass="infotext" value="#{bundle.co_tgd_info}" escape="false" style="display: block;margin-bottom:5px;"></h:outputText>
							<h:form>
								<t:selectOneRadio value="#{BrainSession.currentUserLesson.intervallType}" forceId="true" forceIdIndex="false" id="radios" layout="spread">
									<f:selectItem itemValue="0" itemLabel=""></f:selectItem>
									<f:selectItem itemValue="1" itemLabel=""></f:selectItem>
								</t:selectOneRadio>
								<h:panelGrid columns="2" styleClass="tstd" columnClasses="w30,">
									<t:radio index="0" for="radios"></t:radio>
									<h:panelGroup>
										<h:outputText value="#{bundle.co_std}" styleClass="bold" style="display: block;margin:0px;"></h:outputText>
										<h:outputText value="#{bundle.co_std_text}"></h:outputText>
									</h:panelGroup>
									<t:radio index="1" for="radios"></t:radio>
									<h:panelGroup>
										<h:outputText value="#{bundle.co_tgd}" styleClass="bold" style="display: block"></h:outputText>
										<h:outputText styleClass="font1" value="#{bundle.co_tgd_text}" style="display: block;margin-bottom:5px;" escape="false"></h:outputText>
										<t:inputText value="#{BrainSession.currentUserLesson.targetDate}" autocomplete="off" onclick="$('input:radio[id=radios:1]').attr('checked', true)" forceId="true" id="datepicker"></t:inputText>
										<h:outputText value="#{BrainMessage.intervallsDateError}" styleClass="errortext" />
									</h:panelGroup>
									<h:outputText />
									<h:panelGroup>
										<h:commandLink value="OK" action="#{BrainSession.currentUserLesson.saveIntervalls}" styleClass="btn btn_blue" />
									</h:panelGroup>
								</h:panelGrid>
							</h:form>
							<!-- ### LERNINTERVALL-END ### -->
							<!-- ### CHINESE-START ### -->
							<t:htmlTag value="h2" style="margin-top: 20px;" rendered="#{BrainSession.currentUserLesson.lesson.qlang=='ch'}">
								<h:outputText value="#{bundle.chinese}" />
							</t:htmlTag>
							<h:form id="ff1" rendered="#{BrainSession.currentUserLesson.lesson.qlang=='ch'}">
								<h:panelGrid columns="2" columnClasses="tstd" columnClasses="w30,">
									<h:selectBooleanCheckbox value="#{BrainSession.currentUserLesson.config.showPinyin}" />
									<h:panelGroup>
										<h:outputText value="#{bundle.pinyin_conf_head}<br>" escape="false" styleClass="font1 bold" />
										<h:outputText value="#{bundle.pinyin_conf_text}" escape="false" styleClass="font1" />
									</h:panelGroup>
									<h:outputText value="" />
									<h:commandLink styleClass="btn btn_blue" action="user" value="#{bundle.btn_ok}" />
								</h:panelGrid>
							</h:form>
							<!-- ### CHINESE-END ### -->
							<!-- ### RESET-START ### -->
							<t:htmlTag value="h2" style="margin-top: 20px;">
								<h:outputText value="Reset" />
							</t:htmlTag>
							<h:form>
								<t:panelGrid id="resetgrid" forceId="true" columns="2" columnClasses="tstd" columnClasses="w30,">
									<h:outputText></h:outputText>
									<h:outputText value="#{bundle.co_reset_text}" />
									<h:outputText></h:outputText>
									<h:commandLink styleClass="btn btn_red" onclick="sure_reset(); return false;" action="user" value="Reset" />
								</t:panelGrid>
								<t:panelGrid id="resetyesno" forceId="true" columns="2" columnClasses="tstd" columnClasses="w30,">
									<h:outputText></h:outputText>
									<h:outputText value="#{bundle.co_reset_sure}" />
									<h:outputText></h:outputText>
									<h:panelGroup>
										<h:commandLink styleClass="btn btn_red" action="#{BrainSession.currentUserLesson.reset}" value="#{bundle.btn_yes}" />
										<h:commandLink styleClass="btn btn_blue" onclick="sure_reset(); return false;" action="user" value="#{bundle.btn_no}" />
									</h:panelGroup>
								</t:panelGrid>
							</h:form>
							<!-- ### RESET-END ### -->
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
	</trh:body>
	</html>
</f:view>
