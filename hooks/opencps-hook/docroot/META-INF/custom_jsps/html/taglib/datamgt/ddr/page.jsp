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

<%@ include file="init.jsp"%>
<h1>DataMgt Taglib</h1>
<%
	if(depthLevel > 0){
		
		int colWidth = 100;
		
		if(displayStyle.equals("vertical")){
			colWidth = 100;
		}else{
			colWidth = (int) 100/depthLevel;
		}
		%>
			<aui:row>
				<%
				for(int i = 1; i <= depthLevel; i++){
					String elementName = name + i;
					if(itemNames != null && itemNames.length >= i){
						elementName = itemNames[i -1];
					}
					%>
						<aui:col id='<%="col_" + i %>' cssclass="<%=cssClass + i %>" width="<%=colWidth %>">
							<aui:select name='<%=elementName %>'>
								<aui:option value="0"></aui:option>
							</aui:select>
						</aui:col>
					<%
				}
				%>
			</aui:row>
		<%
	}
%>

<portlet:renderURL var="selectBoxRenderURL" windowState="<%=LiferayWindowState.EXCLUSIVE.toString() %>">
	<portlet:param name="mvcPath" value="/html/taglib/datamgt/ddr/selectbox_render.jsp"/>
</portlet:renderURL>



<aui:script>
	var selectBoxRenderURL = '<%=selectBoxRenderURL.toString()%>';
	
	AUI().ready('aui-base','liferay-portlet-url','aui-io', function(A){
	
		var dictCollectionCode = '<%=dictCollectionCode %>';
		var initDictItemId = parseInt('<%=initDictItemId %>');
		var groupId = parseInt('<%=scopeGroupId %>');
		
		
		if(initDictItemId <= 0){
			Liferay.Service(
			'/opencps-portlet.dictcollection/get-dictcollection-by-gc',
				{
					groupId	: groupId,
					collectionCode : dictCollectionCode
				},function(obj) {
					
					if(obj){
						var dictCollectionId = obj.dictCollectionId;
						
						<portlet:namespace/>renderRootDataItemsByCollection(dictCollectionId);
					}
					
				}
			);
		}
	});
	
	Liferay.provide(window, '<portlet:namespace/>renderRootDataItemsByCollection', function(dictCollectionId) {
	
		var A = AUI();
		
		if(dictCollectionId){
		
			var rootDictItemsContainer =  A.one('#<portlet:namespace/>col_1');
			
			Liferay.Service(
			'/opencps-portlet.dictitem/get-dictitems-by-dictcollectionId',
			{
				dictCollectionId : dictCollectionId
			},function(obj) {
				console.log(obj);
				
				var labelName = rootDictItemsContainer.one('label').text().trim();
				
				var boundingBox = '<div class="control-group">' + 
						'<label class="control-label" for="<portlet:namespace/>' + labelName + '">' + labelName + '</label>' +
						'<select class="aui-field-select" id="<portlet:namespace/>' + labelName + '">' + 
							for(var opt in obj){
								
							}
						'</select>' + 
					'</div>'
				
				rootDictItemsContainer.empty();
				rootDictItemsContainer.html(boundingBox);
			});
		}
	});
	
	Liferay.provide(window, '<portlet:namespace/>renderRootDataItems', function(dictCollectionId) {
	
		var A = AUI();
		
		if(dictCollectionId){
		
			var rootDictItemsContainer =  A.one('#<portlet:namespace/>col_1');
			
			
			var RenderDictItemsBy_DictCollectionId = new Liferay.RenderDictItemsBy_DictCollectionId(
				{
				
					boundingBox : rootDictItemsContainer,
					collectionId : dictCollectionId,
					depthLevel : 1,
					groupId : '<%=scopeGroupId%>',
					ns : '<portlet:namespace/>',	
					selectedItem : 0,
					url : '<%=request.getContextPath() %>' + '/selectbox_render.jsp'
				}
			).render();
		}
	},['render-dictitems-by-dictcollectionId']);
	
	
</aui:script>