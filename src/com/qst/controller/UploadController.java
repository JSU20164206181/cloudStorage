/**
 * 
 */
package com.qst.controller;


import java.io.File;
import java.io.FileFilter;
import java.io.FileInputStream;
import java.io.FileOutputStream;

import java.nio.channels.FileChannel;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;

import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.qst.entity.FileChunk;
import com.qst.entity.User;
import com.qst.service.FileChunkService;
import com.qst.service.UserFileManager;
import com.qst.service.UserService;
import com.sun.jmx.snmp.Timestamp;

import net.sf.json.JSON;
import net.sf.json.JSONObject;








/**
 * @ClassName:UploadController.java
 * @version:v1.0.0
 * @author:mwy
 * @date:2019年9月1日 下午5:34:55
 * @Description:文件上传控制器
 */
@Controller
public class UploadController {
	@Autowired
	private FileChunkService fileChunkService;
	@Autowired
	private UserFileManager fileService;
	@Autowired
	private UserService userService;
	private String nowDate = this.getNowDate();
	private String savePath =System.getProperty("cloud.root")+"../cloudUpload/"+nowDate;
	private String sqlPath = "../cloudUpload/"+nowDate;
	
	
	/**
	 * 文件上传
	 * @param files
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(method = {RequestMethod.POST}, value = {"/webUploader"})
	@ResponseBody
	public void webUploader(@RequestParam(value = "file") MultipartFile files[],HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		String fileMd5 = request.getParameter("fileMd5");
		String chunk = request.getParameter("chunk");
		File file = new File(savePath + "/" + fileMd5);
		
		if (!file.exists()) {
			file.mkdir();
		}
		File chunkFile = new File(savePath + "/" + fileMd5 + "/" + chunk);
		FileUtils.copyInputStreamToFile(files[0].getInputStream(), chunkFile);
	}
	/**
	 * 文件分块 合并
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(method = {RequestMethod.POST}, value = {"/checkFile"})
	@ResponseBody
	public void checkFile(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//System.out.println(request.getParameterMap());
		
		String action = request.getParameter("action");
		if (action.equals("mergeChunks")) {
			int userId = getCookieId(request);
			User user = userService.findUserById(userId);
			String username = user.getUserName();
			int personId = user.getPersonId();
			
			
			
			// 合并文件
			// 需要合并的文件的目录标记
			String fileMd5 = request.getParameter("fileMd5");
			String fileSuffix=request.getParameter("fileSuffix");
			String fileName = request.getParameter("fileName");
			int fileSize = Integer.parseInt(request.getParameter("fileSize"));
			int fileType = 6;
			if(fileSuffix.equals("txt")||fileSuffix.equals("doc")||fileSuffix.equals("hlp")||fileSuffix.equals("wps")||fileSuffix.equals("rtf")||fileSuffix.equals("html")||fileSuffix.equals("pdf")){
				fileType = 3;
			}else if(fileSuffix.equals("bmp")||fileSuffix.equals("gif")||fileSuffix.equals("jpg")||fileSuffix.equals("pic")||fileSuffix.equals("png")||fileSuffix.equals("tif")){
				fileType = 1;
			}else if(fileSuffix.equals("wav")||fileSuffix.equals("aif")||fileSuffix.equals("au")||fileSuffix.equals("mp3")||fileSuffix.equals("ram")||fileSuffix.equals("wma")){
				fileType = 4;
			}else if(fileSuffix.equals("avi")||fileSuffix.equals("mpg")||fileSuffix.equals("mov")||fileSuffix.equals("swf")||fileSuffix.equals("mp4")){
				fileType = 2;
			}else if(fileSuffix.equals("torrent")){
				fileType = 5;
			}
			
			// 读取目录里的所有文件
			File f = new File(savePath + "/" + fileMd5);
			File[] fileArray = f.listFiles(new FileFilter() {
				// 排除目录只要文件
				public boolean accept(File pathname) {
					if (pathname.isDirectory()) {
						return false;
					}
					return true;
				}
			});

			// 转成集合，便于排序
			List<File> fileList = new ArrayList<File>(Arrays.asList(fileArray));
			Collections.sort(fileList, new Comparator<File>() {
				public int compare(File o1, File o2) {
					if (Integer.parseInt(o1.getName()) < Integer.parseInt(o2
							.getName())) {
						return -1;
					}
					return 1;
				}
			});
			// UUID.randomUUID().toString()-->随机名
			File outputFile = new File(savePath + "/" + fileMd5 + "."+fileSuffix);
			// 创建文件
			outputFile.createNewFile();
			// 输出流
			FileChannel outChnnel = new FileOutputStream(outputFile).getChannel();
			// 合并
			FileChannel inChannel;
			for (File file : fileList) {
				inChannel = new FileInputStream(file).getChannel();
				inChannel.transferTo(0, inChannel.size(), outChnnel);
				inChannel.close();
				// 删除分片
				file.delete();
			}
			outChnnel.close();
			// 清除文件夹
			File tempFile = new File(savePath + "/" + fileMd5);
			if (tempFile.isDirectory() && tempFile.exists()) {
				tempFile.delete();
			}
		
			com.qst.entity.File uploadFile = new com.qst.entity.File(userId,username,new Date(),"127.0.0.1",fileName,fileSize/1024,fileType+"",sqlPath+"/"+outputFile.getName(),personId,0,1);
			if(fileService.addFile(uploadFile)>0){
				System.out.println("添加数据库成功");
			}
			System.out.println("合并成功");
		} else if (action.equals("checkChunk")) {
			// 检查当前分块是否上传成功
			
			String fileMd5 = request.getParameter("fileMd5");
			String chunk = request.getParameter("chunk");
			String chunkSize = request.getParameter("chunkSize");
			
			//更新文件块信息到数据库
			//System.out.println(fileChunk.toString());
			//fileChunkService.insert(fileChunk);
			
			File checkFile = new File(savePath + "/" + fileMd5 + "/" + chunk);
			
			
			response.setContentType("text/html;charset=utf-8");
			// 检查文件是否存在，且大小是否一致
			if (checkFile.exists()
					&& checkFile.length() == Integer.parseInt(chunkSize)) {
				// 上传过
				response.getWriter().write("{\"ifExist\":1}");
			} else {
				// 没有上传过
				response.getWriter().write("{\"ifExist\":0}");
			}
		}

	}
	/**
	 * 文件块添加数据库 未完成
	 * @param request
	 * @param response
	 * @param fileChunk
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(method = {RequestMethod.POST}, value = {"/addFileChunk"})
	@ResponseBody
	public String addFileChunk(HttpServletRequest request, HttpServletResponse response,FileChunk fileChunk) throws Exception {
		int userId = 10001;
		
		fileChunk.setUserId(userId);
		fileChunk.setFilePath(savePath);
		System.out.println("##########"+fileChunk.toString());
		int num = fileChunkService.insert(fileChunk);
		
		if(num>0){
			System.out.println("文件块添加成功");
		}
		
		String msg = "success";
		
		return msg;
	}
	/**
	 * 文件块查询 未完成
	 * @param request
	 * @param response
	 * @param fileChunk
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(method = {RequestMethod.POST}, value = {"/getFileChunkList"})
	public String getFileChunkList(HttpServletRequest request, HttpServletResponse response,FileChunk fileChunk) throws Exception {
		int userId = 10001;
		List<FileChunk> fileChunkList = fileChunkService.selectByStatus(1,userId);
		return "jsp/user/index";
		
	}
	/**
	 * 获取当前时间
	 * @return
	 */
	public String getNowDate(){
		Date data = new Date();
		 SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");   
		 return sdf.format(data);   
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
