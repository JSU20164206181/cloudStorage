/**
 * 
 */
package com.qst.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.DataOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.qst.entity.Directory;
import com.qst.entity.File;
import com.qst.service.UserFileManager;
import com.qst.util.ZipUtils;

import javafx.concurrent.Worker;


/**
 * @ClassName:DownloadFile.java
 * @version:v1.0.0
 * @author:mwy
 * @date:2019年9月10日 下午7:06:54
 * @Description:文件下载
 */
@Controller
public class DownloadController {
	@Autowired
	private UserFileManager fileService;

	/**
	 * 文件下载
	 * 
	 * @param request
	 * @param response
	 * @param fileId
	 * @throws IOException
	 */
	@RequestMapping("/downloadFile")
	public void downloadFile(HttpServletRequest request, HttpServletResponse response, int fileId)
			throws IOException {
		File file = fileService.findById(fileId);
		String name = file.getFileName();
		String destUrl = file.getFilePath();
		System.out.println(name);
		// 建立链接
		InputStream is = new FileInputStream(destUrl);
		// 获取网络输入流
		BufferedInputStream bis = new BufferedInputStream(is);

		response.setContentType("multipart/form-data");
		response.setHeader("Content-Disposition", "attachment; filename=" + name);
		OutputStream out = response.getOutputStream();
		byte[] buf = new byte[1024];
		if (name != null) {
			BufferedInputStream br = bis;
			int len = 0;
			while ((len = br.read(buf)) > 0) {
				out.write(buf, 0, len);
			}
			br.close();
		}
		out.flush();
		out.close();

	}

	/**
	 * 文件夹压缩下载
	 * 
	 * @param request
	 * @param response
	 * @param directoryId
	 * @throws IOException
	 */
	@RequestMapping("/downloadDir")
	public void downloadDir(HttpServletRequest request, HttpServletResponse response, int directoryId)
			throws IOException {
		int uid = getCookieId(request);
		System.out.println("获取文件树");
		List<java.io.File> fileList = new ArrayList<java.io.File>();
		Directory dir = fileService.findDirById(directoryId);
		String dirPath = dir.getDirectoryName();
		findChildren(directoryId,uid,dirPath,fileList);
		
		
		//响应头的设置
        response.reset();
        response.setCharacterEncoding("utf-8");
        response.setContentType("multipart/form-data");
        //设置压缩包的名字
         //解决不同浏览器压缩包名字含有中文时乱码的问题
        HttpSession session = request.getSession();
 
        String billname =dir.getDirectoryName();
        String downloadName = billname+".zip";
        //返回客户端浏览器的版本号、类型
        String agent = request.getHeader("USER-AGENT");  
        try {
        	//针对IE或者以IE为内核的浏览器：  
            if (agent.contains("MSIE")||agent.contains("Trident")) {
                downloadName = java.net.URLEncoder.encode(downloadName, "UTF-8");
            } else {
            	//非IE浏览器的处理：
                downloadName = new String(downloadName.getBytes("UTF-8"),"ISO-8859-1");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.setHeader("Content-Disposition", "attachment;fileName=\"" + downloadName + "\"");
        ZipUtils.toZip(fileList, response.getOutputStream());
		
	}
	/**
	 * 查询所有子文件
	 * @param directoryId
	 * @param uid
	 * @param dirPath
	 * @param fileList
	 * @throws IOException 
	 */
	public void findChildren(int directoryId,int uid,String dirPath, List<java.io.File> fileList) throws IOException{
		
		List<Directory> childDirList = fileService.findAllChidFile(directoryId, uid);
		List<File> thisDirFileList = fileService.findFileListByDirId(directoryId);
		java.io.File newDir = new java.io.File(dirPath);
		
		fileList.add(newDir);
		if (thisDirFileList != null) {
			for (int j = 0; j < thisDirFileList.size(); j++) {
				java.io.File oldFile = new java.io.File(thisDirFileList.get(j).getFilePath());
				java.io.File newFile = new java.io.File(dirPath + "/" + thisDirFileList.get(j).getFileName());
				
				FileUtils.copyFile(oldFile, newFile);
				fileList.add(newFile);
			}
		} 
		if (childDirList != null) {
			for (int i = 0; i < childDirList.size(); i++) {
				findChildren(childDirList.get(i).getDirectoryId(), uid, dirPath + "/" + childDirList.get(i).getDirectoryName(), fileList);
			}
		}
		
		
	}
	/**
	 *多文件和文件夹压缩
	 * @param request
	 * @param response
	 * @param filename
	 * @param filepath
	 * @param documentname
	 * @param loginname
	 * @throws IOException 
	 */
	@RequestMapping("/batchDownLoadFile")
	public void batchDownLoadFile(HttpServletRequest request, HttpServletResponse response, int filesId[], int dirsId[], int thisDirId) throws IOException {
		int uid = getCookieId(request);
		System.out.println("获取文件树");
		System.out.println();
		List<java.io.File> fileList = new ArrayList<java.io.File>();
		Directory dir = new Directory();
		dir.setDirectoryName("root");
		String dirPath = "root";
		if(thisDirId!=0){
			dir = fileService.findDirById(thisDirId);
			dirPath = dir.getDirectoryName();
		}
		
		for(int i = 0; i < filesId.length; i++){
			File fileEntity = fileService.findById(filesId[i]);
			java.io.File oldFile = new java.io.File(fileEntity.getFilePath());
			java.io.File newFile = new java.io.File(dirPath + "/" + fileEntity.getFileName());
			FileUtils.copyFile(oldFile, newFile);
			fileList.add(newFile);
		}
		for(int i = 0; i < dirsId.length; i++){
			Directory thisDir = fileService.findDirById(dirsId[i]);
			findChildren(dirsId[i],uid,dirPath+"/"+thisDir.getDirectoryName(),fileList);
		}
		System.out.println(fileList.toString());
		

		// 响应头的设置
		response.reset();
		response.setCharacterEncoding("utf-8");
		response.setContentType("multipart/form-data");
		// 设置压缩包的名字
		// 解决不同浏览器压缩包名字含有中文时乱码的问题
		HttpSession session = request.getSession();

		String billname = dir.getDirectoryName();
		String downloadName = billname + ".zip";
		// 返回客户端浏览器的版本号、类型
		String agent = request.getHeader("USER-AGENT");
		try {
			// 针对IE或者以IE为内核的浏览器：
			if (agent.contains("MSIE") || agent.contains("Trident")) {
				downloadName = java.net.URLEncoder.encode(downloadName, "UTF-8");
			} else {
				// 非IE浏览器的处理：
				downloadName = new String(downloadName.getBytes("UTF-8"), "ISO-8859-1");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		response.setHeader("Content-Disposition", "attachment;fileName=\"" + downloadName + "\"");
		ZipUtils.toZip(fileList, response.getOutputStream());

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
