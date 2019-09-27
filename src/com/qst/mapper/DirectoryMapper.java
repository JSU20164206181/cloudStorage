package com.qst.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.qst.entity.Directory;
import com.qst.entity.Page;

public interface DirectoryMapper {
	int deleteByPrimaryKey(Integer directoryId);

	int insert(Directory record);

	int insertSelective(Directory record);

	Directory selectByPrimaryKey(Integer directoryId);

	int updateByPrimaryKeySelective(Directory record);

	int updateByPrimaryKey(Directory record);

	/**
	 * 分页模糊查找我的文件夹
	 * 
	 * @param dir
	 * @param pg
	 * @return
	 */
	List<Directory> fuzzyFindMyDirectorys(@Param("dir") Directory dir, @Param("pg") Page pg);

	/**
	 * 查询子文件夹
	 * 
	 * @param parent
	 * @return
	 */
	List<Directory> findChidrenById(Directory parent);
	/**
	 * 查询已删除子文件夹
	 * @param parent
	 * @return
	 */
	List<Directory> alreadyDeleteDirById(@Param("dirId") int dirId);
      
	List<Directory> findAllByUser(int uid);

	/**
	 * 查询文件夹是否存在
	 * 
	 * @param dName
	 * @param pId
	 * @param uId
	 * @return
	 */
	Directory selectDirByName(@Param("dirName") String dName, @Param("pId") int pId, @Param("uId") int uId);
	/**
	 * 回收站文件夹 
	 * @param uId
	 * @return
	 */
	List<Directory>  findRecycleDir(@Param("userId") int uId);  

}