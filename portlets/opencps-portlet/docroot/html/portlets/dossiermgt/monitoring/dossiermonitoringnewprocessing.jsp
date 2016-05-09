<%@page import="org.opencps.dossiermgt.service.DossierStatusLocalServiceUtil"%>
<%@page import="org.opencps.dossiermgt.NoSuchDossierStatusException"%>
<%@page import="com.liferay.portal.kernel.exception.SystemException"%>
<%@page import="org.opencps.dossiermgt.model.DossierStatus"%>
<%@page import="com.liferay.portal.kernel.util.FastDateFormatFactoryUtil"%>
<%@page import="java.text.Format"%>
<%@page import="org.opencps.dossiermgt.search.DossierNewDoneSearchTerms"%>
<%@page import="org.opencps.servicemgt.service.ServiceInfoLocalServiceUtil"%>
<%@page import="org.opencps.servicemgt.model.ServiceInfo"%>
<%@page import="org.opencps.dossiermgt.search.DossierNewReceivedSearchTerms"%>
<%@page import="org.opencps.dossiermgt.search.DossierNewReceivedSearch"%>
<%@page import="org.opencps.dossiermgt.search.DossierNewDoneSearch"%>
<%@page import="org.opencps.datamgt.service.DictCollectionLocalServiceUtil"%>
<%@page import="org.opencps.datamgt.model.DictCollection"%>
<%@page import="org.opencps.datamgt.service.DictItemLocalServiceUtil"%>
<%@page import="org.opencps.datamgt.model.DictItem"%>
<%@page import="org.opencps.dossiermgt.service.DossierLocalServiceUtil"%>
<%@page import="org.opencps.dossiermgt.search.DossierDisplayTerms"%>
<%@page import="org.opencps.servicemgt.search.ServiceDisplayTerms"%>
<%@page import="com.liferay.portal.kernel.log.LogFactoryUtil"%>
<%@page import="com.liferay.portal.kernel.log.Log"%>
<%@page import="java.util.List"%>
<%@page import="org.opencps.dossiermgt.model.Dossier"%>
<%@page import="org.opencps.dossiermgt.search.DossierSearchTerms"%>
<%@page import="org.opencps.dossiermgt.search.DossierSearch"%>
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
<liferay-util:include page="/html/portlets/dossiermgt/monitoring/newprocessingtoolbar.jsp" servletContext="<%=application %>" />

<%
	String backURL = ParamUtil.getString(request, "backURL");
	User mappingUser = (User)request.getAttribute(WebKeys.USER_MAPPING_ENTRY);
	PortletURL iteratorURL = renderResponse.createRenderURL();
	iteratorURL.setParameter("mvcPath", templatePath + "dossiermonitoringnewprocessing.jsp");
	
	PasswordPolicy passwordPolicy = null;
	passwordPolicy = PasswordPolicyLocalServiceUtil.getDefaultPasswordPolicy(company.getCompanyId());	
	
	String administrationCode = ParamUtil.getString(request, DossierDisplayTerms.DOSSIER_ADMINISTRATIONCODE);
	
	String domainCode = ParamUtil.getString(request, DossierDisplayTerms.DOSSIER_DOMAINCODE);
	Format dateFormatDate = FastDateFormatFactoryUtil.getDate(locale, timeZone);
%>

<aui:row>
	<aui:col width="50">
		<liferay-ui:search-container searchContainer="<%= new DossierNewReceivedSearch(renderRequest, SearchContainer.DEFAULT_DELTA, iteratorURL) %>">
		
			<liferay-ui:search-container-results>
				<%
					DossierNewReceivedSearchTerms searchTerms = (DossierNewReceivedSearchTerms)searchContainer.getSearchTerms();
					Integer totalCount = 0;										
					List<Dossier> newdossierreceiveds = null;		
					DictCollection dictCollection = DictCollectionLocalServiceUtil.getDictCollection(scopeGroupId, "DOSSIER_STATUS");
					DictItem dictItem = DictItemLocalServiceUtil.getDictItemInuseByItemCode(dictCollection.getDictCollectionId(), "received");
					try {
						newdossierreceiveds = DossierLocalServiceUtil.searchDossierByAdministrationAndDomain(scopeGroupId, administrationCode, domainCode, dictItem.getDictItemId(), searchContainer.getStart(), searchContainer.getEnd());
						totalCount = DossierLocalServiceUtil.countDossierByAdministrationAndDomain(scopeGroupId, administrationCode, domainCode, dictItem.getDictItemId());
					}catch(Exception e){
						_log.error(e);
					}
				
					total = totalCount;
					results = newdossierreceiveds;
					
					pageContext.setAttribute("results", results);
					pageContext.setAttribute("total", total);
				%>
			</liferay-ui:search-container-results>	
				<liferay-ui:search-container-row 
					className="org.opencps.dossiermgt.model.Dossier" 
					modelVar="dossier" 
					keyProperty="dossierId"
				>
					<%						
						// no column
						row.addText(String.valueOf(row.getPos() + 1));

						//subjectname column
						row.addText(dossier.getSubjectName());
						
						ServiceInfo serviceInfo = ServiceInfoLocalServiceUtil.getServiceInfo(dossier.getServiceInfoId());
						//serviceinfo-name column
						row.addText(serviceInfo.getServiceName());
					
						//update-datetime column
						DossierStatus newest = null;
						try {
							newest = DossierStatusLocalServiceUtil.getNewestStatusUpdated(dossier.getDossierId());
						}
						catch (SystemException syex) {
							
						}
						catch (NoSuchDossierStatusException nsdse) {
							
						}
						if (newest != null) {
							row.addText(dateFormatDate.format(newest.getUpdateDatetime()));
						}
						else {
							row.addText("");
						}
					%>	
				</liferay-ui:search-container-row> 
			
			<liferay-ui:search-iterator/>
		</liferay-ui:search-container>

	</aui:col>
	<aui:col width="50">
		<liferay-ui:search-container searchContainer="<%= new DossierNewDoneSearch(renderRequest, SearchContainer.DEFAULT_DELTA, iteratorURL) %>">
		
			<liferay-ui:search-container-results>
				<%
					DossierNewDoneSearchTerms searchTerms = (DossierNewDoneSearchTerms)searchContainer.getSearchTerms();
					Integer totalCount = 0;										
					List<Dossier> newdossierdones = null;		
					DictCollection dictCollection = DictCollectionLocalServiceUtil.getDictCollection(scopeGroupId, "DOSSIER_STATUS");
					DictItem dictItem = DictItemLocalServiceUtil.getDictItemInuseByItemCode(dictCollection.getDictCollectionId(), "done");
					try {
						newdossierdones = DossierLocalServiceUtil.searchDossierByAdministrationAndDomain(scopeGroupId, administrationCode, domainCode, dictItem.getDictItemId(), searchContainer.getStart(), searchContainer.getEnd());
						totalCount = DossierLocalServiceUtil.countDossierByAdministrationAndDomain(scopeGroupId, administrationCode, domainCode, dictItem.getDictItemId());
					}catch(Exception e){
						_log.error(e);
					}
				
					total = totalCount;
					results = newdossierdones;
					
					pageContext.setAttribute("results", results);
					pageContext.setAttribute("total", total);
				%>
			</liferay-ui:search-container-results>	
				<liferay-ui:search-container-row 
					className="org.opencps.dossiermgt.model.Dossier" 
					modelVar="dossier" 
					keyProperty="dossierId"
				>
					<%						
						// no column
						row.addText(String.valueOf(row.getPos() + 1));
						
						//subjectname column
						row.addText(dossier.getSubjectName());
						
						ServiceInfo serviceInfo = ServiceInfoLocalServiceUtil.getServiceInfo(dossier.getServiceInfoId());
						//serviceinfo-name column
						row.addText(serviceInfo.getServiceName());

						//update-datetime column
						DossierStatus newest = null;
						try {
							newest = DossierStatusLocalServiceUtil.getNewestStatusUpdated(dossier.getDossierId());
						}
						catch (SystemException syex) {
							
						}
						catch (NoSuchDossierStatusException nsdse) {
							
						}
						if (newest != null) {
							row.addText(dateFormatDate.format(newest.getUpdateDatetime()));
						}
						else {
							row.addText("");
						}
					%>	
				</liferay-ui:search-container-row> 
			
			<liferay-ui:search-iterator/>
		</liferay-ui:search-container>
	</aui:col>
</aui:row>
<%!
	private Log _log = LogFactoryUtil.getLog("html.portlets.dossiermgt.monitoring.dossiermonitoringnewprocessing.jsp");
%>