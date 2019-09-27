/**
 * 
 */
package com.qst.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.qst.aspect.LoginType;
import com.qst.entity.File;
import com.qst.entity.Page;
import com.qst.entity.User;
import com.qst.service.FileService;
import com.qst.service.UserService;

/**
 * @ClassName: FileController.java
 * @version: v1.0.0
 * @author: ZYL
 * @date: 2019年8月29日 下午9:46:17
 * @Description: 后台管理所有文件
 */
@LoginType
@Controller
public class FileController {
	@Autowired
	private FileService fileService;
	@Autowired
	UserService userService;

	/**
	 * 管理员分页查询所有文件
	 * 
	 * @param pg
	 * @param fileStatus
	 * @param model
	 * @return
	 */
	@RequestMapping("findAllFilesByPage.action")
	public String findAllFilesByPage(Integer fileStatus, Page pg, Model model) {
		model.addAttribute("fileType", 0);
		System.out.println("fileStatus：" + fileStatus);
		if (fileStatus == 0) {
			fileStatus = null;
			model.addAttribute("fileStatus", 0);
		} else {
			model.addAttribute("fileStatus", fileStatus);
		}
		List<File> fileList = new ArrayList<File>();
		int fileTotal = fileService.findFileTotal(fileStatus);
		System.out.println("fileTotal：" + fileTotal);
		if (fileTotal == 0) {
			return "../back/user-file-list";
		}
		int totalPage = 0;// 总页数
		int nowPage = pg.getPage() / pg.getPageSize() + 1;// 当前页
		if (fileTotal % pg.getPageSize() == 0) {
			totalPage = fileTotal / pg.getPageSize();
		} else {
			totalPage = fileTotal / pg.getPageSize() + 1;
		}
		if (nowPage < 1) {
			nowPage = 1;
			pg.setPage(1);
		} else if (nowPage > totalPage) {
			nowPage = totalPage;
			pg.setPage(totalPage);
		}
		System.out.println("pg：" + pg);
		fileList = fileService.findAllFilesByPage(fileStatus, pg);
		System.out.println(fileList);
		model.addAttribute("fileList", fileList);
		model.addAttribute("fileTotal", fileTotal);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("totalPage", totalPage);
		return "../back/user-file-list";
	}

	/**
	 * 管理员根据文件类型分页查询文件
	 * 
	 * @param fileType
	 * @param fileStatus
	 * @param pg
	 * @param model
	 * @return
	 */
	@RequestMapping("findFilesByType.action")
	public String findFilesByType(File file, Page pg, Model model) {
		System.out.println("fileType：" + file.getFileType());
		System.out.println("fileStatus：" + file.getFileStatus());
		System.out.println(pg);
		if (file.getFileType().equals("0")) {
			file.setFileType(null);
			model.addAttribute("fileType", 0);
		} else {
			model.addAttribute("fileType", file.getFileType());
		}
		if (file.getFileStatus() == 0) {
			file.setFileStatus(null);
			model.addAttribute("fileStatus", 0);
		} else {
			model.addAttribute("fileStatus", file.getFileStatus());
		}
		int fileTotal = fileService.findFileTotalByType(file);
		System.out.println("fileTotal：" + fileTotal);
		if (fileTotal == 0) {
			return "../back/user-file-list";
		}
		int totalPage = 0;// 总页数
		int nowPage = pg.getPage() / pg.getPageSize() + 1;// 当前页
		if (fileTotal % pg.getPageSize() == 0) {
			totalPage = fileTotal / pg.getPageSize();
		} else {
			totalPage = fileTotal / pg.getPageSize() + 1;
		}
		if (nowPage < 1) {
			nowPage = 1;
			pg.setPage(1);
		} else if (nowPage > totalPage) {
			nowPage = totalPage;
			pg.setPage(totalPage);
		}
		System.out.println(pg);
		List<File> fileList = new ArrayList<File>();
		fileList = fileService.findFilesByType(file, pg);
		System.out.println(fileList);
		model.addAttribute("fileList", fileList);
		model.addAttribute("fileTotal", fileTotal);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("totalPage", totalPage);
		return "../back/user-file-list";
	}

	/**
	 * 启用/禁用文件
	 * 
	 * @param file
	 * @param fileId
	 * @param fileStatus
	 * @return
	 */
	@RequestMapping("changeFileStatus.action")
	public String changeFileStatus(File file) {
		fileService.changeFileStatus(file);
		System.out.println(file);
		return "../back/user-file-list";
	}

	/**
	 * 彻底删除文件
	 * 
	 * @param fileIdList
	 * @return
	 */
	@RequestMapping("deleteFile.action")
	public String deleteFile(String[] fileIdList) {
		for (int i = 0; i < fileIdList.length; i++) {
			System.out.println("fileId：" + fileIdList[i]);
			fileService.deleteFile(Integer.parseInt(fileIdList[i]));
		}
		return "../back/user-file-list";
	}

	/**
	 * 管理员按文件属性模糊查找文件
	 * 
	 * @param attribute
	 * @param findAttribute
	 * @param file
	 * @param pg
	 * @param model
	 * @return
	 * @throws ParseException
	 */
	@RequestMapping("findFileByAttribute.action")
	public String findFileByAttribute(String startTime, String endTime, String content, Integer findAttribute,
			File file, Page pg, Model model) throws ParseException {
		System.out.println("startTime：" + startTime);
		System.out.println("endTime：" + endTime);
		System.out.println("content：" + content);
		System.out.println("findAttribute：" + findAttribute);
		System.out.println(pg);
		model.addAttribute("startTime", startTime);
		model.addAttribute("endTime", endTime);
		model.addAttribute("content", content);
		model.addAttribute("findAttribute", findAttribute);
		if (content == "" || startTime == "" || endTime == "") {
			return "../back/user-file-list";
		}
		// 格式化日期
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		Date sTime = df.parse(startTime);
		Date eTime = df.parse(endTime);
		// 日期+1天
		Calendar c = Calendar.getInstance();
		c.setTime(eTime);
		c.add(Calendar.DAY_OF_MONTH, 1);
		eTime = c.getTime();
		System.out.println("date：" + sTime + "~~~" + eTime);
		if (findAttribute == 1) {
			file.setFileName(content);
		} else if (findAttribute == 2) {
			file.setUserName(content);
		} else if (findAttribute == 3) {
			file.setUploadIp(content);
		}
		System.out.println(file);
		int fileTotal = fileService.findFileTotalByAttribute(sTime, eTime, file);
		System.out.println("fileTotal：" + fileTotal);
		if (fileTotal == 0) {
			return "../back/user-file-list";
		}
		int totalPage = 0;// 总页数
		int nowPage = pg.getPage() / pg.getPageSize() + 1;// 当前页
		if (fileTotal % pg.getPageSize() == 0) {
			totalPage = fileTotal / pg.getPageSize();
		} else {
			totalPage = fileTotal / pg.getPageSize() + 1;
		}
		if (nowPage < 1) {
			nowPage = 1;
			pg.setPage(1);
		} else if (nowPage > totalPage) {
			nowPage = totalPage;
			pg.setPage(totalPage);
		}
		List<File> fileList = new ArrayList<File>();
		fileList = fileService.findFilesByAttribute(sTime, eTime, file, pg);
		System.out.println(fileList);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("fileTotal", fileTotal);
		model.addAttribute("fileList", fileList);
		return "../back/user-file-list";
	}

	/**
	 * 管理员查询用户信息
	 * 
	 * @param userId
	 * @param model
	 * @return
	 */
	@RequestMapping("findUser.action")
	public String findUser(Integer userId, Model model) {
		User user = userService.selectById(userId);
		System.out.println("user：" + user);
		model.addAttribute("user", user);
		return "../back/member-show";
	}

}
