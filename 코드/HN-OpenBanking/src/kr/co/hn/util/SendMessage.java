package kr.co.hn.util;

import java.util.HashMap;
import org.json.simple.JSONObject;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

/**
 * @class SendMessage
 * @brief This sample code demonstrate how to send sms through CoolSMS Rest API PHP
 * 출처 : https://developer.coolsms.co.kr/JAVA_SDK_EXAMPLE_Message
 */

public class SendMessage {
	  public static void main(String[] args) {
		    String api_key = "API KEY 입력"; // api_key = NCSM3IBHSCY6DUBI   
		    String api_secret = "API SECRET 입력 "; // api_secret = XAE7FI8CJDVG4IVEE1KYDQNWLDI1S1BD
		    Message coolsms = new Message(api_key, api_secret);

		    // 4 params(to, from, type, text) are mandatory. must be filled
		    HashMap<String, String> params = new HashMap<String, String>();
		    params.put("to", "01047628287");   // 수신전화번호
		    params.put("from", "01047628287");   // 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로 하면 됨
		    params.put("type", "SMS");
		    params.put("text", "자승구 SMS 테스트");
		    params.put("app_version", "test app 1.2"); // application name and version

		    try {
		      JSONObject obj = (JSONObject) coolsms.send(params);
		      System.out.println(obj.toString());
		    } catch (CoolsmsException e) {
		      System.out.println(e.getMessage());
		      System.out.println(e.getCode());
		    }
		  }
		}