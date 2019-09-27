/**
 * 
 */
package com.qst.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

/**
* @ClassName: LoginInterceptor.java
* @version: v1.0.0
* @author: 隆森
* @date: 2019年8月28日 下午4:19:18 
* @Description: 权限拦截器
 */

public class LoginInterceptor implements HandlerInterceptor{

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object arg2, Exception arg3)
			throws Exception {
		 
	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3)
			throws Exception {
		
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object arg2) throws Exception {
		 //获取请求的url 
		 String path = request.getRequestURI();
		 
		 //登录注册界面 和登录不拦截
		 if(path.indexOf("/tologin")>=0||path.indexOf("/login")>=0
				 ||path.indexOf("addUser")>=0||path.indexOf("judgeUser")>=0
				 ||path.indexOf("getEmail")>=0){
			System.out.println("拦截器放行");
			 return true;
		 }
			 
		 else{	 
			 if(request.getSession().getAttribute("userName")!=null){
				 System.out.println("拦截器放行");
				 return true;
			 }else{
				 response.sendRedirect("web/jsp/login.jsp");
				 System.out.println("拦截器已经拦截");
				 return false;
			 }
			 
		 }
		 
		
	}

}
