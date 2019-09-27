/**
 * 
 */
package com.qst.serviceImp;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qst.entity.File;
import com.qst.entity.Page;
import com.qst.mapper.FileMapper;
import com.qst.service.FileService;

/**
 * @ClassName: FileServiceImp.java
 * @version: v1.0.0
 * @author: ZYL
 * @date: 2019年8月29日 下午9:10:57
 * @Description: 文件Service的实现
 */
@Service
public class FileServiceImp implements FileService {

	@Autowired
	private FileMapper fileMapper;

	@Override
	public List<File> findAllFilesByPage(Integer fileStatus, Page pg) {
		return fileMapper.findAllFilesByPage(fileStatus, pg);
	}

	@Override
	public int findFileTotal(Integer fileStatus) {
		return fileMapper.findFileTotal(fileStatus);
	}

	@Override
	public List<File> findFilesByType(File file, Page pg) {
		return fileMapper.findFilesByType(file, pg);
	}

	@Override
	public int findFileTotalByType(File file) {
		return fileMapper.findFileTotalByType(file);
	}

	@Override
	public File findFile(Integer fileId) {
		return fileMapper.selectByPrimaryKey(fileId);
	}

	@Override
	public int changeFileStatus(File file) {
		return fileMapper.updateByPrimaryKeySelective(file);
	}

	@Override
	public int deleteFile(Integer fileId) {
		return fileMapper.deleteByPrimaryKey(fileId);
	}

	@Override
	public List<File> findFilesByAttribute(Date startTime, Date endTime, File file, Page pg) {
		return fileMapper.findFilesByAttribute(startTime, endTime, file, pg);
	}

	@Override
	public int findFileTotalByAttribute(Date startTime, Date endTime, File file) {
		return fileMapper.findFileTotalByAttribute(startTime, endTime, file);
	}

}
