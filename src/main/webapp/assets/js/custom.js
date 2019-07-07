/*
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
 */

$(document).ready(function () {
  // Enable portlets
  WinMove();

  $("#profile-content").hide();
  $("#main").css("display", "none");

  $("#back-home").click(function () {
    $("#main").css("display", "none");
    $("#profile").css("display", "block");
    $("#main-content").hide();
    $("#profile-content").hide();
  });

  $("#main").click(function () {
    $("#main").css("display", "none");
    $("#profile").css("display", "block");
    $("#main-content").show();
    $("#profile-content").hide();
  });

  $("#profile").click(function () {
    $("#main").css("display", "block");
    $("#profile").css("display", "none");
    $("#main-content").hide();
    $("#profile-content").show();
  });

  $("#settings-toggle").click(function () {
    $("#right-sidebar").css("right", "0px");
    $("#right-side-menu-overlay").css("display", "block");
  });
  
  $("#sidebar-close-button").click(function () {
    $("#right-sidebar").css("right", "-270px");
    $("#right-side-menu-overlay").css("display", "none");
  });

  $("#right-side-menu-overlay").click(function () {
    $("#right-sidebar").css("right", "-270px");
    $("#right-side-menu-overlay").css("display", "none");
  });

  $("#settings-toggle").click(function () {
    $("#main").css("display", "block");
  });

  var code = $(".code")[0];
  var editor = CodeMirror.fromTextArea(code, {
    mode: "xml",
    htmlMode: true,
    lineNumbers: true,
    styleActiveLine: true,
    matchBrackets: true,
    extraKeys: {"Ctrl-Space": "autocomplete"}
  });
  editor.setOption("theme", "default");

  var prettyXml = formatXml([$('.code').text()].join('\n'), "  ");
  insertText(prettyXml);

//  function scale(width, height, padding, border) {
//    var scrWidth = $(window).width() - 30,
//      scrHeight = $(window).height() - 30,
//      ifrPadding = 2 * padding,
//      ifrBorder = 2 * border,
//      ifrWidth = width + ifrPadding + ifrBorder,
//      ifrHeight = height + ifrPadding + ifrBorder,
//      h, w;
//    if (ifrWidth < scrWidth && ifrHeight < scrHeight) {
//      w = ifrWidth;
//      h = ifrHeight;
//    } else if ((ifrWidth / scrWidth) > (ifrHeight / scrHeight)) {
//      w = scrWidth;
//      h = (scrWidth / ifrWidth) * ifrHeight;
//    } else {
//      h = scrHeight;
//      w = (scrHeight / ifrHeight) * ifrWidth;
//    }
//    return {
//      'width': w - (ifrPadding + ifrBorder),
//      'height': h - (ifrPadding + ifrBorder)
//    };
//  };
  
  $("#profile-toggle").click(function () {
     $("#profile-overlay").css("display", "block");
    $("#popup-profile").css("display", "block");
  });
  
 $("#profile-overlay").click(function () {
    $("#popup-profile").css("display", "none");
    $("#profile-overlay").css("display", "none");
  });
 

//  $(".ui-popup iframe")
//    .attr("width", 0)
//    .attr("height", "auto");
//  $("#profile-popup").on({
//    popupbeforeposition: function () {
//      // call our custom function scale() to get the width and height
//      var size = scale(497, 298, 15, 1),
//        w = size.width,
//        h = size.height;
//      $("#popupVideo iframe")
//        .attr("width", w)
//        .attr("height", h);
//    },
//    popupafterclose: function () {
//      $("#popupVideo iframe")
//        .attr("width", 0)
//        .attr("height", 0);
//    }
//  });
});

// Begin inputting of clicked text into editor
function insertText(data) {
  var cm = $(".CodeMirror")[0].CodeMirror;
  var doc = cm.getDoc();
  var cursor = doc.getCursor(); // gets the line number in the cursor position
  var line = doc.getLine(cursor.line); // get the line contents
  var pos = {
    line: cursor.line
  };
  if (line.length === 0) {
    // check if the line is empty
    // add the data
    doc.replaceRange(data, pos);
  } else {
    // add a new line and the data
    doc.replaceRange("\n" + data, pos);
  }
}

function formatXml(xml, tab) {
  var formatted = '', indent = '';
  tab = tab || '\t';
  xml.split(/>\s*</).forEach(function (node) {
    if (node.match(/^\/\w/))
      indent = indent.substring(tab.length);
    formatted += indent + '<' + node + '>\r\n';
    if (node.match(/^<?\w[^>]*[^\/]$/))
      indent += tab;
  });
  return formatted.substring(1, formatted.length - 3);
}
function openNav() {
  console.log("clicked");
  document.getElementById("mySidenav").style.width = "250px";
}

function closeNav() {
  document.getElementById("mySidenav").style.width = "0";
}

function toggleDarkTheme() {
  // Get the checkbox
  var checkBox = document.getElementById("dark-mode-check");

  // If the checkbox is checked, display the output text
  if (checkBox.checked === true) {
    switch_style("dark-theme");
  } else {
    switch_style("light-theme");
  }
}

function toggleLightTheme() {
  // Get the checkbox
  var checkBox = document.getElementById("light-mode-check");

  // If the checkbox is checked, display the output text
  if (checkBox.checked === true) {
    switch_style("light-theme");
  } else {
    switch_style("dark-theme");
  }
}

/************************** CUSTOMIZABLE THEME ********************************/

// *** TO BE CUSTOMISED ***

var style_cookie_name = "style";
var style_cookie_duration = 30;
var style_domain = "https://localhost:8446/webportal/home.jsp";

// *** END OF CUSTOMISABLE SECTION ***
// You do not need to customise anything below this line

function switch_style(css_title)
{
// You may use this script on your site free of charge provided
// you do not remove this notice or the URL below. Script from
// https://www.thesitewizard.com/javascripts/change-style-sheets.shtml
  var i, link_tag;
  for (i = 0, link_tag = document.getElementsByTagName("link");
          i < link_tag.length; i++) {
    if ((link_tag[i].rel.indexOf("stylesheet") !== -1) &&
            link_tag[i].title) {
      link_tag[i].disabled = true;
      if (link_tag[i].title === css_title) {
        link_tag[i].disabled = false;
      }
    }
    set_cookie(style_cookie_name, css_title,
            style_cookie_duration, style_domain);
  }
}
function set_style_from_cookie()
{
  var css_title = get_cookie(style_cookie_name);
  if (css_title.length) {
    switch_style(css_title);
  }
}
function set_cookie(cookie_name, cookie_value,
        lifespan_in_days, valid_domain)
{
  // https://www.thesitewizard.com/javascripts/cookies.shtml
  var domain_string = valid_domain ?
          ("; domain=" + valid_domain) : '';
  document.cookie = cookie_name +
          "=" + encodeURIComponent(cookie_value) +
          "; max-age=" + 60 * 60 *
          24 * lifespan_in_days +
          "; path=/" + domain_string;
}
function get_cookie(cookie_name)
{
  // https://www.thesitewizard.com/javascripts/cookies.shtml
  var cookie_string = document.cookie;
  if (cookie_string.length != 0) {
    var cookie_array = cookie_string.split('; ');
    for (i = 0; i < cookie_array.length; i++) {
      cookie_value = cookie_array[i].match(cookie_name + '=(.*)');
      if (cookie_value != null) {
        return decodeURIComponent(cookie_value[1]);
      }
    }
  }
  return '';
}
