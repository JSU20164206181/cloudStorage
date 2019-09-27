package com.qst.aspect;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * @Auther: CGL
 * @Date: 2019/9/8 20:02
 * @Description: 自定义注解  标注类   来使aspectj增强
 */
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
public @interface LoginType {
}
