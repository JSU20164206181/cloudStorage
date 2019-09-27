package com.qst.entity;

public class MyTree {
 private int id;
 private String name;
 private int pId;
public int getId() {
	return id;
}
public void setId(int id) {
	this.id = id;
}
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public int getpId() {
	return pId;
}
public void setpId(int pId) {
	this.pId = pId;
}
@Override
public String toString() {
	return "Tree [id=" + id + ", name=" + name + ", pId=" + pId + "]";
}
 
}
