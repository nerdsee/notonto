<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<f:view locale="#{BrainSession.currentLocale}">
	<html>
	<head>
	<title>User</title>
	<f:subview id="s_inc_head">
		<jsp:include page="/snippets/inc_head.jsp" />
	</f:subview>
	</head>
	<body onLoad="document.getElementById('loginfrm:loginname').focus()">
	<f:loadBundle basename="org.stoevesand.brain.i18n.MessagesBundle" var="bundle" />
	<f:subview id="s_headline">
		<jsp:include page="/snippets/headline.jsp" />
	</f:subview>
	<!-- LAYOUT-BLOCK 2-1 START -->
	<t:div id="shade" forceId="true" styleClass="outer">
		<t:div styleClass="block">
			<t:div styleClass="content_w">
				<!-- ### CONTENT-START ### -->
				<h1><h:outputText value="#{bundle.forgotpw}" /></h1>
				<h:outputText value="#{bundle.reminder1}" styleClass="font1" />
				<h:form id="reminderform">
					<h:panelGrid styleClass="tstd" columnClasses="left" columns="2" style="margin-top: 20px;">
						<h:outputText value="#{bundle.email}" styleClass="font1 bold" />
						<h:panelGroup>
							<t:inputText style="display:block" id="emailinput" value="#{Auth.email}" required="true" />
							<h:message for="emailinput" styleClass="font2 c2" />
						</h:panelGroup>
						<h:outputText value="" />
						<h:commandLink styleClass="btn btn_blue" action="#{Auth.remind}" value="#{bundle.btn_remind}" />
					</h:panelGrid>
				</h:form>
				<!-- ### CONTENT-END ### -->
			</t:div>
		</t:div>
	</t:div>
	<!-- LAYOUT-BLOCK 2-1 END -->
	</body>
	</html>
</f:view>
