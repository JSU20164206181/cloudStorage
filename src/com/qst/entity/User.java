package com.qst.entity;

import java.util.Date;

public class User {

    private Integer userId;

    private String userName;

    private String userPassword;

    private Integer usedSize;

    private Integer totalSize;

    private Date createDatetime;

    private Date latestLoginDatetime;

    private String latestLoginIp;

    private Integer personId;

    private Person person;       //一对一关联查询

    //用户装态   0未激活 1正常 2禁用 3删除
    private Integer userStatus;

    //会员等级  1普通会员 2会员  3超级会员
    private Integer memberOrder;

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

    public String getUserPassword() {
        return userPassword;
    }

    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword;
    }

    public Integer getUsedSize() {
        return usedSize;
    }

    public void setUsedSize(Integer usedSize) {
        this.usedSize = usedSize;
    }

    public Integer getTotalSize() {
        return totalSize;
    }

    public void setTotalSize(Integer totalSize) {
        this.totalSize = totalSize;
    }

    public Date getCreateDatetime() {
        return createDatetime;
    }

    public void setCreateDatetime(Date createDatetime) {
        this.createDatetime = createDatetime;
    }

    public Date getLatestLoginDatetime() {
        return latestLoginDatetime;
    }

    public void setLatestLoginDatetime(Date latestLoginDatetime) {
        this.latestLoginDatetime = latestLoginDatetime;
    }

    public String getLatestLoginIp() {
        return latestLoginIp;
    }

    public void setLatestLoginIp(String latestLoginIp) {
        this.latestLoginIp = latestLoginIp;
    }

    public Integer getPersonId() {
        return personId;
    }

    public void setPersonId(Integer personId) {
        this.personId = personId;
    }

    public Integer getUserStatus() {
        return userStatus;
    }

    public void setUserStatus(Integer userStatus) {
        this.userStatus = userStatus;
    }

    public Integer getMemberOrder() {
        return memberOrder;
    }

    public void setMemberOrder(Integer memberOrder) {
        this.memberOrder = memberOrder;
    }

    public Person getPerson() {
        return person;
    }

    public void setPerson(Person person) {
        this.person = person;
    }

    @Override
    public String toString() {
        return "User{" +
                "userId=" + userId +
                ", userName='" + userName + '\'' +
                ", userPassword='" + userPassword + '\'' +
                ", usedSize=" + usedSize +
                ", totalSize=" + totalSize +
                ", createDatetime=" + createDatetime +
                ", latestLoginDatetime=" + latestLoginDatetime +
                ", latestLoginIp='" + latestLoginIp + '\'' +
                ", personId=" + personId +
                ", person=" + person +
                ", userStatus=" + userStatus +
                ", memberOrder=" + memberOrder +
                '}';
    }
}