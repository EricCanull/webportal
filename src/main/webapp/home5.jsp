<%@page import="com.google.inject.internal.ImmutableMap"%>
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
<%@ page import="org.wso2.carbon.identity.sso.agent.bean.LoggedInSessionBean" %>
<%@ page import="org.wso2.carbon.identity.sso.agent.util.SSOAgentConstants" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="edu.portal.webportal.agent.CommonUtil"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@ page import="org.wso2.samples.claims.manager.ClaimManagerProxy"%>

<%!
  String subjectId = null;
  String fullname = "";
  String thumbnail = "";
  String firstname = "";
  String role = "";
  final String SAML_SSO_URL = "samlsso";
  final String SAML_LOGOUT_URL = "logout";
  String samlResponse = "";

%>

<%

  // if web-browser session is there but no session bean set,
  // invalidate session and direct back to login page
  JSONObject requestObject = new JSONObject();
  requestObject.append("requestEndpoint", request.getRequestURI());
  if (request.getSession(false) != null
          && request.getSession(false).getAttribute(SSOAgentConstants.SESSION_BEAN_NAME) == null) {

    request.getSession().invalidate();
%>
<script>
  location.href = <%=SAML_SSO_URL%>;
</script>
<%
    return;
  }

  LoggedInSessionBean sessionBean = (LoggedInSessionBean) session.getAttribute(SSOAgentConstants.SESSION_BEAN_NAME);

  // final Map<String, String> attributeValueMap = new HashMap<>();
  // attributeValueMap.put("fullname", "Eric Canull");
  final Map<String, String> attributeValueMap = sessionBean.getSAML2SSO().getSubjectAttributes();

  ClaimManagerProxy claimManagerProxy = (ClaimManagerProxy) application.getAttribute("claimManagerProxyInstance");

  final Map<String, String> attributeDisplayValueMap
          = claimManagerProxy.getLocalClaimUriDisplayValueMapping(new ArrayList<>(attributeValueMap.keySet()));

  if (!attributeValueMap.isEmpty()) {
    fullname = attributeDisplayValueMap.containsKey("attribute-fullname") ? (String) attributeValueMap.get("attribute-fullname") : fullname;
    firstname = attributeDisplayValueMap.containsKey("attribute-firstname") ? (String) attributeValueMap.get("attribute-firstname") : firstname;
    role = attributeDisplayValueMap.containsKey("attribute-role") ? (String) attributeValueMap.get("attribute-role") : role;
    thumbnail = attributeDisplayValueMap.containsKey("attribute-thumbnail") ? URLDecoder.decode((String) attributeValueMap.get("attribute-thumbnail"), "UTF-8") : thumbnail;
  }

  if (sessionBean != null && sessionBean.getSAML2SSO() != null) {
    subjectId = sessionBean.getSAML2SSO().getSubjectId();
    samlResponse = CommonUtil.marshall(sessionBean.getSAML2SSO().getSAMLResponse());
    samlResponse = StringEscapeUtils.escapeXml(samlResponse);
  } else {
%>
<script>
  location.href = <%=SAML_SSO_URL%>;
</script>
<%
    return;
  }
%>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="University WebPortal">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>JagWire Portal | Main view</title>
    <link rel="icon" href="favicon.ico" type="image/x-icon">

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="font-awesome/css/font-awesome.css" rel="stylesheet">
    <link href="libs/fontawesome-5.2.0/css/solid.min.css" rel="stylesheet">
    <link href="libs/fontawesome-5.2.0/css/fontawesome.min.css" rel="stylesheet">

    <!-- Custom styles -->
    <link href="css/home.css?v=2" rel="stylesheet">

    <link href="css/animate.css?v=1" rel="stylesheet">
    <link href="css/style.css?v=2" rel="stylesheet">
    <link href="css/custom.css?v=3" rel="stylesheet">
    <link href="css/bootstrap-better-nav.min.css" rel="stylesheet">
    <!--<link href="css/tamusa.css?v=2" rel="stylesheet">-->


    <link href="css/plugins/codemirror/codemirror.css" rel="stylesheet">

  </head>

  <body>
    <section class="d-flex flex-column justify-content-between" id="hero">
      <div id="hero-top">
        <nav class="navbar navbar-light navbar-expand-lg fixed-top d-lg-flex">
          <div class="container-fluid"><a class="navbar-brand" href="#"></a>
            <button class="navbar-toggler" data-toggle="collapse" data-target="#navcol-1">
              <span class="sr-only">Toggle navigation</span>
              <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse"
                 id="navcol-1">
              <ul class="nav navbar-nav mx-auto">
                <li class="nav-item" role="presentation"><a class="nav-link active" href="#">Home</a></li>
                  <% if (role.equalsIgnoreCase("ALUMNI") || role.equalsIgnoreCase("STUDENT")) { %>
                <li class="nav-item" role="presentation"><a class="nav-link" href="#">Classes & Registration</a></li>
                <li class="nav-item" role="presentation"><a class="nav-link" href="#">Paying for Collage</a></li>
                <li class="nav-item" role="presentation"><a class="nav-link" href="#">Student Services</a></li>
                <% } if (role.equalsIgnoreCase("FACULTY")) { %>
                <li class="nav-item" role="presentation"><a class="nav-link" href="#">Faculty</a></li>
                <% } if (role.equalsIgnoreCase("FACULTY") || role.equalsIgnoreCase("EMPLOYEE")) { %>
                <li class="nav-item" role="presentation"><a class="nav-link" href="#">Employee</a></li>
                <% } if (role.equalsIgnoreCase("Health Services")) { %>
                <li class="nav-item" role="presentation"><a class="nav-link" href="#">Health Services</a></li>
                <% } %>
              </ul>
              <ul class="nav navbar-nav">
                <li>
                <div class="dropdown img">
                  <% if (thumbnail.equalsIgnoreCase("")) { %>
                  <i class="fa fa-user-circle" style="font-size: 28px; color: #22999a;"></i>
                  <% } else {%>
                  <img alt="image" class="rounded-circle" width="38px" src="<%=thumbnail%>" />
                  <% }%>
                </div>
                </li>
                <li class="nav-item">
                  <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                    <span class="block m-t-xs font-bold"><%=fullname%></span>
                    <span class="text-muted text-xs block"><%=role%></span>
                  </a>
                </li>
                  <ul class="dropdown-menu animated fadeInRight m-t-xs">
                    <li><a class="dropdown-item" href="#">Profile</a></li>
                    <li><a class="dropdown-item" href="#">Contacts</a></li>
                    <li><a class="dropdown-item" href="https://outlook.office.com/owa/?realm=jaguar.tamu.edu">Email</a></li>
                    <li><a class="dropdown-item" href="https://tamusa.blackboard.com/webapps/bb-auth-provider-cas-bb_bb60/execute/casLogin?cmd=login&authProviderId=_105_1&redirectUrl=https%3A%2F%2Ftamusa.blackboard.com%2Fwebapps%2Fportal%2Fframeset.jsp">BlackBoard</a></li>
                      <% if (role.equalsIgnoreCase("Staff") || role.equalsIgnoreCase("Employee") || role.equalsIgnoreCase("Faculty")) { %>
                    <li><a class="dropdown-item" href="https://outlook.office.com/owa/?realm=tamusa.edu">Email</a></li>
                      <% }%>
                    <li class="dropdown-divider"></li>
                    <li><a class="nav-link" id="toggleView" href="#" data-toggle="tooltip" data-placement="bottom" title="Console">
                        <i class="fa fa-tasks"></i></a></li>
                    <li class="dropdown-divider"></li>
                    <li><a class="dropdown-item" href="<%=SAML_LOGOUT_URL%>">Logout</a></li>
                  </ul>
              </ul>
            </div>
          </div>
        </nav>
      </div>

      <div id="page-wrapper" class="gray-bg">
        <div class="row wrapper border-bottom white-bg page-heading">
          <div class="col-lg-10">
            <h2>Home</h2>
            <ol class="breadcrumb">
              <li class="breadcrumb-item">
                <a href="index.html">Home Community</a>
              </li>
              <li class="breadcrumb-item active">
                <strong>Home</strong>
              </li>
            </ol>
          </div>
          <div class="col-lg-2"></div>
        </div>
        
        <div class="wrapper wrapper-content  animated fadeInRight">
          <div class="row">
            <div class="col-md-6">
              <h2>Welcome <%=firstname%></h2>
              <small>You have 42 messages and 6 notifications.</small>
            </div>
            <div class="col-lg-6">
              <div class="ibox ">
                <div class="ibox-title">
                  <h5>User Attributes</h5>
                </div>
                <div class="ibox-content">
                  <% if (!attributeValueMap.isEmpty()) { %>
                  <div class="table-responsive">
                    <table class="table table-bordered">
                      <thead>
                        <tr>
                          <th>Attribute</th>
                          <th>Value</th>
                        </tr>
                      </thead>
                      <tbody>
                        <% for (String attribute : attributeDisplayValueMap.keySet()) { %>
                        <tr>
                          <% if (attributeDisplayValueMap.containsKey(attribute)) {%>
                          <td><%=attributeDisplayValueMap.get(attribute)%> </td>
                          <% } else {%>
                          <td><%=attribute%></td>
                          <% }%>
                          <td><%=attributeValueMap.get(attribute).toString()%></td>
                        </tr>
                        <% } %>
                      </tbody>
                    </table>
                  </div>
                  <% } else { %>
                  <p align="center">No user details Available. Configure SP Claim Configurations.</p>
                  <% }%>
                </div>
              </div>
            </div>
            <div class="col-lg-12">
              <div class="ibox ">
                <div class="ibox-title">
                  <h5>SAML Response</h5>
                </div>
                <div class="ibox-content">
                  <textarea class="code"><%=samlResponse%></textarea>
                </div>
              </div>
            </div>

   
                <div class="footer">
                  <div class="pull-right"></div>
                  <div>
                    <span class="footer-date">&copy&nbsp;2009-</span><span id="footer-year"></span>
                    <a href="http://www.tamusa.edu" style="color:#676a6c;" target="_blank" rel="noopener" 
                       title="Texas A&M University San Antonio Website">Texas A&amp;M University - San Antonio</a>
                  </div>
                </div>
                <script>
                  // in-lieu of document.write()
                  var d = document.getElementById("footer-year");
                  d.innerHTML = new Date().getFullYear().toString();
                </script>
          </div>
        </div>
      </div>

    </section>


          <!-- Mainly scripts -->
          <script src="js/jquery-3.1.1.min.js"></script>
          <script src="js/popper.min.js"></script>
          <script src="js/bootstrap.min.js"></script>
          <script src="js/plugins/metisMenu/jquery.metisMenu.js"></script>
          <script src="js/plugins/slimscroll/jquery.slimscroll.min.js"></script>

          <!-- Custom and plugin javascript -->
          <script src="js/inspinia.js"></script>
          <script src="js/plugins/pace/pace.min.js"></script>

          <script src="js/plugins/codemirror/codemirror.js"></script>
          <script src="js/plugins/codemirror/mode/xml/xml.js"></script>

          <!-- Touch Punch - Touch Event Support for jQuery UI -->
          <!--<script src="js/plugins/touchpunch/jquery.ui.touch-punch.min.js"></script>-->

          <script src="js/bootstrap-better-nav.min.js"></script>
          <!-- Golden Layout -->
          <!--<script src="libs/goldenlayout/js/goldenlayout.min.js"></script>-->

          <!-- Highlight -->
          <!--<script src="libs/highlight_9.12.0/highlight.pack.js"></script>-->
          <!-- Clipboard -->
          <!--<script src="libs/clipboard/clipboard.min.js"></script>-->

          <!-- Custom js -->
          <script src="js/custom.js?v=1"></script>

          <!-- js-cookie https://github.com/js-cookie/js-cookie -->
          <script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>

          </body>
          </html>
