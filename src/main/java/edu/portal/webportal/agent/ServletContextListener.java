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

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContextEvent;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.wso2.carbon.identity.sso.agent.bean.LoggedInSessionBean;
import org.wso2.carbon.identity.sso.agent.util.SSOAgentConstants;
import org.wso2.samples.claims.manager.ClaimManagerProxy;

public class ServletContextListener extends HttpServlet implements javax.servlet.ServletContextListener {

    private final static Logger LOG = Logger.getLogger(ServletContextListener.class.getName());

    private static Properties properties;
    private String subjectId = null;
    private String fullname = "";
    private String thumbnail = "";
    private String firstname = "";
    private String role = "";
    private LoggedInSessionBean sessionBean;
    private ClaimManagerProxy claimManagerProxy;
    private Map<String, String> attributeValueMap;
    private Map<String, String> attributeDisplayValueMap;
    private String[] attributeArray;

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
    public void doGet(HttpServletRequest request, HttpServletResponse response) {

        response.setContentType("text/html");
        try (PrintWriter out = response.getWriter()) {
            String n = request.getParameter("userName");
            out.print("Welcome " + n);

            HttpSession session = request.getSession();

            sessionBean = (LoggedInSessionBean) session.getAttribute(SSOAgentConstants.SESSION_BEAN_NAME);

            attributeValueMap = sessionBean.getSAML2SSO().getSubjectAttributes();

            claimManagerProxy = (ClaimManagerProxy) session.getAttribute("claimManagerProxyInstance");

            attributeDisplayValueMap
                    = claimManagerProxy.getLocalClaimUriDisplayValueMapping(new ArrayList<>(attributeValueMap.keySet()));

            if (!attributeValueMap.isEmpty()) {
                fullname = attributeDisplayValueMap.containsKey("http://wso2.org/claims/fullname")
                        ? (String) attributeValueMap.get("http://wso2.org/claims/fullname") : fullname;
                firstname = attributeDisplayValueMap.containsKey("http://wso2.org/claims/firstname")
                        ? (String) attributeValueMap.get("http://wso2.org/claims/firstname") : firstname;
                role = attributeDisplayValueMap.containsKey("http://wso2.org/claims/role")
                        ? (String) attributeValueMap.get("http://wso2.org/claims/role") : role;
                thumbnail = attributeDisplayValueMap.containsKey("http://wso2.org/claims/thumbnail")
                        ? URLDecoder.decode((String) attributeValueMap.get("http://wso2.org/claims/thumbnail"), "UTF-8") : thumbnail;
            }

            session.setAttribute("uname", n);

            out.print("<a href='servlet2'>visit</a>");

        } catch (IOException e) {
            System.out.println(e);
        }
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
