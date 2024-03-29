<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html>
<!--
~   Copyright (c) 2018 WSO2 Inc. (http://wso2.com) All Rights Reserved.
~
~   Licensed under the Apache License, Version 2.0 (the "License");
~   you may not use this file except in compliance with the License.
~   You may obtain a copy of the License at
~
~        http://www.apache.org/licenses/LICENSE-2.0
~
~   Unless required by applicable law or agreed to in writing, software
~   distributed under the License is distributed on an "AS IS" BASIS,
~   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
~   See the License for the specific language governing permissions and
~   limitations under the License.
-->
<%@ page import="org.apache.oltu.oauth2.client.request.OAuthClientRequest" %>
<%@ page import="org.apache.oltu.oauth2.common.exception.OAuthSystemException" %>
<%@ page import="edu.portal.webportal.agent.OAuth2Constants" %>
<%@ page import="edu.portal.webportal.agent.ServletContextListener" %>
<%@ page import="java.util.Properties" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    
    Properties properties;
    properties = ServletContextListener.getProperties();
    
    String consumerKey = properties.getProperty("consumerKey");
    String authzEndpoint = properties.getProperty("authzEndpoint");
    String authzGrantType = properties.getProperty("authzGrantType");
    String scope = properties.getProperty("scope");
    String callBackUrl = properties.getProperty("callBackUrl");
    String OIDC_LOGOUT_ENDPOINT = properties.getProperty("OIDC_LOGOUT_ENDPOINT");
    String sessionIFrameEndpoint = properties.getProperty("sessionIFrameEndpoint");
    
    session.setAttribute(OAuth2Constants.OAUTH2_GRANT_TYPE, authzGrantType);
    session.setAttribute(OAuth2Constants.CONSUMER_KEY, consumerKey);
    session.setAttribute(OAuth2Constants.SCOPE, scope);
    session.setAttribute(OAuth2Constants.CALL_BACK_URL, callBackUrl);
    session.setAttribute(OAuth2Constants.OAUTH2_AUTHZ_ENDPOINT, authzEndpoint);
    session.setAttribute(OAuth2Constants.OIDC_LOGOUT_ENDPOINT, OIDC_LOGOUT_ENDPOINT);
    session.setAttribute(OAuth2Constants.OIDC_SESSION_IFRAME_ENDPOINT, sessionIFrameEndpoint);
    
    OAuthClientRequest.AuthenticationRequestBuilder oAuthAuthenticationRequestBuilder = new
            OAuthClientRequest.AuthenticationRequestBuilder(authzEndpoint);
    
    oAuthAuthenticationRequestBuilder
            .setClientId(consumerKey)
            .setRedirectURI((String) session.getAttribute(OAuth2Constants.CALL_BACK_URL))
            .setResponseType(authzGrantType)
            .setScope(scope);
    
    // Build the new response mode with form post.
    OAuthClientRequest authzRequest;
    try {
        authzRequest = oAuthAuthenticationRequestBuilder.buildQueryMessage();
        response.sendRedirect(authzRequest.getLocationUri());
        return;
    } catch (OAuthSystemException e) {
%>

<script type="text/javascript">
    window.location = "index.jsp";
</script>

<%
    }
%>
