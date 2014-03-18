<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<h:panelGrid styleClass="loginbox backc1 borderc2" columnClasses="left" columns="1">
	<h:outputText value="#{bundle.registertext}" styleClass="font1" />
	<h:outputLink value="/auth/register.jsf">
		<h:outputText value="#{bundle.registerlink}" styleClass="font1" />
	</h:outputLink>
</h:panelGrid>
