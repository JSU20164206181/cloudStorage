package com.qst.interceptor;

import org.apache.commons.httpclient.Header;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;

/**
* @ClassName: LoginInterceptor.java
* @version: v1.0.0
* @author: 隆森
* @date: 2019年8月28日 下午4:19:18 
* @Description: 手机验证码
 */

public class Code {

	public static String getPhoneCode(String phone) throws Exception {
        String phoneCode = createRandomVcode();
		HttpClient client = new HttpClient();
		PostMethod post = new PostMethod("http://utf8.api.smschinese.cn");
		// 在头文件中设置转码
		post.addRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
		//备用账号 hdq119367 密码413436  d41d8cd98f00b204e980
		NameValuePair[] data = { new NameValuePair("Uid", "hdq119367"),
				new NameValuePair("Key", "d41d8cd98f00b204e980"),
				new NameValuePair("smsMob",phone), 
				new NameValuePair("smsText", "验证码:"+phoneCode)};
		post.setRequestBody(data);

		client.executeMethod(post);
		Header[] headers = post.getResponseHeaders();
		int statusCode = post.getStatusCode();
		System.out.println("statusCode:" + statusCode);
		for (Header h : headers) {
			System.out.println(h.toString());
		}
		String result = new String(post.getResponseBodyAsString().getBytes("utf-8"));
		System.out.println(result); // 打印返回消息状态

		post.releaseConnection();
		return phoneCode;

	}
	
	 /**
	  * 随机生成4位随机验证码
	  * 方法说明
	  */
	 public static String createRandomVcode(){
	  //验证码
	  String vcode = "";
	  for (int i = 0; i < 4; i++) {
	   vcode = vcode + (int)(Math.random() * 9);
	  }
	  return vcode;
	 }

}