package com.qst.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.qst.entity.Directory;
import com.qst.entity.File;
import com.qst.entity.Page;
import com.qst.service.UserFileManager;

/**
 * @ClassName: UserFileManagerController.java
 * @version: v1.0.0
 * @author: hdq
 * @date: 2019年8月29日 上午10:16:09
 * @Description: 用户文件管理Controller
 */
@Controller
public class UserFileManagerController {
	@Autowired
	/** 文件管理Service */
	private UserFileManager s1;
	/** 子文件夹列表 */
	private List<Directory> list;
	/** 父文件夹列表 */
	private List<Directory> list2;
	/** 文件夹下所有文件 */
	private List<File> list3;
	/** 当前目录id */
	private int dId = 0;
	/** 当前页 */
	private int nowPage = 1;
	/** 总页数 */
	private int allPage;
	/** 每页长度 */
	private int pageSize = 10;
	/** 当前页文件夹和文件数量 */
	private int allNumber = 0;
   private int uId;
	/**
	 * 所有文件展示
	 * 
	 * @param pId
	 * @param nowPg
	 * @return
	 */
	@RequestMapping("toFileList.action")
	public ModelAndView toFileList(String pId, String nowPg,HttpServletRequest request) {
		uId=this.getCookieId(request);
		
		System.out.println(System.getProperty("webAppCloud"));
		System.out.print("【FindChidFile】    ");
		if (pId == null || pId == "") {
			dId = 0;
		} else {
			dId = Integer.parseInt(pId);
		}
		if (pId != null && pId != "") { 
			if (pId.equals("0")) {
				pId = "";
			}
		}
		// 获取子目录
		list = s1.findAllChidFile(dId, uId);
		// 获取父目录
		list2 = s1.findFather(pId);
		// 转化为路径
		String nameList = "";
		String idList = "";
		for (int i = list2.size() - 1; i >= 0; i--) {
			nameList = nameList + list2.get(i).getDirectoryName() + "/";
			idList = idList + list2.get(i).getDirectoryId() + "/";
		}
		String name = s1.findDir(pId).getDirectoryName();
		if (name != null) {
			nameList = nameList + name;
		}
		// 获取当前文件目录下文件
		if (nowPg == null || nowPg == "") {
			nowPage = 1;
		} else {
			nowPage = Integer.parseInt(nowPg);
		}


		allPage = s1.allFilePage(dId, uId, 100);

		System.out.println("now1Page:" + nowPage);

		list3 = s1.allFileList(dId, uId, nowPage, 100); 

		// 文件信息传入前台
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pId", dId);
		map.put("dirList", list);
		map.put("nameList", nameList);
		map.put("idList", idList);
		map.put("nowPage", nowPage);
		map.put("allPage", allPage);
		map.put("allNumber", allNumber);
		map.put("fileList", list3);
		System.out.println("DirListSize:" + list.size());
		System.out.println("FileListSize:" + list3.size());

		System.out.println("dirList：" + list);
		System.out.println("fileList：" + list3);

		return new ModelAndView("fileManager", map);
	}

	/**
	 * 跳转回收站
	 * 
	 * @param pId
	 * @param nowPg
	 * @return
	 */
	@RequestMapping("toRecycle.action")
	public ModelAndView toRecycle(HttpServletRequest request) {
		uId=this.getCookieId(request);
		System.out.println(System.getProperty("webAppCloud"));
		System.out.print("【find Recycle】:");
		list = s1.findRecycleDir(uId);
		list3 = s1.findRecycleFile(uId);

		// 文件信息传入前台
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("listFile", list3);
		map.put("listDir", list);
		return new ModelAndView("showRecycle", map);
	}

	/**
	 * 分类展示
	 * 
	 * @param type
	 * @param nowPg
	 * @return
	 */
	@RequestMapping("showForType.action")
	public ModelAndView showForType(String type, String nowPg,HttpServletRequest request) {
		uId=this.getCookieId(request);
		// System.out.println(System.getProperty("webAppCloud"));
		int chose = 0;
		if (type == null || type == "") {
			chose = 0;
		} else {
			chose = Integer.parseInt(type);
		}
		// 获取按类型文件
		if (nowPg == null || nowPg == "") {
			nowPage = 1;
		} else {
			nowPage = Integer.parseInt(nowPg);
		}

		allPage = s1.typeFilePage(chose, uId, pageSize);
		if (nowPage <= 1) {
			nowPage = 1;
		} else if (nowPage >= allPage) {
			nowPage = allPage;
		}
		System.out.println("type" + chose + "now1Page:" + nowPage);
		list3 = s1.typeFileList(chose, uId, nowPage, pageSize);
		// 文件信息传入前台
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pId", dId);
		map.put("dirList", list);
		map.put("nowPage", nowPage);
		map.put("allPage", allPage);
		map.put("allNumber", allNumber);
		map.put("fileList", list3);
		map.put("type", type);

		return new ModelAndView("showByType", map);
	}

	/**
	 * 添加文件夹/文件
	 * 
	 * @param pId
	 * @param dirName
	 * @param response
	 * @return
	 */
	@RequestMapping("addMyDir.action")
	public String addMyDir(String pId, String dirName, HttpServletResponse response,HttpServletRequest request) {
		response.setCharacterEncoding("utf-8");
		uId=this.getCookieId(request);
		System.out.println("uId"+uId);   
		System.out.println("【controller addDir】：pid=" + pId + "----dirName=" + dirName);
		if (pId != null && pId != "" && dirName != null && dirName != "") {
			s1.addMyDir(Integer.parseInt(pId), uId, dirName);
		}
		try {

			response.getWriter().print("success");

		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;

	}

	/**
	 * 移动到回收站
	 * 
	 * @param dirIdList
	 * @param fileIdList
	 * @param response
	 * @return
	 */
	@RequestMapping("moveToRecycle.action")
	public String moveToRecycle(String[] dirIdList, String[] fileIdList, HttpServletResponse response,HttpServletRequest request) {
		response.setCharacterEncoding("utf-8");
		System.out.println("【controller toTecycle】：dirList=" + dirIdList.length + "----fileList=" + fileIdList.length);
        uId=this.getCookieId(request);
		try {
			s1.moveToRecyle(dirIdList, fileIdList, uId);
			response.getWriter().print("success");

		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;

	}

	/**
	 * 恢复文件
	 * 
	 * @param dirIdList
	 * @param fileIdList
	 * @param response
	 * @return
	 */
	@RequestMapping("recoveryRecDir.action")
	public String recoveryRecDir(String[] dirIdList, String[] fileIdList, HttpServletResponse response,HttpServletRequest request) {
		uId=this.getCookieId(request);
		response.setCharacterEncoding("utf-8");
		System.out.println("【controller toTecycle】：dirList=" + dirIdList.length + "----fileList=" + fileIdList.length);

		try {
			s1.reRecyle(dirIdList, fileIdList, uId);
			response.getWriter().print("success");

		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;

	}

	/**
	 * 彻底删除
	 * 
	 * @param dirIdList
	 * @param fileIdList
	 * @param response
	 * @return
	 */
	@RequestMapping("deleteDir.action")
	public String deleteDir(String[] dirIdList, String[] fileIdList, HttpServletResponse response,HttpServletRequest request) {
		uId=this.getCookieId(request); 
		response.setCharacterEncoding("utf-8");
		System.out.println("【controller deleteDir】：dirList=" + dirIdList.length + "----fileList=" + fileIdList.length);

		try {
			s1.deleteRecDir(dirIdList, fileIdList, uId);
			response.getWriter().print("success");

		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;

	}

	/**
	 * 重命名
	 * 
	 * @param id
	 * @param type
	 * @param name
	 * @param response
	 * @return
	 */
	@RequestMapping("reName.action")
	public String reName(String id, String type, String name, HttpServletResponse response,HttpServletRequest request) {
		uId=this.getCookieId(request);
		response.setCharacterEncoding("utf-8");
		System.out.println("【controller reNamwe】：id=" + id + "----name=" + type + "--name:" + name);
		try {
			s1.reNameDirOrFile(id, type, name, uId);
			response.getWriter().print("success");

		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;

	}

	@RequestMapping("showTree.action")
	// @ResponseBody
	public ModelAndView getArticleType(String type, String[] dirList, String[] fileList,HttpServletRequest request) {
		uId=this.getCookieId(request);
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println("【controller showTree】：" + "----dir=" + dirList.length + "--file=" + fileList.length);
		List<String> dList = new ArrayList<>();
		List<String> fList = new ArrayList<>();
		for (String a : dirList) {
			dList.add(a);
		}
		for (String a : fileList) {
			fList.add(a);
		}

		// 拼接jason字符串
		List<Directory> list = s1.findAllDir(uId);
		String j = "[{\"id\":0,\"name\":\"全部文件\",\"pId\":0},";
		for (int i = 0; i < list.size(); i++) {
			j = j + "{\"id\":" + list.get(i).getDirectoryId() + ",\"name\":\"" + list.get(i).getDirectoryName()
					+ "\",\"pId\":" + list.get(i).getParentId() + " }";
			if (i < list.size() - 1) {
				j = j + ",";
			}
		}
		j = j + "]";

		map.put("listTree", j);
		map.put("type", type);
		map.put("dirList", dList);
		map.put("fileList", fList);
		return new ModelAndView("showTree", map);
	}

	/**
	 * 复制文件夹
	 * 
	 * @return
	 */
	@RequestMapping("copyDir.action")
	public String copyDir(String aimId, String[] dirList, String[] fileList, String status,
			HttpServletResponse response,HttpServletRequest request) {
		uId=this.getCookieId(request);
		response.setCharacterEncoding("utf-8");
		if (dirList[0].equals("[]")) {
			dirList = null;
		}
		if (fileList[0].equals("[]")) {
			fileList = null;
		}
		System.out.println("status:" + status);
		try {
			if (status == null) {
				int r = s1.dirAndFileHave(Integer.parseInt(aimId), dirList, fileList, uId);
				if (r != 1) {
					System.out.println("重复！");
					response.getWriter().print("have");

				}
			} else if (status.equals("yes")) {
				System.out.println("开始复制！");
				s1.copyDirOrFile(Integer.parseInt(aimId), dirList, fileList, uId);
				response.getWriter().print("success");
			}

		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;

	}

	/**
	 * 移动文件夹
	 * 
	 * @return
	 */
	@RequestMapping("moveDir.action")
	public String moveDir(String aimId, String[] dirList, String[] fileList, HttpServletResponse response,HttpServletRequest request) {
		response.setCharacterEncoding("utf-8");
		uId=this.getCookieId(request);
		if (dirList[0].equals("[]")) {
			dirList = null;
		}
		if (fileList[0].equals("[]")) {
			fileList = null;
		}
		System.out.println("【controller moveDir】：aimId=" + aimId + "----dir=" + dirList + "--file=" + fileList);
		try {

			int result = s1.moveDirOrFile(Integer.parseInt(aimId), dirList, fileList, uId);
			System.out.println("result" + result);
			if (result == -1) {
				response.getWriter().print("aim1");
			} else if (result == -2) { 
				response.getWriter().print("aim2");
			} else {
				response.getWriter().print("success");
			}

		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;

	}

	/**
	 * 分页模糊查找我的文件夹和文件
	 * 
	 * @param content
	 * @param pg
	 * @param model
	 * @return
	 */
	@RequestMapping("fuzzyFindMyFiles.action")
	public String fuzzyFindMyFiles(Integer userId, String content, Page pg, Model model,HttpServletRequest request) {
		if (content == null || content == "") {
			return "fileManager";  
		}
		uId=this.getCookieId(request);
		model.addAttribute("content", content);
		List<Directory> dirList = new ArrayList<Directory>();
		Directory dir = new Directory();
		dir.setDirectoryName(content);
		dir.setUserId(userId);
		Page pg1 = new Page();
		dirList = s1.fuzzyFindMyDirectorys(dir, pg1);
		System.out.println("dirList：" + dirList);
		model.addAttribute("dirList", dirList);
		List<File> fileList = new ArrayList<File>();
		File file = new File();
		file.setFileName(content);
		file.setUserId(userId);
		fileList = s1.fuzzyFindMyFiles(file, pg1);
		System.out.println("fileList：" + fileList);
		model.addAttribute("fileList", fileList);
		return "fileManager";
	}
	/**
	 * 文件展示
	 * @param type
	 * @param path
	 * @return
	 */
	@RequestMapping("showFile.action")
	public ModelAndView showFile(String type,String path) {
		System.out.println("type:"+type+"path"+path);
		   Map<String, Object> map = new HashMap<String, Object>(); 
			map.put("type",type); 
			map.put("path", path);
			return new ModelAndView("showFile", map); 
		} 

	// 写一个方法 获取id的方法
		public int getCookieId(HttpServletRequest request) {
			Cookie[] cookie = request.getCookies();
			int id = 0;
			for (Cookie co : cookie) {
				if (co.getName().equals("userId")) {
					id = Integer.parseInt(co.getValue());
				}

			}
			return id;
		}
}
