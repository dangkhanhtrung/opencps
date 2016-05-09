<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.opencps.dossiermgt.NoSuchDossierStatusException"%>
<%@page import="com.liferay.portal.kernel.exception.SystemException"%>
<%@page import="org.opencps.dossiermgt.service.DossierStatusLocalServiceUtil"%>
<%@page import="org.opencps.dossiermgt.model.DossierStatus"%>
<%@page import="org.opencps.datamgt.model.DictItem"%>
<%@page import="org.opencps.datamgt.service.DictItemLocalServiceUtil"%>
<%@page import="com.liferay.portal.kernel.util.FastDateFormatFactoryUtil"%>
<%@page import="java.text.Format"%>
<%@page import="org.opencps.util.DictItemUtil"%>
<%@page import="org.opencps.servicemgt.service.ServiceInfoLocalServiceUtil"%>
<%@page import="org.opencps.servicemgt.model.ServiceInfo"%>
<%@page import="org.opencps.dossiermgt.model.Dossier"%>
<%@page import="org.opencps.dossiermgt.service.DossierLocalServiceUtil"%>
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

<liferay-util:include page="/html/portlets/dossiermgt/monitoring/toolbar.jsp" servletContext="<%=application %>" />
<%
	String backURL = ParamUtil.getString(request, "backURL");
	User mappingUser = (User)request.getAttribute(WebKeys.USER_MAPPING_ENTRY);
	PortletURL iteratorURL = renderResponse.createRenderURL();
	iteratorURL.setParameter("mvcPath", templatePath + "dossiermonitoringlookupresult.jsp");
	
	PasswordPolicy passwordPolicy = null;
	passwordPolicy = PasswordPolicyLocalServiceUtil.getDefaultPasswordPolicy(company.getCompanyId());	
	String keywords = ParamUtil.getString(request, "keywords");
	System.out.println("Keywords: " + keywords);	
	Dossier dossier = null;
	ServiceInfo serviceInfo = null;
	if (keywords != null) {
		try {
			dossier = DossierLocalServiceUtil.getDossierByReceptionNo(keywords);
			serviceInfo = ServiceInfoLocalServiceUtil.getServiceInfo(dossier.getServiceInfoId());
		}
		catch (Exception ex) {
			
		}		
	}
	Format dateFormatDate = FastDateFormatFactoryUtil.getDate(locale, timeZone);
%>

<div class="lookup-result">
	<%
		if (keywords != null && dossier != null) {
	%>
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
				<liferay-ui:message key="administration-name"/>
			</td>
			<td class="col-right">
				<% if (serviceInfo != null) { %>
					<%= DictItemUtil.getNameDictItem(serviceInfo.getDomainCode())  %>
				<% } %>
			</td>
		</tr>		
		<tr>
			<td class="col-left">
				<liferay-ui:message key="address"/>
			</td>
			<td class="col-right">
				<%= dossier.getAddress() %>
			</td>
		</tr>		
		<tr>
			<td class="col-left">
				<liferay-ui:message key="receive-datetime"/>
			</td>
			<td class="col-right">
				<%= dateFormatDate.format(dossier.getReceiveDatetime()) %>
			</td>
		</tr>		
		<tr>
			<td class="col-left">
				<liferay-ui:message key="estimate-datetime"/>
			</td>
			<td class="col-right">
				<%= dateFormatDate.format(dossier.getEstimateDatetime()) %>
			</td>
		</tr>		
		<tr>
			<td class="col-left">
				<liferay-ui:message key="finish-datetime"/>
			</td>
			<td class="col-right">
				<%= dateFormatDate.format(dossier.getFinishDatetime()) %>
			</td>
		</tr>		
		<tr>
			<td class="col-left">
				<liferay-ui:message key="dossier-status"/>
			</td>
			<td class="col-right">
				<%
					DictItem dictItem = DictItemLocalServiceUtil.getDictItem(dossier.getDossierStatus());
				%>
				<%= dictItem.getItemName() %>
			</td>
		</tr>		
		<tr>
			<td class="col-left">
				<liferay-ui:message key="update-datetime"/>
			</td>
			<td class="col-right">
				<%
					DossierStatus newest = null;
					try {
						newest = DossierStatusLocalServiceUtil.getNewestStatusUpdated(dossier.getDossierId());
					}
					catch (SystemException syex) {
						
					}
					catch (NoSuchDossierStatusException nsdse) {
						
					}
					if (newest != null) {
						SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss");
				%>
				<%= sdf.format(newest.getUpdateDatetime()) %>
				<%
					}
				%>
			</td>
		</tr>		
	</table>
	<%
		}
		else if (keywords != null) {
	%>
		<liferay-ui:message key="dossier-not-found"/>
	<%
		}
		else {
	%>
	<%
		}
	%>
</div>