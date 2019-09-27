package com.qst.mapper;







import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.qst.entity.FileChunk;

public interface FileChunkMapper {
    int deleteByPrimaryKey(Integer fileChunkId);

    int insert(FileChunk record);

    int insertSelective(FileChunk record);

    FileChunk selectByPrimaryKey(Integer fileChunkId);

    int updateByPrimaryKeySelective(FileChunk record);

    int updateByPrimaryKey(FileChunk record);

	/**
	 * 查询未完成文件块
	 * @param i
	 * @return
	 */
	List<FileChunk> selectByStatus(@Param("status")int status,@Param("userId") int userId);
}