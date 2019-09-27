/**
 * 
 */
package com.qst.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.qst.entity.Admin;
import com.qst.service.AdminService;

/**
* @ClassName: AdminTest.java
* @version: v1.0.0
* @author: CGL
* @date: 2019年8月28日 下午3:10:05 
* @Description: 该类的功能描述
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:spring/spring-dao.xml","classpath:spring/spring-mvc.xml"})
public class AdminTest {


	@Autowired
	private AdminService service;

	@Test
	public void add() {
		Admin admin = new Admin("admin", "123456");
		service.addAdmin(admin);
	}

    @Test
    public void rootTest() {
	    String root = System.getProperty("cloud.root");
        System.out.println(root);
    }

	@Test
	public void selectTest() {
		Admin admin1 = new Admin("admin", "1234567");
		int result = service.login(admin1);
		System.out.println(result);
	}
}
