/**
 * 
 */
package com.qst.serviceImp;

import com.qst.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qst.entity.Admin;
import com.qst.mapper.AdminMapper;
import com.qst.service.AdminService;

/**
* @ClassName: AdminServiceImp.java
* @version: v1.0.0
* @author: CGL
* @date: 2019年8月28日 下午3:08:40 
* @Description:   后台管理员服务层接口实现
 */
@Service
public class AdminServiceImp implements AdminService{
	
	
	@Autowired
	private AdminMapper mapper;

	@Override
	public int login(Admin v) {
		Admin admin = mapper.selectByName(v.getAdminName());
		if(admin==null){
			return 0;
		}else {
			if(admin.getAdminPassword().equalsIgnoreCase(v.getAdminPassword())){
				return 1;
			}else
				return -1;
		}
	}

	/* (non-Javadoc)
	 * @see com.qst.service.AdminService#addAdmin(com.qst.entity.Admin)
	 */
	@Override
	public int addAdmin(Admin v) {
		return mapper.insert(v);
	}

	@Override
	public int deleteById(Integer id) {
		return mapper.deleteByPrimaryKey(id);
	}

	@Override
	public int deleteMany(Integer[] id) {
		return 0;
	}

	@Override
	public int updateById(User vo) {
		return 0;
	}

}
