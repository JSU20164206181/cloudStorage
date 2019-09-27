package com.qst.service;

import java.util.List;

import com.qst.entity.Directory;
import com.qst.entity.File;
import com.qst.entity.Page;


/**
 * @ClassName: UserFileManager.java
 * @version: v1.0.0
 * @author: hdq
 * @date: 2019年8月29日 上午10:01:16
 * @Description: 用户文件管理
 */
public interface UserFileManager {
	/**
	 * 分页模糊查找我的文件夹
	 * 
	 * @param dir
	 * @param pg
	 * @return
	 */
	List<Directory> fuzzyFindMyDirectorys(Directory dir, Page pg);

	/**
	 * 分页模糊查找我的文件
	 * 
	 * @param file
	 * @param pg
	 * @return
	 */
	List<File> fuzzyFindMyFiles(File file, Page pg);

	/**
	 * 查找所有文件
	 * 
	 * @param id当前目录id
	 * @return 子目录列表
	 */
	List<Directory> findAllChidFile(int pId, int uid);

	List<Directory> findAllDir(int uid);

	/**
	 * 根据id查找文件目录信息
	 * 
	 * @param id
	 * @return
	 */
	Directory findDir(String pId);

	/**
	 * 根据id查找父目录信息
	 * 
	 * @param id
	 * @return
	 */
	List<Directory> findFather(String pId);

	/**
	 * 分页查找目录下文件信息
	 * 
	 * @param dId
	 * @param uId
	 * @param nowPage
	 * @param pageSize
	 * @return
	 */
	List<File> allFileList(int dId, int uId, int nowPage, int pageSize);

	/**
	 * 分类查找文件信息
	 * 
	 * @param dId
	 * @param uId
	 * @param nowPage
	 * @param pageSize
	 * @return
	 */
	List<File> typeFileList(int type, int uId, int nowPage, int pageSize);

	/**
	 * 
	 * 分页查找目录下文件数量
	 * 
	 * @param dId
	 * @param uId
	 * @param nowPage
	 * @param pageSize
	 * @return
	 */
	int allFilePage(int type, int uId, int pageSize);

	/**
	 * 分类查找文件数量
	 * 
	 * @param dId
	 * @param uId
	 * @param nowPage
	 * @param pageSize
	 * @return
	 */
	int typeFilePage(int dId, int uId, int pageSize);

	/**
	 * 添加我的文件夹
	 * 
	 * @param pId
	 * @param uId
	 * @param dirName
	 * @return
	 */
	int addMyDir(int pId, int uId, String dirName);

	/**
	 * 移动到回收站
	 * 
	 * @param dirIdList
	 * @param fileIdList
	 * @return
	 */
	int moveToRecyle(String[] dirIdList, String[] fileIdList, int uId);

	/**
	 * 重命名
	 * 
	 * @param dirIdList
	 * @param fileIdList
	 * @return
	 */

	int reNameDirOrFile(String id, String type, String name, int uId);

	/**
	 * 移动文件夹
	 * 
	 * @param aimId
	 * @param dirIdList
	 * @param fileIdList
	 * @param uId
	 * @return
	 */
	int moveDirOrFile(int aimId, String[] dirIdList, String[] fileIdList, int uId);

	/**
	 * 复制文件夹
	 * 
	 * @param aimId
	 * @param dirIdList
	 * @param fileIdList
	 * @param uId
	 * @return
	 */
	int copyDirOrFile(int aimId, String[] dirIdList, String[] fileIdList, int uId);

	/**
	 * 文件夹复制
	 * 
	 * @param aimId
	 * @return
	 */
	int copyOneDir(int dirId, int aimId, int uId);
     /**
      * 添加文件到数据库
      * @param file
      * @return
      */
     int addFile(File file); 
     /**
      * 根据id查找文件
      * @return
      */
     File findById(int fileId);
     /**
      * 根据id查找文件夹
      * @param id
      * @return
      */
     Directory findDirById(int id);


	/**
	 * 根据父文件夹id查询所有文件
	 * @param directoryId
	 */
	List<File> findFileListByDirId(Integer directoryId);


	/**
	 * 文件/文件夹是否重复
	 * 
	 * @param aimId
	 * @param dirIdList
	 * @param fileIdList
	 * @param uId
	 * @return
	 */
	int dirAndFileHave(int aimId, String[] dirIdList, String[] fileIdList, int uId);

	/**
	 * 回收站文件
	 * 
	 * @param uId
	 * @return
	 */
	List<File> findRecycleFile(int uId);

	/**
	 * 回收站文件 夹
	 * 
	 * @param uId
	 * @return
	 */
	List<Directory> findRecycleDir(int uId);

	/**
	 * 删除文件、文件夹
	 * 
	 * @param dirIdList
	 * @param fileIdList
	 * @return
	 */
	int deleteRecDir(String[] dirIdList, String[] fileIdList, int uId);
	/**
	 * 恢复回收站文件夹
	 * 
	 * @param dirIdList
	 * @param fileIdList
	 * @return
	 */
	int reRecyle(String[] dirIdList, String[] fileIdList, int uId);

	

}
