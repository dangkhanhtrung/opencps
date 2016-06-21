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

package org.opencps.dossiermgt.service.persistence;

import java.sql.Timestamp;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.opencps.dossiermgt.model.DossierLog;
import org.opencps.dossiermgt.model.impl.DossierLogImpl;

import com.liferay.portal.kernel.dao.orm.QueryPos;
import com.liferay.portal.kernel.dao.orm.QueryUtil;
import com.liferay.portal.kernel.dao.orm.SQLQuery;
import com.liferay.portal.kernel.dao.orm.Session;
import com.liferay.portal.kernel.dao.orm.Type;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.util.CalendarUtil;
import com.liferay.portal.kernel.util.StringPool;
import com.liferay.portal.kernel.util.StringUtil;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.service.persistence.impl.BasePersistenceImpl;
import com.liferay.util.dao.orm.CustomSQLUtil;

/**
 * @author trungnt
 */
public class DossierLogFinderImpl extends BasePersistenceImpl<DossierLog>
    implements DossierLogFinder {

	public static final String FIND_REQUIRED_PROCESS_DOSSIER =
	    DossierLogFinder.class
	        .getName() + ".findRequiredProcessDossier";
	
	public static final String SEARCH_ADMIN_LOG = 
		DossierLogFinder.class.getName() + ".searchAdminLog";
	
	public static final String COUNT_ADMIN_LOG = 
					DossierLogFinder.class.getName() + ".countAdminLog";
	
	public List<DossierLog> searchAdminLog (Date fromUpdateDatetime , 
		Date toUpdateDatetime, int level, String dossierStatus, int start, int end) {
		
		String[] keywords = null;
		boolean andOperator = false;
		if (Validator
			.isNotNull(dossierStatus)) {
			keywords = CustomSQLUtil
				.keywords(dossierStatus);
		}
		else {
			andOperator = true;
		}
		
		return searchAdminLog(fromUpdateDatetime, toUpdateDatetime, level, keywords,
			start, end, andOperator);
		
	}
	//search Log for Admin
	private List<DossierLog> searchAdminLog (Date fromUpdateDatetime , 
		Date toUpdateDatetime, int level, String [] dossierStatus, int start, int end, boolean andOperator) {
		Session session = null;
		Timestamp fromUpdateTime_TS = CalendarUtil.getTimestamp(fromUpdateDatetime); 
		Timestamp toUpdateTime_TS = CalendarUtil.getTimestamp(toUpdateDatetime); 
		try {
			 
			session = openSession();
			 String sql = CustomSQLUtil.get(SEARCH_ADMIN_LOG);
			 if(dossierStatus == null || dossierStatus.length == 0) {
				 sql = StringUtil.replace(sql, 
					 "AND (lower(opencps_dossier_log.dossierStatus) LIKE ? [$AND_OR_NULL_CHECK$])",
					 StringPool.BLANK);
			 } else {
				 sql = CustomSQLUtil.replaceKeywords(sql, 
					 "lower(opencps_dossier_log.dossierStatus)", StringPool.LIKE,
					 true, dossierStatus);
			 }
			 
			 if(Validator.isNull(fromUpdateDatetime) || Validator.isNull(toUpdateDatetime)) {
				 sql = StringUtil.replace(sql, 
					 "AND opencps_dossier_log.updateDatetime BETWEEN  ? AND ?",
					 StringPool.BLANK);
			 } 
			 
			 if(level == -1) {
				 sql = StringUtil.replace(sql, 
					 "AND opencps_dossier_log.level = ?", StringPool.BLANK);
			 }
			 
			 sql = CustomSQLUtil
								.replaceAndOperator(sql, andOperator);
			 
			 SQLQuery q = session.createSQLQuery(sql);
			 q.setCacheable(false);
			 q.addEntity("DossierLog", DossierLogImpl.class);

			 QueryPos qPos = QueryPos
			    .getInstance(q);
			
			 if(level != -1) {
				 qPos.add(level);
			 }
			 
			 if(Validator.isNotNull(fromUpdateDatetime) && Validator.isNotNull(fromUpdateDatetime)) {
				 qPos.add(fromUpdateTime_TS);
				 qPos.add(toUpdateTime_TS);
			 }
			 
			 if(dossierStatus != null && dossierStatus.length > 0) {
				 qPos
					.add(dossierStatus,2);
				return (List<DossierLog>) QueryUtil
								.list(q, getDialect(), start, end);
			 }
		 }
		catch (Exception e) {
			_log.error(e);
		} finally {
			closeSession(session);
		}
		
		return null;
	}
	
	public int countAdminLog(Date fromUpdateDatetime , 
		Date toUpdateDatetime, int level, String dossierStatus) {
		String[] keywords = null;
		boolean andOperator = false;
		if (Validator
			.isNotNull(dossierStatus)) {
			keywords = CustomSQLUtil
				.keywords(dossierStatus);
		}
		else {
			andOperator = true;
		}
		
		return countAdminLog(fromUpdateDatetime, toUpdateDatetime, level, keywords, andOperator);
	}
	//count log for admin 
	private int countAdminLog(Date fromUpdateDatetime , 
		Date toUpdateDatetime, int level, String [] dossierStatus, boolean andOperator) {
		Timestamp fromUpdateTime_TS = CalendarUtil.getTimestamp(fromUpdateDatetime); 
		Timestamp toUpdateTime_TS = CalendarUtil.getTimestamp(toUpdateDatetime); 
		Session session = null;
		 try {
			session = openSession();
			 String sql = CustomSQLUtil.get(COUNT_ADMIN_LOG);
			 if(dossierStatus == null || dossierStatus.length == 0) {
				 sql = StringUtil.replace(sql, 
					 "AND (lower(opencps_dossier_log.dossierStatus) LIKE ? [$AND_OR_NULL_CHECK$])",
					 StringPool.BLANK);
			 } else {
				 sql = CustomSQLUtil.replaceKeywords(sql, 
					 "lower(opencps_dossier_log.dossierStatus)", StringPool.LIKE,
					 true, dossierStatus);
			 }
			 
			 if(Validator.isNull(fromUpdateDatetime) || Validator.isNull(toUpdateDatetime)) {
				 sql = StringUtil.replace(sql, 
					 "AND opencps_dossier_log.updateDatetime BETWEEN  ? AND ?",
					 StringPool.BLANK);
			 } 
			 
			 if(level == -1) {
				 sql = StringUtil.replace(sql, 
					 "AND opencps_dossier_log.level = ?", StringPool.BLANK);
			 }
			 
			 sql = CustomSQLUtil
								.replaceAndOperator(sql, andOperator);
			 
			 SQLQuery q = session.createSQLQuery(sql);
			 
			 q.setCacheable(false);
			 q.addScalar(COUNT_COLUMN_NAME, Type.INTEGER);

			 QueryPos qPos = QueryPos
			    .getInstance(q);
			 
			 if(level != -1) {
				 qPos.add(level);
			 }
			 
			 if(Validator.isNotNull(fromUpdateDatetime) && Validator.isNotNull(fromUpdateDatetime)) {
				 qPos.add(fromUpdateTime_TS);
				 qPos.add(toUpdateTime_TS);
			 }
			 
			 if(dossierStatus != null && dossierStatus.length > 0) {
				 qPos
					.add(dossierStatus,2);
				Iterator<Integer> itr = q.iterate();
							if (itr
								.hasNext()) {
								Integer count = itr
									.next();

								if (count != null) {
									return count
										.intValue();
								}
							}

							return 0;
			 }
		 }
		catch (Exception e) {
			_log.error(e);
		} finally {
			closeSession(session);
		}
		return 0;
	}

	public List<DossierLog> findRequiredProcessDossier(
	    long dossierId, String[] actors, String[] requestCommands) {

		Session session = null;

		try {
			session = openSession();

			String sql = CustomSQLUtil
			    .get(FIND_REQUIRED_PROCESS_DOSSIER);

			if (actors == null || actors.length == 0) {
				sql = StringUtil
				    .replace(
				        sql, "AND opencps_dossier_log.actor IN(?)",
				        StringPool.BLANK);

			}

			if (requestCommands == null || requestCommands.length == 0) {
				sql = StringUtil
				    .replace(
				        sql, "AND opencps_dossier_log.requestCommand IN(?)",
				        StringPool.BLANK);

			}

			SQLQuery q = session
			    .createSQLQuery(sql);

			q
			    .addEntity("DossierLog", DossierLogImpl.class);

			QueryPos qPos = QueryPos
			    .getInstance(q);

			qPos
			    .add(dossierId);

			if (actors != null && actors.length > 0) {
				qPos
				    .add(StringUtil
				        .merge(actors));

			}
			if (requestCommands != null && requestCommands.length > 0) {
				qPos
				    .add(StringUtil
				        .merge(requestCommands));

			}

			return (List<DossierLog>) QueryUtil
			    .list(q, getDialect(), QueryUtil.ALL_POS, QueryUtil.ALL_POS);
		}
		catch (Exception e) {
			_log
			    .error(e);
		}
		finally {
			closeSession(session);
		}

		return null;
	}

	private Log _log = LogFactoryUtil
	    .getLog(DossierLogFinder.class
	        .getName());
}
