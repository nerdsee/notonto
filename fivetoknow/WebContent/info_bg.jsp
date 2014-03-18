<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<f:view locale="#{BrainSession.currentLocale}">
	<f:loadBundle basename="org.stoevesand.brain.i18n.MessagesBundle" var="bundle" />
	<html>
	<head>
	<title>Notonto - <h:outputText value="#{bundle.menu_info_bg}" /></title>
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
					<h1><h:outputText value="#{bundle.menu_info_bg}" styleClass="flowtext1" /></h1>
					<t:panelGroup styleClass="font1">
						<f:verbatim>
							<p>Eine klassische Methode der Lerntechnik ist die <a class="font1" href="http://de.wikipedia.org/wiki/Lernkartei" target="_new">Lernkartei</a>. Dabei werden Lernkarten in einem Karteikasten mit 5 (oder mehr) Fächern aufbewahrt. Die Lernkarten sind so gestaltet, dass sie auf der einen
							Seite die Frage und auf der anderen die Antwort stehen haben. Zum Lernen von Vokabeln bedeutet dies, dass z.B. auf der einen Seite das deutsche Wort und auf der anderen Seite die Übersetzung in der Sprache steht, die gelernt werden soll.
							<p>Das Lernen mit der Kartei funktioniert jetzt so, dass eine Karte z.B. aus dem Fach 2 genommen wird. Wenn man das Wort auf der Karte richtig übersetzen kann, legt man die Karte danach in Fach 3. Wenn man die Karte nicht weiss, kommt sie zurück in Fach 1. Die Besonderheit ist hier, dass
							eine gewusste Karte immer nur ein Fach weit wandert, hingegen eine Karte die man nicht wusste immer zurück in das erste Fach geht.
							<p>Der Lernerfolg entsteht dadurch, dass man die Lernkarten in den einzelnen Fächer in einer unterschiedlichen Häufigkeit lernt. Lernkarten im ersten Fach lernt man täglich, Lernkarten im 2. Fach wiederholt man nach einer Woche, Lernkarten im 3. Fach nach einem Monat, ... bei den
							Lernkarteien die man kaufen (oder basteln kann) wird diese unterscheidliche Wiederholungszeit erreicht, indem man die einzelnen Fächer unterschiedlich groß gestaltet, z.B. Fach 1 ist 1cm breit, Fach ist 2 cm, Fach 3 4cm usw. Man fängt jetzt erst an die Lernkarten eines Faches zu lernen, wenn
							dieses annähernd voll ist.
							<p>Dieser Mechanismus wurde bei notonto dahingehend perfektioniert, da hier jede einzelne Lernkarte exakt verfolgt wird. Bei jeder Lernkarte wird genau gespeichert, wann diese das letzte mal bearbeitet wurde und wann diese entsprechend des Lernabstandes des Faches wieder gelernt werden
							sollte. Auch die Reihenfolge der Lernkarten innerhalb eines Faches wird durch das System variiert, sodass auch sonst übliche Lernphänomene ("Nach der Lernkarte Hund kommt immer die Lernkarte Telefon ...") ausgeschlossen werden.
							<p>Der gesamte Lernmechanismus der Lernkartei baut darauf auf, dass zwischen der Bearbeitung einer Lernkarte eine gewisse Zeit verstreichen muss, um zu prüfen, ob der Lerninhalt wirklich im Gedächtnis geblieben ist. Nur dadurch wird der Weg in Langzeitgedächtnis geebnet.
							<p>Andere Programmen mit ähnlichem Ziel müssen meist umständlich auf dem Rechner installiert werden, auf dem gelernt werden soll. Ferner müssen hier die Lektionen mühselig selber eingegeben werden. notonto ist vollständig webbasiert. Dass heisst Sie können Ihre Vokabeln jederzeit und
							überall lernen. Internetzugang genügt.
						</f:verbatim>
					</t:panelGroup>
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
