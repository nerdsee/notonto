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
	<t:stylesheet path="/css/jquery-ui-1.8.1.custom.css"></t:stylesheet>
	<f:subview id="s_inc_head">
		<jsp:include page="/snippets/inc_head.jsp" />
	</f:subview>
	<script type="text/javascript">
	$(function() {
		$("#tabs").tabs();
	});	
	</script>
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
				<f:subview id="s_error">
					<jsp:include page="/snippets/error_header.jsp" />
				</f:subview>
				<t:div styleClass="content">
					<t:div styleClass="content_pad">
						<!-- ### CONTENT-START ### -->
						<h1><h:outputText value="#{bundle.validate}" /></h1>
						<h:panelGrid columns="2" styleClass="tstd">
							<h:outputText value="Uploaded Words:" styleClass="font2" />
							<h:outputText value="#{BrainSession.lessonLoader.numberUploadedItems}" styleClass="font2 bold" />
						</h:panelGrid>
						<t:div id="tabs">
							<f:verbatim>
								<ul>
									<li class="font2"><a href="#tabs-1"><h:outputText value="#{bundle.new_entries} [#{BrainSession.lessonLoader.numberNewItems}]" /></a></li>
									<li class="font2"><a href="#tabs-2"><h:outputText value="#{bundle.mod_entries} [#{BrainSession.lessonLoader.numberChangedItems}]" escape="false" /></a></li>
									<li class="font2"><a href="#tabs-3"><h:outputText value="#{bundle.rem_entries} [#{BrainSession.lessonLoader.numberRemovedItems}]" /></a></li>
								</ul>
							</f:verbatim>
							<t:div id="tabs-1">
								<t:dataTable id="newitemlist" styleClass="tcheckword" value="#{BrainSession.lessonLoader.newItems}" var="item" columnClasses="" rendered="#{BrainSession.lessonLoader.newItems.rowCount>0}">
									<h:column>
										<f:facet name="header">
											<h:outputText value="Question" styleClass="font2" />
										</f:facet>
										<h:outputText value="#{item.text}" styleClass="font2 bold" />
										<h:outputText value="<sup>[#{item.extId}]</sup>" rendered="#{item.extId>0}" styleClass="c2" escape="false" />
									</h:column>
									<h:column>
										<f:facet name="header">
											<h:outputText value="Answer(s)" styleClass="font2 bold" />
										</f:facet>
										<t:dataList var="answer" value="#{item.answers}" layout="unorderedList">
											<h:outputText value="#{answer.text}" />
										</t:dataList>
									</h:column>
								</t:dataTable>
								<h:outputText value="#{bundle.none_entries}" styleClass="font2 bold" rendered="#{BrainSession.lessonLoader.newItems.rowCount==0}" />
							</t:div>
							<t:div id="tabs-2">
								<t:dataTable headerClass="bordered" styleClass="tcheckword" id="moditemlist" value="#{BrainSession.lessonLoader.modifiedItems}" var="item" columnClasses="w200 atop font1 bordered,w200 atop font1 bordered" rendered="#{BrainSession.lessonLoader.modifiedItems.rowCount>0}">
									<h:column>
										<f:facet name="header">
											<h:outputText value="Question" styleClass="font2 bold" />
										</f:facet>
										<h:outputText value="#{item.text}" styleClass="font2 bold" />
										<h:outputText value="<sup>[#{item.extId}]</sup>" rendered="#{item.extId>0}" styleClass="c2" escape="false" />
									</h:column>
									<h:column>
										<f:facet name="header">
											<h:outputText value="Answer(s)" styleClass="font2 bold" />
										</f:facet>
										<t:dataList var="answer" value="#{item.answers}" layout="unorderedList">
											<h:outputText value="#{answer.text}" />
										</t:dataList>
									</h:column>
								</t:dataTable>
								<h:outputText value="#{bundle.none_entries}" styleClass="font2 bold" rendered="#{BrainSession.lessonLoader.modifiedItems.rowCount==0}" />
							</t:div>
							<t:div id="tabs-3">
								<t:dataTable headerClass="bordered" styleClass="tcheckword" id="remitemlist" value="#{BrainSession.lessonLoader.removedItems}" var="item" columnClasses="w200 atop font1 bordered,w200 atop font1 bordered" rendered="#{BrainSession.lessonLoader.removedItems.rowCount>0}">
									<h:column>
										<f:facet name="header">
											<h:outputText value="Question" styleClass="font2 bold" />
										</f:facet>
										<h:outputText value="#{item.text}" styleClass="font2 bold" />
										<h:outputText value="<sup>[#{item.extId}]</sup>" rendered="#{item.extId>0}" styleClass="c2" escape="false" />
									</h:column>
									<h:column>
										<f:facet name="header">
											<h:outputText value="Answer(s)" styleClass="font2 bold" />
										</f:facet>
										<t:dataList var="answer" value="#{item.answers}" layout="unorderedList">
											<h:outputText value="#{answer.text}" />
										</t:dataList>
									</h:column>
								</t:dataTable>
								<h:outputText value="#{bundle.none_entries}" styleClass="font2 bold" rendered="#{BrainSession.lessonLoader.removedItems.rowCount==0}" />
							</t:div>
						</t:div>
						<!-- ### CONTENT-END ### -->
					</t:div>
				</t:div>
			</t:div>
			<t:div styleClass="sidebar_col">
				<t:div styleClass="sidebar">
					<h:form>
						<t:htmlTag value="h1" style="margin-top: 40px;">
							<h:outputText value="#{bundle.confirm_changes}" />
						</t:htmlTag>
						<h:commandButton action="#{BrainSession.confirmNewItems}" value="#{bundle.btn_accept}" styleClass="btn btn_blue"/>
						<h:panelGrid columns="2">
							<h:selectBooleanCheckbox value="#{BrainSession.lessonLoader.deleteRemovedItems}" />
							<h:outputText styleClass="font3" value="#{bundle.lesson_confirm}" escape="false" />
						</h:panelGrid>
						<t:htmlTag value="h1" style="margin-top: 40px;">
							<h:outputText value="#{bundle.discard_changes}" />
						</t:htmlTag>
						<h:commandButton action="editlessonmeta" value="#{bundle.btn_discard}" styleClass="btn btn_red"/>
					</h:form>
				</t:div>
			</t:div>
		</t:div>
	</t:div>
	<!-- LAYOUT-BLOCK 2-1 END -->
	<f:subview id="s_footer">
		<jsp:include page="/snippets/footer.jsp" />
	</f:subview>
	</body>
	</html>
</f:view>