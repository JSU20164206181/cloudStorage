/**
 * 
 */
package com.qst.service;

import com.qst.entity.Admin;
import com.qst.entity.User;

/**
* @ClassName: AdminService.java
* @version: v1.0.0
* @author: CGL
* @date: 2019年8月28日 下午3:08:02 
* @Description: 后台管理员服务层方法声明
 */
public interface AdminService {


     /**
      * 用户登录
      * @return 0 表示用户名不存在 1表示验证成功 -1表示用户密码不匹配
      */
     int login(Admin v);

     /**
      * 用户添加
      * @param v
      * @return
      */
     int addAdmin(Admin v);

     /**
      * 删除用户
      * @param id
      * @return
      */
     int deleteById(Integer id);

     /**
      * 删除多个用户
      * @param id
      * @return
      */
     int deleteMany(Integer[] id);

     /**
      * 更新用户
      * @param vo
      * @return
      */
     int updateById(User vo);


}
