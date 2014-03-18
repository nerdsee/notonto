<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@ taglib uri="http://myfaces.apache.org/trinidad" prefix="tr"%>
<t:div styleClass="outer grey">
	<t:div styleClass="block">
		<t:div styleClass="content_footer">
			<!-- ### CONTENT-START ### -->
			<t:div styleClass="footer_col">
				<t:htmlTag value="h2">
					<t:outputText value="Tools" />
				</t:htmlTag>
				<tr:panelList>
					<h:outputLink value="/firefox.jsf" styleClass="quicklink">
						<h:outputText value="Firefox" />
					</h:outputLink>
					<h:outputLink value="/iphone.jsf" styleClass="quicklink">
						<h:outputText value="iPhone" />
					</h:outputLink>
					<h:outputLink value="/igoogle.jsf" styleClass="quicklink">
						<h:outputText value="iGoogle"/>
					</h:outputLink>
					<h:outputLink value="/android.jsf" styleClass="quicklink">
						<h:outputText value="Android"/>
					</h:outputLink>
				</tr:panelList>
			</t:div>
			<t:div styleClass="footer_col">
				<t:htmlTag value="h2">
					<t:outputText value="Info" />
				</t:htmlTag>
				<tr:panelList>
					<h:outputLink value="/disclaimer.jsf" styleClass="quicklink">
						<h:outputText value="#{bundle.disclaimer}" />
					</h:outputLink>
					<h:outputLink value="/impressum.jsf" styleClass="quicklink">
						<h:outputText value="#{bundle.imprint}" />
					</h:outputLink>
					<h:outputLink value="/auth/register.jsf" styleClass="quicklink">
						<h:outputText value="#{bundle.register}" />
					</h:outputLink>
				</tr:panelList>
			</t:div>
			<t:div styleClass="footer_col">
				<t:htmlTag value="h2">
					<t:outputText value="#{bundle.menu_verw}" />
				</t:htmlTag>
				<tr:panelList>
					<h:outputLink value="/lib/topic_5.jsf" styleClass="quicklink">
						<h:outputText value="#{bundle.lang_de}" />
					</h:outputLink>
					<h:outputLink value="/lib/topic_7.jsf" styleClass="quicklink">
						<h:outputText value="#{bundle.lang_en}" />
					</h:outputLink>
					<h:outputLink value="/lib/topic_6.jsf" styleClass="quicklink">
						<h:outputText value="#{bundle.lang_ch}" />
					</h:outputLink>
					<h:outputLink value="/lib/topic_10.jsf" styleClass="quicklink">
						<h:outputText value="#{bundle.lang_es}" />
					</h:outputLink>
					<h:outputLink value="/lib/topic_9.jsf" styleClass="quicklink">
						<h:outputText value="#{bundle.lang_it}" />
					</h:outputLink>
				</tr:panelList>
			</t:div>
			<t:div styleClass="footer_col">
				<t:htmlTag value="h2">
					<t:outputText value="#{bundle.cat}" />
				</t:htmlTag>
				<tr:panelList>
					<h:outputLink value="/library.jsf?cat=HanDeDict" styleClass="quicklink">
						<h:outputText value="HanDeDict" />
					</h:outputLink>
					<h:outputLink value="/library.jsf?cat=HSK" styleClass="quicklink">
						<h:outputText value="HSK" />
					</h:outputLink>
					<h:outputLink value="/library.jsf?cat=NPCR" styleClass="quicklink">
						<h:outputText value="NPCR" />
					</h:outputLink>
				</tr:panelList>
			</t:div>
			<!-- ### CONTENT-END ### -->
		</t:div>
	</t:div>
</t:div>
