<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<f:loadBundle basename="org.stoevesand.brain.i18n.MessagesBundle" var="bundle" />
<h:panelGrid columns="2" styleClass="font1 w100p">
	<h:graphicImage />
	<h:commandLink styleClass="font1" onclick="overlay(); return false;" value="#{bundle.comment}" />
</h:panelGrid>
