package com.qst.mapper;

import java.util.List;
import java.util.Map;

import com.qst.entity.AgeInfo;
import com.qst.entity.Person;
import com.qst.entity.SexInfo;

public interface PersonMapper {
    int deleteByPrimaryKey(Integer personId);

    int insert(Person record);

    int insertSelective(Person record);

    Person selectByPrimaryKey(Integer personId);

    int updateByPrimaryKeySelective(Person record);

    int updateByPrimaryKey(Person record);
    //查找所有的用户
    public List<Person> selectAll();
    //根据email查询对应的id
    public Integer findIdByEmail(String email);

     SexInfo searchSex();

     AgeInfo searchAge();
}