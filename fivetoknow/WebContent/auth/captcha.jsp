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
				<t:htmlTag value="h1">
					<h:outputText value="#{bundle.register}" />
				</t:htmlTag>
				<t:htmlTag value="h2">
					<h:outputText value="#{bundle.captcha_explain}" />
				</t:htmlTag>
				<t:htmlTag value="p" />
				<h:form>
					<h:panelGrid styleClass="tstd" columnClasses="ta_right font1 bold" columns="2" style="margin-top: 20px">
						<h:outputText value="#{bundle.email}" />
						<t:outputText value="#{Auth.email}" />
						<h:outputText value="" />
						<h:graphicImage value="/captcha/captcha.jpg"></h:graphicImage>
						<h:outputText value="#{bundle.captext}" />
						<h:panelGroup>
							<t:inputText style="display:block" id="capinput" value="#{Auth.captext}" required="true" validator="#{Auth.validateCaptcha}" />
							<t:message for="capinput" styleClass="font2 c2"/>
						</h:panelGroup>
						<h:outputText value="" />
						<h:commandButton styleClass="button" action="#{Auth.confirm}" value="#{bundle.btn_confirm}"></h:commandButton>
					</h:panelGrid>
				</h:form>
				<!-- ### CONTENT-END ### -->
			</t:div>
		</t:div>
	</t:div>
	<!-- LAYOUT-BLOCK W END -->
	</body>
	</html>
</f:view>
