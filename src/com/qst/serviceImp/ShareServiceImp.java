/**
 * 
 */
package com.qst.serviceImp;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qst.entity.Page;
import com.qst.entity.Share;
import com.qst.mapper.ShareMapper;
import com.qst.service.ShareService;

/**
 * @ClassName: ShareServiceImp.java
 * @version: v1.0.0
 * @author: ZYL
 * @date: 2019年9月6日 上午9:33:53
 * @Description: 分享文件操作实现类
 */
@Service
public class ShareServiceImp implements ShareService {
	@Autowired
	private ShareMapper shareMapper;

	@Override
	public List<Share> findAllSharesByPage(Page pg) {
		return shareMapper.findAllSharesByPage(pg);
	}

	@Override
	public int findSharesTotal() {
		return shareMapper.findSharesTotal();
	}

	@Override
	public List<Share> findSharesByType(Share share, Page pg) {
		return shareMapper.findSharesByType(share, pg);
	}

	@Override
	public int findSharesTotalByType(Share share) {
		return shareMapper.findSharesTotalByType(share);
	}

	@Override
	public int deleteShare(Integer shareId) {
		return shareMapper.deleteByPrimaryKey(shareId);
	}

	@Override
	public List<Share> findSharesByAttribute(Date startTime, Date endTime, Share share, Page pg) {
		return shareMapper.findSharesByAttribute(startTime, endTime, share, pg);
	}

	@Override
	public int findSharesTotalByAttribute(Date startTime, Date endTime, Share share) {
		return shareMapper.findSharesTotalByAttribute(startTime, endTime, share);
	}

	@Override
	public int addShare(Share share) {
		return shareMapper.insertSelective(share);
	}

	@Override
	public Share findShareById(Integer shareId) {
		return shareMapper.selectByPrimaryKey(shareId);
	}

	@Override
	public Share findShareByUrl(String shareUrl) {
		return shareMapper.findShareByUrl(shareUrl);
	}

	@Override
	public int updateShare(Share share) {
		return shareMapper.updateByPrimaryKeySelective(share);
	}

	@Override
	public List<Share> findMyShares(Integer userId) {
		return shareMapper.findMyShares(userId);
	}

}
