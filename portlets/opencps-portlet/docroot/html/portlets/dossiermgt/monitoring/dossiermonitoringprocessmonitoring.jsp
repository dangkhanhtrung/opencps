<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.opencps.dossiermgt.service.DossierLocalServiceUtil"%>
<%@page import="org.opencps.dossiermgt.model.Dossier"%>
<%@page import="org.opencps.dossiermgt.util.DossierMgtUtil"%>
<%@page import="com.liferay.portal.kernel.language.LanguageUtil"%>
<%@page import="com.liferay.portal.kernel.util.FastDateFormatFactoryUtil"%>
<%@page import="java.text.Format"%>
<%@page import="org.opencps.datamgt.service.DictItemLocalServiceUtil"%>
<%@page import="org.opencps.datamgt.model.DictItem"%>
<%@page import="org.opencps.dossiermgt.service.DossierLogLocalServiceUtil"%>
<%@page import="org.opencps.dossiermgt.model.DossierLog"%>
<%@page import="java.util.List"%>
<%@page import="com.liferay.portal.kernel.log.LogFactoryUtil"%>
<%@page import="com.liferay.portal.kernel.log.Log"%>
<%@page import="com.liferay.portal.service.PasswordPolicyLocalServiceUtil"%>
<%@page import="com.liferay.portal.model.PasswordPolicy"%>
<%@page import="javax.portlet.PortletURL"%>
<%@page import="org.opencps.util.WebKeys"%>
<%@page import="com.liferay.portal.model.User"%>
<%
/**
 * OpenCPS is the open source Core Public Services software
 * Copyright (C) 2016-present OpenCPS community
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Affero General Public License for more details.
 * You should have received a copy of the GNU Affero General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
%>
<%@ include file="../init.jsp"%>
<liferay-util:include page="/html/portlets/dossiermgt/monitoring/toptabs.jsp" servletContext="<%=application %>" />

<%
	String backURL = ParamUtil.getString(request, "backURL");
	User mappingUser = (User)request.getAttribute(WebKeys.USER_MAPPING_ENTRY);
	PortletURL iteratorURL = renderResponse.createRenderURL();
	iteratorURL.setParameter("mvcPath", templatePath + "dossiermonitoringprocessmonitoring.jsp");
	
	PasswordPolicy passwordPolicy = null;
	passwordPolicy = PasswordPolicyLocalServiceUtil.getDefaultPasswordPolicy(company.getCompanyId());	
	Format dateFormatDate = FastDateFormatFactoryUtil.getDate(locale, timeZone);

	PortletURL searchURL = renderResponse.createRenderURL();	
	searchURL.setParameter("mvcPath", templatePath + "dossiermonitoringprocessmonitoring.jsp");
	searchURL.setParameter("tabs1", DossierMgtUtil.TOP_TABS_PROCESS_MONITORING);
	
	String onlyViewErrorAndWarning = ParamUtil.getString(request, "onlyViewErrorAndWarning");
	String autoRefresh = ParamUtil.getString(request, "autoRefresh");
	_log.info("ONLYVIEWERRORANDWARNING: " + onlyViewErrorAndWarning);
	_log.info("AUTOREFRESH: " + autoRefresh);
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss");
%>

<aui:form name="fm" action="<%= searchURL %>" method="post">
<aui:row>
	<aui:col width="50">
		<aui:input checked="<%= \"onlyViewErrorAndWarning\".equals(onlyViewErrorAndWarning) %>" type="checkbox" value="onlyViewErrorAndWarning" id="onlyViewErrorAndWarning" name="onlyViewErrorAndWarning" label="<%= LanguageUtil.get(locale, \"only-view-error-and-warning\") %>" />
	</aui:col>
	<aui:col width="50">
		<aui:input type="checkbox" checked="<%= \"autoRefresh\".equals(autoRefresh) %>" value="autoRefresh" id="autoRefresh" name="autoRefresh" label="<%= LanguageUtil.get(locale, \"auto-refresh\") %>" />
	</aui:col>
</aui:row>
</aui:form>
<liferay-ui:search-container deltaConfigurable="true" delta="<%= SearchContainer.DEFAULT_DELTA %>" iteratorURL="<%= iteratorURL %>">

	<liferay-ui:search-container-results>
		<%		
			List<DossierLog> dossierLogs = null;
			int totalCount = 0;
			int[] levels = { DossierMgtUtil.DOSSIELOG_LEVEL_WARNING, DossierMgtUtil.DOSSIELOG_LEVEL_ERROR };
			try {
				if ("onlyViewErrorAndWarning".equals(onlyViewErrorAndWarning)) {
					dossierLogs = DossierLogLocalServiceUtil.getDossierLogByLevels(levels, searchContainer.getStart(), searchContainer.getEnd(), searchContainer.getOrderByComparator());
					totalCount = DossierLogLocalServiceUtil.countDossierLogByLevels(levels);					
				}
				else {
					dossierLogs = DossierLogLocalServiceUtil.getDossierLogs(searchContainer.getStart(), searchContainer.getEnd());
					totalCount = DossierLogLocalServiceUtil.getDossierLogsCount();					
				}
			} catch(Exception e){
				_log.error(e);
			}
		
			total = totalCount;
			results = dossierLogs;
			
			pageContext.setAttribute("results", results);
			pageContext.setAttribute("total", total);
		%>
	</liferay-ui:search-container-results>	
		<liferay-ui:search-container-row 
			className="org.opencps.dossiermgt.model.DossierLog" 
			modelVar="dossierLog" 
			keyProperty="dossierLogId"
		>
			<%
				DictItem dictItem = DictItemLocalServiceUtil.getDictItem(dossierLog.getDossierStatus());
				Dossier dossier = DossierLocalServiceUtil.getDossier(dossierLog.getDossierId());
				String levelString = LanguageUtil.get(locale, "normal-level");
				if (dossierLog.getLevel() == DossierMgtUtil.DOSSIELOG_LEVEL_WARNING) {
					levelString = LanguageUtil.get(locale, "warning-level");
				}
				else if (dossierLog.getLevel() == DossierMgtUtil.DOSSIELOG_LEVEL_ERROR) {
					levelString = LanguageUtil.get(locale, "error-level");
				}
			%>
			<liferay-ui:search-container-column-text name="row-no" title="row-no" value="<%= String.valueOf(row.getPos() + 1) %>"/>
			<liferay-ui:search-container-column-text name="update-datetime" title="update-datetime" value="<%= dateFormatDate.format(dossierLog.getUpdateDatetime()) %>"/>
			<liferay-ui:search-container-column-text name="uuid" title="uuid" value="<%= dossier.getUuid() %>"/>			
			<liferay-ui:search-container-column-text name="reception-no" title="reception-no" value="<%= dossier.getReceptionNo() %>"/>			
			<liferay-ui:search-container-column-text name="dossier-status" title="dossier-status" value="<%= dictItem.getItemName() %>"/>
			<liferay-ui:search-container-column-text name="action-info" title="action-info" value="<%= dossierLog.getActionInfo() %>"/>
			<liferay-ui:search-container-column-text name="message-info" title="message-info" value="<%= dossierLog.getMessageInfo() %>"/>
			<c:choose>
				<c:when test="<%= (dossierLog.getLevel() == DossierMgtUtil.DOSSIELOG_LEVEL_NORMAL)  %>">
					<liferay-ui:search-container-column-text name="log-level" title="log-level" value="normal-level"/>
				</c:when>
				<c:when test="<%= (dossierLog.getLevel() == DossierMgtUtil.DOSSIELOG_LEVEL_WARNING)  %>">
					<liferay-ui:search-container-column-text name="log-level" title="log-level" value="warning-level"/>
				</c:when>
				<c:when test="<%= (dossierLog.getLevel() == DossierMgtUtil.DOSSIELOG_LEVEL_ERROR)  %>">
					<liferay-ui:search-container-column-text name="log-level" title="log-level" value="error-level"/>
				</c:when>
			</c:choose>
			
		</liferay-ui:search-container-row> 
	
	<liferay-ui:search-iterator/>
</liferay-ui:search-container>

<%
	if ("autoRefresh".equals(autoRefresh)) {
%>
<script>
setInterval(function() {
	submitForm(document.<portlet:namespace />fm);
}, 6000);
</script>
<%
	}
%>
<aui:script use="liferay-auto-fields">
	AUI().ready(function (A) {
		A.one('#<portlet:namespace />onlyViewErrorAndWarningCheckbox').on('click', function() {
			submitForm(document.<portlet:namespace />fm);
		});
		A.one('#<portlet:namespace />autoRefreshCheckbox').on('click', function() {
			submitForm(document.<portlet:namespace />fm);
		});
	});
</aui:script>

<%!
	private Log _log = LogFactoryUtil.getLog("html.portlets.dossiermgt.monitoring.dossiermonitoringprocessmonitoring.jsp");
%>

