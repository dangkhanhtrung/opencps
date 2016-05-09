package org.opencps.dossiermgt.search;

import java.sql.Date;

import javax.portlet.PortletRequest;

import com.liferay.portal.kernel.util.ParamUtil;


public class DossierNewDoneSearchTerms extends DossierDisplayTerms {
    public DossierNewDoneSearchTerms(PortletRequest portletRequest) {
	    super(portletRequest);
	    dossierId = ParamUtil.getLong(portletRequest, DOSSIER_DOSSIERID);
	    subjectName = ParamUtil.getString(portletRequest, DOSSIER_SUBJECTNAME);
	    serviceInfoName = ParamUtil.getString(portletRequest, DOSSIER_SERVICEINFONAME);
    }

	protected long dossierId;
	protected String subjectName;
	protected String serviceInfoName;
	
    public long getDossierId() {
    
    	return dossierId;
    }
	
    public void setDossierId(long dossierId) {
    
    	this.dossierId = dossierId;
    }
	
    public String getSubjectName() {
    
    	return subjectName;
    }
	
    public void setSubjectName(String subjectName) {
    
    	this.subjectName = subjectName;
    }
	
    public String getServiceInfoName() {
    
    	return serviceInfoName;
    }
	
    public void setServiceInfoName(String serviceInfoName) {
    
    	this.serviceInfoName = serviceInfoName;
    }
	
    public Date getReceiveDatetime() {
    
    	return receiveDatetime;
    }
	
    public void setReceiveDatetime(Date receiveDatetime) {
    
    	this.receiveDatetime = receiveDatetime;
    }

	protected Date receiveDatetime;
}