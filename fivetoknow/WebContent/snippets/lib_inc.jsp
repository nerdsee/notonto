
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@ taglib uri="http://myfaces.apache.org/trinidad" prefix="tr"%>
<%@ taglib uri="http://myfaces.apache.org/trinidad/html" prefix="trh"%>
<t:div id="shade" forceId="true" styleClass="outer">
	<!-- LAYOUT-BLOCK 2-1 START -->
	<t:div styleClass="outer grey">
		<t:div styleClass="block">
			<t:div styleClass="content_col">
				<t:div styleClass="content">
					<!-- ### CONTENT-START ### -->
					<t:htmlTag value="h1">
						<h:outputText value="#{bundle.menu_library}" />
					</t:htmlTag>
					<t:htmlTag value="h3">
						<h:outputText value="#{bundle.libinfo}" />
					</t:htmlTag>
					<t:div styleClass="infotext" rendered="#{not Auth.isLoggedIn}">
						<h:outputText value="#{bundle.liblogin}" />
					</t:div>
					<t:div styleClass="breadcrump">
						<h:outputText styleClass="font1 c3" value="&rArr; " escape="false" />
						<t:dataList value="#{BrainSession.topicPath}" var="tpp" layout="simple" columnClasses="w100p">
							<h:outputLink value="/lib/topic_#{tpp.id}.jsf" styleClass="link" rendered="#{BrainSession.currentTopic ne tpp}">
								<h:outputText styleClass="font1 c3" value="#{tpp.text}" escape="false" />
							</h:outputLink>
							<h:outputText styleClass="font1 c3" value=" &rArr; " escape="false" rendered="#{BrainSession.currentTopic ne tpp}" />
							<h:outputText styleClass="font1 bold c3" value="#{bundle.cat}: #{BrainSession.filterCat}" escape="false" rendered="#{empty BrainSession.currentTopic}" />
							<h:outputText styleClass="font1 bold c3" value="#{tpp.text}" escape="false" rendered="#{BrainSession.currentTopic eq tpp}" />
						</t:dataList>
					</t:div>
					<t:dataList value="#{BrainSession.topics}" var="tp" layout="simple" columnClasses="w100p">
						<h:panelGrid columnClasses="w150" style="display: inline; text-align: center; width: 150px;" columns="1">
							<h:outputLink value="/lib/topic_#{tp.id}.jsf" styleClass="link">
								<h:graphicImage url="/images/lessons/lesson_button_#{tp.icon}.gif" styleClass="icon" width="64" height="64" />
								<h:outputText styleClass="font1 bold c3" escape="false" value="<br>#{tp.text}" />
							</h:outputLink>
						</h:panelGrid>
					</t:dataList>
					<h:form>
						<t:dataTable value="#{BrainSession.library}" var="lw" columnClasses="liblist,liblist w100p" styleClass="w100p">
							<t:column>
								<h:graphicImage url="/images/lessons/lesson_button_#{lw.lesson.icon}.gif" styleClass="icon" width="32" height="32" />
							</t:column>
							<t:column>
								<h:panelGrid columns="2" columnClasses="w100p,">
									<h:outputText value="#{lw.lesson.description}" styleClass="font1 bold" />
									<h:panelGroup>
										<h:graphicImage styleClass="flag" value="/images/#{lw.lesson.qlang}.gif" width="15" height="9" />
										<h:outputText value="&nbsp;" escape="false" />
										<h:graphicImage styleClass="flag" value="/images/#{lw.lesson.alang}.gif" width="15" height="9" />
									</h:panelGroup>
								</h:panelGrid>
								<h:panelGrid columns="1" columnClasses="w100p">
									<h:outputText escape="false" value="#{lw.lesson.abstract}" styleClass="font3" />
								</h:panelGrid>
								<h:panelGrid columns="2" columnClasses="ta_left, ta_right w100p">
									<h:outputText escape="false" value="#{bundle.numberitems}&nbsp;#{lw.lesson.itemCount}" styleClass="font3 bold" />
									<t:panelGroup rendered="#{Auth.isLoggedIn}">
										<h:commandLink action="#{BrainSession.subscribeLesson}" styleClass="link">
											<h:outputText escape="false" value=">&nbsp;#{bundle.btn_subscribed}" styleClass="font2 cgr" rendered="#{lw.isSubscribed}" />
											<h:outputText escape="false" value=">&nbsp;#{bundle.btn_subscribe}" styleClass="font2 crd" rendered="#{not lw.isSubscribed}" />
										</h:commandLink>
										<h:commandButton styleClass="distlr" image="/images/icons/pen.gif" action="#{BrainSystem.editLesson}" rendered="#{BrainSession.currentUser.isAdmin}" />
										<h:commandButton styleClass="distlr" image="/images/icons/delete.gif" onclick="if ( !shure() ) return false;" action="#{BrainSystem.deleteLesson}" rendered="#{BrainSession.currentUser.isAdmin}" />
									</t:panelGroup>
								</h:panelGrid>
							</t:column>
						</t:dataTable>
					</h:form>
					<h:outputText styleClass="font1 bold c3" value="#{bundle.nolessons}" escape="false" rendered="#{BrainSession.library.rowCount==0 and BrainSession.topicCount==0}" />
					<!-- ### CONTENT-END ### -->
				</t:div>
			</t:div>
			<t:div styleClass="sidebar_col">
				<t:div styleClass="sidebar">
					<!-- ### SIDEBAR-START ### -->
					<h:form>
						<t:htmlTag value="h1">
							<h:outputText value="#{bundle.cat}" />
						</t:htmlTag>
						<t:div styleClass="thecloud">
							<t:dataList value="#{BrainSession.localCategories}" var="cat">
								<h:panelGroup>
									<h:outputLink value="/library.jsf?cat=#{cat.escapedText}" styleClass="cloud#{cat.size} cloudc#{cat.size}" rendered="#{!cat.isActive}">
										<h:outputText value="#{cat.text} " />
									</h:outputLink>
									<h:outputText value="#{cat.text} " styleClass="sel cloud#{cat.size}" rendered="#{cat.isActive}" />
								</h:panelGroup>
							</t:dataList>
						</t:div>
						<t:htmlTag value="h1" rendered="#{Auth.isLoggedIn}">
							<h:outputText value="#{bundle.code}" />
						</t:htmlTag>
						<t:div styleClass="naked" rendered="#{Auth.isLoggedIn}">
							<h:outputText value="#{bundle.lessoncode}" styleClass="font1" />
							<h:inputText value="#{BrainSession.lessonCode}" size="35" />
							<h:commandLink styleClass="btn btn_blue" action="#{BrainSession.selectLessonCode}" value="#{bundle.btn_ok}" />
						</t:div>
					</h:form>
					<!-- ### SIDEBAR-END ### -->
				</t:div>
			</t:div>
		</t:div>
	</t:div>
	<!-- LAYOUT-BLOCK 2-1 END -->
</t:div>
