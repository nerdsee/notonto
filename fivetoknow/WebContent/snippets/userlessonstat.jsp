<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<f:loadBundle basename="org.stoevesand.brain.i18n.MessagesBundle" var="bundle" />
<h:panelGrid columns="2" styleClass="font1 w100p">
	<h:outputText value="#{bundle.learnable}" />
	<h:outputText value="#{BrainSession.currentUserLesson.available}" />
	<h:outputText value="" />
	<h:outputText value="" />
	<h:outputText value="#{bundle.new}" />
	<h:outputText value="#{BrainSession.currentUserLesson.level0}" />
	<h:outputText value="Level 1" />
	<h:outputText value="#{BrainSession.currentUserLesson.level1}" />
	<h:outputText value="Level 2" />
	<h:outputText value="#{BrainSession.currentUserLesson.level2}" />
	<h:outputText value="Level 3" />
	<h:outputText value="#{BrainSession.currentUserLesson.level3}" />
	<h:outputText value="Level 4" />
	<h:outputText value="#{BrainSession.currentUserLesson.level4}" />
	<h:outputText value="Level 5" />
	<h:outputText value="#{BrainSession.currentUserLesson.level5}" />
</h:panelGrid>
