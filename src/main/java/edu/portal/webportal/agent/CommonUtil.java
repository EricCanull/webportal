/*
 * Copyright (c) 2019, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 * WSO2 Inc. licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
package edu.portal.webportal.agent;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.opensaml.xml.XMLObject;
import org.opensaml.xml.io.Marshaller;
import org.opensaml.xml.io.MarshallerFactory;
import org.opensaml.xml.util.Base64;
import org.w3c.dom.Element;
import org.w3c.dom.bootstrap.DOMImplementationRegistry;
import org.w3c.dom.ls.DOMImplementationLS;
import org.w3c.dom.ls.LSOutput;
import org.w3c.dom.ls.LSSerializer;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.Serializable;
import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import org.opensaml.xml.io.MarshallingException;
import org.w3c.dom.ls.LSException;

public class CommonUtil implements Serializable {

  private static final long serialVersionUID = 42L;

  private static final Log LOG = LogFactory.getLog(CommonUtil.class);

  private CommonUtil() {

  }

  /**
   * Serialize the Auth.Request
   *
   * @param xmlObject
   * @return serialized auth. req
   * @throws java.lang.Exception
   */
  public static String marshall(XMLObject xmlObject) throws Exception {

    ByteArrayOutputStream byteArrayOutputStream = null;
    try {

      MarshallerFactory marshallerFactory = org.opensaml.xml.Configuration.getMarshallerFactory();
      Marshaller marshaller = marshallerFactory.getMarshaller(xmlObject);
      Element element = marshaller.marshall(xmlObject);

      byteArrayOutputStream = new ByteArrayOutputStream();
      DOMImplementationRegistry registry = DOMImplementationRegistry.newInstance();
      DOMImplementationLS impl = (DOMImplementationLS) registry.getDOMImplementation("LS");
      LSSerializer writer = impl.createLSSerializer();
      LSOutput output = impl.createLSOutput();
      output.setByteStream(byteArrayOutputStream);
      writer.write(element, output);
      return byteArrayOutputStream.toString("UTF-8");
    } catch (UnsupportedEncodingException | ClassCastException | ClassNotFoundException | IllegalAccessException | InstantiationException | MarshallingException | LSException e) {
      LOG.error("Error Serializing the SAML Response", e);
      throw new Exception("Error Serializing the SAML Response", e);
    } finally {
      if (byteArrayOutputStream != null) {
        try {
          byteArrayOutputStream.close();
        } catch (IOException e) {
          LOG.error("Error while closing the stream", e);
        }
      }
    }
  }

  /**
   * Encoding the response
   *
   * @param xmlString String to be encoded
   * @return encoded String
   */
  public static String encode(String xmlString) {
    LOG.info("Response" + xmlString);
    // Encoding the message
    String encodedRequestMessage
            = Base64.encodeBytes(xmlString.getBytes(StandardCharsets.UTF_8),
                    Base64.DONT_BREAK_LINES);
    return encodedRequestMessage.trim();
  }

}
