<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%--
  ~ Copyright (c) 2015, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
  ~
  ~ WSO2 Inc. licenses this file to you under the Apache License,
  ~ Version 2.0 (the "License"); you may not use this file except
  ~ in compliance with the License.
  ~ You may obtain a copy of the License at
  ~
  ~ http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing,
  ~ software distributed under the License is distributed on an
  ~ "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
  ~ KIND, either express or implied.  See the License for the
  ~ specific language governing permissions and limitations
  ~ under the License.
--%>



<script>
  function doSubmit() {
    var answer1 = document.getElementById("answer1").value;
    var answer2 = document.getElementById("answer2").value;
    if (answer1 == 'null' || answer1 == "") {
      alert('Please provide an answer to Security Question 1');
    }
    if (answer2 == 'null' || answer2 == "") {
      alert('Please provide an answer to Security Question 2');
    }
  }

</script>

<%
    String username = request.getParameter("username");
%>



<form id="securityQuestionSetupForm" method="POST"
      action="${pageContext.request.contextPath}/infoRecover/setupSecurityQuestions?username=<%=username%>">
  <div class="card">
    <div class="card-body">
      <!--                  <label>City where you were born?</label>
                          <input id="answer1" class="form-control" type="text">
                        <label>Model of your first car?</label>
                          <input id="answer2" class="form-control" type="text">
                        <br>
                        <div class="form-row">
                          <div class="col-md-12 content-right">
                            <button class="btn btn-primary form-btn" onSubmit="doSubmit();" type="submit">SUBMIT </button>
                          </div>
                          <br>
                        </div>-->
      <h3>Setup Security Questions</h3>
      <br>
      <table cellpadding="5px">
        <tr class="spaceUnder">
          <td>Select Security Question 1 <%=username%></td>
          <td><select name="question1">
              <c:forEach var="line" items="${questionSet1}">
                <option><c:out value="${line}"/></option>
              </c:forEach>
            </select></td>
        </tr>
        <tr class="spaceUnder">
          <td>Enter answer</td>
          <td><input type="text" name="answer1" id="answer1"/></td>
        </tr>
        <tr class="spaceUnder">
          <td>Select Security Question 2</td>

          <td><select name="question2">
              <c:forEach var="line" items="${questionSet2}">
                <option><c:out value="${line}"/></option>
              </c:forEach>
            </select></td>
        </tr>
        <tr class="spaceUnder">
          <td>Enter answer</td>
          <td><input type="text" name="answer2" id="answer2"/></td>
        </tr>
      </table>
      <br>
      <input type="submit" class="btn btn-primary form-btn" value="Update"/>
      <input type="button" class="btn btn-primary form-btn" value="Cancel"/>
    </div>
  </div>

</form>




