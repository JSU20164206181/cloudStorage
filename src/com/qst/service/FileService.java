/**
 * 
 */
package com.qst.service;

import java.util.Date;
import java.util.List;

import com.qst.entity.File;
import com.qst.entity.Page;

/**
 * @ClassName: FileService.java
 * @version: v1.0.0
 * @author: ZYL
 * @date: 2019年8月29日 下午9:02:16
 * @Description: 文件Service
 */
public interface FileService {
	/**
	 * 查询某个文件的信息
	 * 
	 * @param fileId
	 * @return
	 */
	public File findFile(Integer fileId);

	/**
	 * 更改文件状态
	 * 
	 * @param file
	 * @return
	 */
	public int changeFileStatus(File file);

	/**
	 * 管理员分页查询所有文件
	 * 
	 * @param page
	 * @param pageSize
	 * @param fileStatus
	 * @return
	 */
	public List<File> findAllFilesByPage(Integer fileStatus, Page pg);

	/**
	 * 管理员查询文件总数
	 * 
	 * @param fileStatus
	 * @return
	 */
	public int findFileTotal(Integer fileStatus);

	/**
	 * 彻底删除文件
	 * 
	 * @param fileId
	 * @return
	 */
	public int deleteFile(Integer fileId);

	/**
	 * 管理员根据文件类型分页查询文件
	 * 
	 * @param fileType
	 * @param fileStatus
	 * @param page
	 * @param pageSize
	 * @return
	 */
	public List<File> findFilesByType(File file, Page pg);

	/**
	 * 管理员查询分类文件总数
	 * 
	 * @param fileType
	 * @param fileStatus
	 * @return
	 */
	public int findFileTotalByType(File file);

	/**
	 * 管理员按文件属性模糊查找文件
	 * 
	 * @param file
	 * @return
	 */
	public List<File> findFilesByAttribute(Date startTime, Date endTime, File file, Page pg);

	/**
	 * 管理员按文件属性模糊查找文件总数
	 * 
	 * @param file
	 * @return
	 */
	public int findFileTotalByAttribute(Date startTime, Date endTime, File file);

}
