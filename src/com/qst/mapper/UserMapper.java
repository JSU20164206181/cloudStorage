package com.qst.mapper;

import com.qst.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserMapper {
	//ajax判断用户是否存
	public String judgeUser(String name);
	//登录时 取出用户的id等信息
	public User selectIdByName(String name);

    int deleteByPrimaryKey(Integer userId);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer userId);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);

    /**
     * 分页查找数据 输入4代表查询 正常和禁用两种类型的用户
     * @param start
     * @param pageSize
     * @return
     */
    List<User> selectByPage(@Param("status")Integer status,@Param("start") Integer start, @Param("pageSize") Integer pageSize);

    /**
     * 根据类型分页的总数量  状态
     * @return
     */
    int searchTypeCount(@Param("status") Integer status);

    /**
     * 模糊分页查找数据 输入4代表查询 正常和禁用两种类型的用户
     * @param start
     * @param pageSize
     * @param key
     * @return
     */
    List<User> fuzzySearchByPage(@Param("status")Integer status,@Param("key")String key,@Param("start") Integer start, @Param("pageSize") Integer pageSize);

    /**
     * 模糊查找   类型分页的总数量  状态
     * @return
     */
    int fuzzySearchTypeCount(@Param("status") Integer status,@Param("key") String key);


    /**
     * 批量删除  伪删除
     * @param array id数组
     * @return   删除的数据条数
     */
    int deleteMany(Integer[] array);

    /**
     * 从数据库删除数据
     * @param userId
     * @return
     */
    int resetUserById(Integer userId);


}