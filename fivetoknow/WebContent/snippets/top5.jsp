<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<t:div styleClass="sidebar">
	<!-- ### CONTENT-START ### -->
	<h:panelGroup>
		<t:htmlTag value="h1">
			<h:outputText value="notonto" styleClass="c4" />
			<h:outputText value="Top10" styleClass="c3" />
		</t:htmlTag>
	</h:panelGroup>
	<h:panelGrid columns="2" columnClasses="w100p">
		<h:panelGroup>
			<h:panelGroup styleClass="font1">
				<t:dataTable var="user" value="#{BrainSystem.top5}" styleClass="naked" columnClasses="ta_right font1, font1">
					<t:column>
						<h:outputText value="#{user.score}" styleClass="font1" />
					</t:column>
					<t:column>
						<h:outputText value="&nbsp;" escape="false" styleClass="font1" />
						<h:outputText value="#{user.nick}" styleClass="font1 bold c3" />
					</t:column>
				</t:dataTable>
			</h:panelGroup>
			<t:div styleClass="w100p ta_right">
				<h:outputText value="Stand" styleClass="font3" />
				<h:outputText value="&nbsp;" escape="false" styleClass="font3" />
				<h:outputText value="#{BrainSystem.lastTop5}" styleClass="font3">
					<f:convertDateTime pattern="HH:mm" />
				</h:outputText>
				<h:outputText value="&nbsp;" escape="false" styleClass="font3" />
				<h:outputText value="Uhr" styleClass="font3" />
			</t:div>
		</h:panelGroup>
	</h:panelGrid>
	<!-- ### CONTENT-END ### -->
</t:div>
