/**
 * 
 */
package com.qst.service;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.qst.entity.Page;
import com.qst.entity.Share;

/**
 * @ClassName: ShareService.java
 * @version: v1.0.0
 * @author: ZYL
 * @date: 2019年9月6日 上午9:29:24
 * @Description: 分享文件操作接口
 */
public interface ShareService {
	/**
	 * 管理员分页查询所有分享文件
	 * 
	 * @param pg
	 * @return
	 */
	public List<Share> findAllSharesByPage(Page pg);

	/**
	 * 管理员查询所有分享文件总数
	 * 
	 * @return
	 */
	public int findSharesTotal();

	/**
	 * 管理员根据分享文件类型分页查询文件
	 * 
	 * @param share
	 * @param pg
	 * @return
	 */
	public List<Share> findSharesByType(Share share, Page pg);

	/**
	 * 管理员查询分享分类文件总数
	 * 
	 * @param share
	 * @return
	 */
	public int findSharesTotalByType(Share share);

	/**
	 * 取消/删除分享
	 * 
	 * @param shareId
	 * @return
	 */
	public int deleteShare(Integer shareId);

	/**
	 * 管理员按分享文件属性模糊查找文件
	 * 
	 * @param startTime
	 * @param endTime
	 * @param share
	 * @param pg
	 * @return
	 */
	public List<Share> findSharesByAttribute(Date startTime, Date endTime, Share share, Page pg);

	/**
	 * 管理员按分享文件属性模糊查找文件总数
	 * 
	 * @param startTime
	 * @param endTime
	 * @param share
	 * @return
	 */
	public int findSharesTotalByAttribute(Date startTime, Date endTime, Share share);

	/**
	 * 新增分享文件
	 * 
	 * @param share
	 * @return
	 */
	public int addShare(Share share);

	/**
	 * 根据ID查询分享文件
	 * 
	 * @param shareId
	 * @return
	 */
	public Share findShareById(Integer shareId);

	/**
	 * 根据分享地址查询分享文件
	 * 
	 * @param shareUrl
	 * @return
	 */
	public Share findShareByUrl(String shareUrl);

	/**
	 * 根据ID修改分享文件
	 * 
	 * @param share
	 * @return
	 */
	public int updateShare(Share share);

	/**
	 * 查询我的分享
	 * 
	 * @param userId
	 * @return
	 */
	public List<Share> findMyShares(Integer userId);

}
