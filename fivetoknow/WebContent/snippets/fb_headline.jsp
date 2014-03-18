<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<fb:login-button v="2">
	<fb:intl>Connect with Facebook</fb:intl>
</fb:login-button>
<f:verbatim>
	<script src="http://static.ak.connect.facebook.com/js/api_lib/v0.4/FeatureLoader.js.php" type="text/javascript">
  </script>
	<script type="text/javascript">
   FB_RequireFeatures(["XFBML"], function()
    {
       FB.Facebook.init("15b68e3e9a6455c307d652a38a0fcf05", "fb/xd_receiver.htm", {"ifUserConnected":"fbindex.jsf"});
    });
  </script>
</f:verbatim>