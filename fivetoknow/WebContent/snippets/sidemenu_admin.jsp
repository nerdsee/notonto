<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<f:loadBundle basename="org.stoevesand.brain.i18n.MessagesBundle" var="bundle" />
<t:div styleClass="sidebar">
	<!-- ### SIDEBAR-START ### -->
	<t:htmlTag value="h1">
		<h:outputText value="Admin" />
	</t:htmlTag>
	<h:form styleClass="naked" id="side_form1">
		<t:panelNavigation2 styleClass="nav2" layout="list" itemClass="mypage" activeItemClass="selected" openItemClass="selected">
			<t:commandNavigation2 value="lib" externalLink="/admin/user.jsf">
				<t:outputText value="User" />
			</t:commandNavigation2>
		</t:panelNavigation2>
	</h:form>
	<!-- ### SIDEBAR-END ### -->
</t:div>
