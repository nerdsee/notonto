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
	<t:div styleClass="outer grey">
		<t:div styleClass="block">
			<t:div styleClass="content_col">
				<t:div styleClass="content">
					<t:div styleClass="content_pad">
						<!-- ### CONTENT-START ### -->
						<t:htmlTag value="h1">
							<h:outputText value="iGoogle Gadget" styleClass="flowtext1" />
						</t:htmlTag>
						<h:panelGrid columns="1" columnClasses="w100p" styleClass="pad">
							<h:panelGroup styleClass="font1">
								<f:verbatim>
						Wenn Sie zwischendurch ein paar Lektionen lernen möchten und sich eine eigene Startseite bei iGoogle
						angelegt haben, ist das iGoogle Gadget genau das richtige.
						</f:verbatim>
							</h:panelGroup>
						</h:panelGrid>
						<h:panelGrid columns="1" columnClasses="w100p ta_center" styleClass="pad">
							<h:graphicImage value="/images/ig/igoogle2.png" style="border: 0px;" />
						</h:panelGrid>
						<!-- ### CONTENT-END ### -->
					</t:div>
				</t:div>
			</t:div>
			<t:div styleClass="sidebar_col">
				<t:div styleClass="sidebar">
					<t:div styleClass="content_pad">
						<!-- ### SIDEBAR-START ### -->
						<t:htmlTag value="h1">
							<h:outputText value="Installation" />
						</t:htmlTag>
						<h:panelGroup styleClass="font1">
							<h:outputText value="Bitte klicken Sie hier, um das Plugin zu installieren." />
						</h:panelGroup>
						<h:panelGrid styleClass="w200 ta_center" columns="1">
							<f:verbatim>
								<a href="http://www.google.com/ig/adde?moduleurl=http://www.notonto.de/ig/notonto.xml"><img src="http://buttons.googlesyndication.com/fusion/add.gif" style="width: 104px; height: 17px; border: 0px;" alt="Add to Google" /></a>
							</f:verbatim>
						</h:panelGrid>
						<!-- ### SIDEBAR-END ### -->
					</t:div>
				</t:div>
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
