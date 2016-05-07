<%@page import="org.opencps.util.WebKeys"%>
<%@page import="com.liferay.portal.model.User"%>
<%@page import="javax.portlet.PortletURL"%>
<%@page import="com.liferay.portal.model.PasswordPolicy"%>
<%@page import="com.liferay.portal.service.PasswordPolicyLocalServiceUtil"%>
<%@page import="com.liferay.portal.service.UserLocalServiceUtil"%>
<%@page import="com.liferay.portal.UserLockoutException"%>
<%@page import="org.opencps.dossiermgt.util.DossierMgtUtil"%>
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

<%
	String backURL = ParamUtil.getString(request, "backURL");
	User mappingUser = (User)request.getAttribute(WebKeys.USER_MAPPING_ENTRY);
	PortletURL iteratorURL = renderResponse.createRenderURL();
	iteratorURL.setParameter("mvcPath", templatePath + "frontofficedossierfilelist.jsp");
	
	PasswordPolicy passwordPolicy = null;
	passwordPolicy = PasswordPolicyLocalServiceUtil.getDefaultPasswordPolicy(company.getCompanyId());
	
	String[] dossierSections = new String[]{"dossier_info", "dossierpart_info", "dossierresult_info", "transaction_info"};
	
	String[][] categorySections = {dossierSections};
	
%>

<liferay-ui:header
	backURL="<%= backURL %>"
	title='<%= "dossier-list" %>'
/>

<liferay-util:buffer var="htmlTop">
	<div class="user-info">
		<div class="float-container">
			<img alt="" class="user-logo" src="#" />

		</div>
	</div>
</liferay-util:buffer>

<liferay-util:buffer var="htmlBottom">

	<%
	boolean lockedOut = false;

	if ((mappingUser != null) && (passwordPolicy != null)) {
		try {
			UserLocalServiceUtil.checkLockout(mappingUser);
		}
		catch (UserLockoutException ule) {
			lockedOut = true;
		}
	}
	%>

	<c:if test="<%= lockedOut %>">
		<aui:button-row>
			<div class="alert alert-block"><liferay-ui:message key="this-user-account-has-been-locked-due-to-excessive-failed-login-attempts" /></div>

			<%
			String taglibOnClick = renderResponse.getNamespace() + "saveUser('unlock');";
			%>

			<aui:button onClick="<%= taglibOnClick %>" value="unlock" />
		</aui:button-row>
	</c:if>
</liferay-util:buffer>

<liferay-ui:form-navigator
	backURL="<%= backURL %>"
	categoryNames="<%= DossierMgtUtil._DOSSIER_CATEGORY_NAMES %>"
	categorySections="<%= categorySections %>"
	htmlBottom="<%= htmlBottom %>"
	htmlTop="<%= htmlTop %>"
	jspPath='<%=templatePath + "dossier/" %>'
	showButtons="false"
/>