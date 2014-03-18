<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<t:div styleClass="sidebar">
	<!-- ### CONTENT-START ### -->
	<h:panelGrid columns="2" columnClasses="w100p">
		<h:panelGroup>
			<h:panelGroup>
				<t:htmlTag value="h1">
					<h:outputText value="Firefox-Plugin" />
				</t:htmlTag>
			</h:panelGroup>
			<h:panelGroup styleClass="font1">
				<h:graphicImage style="vertical-align:top; float: left" value="/images/special/firefox-logo_mini.png" />
				<h:outputText escape="false" styleClass="font1" value="#{bundle.firefox_plug}" />
			</h:panelGroup>
		</h:panelGroup>
	</h:panelGrid>
	<!-- ### CONTENT-END ### -->
</t:div>
