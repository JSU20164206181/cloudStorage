package com.qst.mapper;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.qst.entity.File;
import com.qst.entity.Page;

public interface FileMapper {
	int deleteByPrimaryKey(Integer fileId);

	int insert(File file);

	int insertSelective(File file);

	File selectByPrimaryKey(Integer fileId);

	int updateByPrimaryKeySelective(File file);

	int updateByPrimaryKey(File file);

	List<File> findAllFilesByPage(@Param("fileStatus") Integer fileStatus, @Param("pg") Page pg);

	int findFileTotal(@Param("fileStatus") Integer fileStatus);

	List<File> findFilesByType(@Param("file") File file, @Param("pg") Page pg);

	int findFileTotalByType(@Param("file") File file);

	List<File> findFilesByAttribute(@Param("startTime") Date startTime, @Param("endTime") Date endTime,
			@Param("file") File file, @Param("pg") Page pg);

	int findFileTotalByAttribute(@Param("startTime") Date startTime, @Param("endTime") Date endTime,
			@Param("file") File file);

	List<File> fuzzyFindMyFiles(@Param("file") File file, @Param("pg") Page pg);

	/**
	 * 用户文件管理-查找目录下所有文件
	 * 
	 * @param dId
	 * @param uId
	 * @return
	 */
	List<File> userSelectAllFileByDirId(@Param("dirId") int dId, @Param("userId") int uId);
	/**
	 * 用户文件管理-根据名字查找目录下文件
	 * 
	 * @param dId
	 * @param uId
	 * @return
	 */
	File userSelecttByName(@Param("dirId") int dId, @Param("name") String name, @Param("userId") int uId);

	/**
	 * 用户文件管理-分页查找目录下所有文件夹
	 * 
	 * @param dId
	 * @param uId
	 * @param nowPage
	 * @param pageSize
	 * @return
	 */
	List<File> userSelectFileByDirId(@Param("dirId") int dId, @Param("userId") int uId, @Param("nowPage") int nowPage,
			@Param("pageSize") int pageSize);
	/**
	 * 目录下已删除文件
	 * 
	 * @param dId  
	 * @return
	 */
	List<File> alreadyDeleteFileByDirId(@Param("dirId") int dId);   

	/**
	 * 用户文件管理-查找目录下文件数量
	 * 
	 * @param dId
	 * @param uId
	 * @return
	 */
	int userFileNumberByDirId(@Param("dirId") int dId, @Param("userId") int uId);

	/**
	 * 根据父文件夹id查询所有子文件
	 * @param dId
	 * @return
	 */
	List<File>  findFileListByDirId(@Param("dirId") int dId);

	/**
	 * 分类文件显示
	 * @param type
	 * @param uId
	 * @param nowPage
	 * @param pageSize
	 * @return
	 */   
	List<File> fileByType(@Param("type") int type, @Param("userId") int uId, @Param("nowPage") int nowPage, 
			@Param("pageSize") int pageSize);


	/**
	 * 分类文件总数
	 * 
	 * @param dId
	 * @param uId
	 * @return
	 */
	int fileNumberByType(@Param("type") int Type, @Param("userId") int uId);
	/**
	 * 回收站文件列表
	 * @param uId
	 * @return
	 */
	List<File> findRecycleFile (@Param("userId") int uId);
	List<File>  findAllFile(int id);
	
	

}