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
<%@ page import="edu.portal.webportal.attributes.ClaimManagerProxy"%>

<%!
  String subjectId = null;
  String fullname = "";
  String thumbnail = "";
  String firstname = "";
  String role = "Student";
  final String SAML_SSO_URL = "samlsso";
  final String SAML_LOGOUT_URL = "logout";
  String samlResponse = "";
  String[] attributeArray;

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
//  AttributeRequestor attributeRequestor = new AttributeRequestor();
//  attributeArray = attributeRequestor.getRequestedAttributes();
  LoggedInSessionBean sessionBean = (LoggedInSessionBean) session.getAttribute(SSOAgentConstants.SESSION_BEAN_NAME);

//   final Map<String, String> attributeValueMap = new HashMap<>();

  final Map<String, String> attributeValueMap = sessionBean.getSAML2SSO().getSubjectAttributes();
//   attributeValueMap.put("fullname", "Eric Canull");
  ClaimManagerProxy claimManagerProxy = (ClaimManagerProxy) application.getAttribute("claimManagerProxyInstance");

  final Map<String, String> attributeDisplayValueMap
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

<html lang="en">

  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="University WebPortal">
    <meta http-equiv="Default-Style" content="light-theme">
    <title>JagWire Portal | Main view</title>
    <link rel="icon" href="favicon.ico" type="image/x-icon">
    

<!--    <script src="assets/js/plugins/pace/pace.min.js"></script>-->
    <!--<link rel="stylesheet" href="assets/css/plugins/pace/pace-theme-mac-osx-motion.css?v=1">-->

    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:300,400,600">
    <link rel="stylesheet" href="https://unpkg.com/@bootstrapstudio/bootstrap-better-nav/dist/bootstrap-better-nav.min.css">
    <link rel="stylesheet" href="assets/css/animate.css">
    <link rel="stylesheet" href="assets/css/style.css?v=2">
    <link rel="stylesheet" href="assets/css/theme.css?v=2">
    <link rel="stylesheet" title="light-theme" href="assets/css/light-theme.css?v=1">
    <link rel="alternate stylesheet" title="dark-theme" href="assets/css/dark-theme.css?v=1">

    <link rel="stylesheet" href="assets/font-awesome/css/font-awesome.css">
    <link rel="stylesheet" href="libs/fontawesome-5.2.0/css/solid.min.css">
    <link rel="stylesheet" href="libs/fontawesome-5.2.0/css/fontawesome.min.css">
    <link rel="stylesheet" href="assets/css/plugins/codemirror/codemirror.css" >
  </head>

  <body>
  

    <section class="main-section d-flex flex-column justify-content-between">

      <div class="nav-header">
        <nav class="navbar-custom navbar navbar-fixed-top navbar-dark navbar-expand-lg">
          <div class="container-fluid">
<!--            <div class="navbar-brand-circle">-->
              <a class="navbar-brand" href="#" style="background-image: url(&quot;assets/img/jaghead.png&quot;);"></a>
            <!--</div>-->
            <button class="navbar-toggler navbar-dark float-right" data-toggle="collapse" data-target="#navcol-1">
              <span class="sr-only">Toggle navigation</span>
              <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navcol-1">
              <ul class="nav navbar-nav mx-auto">
                <li class="nav-item" role="presentation"><a class="nav-link active" href="#">Home</a></li>
                  <% if (role.equalsIgnoreCase("ALUMNI") || role.equalsIgnoreCase("STUDENT")) { %>
                <li class="nav-item" role="presentation"><a class="nav-link" href="#">Classes & Registration</a></li>
                <li class="nav-item" role="presentation"><a class="nav-link" href="#">Paying for College</a></li>
                <li class="nav-item" role="presentation"><a class="nav-link" href="#">Student Services</a></li>
                  <% }
                    if (role.equalsIgnoreCase("FACULTY")) { %>
                <li class="nav-item" role="presentation"><a class="nav-link" href="#">Faculty</a></li>
                  <% }
                    if (role.equalsIgnoreCase("FACULTY") || role.equalsIgnoreCase("EMPLOYEE")) { %>
                <li class="nav-item" role="presentation"><a class="nav-link" href="#">Employee</a></li>
                  <% }
                    if (role.equalsIgnoreCase("Health Services")) { %>
                <li class="nav-item" role="presentation"><a class="nav-link" href="#">Health Services</a></li>
                  <% } %>
              </ul>
            </div>
              
          <div class="overlay" id="profile-overlay"></div>
          <div data-role="popup" id="popup-profile" data-overlay-theme="b" data-theme="a" data-tolerance="15,15" class="ui-content">
            <iframe src="includes/profile.jsp" width="820" height="580" seamless=""></iframe>
          </div>
  
            
          <!-- Right Sidebar -->
          <div class="right-bar" id="right-sidebar">
            <div class="rightbar-title">
              <a href="javascript:void(0);" id="sidebar-close-button" class="right-bar-toggle float-right">
                <i class="fa fa-close"></i>
              </a>
              <h5 class="m-0">Settings</h5>
            </div>

            <div class="slimscroll-menu rightbar-content">

              <div class="p-1">
<!--                <div class="alert alert-primary" role="alert">
                  <strong>Customize </strong> the overall color scheme, layout, sidebar menu, etc. Preferences are stored in local storage cache.
                </div>-->
              </div>

              <!-- Settings -->
              <h5 class="pl-2">Color Scheme</h5>
              <hr class="mb-0" />

              <div class="p-2">
                <div class="custom-control custom-switch mb-1">
                  <input type="radio" class="custom-control-input" name="color-scheme-mode" value="light" id="light-mode-check" onclick="toggleLightTheme()" checked />
                  <label class="custom-control-label" for="light-mode-check">Light Mode</label>
                </div>

                <div class="custom-control custom-switch mb-1">
                  <input type="radio" class="custom-control-input" name="color-scheme-mode" value="dark" id="dark-mode-check" onclick="toggleDarkTheme()"  />
                  <label class="custom-control-label" for="dark-mode-check">Dark Mode</label>
                </div>
              </div>

              <h5 class="pl-2">Layout</h5>
              <hr class="mb-0" />

              <div class="p-2">
                <div class="custom-control custom-switch mb-1">
                  <input type="radio" class="custom-control-input" name="layout" value="vertical" id="vertical-check" checked />
                  <label class="custom-control-label" for="vertical-check">Vertical Layout (Default)</label>
                </div>

                <div class="custom-control custom-switch mb-1">
                  <input type="radio" class="custom-control-input" name="layout" value="horizontal" id="horizontal-check" />
                  <label class="custom-control-label" for="horizontal-check">Horizontal Layout</label>
                </div>

                <div class="custom-control custom-switch mb-1">
                  <input type="radio" class="custom-control-input" name="layout" value="detached" id="detached-check" />
                  <label class="custom-control-label" for="detached-check">Detached Layout</label>
                </div>
              </div>

              <h5 class="pl-2">Width</h5>
              <hr class="mb-0" />
              <div class="p-2">
                <div class="custom-control custom-switch mb-1">
                  <input type="radio" class="custom-control-input" name="width" value="fluid" id="fluid-check" checked />
                  <label class="custom-control-label" for="fluid-check">Fluid</label>
                </div>
                <div class="custom-control custom-switch mb-1">
                  <input type="radio" class="custom-control-input" name="width" value="boxed" id="boxed-check" />
                  <label class="custom-control-label" for="boxed-check">Boxed</label>
                </div>
              </div>

              <h5 class="pl-2">Left Sidebar</h5>
              <hr class="mb-0" />

              <div class="p-2">
                <div class="custom-control custom-switch mb-1">
                  <input type="radio" class="custom-control-input" name="theme" value="default" id="default-check" checked />
                  <label class="custom-control-label" for="default-check">Default</label>
                </div>

                <div class="custom-control custom-switch mb-1">
                  <input type="radio" class="custom-control-input" name="theme" value="light" id="light-check" />
                  <label class="custom-control-label" for="light-check">Light</label>
                </div>

                <div class="custom-control custom-switch mb-3">
                  <input type="radio" class="custom-control-input" name="theme" value="dark" id="dark-check" />
                  <label class="custom-control-label" for="dark-check">Dark</label>
                </div>

                <div class="custom-control custom-switch mb-1">
                  <input type="radio" class="custom-control-input" name="compact" value="fixed" id="fixed-check" checked />
                  <label class="custom-control-label" for="fixed-check">Fixed</label>
                </div>

                <div class="custom-control custom-switch mb-1">
                  <input type="radio" class="custom-control-input" name="compact" value="condensed" id="condensed-check" />
                  <label class="custom-control-label" for="condensed-check">Condensed</label>
                </div>

                <div class="custom-control custom-switch mb-1">
                  <input type="radio" class="custom-control-input" name="compact" value="scrollable" id="scrollable-check" />
                  <label class="custom-control-label" for="scrollable-check">Scrollable</label>
                </div>
              </div>

              <div class="p-2 text-center">
                <button class="btn btn-primary btn-block" id="resetBtn">Reset to Default</button>
              </div>
            </div>
          </div>

          <div class="side-menu-overlay" id="right-side-menu-overlay"></div>
          <!-- /Right-bar -->

            <div class="nav-item dropdown user-dropdown">
              <a class="nav-link dropdown-toggle nav-user arrow-none mr-0" data-toggle="dropdown" href="#" role="button" aria-haspopup="false" aria-expanded="false">
                <span class="account-user-avatar">
                  <% if (thumbnail.equalsIgnoreCase("")) { %>
                  <i class="fa fa-user-circle" style="font-size: 28px; color: #22999a;"></i>
                  <% } else {%>
                  <img alt="image" class="rounded-circle" alt="user-image" width="38px" src="<%=thumbnail%>" />
                  <% }%>
                </span>
                <span>
                  <span class="account-user-name"><%=fullname%></span><br>
                  <span class="account-position"><%=role%></span>
                </span>
              </a>
              <div class="dropdown-menu animated fadeInRight m-t-xs" role="menu">
                <a class="dropdown-item" id="profile-toggle" role="presentation" href="#">Profile</a>
                <a class="dropdown-item" href="https://tamusa.blackboard.com/webapps/bb-auth-provider-cas-bb_bb60/execute/casLogin?cmd=login&authProviderId=_105_1&redirectUrl=https%3A%2F%2Ftamusa.blackboard.com%2Fwebapps%2Fportal%2Fframeset.jsp">BlackBoard</a>
                <% if (role.equalsIgnoreCase("ALUMNI") || role.equalsIgnoreCase("STUDENT")) { %>
                <a class="dropdown-item" role="presentation" href="https://outlook.office.com/owa/?realm=jaguar.tamu.edu">Email</a>
                <% }
                  if (role.equalsIgnoreCase("FACULTY") || role.equalsIgnoreCase("EMPLOYEE")) { %>
                <a class="dropdown-item" role="presentation" href="https://outlook.office.com/owa/?realm=tamusa.edu">Email</a>
                <% }%>
                <div class="dropdown-divider"></div>

                <a class="dropdown-item right-bar-toggle" id="settings-toggle" href="javascript: void(0);" data-toggle="tooltip" data-placement="bottom" title="Settings">
                  <i class="fa fa-tasks"></i><span>&nbsp;Settings</span></a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="<%=SAML_LOGOUT_URL%>">Logout</a>
              </div>
            </div>
          </div>
        </nav>
      </div>

      <div class="breadcrumb-wrapper gray-bg">  
        <div class="breadcrumb-grid">
          <div class="breadcrumb-left">
            <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="javascript: void(0);">Home Community</a></li>
              <li class="breadcrumb-item active">Home</li>
            </ol>
          </div>
        </div>
      </div>


      <div class="wrapper wrapper-content gray-bg animated fadeInRight">
        <div class="row" id="sortable-view">
          <div class="col-lg-9">
            <div class="ibox ">
              <div class="ibox-title">
                <h5>Campus Events & Activities</h5>
                <div class="ibox-tools">
                  <a class="collapse-link">
                    <i class="fa fa-chevron-up"></i>
                  </a>
                  <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                    <i class="fa fa-wrench"></i>
                  </a>
                  <ul class="dropdown-menu dropdown-user">
                    <li><a href="#" class="dropdown-item">Config option 1</a>
                    </li>
                    <li><a href="#" class="dropdown-item">Config option 2</a>
                    </li>
                  </ul>
                  <a class="close-link">
                    <i class="fa fa-times"></i>
                  </a>
                </div>
              </div>
              <div class="ibox-content">
                <div><iframe alt="" border="0" bordercolor="#000000" frameborder="0" height="315" hspace="0" id="_48_INSTANCE_NvFW811taWgU_iframe" longdesc="" name="_48_INSTANCE_NvFW811taWgU_iframe" scrolling="auto" src="https://tamusa.campuslabs.com/engage/opportunityboard" title="" vspace="0" width="100%" style="height: 315px;"> Your browser does not support inline frames or is currently configured not to display inline frames. Content can be viewed at actual source page: https://tamusa.campuslabs.com/engage/opportunityboard. </iframe></div>
              </div>
            </div>
                        
            <div class="ibox">
              <div class="ibox-title">
                <h5>SAML Response</h5>
                <div class="ibox-tools">
                  <a class="collapse-link">
                    <i class="fa fa-chevron-up"></i>
                  </a>
                  <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                    <i class="fa fa-wrench"></i>
                  </a>
                  <ul class="dropdown-menu dropdown-user">
                    <li><a href="#" class="dropdown-item">Config option 1</a>
                    </li>
                    <li><a href="#" class="dropdown-item">Config option 2</a>
                    </li>
                  </ul>
                  <a class="close-link">
                    <i class="fa fa-times"></i>
                  </a>
                </div>
              </div>

              <div class="ibox-content">
                <div class="journal-content-article">        
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
                 <%--       <div class="attributeRequestor">
                      for(String s : attributeArray) { 
                        <p><%=s%></p>
                        <% } %>
               
                      </div>
                          --%>
                  </div>
                  <% } else { %>
                  <p align="center">No user details Available. Configure SP Claim Configurations.</p>
                  <% }%>
                 
                </div>
              </div>
            </div>

            <div class="ibox">
              <div class="ibox-title">
                <h5>SAML Response</h5>
                <div class="ibox-tools">
                  <a class="collapse-link">
                    <i class="fa fa-chevron-up"></i>
                  </a>
                  <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                    <i class="fa fa-wrench"></i>
                  </a>
                  <ul class="dropdown-menu dropdown-user">
                    <li><a href="#" class="dropdown-item">Config option 1</a>
                    </li>
                    <li><a href="#" class="dropdown-item">Config option 2</a>
                    </li>
                  </ul>
                  <a class="close-link">
                    <i class="fa fa-times"></i>
                  </a>
                </div>
              </div>
              <div class="ibox-content">
                <div class="journal-content-article">
                  <textarea class="code"><%=samlResponse%></textarea>
                </div>
              </div>
            </div>
                
          </div>
          <div class="col-lg-3">
            <div class="ibox">
              <div class="ibox-title">
                <h5>New Student Resources</h5>
                <div class="ibox-tools">
                  <a class="collapse-link">
                    <i class="fa fa-chevron-up"></i>
                  </a>
                  <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                    <i class="fa fa-wrench"></i>
                  </a>
                  <ul class="dropdown-menu dropdown-user">
                    <li><a href="#" class="dropdown-item">Config option 1</a>
                    </li>
                    <li><a href="#" class="dropdown-item">Config option 2</a>
                    </li>
                  </ul>
                  <a class="close-link">
                    <i class="fa fa-times"></i>
                  </a>
                </div>
              </div>
              <div class="ibox-content">
                <div class="journal-content-article">
                  <ul>
                    <li><a href="https://ssb-prod.ec.tamusa.edu/ssomanager/c/SSB?pkg=zwsksnso.p_redirect" target="_blank">Orientation Signup</a></li>
                    <li><a href="http://www.tamusa.edu/university-college/first-year-experience/NewStudentOrientation/index.html" target="_blank">Orientation Information</a></li>
                    <li><a href="https://www.americancampus.com/portfolio/property-details/tx/esperanza-hall/761" target="_blank">Housing</a></li>
                    <li><a href="http://www.tamusa.edu/welcomecenter/NewStudentChecklist/meningitisvaccine.html" target="_blank">Meningitis</a></li>
                    <li><a href="http://www.tamusa.edu/militaryaffairs/" target="_blank">Military Affairs</a></li>
                    <li><a href="https://tamusa.givepulse.com/sso/cas/tamusa" target="_blank">Volunteer/Service-Learning</a></li>
                    <li><a href="https://ssb-prod.ec.tamusa.edu/ssomanager/c/SSB?pkg=tamusa_everfi_sso.call_rest_webservice" target="_blank">AlcoholEDU Course</a></li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="ibox">
              <div class="ibox-title">
                <h5>Get Involved</h5>
                <div class="ibox-tools">
                  <a class="collapse-link">
                    <i class="fa fa-chevron-up"></i>
                  </a>
                  <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                    <i class="fa fa-wrench"></i>
                  </a>
                  <ul class="dropdown-menu dropdown-user">
                    <li><a href="#" class="dropdown-item">Config option 1</a>
                    </li>
                    <li><a href="#" class="dropdown-item">Config option 2</a>
                    </li>
                  </ul>
                  <a class="close-link">
                    <i class="fa fa-times"></i>
                  </a>
                </div>
              </div>
              <div class="ibox-content">
                <div class="journal-content-article">
                  <ul>
                    <li><a href="https://tamusa.campuslabs.com/engage/account/login?returnUrl=/engage/" target="_blank">JagSync</a></li>
                    <li><a href="https://tamusa.campuslabs.com/engage/account/login?returnUrl=/engage/organization/student-government-association" target="_blank">Student Government Association (SGA)</a></li>
                    <li><a href="https://tamusa.givepulse.com/sso/cas/tamusa" target="_blank">Volunteer/Service-Learning</a></li>
                    <li><a href="https://www.imleagues.com/spa/account/ssoredirect?schoolId=85063363355e4411b4eb0f6104eda7ca" target="_blank">IMLeagues</a></li>
                  </ul>
                </div>
              </div>
            </div>
            
            <div class="ibox ">
              <div class="ibox-title">
                <h5>Stay Connected</h5>
                <div class="ibox-tools">
                  <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                  <a class="dropdown-toggle" data-toggle="dropdown" href="#"><i class="fa fa-wrench"></i></a>
                  <ul class="dropdown-menu dropdown-user">
                    <li><a href="#" class="dropdown-item">Config option 1</a></li>
                    <li><a href="#" class="dropdown-item">Config option 2</a></li>
                  </ul>
                  <a class="close-link"><i class="fa fa-times"></i></a>
                </div>
              </div>
              <div class="ibox-content">
                <div class="journal-content-article">
                  <p style="text-align: center; font-family: \"Times New Roman\"; font-size: 14px;"><strong>CONNECT WITH US</strong><br /> <a href="https://www.facebook.com/TAMUSanAntonio" target="_blank" title="TAMU-SA Facebook"><img alt="Facebook" border="0" height="32" src="http://www.tamusa.tamus.edu/uploadFile/folders/maguero8887/Image/Image-635351484561141662-10.100.150.124.png" style="text-align: left; line-height: 18px; font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 14px;" width="32" /></a>&nbsp; <a href="https://twitter.com/TAMUSanAntonio" target="_blank" title="TAMU-SA Twitter"> <img alt="Twitter" border="0" height="32" src="http://www.tamusa.tamus.edu/uploadFile/folders/maguero8887/Image/Image-635351484756771670-10.100.150.124.png" style="text-align: left; line-height: 18px; font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 14px;" width="32" /></a>&nbsp; <a href="http://www.youtube.com/user/tamusavids" target="_blank" title="TAMU-SA YouTube"> <img alt="Youtube" border="0" height="32" src="http://www.tamusa.tamus.edu/uploadFile/folders/maguero8887/Image/Image-635404336972107630-10.100.150.124.png" style="text-align: left; line-height: 18px; font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 14px;" width="32" /></a></p>
                </div>
              </div>
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
                
    </section>


    <script src="assets/js/jquery-3.1.1.min.js"></script>
    <script src="assets/bootstrap/js/bootstrap.min.js"></script>
    <script src="assets/js/popper.min.js"></script>
    <script src="assets/js/plugins/metisMenu/jquery.metisMenu.js"></script>
    <script src="assets/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
    <!-- Peity -->
    <script src="assets/js/plugins/peity/jquery.peity.min.js"></script>

    <!-- Custom and plugin javascript -->
    <script src="assets/js/inspinia.js"></script>


    <!-- jquery UI -->
    <script src="assets/js/plugins/jquery-ui/jquery-ui.min.js"></script>

    <!-- Touch Punch - Touch Event Support for jQuery UI -->
    <script src="assets/js/plugins/touchpunch/jquery.ui.touch-punch.min.js"></script>

    <!-- iCheck -->
    <script src="assets/js/plugins/iCheck/icheck.min.js"></script>

    <!-- Peity d data  -->
    <script src="assets/js/demo/peity-demo.js"></script>
    <!--<script src="assets/js/app.min.js"></script>-->

    <script src="https://unpkg.com/@bootstrapstudio/bootstrap-better-nav/dist/bootstrap-better-nav.min.js"></script>

    <!-- Code Editor -->
    <script src="assets/js/plugins/codemirror/codemirror.js"></script>
    <script src="assets/js/plugins/codemirror/mode/xml/xml.js"></script>

    <!-- Custom js -->
    <script src="assets/js/custom.js?v=1"></script>
   

    </body>
  </html>
