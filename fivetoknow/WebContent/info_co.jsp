<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<f:view locale="#{BrainSession.currentLocale}">
	<f:loadBundle basename="org.stoevesand.brain.i18n.MessagesBundle" var="bundle" />
	<html>
	<head>
	<title>Notonto - <h:outputText value="#{bundle.menu_info_ls}" /></title>
	<f:subview id="s_inc_head">
		<jsp:include page="/snippets/inc_head.jsp" />
	</f:subview>
	</head>
	<body onload="document.getElementById('s_login:loginfrm:loginname').focus()">
	<f:subview id="s_headline">
		<jsp:include page="/snippets/headline.jsp" />
	</f:subview>
	<!-- LAYOUT-BLOCK 2-1 START -->
	<t:div id="shade" forceId="true" styleClass="outer">
		<t:div styleClass="block">
			<t:div styleClass="content_col">
				<t:div styleClass="content">
					<!-- ### CONTENT-START ### -->
					<h1><h:outputText value="#{bundle.menu_info_ls}" styleClass="flowtext1" /></h1>
					<t:panelGroup styleClass="font1">
						<f:verbatim>
							<p>Bei einer Internetseite, die Lerninhalte anbietet, ist das oberste Gebot Qualität. Die Funktionalitäten können noch so ausgereift sein, 
							wenn die Inhalte der Lektionen fehlerhaft sind, ist die Lernfreude schnell dahin. 
							<p>Die Lektionen die auf notonto öffentlich zur Verfügung stehen, bauen entweder auf die Inhalte weit verbreiteter Lehrmittel auf oder 
							wurden von Profis zusammengestellt. Die folgenden Liste gibt einen Überblick der Quellen, auf die zur 
							Zusammenstellung der Lerninhalte zurückgegriffen wurde.
						</f:verbatim>
					</t:panelGroup>
					<!-- HanDeDict -->
					<h:panelGrid columns="2" columnClasses="libicon,libcontent w100p" styleClass="tstd boxed">
						<h:panelGroup>
							<h:graphicImage url="/images/lessons/lesson_button_ch.gif" styleClass="icon" width="32" height="32" />
						</h:panelGroup>
						<h:panelGroup styleClass="w100p">
							<h:panelGrid columns="1" columnClasses="w100p naked" styleClass="naked w100p font1">
								<h:outputText value="Freies Chinesisch Deutsches Wörterbuch HanDeDict" styleClass="font9" />
								<f:verbatim>
Teamleiter: Jan Hefti, Dr. Michael Klaus Engel<br />
mit der Unterstützung der Chinesisch-Deutschen Gesellschaft e.V. Hamburg
									</f:verbatim>
								<h:outputLink value="http://chdg.de" target="_NEW" styleClass="font1">
									<h:outputText value="http://chdg.de" />
								</h:outputLink>
							</h:panelGrid>
						</h:panelGroup>
					</h:panelGrid>
					<t:htmlTag value="p" />
					<!-- Capax -->
					<h:panelGrid columns="2" columnClasses="libicon,libcontent w100p" styleClass="tstd boxed">
						<h:panelGroup>
							<h:graphicImage url="/images/lessons/lesson_button_en.gif" styleClass="icon" width="32" height="32" />
						</h:panelGroup>
						<h:panelGroup styleClass="w100p">
							<h:panelGrid columns="1" columnClasses="w100p naked" styleClass="naked w100p font1">
								<h:outputText value="Loxton Professional English" styleClass="font9" />
								<f:verbatim>
The quality business English specialists.									</f:verbatim>
								<h:outputLink value="http://www.loxton-english.de/" target="_NEW" styleClass="font1">
									<h:outputText value="http://www.loxton-english.de/" />
								</h:outputLink>
							</h:panelGrid>
						</h:panelGroup>
					</h:panelGrid>
					<t:htmlTag value="p" />
					<!-- HSK Flashcards -->
					<h:panelGrid columns="2" columnClasses="libicon,libcontent w100p" styleClass="tstd boxed">
						<h:panelGroup>
							<h:graphicImage url="/images/lessons/lesson_button_ch.gif" styleClass="icon" width="32" height="32" />
						</h:panelGroup>
						<h:panelGroup styleClass="w100p">
							<h:panelGrid columns="1" columnClasses="w100p naked" styleClass="naked w100p font1">
								<h:outputText value="HSK Flashcards" styleClass="font9" />
								<f:verbatim>
This page is maintained by Jake Marble and is an excellent source for chinese flashcards. There are sets available for HSK, PCR, NPCR and many more ...
</f:verbatim>
								<h:outputLink value="http://www.hskflashcards.com" target="_NEW" styleClass="font1">
									<h:outputText value="http://www.hskflashcards.com" />
								</h:outputLink>
							</h:panelGrid>
						</h:panelGroup>
					</h:panelGrid>
					<!-- ### CONTENT-END ### -->
				</t:div>
			</t:div>
			<t:div styleClass="sidebar_col">
				<f:subview id="s_sidem">
					<jsp:include page="/snippets/sidemenu_index.jsp" />
				</f:subview>
			</t:div>
		</t:div>
	</t:div>
	<!-- LAYOUT-BLOCK 2-1 END -->
	<f:subview id="s_footer">
		<jsp:include page="/snippets/footer.jsp" />
	</f:subview>
	</body>
	</html>
</f:view>
