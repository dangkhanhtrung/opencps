
<%@page import="org.opencps.dossiermgt.search.DossierDisplayTerms"%>
<%@page import="org.opencps.dossiermgt.util.DossierMgtUtil"%>
<%@page import="java.util.List"%>
<%@page import="org.opencps.datamgt.service.DictItemLocalServiceUtil"%>
<%@page import="org.opencps.servicemgt.util.ServiceUtil"%>
<%@page import="org.opencps.datamgt.model.DictCollection"%>
<%@page import="org.opencps.datamgt.model.DictItem"%>
<%@page import="org.opencps.datamgt.service.DictCollectionLocalServiceUtil"%>
<%@page import="org.opencps.servicemgt.search.ServiceDisplayTerms"%>
<%@page import="javax.portlet.PortletURL"%>
<%@page import="com.liferay.portal.kernel.language.LanguageUtil"%>
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

<%@page import="com.liferay.portal.kernel.log.LogFactoryUtil"%>
<%@page import="com.liferay.portal.kernel.log.Log"%>
<%@ include file="../init.jsp"%>

<%
	PortletURL searchURL = renderResponse.createRenderURL();	
	searchURL.setParameter("mvcPath", templatePath + "dossiermonitoringnewprocessing.jsp");
	searchURL.setParameter("tabs1", DossierMgtUtil.TOP_TABS_NEW_PROCESSING);
	
	String administrationCode = ParamUtil.getString(request, DossierDisplayTerms.DOSSIER_ADMINISTRATIONCODE);
	
	String domainCode = ParamUtil.getString(request, DossierDisplayTerms.DOSSIER_DOMAINCODE);
	
	request.setAttribute(DossierDisplayTerms.DOSSIER_ADMINISTRATIONCODE, administrationCode);
	
	request.setAttribute(DossierDisplayTerms.DOSSIER_DOMAINCODE, domainCode);
	
	DictCollection dc = DictCollectionLocalServiceUtil.getDictCollection(scopeGroupId, ServiceUtil.SERVICE_DOMAIN);
	
	List<DictItem> ls = DictItemLocalServiceUtil.getDictItemsByDictCollectionId(dc.getDictCollectionId());
	
	DictCollection dcAdministration = DictCollectionLocalServiceUtil.getDictCollection(scopeGroupId, ServiceUtil.SERVICE_ADMINISTRATION);
	
	List<DictItem> lsAdministration = DictItemLocalServiceUtil.getDictItemsByDictCollectionId(dcAdministration.getDictCollectionId());
	
%>

<aui:nav-bar cssClass="custom-toolbar">
	<aui:nav id="toolbarContainer" cssClass="nav-display-style-buttons pull-left" >
		
	</aui:nav>
	
	<aui:nav-bar-search cssClass="pull-left" style="width: 98%;">
		<div class="form-search">
			<aui:form action="<%= searchURL %>" method="post" name="fm">
				<div class="toolbar_search_input">
					<aui:row>
						<aui:col width="50">
							<aui:select label="" name="<%= DossierDisplayTerms.DOSSIER_DOMAINCODE %>" style="width: 100%;">
								<aui:option value="">
									<liferay-ui:message key="filter-by-service-domain"></liferay-ui:message>
								</aui:option>
								<%
									for (DictItem di : ls ) {							
								%>
								<aui:option value="<%= di.getItemCode() %>"><%= di.getItemName(locale) %></aui:option>							
								<%
									}
								%>	
							</aui:select>
						</aui:col>
						<aui:col width="50">
							<aui:select label="" name="<%= DossierDisplayTerms.DOSSIER_ADMINISTRATIONCODE %>" style="width: 100%;">
								<aui:option value="">
									<liferay-ui:message key="filter-by-service-administration"></liferay-ui:message>
								</aui:option>
								<%
									for (DictItem di : lsAdministration ) {							
								%>
								<aui:option value="<%= di.getItemCode() %>"><%= di.getItemName(locale) %></aui:option>							
								<%
									}
								%>	
							</aui:select>
						</aui:col>
					</aui:row>
					<aui:row>
						<aui:col width="100">
							<aui:button type="submit" value="<%= LanguageUtil.get(locale, \"button-search\") %>">
							</aui:button>
						</aui:col>
					</aui:row>
				</div>
			</aui:form>
		</div>			
	</aui:nav-bar-search>
</aui:nav-bar>
<%!
	private Log _log = LogFactoryUtil.getLog("html.portlets.dossiermgt.monitoring.newprocessingtoolbar.jsp");
%>