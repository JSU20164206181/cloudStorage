package com.qst.aspect;

import com.qst.controller.FinalConstant;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;

/**
 * @Auther: CGL
 * @Date: 2019/9/8 20:04
 * @Description:  Aspectj   实现经态aop 监听管理员是否登录
 */
@Component
@Aspect
public class AdminLoginController implements FinalConstant {

    /**
     * 注解形式pointCut  需要注入横切增强逻辑的路径
     */
    @Pointcut("execution(* com.qst.controller..*.*(..)) && @target(com.qst.aspect.LoginType) ||"
    +"@annotation(com.qst.aspect.LoginMethod)")
    public void myPointCut(){ }

    /**
     * Around形式的增强  环绕增强
     * @param joinPoint
     * @return
     */
    @Around("myPointCut()")
    public Object userLoginAdvice(ProceedingJoinPoint joinPoint){
        System.out.println("进入aop增强advice-------------");
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        request.setAttribute("error","请登录之后再执行");

        String aa = (String) request.getSession().getAttribute(SESSION_ADMIN_NAME);
        if(aa!=null) {
            try {
                return joinPoint.proceed();
            } catch (Throwable throwable) {
                throwable.printStackTrace();
            }
        }
        return "adminLogin";
    }
}
