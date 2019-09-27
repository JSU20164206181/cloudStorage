/**
 * 
 */
package com.qst.serviceImp;

import com.qst.entity.AgeInfo;
import com.qst.entity.File;
import com.qst.entity.SexInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qst.entity.Person;
import com.qst.entity.User;
import com.qst.mapper.FileMapper;
import com.qst.mapper.PersonMapper;
import com.qst.mapper.UserMapper;
import com.qst.service.UserService;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
* @ClassName: UserServiceImp.java
* @version: v1.0.0
* @author: 隆森
* @date: 2019年8月28日 下午3:59:43 
* @Description: 该类的功能描述
 */
@Service
@Transactional
public class UserServiceImp implements UserService{
    
	@Autowired
	UserMapper userMapper;
	@Autowired
	PersonMapper personMapper;
	@Autowired
	FileMapper fileMapper;
	
	@Override
	public String judgeUser(String name) {
		
		return userMapper.judgeUser(name);
	}

	
	@Override
	public int UserinsertSelective(User user) {
		userMapper.insertSelective(user);
		return 0;
	}

	@Override
	public int PersoninsertSelective(Person person) {
		personMapper.insertSelective(person);
		return 0;
	}
	
	@Override
	public int updateByPrimaryKeySelective(User user) {
		userMapper.updateByPrimaryKeySelective(user);
		return 0;
	}


	
	@Override
	public User selectIdByName(String name) {
		
		return userMapper.selectIdByName(name);
		
	}



	@Override
	public int updateHeadImg(String img,int id) {
		
		Person person = new Person();
		person.setPersonId(id);
		person.setPicture(img);
		return personMapper.updateByPrimaryKeySelective(person);
	}

	@Override
	public User selectById(Integer id) {
		return userMapper.selectByPrimaryKey(id);
	}

	@Override
	public Person selectPersonById(int id) {

		return personMapper.selectByPrimaryKey(id);
	}



	@Override
	public int updatePerson(Person person) {
		personMapper.updateByPrimaryKeySelective(person);
		return 0;
	}

	//激活用户  状态0到1 的改变
		@Override
		public int updateUserStatus(User user) {
			userMapper.updateByPrimaryKeySelective(user);
			return 0;
		}





	@Override
	public List<User> selectByPage(Integer status, int page, int pageSize) {
		int start = (page-1)*pageSize;
		return userMapper.selectByPage(status,start,pageSize);
	}

	@Override
	public int searchStatusCount(Integer status) {
		return userMapper.searchTypeCount(status);
	}

	@Override
	public String stopAndStart(Integer userId) {
		String result = "error";
		User user = userMapper.selectByPrimaryKey(userId);
		if(user.getUserStatus() == 1){
			user.setUserStatus(2);
		}else if(user.getUserStatus()==2){
			user.setUserStatus(1);
		}else {
			return result;
		}

		if (userMapper.updateByPrimaryKeySelective(user)==1)
			result = "success";

		return result;
	}

	@Override
	public int deleteMany(Integer[] id) {
		return userMapper.deleteMany(id);
	}

	@Override
	public int deleteById(Integer id) {
		return userMapper.deleteByPrimaryKey(id);
	}

	@Override
	public String resetUser(Integer userId) {
		String result = "error";
		if(userMapper.resetUserById(userId)==1)
			result = "success";
		return result;
	}

	@Override
	@Transactional
	public String updateUser(User user){
		String result = "error";
		try{
			userMapper.updateByPrimaryKeySelective(user);
			personMapper.updateByPrimaryKeySelective(user.getPerson());
			result = "success";

		}catch (Exception e){
			e.printStackTrace();
			result = "error";
			throw new RuntimeException("抛出异常，事务回滚");
		}

		return result;
	}

	@Override
	@Transactional
	public String insertUser(User user) {
		String result = "error";
		Person p = user.getPerson();
		user.setUserStatus(1);
		user.setTotalSize(500*1024*1024);
		user.setCreateDatetime(new Date());
		p.setPicture("web/images/defaultImg.jpg");
		try{
			personMapper.insertSelective(p);
			System.out.println(p.getPersonId());
            user.setPersonId(p.getPersonId());
			userMapper.insertSelective(user);
			result = "success";

		}catch (Exception e){
			e.printStackTrace();
			result = "error";
			throw new RuntimeException("插入用户数据出错抛出异常，事务回滚");
		}

		return result;
	}

	@Override
	public List<User> fuzzySearch(Integer status, int page, int pageSize, String key) {
		System.out.println(page+"------------");
		return userMapper.fuzzySearchByPage(status,key,(page-1)*pageSize,pageSize);
	}

	@Override
	public int fuzzySearchCount(Integer status, String key) {
		return userMapper.fuzzySearchTypeCount(status,key);
	}

	@Override
	public HashMap<String, Integer> sexInfo() {
		SexInfo result = personMapper.searchSex();
		HashMap<String,Integer> sexCount = new HashMap<String,Integer>();
		sexCount.put("男",result.getManNum());
		sexCount.put("女",result.getWoMn());
		sexCount.put("all",result.getSum());
		return  sexCount;
	}

	@Override
	public HashMap<String, Integer> ageInfo() {
		HashMap<String,Integer> result = new HashMap<String,Integer>();
		AgeInfo ageInfo = personMapper.searchAge();

		result.put("儿童",ageInfo.getChild());
		result.put("少年",ageInfo.getYoung());
		result.put("青年",ageInfo.getYouth());
		result.put("中年",ageInfo.getMiddle());
		result.put("老年",ageInfo.getOld());
		result.put("all",ageInfo.getSum());

		return result;
	}

	@Override
	public List<Person> findPersonByEamil() {

		return personMapper.selectAll();
	}



	@Override
	public Integer findIdByEmail(String email) {

		return personMapper.findIdByEmail(email);
	}


   	@Override
	public User findUserById(int userId) {

		return userMapper.selectByPrimaryKey(userId);
	}


	/* (non-Javadoc)
	 * @see com.qst.service.UserService#findAllFile(int)
	 */
	@Override
	public List<File> findAllFile(int cookieId) {
		
		return fileMapper.findAllFile(cookieId);
	}




}
