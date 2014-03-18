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
	<body onLoad="document.getElementById('loginfrm:loginname').focus()">
	<f:loadBundle basename="org.stoevesand.brain.i18n.MessagesBundle" var="bundle" />
	<f:subview id="s_headline">
		<jsp:include page="/snippets/headline.jsp" />
	</f:subview>
	<!-- LAYOUT-BLOCK 2-1 START -->
	<t:div styleClass="outer grey">
		<t:div styleClass="block">
			<t:div styleClass="content_w">
				<t:div styleClass="content_pad">
					<!-- ### CONTENT-START ### -->
					<h1><h:outputText value="#{bundle.unlock}" /></h1>
					<h3><h:outputText value="#{bundle.unlock_text}" /></h3>
					<!-- ### CONTENT-END ### -->
				</t:div>
			</t:div>
		</t:div>
	</t:div>
	<!-- LAYOUT-BLOCK 2-1 END -->
	</body>
	</html>
</f:view>
