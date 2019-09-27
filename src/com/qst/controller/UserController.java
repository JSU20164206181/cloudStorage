/**
 * 
 */
package com.qst.controller;

import java.io.File;
import java.net.InetAddress;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.request.AlipayTradePagePayRequest;
import com.alipay.api.response.AlipayTradePagePayResponse;
import com.qst.entity.Person;
import com.qst.entity.User;
import com.qst.interceptor.Code;
import com.qst.interceptor.FinalConst;
import com.qst.interceptor.MailUtil;
import com.qst.service.UserService;

/**
 * @ClassName: TestContrller.java
 * @version: v1.0.0
 * @author: 隆森
 * @date: 2019年8月26日 下午2:55:01
 * @Description: 该类的功能描述
 */

@Controller
public class UserController implements FinalConst {

	@Autowired
	UserService userService;

	// 注册时判断用户名是否存在
	@RequestMapping(value = "judgeUser.action")
	public void judgeUser(@RequestParam(value = "userName") String userName, HttpServletResponse response)
			throws Exception {

		// 将userName 放入到数据库中进行比较

		if (userService.judgeUser(userName) != null) {

			response.getWriter().write(userService.judgeUser(userName));

		} else {

			response.getWriter().write("账号可以使用");
		}

	}

	// 注册用户
	@RequestMapping(value = "addUser.action")
	public String addUser(User user) throws Exception {

		// 将创建时间设置到数据库里面
		Date date = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd :hh:mm:ss");
		String time = dateFormat.format(date);
		Date da = dateFormat.parse(time);
		user.setCreateDatetime(da);

		// 总空间大小是500 初始大小是0
		user.setUsedSize(0);
		user.setTotalSize(500*1048576);

		// user的初始状态是0 0是未激活 1是正常 2是禁用 3是删除
		user.setUserStatus(0);

		// 1是普通会员 2是会员 3是超级会员.
		user.setMemberOrder(1);

		userService.UserinsertSelective(user);

		// 插入user对应的person
		Person person = new Person();
		person.setPersonId(user.getUserId());
		// 将默认照片的路径放入其里面
		System.out.println(person.getPersonId());
		person.setPicture("web/images/defaultImg.jpg");
		userService.PersoninsertSelective(person);

		// 将外键的personId 的值插入
		user.setPersonId(user.getUserId());
		userService.updateByPrimaryKeySelective(user);
		return "login";
	}

	// 获取邮箱验证码
	@RequestMapping(value = "getEmail.action")
	public void getEmail(HttpServletResponse response, HttpServletRequest request) throws Exception {

		// 获取发送邮箱
		String realEmail = request.getParameter("personEamil");
		// 获取验证码
		String emailCode = MailUtil.getEmail(realEmail);
		// 取出邮箱内容的数字验证码
		String regEx = "[^0-9]";
		Pattern p = Pattern.compile(regEx);
		Matcher realEamilCode = p.matcher(emailCode);
		response.getWriter().write(realEamilCode.replaceAll("").trim());
	}

	// 登录功能
	@RequestMapping(value = "tologin.action")
	public String login(User user, HttpServletResponse response, HttpServletRequest request) throws Exception {
		User user1;
		// 先判断是否是邮箱登录
		if (request.getParameter("email") != null) {
			// 通过邮箱查询用户的id
			Integer id = userService.findIdByEmail(request.getParameter("email"));
			// 根据id找到对应的user
			if(id==null){
				request.getSession().setAttribute(LOGIN_ERROR, "没有对应的用户,请检查你的邮箱");
				return "redirect:/web/jsp/login.jsp";
			}
			user1 = userService.findUserById(id);
			
		}
		// 普通账号密码登录
		else {
			// 数据库查询对应的用户
			user1 = userService.selectIdByName(user.getUserName());
			if (user1 == null || !user1.getUserPassword().equals(user.getUserPassword())){
				request.getSession().setAttribute(LOGIN_ERROR, "账号密码错误");
				return "redirect:/web/jsp/login.jsp";
			}
		}

		// 登录ip放入里面
		InetAddress addr = InetAddress.getLocalHost();
		user1.setLatestLoginIp(addr.toString().split("/")[1]);
		// 登录时间放到user里面
		Date date = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd :hh:mm:ss");
		String time = dateFormat.format(date);
		Date da = dateFormat.parse(time);
		user1.setLatestLoginDatetime(da);

		// 修改后的user
		userService.updateByPrimaryKeySelective(user1);
		System.out.println(user1+"ss");
		if (user1.getUserStatus() == 2) {
			request.getSession().setAttribute(LOGIN_ERROR, "你已经被禁用 请联系管理员");
			return "redirect:/web/jsp/login.jsp";
		} else if (user1.getUserStatus() == 3) {
			request.getSession().setAttribute(LOGIN_ERROR, "你的账号已被删除,请联系管理员");
			return "redirect:/web/jsp/login.jsp";
		}
		// 存id和name
		Cookie cookie = new Cookie(CLIENT_USER_ID, user1.getUserId() + "");
		response.addCookie(cookie);
		request.getSession().setAttribute(SESSION_USER_NAME, user1.getUserName());
		
		System.out.println("cookie："+cookie.getValue());
		
		//获取用户的使用空间和总共空间
		request.getSession().setAttribute("used_size", getPrintSize((long)user1.getUsedSize() *1024));
		request.getSession().setAttribute("user_totalSize", getPrintSize((long)(user1.getTotalSize()) *1024));
		request.getSession().setAttribute("member_order",user1.getMemberOrder());
		request.getSession().setAttribute("userStatus", user1.getUserStatus());

		return "redirect:/toFileList.action";

	}

	// 退出登录
	@RequestMapping(value = "logout.action")
	public void logout(HttpServletRequest request, HttpServletResponse response) {

		// 删除cookie和session
		Cookie[] cookie = request.getCookies();
		for (Cookie co : cookie) {
			if (co.getName().equals("userId")) {
				co.setMaxAge(0);
				response.addCookie(co);
			}
		}
		request.getSession().invalidate();
		System.out.println("删除");
	}

	// 上传头像
	@RequestMapping(value = "HeadImgUpload.action")
	public String HeadImgUpload(@RequestParam(value = "myfile") MultipartFile myfile, HttpServletRequest request) {
		// 将头像图片传到服务器的上面 webapps下面和项目同级目录
		String realPath = request.getServletContext().getRealPath("");
		realPath = realPath + "../HeadImg";

		// 获取图片的名字
		String fileName = myfile.getOriginalFilename();
		System.out.println("图片名字" + fileName);
		File targetFile = new File(realPath, fileName);
		if (!targetFile.exists()) {
			targetFile.mkdirs();
		}
		try {
			System.out.println(targetFile);
			myfile.transferTo(targetFile);
			System.out.println("上传成功");
			// 取出当前用户的id

			userService.updateHeadImg("../HeadImg/" + fileName, getCookieId(request));
			Person person = userService.selectPersonById(getCookieId(request));
			request.setAttribute("person", person);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return "PersonCenter";

	}

	// 获取用户的信息
	@RequestMapping(value = "showPerson.action")
	public String showPerson(HttpServletRequest request) {
		// 取出当前用户的id

		Person person = userService.selectPersonById(getCookieId(request));
		request.setAttribute("person", person);
		return "PersonCenter";
	}

	// 修改个人信息
	@RequestMapping(value = "updateUser.action")
	public String updateUserMsg(Person person, User user, HttpServletRequest request) {
		
		// 先查询要更改信息的person对象
		person.setPersonId(getCookieId(request));
		// 获取cookie的id
		user.setUserId(getCookieId(request));
		System.out.println(person.toString());
		System.out.println(user.toString());
		// 修改存放用户名的session 的值
		request.getSession().setAttribute(SESSION_USER_NAME, user.getUserName());
		// 修改user
		userService.updateByPrimaryKeySelective(user);
		// 修改用户
		userService.updatePerson(person);
		// 重新获取修改后的个人信息
		person = userService.selectPersonById(getCookieId(request));
		// 重新设置 获取修改后的个人信息
		request.setAttribute("person", person);
		return "redirect:/page/PersonCenter.action";
		/* return "PersonCenter"; */
	}

	// 防止刷新时表单重复提交
	@RequestMapping("/page/{page}")
	public String page(@PathVariable("page") String page, HttpServletRequest request) {
		Person person = userService.selectPersonById(getCookieId(request));
		System.out.println(person);
		request.setAttribute("person", person);
		return page;
	}

	// 发送手机验证码
	@RequestMapping("sendPhone.action")
	public void sendPhone(HttpServletResponse response, HttpServletRequest request) throws Exception {
		String telePhone = request.getParameter("telephone");
		System.out.println("手机号码");
		String code = Code.getPhoneCode(telePhone);
		System.out.println("code" + code);
		response.getWriter().write(code);
	}

	// 激活用户
	@RequestMapping("sensitiveUser.action")
	public String sensitiveUser(HttpServletRequest request) {

		request.getSession().setAttribute("userStatus", 1 + "");
		User user = new User();
		user.setUserId(getCookieId(request));
		user.setUserStatus(1);
		userService.updateUserStatus(user);
		System.out.println("激活成功");
		return "redirect:/toFileList.action";
	}

	// 写一个方法 获取id的方法
	public int getCookieId(HttpServletRequest request) {
		Cookie[] cookie = request.getCookies();
		int id = 0;
		for (Cookie co : cookie) {
			if (co.getName().equals("userId")) {
				id = Integer.parseInt(co.getValue());
			}

		}
		return id;
	}

	// 修改用户名信息时 判断是否可以修改

	@RequestMapping(value = "updateUname.action")
	public void updateUname(@RequestParam(value = "bname") String name, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		JSONObject jo = new JSONObject();
		if (userService.judgeUser(name) != null) {
			jo.put("pname", userService.judgeUser(name));
			response.getWriter().write(jo.toString());
		} else {
			jo.put("pname", "no");
			response.getWriter().write(jo.toString());
		}
	}

	// 修改youx 时 判断是否可以修改
	@RequestMapping(value = "updateEmail.action")
	public void updateEmail(@RequestParam(value = "bemail") String email, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		JSONObject jo = new JSONObject();
		int flag = 0;
		if (userService.findPersonByEamil() != null) {
			List<Person> list = userService.findPersonByEamil();
			
			for (Person pList : list) {
				if (pList.getEmail() != null && pList.getEmail().equals(email)) {
					flag = 1;
				}
			}
		}
		if (flag == 1) {
			jo.put("pemail", "no");
			response.getWriter().write(jo.toString());
		} else {
			jo.put("pemail", "ok");
			response.getWriter().write(jo.toString());
		}

	}
	//支付宝沙箱
	@RequestMapping(value = "buyVip.action")
	public void buyVip(HttpServletRequest request1,HttpServletResponse res) throws Exception{
		
		
		AlipayClient alipayClient = new DefaultAlipayClient("https://openapi.alipaydev.com/gateway.do","2016101300673650"
				,"MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDoUdyYlkOpAsxacUpLs4CWgMvokGaQF2MTz3FXKjwawz6SjsQcjIav0piyJR3W/DAggMBKHwz3K3YavUHij0iU9lyXbpeN4BoJkmXcgsVIypyKQaDePQzdnvYdO9rglL5MdRgkRpDzV0Q+rTgN5M+e9ZN7M9+xnhP/O944pWF7+hPZiByS4iMFasAYLIDalZPkYeqxfVV/UVHXHgBA2qu2YZzc7X4r6NQ8S69dbjYdwkG+FA9rfjmyNb64qgA5hWqluf5bXOHsMXVSztIkJ8B2qWps0Nb1rDwmGcxCYgyB9btKpzEAHxcJW67CSwKsz1tnV/fRCT1dewL/0wTbyuotAgMBAAECggEAAq/fs0wZoDzODEW/LDz5QcRfl2MELKp4lOQTVYTBiTW05ZENJ59gd2wiI/1V6QSlsdqLXtAZIEq6ZPjHaE1r830d+QpoalWrN20gDHreuUbOpLK5n5hpK68I/bGRiINv6AZ6rwC58HaT7X2nZlG9LQN+HzCsZ6uCY7NXkKQpCnwGVTzPDZiDzYeuc8D+sj6FZRAMYFRB587yosSzi5ZZ61/Kq/gjsZ3u9zZMsmMcabQeckEdB9vFoFpuZxgqYQIat1MK4G2s3qhuTShWbjoyEXkSSSg1ZT0qZNoh2q7kYh+MIrJR1W2n3q5VTAp/VTRcu3D4vMfvkz/TuD+cMkCZgQKBgQD+jxRkr622cQdvri9fkiOgbdaqpXIG6x7DCB6Y+AISDNYWlvsOS6b3ZNzosEXmukgj715IK1/H4qLoygjQDIsSE0KxV3JfVW06QzWSbjg9giRUQUTpv5JS4Fznmj1ySrk3Wr2xs5ggPBDSYnnOXDuP+kCx7WJWywUBhdsqnNVDcQKBgQDpoo1Jpo8jnVfWWJ0P+lsbdLSkkDh70AaAuEF+JxujNiN85cHq5G+Y6JFBYOUrUGJstd3fPSVfh/SFtl/YpQwAR5JAXDcTBnQzxRT/Wdx/sJa659VdhkqrH7v6q/GVJQW3MJpKBcaxyoWiKH+vWXYYfsDA6CcePDQooLIhN0K8fQKBgQCYwAa+vGSC26RYsa8frDPQqthroceguynEYnTp2bh0WFuHRqXz2BWi0lV1E4F+iD2Nwq9SoyRgb3DOO526KiyxdflJLW4mIr7efUICUj1RO2zNWjUeBqSpMpTNLVK96HTn8H1vypL4lNKLTChHWjUrmkGEAyxFZKHmXgo7scyPIQKBgQCGjR4Pb4P5/9CpWilCHW3A1yp9p61P6NMF6JeXPpCVI0W21V8jluGKT03wOAxjMI0ujGK2ATH33YV+SDTUwOCzfISG2lTBeTMM6ZCZKrhpNVrpU0C29vMjsEgDKmkb+tFa2fvRa5gtpjPl2qsGYmA35S+/KTP2HrfvOfS8WmXtxQKBgHvKTPCqvcvxzPc1XAQuo0un6WGPY75I6EO1Gu2zXwwcoS7npAJ4MDhT9xq9MNGgFwaRRLsIK3Eb/U4bwjIKD4x5Apm37Fa3SclWadTpwS2jaie+NeZ9VwxlYTjPpWOKMBVXv6A/4OZTC4NzV2wRXrN6Aothc2T9I/TS+zq0v8Gu",
				"json",
				"utf-8","MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA6FHcmJZDqQLMWnFKS7OAloDL6JBmkBdjE89xVyo8GsM+ko7EHIyGr9KYsiUd1vwwIIDASh8M9yt2Gr1B4o9IlPZcl26XjeAaCZJl3ILFSMqcikGg3j0M3Z72HTva4JS+THUYJEaQ81dEPq04DeTPnvWTezPfsZ4T/zveOKVhe/oT2YgckuIjBWrAGCyA2pWT5GHqsX1Vf1FR1x4AQNqrtmGc3O1+K+jUPEuvXW42HcJBvhQPa345sjW+uKoAOYVqpbn+W1zh7DF1Us7SJCfAdqlqbNDW9aw8JhnMQmIMgfW7SqcxAB8XCVuuwksCrM9bZ1f30Qk9XXsC/9ME28rqLQIDAQAB",
				"RSA2");
		AlipayTradePagePayRequest request = new AlipayTradePagePayRequest();
		request.setReturnUrl("http://127.0.0.1:8080/cloudStorage/updateVip.action");
		request.setBizContent("{" +
		"\"out_trade_no\":\"2019032001010"+Code.createRandomVcode()+"\"," +
		"\"product_code\":\"FAST_INSTANT_TRADE_PAY\"," +
		"\"total_amount\":28.88," +
		"\"subject\":\"Iphone6 16G\"," +
		"\"body\":\"Iphone6 16G\" " +
		"}");
		AlipayTradePagePayResponse response = alipayClient.pageExecute(request);
		if(response.isSuccess()){
		   System.out.println("调用成功");
		
		} else {
		System.out.println("调用失败");
		}
		res.setContentType("text/html");
		res.getWriter().write(response.getBody());
		/*return "index";	*/
	}		
	//买超级会员
	@RequestMapping(value = "updateVip.action")
	public String updateVip(HttpServletRequest request){
		System.out.println("充值");
		User user = new User();
		user.setUserId(getCookieId(request));
		//空间升级为1.5TB
		user.setTotalSize(1610612736);
		user.setMemberOrder(3);
		userService.updateByPrimaryKeySelective(user);
		request.getSession().setAttribute("user_totalSize", getPrintSize((long)(user.getTotalSize()) *1024));
		request.getSession().setAttribute("member_order",3);
		return "redirect:/toFileList.action";
	}

	public static void main(String[] args) {
		System.out.println(getPrintSize((long)1610612736*1024));
		
	}
	//单位换算
	public static String getPrintSize(long size) {
		
		//如果字节数少于1024，则直接以B为单位，否则先除于1024，后3位因太少无意义
		if (size < 1024) {
			return String.valueOf(size) + "B";
		} else {
			size = size / 1024;
		}
		//如果原字节数除于1024之后，少于1024，则可以直接以KB作为单位
		//因为还没有到达要使用另一个单位的时候
		//接下去以此类推
		if (size < 1024) {
			return String.valueOf(size) + "KB";
		} else {
			size = size / 1024;
		}
		if (size < 1024) {
			//因为如果以MB为单位的话，要保留最后1位小数，
			//因此，把此数乘以100之后再取余
			size = size * 100;
			return String.valueOf((size / 100)) + "."
					+ String.valueOf((size % 100)) + "MB";
		} else {
			//否则如果要以GB为单位的，先除于1024再作同样的处理
			size = size * 100 / 1024;
			return String.valueOf((size / 100)) + "."
					+ String.valueOf((size % 100)) + "GB";
		}
	}

	@RequestMapping(value = "findAllFile.action")
	public void findAllFile(HttpServletRequest request,HttpServletResponse response) throws Exception{
		int size = 0;
		System.out.println("执行++++");
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		List<com.qst.entity.File> list  = userService.findAllFile(getCookieId(request));
		System.out.println("文件哟哟哟"+list);
		if(list==null||list.size()==0){
			request.getSession().setAttribute("used_size", 0+"");
		}else{
			for(int i =0;i<list.size();i++){
				size =size+list.get(i).getFileSize();
			}
		}
		String maxSize = (String) request.getSession().getAttribute("user_totalSize");
		System.out.println("size"+size);
		response.getWriter().write(getPrintSize((long)size *1024)+"/"+maxSize);	
	}
}
