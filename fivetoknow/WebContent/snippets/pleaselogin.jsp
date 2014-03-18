<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<t:div style="text-align:center; width:100%;" rendered="#{not Auth.isLoggedIn}">
	<f:verbatim>
		<font class="c3" style='margin-top: 10px; font: 60px bold Helvetica; display: block;'>&uarr;&nbsp;</font>
		<br>
		<font class="c3" style='font: 30px Helvetica;'>Please login</font>
	</f:verbatim>
</t:div>
