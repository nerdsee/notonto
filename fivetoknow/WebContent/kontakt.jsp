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
	<f:subview id="s_inc_head">
		<jsp:include page="/snippets/inc_head.jsp" />
	</f:subview>
	</head>
	<trh:body id="body" initialFocusId="ff1:it1">
		<f:subview id="s_headline">
			<jsp:include page="/snippets/headline.jsp" />
		</f:subview>
		<!-- LAYOUT-BLOCK 2-1 START -->
		<t:div id="shade" forceId="true" styleClass="outer">
			<t:div styleClass="block" rendered="#{Auth.isLoggedIn}">
				<t:div styleClass="content_col">
					
					<t:div styleClass="content">
						<t:div styleClass="content_pad">
							<!-- ### CONTENT-START ### -->
							<t:htmlTag value="h1">
								<h:outputText value="#{bundle.contact}" />
							</t:htmlTag>
							<t:htmlTag value="h2">
								<h:outputText value="#{bundle.contact_text}" />
							</t:htmlTag>
							<h:form>
								<h:panelGrid columns="1">
									<h:inputTextarea required="true" id="msgtxt" value="#{BrainSession.message}" rows="15" cols="60">
									</h:inputTextarea>
									<h:message for="msgtxt" styleClass="errortext"/>
									<h:commandLink styleClass="btn btn_blue" action="#{BrainSystem.leaveMessage}" value="#{bundle.btn_send}" />
								</h:panelGrid>
							</h:form>
							<!-- ### CONTENT-END ### -->
						</t:div>
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
