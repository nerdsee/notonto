<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<h:form styleClass="naked">
	<t:panelNavigation2 styleClass="nav1" layout="list" itemClass="mypage" activeItemClass="selected" openItemClass="selected">
		<t:commandNavigation2 value="index" action="index">
			<t:outputText value="Home" />
		</t:commandNavigation2>
		<t:commandNavigation2 value="lessons" action="user" activeOnViewIds="/user.jsp">
			<t:outputText value="#{bundle.menu_lessons}" />
		</t:commandNavigation2>
		<t:commandNavigation2 value="lib" action="lib">
			<t:outputText value="#{bundle.menu_verw}" />
		</t:commandNavigation2>
		<t:commandNavigation2 value="Stat" action="stat">
			<t:outputText value="#{bundle.menu_stat}" />
		</t:commandNavigation2>
		<t:commandNavigation2 value="logout" action="#{Auth.logout}">
			<t:outputText value="#{bundle.menu_logout}" />
		</t:commandNavigation2>
	</t:panelNavigation2>
</h:form>
