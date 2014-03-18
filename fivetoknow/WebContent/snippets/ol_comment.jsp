<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@ taglib uri="http://myfaces.apache.org/trinidad" prefix="tr"%>
<f:loadBundle basename="org.stoevesand.brain.i18n.MessagesBundle" var="bundle" />
<script type="text/javascript">
	$(function() {
		// a workaround for a flaw in the demo system (http://dev.jqueryui.com/ticket/4375), ignore!
		$("#dialog").dialog("destroy");
	
		$("#dialog-message").dialog({
			modal: true,
			autoOpen: false,
			width: 600,
			resizable: false
		});
	});
</script>
<t:div forceId="true" id="dialog-message" title="#{bundle.feedback}">
	<h:panelGrid columns="1">
		<t:htmlTag value="h2">
			<h:outputText value="#{bundle.feedback_text}" />
		</t:htmlTag>
		<tr:form>
			<tr:selectOneChoice autoSubmit="false" value="#{BrainSession.commentType}" contentStyle="width: 500px">
				<tr:selectItem value="" label="-- Select --"></tr:selectItem>
				<tr:selectItem value="spell" label="#{bundle.f_spell}"></tr:selectItem>
				<tr:selectItem value="trans" label="#{bundle.f_trans}"></tr:selectItem>
				<tr:selectItem value="extra" label="#{bundle.f_extra}"></tr:selectItem>
				<tr:selectItem value="other" label="#{bundle.f_other}"></tr:selectItem>
			</tr:selectOneChoice>
			<tr:inputText partialTriggers="clc clok" value="#{BrainSession.comment}" autoSubmit="false" columns="59" rows="10" maximumLength="700" />
			<tr:commandLink styleClass="btn btn_blue" id="clc" partialSubmit="true" onclick="$('#dialog-message').dialog('close');" text="#{bundle.btn_cancel}" action="#{BrainSession.clearComment}" />
			<tr:commandLink styleClass="btn btn_blue" id="clok" partialSubmit="true" onclick="$('#dialog-message').dialog('close');" text="#{bundle.btn_submit}" action="#{BrainSystem.storeComment}" />
		</tr:form>
	</h:panelGrid>
</t:div>
