/**
 * 
 */
package com.qst.service;

import java.util.List;

import com.qst.entity.FileChunk;

/**
 * @ClassName:FileChunkService.java
 * @version:v1.0.0
 * @author:mwy
 * @date:2019年9月4日 上午9:44:52
 * @Description:文件块业务层
 */
public interface FileChunkService {
	int deleteByPrimaryKey(Integer fileChunkId);

    int insert(FileChunk record);

    int insertSelective(FileChunk record);

    FileChunk selectByPrimaryKey(Integer fileChunkId);

    int updateByPrimaryKeySelective(FileChunk record);

    int updateByPrimaryKey(FileChunk record);

	/**
	 * 查询未完成的文件块
	 * @param i
	 * @param j 
	 * @return
	 */
	List<FileChunk> selectByStatus(int status, int userId);
}
