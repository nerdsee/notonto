<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Strict//EN">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@ taglib uri="http://myfaces.apache.org/trinidad/html" prefix="trh"%>
<f:view locale="#{BrainSession.currentLocale}">
	<html>
	<head>
	<title><h:outputText value="Notonto - #{bundle.menu_learn}" /></title>
	<f:subview id="s_inc_head">
		<jsp:include page="/snippets/inc_head.jsp" />
	</f:subview>
	</head>
	<body>
	<f:subview id="s_headline">
		<jsp:include page="/snippets/headline.jsp" />
	</f:subview>
	<!-- LAYOUT-BLOCK 2-1 START -->
	<t:div id="shade" forceId="true" styleClass="outer">
		<t:div styleClass="block">
			<t:div styleClass="content_col">
				<t:div styleClass="content" rendered="#{Auth.isLoggedIn}">
					<!-- ### CONTENT-START ### -->
					<t:htmlTag value="h1">
						<h:outputText value="#{bundle.menu_learn}" />
					</t:htmlTag>
					<t:div styleClass="infotext" rendered="#{empty BrainSession.currentUser.lessons}">
						<h:outputText value="#{bundle.subfirst}" />
					</t:div>
					<h:form>
						<h:dataTable styleClass="wco" value="#{BrainSession.currentUser.lessons}" rendered="#{not empty BrainSession.currentUser.lessons}" var="userlesson">
							<h:column>
								<h:panelGrid columnClasses=",left w100p,," columns="4" styleClass="tl">
									<h:graphicImage url="/images/lessons/lesson_button_#{userlesson.lesson.icon}.gif" styleClass="icon" width="32" height="32" />
									<h:commandLink action="#{BrainSession.learnLesson}" styleClass="btn_lesson">
										<h:outputText value="#{userlesson.lesson.description}" styleClass="font1 bold" />
										<h:graphicImage styleClass="flag" value="/images/#{userlesson.lesson.qlang}.gif" width="15" height="9" style="margin-left: 10px;"/>
										<h:graphicImage styleClass="flag" value="/images/#{userlesson.lesson.alang}.gif" width="15" height="9" style="margin-left: 5px;"/>
										<h:outputText value="<br>" escape="false" />
										<h:outputFormat value="#{bundle.learnitems}" styleClass="font3">
											<f:param value="#{userlesson.available}" />
										</h:outputFormat>
										<h:outputText value="<br> [#{userlesson.nextUserItemTimeDiff} ]" escape="false" rendered="#{userlesson.available==0}" styleClass="font3" />
										<h:outputText value="<br><i>Zieltermin: #{userlesson.targetDate}</i>" escape="false" rendered="#{userlesson.intervallType==1}" styleClass="font3" />
									</h:commandLink>
									<h:panelGroup>
										<h:commandButton image="/images/icons/conf.gif" styleClass="btn_empty" action="#{BrainSystem.confLesson}" value="#{bundle.btn_conf}" rendered="#{Auth.isLoggedIn}" />
									</h:panelGroup>
									<h:panelGroup>
										<h:commandButton image="/images/icons/delete.gif" styleClass="btn_empty" onclick="if ( !shure('#{userlesson.lesson.description}') ) return false;" action="#{BrainSession.unsubscribeLesson}" value="#{bundle.btn_delete}" rendered="#{Auth.isLoggedIn}" />
									</h:panelGroup>
								</h:panelGrid>
							</h:column>
						</h:dataTable>
					</h:form>
					<!-- ### CONTENT-END ### -->
					<f:subview id="pleaseli">
						<jsp:include page="/snippets/pleaselogin.jsp" />
					</f:subview>
				</t:div>
			</t:div>
			<t:div styleClass="sidebar_col">
				<t:div styleClass="sidebar" rendered="#{Auth.isLoggedIn}">
					<t:htmlTag value="h1">
						<h:outputText value="#{bundle.contact}" />
					</t:htmlTag>
					<t:div styleClass="font1 tbmargin">
						<h:outputText value="#{bundle.contact_text}" />
					</t:div>
					<h:outputLink value="/kontakt.jsf" styleClass="link">
						<h:outputText value="> #{bundle.contact}" styleClass="font1 c2" />
					</h:outputLink>
				</t:div>
				<!-- ### SIDEBAR-START ### -->
				<t:div styleClass="sidebar" rendered="#{Auth.isLoggedIn}">
					<t:htmlTag value="h1">
						<h:outputText value="#{bundle.menu_stat}" />
					</t:htmlTag>
					<t:div styleClass="font1 tbmargin">
						<h:outputText value="#{bundle.stat_text}" />
					</t:div>
					<h:outputLink value="/stat.jsf" styleClass="link">
						<h:outputText value="> #{bundle.menu_stat}" styleClass="font1 c2" />
					</h:outputLink>
				</t:div>
				<f:subview id="s_ff_sm">
					<jsp:include page="/snippets/firefox_sm.jsp" />
				</f:subview>
				<!-- ### SIDEBAR-END ### -->
			</t:div>
		</t:div>
	</t:div>
	<!-- LAYOUT-BLOCK 2-1 END -->
	<f:subview id="s_footer">
		<jsp:include page="/snippets/footer.jsp" />
	</f:subview>
	</body>
	</html>
</f:view>
