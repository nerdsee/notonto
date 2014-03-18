<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<f:view locale="#{BrainSession.currentLocale}">
	<html>
	<head>
	<title>Notonto - Nutzungsbedingungen</title>
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
		<!-- LAYOUT-BLOCK 2-1 START -->
		<t:div styleClass="block">
			<t:div styleClass="content_w">
				<!-- ### CONTENT-START ### -->
				<h1><h:outputText value="#{bundle.disclaimer}" /></h1>
				<h2>Nutzungsbedingungen</h2>
				<h3><h:outputText value="#{bundle.nutzung1} #{bundle.nutzung2} #{bundle.nutzung3}" /></h3>
				<f:verbatim>
					<h2>Haftung für Inhalte</h2>
					<h3>Die Inhalte meiner Seiten wurden mit größter Sorgfalt erstellt. Für die Richtigkeit, Vollständigkeit und Aktualität der Inhalte kann ich jedoch keine Gewähr übernehmen. Als Diensteanbieter bin ich gemäß § 6 Abs.1 MDStV und § 8 Abs.1 TDG für eigene Inhalte auf diesen Seiten nach den
					allgemeinen Gesetzen verantwortlich. Diensteanbieter sind jedoch nicht verpflichtet, die von ihnen übermittelten oder gespeicherten fremden Informationen zu überwachen oder nach Umständen zu forschen, die auf eine rechtswidrige Tätigkeit hinweisen. Verpflichtungen zur Entfernung oder Sperrung
					der Nutzung von Informationen nach den allgemeinen Gesetzen bleiben hiervon unberührt. Eine diesbezügliche Haftung ist jedoch erst ab dem Zeitpunkt der Kenntnis einer konkreten Rechtsverletzung möglich. Bei bekannt werden von entsprechenden Rechtsverletzungen werde ich diese Inhalte umgehend
					entfernen.</h3>
					<h2>Haftung für Links</h2>
					<h3>Mein Angebot enthält Links zu externen Webseiten Dritter, auf deren Inhalte ich keinen Einfluss habe. Deshalb kann ich für diese fremden Inhalte auch keine Gewähr übernehmen. Für die Inhalte der verlinkten Seiten ist stets der jeweilige Anbieter oder Betreiber der Seiten
					verantwortlich. Die verlinkten Seiten wurden zum Zeitpunkt der Verlinkung auf mögliche Rechtsverstöße überprüft. Rechtswidrige Inhalte waren zum Zeitpunkt der Verlinkung nicht erkennbar. Eine permanente inhaltliche Kontrolle der verlinkten Seiten ist jedoch ohne konkrete Anhaltspunkte einer
					Rechtsverletzung nicht zumutbar. Bei bekannt werden von Rechtsverletzungen werde ich derartige Links umgehend entfernen.</h3>
					<h2>Urheberrecht</h2>
					<h3>Der Betreiber der Seiten ist bemüht, stets die Urheberrechte anderer zu beachten bzw. auf selbst erstellte sowie lizenzfreie Werke zurückzugreifen. Die durch den Seitenbetreiber erstellten Inhalte und Werke (Texte, Bilder) auf diesen Seiten unterliegen dem deutschen Urheberrecht.
					Beiträge Dritter (Downloads) sind als solche gekennzeichnet.</h3>
					<h2>Datenschutz</h2>
					<h3>Soweit auf unseren Seiten personenbezogene Daten (beispielsweise Name, Anschrift oder eMail-Adressen) erhoben werden, erfolgt dies soweit möglich stets auf freiwilliger Basis. Die Nutzung der Angebote und Dienste ist, soweit möglich, stets ohne Angabe personenbezogener Daten möglich.
					Um den vollen Umfang dieses Dienstes zu nutzen, ist eine kostenlose Registrierung notwendig. Die persönlichen Daten, die der Benutzer im Profil hinterlegt, sind nur dann öffentlich, wenn dies bei den entsprechenden Eingabefeldern so beschrieben steht. Alle Angaben sind freiwillig, eine korrekte
					E-Mail Adresse ist jedoch für die Nutzung Voraussetzung. Falls ein Benutzer über diese E-Mail Adresse nicht erreicht werden kann, wird der Zugang gesperrt. Personenbezogene Daten werden nicht an Dritte weitergegeben. Der Nutzung von im Rahmen der Impressumspflicht veröffentlichten Kontaktdaten
					durch Dritte zur Übersendung von nicht angeforderter Werbung und Informationsmaterialien wird hiermit ausdrücklich widersprochen. Der Betreiber der Seiten behält sich ausdrücklich rechtliche Schritte im Falle der unverlangten Zusendung von Werbeinformationen, etwa durch Spam-Mails, vor.</h3>
					<h3>Quelle: eRecht24.de - <a href="http://www.e-recht24.de">Rechtsberatung von Anwalt</a> Sören Siebert</h3>
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
