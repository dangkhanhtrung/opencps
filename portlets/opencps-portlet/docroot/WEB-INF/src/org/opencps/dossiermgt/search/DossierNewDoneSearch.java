package org.opencps.dossiermgt.search;

import java.util.ArrayList;
import java.util.List;

import javax.portlet.PortletRequest;
import javax.portlet.PortletURL;

import org.opencps.dossiermgt.model.Dossier;

import com.liferay.portal.kernel.dao.search.SearchContainer;

public class DossierNewDoneSearch extends SearchContainer<Dossier> {
	public static final String EMPTY_RESULTS_MESSAGE =
				    "no-dossier-were-found";
	static List<String> headerNames = new ArrayList<String>();
	static {
		headerNames.add("row-no");
		headerNames.add("subject-name");
		headerNames.add("serviceinfo-name");
		headerNames.add("update-datetime");
	}

	/**
	 * @param portletRequest
	 * @param delta
	 * @param iteratorURL
	 */
	public DossierNewDoneSearch(
	    PortletRequest portletRequest, int delta, PortletURL iteratorURL) {
		
		super(portletRequest, new DossierDisplayTerms(portletRequest), new DossierNewDoneSearchTerms(
		    portletRequest), DEFAULT_CUR_PARAM, delta, iteratorURL, headerNames, EMPTY_RESULTS_MESSAGE);
	}

}
