package com.qst.aspect;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * @Auther: CGL
 * @Date: 2019/9/8 20:00
 * @Description:  自定义注解   标注需要管理员登录才能执行的方法
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface LoginMethod {
}
