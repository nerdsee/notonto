<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<f:loadBundle basename="org.stoevesand.brain.i18n.MessagesBundle" var="bundle" />
<t:div styleClass="sidebar">
	<!-- ### SIDEBAR-START ### -->
	<t:htmlTag value="h1">
		<h:outputText value="Up-/Download" />
	</t:htmlTag>
	<h:form id="lessonuploadform" enctype="multipart/form-data">
		<!-- new chapter to be added here -->
		<h:panelGrid columns="1" styleClass="">
			<h:outputText value="#{bundle.fileformat}" styleClass="font1" />
			<t:inputFileUpload value="#{BrainSession.lessonLoader.uploadedFile}" required="true" label="l" size="5"/>	
			<h:commandLink styleClass="btn btn_blue" value="Upload" action="#{BrainSession.fileLessonUploaded}" />
		</h:panelGrid>
	</h:form>
	<h:form styleClass="" id="side_form2">
		<h:commandLink styleClass="btn btn_blue" action="#{BrainSession.downloadLesson}" value="Download Lesson" />
	</h:form>
	<t:htmlTag value="h1" style="margin-top: 40px;">
		<h:outputText value="Lektion löschen" />
	</t:htmlTag>
	<h:form styleClass="" id="side_form3">
		<h:commandLink styleClass="btn btn_red" action="#{BrainSession.deleteOwnerLesson}" onclick="if ( !shure('#{BrainSession.currentLesson.description}') ) return false;">
			<h:outputText escape="false" value="#{bundle.btn_delete}" />
		</h:commandLink>
	</h:form>
	<!-- ### SIDEBAR-END ### -->
</t:div>
