<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<h:form id="langfrm">
	<h:panelGroup styleClass="langbox">
		<h:commandButton action="#{BrainSystem.localeDE}" styleClass="flag" image="/images/de.gif"></h:commandButton>
		<h:commandButton action="#{BrainSystem.localeEN}" styleClass="flag" image="/images/en.gif"></h:commandButton>
		<h:commandButton action="#{BrainSystem.localeES}" styleClass="flag" image="/images/es.gif"></h:commandButton>
	</h:panelGroup>
</h:form>
