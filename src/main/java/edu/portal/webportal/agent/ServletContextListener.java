/*
 * Copyright (c) 2019, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 * WSO2 Inc. licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
package edu.portal.webportal.agent;

import edu.portal.webportal.attributes.ClaimManagerProxy;
import java.io.IOException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContextEvent;

public class ServletContextListener implements javax.servlet.ServletContextListener {

    private final static Logger LOG = Logger.getLogger(ServletContextListener.class.getName());

    private static Properties properties;

    private ClaimManagerProxy claimManagerProxy;


    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {

        properties = new Properties();

        try {
            properties.load(CommonUtil.class.getClassLoader().getResourceAsStream("sso.properties"));
        } catch (IOException e) {
            LOG.log(Level.WARNING, "Error while loading properties", e);
        }

        // Obtain a claim manager instance for this application and set it to servlet context
        claimManagerProxy
                = new ClaimManagerProxy(
                        properties.getProperty("claimManagementEndpoint"),
                        properties.getProperty("adminUsername"),
                        properties.getProperty("adminPassword"));

        servletContextEvent.getServletContext().setAttribute("claimManagerProxyInstance", claimManagerProxy);
    }
    
    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {

    }

    /**
     * Get the properties of the sample
     *
     * @return Properties
     */
    public static Properties getProperties() {
        return properties;
    }
}
