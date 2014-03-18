<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>

	
	<t:div styleClass="content_err" rendered="#{BrainMessage.errorText != null}">
			<!-- ### CONTENT-START ### -->
				<h:outputText value="#{BrainMessage.errorText}" styleClass="font2"></h:outputText>
			<!-- ### CONTENT-END ### -->
	</t:div>
	
