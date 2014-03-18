<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@ taglib uri="http://myfaces.apache.org/trinidad" prefix="tr"%>
<f:view locale="#{BrainSession.currentLocale}">
	<f:loadBundle basename="org.stoevesand.brain.i18n.MessagesBundle" var="bundle" />
	<html>
	<head>
	<title>Notonto</title>
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
			<t:div styleClass="content_w">
				<!-- ### CONTENT-START ### -->
				<t:htmlTag value="h1">
					<h:outputText value="notonto für Android" styleClass="flowtext1" />
				</t:htmlTag>
				<t:div styleClass="ta_center brc4 bf">
					<h:graphicImage value="/images/android/screens/a_menu.jpg" style="border:none;" />
					<h:graphicImage value="/images/android/screens/a_question.jpg" style="border: none;" />
					<h:graphicImage value="/images/android/screens/a_answer.jpg" style="border: none;" />
				</t:div>
				<t:div styleClass="w100p ta_center">
					<h:graphicImage value="/images/android/notonto.android.png" style="padding: 20px 0px 20px 0px" />
				</t:div>
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
