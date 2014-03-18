<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<f:loadBundle basename="org.stoevesand.brain.i18n.MessagesBundle" var="bundle" />
<t:div styleClass="outer bc3">
	<t:div styleClass="block ta_right">
		<h:form styleClass="" id="head_form1">
			<h:panelGrid columns="2" columnClasses="ta_left, ta_right" styleClass="w100p">
				<t:htmlTag value="ul" styleClass="minimenu">
					<t:htmlTag value="li">
						<h:commandButton action="#{BrainSession.localeDE}" styleClass="flag" image="/images/de.gif" />
					</t:htmlTag>
					<t:htmlTag value="li">
						<h:commandButton action="#{BrainSession.localeEN}" styleClass="flag" image="/images/en.gif" />
					</t:htmlTag>
					<t:htmlTag value="li">
						<h:outputLink value="/impressum.jsf" styleClass="link">
							<h:outputText value="#{bundle.imprint}" />
						</h:outputLink>
					</t:htmlTag>
					<t:htmlTag value="li">
						<h:outputLink value="/disclaimer.jsf" styleClass="link">
							<h:outputText value="#{bundle.disclaimer}" />
						</h:outputLink>
					</t:htmlTag>
				</t:htmlTag>
				<h:panelGroup rendered="#{Auth.isLoggedIn}">
					<h:outputText value="#{BrainSession.currentUser.name}" styleClass="headtext font3 cf" />
					<h:commandLink value="#{bundle.menu_account}" action="#{Auth.prepareOptions}" styleClass="headtext font3 c4 bold" />
					<h:outputLink value="/kontakt.jsf" styleClass="headtext font3 c4 bold">
						<h:outputText value="#{bundle.contact}" />
					</h:outputLink>
					<h:commandLink value="#{bundle.menu_logout}" action="#{Auth.logout}" styleClass="headtext font3 c4 bold" />
				</h:panelGroup>
				<h:panelGroup rendered="#{!Auth.isLoggedIn}">
					<h:commandLink value="#{bundle.forgotpw}" action="forgotpw" styleClass="headtext font3 c1 bold" />
					<h:outputLink value="/auth/register.jsf" styleClass="headtext font3 c1 bold">
						<h:outputText value="#{bundle.registerlink}" />
					</h:outputLink>
				</h:panelGroup>
			</h:panelGrid>
		</h:form>
	</t:div>
</t:div>

<h:form styleClass="naked" id="head_form2">
	<t:div styleClass="outer bc3">
		<t:div styleClass="block" id="menutop" forceId="true">
			<t:panelNavigation2 styleClass="nav1" layout="list" itemClass="mypage" activeItemClass="selected" openItemClass="selected">
				<t:commandNavigation2 value="index" externalLink="/" activeOnViewIds="/index.jsp">
					<t:outputText value="#{bundle.menu_home}" />
				</t:commandNavigation2>
				<t:commandNavigation2 value="lib" externalLink="/library.jsf" activeOnViewIds="/library.jsp">
					<t:outputText value="#{bundle.menu_library}" />
				</t:commandNavigation2>
				<t:commandNavigation2 value="lessons" externalLink="" externalLink="/user.jsf" activeOnViewIds="/user.jsp" rendered="#{Auth.isLoggedIn}">
					<t:outputText value="#{bundle.menu_learn}" />
				</t:commandNavigation2>
				<t:commandNavigation2 value="#{bundle.menu_teacher}" externalLink="/teacher/index.jsf" rendered="#{Auth.isLoggedIn}" activeOnViewIds="/teacher/index.jsp">
					<t:outputText value="#{bundle.menu_teacher}" />
				</t:commandNavigation2>
				<t:commandNavigation2 value="#{bundle.menu_admin}" externalLink="/admin/user.jsf" activeOnViewIds="/admin/user.jsp" rendered="#{Auth.isLoggedIn && BrainSession.currentUser.isAdmin}">
					<t:outputText value="#{bundle.menu_admin}" />
				</t:commandNavigation2>
			</t:panelNavigation2>
			<f:subview id="s_login_top">
				<jsp:include page="/snippets/login_top.jsp" />
			</f:subview>
		</t:div>
	</t:div>
</h:form>
