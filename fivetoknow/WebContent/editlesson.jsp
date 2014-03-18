<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@ taglib uri="http://myfaces.apache.org/trinidad" prefix="tr"%>
<%@ taglib uri="http://myfaces.apache.org/trinidad/html" prefix="trh"%>
<%
	String now = "" + System.currentTimeMillis();
%>
<f:view locale="#{BrainSession.currentLocale}">
	<html>
	<head>
	<title>Edit Item</title>
	<f:subview id="s_inc_head">
		<jsp:include page="/snippets/inc_head.jsp" />
	</f:subview>
	</head>
	<body>
	<f:loadBundle basename="org.stoevesand.brain.i18n.MessagesBundle" var="bundle" />
	<f:subview id="s_headline">
		<jsp:include page="/snippets/headline.jsp" />
	</f:subview>
	<!-- LAYOUT-BLOCK 2-1 START -->
	<t:div id="shade" forceId="true" styleClass="outer">
		<t:div styleClass="block">
			<t:div styleClass="content_col">
				<t:div styleClass="content">
					<t:div styleClass="content_pad">
						<h:form>
							<!-- ### CONTENT-START ### -->
							<t:htmlTag value="h1">
								<h:outputText value="#{bundle.editlesson}" />
							</t:htmlTag>
							<h:panelGrid columns="2" styleClass="naked w100p" columnClasses=",ta_right">
							<t:htmlTag value="h2">
								<h:outputText value="#{BrainSession.currentLesson.description}" />
							</t:htmlTag>
							<h:commandLink styleClass="nlink" action="editlessonmeta">
								<h:outputText escape="false" value=">&nbsp;#{bundle.btn_editmeta}" styleClass="font9g c4" />
							</h:commandLink>
							</h:panelGrid>
						</h:form>
						<h:form>
							<h:inputText value="#{BrainSession.filterText}" size="40" />
							<h:commandButton styleClass="font5 naked c3" action="#{BrainSystem.doNothing}" value=">search" />
							<t:dataTable id="itemlist" value="#{BrainSession.itemList}" var="item" rows="#{BrainSession.numRows}" rowIndexVar="rowIndex" first="#{BrainSession.pageIndex}" columnClasses="w200 atop font1,w200 atop font1,w100 atop,w100 atop">
								<h:column>
									<f:facet name="header">
										<h:outputText value="" />
									</f:facet>
									<h:outputText value="#{item.text}" />
								</h:column>
								<h:column>
									<f:facet name="answer">
										<h:outputText value="" />
									</f:facet>
									<t:dataList var="answer" value="#{item.answers}" layout="unorderedList">
										<h:outputText value="#{answer.text}" />
									</t:dataList>
								</h:column>
								<h:column>
									<f:facet name="btn1">
										<h:outputText value="" />
									</f:facet>
									<h:commandButton styleClass="button" action="#{BrainSystem.editItem}" value="#{bundle.btn_edit}">
										<t:updateActionListener property="#{BrainSession.pageIndex}" value="#{rowIndex}" />
									</h:commandButton>
								</h:column>
								<h:column>
									<f:facet name="btn1">
										<h:outputText value="" />
									</f:facet>
									<h:commandButton styleClass="button" action="#{BrainSystem.deleteItem}" value="#{bundle.btn_delete}">
										<t:updateActionListener property="#{BrainSession.pageIndex}" value="#{rowIndex}" />
									</h:commandButton>
								</h:column>
							</t:dataTable>
							<t:dataScroller for="itemlist" fastStep="10" pageCountVar="pageCount" pageIndexVar="pageIndex" styleClass="scroller" paginator="true" paginatorMaxPages="9" paginatorTableClass="paginator" firstRowIndexVar="friv" paginatorActiveColumnStyle="font-weight:bold;color: #FB5F00;" immediate="true">
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
							<h:commandButton value="OK" action="lib" />
						</h:form>
						<!-- ### CONTENT-END ### -->
					</t:div>
				</t:div>
			</t:div>
			<t:div styleClass="sidebar_col">
			</t:div>
		</t:div>
	</t:div>
	<!-- LAYOUT-BLOCK 2-1 END -->
	</body>
	</html>
</f:view>