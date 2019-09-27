package com.qst.controller;

/**
 * @Auther: CGL
 * @Date: 2019/8/30 15:54
 * @Description:  常量控制器
 */
public interface FinalConstant {

    /**
     * 存放于服务端session中的图片验证码
     */
    String SESSION_VALIDATECODE = "imgValidate";

    /**
     * 客户端提交获取的验证码
     */
    String REQUEST_VALIDATECODE = "validateCode";

    /**
     * 错误信息
     */
    String REQUEST_ERROR_INFO = "error";

    /**
     * 服务端存放于会话中的后台管理员用户名
     */
    String SESSION_ADMIN_NAME = "loginAdmin";

    /**
     * 用户登录成功后存放在服务端Session中的属性名 用户账号
     */
    String SESSION_USER_ACCOUNT = "loginUser";

    /**
     * 存储在客户端cookie中的用户名
     */
    String CILENT_USERNAME = "userName";

    /**
     * 存储在客户端中的用户id
     */
    String CILENT_USER_ID = "userId";
}
