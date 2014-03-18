<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="org.stoevesand.brain.*"%>
<%@ page import="org.stoevesand.brain.auth.*"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@ taglib uri="http://myfaces.apache.org/trinidad" prefix="tr"%>
<f:view locale="#{BrainSession.currentLocale}">
	<f:loadBundle basename="org.stoevesand.brain.i18n.MessagesBundle" var="bundle" />
	<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml">
	<head>
	<title>Notonto</title>
	<link rel="stylesheet" type="text/css" href="/css/style2.css" />
	</head>
	<body>
	<f:verbatim>
		<script src="http://static.ak.connect.facebook.com/js/api_lib/v0.4/FeatureLoader.js.php" type="text/javascript"></script>
	</f:verbatim>
	<f:subview id="s_headline">
		<jsp:include page="/snippets/headline.jsp" />
	</f:subview>
	<!-- LAYOUT-BLOCK 2-1 START -->
	<t:div styleClass="outer grey">
		<t:div styleClass="block">
			<t:div styleClass="content_col">
				<t:div styleClass="content">
					<t:div styleClass="content_pad">
						<!-- ### CONTENT-START ### -->
						<h:panelGrid columns="2" columnClasses=",100p atop">
							<t:htmlTag value="fb:profile-pic">
								<f:param name="uid" value="#{BrainSession.facebookClient.user.facebookId}" />
								<f:param name="size" value="thumb" />
							</t:htmlTag>
							<h:panelGroup>
								<t:htmlTag value="h1">
									<h:outputText value="Willkomen " />
									<t:htmlTag value="fb:name">
										<f:param name="uid" value="#{BrainSession.facebookClient.user.facebookId}" />
										<f:param name="useyou" value="false" />
										<f:param name="linked" value="false" />
									</t:htmlTag>
								</t:htmlTag>
								<h:outputText styleClass="font1" value="Zu diesem Facebook Account gibt es derzeit noch keinen zugeordneten Account bei notonto. Sie können sich entweder einen neuen Account erzeugen oder einen bestehenden Account bei notonto mit Facebook verbinden." />
							</h:panelGroup>
						</h:panelGrid>
						<h:panelGrid columns="2" columnClasses="w50p atop,atop w50p">
							<h:form>
								<h:panelGroup layout="block" styleClass="innerbox">
									<h:outputText value="Neuen Account bei notonto erzeugen:" styleClass="font2 naked" />
									<t:htmlTag value="br"></t:htmlTag>
									<h:commandLink styleClass="font5 naked c2" action="#{BrainSession.facebookClient.fb_createAccount}" value=">erzeugen" />
								</h:panelGroup>
							</h:form>
							<h:form>
								<h:panelGroup layout="block" styleClass="innerbox">
									<h:outputText value="Bestehenden Account von notonto mit Facebook verbinden:" styleClass="font2 naked" />
									<t:htmlTag value="br"></t:htmlTag>
									<h:panelGrid styleClass="backc1 borderc2" columnClasses="left" columns="1">
										<h:outputText value="#{bundle.username}" styleClass="font1" />
										<h:inputText styleClass="it" id="loginname" value="#{Auth.username}" size="27" required="true"></h:inputText>
										<h:message for="loginname" styleClass="errortext" />
										<h:outputText value="#{bundle.password}" styleClass="font1" />
										<h:inputSecret styleClass="it" id="loginpass" value="#{Auth.password}" size="27" required="true" />
										<h:message for="loginpass" styleClass="errortext" />
										<h:commandLink styleClass="font5 naked c2" action="#{Auth.fb_link}" value=">verbinden" />
										<h:messages styleClass="errortext naked" globalOnly="true" layout="table" />
									</h:panelGrid>
								</h:panelGroup>
							</h:form>
						</h:panelGrid>
						<!-- ### CONTENT-END ### -->
					</t:div>
				</t:div>
			</t:div>
			<f:verbatim>
				<script src="http://static.ak.connect.facebook.com/js/api_lib/v0.4/FeatureLoader.js.php" type="text/javascript"></script>
			</f:verbatim>
			<f:verbatim>
				<script type="text/javascript">
   FB_RequireFeatures(["XFBML"], function()
    {
       FB.init("15b68e3e9a6455c307d652a38a0fcf05", "/fb/xd_receiver.htm");
    });
			</script>
			</f:verbatim>
			<t:div styleClass="sidebar_col">
				<t:div styleClass="sidebar">
					<t:div styleClass="content_pad">
						<!-- ### SIDEBAR-START ### -->
						<!-- ### SIDEBAR-END ### -->
					</t:div>
				</t:div>
			</t:div>
		</t:div>
	</t:div>
	<!-- LAYOUT-BLOCK 2-1 END -->
	<f:subview id="s_footer">
		<jsp:include page="/snippets/footer.jsp" />
	</f:subview>
	<f:verbatim>
		<script type="text/javascript">  
		FB_RequireFeatures(["XFBML"], function(){ FB.Facebook.init("15b68e3e9a6455c307d652a38a0fcf05", "fb/xd_receiver.htm"); }); 
	</script>
	</f:verbatim>
	</body>
	</html>
</f:view>
