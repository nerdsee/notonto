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
		<t:div id="shade" forceId="true" styleClass="outer">
			<t:div styleClass="block" rendered="#{Auth.isLoggedIn && BrainSession.currentUser.isAdmin}">
				<t:div styleClass="content_col">
					<t:div styleClass="content">
						<!-- ### CONTENT-START ### -->
						<t:htmlTag value="h1">
							<h:outputText value="User" />
						</t:htmlTag>
						<h:form>
							<t:dataTable styleClass="tstd" id="userlist" value="#{BrainSystem.userList}" var="user" rows="#{BrainSession.numRows}" rowIndexVar="rowIndex" first="#{BrainSession.pageIndex}" columnClasses="w200 atop font1,w100 atop font1,w200 atop font9,w100 atop" sortable="true"
								sortColumn="#{BrainSession.sortColumn}">
								<h:column>
									<f:facet name="header">
										<t:commandSortHeader columnName="sort_name">
											<h:outputText value="Benutzername" />
										</t:commandSortHeader>
									</f:facet>
									<h:outputText value="#{user.name}" />
								</h:column>
								<h:column>
									<f:facet name="header">
										<t:commandSortHeader columnName="sort_score">
											<h:outputText value="Score" />
										</t:commandSortHeader>
									</f:facet>
									<h:outputText value="#{user.score}" />
								</h:column>
								<h:column>
									<f:facet name="header">
										<h:outputText value="login/reg" />
									</f:facet>
									<h:outputText value="#{user.lastLoginDate}">
										<f:convertDateTime dateStyle="short" timeStyle="medium" type="both" />
									</h:outputText>
								</h:column>
								<h:column>
									<f:facet name="header">
										<h:outputText value="" />
									</f:facet>
									<h:panelGroup>
									</h:panelGroup>
								</h:column>
							</t:dataTable>
							<t:dataScroller for="userlist" fastStep="10" pageCountVar="pageCount" pageIndexVar="pageIndex" styleClass="scroller" paginator="true" paginatorMaxPages="9" paginatorTableClass="paginator" firstRowIndexVar="friv" paginatorActiveColumnStyle="font-weight:bold;" immediate="true">
								<f:facet name="first">
									<t:graphicImage url="/images/arrow-first.gif" border="1" />
								</f:facet>
								<f:facet name="previous">
									<t:graphicImage url="/images/arrow-previous.gif" border="1" />
								</f:facet>
								<f:facet name="next">
									<t:graphicImage url="/images/arrow-next.gif" border="1" />
								</f:facet>
								<f:facet name="last">
									<t:graphicImage url="/images/arrow-last.gif" border="1" />
								</f:facet>
							</t:dataScroller>
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
		</t:div>
	</trh:body>
	</html>
</f:view>
