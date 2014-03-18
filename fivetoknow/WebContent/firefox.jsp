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
			<t:div styleClass="content_col">
				<t:div styleClass="content">
					<t:div styleClass="content_pad">
						<!-- ### CONTENT-START ### -->
						<t:htmlTag value="h1">
							<h:outputText value="Firefox Plugin" styleClass="flowtext1" />
						</t:htmlTag>
						<t:htmlTag value="h2">
							<h:outputText value="#{bundle.welcome2}" styleClass="flowtext2" />
						</t:htmlTag>
						<h:panelGrid columns="2" columnClasses="w100p, " styleClass="pad">
							<h:panelGroup styleClass="font1">
								<f:verbatim>
						Nachdem Sie das Plugin installiert haben, erscheint unten rechts im Firefox das Notonto-Plugin
						</f:verbatim>
							</h:panelGroup>
							<h:graphicImage value="/images/special/bild1.jpg" style="border: 1px solid black;" />
						</h:panelGrid>
						<h:panelGrid columns="2" columnClasses="w100p, " styleClass="pad">
							<h:panelGroup styleClass="font1">
								<f:verbatim>
						Klicken Sie mit der rechten Maus auf das Feld. Und wählen sie die "Options".
						Hier stellen Sie bitte Ihren Benutzername (email-Adresse) und Passwort für Ihr Notonto-Konto ein.
						Danach erscheinen in dem Menü die von Ihnen abonnierten Lektionen. Wählen Sie die Lektion aus, 
						die sie lernen möchten. 
						</f:verbatim>
							</h:panelGroup>
							<h:graphicImage value="/images/special/bild2.jpg" style="border: 1px solid black;" />
						</h:panelGrid>
						<h:panelGroup styleClass="font1 w100p pad">
							<f:verbatim>
						Um die Lektion zu lernen klicken Sie jetzt einfach mit der linken Maustaste auf das Notonto-Plugin.
						Es öffnet sich der Lernbereich am unteren Fensterrand. Hier erscheint die erste Frage aus der von 
						Ihnen gewählten Lektion. Überlegen Sie jetzt, ob sie die Antwort wissen und klicken dann mit der Maus
						irgendwo in den Fragebereich. Es erscheint dann die Antwort und sie können angeben, ob Sie die Frage 
						gewusst haben oder nicht. Daraufhin erscheint die nächste Frage.
						Wenn Sie sich zu einer Antwort noch einmal die Frage ansehen möchten, können Sie durch einen Mausklick
						im Lernbereich beliebig oft zwischen Frage und Antwort hin- und herschalten. 
						</f:verbatim>
						</h:panelGroup>
						<h:panelGrid columns="2" columnClasses="w100p, " styleClass="pad">
							<h:panelGroup styleClass="font1">
							</h:panelGroup>
							<h:graphicImage value="/images/special/frage1.jpg" style="border: 1px solid black;" />
						</h:panelGrid>
						<h:panelGrid columns="2" columnClasses=",w100p" styleClass="pad">
							<h:graphicImage value="/images/special/antwort1.jpg" style="border: 1px solid black;" />
							<h:panelGroup styleClass="font1">
							</h:panelGroup>
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
							<h:outputLink value="https://www.notonto.de/notonto.cur.xpi" styleClass="link">
								<h:graphicImage value="/images/special/addtofirefox.png" />
							</h:outputLink>
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
