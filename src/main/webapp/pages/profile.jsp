<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html>

<%@page import="edu.portal.webportal.attributes.ClaimManagerProxy"%>

<%
    ClaimManagerProxy claimManagerProxy = (ClaimManagerProxy) session.getAttribute("claimManagerProxy");

%>

<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>profile</title>
    <link rel="stylesheet" href="../assets/bootstrap/css/bootstrap.min.css?v=2">
    <link rel="stylesheet" href="../assets/css/style.css?v=2">
    <link rel="stylesheet" href="../assets/css/Profile-Edit-Form.css?v=2">

  </head>

  <body>
    <div class="container profile profile-view" id="profile">
      <div class="row">
        <div class="col-md-12 alert-col relative">
          <div class="alert alert-info absolue center" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span></button><span>Profile save with success</span></div>
        </div>
      </div>
      <div class="form-row profile-row">
        <div class="col-md-3 text-center relative" id="avatar-col">
          <div class="avatar" style="text-align: center;">
            <div class="avatar-bg center" style="background-image: url(<%=claimManagerProxy.getThumbnail()%>);"></div>
          </div>
          <input type="button" id="changePhotoButton" value="Change Photo" onclick="document.getElementById('file').click();" />
          <input type="file" style="display:none;" id="file" name="file" accept="image/*"/>
          <div class="form-row">
            <div class="card-header" role="tab">
              <h5 class="mb-0"><a class="toggle">Basic Info</a></h5>
            </div>
          </div>
          <div class="form-row">
            <div class="card-header" role="tab">
              <h5 class="mb-0"><a class="toggle">Security Questions</a></h5>
            </div>
          </div>
          <div class="form-row">
            <div class="card-header" role="tab">
              <h5 class="mb-0"><a class="toggle">Reset Password</a></h5>
            </div>              
          </div>
        </div>
        <div class="col-md-9">
          <h1>Profile</h1>
          <hr>

          <div class="panel">
            <form>
              <div class="card">
                <div class="card-body">
                  <div class="form-row">
                    <div class="col-sm-12 col-md-6">
                      <div class="form-group"><label>Firstname </label><input class="form-control" value="<%=claimManagerProxy.getFirstName()%>" type="text" name="firstname" readonly=""></div>
                    </div>
                    <div class="col-sm-12 col-md-6">
                      <div class="form-group"><label>Lastname </label><input class="form-control" value="<%=claimManagerProxy.getLastName()%>" type="text" name="lastname" readonly=""></div>
                    </div>
                  </div>
                  <div class="form-row">
                    <div class="col-sm-12 col-md-6">
                      <div class="form-group"><label>Phone #</label><input class="form-control" value="<%=claimManagerProxy.getPhoneNumber()%>" type="text" name="phonenumber" inputmode="tel"></div>
                    </div>
                    <div class="col-sm-12 col-md-6">
                      <div class="form-group"><label>Birthday</label><input class="form-control" value="<%=claimManagerProxy.getBirthday()%>" type="text" name="lastname" readonly=""></div>
                    </div>
                  </div>
                  <div class="form-group"><label>Email </label><input class="form-control" value="<%=claimManagerProxy.getWorkEmailAddress()%>" type="email" autocomplete="off" required="" name="email" disabled=""></div>
                  <div class="form-group"><label>Personal Email</label><input class="form-control" value="<%=claimManagerProxy.getPersonalEmailAddress()%>" type="email" autocomplete="off" required="" name="email"></div>
                  <div class="form-row">
                    <div class="col-md-12 content-right">
                      <button class="btn btn-primary form-btn" type="submit">SAVE </button>
                      <button class="btn btn-danger bg-secondary form-btn" id="cancel-button" type="button">CANCEL</button></div>
                  </div>
                  <br>
                </div>
              </div>
            </form>
          </div>

          <div class="panel">
            <form>
              <div class="card">
                <div class="card-body">
                  <label>City where you were born?</label><input class="form-control" type="text">
                  <label>Model of your first car?</label><input class="form-control" type="text">
                  <br>
                  <div class="form-row">
                    <div class="col-md-12 content-right">
                      <button class="btn btn-primary form-btn" type="submit">SUBMIT </button>
                    </div>
                    <br>
                  </div>
                </div>
              </div>
            </form>
          </div>

          <div class="panel">
            <form>
              <div class="card">
                <div class="card-body">
                  <label>Current Password</label><input class="form-control" id="currentPassword" name="CURRENT_PWD" type="password" tabindex="0" autocomplete="off" required>
                  <label>New Password</label><input class="form-control" id="newPassword" name="NEW_PWD" type="password" autocomplete="off" required>
                  <label>Confirm Password</label><input class="form-control" id="repeatPassword" name="NEW_PWD_CONFIRMATION" type="password" autocomplete="off" data-match="newPassword" required="">
                  <br>
                  <div class="form-row">
                    <div class="col-md-12 content-right">
                      <button class="btn btn-primary form-btn" type="submit">SUBMIT </button>
                    </div>
                    <br>
                  </div>
                </div>
            </form>
          </div>
        </div>

      </div>

      <script>
        var tog = document.getElementsByClassName("toggle");
        var pan = document.getElementsByClassName("panel");
 
        var firstToggle =  tog[0];
        var secondToggle = tog[1];
        var thirdToggle = tog[2];
        var firstPanel = pan[0];
        firstToggle.classList.add("active");
        firstPanel.style.display = "block";
        firstPanel.style.maxHeight = firstPanel.scrollHeight + "px";
        
        firstToggle.onclick = function() {
          changeAction(firstToggle, 0);
        };
        secondToggle.onclick = function() {
          changeAction(secondToggle, 1);
        };

        thirdToggle.onclick = function() {
          changeAction(thirdToggle, 2);
        };
          
         function changeAction(toggle, active) {
              // For toggling purposes detect if the clicked section is already "active"
              var isActive = toggle.classList.contains("active");

              // Close all accordions
              var allToggles = document.getElementsByClassName("toggle");
              var allPanels = document.getElementsByClassName("panel");
              for (j = 0; j < allToggles.length; j++) {
                // Remove active class from section header
                allToggles[j].classList.remove("active");

                // Remove the max-height class from the panel to close it
                var panel = allPanels[j];
                var maxHeightValue = getStyle(panel, "maxHeight");

              if (maxHeightValue !== "0px") {
                  panel.style.maxHeight = null;
                  panel.style.display = "none";
                }
              }

              // Toggle the clicked section using a ternary operator
              isActive ? toggle.classList.remove("active") : toggle.classList.add("active");

              // Toggle the panel element
              var panel = allPanels[active];
              var maxHeightValue = getStyle(panel, "maxHeight");

              if (maxHeightValue !== "0px") {
                panel.style.maxHeight = null;
              } else {
                panel.style.display = "block";
                panel.style.maxHeight = panel.scrollHeight + "px";
              }
            };
         
        // Cross-browser way to get the computed height of a certain element. Credit to @CMS on StackOverflow (http://stackoverflow.com/a/2531934/7926565)
        function getStyle(el, styleProp) {
          var value, defaultView = (el.ownerDocument || document).defaultView;
          // W3C standard way:
          if (defaultView && defaultView.getComputedStyle) {
            // sanitize property name to css notation
            // (hypen separated words eg. font-Size)
            styleProp = styleProp.replace(/([A-Z])/g, "-$1").toLowerCase();
            return defaultView.getComputedStyle(el, null).getPropertyValue(styleProp);
          } else if (el.currentStyle) { // IE
            // sanitize property name to camelCase
            styleProp = styleProp.replace(/\-(\w)/g, function (str, letter) {
              return letter.toUpperCase();
            });
            value = el.currentStyle[styleProp];
            // convert other units to pixels on IE
            if (/^\d+(em|pt|%|ex)?$/i.test(value)) {
              return (function (value) {
                var oldLeft = el.style.left, oldRsLeft = el.runtimeStyle.left;
                el.runtimeStyle.left = el.currentStyle.left;
                el.style.left = value || 0;
                value = el.style.pixelLeft + "px";
                el.style.left = oldLeft;
                el.runtimeStyle.left = oldRsLeft;
                return value;
              })(value);
            }
            return value;
          }
        }
      </script>
      <script src="../assets/js/jquery-3.4.1.min.js"></script>
      <script src="../assets/bootstrap/js/bootstrap.min.js"></script>
      <script src="../assets/js/Profile-Edit-Form.js"></script>
  </body>

</html>
