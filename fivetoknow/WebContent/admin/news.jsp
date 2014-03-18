<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@ taglib uri="http://myfaces.apache.org/trinidad" prefix="tr"%>
<%@ taglib uri="http://myfaces.apache.org/trinidad/html" prefix="trh"%>
<f:view locale="#{BrainSession.currentLocale}">
	<f:loadBundle basename="org.stoevesand.brain.i18n.MessagesBundle" var="bundle" />
	<html>
	<head>
	<title>Notonto - Administration</title>
	<t:stylesheet path="/css/style2.css"></t:stylesheet>
	</head>
	<trh:body id="body" initialFocusId="ff1:it1">
		<f:subview id="s_headline">
			<jsp:include page="/snippets/headline.jsp" />
		</f:subview>
		<!-- LAYOUT-BLOCK 2-1 START -->
		<t:div styleClass="block" rendered="#{Auth.isLoggedIn && BrainSession.currentUser.isAdmin}">
			<t:div styleClass="content_col">
				<t:div styleClass="content">
					<!-- ### CONTENT-START ### -->
					<t:htmlTag value="h1">
						<h:outputText value="News" />
					</t:htmlTag>
					<h:form>
						<t:dataTable id="newslist" value="#{BrainSystem.allNews}" var="news" rowIndexVar="rowIndex" first="#{BrainSession.pageIndex}" columnClasses="w100p atop" sortable="false">
							<h:column>
								<f:facet name="header">
									<t:commandSortHeader columnName="sort_name">
										<h:outputText value="News" />
									</t:commandSortHeader>
								</f:facet>
								<h:outputText value="#{news.title}" />
								<h:commandButton styleClass="button" action="#{BrainSystem.editNews}" value="#{bundle.btn_edit}">
								</h:commandButton>
							</h:column>
							<h:column>
								<f:facet name="header">
									<h:outputText value="Locale" />
								</f:facet>
								<h:outputText value="#{news.locale}" />
							</h:column>
						</t:dataTable>
						<h:commandButton styleClass="button" action="#{BrainSystem.addNews}" value="#{bundle.btn_edit}" />
					</h:form>
					<!-- ### CONTENT-END ### -->
				</t:div>
			</t:div>
			<t:div styleClass="sidebar_col">
				<f:subview id="s_sidem">
					<jsp:include page="/snippets/sidemenu_admin.jsp" />
				</f:subview>
			</t:div>
		</t:div>
		<!-- LAYOUT-BLOCK 2-1 END -->
	</trh:body>
	</html>
</f:view>
