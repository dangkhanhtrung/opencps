<%@page import="org.opencps.dossiermgt.permissions.DossierFilePermission"%>
<%@page import="org.opencps.dossiermgt.permissions.DossierPermission"%>
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

<%@page import="javax.portlet.PortletURL"%>
<%@page import="org.opencps.util.ActionKeys"%>
<%@page import="com.liferay.portal.service.permission.PortletPermissionUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="org.opencps.dossiermgt.util.DossierMgtUtil"%>
<%@ include file="../init.jsp"%>

<%

	String[] names = new String[]{DossierMgtUtil.TOP_TABS_LOOKUP_RESULT, DossierMgtUtil.TOP_TABS_NEW_PROCESSING, DossierMgtUtil.TOP_TABS_PROCESS_MONITORING, DossierMgtUtil.TOP_TABS_DOSSIER_SEARCH};

	String value = ParamUtil.getString(request, "tabs1", DossierMgtUtil.TOP_TABS_LOOKUP_RESULT);

	List<String> urls = new ArrayList<String>();

	if (PortletPermissionUtil.contains(permissionChecker, plid, portletDisplay.getId(), ActionKeys.VIEW) && 
			DossierPermission.contains(permissionChecker, scopeGroupId, ActionKeys.VIEW)) {
		PortletURL viewLookupResultURL = renderResponse.createRenderURL();
		viewLookupResultURL.setParameter("mvcPath", templatePath + "dossiermonitoringlookupresult.jsp");
		viewLookupResultURL.setParameter("tabs1", DossierMgtUtil.TOP_TABS_LOOKUP_RESULT);
		urls.add(viewLookupResultURL.toString());
	}
	
	if (PortletPermissionUtil.contains(permissionChecker, plid, portletDisplay.getId(), ActionKeys.VIEW) && 
			DossierPermission.contains(permissionChecker, scopeGroupId, ActionKeys.VIEW)) {
		PortletURL viewNewProcessingURL = renderResponse.createRenderURL();
		viewNewProcessingURL.setParameter("mvcPath", templatePath + "dossiermonitoringnewprocessing.jsp");
		viewNewProcessingURL.setParameter("tabs1", DossierMgtUtil.TOP_TABS_NEW_PROCESSING);
		urls.add(viewNewProcessingURL.toString());
	}
	
	if (PortletPermissionUtil.contains(permissionChecker, plid, portletDisplay.getId(), ActionKeys.VIEW) && 
			DossierFilePermission.contains(permissionChecker, scopeGroupId, ActionKeys.VIEW)) {
		PortletURL viewProcessMonitoringURL = renderResponse.createRenderURL();
		viewProcessMonitoringURL.setParameter("mvcPath", templatePath + "dossiermonitoringprocessmonitoring.jsp");
		viewProcessMonitoringURL.setParameter("tabs1", DossierMgtUtil.TOP_TABS_PROCESS_MONITORING);
		urls.add(viewProcessMonitoringURL.toString());
	}
	
	if (PortletPermissionUtil.contains(permissionChecker, plid, portletDisplay.getId(), ActionKeys.VIEW) && 
			DossierPermission.contains(permissionChecker, scopeGroupId, ActionKeys.VIEW)) {
		PortletURL viewSearchURL = renderResponse.createRenderURL();
		viewSearchURL.setParameter("mvcPath", templatePath + "dossiermonitoringsearch.jsp");
		viewSearchURL.setParameter("tabs1", DossierMgtUtil.TOP_TABS_DOSSIER_SEARCH);
		urls.add(viewSearchURL.toString());
	}
%>
<liferay-ui:tabs
	names="<%= StringUtil.merge(names) %>"
	param="tabs1"
	url0="<%=urls != null && urls.size() > 0 ? urls.get(0): StringPool.BLANK %>"
	url1="<%=urls != null && urls.size() > 1 ? urls.get(1): StringPool.BLANK %>"
	url2="<%=urls != null && urls.size() > 2 ? urls.get(2): StringPool.BLANK %>"
	url3="<%=urls != null && urls.size() > 3 ? urls.get(3): StringPool.BLANK %>"
/>
