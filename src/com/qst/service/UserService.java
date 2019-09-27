/**
 * 
 */
package com.qst.service;

import com.qst.entity.Person;
import com.qst.entity.SexInfo;
import com.qst.entity.User;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;

/**
* @ClassName: UserService.java
* @version: v1.0.0
* @author: 隆森
* @date: 2019年8月28日 下午3:59:01 
* @Description: User的service
 */

public interface UserService {
      //ajax判断用户是否存在
	  public String judgeUser(String name);
	  //注册用户到数据库
	  public int UserinsertSelective(User user);
	  //注册对应的person 到数据库
	  public int PersoninsertSelective(Person person);
	  //根据id修改用户
	  public int updateByPrimaryKeySelective(User user);
	  //取出用户的id存放到cookie里面
	  public User selectIdByName(String name);
	  //上传的图片放到person类里面
	  public int updateHeadImg(String img,int id);
	  //查找用户
	  public Person selectPersonById(int id);
	  //修改用户
	  public int updatePerson(Person person);
	  //激活用户  即状态0到1
	  public int updateUserStatus(User user);
	  //查找所有的用户
	  public List<Person> findPersonByEamil();
	  //根据email查找用户
	  public Integer findIdByEmail(String email);
	  //查找User
	  public User findUserById(int userId);



	/**
	 * 根据id查询用户信息
	 * @param id
	 * @return
	 */
	User selectById(Integer id);

	/**
	 * 根据类型分页获取数据
	 * @param status
	 * @param page
	 * @param pageSize
	 * @return
	 */
	List<User> selectByPage(Integer status,int page,int pageSize);

	/**
	 * 根据类型获取符号条件的总数量
	 * @param status
	 * @return
	 */
	int searchStatusCount(Integer status);

    /**
     * 启用或禁用用户
     * @param userId
     * @return  成功返回success 失败返回error
     */
	String stopAndStart(Integer userId);

    /**
     * 批量删除
     * @param id  输入要删除的id数组
     * @return  返回删除的数组长度
     */
	int deleteMany(Integer[] id);

	/**
	 * 根据id删除单个用户
	 * @param id
	 * @return
	 */
	int deleteById(Integer id);

	/**
	 * 从数据库删除用户信息
	 * @param userId
	 * @return
	 */
	String resetUser(Integer userId);

	/**
	 * 更新用户信息
	 * @param user
	 * @return
	 */
	String updateUser(User user) throws Exception;

	/**
	 * 插入用户信息
	 * @param user
	 * @return
	 */
    String insertUser(User user);

	/**
	 *  用户类型   模糊查找
	 * @param status
	 * @param page
	 * @param pageSize
	 * @param key
	 * @return
	 */
    List<User> fuzzySearch(Integer status,int page,int pageSize,String key);

	/**
	 * 根据用户类型 模糊查找的信息条数
	 * @param status
	 * @param key
	 * @return
	 */
    int fuzzySearchCount(Integer status,String key);

    HashMap<String,Integer> sexInfo();

    HashMap<String,Integer> ageInfo();
	/**
	 * @param cookieId
	 * @return
	 */
	public List<com.qst.entity.File> findAllFile(int cookieId);
}
