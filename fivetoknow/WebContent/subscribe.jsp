<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<f:view locale="#{BrainSession.currentLocale}">
	<html>
	<head>
	<title>Notonto - User</title>
	<f:subview id="s_inc_head">
		<jsp:include page="/snippets/inc_head.jsp" />
	</f:subview>
	</head>
	<body>
	<f:loadBundle basename="org.stoevesand.brain.i18n.MessagesBundle" var="bundle" />
	<t:div styleClass="outerBorder">
		<f:subview id="s_headline">
			<jsp:include page="/snippets/headline.jsp" />
		</f:subview>
		<t:div styleClass="main">
			<f:subview id="s_left">
				<jsp:include page="/snippets/left.jsp" />
			</f:subview>
			<t:div styleClass="content">
				<h1><h:outputText value="#{bundle.menu_verw}" /></h1>
				<h2><h:outputText value="#{bundle.subscribed}" /></h2>
				<h:form>
					<h:dataTable style="width: 350px" value="#{BrainSession.currentUser.lessons}" var="userlesson">
						<h:column>
							<f:facet name="header">
								<h:outputText value="#{bundle.lessonname}" />
							</f:facet>
							<h:outputText value="#{userlesson.lesson.description}" />
						</h:column>
						<h:column>
							<f:facet name="header">
								<h:outputText value="" />
							</f:facet>
							<h:commandLink action="#{BrainSession.unsubscribeLesson}" onclick="if ( !shure() ) return false;">
								<h:outputText value="delete" />
							</h:commandLink>
						</h:column>
					</h:dataTable>
					<hr />
					<p />
					<h2><h:outputText value="#{bundle.unsubscribed}" /></h2>
					<h:dataTable style="width: 350px" value="#{BrainSystem.unsubscribedLessons}" var="lesson">
						<h:column>
							<f:facet name="header">
								<h:outputText value="#{bundle.lessonname}" />
							</f:facet>
							<h:outputText value="#{lesson.description}" />
						</h:column>
						<h:column>
							<f:facet name="header">
								<h:outputText value="" />
							</f:facet>
							<h:commandLink action="#{BrainSession.subscribeLesson}">
								<h:outputText value="subscribe" />
							</h:commandLink>
						</h:column>
					</h:dataTable>
				</h:form>
			</t:div>
		</t:div>
	</t:div>
	<f:subview id="s_footer">
		<jsp:include page="/snippets/footer.jsp" />
	</f:subview>
	</body>
	</html>
</f:view>