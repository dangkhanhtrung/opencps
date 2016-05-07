<%@page import="org.opencps.dossiermgt.service.DossierLocalServiceUtil"%>
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
 * along with this program. If not, see <http://www.gnu.org/licenses/>
 */
%>

<%@page import="org.opencps.datamgt.service.DictItemLocalServiceUtil"%>
<%@page import="java.util.List"%>
<%@page import="org.opencps.datamgt.model.DictItem"%>
<%@page import="org.opencps.datamgt.service.DictCollectionLocalServiceUtil"%>
<%@page import="org.opencps.datamgt.model.DictCollection"%>

<%@ include file="../init.jsp" %>

<div class="state-menu well" style="max-width: 340px; padding: 8px 0;">
	<ul class="nav nav-list">
		<li class="nav-header"><liferay-ui:message key="dossier-status"/></li>
		<%
			DictCollection dictCollection = DictCollectionLocalServiceUtil.getDictCollection(scopeGroupId, "DOSSIER_STATUS");
			List<DictItem> dictItems = DictItemLocalServiceUtil.getDictItemsByDictCollectionId(dictCollection.getDictCollectionId());
			for (DictItem item : dictItems) {
		%>
			<li>
				<a href=""><%= item.getItemName() %>
					<span class="label label-info">
						<%= DossierLocalServiceUtil.countDossierByDossierStatus(scopeGroupId, item.getDictItemId()) %>
					</span>				
				</a>
			</li>
		<%
			}
		%>
	</ul>
</div>