/**
 * 
 */
package com.qst.serviceImp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qst.entity.FileChunk;
import com.qst.mapper.FileChunkMapper;
import com.qst.service.FileChunkService;

/**
 * @ClassName:FileChunkServiceImp.java
 * @version:v1.0.0
 * @author:mwy
 * @date:2019年9月4日 上午9:46:39
 * @Description:文件块业务层实现类
 */
@Service
public class FileChunkServiceImp implements FileChunkService {
	@Autowired
	private FileChunkMapper fileChunkMapper;
	/**
	 * 通过id删除文件块
	 */
	@Override
	public int deleteByPrimaryKey(Integer fileChunkId) {
		
		return fileChunkMapper.deleteByPrimaryKey(fileChunkId);
	}

	/**
	 * 添加文件块
	 */
	@Override
	public int insert(FileChunk record) {
		// TODO Auto-generated method stub
		return fileChunkMapper.insert(record);
	}

	/**
	 * 选择性添加文件块
	 */
	@Override
	public int insertSelective(FileChunk record) {
		// TODO Auto-generated method stub
		return fileChunkMapper.insertSelective(record);
	}

	/**
	 * 通过id查找文件块
	 */
	@Override
	public FileChunk selectByPrimaryKey(Integer fileChunkId) {
		// TODO Auto-generated method stub
		return fileChunkMapper.selectByPrimaryKey(fileChunkId);
	}

	/**
	 * 选择性更新文件块
	 */
	@Override
	public int updateByPrimaryKeySelective(FileChunk record) {
		// TODO Auto-generated method stub
		return fileChunkMapper.updateByPrimaryKeySelective(record);
	}

	/**
	 * 更新文件块
	 */
	@Override
	public int updateByPrimaryKey(FileChunk record) {
		// TODO Auto-generated method stub
		return fileChunkMapper.updateByPrimaryKey(record);
	}

	/**
	 * 查询未完成文件块
	 */
	@Override
	public List<FileChunk> selectByStatus(int status, int userId) {
		
		return fileChunkMapper.selectByStatus( status,  userId);
	}

}
