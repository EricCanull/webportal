package edu.portal.webportal.attributes;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import org.wso2.carbon.identity.sso.agent.bean.LoggedInSessionBean;
import org.wso2.carbon.identity.sso.agent.util.SSOAgentConstants;
import org.json.JSONObject;
import edu.portal.webportal.agent.CommonUtil;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import java.net.URLDecoder;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.apache.commons.lang.StringEscapeUtils;
import org.wso2.samples.claims.manager.ClaimManagerProxy;
import org.wso2.carbon.identity.sso.agent.openid.AttributesRequestor;

import java.util.*;

public class AttributeRequestor implements AttributesRequestor {

  private String subjectId = null;
  private String fullname = "";
  private String thumbnail = "";
  private String firstname = "";
  private String role = "";
  private LoggedInSessionBean sessionBean;
  private ClaimManagerProxy claimManagerProxy;
  private Map<String, String> attributeValueMap;
  private Map<String, String> attributeDisplayValueMap;

  List<String> requestedAttributes = new ArrayList<>();
  Map<String, Boolean> requiredMap = new HashMap<>();
  Map<String, String> typeURIMap = new HashMap<>();
  Map<String, Integer> countMap = new HashMap<>();

  public AttributeRequestor() {

  }
  
//    if (!attributeValueMap.isEmpty()) {
//    fullname = attributeDisplayValueMap.containsKey("http://wso2.org/claims/fullname") 
//      ? (String) attributeValueMap.get("http://wso2.org/claims/fullname") : fullname;
//    firstname = attributeDisplayValueMap.containsKey("http://wso2.org/claims/firstname") 
//      ? (String) attributeValueMap.get("http://wso2.org/claims/firstname") : firstname;
//    role = attributeDisplayValueMap.containsKey("http://wso2.org/claims/userrole") 
//      ? (String) attributeValueMap.get("http://wso2.org/claims/userrole") : role;
//    thumbnail = attributeDisplayValueMap.containsKey("http://wso2.org/claims/thumbnail") 
//      ? URLDecoder.decode((String) attributeValueMap.get("http://wso2.org/claims/thumbnail"), "UTF-8") : thumbnail;
//  }

  @Override
  public void init() {
    requestedAttributes.add("fullname");
    requiredMap.put("fullname", true);
    typeURIMap.put("fullname", "http://wso2.org/claims/fullname");
    countMap.put("fullname", 1);
    requestedAttributes.add("firstname");
    requiredMap.put("firstname", true);
    typeURIMap.put("firstname", "http://wso2.org/claims/firstname");
    countMap.put("firstname", 1);
    requestedAttributes.add("role");
    requiredMap.put("role", true);
    typeURIMap.put("role", "http://wso2.org/claims/userRole");
    countMap.put("role", 0);
    requestedAttributes.add("thumbnail");
    requiredMap.put("thumbnail", true);
    typeURIMap.put("thumbnail", "http://wso2.org/claims/thumbnail");
    countMap.put("thumbnail", 1);

  }

  public String[] getRequestedAttributes() {
    String[] attrArray = new String[requestedAttributes.size()];
    return requestedAttributes.toArray(attrArray);
  }

  @Override
  public boolean isRequired(String s, String s2) {
    return requiredMap.get(s2);
  }

  @Override
  public String getTypeURI(String s, String s2) {
    return typeURIMap.get(s2);
  }

  @Override
  public int getCount(String s, String s2) {
    return countMap.get(s2);
  }

  @Override
  public String[] getRequestedAttributes(String string) {
    throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
  }
}
