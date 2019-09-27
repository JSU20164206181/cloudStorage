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

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.qst.aspect.LoginMethod;
import com.qst.entity.Directory;
import com.qst.entity.File;
import com.qst.entity.Page;
import com.qst.entity.Share;
import com.qst.service.FileService;
import com.qst.service.ShareService;
import com.qst.service.UserFileManager;
import com.qst.service.UserService;

/**
 * @ClassName: ShareController.java
 * @version: v1.0.0
 * @author: ZYL
 * @date: 2019年9月6日 上午9:13:32
 * @Description: 后台管理所有分享文件
 */
@Controller
public class ShareController {
	@Autowired
	private ShareService shareService;
	@Autowired
	private UserFileManager userFileManager;
	@Autowired
	private FileService fileService;
	@Autowired
	private UserService userService;

	/**
	 * 管理员分页查询所有分享文件
	 * 
	 * @param pg
	 * @param model
	 * @return
	 */
	@LoginMethod
	@RequestMapping("findAllSharesByPage.action")
	public String findAllSharesByPage(Page pg, Model model) {
		model.addAttribute("shareStatus", 0);
		model.addAttribute("validDate", 0);
		int shareTotal = shareService.findSharesTotal();
		System.out.println("shareTotl：" + shareTotal);
		model.addAttribute("shareTotal", shareTotal);
		if (shareTotal == 0) {
			return "../back/user-share-list";
		}
		int totalPage = 0;// 总页数
		int nowPage = pg.getPage() / pg.getPageSize() + 1;// 当前页
		if (shareTotal % pg.getPageSize() == 0) {
			totalPage = shareTotal / pg.getPageSize();
		} else {
			totalPage = shareTotal / pg.getPageSize() + 1;
		}
		if (nowPage < 1) {
			nowPage = 1;
			pg.setPage(1);
		} else if (nowPage > totalPage) {
			nowPage = totalPage;
			pg.setPage(totalPage);
		}
		System.out.println("pg：" + pg);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("totalPage", totalPage);
		List<Share> shareList = new ArrayList<Share>();
		shareList = shareService.findAllSharesByPage(pg);
		System.out.println("shareList：" + shareList);
		model.addAttribute("shareList", shareList);
		return "../back/user-share-list";
	}

	/**
	 * 管理员根据分享文件类型分页查询文件
	 * 
	 * @param share
	 * @param pg
	 * @param model
	 * @return
	 */
	@LoginMethod
	@RequestMapping("findSharesByType.action")
	public String findSharesByType(Share share, Page pg, Model model) {
		System.out.println("shareStatus：" + share.getShareStatus());
		System.out.println("validDate：" + share.getValidDate());
		System.out.println(pg);
		if (share.getShareStatus() == 0) {
			share.setShareStatus(null);
			model.addAttribute("shareStatus", 0);
		} else {
			model.addAttribute("shareStatus", share.getShareStatus());
		}
		if (share.getValidDate() == 0) {
			share.setValidDate(null);
			model.addAttribute("validDate", 0);
		} else {
			model.addAttribute("validDate", share.getValidDate());
		}
		int shareTotal = shareService.findSharesTotalByType(share);
		System.out.println("shareTotal：" + shareTotal);
		model.addAttribute("shareTotal", shareTotal);
		if (shareTotal == 0) {
			return "../back/user-share-list";
		}
		int totalPage = 0;// 总页数
		int nowPage = pg.getPage() / pg.getPageSize() + 1;// 当前页
		if (shareTotal % pg.getPageSize() == 0) {
			totalPage = shareTotal / pg.getPageSize();
		} else {
			totalPage = shareTotal / pg.getPageSize() + 1;
		}
		if (nowPage < 1) {
			nowPage = 1;
			pg.setPage(1);
		} else if (nowPage > totalPage) {
			nowPage = totalPage;
			pg.setPage(totalPage);
		}
		System.out.println(pg);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("totalPage", totalPage);
		List<Share> shareList = new ArrayList<Share>();
		shareList = shareService.findSharesByType(share, pg);
		System.out.println(shareList);
		model.addAttribute("shareList", shareList);
		return "../back/user-share-list";
	}

	/**
	 * 取消/删除分享
	 * 
	 * @param shareIdList
	 * @return
	 */
	@LoginMethod
	@RequestMapping("deleteShare.action")
	public String deleteShare(String[] shareIdList) {
		for (int i = 0; i < shareIdList.length; i++) {
			System.out.println("fileId：" + shareIdList[i]);
			shareService.deleteShare(Integer.parseInt(shareIdList[i]));
		}
		return "../back/user-share-list";
	}

	/**
	 * 管理员按分享文件属性模糊查找文件
	 * 
	 * @param startTime
	 * @param endTime
	 * @param content
	 * @param findAttribute
	 * @param share
	 * @param pg
	 * @param model
	 * @return
	 * @throws ParseException
	 */
	@LoginMethod
	@RequestMapping("findSharesByAttribute.action")
	public String findSharesByAttribute(String startTime, String endTime, String content, Integer findAttribute,
			Share share, Page pg, Model model) throws ParseException {
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
			return "../back/user-share-list";
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
			share.setShareName(content);
		} else if (findAttribute == 2) {
			share.setUserName(content);
		}
		System.out.println(share);
		int shareTotal = shareService.findSharesTotalByAttribute(sTime, eTime, share);
		System.out.println("shareTotal：" + shareTotal);
		model.addAttribute("shareTotal", shareTotal);
		if (shareTotal == 0) {
			return "../back/user-share-list";
		}
		int totalPage = 0;// 总页数
		int nowPage = pg.getPage() / pg.getPageSize() + 1;// 当前页
		if (shareTotal % pg.getPageSize() == 0) {
			totalPage = shareTotal / pg.getPageSize();
		} else {
			totalPage = shareTotal / pg.getPageSize() + 1;
		}
		if (nowPage < 1) {
			nowPage = 1;
			pg.setPage(1);
		} else if (nowPage > totalPage) {
			nowPage = totalPage;
			pg.setPage(totalPage);
		}
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("totalPage", totalPage);
		List<Share> shareList = new ArrayList<Share>();
		shareList = shareService.findSharesByAttribute(sTime, eTime, share, pg);
		System.out.println(shareList);
		model.addAttribute("shareList", shareList);
		return "../back/user-share-list";
	}

	/**
	 * 用户创建分享
	 * 
	 * @param dirList
	 * @param fileList
	 * @param share
	 * @return
	 */
	@RequestMapping("addShare.action")
	public String addShare(String dirList, String fileList, Share share) {
		System.out.println(share);
		String[] dirs = dirList.split(",");
		String[] files = fileList.split(",");
		System.out.print("dir：");
		if (dirList.equals("")) {
			dirs = new String[0];
		} else {
			for (String dir : dirs) {
				System.out.print(dir + " ");
			}
			System.out.println();
		}
		System.out.println("dirLength：" + dirs.length);
		System.out.print("file：");
		if (fileList.equals("")) {
			files = new String[0];
		} else {
			for (int i = 0; i < files.length; i++) {
				System.out.print(files[i] + " ");
			}
			System.out.println();
		}
		System.out.println("fileLength：" + files.length);
		if ((dirs.length > 0 && files.length > 0) || (dirs.length > 1 && files.length == 0)) {// 一个或多个文件和一个或多个文件夹；多个文件夹
			share.setShareName(
					userFileManager.findDir(dirs[0]).getDirectoryName() + "等" + (dirs.length + files.length) + "个文件");
		} else if (dirs.length == 1 && files.length == 0) {// 一个文件夹
			share.setShareName(userFileManager.findDir(dirs[0]).getDirectoryName());
		} else if (files.length == 1 && dirs.length == 0) {// 一个文件
			share.setShareName(fileService.findFile(Integer.parseInt(files[0])).getFileName());
		} else if (files.length > 1 && dirs.length == 0) {// 多个文件
			share.setShareName(fileService.findFile(Integer.parseInt(files[0])).getFileName() + " 等"
					+ (dirs.length + files.length) + "个文件");
		}
		// share.setShareUrl("112.91.182.26");
		share.setShareUrl("/");
		share.setCreateDatetime(new Date());
		share.setFileId(fileList);
		share.setDirectoryId(dirList);
		share.setUserName(userService.findUserById(share.getUserId()).getUserName());
		share.setPersonId(userService.findUserById(share.getUserId()).getPersonId());
		if (share.getShareStatus() == 2) {
			String command = RandomStringUtils.randomAlphanumeric(4);
			System.out.println("提取码：" + command);
			share.setShareCommand(command);
		}
		System.out.println("share：" + share);
		shareService.addShare(share);
		System.out.println(share.getShareId());
		share.setShareUrl("http://127.0.0.1:8080/cloudStorage/viewShare.action?url=" + share.getShareId()
				+ RandomStringUtils.randomAlphanumeric(9));
		shareService.updateShare(share);
		System.out.println("share：" + share);
		return "redirect:/toFileList.action";
	}

	/**
	 * 查看某个分享
	 * 
	 * @param url
	 * @param model
	 * @return
	 */
	@RequestMapping("viewShare.action")
	public String viewShare(String url, String status, Model model) {
		if (url.length() <= 50) {
			url = "http://127.0.0.1:8080/cloudStorage/viewShare.action?url=" + url;
		}
		System.out.println("url：" + url);
		Share share = new Share();
		share = shareService.findShareByUrl(url);
		System.out.println("share：" + share);
		String[] dirIdList;
		String[] fileIdList;
		List<Directory> dirList = new ArrayList<>();
		List<File> fileList = new ArrayList<>();
		System.out.print("dir：");
		if (share.getDirectoryId().equals("")) {
			dirIdList = new String[0];
		} else {
			dirIdList = share.getDirectoryId().split(",");
			for (int i = 0; i < dirIdList.length; i++) {
				System.out.print(dirIdList[i] + " ");
				dirList.add(userFileManager.findDir(dirIdList[i]));
			}
			System.out.println();
			System.out.println("dirList：" + dirList);
		}
		System.out.println("dirIdList.length：" + dirIdList.length);
		System.out.print("file：");
		if (share.getFileId().equals("")) {
			fileIdList = new String[0];
		} else {
			fileIdList = share.getFileId().split(",");
			for (int i = 0; i < fileIdList.length; i++) {
				System.out.print(fileIdList[i] + " ");
				fileList.add(fileService.findFile(Integer.parseInt(fileIdList[i])));
			}
			System.out.println();
			System.out.println("fileList：" + fileList);
		}
		System.out.println("fileIdList.length：" + fileIdList.length);

		model.addAttribute("share", share);
		model.addAttribute("dirList", dirList);
		model.addAttribute("fileList", fileList);
		if (status == null || status == "") {
			status = "0";
		}
		if (share.getShareStatus() == 2 && !status.equals("1")) {
			return "../jsp/input-command";
		} else {
			return "../jsp/show-share-file";
		}
	}

	/**
	 * 查询我的分享
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("findMyShares.action")
	public String findMyShares(HttpServletRequest request, Model model) {
		Cookie[] cookie = request.getCookies();
		int userId = 0;
		for (Cookie co : cookie) {
			if (co.getName().equals("userId")) {
				userId = Integer.parseInt(co.getValue());
			}
		}
		System.out.println("userId：" + userId);
		List<Share> shareList = new ArrayList<>();
		shareList.addAll(shareService.findMyShares(userId));
		System.out.println(shareList);
		model.addAttribute("shareList", shareList);
		return "../jsp/my-share";
	}
	
	@RequestMapping("deleteMyShare.action")
	public String deleteMyShare(String[] shareIdList) {
		for (int i = 0; i < shareIdList.length; i++) {
			System.out.println("fileId：" + shareIdList[i]);
			shareService.deleteShare(Integer.parseInt(shareIdList[i]));
		}
		return "../jsp/my-share";
	}

}
