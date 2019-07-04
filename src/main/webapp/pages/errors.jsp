<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true"%>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="PORTAL-WEBAPP - Error">

  <title>Portal WebApp Error</title>

  <!-- Bootstrap Material Design CSS -->
  <link href="libs/bootstrap-material-design_4.0.0/css/bootstrap-material-design.min.css" rel="stylesheet">
  <!-- Font Awesome icons -->
  <link href="libs/fontawesome-5.2.0/css/solid.min.css" rel="stylesheet">
  <link href="libs/fontawesome-5.2.0/css/fontawesome.min.css" rel="stylesheet">
  <!-- Custom styles -->
  
  <link href="assets/css/login.css" rel="stylesheet">
  <link href="assets/css/manager.css" rel="stylesheet">
</head>

<body class="app-login">
  <section class="login-block">
    <div class="container">
      <div class="row">
        <div class="col-sm-9 col-md-4 col-lg-4 mx-auto login-sec">
          <div class="app-icon d-block mx-auto">
            <i class="fa fa-globe"></i>
          </div>
          <div class="app-name text-center">Portal WebApp</div>
          <form class="app-error-form" role="form" action="samlsso" method="post" autocomplete="off">
            <div class="alert alert-danger" id="server-error-code">
              <span>An error has occurred&nbsp;</span><%=exception.getMessage()%>
              </div>
              <a href="https://localhost.com:8446/webportal/index.jsp"> Go to Login page </a>
          </form>
        </div>
      </div>
    </div>
    <div class="text-muted text-center login-footer">
      <span>Sample Application. </span>
      <span>Copyright &copy; &nbsp;<span class="year">2019</span>
      </span>
    </div>
  </section>
</body>

</html>
