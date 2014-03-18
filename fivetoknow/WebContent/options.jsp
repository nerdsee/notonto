<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
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
	<title>Notonto - Optionen</title>
	<f:subview id="s_inc_head">
		<jsp:include page="/snippets/inc_head.jsp" />
	</f:subview>
	<script type="text/javascript">
  $(document).ready(function(){
	    $("#accordion").accordion({ collapsible: true, active: false });
  });
  </script>
	</head>
	<trh:body id="body" initialFocusId="ff1:it1">
		<f:subview id="s_headline">
			<jsp:include page="/snippets/headline.jsp" />
		</f:subview>
		<!-- LAYOUT-BLOCK 2-1 START -->
		<t:div id="shade" forceId="true" styleClass="outer">
			<t:div styleClass="block">
				<t:div styleClass="content_col">
					<t:div styleClass="content">
						<t:div styleClass="content_pad" rendered="#{Auth.isLoggedIn}">
							<!-- ### CONTENT-START ### -->
							<t:htmlTag value="h1">
								<h:outputText value="#{bundle.account}" />
							</t:htmlTag>
							<t:div id="accordion">
								<t:htmlTag value="a" rendered="#{Auth.isLoggedIn}">
									<f:param name="href" value="#" />
									<f:param name="class" value="font1 c3" />
									<t:htmlTag value="h2">
										<h:outputText value="#{bundle.passchange}" />
										<h:outputText value=">>" styleClass="font1 c3" />
									</t:htmlTag>
								</t:htmlTag>
								<t:div rendered="#{Auth.isLoggedIn}">
									<t:div styleClass="pad">
										<h:outputText value="#{bundle.passchange_text}" styleClass="font1" />
									</t:div>
									<tr:form id="ff1" partialTriggers="cb1">
										<h:panelGrid columns="2">
											<h:outputText value="#{bundle.password}" styleClass="font1" />
											<tr:inputText secret="true" id="pw1" value="#{Auth.passnew}" />
											<h:outputText value="" />
											<h:message for="pw1" styleClass="errortext" />
											<h:outputText value="#{bundle.passconfirm}" styleClass="font1" />
											<tr:inputText secret="true" id="pw2" value="#{Auth.passconfirm}" />
											<h:outputText value="" />
											<h:message for="pw2" styleClass="errortext" />
											<h:outputText value="" styleClass="font1" rendered="#{Auth.statusCode > 0}" />
											<tr:outputText styleClass="oktext" partialTriggers="cb1" value="#{bundle.msg_pwchanged}" rendered="#{Auth.statusCode == 1}" />
											<tr:outputText styleClass="errortext" partialTriggers="cb1" value="#{bundle.msg_pwnomatch}" rendered="#{Auth.statusCode == 3}" />
											<tr:outputText styleClass="errortext" partialTriggers="cb1" value="#{bundle.msg_pwempty}" rendered="#{Auth.statusCode eq 4}" />
											<h:outputText value="" />
											<tr:commandButton styleClass="btn btn_blue" id="cb1" action="#{Auth.alterPassword}" partialSubmit="true" text="#{bundle.btn_confirm}"></tr:commandButton>
										</h:panelGrid>
									</tr:form>
								</t:div>
								<t:htmlTag value="a">
									<f:param name="href" value="#" />
									<f:param name="class" value="h2" />
									<t:htmlTag value="h2">
										<h:outputText value="#{bundle.statusMail}: " />
										<tr:panelGroupLayout partialTriggers="statb1">
											<tr:outputText value="#{bundle.stat_never}" rendered="#{BrainSession.currentUser.statusMailFreq==0}" styleClass="c2" />
											<tr:outputText value="#{bundle.stat_daily}" rendered="#{BrainSession.currentUser.statusMailFreq==1}" styleClass="c2" />
											<tr:outputText value="#{bundle.stat_weekly}" rendered="#{BrainSession.currentUser.statusMailFreq==7}" styleClass="c2" />
											<tr:outputText value="#{bundle.stat_monthly}" rendered="#{BrainSession.currentUser.statusMailFreq==30}" styleClass="c2" />
											<h:panelGroup rendered="#{BrainSession.currentUser.statusMailFreq>0}">
												<h:outputText value=" #{bundle.stat_in} " />
												<tr:outputText value="#{bundle.stat_en}" rendered="#{BrainSession.currentUser.statusLang=='en'}" styleClass="c2" />
												<tr:outputText value="#{bundle.stat_de}" rendered="#{BrainSession.currentUser.statusLang=='de'}" styleClass="c2" />
											</h:panelGroup>
										</tr:panelGroupLayout>
										<h:outputText value=">>" styleClass="h2" />
									</t:htmlTag>
								</t:htmlTag>
								<t:div>
									<t:div styleClass="pad">
										<h:outputText escape="false" value="#{bundle.statusmail_text}" styleClass="font1" />
									</t:div>
									<tr:form id="statf" partialTriggers="statb1">
										<h:panelGrid columns="2">
											<h:outputText value="#{bundle.statusMailFreq}" styleClass="font1" />
											<tr:selectOneChoice value="#{BrainSession.currentUser.statusMailFreq}">
												<tr:selectItem value="0" label="#{bundle.stat_never}" />
												<tr:selectItem value="1" label="#{bundle.stat_daily}" />
												<tr:selectItem value="7" label="#{bundle.stat_weekly}" />
												<tr:selectItem value="30" label="#{bundle.stat_monthly}" />
											</tr:selectOneChoice>
											<h:outputText value="#{bundle.statusMailLang}" styleClass="font1" />
											<tr:selectOneChoice value="#{BrainSession.currentUser.statusLang}">
												<tr:selectItem value="de" label="#{bundle.stat_de}" />
												<tr:selectItem value="en" label="#{bundle.stat_en}" />
											</tr:selectOneChoice>
											<h:outputText value="" />
											<tr:commandButton id="statb1" styleClass="btn btn_blue" action="#{Auth.alterStatusMailFreq}" partialSubmit="true" text="OK"></tr:commandButton>
										</h:panelGrid>
									</tr:form>
								</t:div>
								<t:htmlTag value="a">
									<f:param name="href" value="#" />
									<f:param name="class" value="h2" />
									<t:htmlTag value="h2">
										<h:outputText value="#{bundle.nickname}: " />
										<tr:outputText value="#{BrainSession.currentUser.nick}" partialTriggers="nickb1" styleClass="c2" />
										<h:outputText value=">>" styleClass="h2" />
									</t:htmlTag>
								</t:htmlTag>
								<t:div>
									<t:div styleClass="pad">
										<h:outputText escape="false" value="#{bundle.nickname_text}" styleClass="font1" />
									</t:div>
									<tr:form id="ni2" partialTriggers="nickb1">
										<h:panelGrid columns="2">
											<h:outputText value="#{bundle.nickname}" styleClass="font1" />
											<tr:inputText partialTriggers="nickb1" id="nick1" value="#{Auth.nicknew}" maximumLength="15" simple="true">
											</tr:inputText>
											<h:outputText value="" styleClass="font1" />
											<tr:outputText value="#{Auth.nickMsg}" partialTriggers="nickb1" styleClass="errortext" />
											<h:outputText value="" />
											<tr:commandButton id="nickb1" styleClass="btn btn_blue" action="#{Auth.alterNickname}" partialSubmit="true" text="OK"></tr:commandButton>
										</h:panelGrid>
									</tr:form>
								</t:div>
								<t:htmlTag value="a">
									<f:param name="href" value="#" />
									<f:param name="class" value="h2" />
									<t:htmlTag value="h2">
										<h:outputText value="#{bundle.prefix}: " />
										<tr:outputText value="#{BrainSession.currentUser.prefix}" partialTriggers="prefixb1" styleClass="c2" />
										<h:outputText value=">>" styleClass="h2" />
									</t:htmlTag>
								</t:htmlTag>
								<t:div>
									<tr:form id="prefixf1" partialTriggers="prefixb1">
										<t:div styleClass="pad">
											<h:outputText escape="false" value="#{bundle.prefix_text}" styleClass="font1" />
										</t:div>
										<h:panelGrid columns="3">
											<h:outputText value="#{bundle.prefix}" styleClass="font1" />
											<tr:inputText secret="false" id="prefixpw" value="#{Auth.prefixnew}" />
											<h:outputText value="#{BrainMessage.prefixErrorText}" styleClass="errortext" />
											<h:outputText value="" />
											<tr:commandButton id="prefixb1" styleClass="btn btn_blue" action="#{Auth.alterPrefix}" partialSubmit="true" text="OK"></tr:commandButton>
										</h:panelGrid>
									</tr:form>
								</t:div>
								<t:htmlTag value="a" rendered="#{Auth.isLoggedIn}">
									<f:param name="href" value="#" />
									<f:param name="class" value="h2" />
									<t:htmlTag value="h2">
										<h:outputText value="#{bundle.delete_account} >>" />
									</t:htmlTag>
								</t:htmlTag>
								<t:div rendered="#{Auth.isLoggedIn}">
									<tr:form id="delf1" partialTriggers="delcb1">
										<t:div styleClass="pad">
											<h:outputText escape="false" value="#{bundle.delete_text}" styleClass="font1" />
										</t:div>
										<h:panelGrid columns="2">
											<h:outputText value="#{bundle.password}" styleClass="font1" />
											<tr:inputText secret="false" id="delpw" value="#{Auth.passnew}" />
											<h:outputText value="" />
											<h:outputText value="#{BrainMessage.pwErrorText}" styleClass="errortext" />
											<h:outputText value="" />
											<tr:commandButton id="delcb1" styleClass="btn btn_blue" action="#{Auth.deleteAccount}" partialSubmit="true" text="#{bundle.btn_delete}"></tr:commandButton>
										</h:panelGrid>
									</tr:form>
								</t:div>
							</t:div>
							<!-- ### CONTENT-END ### -->
						</t:div>
					</t:div>
				</t:div>
				<t:div styleClass="sidebar_col">
					<f:subview id="pleaseli">
						<jsp:include page="/snippets/pleaselogin.jsp" />
					</f:subview>
				</t:div>
			</t:div>
		</t:div>
		<!-- LAYOUT-BLOCK 2-1 END -->
	</trh:body>
	</html>
</f:view>
