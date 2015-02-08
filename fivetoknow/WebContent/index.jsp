<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://primefaces.org/ui" prefix="p"%>

<f:view locale="#{BrainSession.currentLocale}">
	<f:loadBundle basename="org.stoevesand.brain.i18n.MessagesBundle" var="bundle" />
	<html>
	<head>
	<title>Notonto - Vokabeln lernen und behalten</title>
	<meta name="keywords" content="Vokabeltrainer,Vokabel,Vokabeln,Karteikasten,kostenlos,gratis,online,Englisch,Deutsch,Chinesisch,Italienisch,Allgemeinbildung,Vokabelprogramm,Bildung,Lernen,Lernprogramm,iPhone,iPod,iGoogle,iPad,Android" />
	<meta name="description" content="Hier können Sie kostenlos Vokabeln lernen. Vorhandene Lektionen lernen oder eigene Lektionen erstellen." />
	<f:subview id="s_inc_head">
		<jsp:include page="/snippets/inc_head.jsp" />
	</f:subview>
	</head>
	<body onload="document.getElementById('loginname').focus()">
	<f:subview id="s_headline">
		<jsp:include page="/snippets/headline.jsp" />
	</f:subview>
	<t:div id="shade" forceId="true" styleClass="outer">
		<!-- LAYOUT-BLOCK 2-1 START -->
		<t:div styleClass="block">
			<t:div styleClass="content_col">
				<t:div styleClass="content">
					<!-- ### CONTENT-START ### -->
					<t:htmlTag value="h1">
						<h:outputText value="#{bundle.welcome1}" />
					</t:htmlTag>
					<t:div styleClass="font1">
						<h:outputText value="#{bundle.welcome2}" />
					</t:div>
					<t:panelGroup styleClass="font1">
						<h:outputText value="#{bundle.intro1}" escape="false" />
						<t:htmlTag value="p"></t:htmlTag>
						<h:outputText value="#{bundle.intro2}" escape="false" />
					</t:panelGroup>
					<!-- ### CONTENT-END ### -->
				</t:div>
				<f:subview id="s_news" rendered="#{true}">
					<jsp:include page="/snippets/newslong.jsp" />
				</f:subview>
			</t:div>
			<t:div styleClass="sidebar_col">
				<f:subview id="s_sidem">
					<jsp:include page="/snippets/sidemenu_index.jsp" />
				</f:subview>
				<f:subview id="s_top5">
					<jsp:include page="/snippets/top5.jsp" />
				</f:subview>
				<f:subview id="s_ff_sm">
					<jsp:include page="/snippets/tools.jsp" />
				</f:subview>
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
