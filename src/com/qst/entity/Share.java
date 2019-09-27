package com.qst.entity;

import java.util.Date;

public class Share {
	private Integer shareId;

	private String shareUrl;

	private String shareName;

	private Date createDatetime;

	private Integer validDate;

	private String fileId;

	private String directoryId;

	private Integer userId;

	private String userName;

	private Integer personId;

	private Integer shareStatus;

	private String shareCommand;

	public Integer getShareId() {
		return shareId;
	}

	public void setShareId(Integer shareId) {
		this.shareId = shareId;
	}

	public String getShareUrl() {
		return shareUrl;
	}

	public void setShareUrl(String shareUrl) {
		this.shareUrl = shareUrl;
	}

	public String getShareName() {
		return shareName;
	}

	public void setShareName(String shareName) {
		this.shareName = shareName;
	}

	public Date getCreateDatetime() {
		return createDatetime;
	}

	public void setCreateDatetime(Date createDatetime) {
		this.createDatetime = createDatetime;
	}

	public Integer getValidDate() {
		return validDate;
	}

	public void setValidDate(Integer validDate) {
		this.validDate = validDate;
	}

	public String getFileId() {
		return fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	public String getDirectoryId() {
		return directoryId;
	}

	public void setDirectoryId(String directoryId) {
		this.directoryId = directoryId;
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

	public Integer getPersonId() {
		return personId;
	}

	public void setPersonId(Integer personId) {
		this.personId = personId;
	}

	public Integer getShareStatus() {
		return shareStatus;
	}

	public void setShareStatus(Integer shareStatus) {
		this.shareStatus = shareStatus;
	}

	public String getShareCommand() {
		return shareCommand;
	}

	public void setShareCommand(String shareCommand) {
		this.shareCommand = shareCommand;
	}

	@Override
	public String toString() {
		return "Share [shareId=" + shareId + ", shareUrl=" + shareUrl + ", shareName=" + shareName + ", createDatetime="
				+ createDatetime + ", validDate=" + validDate + ", fileId=" + fileId + ", directoryId=" + directoryId
				+ ", userId=" + userId + ", userName=" + userName + ", personId=" + personId + ", shareStatus="
				+ shareStatus + ", shareCommand=" + shareCommand + "]";
	}

}