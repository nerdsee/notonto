<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<f:loadBundle basename="org.stoevesand.brain.i18n.MessagesBundle" var="bundle" />
<t:div styleClass="sidebar">
	<!-- ### SIDEBAR-START ### -->
	<t:htmlTag value="h1">
		<h:outputText value="Aktionen" />
	</t:htmlTag>
	<h:form styleClass="naked" id="side_form1">
		<h:commandLink action="#{BrainSession.newLesson}" styleClass="btn btn_blue">
			<h:outputText value="#{bundle.btn_newlesson}" />
		</h:commandLink>
	</h:form>
	<!-- ### SIDEBAR-END ### -->
</t:div>
