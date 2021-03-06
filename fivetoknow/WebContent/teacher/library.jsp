<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@ taglib uri="http://myfaces.apache.org/trinidad" prefix="tr"%>
<%@ taglib uri="http://myfaces.apache.org/trinidad/html" prefix="trh"%>
<%
	String cat = request.getParameter("cat");
	if (cat == null)
		cat = "";
%>
<f:view locale="#{BrainSession.currentLocale}">
	<f:loadBundle basename="org.stoevesand.brain.i18n.MessagesBundle" var="bundle" />
	<html>
	<head>
	<title>Notonto - <h:outputText value="#{bundle.menu_verw}" /> - <h:outputText value="#{BrainSession.currentTopicDirect.text}" /><h:outputText value="#{bundle.cat}: #{BrainSession.filterCat}" rendered="#{empty BrainSession.currentTopic}" /></title>
	<f:subview id="s_inc_head">
		<jsp:include page="/snippets/inc_head.jsp" />
	</f:subview>
	</head>
	<body id="body">
	<f:subview id="s_headline">
		<jsp:include page="/snippets/headline.jsp" />
	</f:subview>
	<f:subview id="s_lib">
		<jsp:include page="/snippets/lib_inc.jsp" />
	</f:subview>
	<f:subview id="s_footer">
		<jsp:include page="/snippets/footer.jsp" />
	</f:subview>
	</body>
	</html>
</f:view>