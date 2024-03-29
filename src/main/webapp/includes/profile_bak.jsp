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
          <div class="alert alert-info absolue center" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">�</span></button><span>Profile save with success</span></div>
        </div>
      </div>
      <form>
        <div class="form-row profile-row">
          <div class="col-md-3 text-center relative" id="avatar-col">
            <div class="avatar" style="text-align: center;">
              <div class="avatar-bg center" style="background-image: url(<%=claimManagerProxy.getThumbnail()%>);"></div>
            </div>
            <input type="button" id="changePhotoButton" value="Change Photo" onclick="document.getElementById('file').click();" />
            <input type="file" style="display:none;" id="file" name="file" accept="image/*"/>
          </div>
          <div class="col-md-9">
            <h1>Profile </h1>
            <hr>
            <div class="form-group">
              <div role="tablist" id="accordion-1">
                <div class="card">
                  <div class="card-header" role="tab">
                    <h5 class="mb-0"><a data-toggle="collapse" aria-expanded="true" aria-controls="accordion-1 .item-1" href="div#accordion-1 .item-1">Basic Info</a></h5>
                  </div>
                  <div class="collapse item-1" role="tabpanel" data-parent="#accordion-1">
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
                </div>
              </div>
            </div>
            <div class="form-group">
              <div role="tablist" id="accordion-2">
                <div class="card">
                  <div class="card-header" role="tab">
                    <h5 class="mb-0"><a data-toggle="collapse" aria-expanded="true" aria-controls="accordion-2 .item-1" href="div#accordion-2 .item-1">Security Questions</a></h5>
                  </div>
                  <div class="collapse item-1" role="tabpanel" data-parent="#accordion-2">
                    <div class="card-body"><label>City where you were born?</label><input class="form-control" type="text"><label>Model of your first car?</label><input class="form-control" type="text"></div>
                    <div class="form-row">
                      <div class="col-md-12 content-right">
                        <button class="btn btn-primary form-btn" type="submit">SAVE </button>
                        <button class="btn btn-danger bg-secondary form-btn" id="cancel-button" type="button">CANCEL</button></div>
                    </div>
                    <br>
                  </div>
                </div>
              </div>
            </div>
            <div class="form-group">
              <div role="tablist" id="accordion-3">
                <div class="card">
                  <div class="card-header" role="tab">
                    <h5 class="mb-0"><a data-toggle="collapse" aria-expanded="true" aria-controls="accordion-3 .item-1" href="div#accordion-3 .item-1">Reset Password</a></h5>
                  </div>
                  <div class="collapse item-1" role="tabpanel" data-parent="#accordion-3">
                    <div class="card-body">
                      <label>Current Password</label><input class="form-control" type="password">
                      <label>New Password</label><input class="form-control" type="password">
                      <label>Confirm Password</label><input class="form-control" type="password">
                      <br>
                      <div class="form-row">
                        <div class="col-md-12 content-right">
                          <button class="btn btn-primary form-btn" type="submit">SAVE </button>
                          <button class="btn btn-danger bg-secondary form-btn" id="cancel-button" type="button">CANCEL</button></div>
                      </div>
                      <br>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <hr>
          </div>
        </div>
      </form>
    </div>
    <script src="../assets/js/jquery-3.4.1.min.js"></script>
    <script src="../assets/bootstrap/js/bootstrap.min.js"></script>
    <script src="../assets/js/Profile-Edit-Form.js"></script>
  </body>

</html>
