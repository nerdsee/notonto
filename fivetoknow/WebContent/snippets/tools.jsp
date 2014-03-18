<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<t:div styleClass="sidebar">
	<!-- ### CONTENT-START ### -->
	<h:panelGroup>
		<t:htmlTag value="h1">
			<h:outputText value="notonto" styleClass="c4" />
			<h:outputText value="Tools" styleClass="c3" />
		</t:htmlTag>
	</h:panelGroup>
	<h:panelGrid columns="3" styleClass="w100p" columnClasses="w30p,w30p,w30p">
		<t:div styleClass="ta_center" style="padding-bottom: 10px;">
			<h:outputLink value="/firefox.jsf" styleClass="font1 bold">
				<h:graphicImage height="48" width="48" value="/images2/tools-ff.png"></h:graphicImage>
				<h:outputText value="<br>Firefox" escape="false" styleClass="font2 c3" />
			</h:outputLink>
		</t:div>
		<t:div styleClass="ta_center">
			<h:outputLink value="/iphone.jsf" styleClass="font1 bold">
				<h:graphicImage height="48" width="48" value="/images2/tools-iphone.png"></h:graphicImage>
				<h:outputText value="<br>iPhone" escape="false" styleClass="font2 c3"/>
			</h:outputLink>
		</t:div>
		<t:div styleClass="ta_center">
			<h:outputLink value="/igoogle.jsf" styleClass="font1 bold">
				<h:graphicImage height="48" width="48" value="/images2/tools-google.png"></h:graphicImage>
				<h:outputText value="<br>iGoogle" escape="false" styleClass="font2 c3"/>
			</h:outputLink>
		</t:div>
		<t:div styleClass="ta_center">
			<h:outputLink value="/android.jsf" styleClass="font1 bold">
				<h:graphicImage height="48" width="48" value="/images2/tools-android.png"></h:graphicImage>
				<h:outputText value="<br>Android" escape="false" styleClass="font2 c3"/>
			</h:outputLink>
		</t:div>
		<t:div styleClass="ta_center">
			<h:outputLink value="http://wiki.notonto.de" target="_NEW" styleClass="font1 bold">
				<h:graphicImage height="48" width="48" value="/images2/tools-mw.png" style="padding: 0px 10px;"></h:graphicImage>
				<h:outputText value="<br>Wiki" escape="false" styleClass="font2 c3" />
			</h:outputLink>
		</t:div>
		<t:div styleClass="ta_center">
			<h:outputLink value="http://blog.notonto.de" target="_NEW" styleClass="font2 bold">
				<h:graphicImage height="48" width="48" value="/images2/tools-wp.png" style="padding: 0px 10px;"></h:graphicImage>
				<h:outputText value="<br>Blog" escape="false" styleClass="font2 c3" />
			</h:outputLink>
		</t:div>
	</h:panelGrid>
	<!-- ### CONTENT-END ### -->
</t:div>
