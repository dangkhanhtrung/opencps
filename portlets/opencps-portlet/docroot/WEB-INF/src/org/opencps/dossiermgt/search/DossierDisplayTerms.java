/**
* OpenCPS is the open source Core Public Services software
* Copyright (C) 2016-present OpenCPS community

* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU Affero General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* any later version.

* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU Affero General Public License for more details.
* You should have received a copy of the GNU Affero General Public License
* along with this program. If not, see <http://www.gnu.org/licenses/>
*/

package org.opencps.dossiermgt.search;

import java.sql.Date;

import javax.portlet.PortletRequest;

import com.liferay.portal.kernel.dao.search.DisplayTerms;
import com.liferay.portal.kernel.util.ParamUtil;


public class DossierDisplayTerms extends DisplayTerms {
	public static final String DOSSIER_DOSSIERID = "dossierId";
	public static final String DOSSIER_SUBJECTNAME = "subjectName";
	public static final String DOSSIER_SERVICEINFONAME = "serviceInfoName";
	public static final String DOSSIER_UUID = "uuid";
	public static final String DOSSIER_RECEIVEDATETIME = "receiveDatetime";
	public static final String DOSSIER_GOVAGENCYNAME = "govAgencyName";
	public static final String DOSSIER_RECEPTIONNO = "receptionNo";
	public static final String DOSSIER_DOSSIERSTATUS = "dossierStatus";
	public static final String DOSSIER_DOMAINCODE= "domainCode";
	public static final String DOSSIER_ADMINISTRATIONCODE = "administrationCode";
	
	public static final String COMPANY_ID = "companyId";
	public static final String CREATE_DATE = "createDate";
	public static final String GROUP_ID = "groupId";
	public static final String MODIFIED_DATE = "modifiedDate";
	public static final String SERVICE_MODE = "serviceMode";
	public static final String COUNTER = "counter";
	public static final String RECEPTION_NO = "receptionNo";
	public static final String DOSSIER_STATUS = "dossierStatus";
	public static final String DOSSIER_SOURCE = "dossierSource";
	public static final String DOSSIER_ID = "dossierId";
	public static final String OWNERORGANIZATION_ID = "ownerOrganizationId";
	public static final String SERVICE_CONFIG_ID = "serviceConfigId";
	public static final String SERVICE_INFO_ID = "serviceInfoId";
	public static final String DOSSIER_TEMPLATE_ID = "dossierTemplateId";
	public static final String TEMPLATE_FILE_NO = "templateFileNo";
	public static final String GOVAGENCY_ORGANIZATION_ID =
	    "govAgencyOrganizationId";
	public static final String SUBJECT_ID = "subjectId";
	public static final String EXTERNALREF_NO = "externalRefNo";
	public static final String EXTERNALREF_URL = "externalRefUrl";
	public static final String SERVICE_DOMAIN_INDEX = "serviceDomainIndex";
	public static final String SERVICE_ADMINISTRATION_INDEX =
	    "serviceAdministrationIndex";
	public static final String GOVAGENCY_CODE = "govAgencyCode";
	public static final String GOVAGENCY_NAME = "govAgencyName";
	public static final String SUBJECT_NAME = "subjectName";
	public static final String ADDRESS = "address";
	public static final String CITY_CODE = "cityCode";
	public static final String CITY_NAME = "cityName";
	public static final String CITY_ID = "cityId";
	public static final String DISTRICT_CODE = "districtCode";
	public static final String DISTRICT_NAME = "districtName";
	public static final String DISTRICT_ID = "districtId";
	public static final String WARD_CODE = "wardCode";
	public static final String WARD_NAME = "wardName";
	public static final String WARD_ID = "wardId";
	public static final String CONTACT_NAME = "contactName";
	public static final String CONTACT_TEL_NO = "contactTelNo";
	public static final String CONTACT_EMAIL = "contactEmail";
	public static final String NOTE = "note";
	public static final String SUBMIT_DATETIME = "submitDatetime";
	public static final String RECEIVE_DATETIME = "receiveDatetime";
	public static final String ESTIMATE_DATETIME = "estimateDatetime";
	public static final String FINISH_DATETIME = "finishDatetime";
	public static final String SERVICE_NAME = "serviceName";
	public static final String SERVICE_NO = "serviceNo";
	public static final String ACCOUNT_TYPE = "accountType";

	public static final String USER_ID = "userId";

	
    public DossierDisplayTerms(PortletRequest portletRequest) {

	    super(portletRequest);
	    dossierId = ParamUtil.getLong(portletRequest, DOSSIER_DOSSIERID);
	    subjectName = ParamUtil.getString(portletRequest, DOSSIER_SUBJECTNAME);
	    
	    serviceInfoName = ParamUtil.getString(portletRequest, DOSSIER_SERVICEINFONAME);
	    govAgencyName = ParamUtil.getString(portletRequest, DOSSIER_GOVAGENCYNAME);
    }

    protected String subjectName;
    
    public String getSubjectName() {
    
    	return subjectName;
    }
	
    public void setSubjectName(String subjectName) {
    
    	this.subjectName = subjectName;
    }
	
    public Date getReceiveDatetime() {
    
    	return receiveDatetime;
    }
	
    public void setReceiveDatetime(Date receiveDatetime) {
    
    	this.receiveDatetime = receiveDatetime;
    }
	
    public String getServiceInfoName() {
    
    	return serviceInfoName;
    }
	
    public void setServiceInfoName(String serviceInfoName) {
    
    	this.serviceInfoName = serviceInfoName;
    }
    
    protected long dossierId;
	
    public long getDossierId() {
    
    	return dossierId;
    }

	
    public void setDossierId(long dossierId) {
    
    	this.dossierId = dossierId;
    }

	protected Date receiveDatetime;
    protected String serviceInfoName;
    protected String uuid_;
    protected String govAgencyName;
    protected String receptionNo;
    protected int dossierStatus;


	
    public String getUuid_() {
    
    	return uuid_;
    }

	
    public void setUuid_(String uuid_) {
    
    	this.uuid_ = uuid_;
    }

	
    public String getGovAgencyName() {
    
    	return govAgencyName;
    }

	
    public void setGovAgencyName(String govAgencyName) {
    
    	this.govAgencyName = govAgencyName;
    }

	
    public String getReceptionNo() {
    
    	return receptionNo;
    }

	
    public void setReceptionNo(String receptionNo) {
    
    	this.receptionNo = receptionNo;
    }

	
    public int getDossierStatus() {
    
    	return dossierStatus;
    }

	
    public void setDossierStatus(int dossierStatus) {
    
    	this.dossierStatus = dossierStatus;
    }
}
