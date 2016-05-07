
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

import org.opencps.dossiermgt.NoSuchDossierException;
import org.opencps.dossiermgt.NoSuchDossierStatusException;
import org.opencps.dossiermgt.model.DossierStatus;
import org.opencps.dossiermgt.model.impl.DossierStatusModelImpl;
import org.opencps.dossiermgt.service.base.DossierStatusLocalServiceBaseImpl;

import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.util.OrderByComparatorFactoryUtil;

/**
 * The implementation of the dossier status local service.
 *
 * <p>
 * All custom service methods should be put in this class. Whenever methods are added, rerun ServiceBuilder to copy their definitions into the {@link org.opencps.dossiermgt.service.DossierStatusLocalService} interface.
 *
 * <p>
 * This is a local service. Methods of this service will not have security checks based on the propagated JAAS credentials because this service can only be accessed from within the same VM.
 * </p>
 *
 * @author trungnt
 * @see org.opencps.dossiermgt.service.base.DossierStatusLocalServiceBaseImpl
 * @see org.opencps.dossiermgt.service.DossierStatusLocalServiceUtil
 */
public class DossierStatusLocalServiceImpl
	extends DossierStatusLocalServiceBaseImpl {
	/*
	 * NOTE FOR DEVELOPERS:
	 *
	 * Never reference this interface directly. Always use {@link org.opencps.dossiermgt.service.DossierStatusLocalServiceUtil} to access the dossier status local service.
	 */
	
	/**
	 * <p>
	 * Lấy về thông tin một trạng thái hồ sơ mới cập nhật của hồ sơ
	 * </p>
	 * 
	 * @param dossierId
	 *            là mã hồ sơ
	 * @return trả về đối tượng trạng thái hồ sơ mới nhất của một hồ sơ
	 * @throws SystemException
	 *             Nếu ngoại lệ hệ thống xảy ra
	 * @throws NoSuchDossierStatusException
	 *             Khi xảy ra lỗi không tìm thấy DossierStatus
	 */
	public DossierStatus getNewestStatusUpdated(long dossierId) throws SystemException, NoSuchDossierStatusException {
		return dossierStatusPersistence.fetchByDossierId_First(dossierId, OrderByComparatorFactoryUtil.create(DossierStatusModelImpl.TABLE_NAME, "updateDatetime", "desc"));
	}
}