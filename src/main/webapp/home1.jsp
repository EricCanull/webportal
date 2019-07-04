<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html>
<html>

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>JagWire Portal | Main view</title>

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="font-awesome/css/font-awesome.css" rel="stylesheet">

    <link href="css/animate.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">

  </head>

  <body>

    <div id="wrapper">

      <nav class="navbar-default navbar-static-side" role="navigation">
        <div class="sidebar-collapse">
          <ul class="nav metismenu" id="side-menu">
            <li class="nav-header">
              <div class="dropdown profile-element">
                <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                  <span class="block m-t-xs font-bold">Example user</span>
                  <span class="text-muted text-xs block">menu <b class="caret"></b></span>
                </a>
                <ul class="dropdown-menu animated fadeInRight m-t-xs">
                  <li><a class="dropdown-item" href="profile.html">Profile</a></li>
                  <li><a class="dropdown-item" href="contacts.html">Contacts</a></li>
                  <li><a class="dropdown-item" href="mailbox.html">Mailbox</a></li>
                  <li class="dropdown-divider"></li>
                  <li><a class="dropdown-item" href="javascript:jagwireLogout(escape(' /cas/logout'))">Logout</a></li>
                </ul>
              </li>
          </ul>
        </div>
        <div class="logo-element">
          A&amp;M
        </div>
        <ul>
          <li class="active">
            <a href="index.html"><i class="fa fa-th-large"></i> <span class="nav-label">Home</span></a>
          </li>
          <li>
            <a href="minor.html"><i class="fa fa-th-large"></i> <span class="nav-label">Classes &amp; Registration</span> </a>
          </li>
          <li>
            <a href="minor.html"><i class="fa fa-th-large"></i> <span class="nav-label">Paying For College</span> </a>
          </li>
          <li>
            <a href="minor.html"><i class="fa fa-th-large"></i> <span class="nav-label">Student Services</span> </a>
          </li>
          <li>
            <a href="minor.html"><i class="fa fa-th-large"></i> <span class="nav-label">Employee</span> </a>
          </li>
          <li>
            <a href="minor.html"><i class="fa fa-th-large"></i> <span class="nav-label">Health Services</span> </a>
          </li>
        </ul>
      </nav>

    </div>

    <div id="page-wrapper" class="gray-bg">
      <div class="row border-bottom">
        <nav class="navbar navbar-static-top white-bg" role="navigation" style="margin-bottom: 0">
          <div class="navbar-header">
            <a class="navbar-minimalize minimalize-styl-2 btn btn-primary " href="#"><i class="fa fa-bars"></i> </a>
            <form role="search" class="navbar-form-custom" method="post" action="#">
              <div class="form-group">
                <input type="text" placeholder="Search for something..." class="form-control" name="top-search" id="top-search">
              </div>
            </form>
          </div>
          <ul class="nav navbar-top-links navbar-right">
            <li>
              <a href="#">
                <i class="fa fa-sign-out"></i> Log out
              </a>
            </li>
          </ul>

        </nav>
      </div>
      <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
          <div class="col-lg-12">
            <div class="text-center m-t-lg">
              <h1>
              </h1>
              <small>

              </small>
            </div>
          </div>
        </div>
      </div>
      <div class="footer">
        <div class="pull-right">
        </div>
        <div>
          <span class="footer-date">&copy&nbsp;2009-</span><span id="footer-year"></span>
          <strong>

          </strong>
        </div>
        <script>
          // in-lieu of document.write()
          var d = document.getElementById("footer-year");
          d.innerHTML = new Date().getFullYear().toString();
        </script>
      </div>

    </div>

    <!-- Mainly scripts -->
    <script src="js/jquery-3.1.1.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/plugins/metisMenu/jquery.metisMenu.js"></script>
    <script src="js/plugins/slimscroll/jquery.slimscroll.min.js"></script>

    <!-- Custom and plugin javascript -->
    <script src="js/inspinia.js"></script>
    <script src="js/plugins/pace/pace.min.js"></script>

    <!-- Custom portal javascript -->
    <script src="js/jagwire/portal.integration.js"></script>

  </body>

</html>
