package com.qst.entity;

import java.util.Date;

public class File {
	private Integer fileId;

	private Integer userId;

	private String userName;

	private Date uploadDatetime;

	private String uploadIp;

	private String fileName;

	private Integer fileSize;

	private String fileType;

	private String filePath;

	private Integer personId;

	private Integer directoryId;

	private Integer fileStatus;

	public File() {
		
	}

	public File(Integer userId, String userName, Date uploadDatetime, String uploadIp, String fileName,
			Integer fileSize, String fileType, String filePath, Integer personId, Integer directoryId,
			Integer fileStatus) {
		
		this.userId = userId;
		this.userName = userName;
		this.uploadDatetime = uploadDatetime;
		this.uploadIp = uploadIp;
		this.fileName = fileName;
		this.fileSize = fileSize;
		this.fileType = fileType;
		this.filePath = filePath;
		this.personId = personId;
		this.directoryId = directoryId;
		this.fileStatus = fileStatus;
	}

	public Integer getFileId() {
		return fileId;
	}

	public void setFileId(Integer fileId) {
		this.fileId = fileId;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public Date getUploadDatetime() {
		return uploadDatetime;
	}

	public void setUploadDatetime(Date uploadDatetime) {
		this.uploadDatetime = uploadDatetime;
	}

	public String getUploadIp() {
		return uploadIp;
	}

	public void setUploadIp(String uploadIp) {
		this.uploadIp = uploadIp;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public Integer getFileSize() {
		return fileSize;
	}

	public void setFileSize(Integer fileSize) {
		this.fileSize = fileSize;
	}

	public String getFileType() {
		return fileType;
	}

	public void setFileType(String fileType) {
		this.fileType = fileType;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public Integer getPersonId() {
		return personId;
	}

	public void setPersonId(Integer personId) {
		this.personId = personId;
	}

	public Integer getDirectoryId() {
		return directoryId;
	}

	public void setDirectoryId(Integer directoryId) {
		this.directoryId = directoryId;
	}

	public Integer getFileStatus() {
		return fileStatus;
	}

	public void setFileStatus(Integer fileStatus) {
		this.fileStatus = fileStatus;
	}

	@Override
	public String toString() {
		return "File [fileId=" + fileId + ", userId=" + userId + ", userName=" + userName + ", uploadDatetime="
				+ uploadDatetime + ", uploadIp=" + uploadIp + ", fileName=" + fileName + ", fileSize=" + fileSize
				+ ", fileType=" + fileType + ", filePath=" + filePath + ", personId=" + personId + ", directoryId="
				+ directoryId + ", fileStatus=" + fileStatus + "]";
	}

}