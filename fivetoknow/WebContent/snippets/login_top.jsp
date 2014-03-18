<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<t:div style="float:right; text-align: right; margin-top: 20px;" rendered="#{!Auth.isLoggedIn}">
	<h:panelGrid styleClass="tnk" columns="3">
		<h:outputText value="#{bundle.username}" styleClass="font2 bold cf" />
		<h:outputText value="#{bundle.password}" styleClass="font2 bold cf" />
		<h:outputText value="" />
		<t:inputText forceId="true" styleClass="input" id="loginname" value="#{Auth.username}" size="20" required="true" />
		<t:inputSecret forceId="true" styleClass="input" id="loginpass" value="#{Auth.password}" size="20" required="true" onkeydown="return firelogin(event,1);" />
		<t:commandLink forceId="true" id="firelogin" styleClass="btns btn_blue" onclick="return userandpass();" action="#{Auth.login}" value="#{bundle.login}" />
	</h:panelGrid>
	<h:messages styleClass="font3 bold c1" globalOnly="true" layout="table" />
</t:div>
