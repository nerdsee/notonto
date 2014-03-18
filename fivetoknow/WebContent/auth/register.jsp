<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<f:view locale="#{BrainSession.currentLocale}">
	<html>
	<head>
	<title>Register</title>
	<t:stylesheet path="/css/jquery-ui-1.8.1.custom.css"></t:stylesheet>
	<f:subview id="s_inc_head">
		<jsp:include page="/snippets/inc_head.jsp" />
	</f:subview>
	</head>
	<body onLoad="document.getElementById('regform:emailinput').focus()">
	<script type="text/javascript">
	$(function() {
		// a workaround for a flaw in the demo system (http://dev.jqueryui.com/ticket/4375), ignore!
		$("#dialog").dialog("destroy");
	
		$("#dialog-message").dialog({
			modal: true,
			autoOpen: false,
			buttons: {
				Close: function() {
					$(this).dialog('close');
				}
			}
		});
	});
	</script>
	<f:loadBundle basename="org.stoevesand.brain.i18n.MessagesBundle" var="bundle" />
	<f:subview id="s_headline">
		<jsp:include page="/snippets/headline.jsp" />
	</f:subview>
	<!-- LAYOUT-BLOCK 2-1 START -->
	<t:div id="shade" forceId="true" styleClass="outer">
		<t:div styleClass="block">
			<t:div styleClass="content_col">
				<t:div styleClass="content">
					<!-- ### CONTENT-START ### -->
					<t:htmlTag value="h1">
						<h:outputText value="#{bundle.register}" />
					</t:htmlTag>
					<h:form id="regform">
						<h:panelGrid styleClass="tstd" columnClasses="ta_right w10p," columns="2">
							<h:outputText value="#{bundle.email}" styleClass="font1 bold" />
							<h:panelGroup>
								<t:inputText style="display:block;" id="emailinput" value="#{Auth.email}" required="true" validator="#{Auth.validateEmail}">
									<t:validateEmail />
								</t:inputText>
								<h:message for="emailinput" styleClass="font2 c2" />
							</h:panelGroup>
							<h:outputText value="#{bundle.password}" styleClass="font1 bold" />
							<h:panelGroup>
								<t:inputSecret style="display:block;" id="passinput" value="#{Auth.password}" required="true" />
								<h:message for="passinput" styleClass="font2 c2" />
							</h:panelGroup>
							<h:outputText value="#{bundle.passconfirm}" styleClass="font1 bold" />
							<h:panelGroup>
								<t:inputSecret style="display:block;" id="passconfinput" value="#{Auth.passconfirm}" required="true" />
								<h:message for="passconfinput" styleClass="font2 c2" />
							</h:panelGroup>
							<h:outputText value="" />
							<h:panelGroup>
								<h:selectBooleanCheckbox id="acceptinput" required="true" validator="#{Auth.validateRights}" />
								<h:outputText styleClass="font1" value="#{bundle.confirm1} " />
								<h:commandLink styleClass="font1 c1" onclick="$('#dialog-message').dialog('open'); return false;" value="#{bundle.confirm2}" />
								<h:outputText styleClass="font1" value=" #{bundle.confirm3}" />
							</h:panelGroup>
							<h:outputText value="" />
							<h:message for="acceptinput" styleClass="font2 c2" />
							<h:outputText value="" />
							<h:commandLink styleClass="btn btn_blue" action="#{Auth.register}" value="#{bundle.register}"/>
						</h:panelGrid>
					</h:form>
					<!-- ### CONTENT-END ### -->
				</t:div>
			</t:div>
			<t:div styleClass="sidebar_col">
				<t:div styleClass="sidebar">
					<!-- ### SIDEBAR-START ### -->
					<t:htmlTag value="h1">
						<h:outputText value="Info"></h:outputText>
					</t:htmlTag>
					<f:verbatim>
						<font class="font1"> Bitte geben Sie hier Ihre korrekte email-Adresse ein. Diese dient später beim Login als Ihre Benutzername. </font>
					</f:verbatim>
					<!-- ### SIDEBAR-END ### -->
				</t:div>
			</t:div>
		</t:div>
	</t:div>
	<!-- LAYOUT-BLOCK 2-1 END -->
	<t:div id="dialog-message" title="#{bundle.terms}">
		<h:panelGrid columns="1">
			<h:panelGroup styleClass="font1 ta_left">
				<h:outputText value="#{bundle.nutzung1}" />
				<t:htmlTag value="p"></t:htmlTag>
				<h:outputText value="#{bundle.nutzung2}" />
				<t:htmlTag value="p"></t:htmlTag>
				<h:outputText value="#{bundle.nutzung3}" />
			</h:panelGroup>
		</h:panelGrid>
	</t:div>
	</body>
	</html>
</f:view>
