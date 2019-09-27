/**
 * 
 */
package com.qst.interceptor;


import java.util.Properties;

import javax.mail.Message.RecipientType;

import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;



public class MailUtil {
	// 发件人的 邮箱 和 密码（替换为自己的邮箱和授权密码）
     private static String myEmailAccount ="ls834915385@163.com";
     
     private static String myEmailPassword = "ls834915385";
     
     // 发件人邮箱的 SMTP 服务器地址, 必须准确, 不同邮件服务器地址不同, 
     //一般格式为: smtp.xxx.com
     // 网易163邮箱的 SMTP 服务器地址为: smtp.163.com
     private static String myEmailSMTPHost = "smtp.163.com";
     
    // 收件人邮箱（替换为自己知道的有效邮箱）
     private static String receiveMailAccount = "";
     
     //发件人名称
     private static String senderNickName = "云盘";
     //收件人名称
     private static String recipientsNickName = "lsls";
     //邮件主题
     private static String mailSubject = "登录通知";
     //邮件内容
     private static String mailContent ="你的验证码是:"+createRandomVcode()+",六十秒内有效";
	
     public static String  getEmail(String email) throws Exception {
    	 receiveMailAccount = email;
    	 System.out.println("邮箱"+receiveMailAccount);
    	// 1. 创建参数配置, 用于连接邮件服务器的参数配置
    	 Properties config = new Properties();
    	// 使用的协议（JavaMail规范要求）
    	 config.setProperty("mail.transport.protocol", "smtp");   
    	// 发件人的邮箱的 SMTP 服务器地址
    	 config.setProperty("mail.smtp.host", myEmailSMTPHost);  
    	 // 需要请求认证ַ
    	 config.setProperty("mail.smtp.auth", "true");            
    	 
    	 // 2. 根据配置创建会话对象, 用于和邮件服务器交互
    	 Session session = Session.getInstance(config);
    	// 设置为debug模式, 可以查看详细的发送 log
         session.setDebug(true);    
        // 3. 创建一封邮件
         MimeMessage mail = createMimeMessage(session);
         // 也可以保持到本地查看
         
         // message.writeTo(file_out_put_stream);
  
        // 4. 根据 Session 获取邮件传输对象
         Transport transport = session.getTransport();
  
         // 5. 使用 邮箱账号 和 密码 连接邮件服务器
         //    这里认证的邮箱必须与 message 中的发件人邮箱一致，否则报错

         transport.connect(myEmailAccount, myEmailPassword);
         
           // 6. 发送邮件, 发到所有的收件地址, message.getAllRecipients()
            //获取到的是在创建邮件对象时添加的所有收件人, 抄送人, 密送人
         transport.sendMessage(mail, mail.getAllRecipients());
  
         // 7. 关闭连接
         transport.close();
         return mailContent;
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

	
     //创建邮件
	private static MimeMessage createMimeMessage(Session session) throws Exception {
		
		// 1. 创建邮件对象
        MimeMessage mail = new MimeMessage(session);
        
     // 2. From: 发件人
        mail.setFrom(new InternetAddress(myEmailAccount, senderNickName, "UTF-8"));
     // 3. To: 收件人（可以增加多个收件人、抄送、密送）
        mail.addRecipient(RecipientType.TO, new InternetAddress(receiveMailAccount, recipientsNickName, "UTF-8"));
        /**
         * 添加抄送人,抄送给自己
         * 不加有可能报一个异常:
         *  554 DT:SPM
         *	DT:SPM 发送的邮件内容包含了未被许可的信息，或被系统识别为垃圾邮件。请检查是否有用户发送病毒或者垃圾邮件；
         * (包含Test 等垃圾信息,会报 DT:SPM)
         */
        mail.addRecipients(MimeMessage.RecipientType.CC, InternetAddress.parse(myEmailAccount));
        // 4. Subject: 邮件主题
        mail.setSubject(mailSubject);
        
        /**
         *  一般  JavaMail 只需要使用这个功能就足够了 </br>
         *  用这个内容设置 一个超链接,完成注册 或者 找回密码就行了
         *  (设置内容,前面设置的内容会被覆盖!)
         */
         mail.setText(mailContent);

		
		return mail;
	}
     
    
}
