<%@page import="org.opencps.dossiermgt.util.DossierMgtUtil"%>
<%@page import="org.opencps.dossiermgt.search.DossierDisplayTerms"%>
<%@page import="org.opencps.dossiermgt.model.Dossier"%>
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
<%@page import="org.opencps.util.WebKeys"%>
<%@page import="com.liferay.portal.kernel.dao.search.ResultRow"%>
<%@page import="com.liferay.portal.kernel.dao.search.SearchContainer"%>
<%@page import="org.opencps.util.ActionKeys"%>
<%@page import="org.opencps.util.PortletConstants"%>
<%@ include file="../init.jsp"%>

 
<%
	ResultRow row = (ResultRow)request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);
	Dossier dossier = (Dossier) row.getObject();
	String keywords = ParamUtil.getString(request, "keywords");
%> 

			
 <liferay-ui:icon-menu>
 	<portlet:renderURL var="viewHistoryURL">
		<portlet:param name="mvcPath" value='<%=templatePath + "dossiermonitoringhistory.jsp" %>'/>
		<portlet:param name="tabs1" value="<%= DossierMgtUtil.TOP_TABS_DOSSIER_SEARCH %>"/>
		<portlet:param name="<%= DossierDisplayTerms.DOSSIER_DOSSIERID %>" value="<%= String.valueOf(dossier.getDossierId()) %>"/>
		<portlet:param name="backURL" value="<%=currentURL %>"/>
		<portlet:param name="keywords" value="<%= keywords %>"/>
	</portlet:renderURL> 
		
 	<liferay-ui:icon image="history" message="view-history" url="<%= viewHistoryURL.toString() %>" />   
</liferay-ui:icon-menu> 