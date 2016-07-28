/**
 * Copyright (c) 2000-present Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */

package org.opencps.api.service.base;

import com.liferay.portal.kernel.bean.BeanReference;
import com.liferay.portal.kernel.bean.IdentifiableBean;
import com.liferay.portal.kernel.dao.jdbc.SqlUpdate;
import com.liferay.portal.kernel.dao.jdbc.SqlUpdateFactoryUtil;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.service.BaseServiceImpl;
import com.liferay.portal.service.persistence.UserPersistence;

import org.opencps.api.model.ApiService;
import org.opencps.api.service.ApiServiceService;
import org.opencps.api.service.persistence.ApiServicePersistence;

import javax.sql.DataSource;

/**
 * Provides the base implementation for the api service remote service.
 *
 * <p>
 * This implementation exists only as a container for the default service methods generated by ServiceBuilder. All custom service methods should be put in {@link org.opencps.api.service.impl.ApiServiceServiceImpl}.
 * </p>
 *
 * @author trungdk
 * @see org.opencps.api.service.impl.ApiServiceServiceImpl
 * @see org.opencps.api.service.ApiServiceServiceUtil
 * @generated
 */
public abstract class ApiServiceServiceBaseImpl extends BaseServiceImpl
	implements ApiServiceService, IdentifiableBean {
	/*
	 * NOTE FOR DEVELOPERS:
	 *
	 * Never modify or reference this class directly. Always use {@link org.opencps.api.service.ApiServiceServiceUtil} to access the api service remote service.
	 */

	/**
	 * Returns the api service local service.
	 *
	 * @return the api service local service
	 */
	public org.opencps.api.service.ApiServiceLocalService getApiServiceLocalService() {
		return apiServiceLocalService;
	}

	/**
	 * Sets the api service local service.
	 *
	 * @param apiServiceLocalService the api service local service
	 */
	public void setApiServiceLocalService(
		org.opencps.api.service.ApiServiceLocalService apiServiceLocalService) {
		this.apiServiceLocalService = apiServiceLocalService;
	}

	/**
	 * Returns the api service remote service.
	 *
	 * @return the api service remote service
	 */
	public org.opencps.api.service.ApiServiceService getApiServiceService() {
		return apiServiceService;
	}

	/**
	 * Sets the api service remote service.
	 *
	 * @param apiServiceService the api service remote service
	 */
	public void setApiServiceService(
		org.opencps.api.service.ApiServiceService apiServiceService) {
		this.apiServiceService = apiServiceService;
	}

	/**
	 * Returns the api service persistence.
	 *
	 * @return the api service persistence
	 */
	public ApiServicePersistence getApiServicePersistence() {
		return apiServicePersistence;
	}

	/**
	 * Sets the api service persistence.
	 *
	 * @param apiServicePersistence the api service persistence
	 */
	public void setApiServicePersistence(
		ApiServicePersistence apiServicePersistence) {
		this.apiServicePersistence = apiServicePersistence;
	}

	/**
	 * Returns the counter local service.
	 *
	 * @return the counter local service
	 */
	public com.liferay.counter.service.CounterLocalService getCounterLocalService() {
		return counterLocalService;
	}

	/**
	 * Sets the counter local service.
	 *
	 * @param counterLocalService the counter local service
	 */
	public void setCounterLocalService(
		com.liferay.counter.service.CounterLocalService counterLocalService) {
		this.counterLocalService = counterLocalService;
	}

	/**
	 * Returns the resource local service.
	 *
	 * @return the resource local service
	 */
	public com.liferay.portal.service.ResourceLocalService getResourceLocalService() {
		return resourceLocalService;
	}

	/**
	 * Sets the resource local service.
	 *
	 * @param resourceLocalService the resource local service
	 */
	public void setResourceLocalService(
		com.liferay.portal.service.ResourceLocalService resourceLocalService) {
		this.resourceLocalService = resourceLocalService;
	}

	/**
	 * Returns the user local service.
	 *
	 * @return the user local service
	 */
	public com.liferay.portal.service.UserLocalService getUserLocalService() {
		return userLocalService;
	}

	/**
	 * Sets the user local service.
	 *
	 * @param userLocalService the user local service
	 */
	public void setUserLocalService(
		com.liferay.portal.service.UserLocalService userLocalService) {
		this.userLocalService = userLocalService;
	}

	/**
	 * Returns the user remote service.
	 *
	 * @return the user remote service
	 */
	public com.liferay.portal.service.UserService getUserService() {
		return userService;
	}

	/**
	 * Sets the user remote service.
	 *
	 * @param userService the user remote service
	 */
	public void setUserService(
		com.liferay.portal.service.UserService userService) {
		this.userService = userService;
	}

	/**
	 * Returns the user persistence.
	 *
	 * @return the user persistence
	 */
	public UserPersistence getUserPersistence() {
		return userPersistence;
	}

	/**
	 * Sets the user persistence.
	 *
	 * @param userPersistence the user persistence
	 */
	public void setUserPersistence(UserPersistence userPersistence) {
		this.userPersistence = userPersistence;
	}

	public void afterPropertiesSet() {
		Class<?> clazz = getClass();

		_classLoader = clazz.getClassLoader();
	}

	public void destroy() {
	}

	/**
	 * Returns the Spring bean ID for this bean.
	 *
	 * @return the Spring bean ID for this bean
	 */
	@Override
	public String getBeanIdentifier() {
		return _beanIdentifier;
	}

	/**
	 * Sets the Spring bean ID for this bean.
	 *
	 * @param beanIdentifier the Spring bean ID for this bean
	 */
	@Override
	public void setBeanIdentifier(String beanIdentifier) {
		_beanIdentifier = beanIdentifier;
	}

	@Override
	public Object invokeMethod(String name, String[] parameterTypes,
		Object[] arguments) throws Throwable {
		Thread currentThread = Thread.currentThread();

		ClassLoader contextClassLoader = currentThread.getContextClassLoader();

		if (contextClassLoader != _classLoader) {
			currentThread.setContextClassLoader(_classLoader);
		}

		try {
			return _clpInvoker.invokeMethod(name, parameterTypes, arguments);
		}
		finally {
			if (contextClassLoader != _classLoader) {
				currentThread.setContextClassLoader(contextClassLoader);
			}
		}
	}

	protected Class<?> getModelClass() {
		return ApiService.class;
	}

	protected String getModelClassName() {
		return ApiService.class.getName();
	}

	/**
	 * Performs an SQL query.
	 *
	 * @param sql the sql query
	 */
	protected void runSQL(String sql) throws SystemException {
		try {
			DataSource dataSource = apiServicePersistence.getDataSource();

			SqlUpdate sqlUpdate = SqlUpdateFactoryUtil.getSqlUpdate(dataSource,
					sql, new int[0]);

			sqlUpdate.update();
		}
		catch (Exception e) {
			throw new SystemException(e);
		}
	}

	@BeanReference(type = org.opencps.api.service.ApiServiceLocalService.class)
	protected org.opencps.api.service.ApiServiceLocalService apiServiceLocalService;
	@BeanReference(type = org.opencps.api.service.ApiServiceService.class)
	protected org.opencps.api.service.ApiServiceService apiServiceService;
	@BeanReference(type = ApiServicePersistence.class)
	protected ApiServicePersistence apiServicePersistence;
	@BeanReference(type = com.liferay.counter.service.CounterLocalService.class)
	protected com.liferay.counter.service.CounterLocalService counterLocalService;
	@BeanReference(type = com.liferay.portal.service.ResourceLocalService.class)
	protected com.liferay.portal.service.ResourceLocalService resourceLocalService;
	@BeanReference(type = com.liferay.portal.service.UserLocalService.class)
	protected com.liferay.portal.service.UserLocalService userLocalService;
	@BeanReference(type = com.liferay.portal.service.UserService.class)
	protected com.liferay.portal.service.UserService userService;
	@BeanReference(type = UserPersistence.class)
	protected UserPersistence userPersistence;
	private String _beanIdentifier;
	private ClassLoader _classLoader;
	private ApiServiceServiceClpInvoker _clpInvoker = new ApiServiceServiceClpInvoker();
}