<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<f:view locale="#{BrainSession.currentLocale}">
	<html>
	<head>
	<title>Notonto - Impressum</title>
	<f:subview id="s_inc_head">
		<jsp:include page="/snippets/inc_head.jsp" />
	</f:subview>
	</head>
	<body>
	<f:loadBundle basename="org.stoevesand.brain.i18n.MessagesBundle" var="bundle" />
	<f:subview id="s_headline">
		<jsp:include page="/snippets/headline.jsp" />
	</f:subview>
	<t:div id="shade" forceId="true" styleClass="outer">
		<t:div styleClass="block">
			<t:div styleClass="content_w">
				<!-- ### CONTENT-START ### -->
				<t:htmlTag value="h1">
					<h:outputText value="#{bundle.imprint}" />
				</t:htmlTag>
				<f:verbatim>
					<h3>Diese Webseite ist ein rein privates Projekt von:<br>
					Jan Stövesand<br>
					Kegelhofstr. 9<br>
					20251 Hamburg<br>
					<br>
					email: info[at]notonto.de<br>
					<br>
					Inhaltlich Verantwortlicher gemäß § 10 Absatz 3 MDStV<br>
					<br>
					Jan Stövesand (Anschrift wie oben)<br>
					</h3>
				</f:verbatim>
				<!-- ### CONTENT-END ### -->
			</t:div>
		</t:div>
		<!-- LAYOUT-BLOCK 2-1 END -->
	</t:div>
	<f:subview id="s_footer">
		<jsp:include page="/snippets/footer.jsp" />
	</f:subview>
	</body>
	</html>
</f:view>
