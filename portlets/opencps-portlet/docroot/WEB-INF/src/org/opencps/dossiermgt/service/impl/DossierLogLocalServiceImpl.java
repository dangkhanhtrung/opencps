
/*******************************************************************************
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
 *******************************************************************************/


package org.opencps.dossiermgt.service.impl;

import java.util.Date;
import java.util.List;

import org.opencps.dossiermgt.NoSuchDossierException;
import org.opencps.dossiermgt.model.DossierLog;
import org.opencps.dossiermgt.service.base.DossierLogLocalServiceBaseImpl;

import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.util.OrderByComparator;
import com.liferay.portal.service.ServiceContext;

/**
 * The implementation of the dossier log local service.
 *
 * <p>
 * All custom service methods should be put in this class. Whenever methods are added, rerun ServiceBuilder to copy their definitions into the {@link org.opencps.dossiermgt.service.DossierLogLocalService} interface.
 *
 * <p>
 * This is a local service. Methods of this service will not have security checks based on the propagated JAAS credentials because this service can only be accessed from within the same VM.
 * </p>
 *
 * @author trungnt
 * @see org.opencps.dossiermgt.service.base.DossierLogLocalServiceBaseImpl
 * @see org.opencps.dossiermgt.service.DossierLogLocalServiceUtil
 */
public class DossierLogLocalServiceImpl extends DossierLogLocalServiceBaseImpl {
	/*
	 * NOTE FOR DEVELOPERS:
	 *
	 * Never reference this interface directly. Always use {@link org.opencps.dossiermgt.service.DossierLogLocalServiceUtil} to access the dossier log local service.
	 */
	
	public DossierLog addDossierLog(
		    long userId, long groupId, long companyId, long dossierId,
		    long fileGroupId, int status, String actionInfo, String messageInfo,
		    Date updateDatetime, int level)
		    throws SystemException {

			long dossierLogId = counterLocalService
			    .increment(DossierLog.class
			        .getName());
			DossierLog dossierLog = dossierLogPersistence
			    .create(dossierLogId);

			dossierLog
			    .setGroupId(groupId);
			dossierLog
			    .setCompanyId(companyId);

			Date now = new Date();

			dossierLog
			    .setUserId(userId);

			dossierLog
			    .setModifiedDate(now);

			dossierLog
			    .setDossierId(dossierId);
			dossierLog
			    .setFileGroupId(fileGroupId);
			dossierLog
			    .setDossierStatus(status);
			dossierLog
			    .setActionInfo(actionInfo);
			dossierLog
			    .setMessageInfo(messageInfo);
			dossierLog
			    .setUpdateDatetime(updateDatetime);
			dossierLog
			    .setLevel(level);

			return dossierLogPersistence
			    .update(dossierLog);

		}

		public DossierLog addDossierLog(
		    long userId, long dossierId, long fileGroupId, int status,
		    String actionInfo, String messageInfo, Date updateDatetime, int level,
		    ServiceContext serviceContext)
		    throws SystemException {

			long dossierLogId = counterLocalService
			    .increment(DossierLog.class
			        .getName());
			DossierLog dossierLog = dossierLogPersistence
			    .create(dossierLogId);
			Date now = new Date();

			dossierLog
			    .setUserId(userId);
			dossierLog
			    .setGroupId(serviceContext
			        .getScopeGroupId());
			dossierLog
			    .setCompanyId(serviceContext
			        .getCompanyId());
			dossierLog
			    .setCreateDate(now);
			dossierLog
			    .setModifiedDate(now);

			dossierLog
			    .setDossierId(dossierId);
			dossierLog
			    .setFileGroupId(fileGroupId);
			dossierLog
			    .setDossierStatus(status);
			dossierLog
			    .setActionInfo(actionInfo);
			dossierLog
			    .setMessageInfo(messageInfo);
			dossierLog
			    .setUpdateDatetime(updateDatetime);
			dossierLog
			    .setLevel(level);

			return dossierLogPersistence
			    .update(dossierLog);

		}

		public List<DossierLog> findByF_Level_All(long groupId)
					    throws SystemException {

						return dossierLogPersistence
						    .findByF_Level_All(groupId);
					}
		public List<DossierLog> findByF_Level_Warring_Error(long groupId)
					    throws SystemException {

						return dossierLogPersistence
						    .findByF_Level_Warring_Error(groupId);
					}
	
	/**
	 * <p>
	 * Tìm kiếm lịch sử xử lý hồ sơ theo mã hồ sơ
	 * </p>
	 * 
	 * @param dossierId
	 *            là mã hồ sơ
	 * @return trả về danh sách các lịch sử thao tác hồ sơ
	 * @throws SystemException
	 *             Nếu ngoại lệ hệ thống xảy ra
	 * @throws NoSuchDossierLogException
	 *             Khi xảy ra lỗi không tìm thấy Dossier
	 */
	public List<DossierLog> getDossierLogByDossierId(long dossierId, int start, int end, OrderByComparator orderByComparator)
			throws NoSuchDossierException, SystemException {
		return dossierLogPersistence.findByDossierId(dossierId, start, end, orderByComparator);
	}

	/**
	 * <p>
	 * Đếm số lượng các lịch sử hồ sơ theo mã hồ sơ
	 * </p>
	 * 
	 * @param dossierId
	 *            là mã hồ sơ
	 * @return trả về số lượng các hồ sơ lịch sử của hồ sơ
	 * @throws SystemException
	 *             Nếu ngoại lệ hệ thống xảy ra
	 */
	public int countDossierLogByDossierId(long dossierId) throws SystemException {
		return dossierLogPersistence.countByDossierId(dossierId);
	}
	
	/**
	 * <p>
	 * Tìm kiếm lịch sử xử lý hồ sơ theo mã hồ sơ
	 * </p>
	 * 
	 * @param dossierId
	 *            là mã hồ sơ
	 * @param levels
	 * @return trả về danh sách các lịch sử thao tác hồ sơ
	 * @throws SystemException
	 *             Nếu ngoại lệ hệ thống xảy ra
	 * @throws NoSuchDossierLogException
	 *             Khi xảy ra lỗi không tìm thấy Dossier
	 */
	public List<DossierLog> getDossierLogByDossierAndLevels(long dossierId, int[] levels, int start, int end, OrderByComparator orderByComparator)
			throws NoSuchDossierException, SystemException {
		return dossierLogPersistence.findByDossierAndLevel(dossierId, levels, start, end, orderByComparator);
	}

	/**
	 * <p>
	 * Đếm số lượng các lịch sử hồ sơ theo mã hồ sơ
	 * </p>
	 * 
	 * @param dossierId
	 *            là mã hồ sơ
	 * @param levels
	 * @return trả về số lượng các hồ sơ lịch sử của hồ sơ
	 * @throws SystemException
	 *             Nếu ngoại lệ hệ thống xảy ra
	 */
	public int countDossierLogByDossierAndLevels(long dossierId, int[] levels) throws SystemException {
		return dossierLogPersistence.countByDossierAndLevel(dossierId, levels);
	}

	/**
	 * <p>
	 * Tìm kiếm lịch sử xử lý hồ sơ theo mã hồ sơ
	 * </p>
	 * 
	 * @param levels
	 * @return trả về danh sách các lịch sử thao tác hồ sơ
	 * @throws SystemException
	 *             Nếu ngoại lệ hệ thống xảy ra
	 * @throws NoSuchDossierLogException
	 *             Khi xảy ra lỗi không tìm thấy Dossier
	 */
	public List<DossierLog> getDossierLogByLevels(int[] levels, int start, int end, OrderByComparator orderByComparator)
			throws NoSuchDossierException, SystemException {
		return dossierLogPersistence.findByLevel(levels, start, end, orderByComparator);
	}

	/**
	 * <p>
	 * Đếm số lượng các lịch sử hồ sơ theo mã hồ sơ
	 * </p>
	 * 
	 * @param levels
	 * @return trả về số lượng các hồ sơ lịch sử của hồ sơ
	 * @throws SystemException
	 *             Nếu ngoại lệ hệ thống xảy ra
	 */
	public int countDossierLogByLevels(int[] levels) throws SystemException {
		return dossierLogPersistence.countByLevel(levels);
	}
	
}