<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Strict//EN">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="org.stoevesand.brain.*"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@ taglib uri="http://myfaces.apache.org/trinidad" prefix="tr"%>
<%@ taglib uri="http://myfaces.apache.org/trinidad/html" prefix="trh"%>
<%
	String now = "" + System.currentTimeMillis();
	String ulid = request.getParameter("ulid");
	if (ulid != null) {
		BrainSession bss = BrainSystem.getBrainSystem()
				.getBrainSession();
		bss.putParameter("ulid", ulid);
		if (bss.isLoggedIn()) {
			boolean lessonok=bss.setCurrentUserLesson(ulid);
			if (!lessonok) {
				response.sendRedirect("/index.jsf");
			}
		}
	}
%>
<f:view locale="#{BrainSession.currentLocale}">
	<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>Notonto - Lektion</title>
	<trh:script source="/js/es.js" rendered="#{BrainSession.currentUserLesson.lesson.keyboardLayout=='ES'}" />
	<trh:script source="/js/de.js" rendered="#{BrainSession.currentUserLesson.lesson.keyboardLayout=='DE'}" />
	<trh:script source="/js/py.js" rendered="#{BrainSession.currentUserLesson.lesson.keyboardLayout=='PY'}" />
	<trh:script source="/js/en.js" rendered="#{BrainSession.currentUserLesson.lesson.keyboardLayout=='EN'}" />
	<t:stylesheet path="/css/jquery-ui-1.8.1.custom.css"></t:stylesheet>
	<f:subview id="s_inc_head">
		<jsp:include page="/snippets/inc_head.jsp" />
	</f:subview>
	</head>
	<trh:body id="body1" onkeydown="bodykeydown(event); return true;">
		<f:loadBundle basename="org.stoevesand.brain.i18n.MessagesBundle" var="bundle" />
		<f:subview id="s_headline">
			<jsp:include page="/snippets/headline.jsp" />
		</f:subview>
		<!-- LAYOUT-BLOCK 2-1 START -->
		<t:div id="shade" forceId="true" styleClass="outer">
			<t:div styleClass="block">
				<t:div styleClass="content_col">
					<t:div styleClass="content" rendered="#{Auth.isLoggedIn}">
						<t:htmlTag value="h1">
							<h:outputText value="#{BrainSession.currentUserLesson.lesson.description}" />
						</t:htmlTag>
					</t:div>
					<t:div styleClass="content" rendered="#{Auth.isLoggedIn}">
						<!-- ### CONTENT-START ### -->
						<h:panelGrid columns="1" styleClass="w100p" columnClasses="ta_right" rendered="#{not empty BrainSession.currentUserLesson.currentUserItem}">
							<h:commandLink styleClass="font1 link c2" onclick="$('#dialog-message').dialog('open'); return false;" value="#{bundle.feedback}" />
						</h:panelGrid>
						<t:div id="area_question" styleClass="" rendered="#{not empty BrainSession.currentUserLesson.currentUserItem}">
							<t:div styleClass="card">
								<h:panelGrid styleClass="w100p" columns="2" columnClasses="atop w150,atop w400">
									<h:outputText value="Level #{BrainSession.currentUserItem.showLevel}" styleClass="font5" />
									<t:div styleClass="ta_right">
										<h:commandLink styleClass="link" onclick="show_answer()">
											<h:outputText styleClass="font5 c2" value=">#{bundle.btn_showanswer}" />
										</h:commandLink>
									</t:div>
									<h:outputText value="" styleClass="font1" />
									<h:outputText value="#{BrainSession.currentUserItem.item.formattedText}" escape="false" styleClass="font4" rendered="#{BrainSession.currentUserLesson.lesson.lessonType==0}" />
									<h:outputText value="#{BrainSession.currentUserItem.item.formattedText}" escape="false" styleClass="fontsym ta_center" rendered="#{BrainSession.currentUserLesson.lesson.lessonType==1}" />
									<h:outputText value="" styleClass="font1" rendered="#{BrainSession.currentUserLesson.lesson.lessonType==1}" />
									<h:outputText value="[#{BrainSession.currentUserItem.item.comment}]" styleClass="font4 ta_center" rendered="#{BrainSession.currentUserLesson.lesson.lessonType==1 and BrainSession.currentUserLesson.config.showPinyin }" />
									<h:outputText value="" styleClass="font1" />
									<h:outputText value="" styleClass="font1" />
								</h:panelGrid>
							</t:div>
							<h:form id="answerform" rendered="#{not empty BrainSession.currentUserLesson.currentUserItem}" accept="text/plain">
								<h:panelGrid styleClass="" columns="2" columnClasses="atop w150,atop w400">
									<h:outputText value="#{bundle.youranswer}" styleClass="font5 c3" />
									<f:verbatim>
										<input type="hidden" id="now" value="<%=now%>" />
										<input type="text" id="answerinput<%=now%>" style="width: 400px;" onkeydown="return checkSpecialChar(event, this);" onkeyup="parse(this)" />
									</f:verbatim>
									<h:outputText value="" rendered="#{BrainSession.currentUserLesson.lesson.keyboardLayout=='PY'}" />
									<h:outputText id="pinyin" value="-" rendered="#{BrainSession.currentUserLesson.lesson.keyboardLayout=='PY'}" />
									<h:outputText value="" />
									<h:commandButton styleClass="btn_blue" id="submitlink" action="#{BrainSystem.checkAnswerText}" onclick="updateData(); return true;" value="#{bundle.btn_check}" />
								</h:panelGrid>
								<h:inputHidden id="keyboardLayout" value="#{BrainSession.currentUserLesson.lesson.keyboardLayout}" />
								<h:inputHidden id="answerin" value="#{BrainSession.answerText}"></h:inputHidden>
							</h:form>
						</t:div>
						<!-- ### Antwort ### -->
						<t:div id="area_answer" styleClass="hidden" rendered="#{not empty BrainSession.currentUserLesson.currentUserItem}">
							<t:div styleClass="card">
								<h:panelGrid styleClass="w100p" columns="2" columnClasses="atop w150,atop">
									<h:outputText value="Level #{BrainSession.currentUserItem.showLevel}" styleClass="font5" />
									<t:div styleClass="ta_right">
										<h:commandLink styleClass="link" onclick="show_question()">
											<h:outputText styleClass="font5 c1" value="<#{bundle.btn_showquestion}" />
										</h:commandLink>
									</t:div>
									<h:outputText value="" styleClass="font1" />
									<h:panelGroup>
										<h:outputText value="[#{BrainSession.currentUserItem.item.comment}]<p>" escape="false" styleClass="font4 ta_center" rendered="#{BrainSession.currentUserLesson.lesson.lessonType==1 and not BrainSession.currentUserLesson.config.showPinyin }" />
										<t:dataList value="#{BrainSession.currentUserItem.item.answers}" var="answer" itemStyleClass="#{BrainSession.currentUserItem.item.answersSize>1 ? 'font5' : 'font4'}" layout="#{BrainSession.currentUserItem.item.answersSize>1 ? 'unorderedList' : 'simple'}"
											styleClass="plainlist #{BrainSession.currentUserItem.item.answersSize>1 ? 'font5' : 'font4'}">
											<h:panelGroup rendered="#{answer.visible == true}">
												<h:outputText value="#{answer.text}" rendered="#{BrainSession.currentUserLesson.lesson.alang!='ch'}" />
												<h:outputText value="#{answer.text}" styleClass="fontsym" rendered="#{BrainSession.currentUserLesson.lesson.alang=='ch'}" />
												<h:outputText value="<br>#{answer.phonetic}" styleClass="font4 c1" escape="false" />
											</h:panelGroup>
										</t:dataList>
									</h:panelGroup>
									<h:outputText value="" styleClass="font1" />
									<h:outputText value="" styleClass="font1" />
								</h:panelGrid>
							</t:div>
							<h:form id="ynform" accept="text/plain">
								<t:div styleClass="ta_right">
									<h:outputText value="#{bundle.knowanswer}&nbsp;&nbsp;" escape="false" styleClass="font5 c3" />
									<h:commandLink id="btnyes" action="#{BrainSystem.knowAnswer}" styleClass="btn btn_green">
										<h:outputText value="#{bundle.btn_yes}" />
									</h:commandLink>
									<h:outputText styleClass="font5" value="&nbsp;" escape="no" />
									<h:commandLink id="btnno" action="#{BrainSystem.failAnswer}" styleClass="btn btn_red">
										<h:outputText value="#{bundle.btn_no}" />
									</h:commandLink>
								</t:div>
							</h:form>
						</t:div>
						<h:form rendered="#{empty BrainSession.currentUserLesson.currentUserItem}">
							<h:panelGrid columns="1" styleClass="w100p">
								<t:htmlTag value="h1">
									<h:outputText value="#{bundle.noitems}" />
								</t:htmlTag>
								<t:htmlTag value="h2">
									<h:outputText value="#{BrainSession.currentUserLesson.nextUserItemTimeDiff}" />
								</t:htmlTag>
								<h:commandLink styleClass="btn btn_blue" action="#{BrainSystem.tryNextUserItem}" value="Refresh" rendered="#{Auth.isLoggedIn}" />
							</h:panelGrid>
						</h:form>
						<!-- ### CONTENT-END ### -->
					</t:div>
					<t:div styleClass="content" rendered="#{not empty BrainSession.lastUserItem}">
						<!-- ### CONTENT-START ### -->
						<t:htmlTag value="h2">
							<h:outputText value="Richtige Antwort!" />
						</t:htmlTag>
						<h:panelGrid styleClass="tstd" columns="2" columnClasses="font2,">
							<h:outputText value="Level #{BrainSession.lastUserItem.showLevel}" />
							<h:outputText styleClass="" value="" />
							<h:outputText styleClass="font1" value="Wort" />
							<h:outputText styleClass="font1 green" value="#{BrainSession.lastUserItem.item.formattedText}" escape="false" rendered="#{BrainSession.currentUserLesson.lesson.lessonType==0}" />
							<h:outputText styleClass="font6 green" value="#{BrainSession.lastUserItem.item.formattedText}" escape="false" rendered="#{BrainSession.currentUserLesson.lesson.lessonType==1}" />
							<h:panelGroup>
								<h:outputText value="Mögliche Antworten" />
							</h:panelGroup>
							<t:dataList var="answer" value="#{BrainSession.lastUserItem.item.answers}" layout="orderedList" styleClass="plainlist font1">
								<h:outputText value="#{answer.text}" styleClass="font1 green" rendered="#{answer.text eq BrainSession.lastAnswerText}" />
								<h:outputText value="#{answer.text}" styleClass="font1" rendered="#{answer.text ne BrainSession.lastAnswerText}" />
							</t:dataList>
						</h:panelGrid>
						<!-- ### CONTENT-END ### -->
					</t:div>
				</t:div>
				<t:div styleClass="sidebar_col">
					<t:div styleClass="sidebar" rendered="#{Auth.isLoggedIn}">
						<!-- ### SIDEBAR-START ### -->
						<t:htmlTag value="h1">
							<h:outputText value="Info" />
						</t:htmlTag>
						<t:div styleClass="font1 tbmargin">
							<h:outputText value="#{bundle.lessoninfo}" escape="false" />
						</t:div>
						<!-- ### SIDEBAR-END ### -->
					</t:div>
					<t:div styleClass="sidebar" rendered="#{Auth.isLoggedIn}">
						<!-- ### SIDEBAR-START ### -->
						<t:htmlTag value="h1">
							<h:outputText value="#{bundle.key_hint}" />
						</t:htmlTag>
						<t:div styleClass="font1 tbmargin">
							<t:panelGrid columns="2" columnClasses="box,font1">
								<h:outputText value="&rarr;" escape="false" />
								<h:outputText value="#{bundle.key_answer}" escape="false" />
								<h:outputText value="&larr;" escape="false" />
								<h:outputText value="#{bundle.key_question}" escape="false" />
								<h:outputText value="&uarr;" escape="false" />
								<h:outputText value="#{bundle.key_yes}" escape="false" />
								<h:outputText value="&darr;" escape="false" />
								<h:outputText value="#{bundle.key_no}" escape="false" />
							</t:panelGrid>
						</t:div>
						<!-- ### SIDEBAR-END ### -->
					</t:div>
					<t:div styleClass="sidebar" rendered="#{Auth.isLoggedIn}">
						<!-- ### SIDEBAR-START ### -->
						<t:htmlTag value="h1">
							<h:outputText value="Statistik" />
						</t:htmlTag>
						<f:subview id="i_s_left">
							<jsp:include page="/snippets/userlessonstat.jsp" />
						</f:subview>
						<!-- ### SIDEBAR-END ### -->
					</t:div>
					<f:subview id="pleaseli">
						<jsp:include page="/snippets/pleaselogin.jsp" />
					</f:subview>
				</t:div>
			</t:div>
		</t:div>
		<!-- LAYOUT-BLOCK 2-1 END -->
		<f:subview id="i_s_left_ol_comment">
			<jsp:include page="/snippets/ol_comment.jsp" />
		</f:subview>
		<f:verbatim escape="false">
			<script>
		document.getElementById('answerinput<%=now%>').focus()
</script>
		</f:verbatim>
	</trh:body>
	</html>
</f:view>
