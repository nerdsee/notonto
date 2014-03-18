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
	<title><h:outputText value="Notonto - #{bundle.menu_teacher}" /></title>
	<f:subview id="s_inc_head">
		<jsp:include page="/snippets/inc_head.jsp" />
	</f:subview>
	</head>
	<body>
	<f:subview id="s_headline">
		<jsp:include page="/snippets/headline.jsp" />
	</f:subview>
	<t:div id="shade" forceId="true" styleClass="outer">
		<!-- LAYOUT-BLOCK 2-1 START -->
		<t:div styleClass="block">
			<t:div styleClass="content_col">
				<t:div styleClass="content">
					<!-- ### CONTENT-START ### -->
					<t:htmlTag value="h1">
						<h:outputText value="#{bundle.menu_teacher}" />
					</t:htmlTag>
					<t:htmlTag value="h3">
						<h:outputText value="#{bundle.teacherinfo}" />
					</t:htmlTag>
					<t:div styleClass="hinttext" rendered="#{not Auth.isLoggedIn}">
						<h:outputText value="#{bundle.liblogin}" />
					</t:div>
					<h:form>
						<t:dataTable value="#{BrainSession.ownerLibrary}" var="lw" columnClasses="liblist,liblist w100p">
							<t:column>
								<h:graphicImage url="/images/lessons/lesson_button_#{lw.lesson.icon}.gif" styleClass="icon" width="32" height="32" />
							</t:column>
							<t:column>
								<h:panelGrid columns="2" columnClasses=",ta_right" styleClass="w100p">
									<h:outputText value="#{lw.lesson.description}" styleClass="font1 bold" />
									<h:panelGroup>
										<h:graphicImage styleClass="flag" value="/images/#{lw.lesson.qlang}.gif" width="15" height="9" />
										<h:outputText value="&nbsp;" escape="false" />
										<h:graphicImage styleClass="flag" value="/images/#{lw.lesson.alang}.gif" width="15" height="9" />
									</h:panelGroup>
								</h:panelGrid>
								<h:panelGrid columns="2" columnClasses="ta_left, ta_right" styleClass="w100p">
									<h:panelGrid columns="2" styleClass="font3" columnClasses="">
										<h:outputText escape="false" value="#{bundle.numberitems}" />
										<h:outputText value="#{lw.lesson.itemCount}" />
										<h:outputText escape="false" value="#{bundle.numbersubs}" />
										<h:outputText value="#{lw.lesson.subscriberCount}" />
										<h:outputText escape="false" value="#{bundle.usage}" />
										<h:outputText value="#{lw.lesson.usageCount}" />
									</h:panelGrid>
									<t:panelGroup rendered="#{Auth.isLoggedIn}">
										<h:commandLink action="#{BrainSession.subscribeOwnerLesson}" styleClass="nlink" style="margin-top: 4px">
											<h:outputText escape="false" value=">&nbsp;#{bundle.btn_subscribed}" styleClass="font2 cgr" rendered="#{lw.isSubscribed}" />
											<h:outputText escape="false" value=">&nbsp;#{bundle.btn_subscribe}" styleClass="font2 crd" rendered="#{not lw.isSubscribed}" />
										</h:commandLink>
										<h:outputText escape="false" value="<br>&nbsp<br>" style="font-size: 5px;" />
										<h:commandLink styleClass="btn btn_blue" action="#{BrainSession.editOwnerLesson}">
											<h:outputText value="#{bundle.btn_edit}" />
										</h:commandLink>
									</t:panelGroup>
								</h:panelGrid>
							</t:column>
						</t:dataTable>
					</h:form>
					<t:div styleClass="infotext" rendered="#{BrainSession.ownerLibrary.rowCount==0}">
						<h:outputText value="#{bundle.nolessons}" />
					</t:div>
					<!-- ### CONTENT-END ### -->
				</t:div>
			</t:div>
			<t:div styleClass="sidebar_col">
				<f:subview id="s_sidem">
					<jsp:include page="/snippets/sidemenu_teacher.jsp" />
				</f:subview>
			</t:div>
		</t:div>
		<!-- LAYOUT-BLOCK 2-1 END -->
	</t:div>
	</body>
	</html>
</f:view>
