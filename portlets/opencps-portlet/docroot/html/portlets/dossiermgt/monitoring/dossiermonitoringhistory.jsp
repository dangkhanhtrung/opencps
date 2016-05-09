<%@page import="org.opencps.datamgt.service.DictItemLocalServiceUtil"%>
<%@page import="org.opencps.datamgt.model.DictItem"%>
<%@page import="com.liferay.portal.kernel.util.FastDateFormatFactoryUtil"%>
<%@page import="java.text.Format"%>
<%@page import="org.opencps.dossiermgt.service.DossierLogLocalServiceUtil"%>
<%@page import="java.util.List"%>
<%@page import="org.opencps.util.DictItemUtil"%>
<%@page import="org.opencps.servicemgt.service.ServiceInfoLocalServiceUtil"%>
<%@page import="org.opencps.servicemgt.model.ServiceInfo"%>
<%@page import="org.opencps.dossiermgt.model.Dossier"%>
<%@page import="org.opencps.dossiermgt.model.DossierLog"%>
<%@page import="org.opencps.dossiermgt.service.DossierLocalServiceUtil"%>
<%@page import="org.opencps.dossiermgt.search.DossierDisplayTerms"%>
<%@page import="com.liferay.portal.kernel.language.LanguageUtil"%>
<%@page import="org.opencps.util.WebKeys"%>
<%@page import="com.liferay.portal.kernel.log.LogFactoryUtil"%>
<%@page import="com.liferay.portal.kernel.log.Log"%>
<%@page import="com.liferay.portal.service.PasswordPolicyLocalServiceUtil"%>
<%@page import="com.liferay.portal.model.PasswordPolicy"%>
<%@page import="javax.portlet.PortletURL"%>
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
	iteratorURL.setParameter("mvcPath", templatePath + "dossiermonitoringhistory.jsp");
	
	PasswordPolicy passwordPolicy = null;
	passwordPolicy = PasswordPolicyLocalServiceUtil.getDefaultPasswordPolicy(company.getCompanyId());
	
	long dossierId = ParamUtil.getLong(request, DossierDisplayTerms.DOSSIER_DOSSIERID);
	Dossier dossier = DossierLocalServiceUtil.getDossier(dossierId);
	ServiceInfo serviceInfo = ServiceInfoLocalServiceUtil.getServiceInfo(dossier.getServiceInfoId());
	Format dateFormatDate = FastDateFormatFactoryUtil.getDate(locale, timeZone);
	
%>

<liferay-ui:header
	backURL="<%= backURL %>"
	title="<%= LanguageUtil.get(locale, \"back\") %>"
/>

<div class="lookup-result">
	<table>
		<tr>
			<td class="col-left">
				<liferay-ui:message key="reception-no"/>
			</td>
			<td class="col-right">
				<%= dossier.getReceptionNo() %>
			</td>
		</tr>		
		<tr>
			<td class="col-left">
				<liferay-ui:message key="subject-name"/>
			</td>
			<td class="col-right">
				<%= dossier.getSubjectName() %>
			</td>
		</tr>		
		<tr>
			<td class="col-left">
				<liferay-ui:message key="service-name"/>
			</td>
			<td class="col-right">
				<% if (serviceInfo != null) { %>
					<%= serviceInfo.getServiceName() %>
				<% } %>
			</td>
		</tr>		
		<tr>
			<td class="col-left">
				<liferay-ui:message key="govagency-name"/>
			</td>
			<td class="col-right">
				<%= dossier.getGovAgencyName() %>
			</td>
		</tr>		
	</table>
</div>

<liferay-ui:search-container deltaConfigurable="true" delta="<%= SearchContainer.DEFAULT_DELTA %>" iteratorURL="<%= iteratorURL %>">

	<liferay-ui:search-container-results>
		<%		
			List<DossierLog> dossierLogs = null;
			int totalCount = 0;
			try {
				dossierLogs = DossierLogLocalServiceUtil.getDossierLogByDossierId(dossierId, searchContainer.getStart(), searchContainer.getEnd(), searchContainer.getOrderByComparator());
				totalCount = DossierLogLocalServiceUtil.countDossierLogByDossierId(dossierId);
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
			%>
			<liferay-ui:search-container-column-text name="row-no" title="row-no" value="<%= String.valueOf(row.getPos() + 1) %>"/>
			<liferay-ui:search-container-column-text name="update-datetime" title="update-datetime" value="<%= dateFormatDate.format(dossierLog.getUpdateDatetime()) %>"/>
			<liferay-ui:search-container-column-text name="dossier-status" title="dossier-status" value="<%= dictItem.getItemName() %>"/>
			<liferay-ui:search-container-column-text name="action-info" title="action-info" value="<%= dossierLog.getActionInfo() %>"/>
			<liferay-ui:search-container-column-text name="message-info" title="message-info" value="<%= dossierLog.getMessageInfo() %>"/>
		
		</liferay-ui:search-container-row> 
	
	<liferay-ui:search-iterator/>
</liferay-ui:search-container>

<%!
	private Log _log = LogFactoryUtil.getLog("html.portlets.dossiermgt.monitoring.dossiermonitoringhistory.jsp");
%>
