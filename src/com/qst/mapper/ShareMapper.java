package com.qst.mapper;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.qst.entity.Page;
import com.qst.entity.Share;

public interface ShareMapper {
	int deleteByPrimaryKey(Integer shareId);

	int insert(Share share);

	int insertSelective(Share share);

	Share selectByPrimaryKey(Integer shareId);

	int updateByPrimaryKeySelective(Share share);

	int updateByPrimaryKey(Share share);

	List<Share> findAllSharesByPage(@Param("pg") Page pg);

	int findSharesTotal();

	List<Share> findSharesByType(@Param("share") Share share, @Param("pg") Page pg);

	int findSharesTotalByType(@Param("share") Share share);

	List<Share> findSharesByAttribute(@Param("startTime") Date startTime, @Param("endTime") Date endTime,
			@Param("share") Share share, @Param("pg") Page pg);

	int findSharesTotalByAttribute(@Param("startTime") Date startTime, @Param("endTime") Date endTime,
			@Param("share") Share share);

	Share findShareByUrl(@Param("shareUrl") String shareUrl);

	List<Share> findMyShares(@Param("userId") Integer userId);
}