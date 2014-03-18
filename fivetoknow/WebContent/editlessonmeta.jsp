<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@ taglib uri="http://myfaces.apache.org/trinidad" prefix="tr"%>
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
	<script type="text/javascript">
	function calc_code() {
		var prefix="";
		if ($("#presel").length>0)
			prefix=$("#presel option:selected").text();
		else
			prefix=$("#preselstat").text();
		var code=$("#itcode").val();
		$("#gencode").html("= "+prefix+code);
	}
	function change_flag() {
		var flag=$("#flagsel option:selected").attr("value");
		$("#iflag").attr("src","/images/lessons/lesson_button_"+flag+".gif");
	}
</script>
	</head>
	<body onLoad="calc_code()">
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
					<h1><h:outputText value="#{bundle.editlesson}" /></h1>
					<h2><h:outputText value="#{BrainSession.currentLesson.description}" /></h2>
					<h:form>
						<h:panelGrid columns="2" styleClass="tstd" columnClasses="ta_right,test">
							<h:outputText value="Titel" styleClass="font1 bold" />
							<h:inputText value="#{BrainSession.currentLesson.description}" size="40" />
							<h:outputText value="Code" styleClass="font1 bold" />
							<h:panelGroup rendered="#{not empty BrainSession.currentLesson.owner.prefix}">
								<t:selectOneListbox forceId="true" id="presel" size="1" value="#{BrainSession.currentLesson.ownergroupId}" rendered="#{BrainSession.currentLesson.prefixListSize>1}" onchange="calc_code();">
									<f:selectItems value="#{BrainSession.currentLesson.prefixList}" />
								</t:selectOneListbox>
								<t:outputText forceId="true" id="preselstat" value="#{BrainSession.currentLesson.prefix}" styleClass="font1" rendered="#{BrainSession.currentLesson.prefixListSize==1}" />
								<t:inputText forceId="true" id="itcode" value="#{BrainSession.currentLesson.codeSuffix}" size="8" onkeyup="calc_code();" />
								<h:outputText value=" " styleClass="font1" />
								<t:outputText forceId="true" id="gencode" value="" styleClass="font1" />
							</h:panelGroup>
							<h:outputText value="#{bundle.selectprefix}" escape="false" styleClass="c3 msgtext" rendered="#{empty BrainSession.currentLesson.owner.prefix}" />
							<h:outputText value="Type" styleClass="font1 bold" />
							<t:selectOneListbox size="1" value="#{BrainSession.currentLesson.lessonType}">
								<f:selectItem itemValue="0" itemLabel="Standard" />
								<f:selectItem itemValue="1" itemLabel="Symbol" />
							</t:selectOneListbox>
							<h:outputText value="Icon" styleClass="font1 bold" />
							<t:selectOneListbox forceId="true" size="1" id="flagsel" value="#{BrainSession.currentLesson.icon}" onchange="change_flag();">
								<f:selectItem itemValue="allg" itemLabel="common knowledge" />
								<f:selectItem itemValue="capax" itemLabel="capax" />
								<f:selectItem itemValue="dk" itemLabel="danish" />
								<f:selectItem itemValue="en" itemLabel="english" />
								<f:selectItem itemValue="geo" itemLabel="geography" />
								<f:selectItem itemValue="it" itemLabel="italian" />
								<f:selectItem itemValue="lang" itemLabel="language" />
								<f:selectItem itemValue="mpc" itemLabel="mpc-logo" />
								<f:selectItem itemValue="no" itemLabel="norwegian" />
								<f:selectItem itemValue="pt" itemLabel="portugese" />
								<f:selectItem itemValue="ru" itemLabel="russian" />
								<f:selectItem itemValue="es" itemLabel="spanish" />
							</t:selectOneListbox>
							<h:outputText value="" styleClass="font1 bold" />
							<t:graphicImage forceId="true" id="iflag" url="/images/lessons/lesson_button_#{BrainSession.currentLesson.icon}.gif" styleClass="icon" width="32" height="32" />
							<h:outputText value="Language (Q-A)" styleClass="font1 bold" />
							<h:panelGroup>
								<t:selectOneListbox style="margin-right: 5px;" size="1" value="#{BrainSession.currentLesson.qlang}">
									<f:selectItem itemValue="ch" itemLabel="ch" />
									<f:selectItem itemValue="de" itemLabel="de" />
									<f:selectItem itemValue="dk" itemLabel="dk" />
									<f:selectItem itemValue="en" itemLabel="en" />
									<f:selectItem itemValue="es" itemLabel="es" />
									<f:selectItem itemValue="it" itemLabel="it" />
									<f:selectItem itemValue="no" itemLabel="no" />
									<f:selectItem itemValue="pt" itemLabel="pt" />
									<f:selectItem itemValue="ru" itemLabel="ru" />
								</t:selectOneListbox>
								<t:selectOneListbox size="1" value="#{BrainSession.currentLesson.alang}">
									<f:selectItem itemValue="ch" itemLabel="ch" />
									<f:selectItem itemValue="de" itemLabel="de" />
									<f:selectItem itemValue="dk" itemLabel="dk" />
									<f:selectItem itemValue="en" itemLabel="en" />
									<f:selectItem itemValue="es" itemLabel="es" />
									<f:selectItem itemValue="it" itemLabel="it" />
									<f:selectItem itemValue="no" itemLabel="no" />
									<f:selectItem itemValue="pt" itemLabel="pt" />
									<f:selectItem itemValue="ru" itemLabel="ru" />
								</t:selectOneListbox>
							</h:panelGroup>
							<h:outputText value="Tags" styleClass="font1 bold" rendered="#{Auth.isLoggedIn && BrainSession.currentUser.isAdmin}" />
							<h:panelGrid columns="2" rendered="#{Auth.isLoggedIn && BrainSession.currentUser.isAdmin}">
								<h:outputText value="DE" styleClass="font1 bold" />
								<h:inputText value="#{BrainSession.currentLesson.tagsDE}" size="40" />
								<h:outputText value="EN" styleClass="font1 bold" />
								<h:inputText value="#{BrainSession.currentLesson.tagsEN}" size="40" />
								<h:outputText value="ES" styleClass="font1 bold" />
								<h:inputText value="#{BrainSession.currentLesson.tagsES}" size="40" />
							</h:panelGrid>
							<h:outputText value="Abstract" styleClass="font1 bold" />
							<h:inputTextarea value="#{BrainSession.currentLesson.abstract}" cols="40" rows="10" />
							<h:outputText value="" />
							<h:panelGroup>
								<h:commandLink value="OK" action="#{BrainSession.currentLesson.saveAction}" styleClass="btn btn_blue"/>
								<h:outputText value="" />
								<h:commandLink value="Back" action="#{BrainSession.currentLesson.rollbackAction}" styleClass="btn btn_red" />
							</h:panelGroup>
						</h:panelGrid>
					</h:form>
					<!-- ### CONTENT-END ### -->
				</t:div>
			</t:div>
			<t:div styleClass="sidebar_col">
				<f:subview id="i_s_left">
					<jsp:include page="/snippets/sidemenu_lesson.jsp" />
				</f:subview>
			</t:div>
		</t:div>
	</t:div>
	<!-- LAYOUT-BLOCK 2-1 END -->
	</body>
	</html>
</f:view>