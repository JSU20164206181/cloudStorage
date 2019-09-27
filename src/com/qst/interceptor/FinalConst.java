package com.qst.interceptor;

/**
 * @Auther: CGL
 * @Date: 2019/7/30 10:27
 * @Description: 常量控制器 常用常量都在此接口中定义
 */
public interface FinalConst {
  
	/**
     *   记录登录报错类型
     */
    String LOGIN_ERROR = "error";
    /**
     * 存放于客户端的用户id
     */
    String CLIENT_USER_ID = "userId";

    /**
     * 存放于服务端中用户名，用于判断是否登录
     */
    String SESSION_USER_NAME = "userName";

    /**
     * 存放于服务端的管理员用户名，用于判断管理员登录
     */
    String SESSION_ADMIN_NAME = "adminName";

    /**
     * 存放导出表格路径
     * 路径不存在则创建
     */
    String EXCEL_PATH = "C:/excel_Date/";
}
