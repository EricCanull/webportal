<%--
  ~ Copyright (c) 2016, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
  ~
  ~  WSO2 Inc. licenses this file to you under the Apache License,
  ~  Version 2.0 (the "License"); you may not use this file except
  ~  in compliance with the License.
  ~  You may obtain a copy of the License at
  ~
  ~    http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing,
  ~ software distributed under the License is distributed on an
  ~ "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
  ~ KIND, either express or implied.  See the License for the
  ~ specific language governing permissions and limitations
  ~ under the License.
  --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page isErrorPage="true" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="org.owasp.encoder.Encode" %>

    <html>
    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>JagWire Portal</title>

        <link rel="icon" href="images/favicon.png" type="image/x-icon"/>
            <link href="libs/fontawesome-5.2.0/css/solid.min.css" rel="stylesheet">
    <link href="libs/fontawesome-5.2.0/css/fontawesome.min.css" rel="stylesheet">
        <link href="./assets/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="./assets/css/Roboto.css" rel="stylesheet">
        <link href="./assets/css/custom-common.css" rel="stylesheet">

        <!--[if lt IE 9]>
        <script src="js/html5shiv.min.js"></script>
        <script src="js/respond.min.js"></script>
        <![endif]-->
    </head>

    <body>

      <nav class="navbar navbar-light navbar-expand" style="background-color: #000000;">
        <div class="container-fluid"><a class="navbar-brand d-flex d-sm-flex align-items-center align-items-sm-center" href="#"><i class="fas fa-globe" style="font-size: 40px;color: rgba(238,238,238,0.9);"></i><span style="color: rgba(249,249,249,0.9);font-size: 22px;">  Webportal</span></a>
          <button
            data-toggle="collapse" data-target="#navcol-1" class="navbar-toggler" style="background-color: rgba(38,3,3,0);"><span class="sr-only">Toggle navigation</span><span class="navbar-toggler-icon"></span></button>
        </div>
      </nav>

    <!-- page content -->
    <div class="container-fluid body-wrapper">

        <div class="row">
            <!-- content -->
            <div class="col-xs-12 col-sm-10 col-md-8 col-lg-5 col-centered wr-login">
                <div class="alert alert-danger" id="server-error-code">
                  <h4 style="color: black; font-weight: bold; margin-bottom: 0;">An error has occurred</h4>
                    <br>
                   <b><%=exception.getMessage()%></b>
                   <hr/>
                    <a href="index.jsp">Return to landing page</a>
                </div>

            </div>
        </div>
        <!-- /content/body -->

    </div>
    

    <!-- footer -->
    <footer class="footer">
        <div class="container-fluid">
            <p>&copy;
                <script>document.write(new Date().getFullYear());</script>
                <a href="http://wso2.com/" target="_blank"></a>
            </p>
        </div>
    </footer>
    </body>
    </html>
