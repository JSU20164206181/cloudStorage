package com.qst.entity;

import java.util.Date;

public class Directory {
    private Integer directoryId;

    private String directoryName;

    private Integer parentId;

    private Integer userId;

    private Date createDatetime;
    private Integer directoryStatus; 
    

    @Override
	public String toString() {
		return "Directory [directoryId=" + directoryId + ", directoryName=" + directoryName + ", parentId=" + parentId
				+ ", userId=" + userId + ", createDatetime=" + createDatetime + ", directoryStatus=" + directoryStatus
				+ "]";
	}
	public Integer getDirectoryId() {
        return directoryId;
    }

    public void setDirectoryId(Integer directoryId) {
        this.directoryId = directoryId;
    }

    public String getDirectoryName() {
        return directoryName;
    }

    public void setDirectoryName(String directoryName) {
        this.directoryName = directoryName;
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Date getCreateDatetime() {
        return createDatetime;
    }

    public void setCreateDatetime(Date createDatetime) {
        this.createDatetime = createDatetime;
    }

	public Integer getDirectoryStatus() {  
		return directoryStatus; 
	} 

	public void setDirectoryStatus(Integer directoryStatus) {
		this.directoryStatus = directoryStatus;
	}
}