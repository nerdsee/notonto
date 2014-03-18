<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<f:view locale="#{BrainSession.currentLocale}">
	<html>
	<head>
	<title>Notonto</title>
	<f:subview id="s_inc_head">
		<jsp:include page="/snippets/inc_head.jsp" />
	</f:subview>
	</head>
	<body>
	<f:loadBundle basename="org.stoevesand.brain.i18n.MessagesBundle" var="bundle" />
	<f:subview id="s_headline">
		<jsp:include page="/snippets/headline.jsp" />
	</f:subview>
	<!-- LAYOUT-BLOCK W START -->
	<t:div styleClass="outer grey">
		<t:div styleClass="block">
			
			<t:div styleClass="content_w">
				<t:div styleClass="content_pad">
					<!-- ### CONTENT-START ### -->
					<h:panelGrid columns="1">
						<h:outputText value="Etwas schlimmes ist passiert." styleClass="flowtext1" />
					</h:panelGrid>
					<!-- ### CONTENT-END ### -->
				</t:div>
			</t:div>
			
		</t:div>
	</t:div>
	<!-- LAYOUT-BLOCK W END -->
	</body>
	</html>
</f:view>