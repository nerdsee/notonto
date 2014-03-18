<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<t:div styleClass="content">
	<!-- ### CONTENT-START ### -->
	<t:htmlTag value="h1">
		<h:outputText value="notonto" styleClass="c4" />
		<h:outputText value="Blog" styleClass="c3" />
	</t:htmlTag>
	<h:dataTable styleClass="news" value="#{BrainSystem.news}" columnClasses="left atop w100,atop w400" var="news" rows="6">
		<h:column>
			<h:outputText value="#{news.date}" styleClass="font1 bold">
				<f:convertDateTime type="date" dateStyle="short" />
			</h:outputText>
			<h:outputText value="<br>" escape="false" />
			<h:outputLink value="http://blog.notonto.de/?tag=#{news.slug}" target="_BLOG" styleClass="font1 bold">
				<h:outputText value="#{news.typetext}" styleClass="c3" />
			</h:outputLink>
		</h:column>
		<h:column>
			<h:outputLink value="http://blog.notonto.de/?p=#{news.id}" target="_BLOG" styleClass="font1 bold">
				<h:outputText value="#{news.title}" styleClass="c3" />
			</h:outputLink>
			<h:outputText value="<br>#{news.text}<p>" escape="false" styleClass="font1" style="margin-bottom: 5px;" />
		</h:column>
	</h:dataTable>
	<!-- ### CONTENT-END ### -->
</t:div>
