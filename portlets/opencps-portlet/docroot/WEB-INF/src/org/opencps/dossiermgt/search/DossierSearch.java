package org.opencps.dossiermgt.search;

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

import java.util.ArrayList;
import java.util.List;

import javax.portlet.PortletRequest;
import javax.portlet.PortletURL;

import org.opencps.dossiermgt.model.Dossier;

import com.liferay.portal.kernel.dao.search.SearchContainer;


public class DossierSearch extends SearchContainer<Dossier>{
	public static final String EMPTY_RESULTS_MESSAGE =
				    "no-dossier-were-found";
	static List<String> headerNames = new ArrayList<String>();
	static {
		headerNames.add("row-no");
		headerNames.add("uuid");
		headerNames.add("subject-name");
		headerNames.add("serviceinfo-name");
		headerNames.add("govagency-name");
		headerNames.add("receive-datetime");
		headerNames.add("reception-no");
		headerNames.add("dossier-status");
		headerNames.add("action");
	}

	/**
	 * @param portletRequest
	 * @param delta
	 * @param iteratorURL
	 */
	public DossierSearch(
	    PortletRequest portletRequest, int delta, PortletURL iteratorURL) {
		
		super(portletRequest, new DossierDisplayTerms(portletRequest), new DossierSearchTerms(
		    portletRequest), DEFAULT_CUR_PARAM, delta, iteratorURL, headerNames, EMPTY_RESULTS_MESSAGE);

	}
}

