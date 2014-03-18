<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@ taglib uri="http://myfaces.apache.org/trinidad" prefix="tr"%>
<%
	String now = "" + System.currentTimeMillis();
%>
<f:view locale="#{BrainSession.currentLocale}">
	<html>
	<head>
	<title>Notonto - Edit Item</title>
	<f:subview id="s_inc_head">
		<jsp:include page="/snippets/inc_head.jsp" />
	</f:subview>
	<script type="text/javascript">
	function calc_code() {
		var prefix="";
		if ($("#presel").length>0)
			prefix=$("#presel option:selected").text();
		else
			prefix=$("#preselstat").text();
		var code=$("#itcode").val();
		$("#gencode").html("= "+prefix+code);
	}
</script>
	</head>
	<body onload="calc_code()">
	<f:loadBundle basename="org.stoevesand.brain.i18n.MessagesBundle" var="bundle" />
	<f:subview id="s_headline">
		<jsp:include page="/snippets/headline.jsp" />
	</f:subview>
	<!-- LAYOUT-BLOCK 2-1 START -->
	<t:div id="shade" forceId="true" styleClass="outer">
		<t:div styleClass="block">
			<t:div styleClass="content_col">
				<t:div styleClass="content">
					<!-- ### CONTENT-START ### -->
					<h1><h:outputText value="#{bundle.newlesson}" /></h1>
					<h:form enctype="UTF-8" acceptcharset="UTF-8" id="newlform">
						<h:panelGrid columns="2" styleClass="tstd">
							<h:outputText value="Title" styleClass="font1 bold" />
							<h:panelGroup>
								<h:inputText id="ittitle" value="#{BrainSession.currentLesson.description}" size="40" required="true" requiredMessage="Please enter a title." />
								<h:outputText value=" " styleClass="font1" />
								<h:message for="ittitle" styleClass="errortext" />
							</h:panelGroup>
							<h:outputText value="" />
							<h:panelGroup>
								<h:commandLink styleClass="btn btn_blue" value=">OK" action="#{BrainSession.currentLesson.createAction}" />
								<h:outputLink styleClass="btn btn_red" value="/teacher/index.jsf" ><h:outputText value=">Cancel"/></h:outputLink>
							</h:panelGroup>
						</h:panelGrid>
					</h:form>
					<!-- ### CONTENT-END ### -->
				</t:div>
			</t:div>
			<t:div styleClass="sidebar_col">
			</t:div>
		</t:div>
	</t:div>
	<!-- LAYOUT-BLOCK 2-1 END -->
	</body>
	</html>
</f:view>