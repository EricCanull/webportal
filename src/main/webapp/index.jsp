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
    
<%@ page import="edu.portal.webportal.oauth2.OAuth2Constants" %>
<%@ page import="java.util.Properties" %>
<%@ page import="edu.portal.webportal.agent.ServletContextListener" %>

<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="PORTAL-WEBAPP - Login">

    <title>Portal WebApp Login</title>
    <link rel="icon" href="favicon.ico" type="image/x-icon">

    <!-- Bootstrap Material Design CSS -->
    <link href="libs/bootstrap-material-design_4.0.0/css/bootstrap-material-design.min.css" rel="stylesheet">
    <!-- Font Awesome icons -->
    <link href="libs/fontawesome-5.2.0/css/solid.min.css" rel="stylesheet">
    <link href="libs/fontawesome-5.2.0/css/fontawesome.min.css" rel="stylesheet">
    <!-- Custom styles -->
    <link href="assets/css/login.css?v=1" rel="stylesheet">
    <link href="assets/css/manager.css?v=1" rel="stylesheet">
</head>

<%
    if (request.getSession(false) != null) {
        request.getSession(false).invalidate();
    }
%>

<body class="app-login">
<section class="login-block">
    <div class="container">
        <div class="row">
            <div class="col-sm-9 col-md-4 col-lg-4 mx-auto login-sec">
                <div class="app-icon d-block mx-auto">
                    <i class="fa fa-globe"></i>
                </div>
                <div class="app-name text-center">Portal WebApp</div>
                <form class="app-login-form" role="form" action="samlsso" method="post"  autocomplete="off">
                    <input type="submit" id="btn-login" class="btn btn-login" value="LOGIN">
                </form>
            </div>
        </div>
    </div>
    <div class="text-muted text-center login-footer">
        <span></span>
        <span>Copyright  &copy; &nbsp;<span class="year">2019</span>
        </span>
    </div>
</section>

<!-- JQuery -->
<script src="libs/jquery_3.3.1/jquery.min.js"></script>
<!-- Popper -->
<script src="assets/js/popper.min.js"></script>
<!-- Bootstrap Material Design JavaScript -->
<script src="libs/bootstrap-material-design_4.0.0/js/bootstrap-material-design.min.js"></script>


</body>
</html>
