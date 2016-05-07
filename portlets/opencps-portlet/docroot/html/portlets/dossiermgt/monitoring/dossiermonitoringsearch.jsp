<%@page import="com.liferay.portal.kernel.dao.search.SearchEntry"%>
<%@page import="com.liferay.portal.kernel.language.LanguageUtil"%>
<%@page import="org.opencps.datamgt.service.DictItemLocalServiceUtil"%>
<%@page import="org.opencps.datamgt.model.DictItem"%>
<%@page import="com.liferay.portal.kernel.util.FastDateFormatFactoryUtil"%>
<%@page import="java.text.Format"%>
<%@page import="org.opencps.servicemgt.service.ServiceInfoLocalServiceUtil"%>
<%@page import="org.opencps.servicemgt.model.ServiceInfo"%>
<%@page import="org.opencps.dossiermgt.model.Dossier"%>
<%@page import="java.util.List"%>
<%@page import="org.opencps.dossiermgt.service.DossierLocalServiceUtil"%>
<%@page import="com.liferay.util.dao.orm.CustomSQLUtil"%>
<%@page import="org.opencps.dossiermgt.search.DossierSearchTerms"%>
<%@page import="com.liferay.portal.kernel.log.LogFactoryUtil"%>
<%@page import="com.liferay.portal.kernel.log.Log"%>
<%@page import="com.liferay.portal.service.PasswordPolicyLocalServiceUtil"%>
<%@page import="com.liferay.portal.model.PasswordPolicy"%>
<%@page import="javax.portlet.PortletURL"%>
<%@page import="org.opencps.util.WebKeys"%>
<%@page import="com.liferay.portal.model.User"%>
<%@page import="org.opencps.dossiermgt.search.DossierSearch"%>

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
<liferay-util:include page="/html/portlets/dossiermgt/monitoring/searchtoolbar.jsp" servletContext="<%=application %>" />

<%
	String backURL = ParamUtil.getString(request, "backURL");
	User mappingUser = (User)request.getAttribute(WebKeys.USER_MAPPING_ENTRY);
	PortletURL iteratorURL = renderResponse.createRenderURL();
	iteratorURL.setParameter("mvcPath", templatePath + "dossiermonitoringsearch.jsp");
	
	PasswordPolicy passwordPolicy = null;
	passwordPolicy = PasswordPolicyLocalServiceUtil.getDefaultPasswordPolicy(company.getCompanyId());	
	
	String keywords = ParamUtil.getString(request, "keywords");
	System.out.println("Keywords: " + keywords);	
	Format dateFormatDate = FastDateFormatFactoryUtil.getDate(locale, timeZone);
%>

<liferay-ui:search-container searchContainer="<%= new DossierSearch(renderRequest, SearchContainer.DEFAULT_DELTA, iteratorURL) %>">

	<liferay-ui:search-container-results>
		<%
			DossierSearchTerms searchTerms = (DossierSearchTerms)searchContainer.getSearchTerms();
			
			String[] keywordArrs = null;
			
			if(Validator.isNotNull(searchTerms.getKeywords())){
				keywordArrs = CustomSQLUtil.keywords(searchTerms.getKeywords());
			}
			
			if (keywordArrs != null) {
				List<Dossier> dossiers = null;
				Integer totalCount = 0;
				
				try {
					dossiers = DossierLocalServiceUtil.searchDossier(scopeGroupId, searchTerms.getKeywords(), searchContainer.getStart(), searchContainer.getEnd());
					totalCount = DossierLocalServiceUtil.countDossier(scopeGroupId, searchTerms.getKeywords());
				} catch(Exception e){
					_log.error(e);
				}
			
				total = totalCount;
				results = dossiers;
				
				pageContext.setAttribute("results", results);
				pageContext.setAttribute("total", total);				
			}
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
				
				//uuid column
				row.addText(dossier.getUuid());
				
				//subjectName column
				row.addText(dossier.getSubjectName());
				ServiceInfo serviceInfo = ServiceInfoLocalServiceUtil.getServiceInfo(dossier.getServiceInfoId());
				
				//serviceinfo-name column
				row.addText(serviceInfo.getServiceName());
				
				//govagencyname column
				row.addText(dossier.getGovAgencyName());

				//receivedatetime column
				if (dossier.getReceiveDatetime() != null)
					row.addText(dateFormatDate.format(dossier.getReceiveDatetime()));
				else
					row.addText("");

				row.addText(dossier.getReceptionNo());
				
				//dossierstatus column
				DictItem dictItem = DictItemLocalServiceUtil.getDictItem(dossier.getDossierStatus());
				row.addText(dictItem.getItemName());
				
				row.addJSP("center", SearchEntry.DEFAULT_VALIGN, templatePath + "history_actions.jsp", config.getServletContext(), request, response);
			%>	
		</liferay-ui:search-container-row> 
	
	<liferay-ui:search-iterator/>
</liferay-ui:search-container>

<%!
	private Log _log = LogFactoryUtil.getLog("html.portlets.dossiermgt.monitoring.dossiermonitoringsearch.jsp");
%>
