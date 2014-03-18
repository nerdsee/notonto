<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<h:panelGrid columns="2" styleClass="font1 w100p">
	<h:outputText value="Score" />
	<h:outputText value="#{BrainSession.currentUser.score}" />
</h:panelGrid>
