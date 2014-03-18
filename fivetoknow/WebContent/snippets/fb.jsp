<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<f:verbatim>
	<script src="http://static.ak.connect.facebook.com/js/api_lib/v0.4/FeatureLoader.js.php" type="text/javascript">
	</script>
</f:verbatim>
<t:div styleClass="sidebar_top" rendered="#{!Auth.isLoggedIn}">
</t:div>
<t:div styleClass="sidebar" rendered="#{!Auth.isLoggedIn}" style="border: 2px solid #6D84B4; abackground-color: #7A8FB9;">
	<!-- ### SIDEBAR-START ### -->
	<t:htmlTag value="center">
		<fb:login-button v="2" onlogin="fb_login()">
			<fb:intl>Connect using Facebook</fb:intl>
		</fb:login-button>
	</t:htmlTag>
	<f:verbatim>
		<script type="text/javascript">
   FB_RequireFeatures(["XFBML"], function()
    {
       FB.init("15b68e3e9a6455c307d652a38a0fcf05", "/fb/xd_receiver.htm");
    });
			</script>
	</f:verbatim>
	<!-- ### SIDEBAR-END ### -->
</t:div>
<t:div styleClass="sidebar_bottom" rendered="#{!Auth.isLoggedIn}"></t:div>
