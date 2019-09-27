package com.qst.serviceImp;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qst.entity.Directory;
import com.qst.entity.File;
import com.qst.entity.Page;
import com.qst.mapper.DirectoryMapper;
import com.qst.mapper.FileMapper;
import com.qst.service.UserFileManager;

/**
 * @ClassName: UserFileManagerImp.java
 * @version: v1.0.0
 * @author: hdq
 * @date: 2019年8月29日 上午10:33:37
 * @Description: 用户文件管理Server实现类
 */
@Service
public class UserFileManagerImp implements UserFileManager {
	@Autowired
	private DirectoryMapper mapper1;
	@Autowired
	private FileMapper mapper2;
	@Override
 public List<Directory> fuzzyFindMyDirectorys(Directory dir, Page pg) {
		return mapper1.fuzzyFindMyDirectorys(dir, pg);
	}

	@Override
	public List<File> fuzzyFindMyFiles(File file, Page pg) {
		return mapper2.fuzzyFindMyFiles(file, pg);
	}
	@Override
	public List<Directory> findAllChidFile(int pId, int uId) {
		Directory dir = new Directory();
		dir.setParentId(pId);
		dir.setUserId(uId);
		List<Directory> list = mapper1.findChidrenById(dir);
		System.out.println("【Imp ChildList:】" + list);
		return list;
	}

	@Override
	public Directory findDir(String pId) {
		int id1 = 0;
		Directory list = new Directory();
		if (pId != null && pId != "") {
			id1 = Integer.parseInt(pId);
			list = mapper1.selectByPrimaryKey(id1);
		}

		return list;
	}

	@Override
	public List<Directory> findFather(String pId) {
		// TODO Auto-generated method stub
		Directory dirM = new Directory();
		List<Directory> list = new ArrayList<Directory>();
		int id1 = 0;
		if (pId != null && pId != "") {
			id1 = Integer.parseInt(pId);
			dirM = mapper1.selectByPrimaryKey(id1);
			while (true) {

				System.out.println("Test" + dirM.getParentId());
				if (dirM.getParentId() != 0) {
					dirM = mapper1.selectByPrimaryKey(dirM.getParentId());
					list.add(dirM);
				} else {
					break;
				}
			}
		}
		System.out.println("【Imp FatherList:】" + list);
		return list;
	}

	@Override
	public List<File> allFileList(int dId, int uId, int nowPage, int pageSize) {
		int pageNum = this.allFilePage(dId, uId, pageSize);
		if (nowPage <= 1) {
			nowPage = 1;
		} else if (nowPage >= pageNum) {
			nowPage = pageNum;
		}
		int start = (nowPage - 1) * pageSize;
		System.out.println("start:" + start);
		List<File> fileList = mapper2.userSelectFileByDirId(dId, uId, start, pageSize);
		System.out.println("【Imp FileList:】" + fileList);
		return fileList;
	}

	@Override
	public int allFilePage(int dId, int uId, int pageSize) {

		int num = mapper2.userFileNumberByDirId(dId, uId);

		int allpage = 0;
		if (num % pageSize == 0) {
			allpage = num / pageSize;
		} else {
			allpage = num / pageSize + 1;
		}
		return allpage;
	}
 
	@Override
	public int addMyDir(int pId, int uId, String dirName) {

		Directory d = mapper1.selectDirByName(dirName, pId, uId);
		Timestamp time = new Timestamp(System.currentTimeMillis());
		if (d != null) {
			String tsStr = "";
			DateFormat sdf = new SimpleDateFormat("yyyyMMdd-HHmmss");
			tsStr = sdf.format(time);
			dirName = dirName + tsStr;
		}

		Directory dir = new Directory();
		dir.setCreateDatetime(time);
		dir.setParentId(pId);
		dir.setDirectoryName(dirName);
		dir.setUserId(uId);
		dir.setDirectoryStatus(1);
		mapper1.insert(dir);
		System.out.println("【Imp addDir:】" + dir);
		return 1;
	}

	@Override
	public int moveToRecyle(String[] dirIdList, String[] fileIdList, int uId) {
		for (int i = 0; i < dirIdList.length; i++) {
			this.deleteDir(Integer.parseInt(dirIdList[i]), uId);
			System.out.println("删除顶层文件夹:" + dirIdList[i]);
			Directory dir = mapper1.selectByPrimaryKey(Integer.parseInt(dirIdList[i]));
			dir.setDirectoryStatus(3);
			mapper1.updateByPrimaryKey(dir);
		}
		for (int i = 0; i < fileIdList.length; i++) {
			System.out.println("删除顶层文件:" + fileIdList[i]);
			File file = mapper2.selectByPrimaryKey(Integer.parseInt(fileIdList[i]));
			file.setFileStatus(3);
			mapper2.updateByPrimaryKey(file);
		}
		return 0;
	}

	public void deleteDir(int dirId, int uId) {
		Directory dir = new Directory();
		dir.setParentId(dirId);
		dir.setUserId(uId);
		List<Directory> dirList = mapper1.findChidrenById(dir);
	
		List<File> fileList = mapper2.userSelectAllFileByDirId(dirId, uId);
        System.out.println("test "+fileList+"dirId:"+dirId);   
		for (int i = 0; i < fileList.size(); i++) {  
			System.out.println("删除文件:" + fileList.get(i).getFileName());
			fileList.get(i).setFileStatus(3);
			mapper2.updateByPrimaryKey(fileList.get(i));
         
		}	
		System.out.println(dirId+"子文件夹长度:"+dirList.size());
		if (dirList.size() == 0) { 
			
		} else {
			for (int i = 0; i < dirList.size(); i++) {
				this.deleteDir(dirList.get(i).getDirectoryId(), uId);
				System.out.println("删除文件夹：" + dirList.get(i).getDirectoryName());
				dirList.get(i).setDirectoryStatus(3);
				mapper1.updateByPrimaryKey(dirList.get(i));
			}

		}

	}

	@Override
	public int reNameDirOrFile(String id, String type, String name, int uId) {
		if (type != null && type != "" && id != null && id != "") {
			Integer id1 = Integer.parseInt(id);
			Timestamp time = new Timestamp(System.currentTimeMillis());
			if (type.equals("dir")) {
				Directory dir = mapper1.selectByPrimaryKey(id1);
				String oldname = dir.getDirectoryName();
				if (oldname.equals(name)) { // 文件名不变
				}

				else {
					Directory d = mapper1.selectDirByName(name, dir.getParentId(), uId);// 文件名重复
					System.out.println("cf:" + d);
					if (d != null) {
						String tsStr = "";
						DateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmss"); 
						tsStr = sdf.format(time);
						name = name + tsStr;
					}
					dir.setDirectoryName(name);
				}
				dir.setDirectoryStatus(1);
				dir.setCreateDatetime(time);
				mapper1.updateByPrimaryKey(dir);

			} else if (type.equals("file")) {

				File file = mapper2.selectByPrimaryKey(id1);
				System.out.println("oldFilr"+file); 
				String oldname = file.getFileName();
				if (oldname.equals(name)) { // 文件名不变
				}

				else {
					File f = mapper2.userSelecttByName(file.getDirectoryId(), name, uId);// 文件名重复 
					System.out.println("重复:" + f);
					if (f != null) {
						String tsStr = "";
						DateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmss_");
						tsStr = sdf.format(time);
						name = tsStr + name;
					}
					file.setFileName(name);
				}

				file.setUploadDatetime(time);
				mapper2.updateByPrimaryKey(file);
			}

		}
		return 0;
	}

	@Override
	public List<Directory> findAllDir(int uId) {

		return mapper1.findAllByUser(uId);
	}

	@Override
	public int moveDirOrFile(int aimId, String[] dirIdList, String[] fileIdList, int uId) {
		File file;
		Directory dir;
		String re = "[^0-9]";
		Pattern p = Pattern.compile(re);
		int result = 1;
		Timestamp time = new Timestamp(System.currentTimeMillis());
		String tsStr = "";
		DateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmss_");
		tsStr = sdf.format(time); 
		
		if (dirIdList != null) {
			// 当前文件包含移动目标
			
			for (int i = 0; i < dirIdList.length; i++) {
				Matcher m = p.matcher(dirIdList[i]);
				Integer id = Integer.parseInt(m.replaceAll("").trim()); 
				//移动文件
				dir = mapper1.selectByPrimaryKey(id);
				if(dir.getParentId()==aimId){
					result = -2;
					break;
				}
				//目标文件父目录+当前文件   
				if(aimId!=0){
				List<Directory> aimPList=this.findFather(aimId+"");
				aimPList.add(mapper1.selectByPrimaryKey(aimId));
				
				System.out.println(aimId+"父目录: "+aimPList);  
				
				//目标为选中文件
				if (dir.getDirectoryId() == aimId) {
					result = -1;
				}
				//目标为选中文件的子文件   
				for(int p1=0;p1<aimPList.size();p1++){
					if(dir.getDirectoryId()==aimPList.get(p1).getDirectoryId()){  
						result = -1;
					} 
				}
				}
				//
				if(	result == -1){
					break; 
				}
			}
			if (result != -1&&result != -2) { 
				// 移动文件夹
				for (int i = 0; i < dirIdList.length; i++) {
					
					Matcher m = p.matcher(dirIdList[i]);
					Integer id = Integer.parseInt(m.replaceAll("").trim());
					dir = mapper1.selectByPrimaryKey(id);
					//System.out.println("11111" + dir);
					dir.setParentId(aimId);
                        //System.out.println("aaaa"+mapper1.selectDirByName(dir.getDirectoryName(), aimId, uId)); 
					if(mapper1.selectDirByName(dir.getDirectoryName(), aimId, uId) != null){
						dir.setDirectoryName(dir.getDirectoryName()+"_"+tsStr);    
					}   
					mapper1.updateByPrimaryKeySelective(dir);
				}

			}
		}
		// 移动文件
		if (fileIdList != null && result != -1&& result != -2) {
			for (int i = 0; i < fileIdList.length; i++) {
				Matcher m = p.matcher(fileIdList[i]);
				Integer id = Integer.parseInt(m.replaceAll("").trim());
				file = mapper2.selectByPrimaryKey(id);
				
				System.out.println("move："+mapper2.userSelecttByName(aimId, file.getFileName(), uId)); 
				if(mapper2.userSelecttByName(aimId, file.getFileName(), uId) != null){
					file.setFileName(tsStr+file.getFileName());
					file.setDirectoryId(aimId);
				} else{
					file.setDirectoryId(aimId);
				} 
				System.out.println("move2："+file);   
				mapper2.updateByPrimaryKeySelective(file);

			}
		}

		return result;
	}

	@Override
	public int copyDirOrFile(int aimId, String[] dirIdList, String[] fileIdList, int uId) {
		File file;
		String re = "[^0-9]";
		Pattern p = Pattern.compile(re);
		int result = 1;
		Timestamp time = new Timestamp(System.currentTimeMillis());
		String tsStr = "";
		DateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmss");
		tsStr = sdf.format(time);
		// 复制文件夹
		if (dirIdList != null) {
			for (int i = 0; i < dirIdList.length; i++) {
				Matcher m = p.matcher(dirIdList[i]);
				Integer id = Integer.parseInt(m.replaceAll("").trim());		
				this.copyOneDir(id, aimId, uId);
				
			}
		}
		// 复制文件
		if (fileIdList != null) {
			for (int i = 0; i < fileIdList.length; i++) {
				
					
				Matcher m = p.matcher(fileIdList[i]);
				Integer id = Integer.parseInt(m.replaceAll("").trim());
				file = mapper2.selectByPrimaryKey(id);
				if(mapper2.userSelecttByName(aimId, file.getFileName(), uId) != null){
					file.setFileName(tsStr+"_"+file.getFileName());
				}
				file.setDirectoryId(aimId);
				file.setFileId(null); 
				mapper2.insert(file);
			}
		} 
		return result;
	}

	@Override
	public int copyOneDir(int dirId, int aimId, int uId) { 
		Directory dir = new Directory();
		dir.setParentId(dirId);
		dir.setUserId(uId);
		//时间字符串
		Timestamp time = new Timestamp(System.currentTimeMillis());
		String tsStr = "";
		DateFormat sdf = new SimpleDateFormat("_yyyyMMdd_HHmmss");
		tsStr = sdf.format(time);
		 
		List<Directory> dirList = mapper1.findChidrenById(dir);
		Directory copyDir = mapper1.selectByPrimaryKey(dirId);
		copyDir.setParentId(aimId);
		copyDir.setDirectoryId(null); 
		Directory have=mapper1.selectDirByName(copyDir.getDirectoryName(),aimId, uId);  
		  
		if(have!= null){    
			System.out.println(have); 
			copyDir.setDirectoryName(have.getDirectoryName()+tsStr);  
		}
		System.out.println("复制文件夹：" + copyDir);   
		mapper1.insertSelective(copyDir);
		copyDir = mapper1.selectDirByName(copyDir.getDirectoryName(), aimId, uId);
		
		if (dirList.size() == 0) {
			List<File> fileList = mapper2.userSelectAllFileByDirId(dirId, uId);

			for (int i = 0; i < fileList.size(); i++) {
				System.out.println("复制文件:" + fileList.get(i).getFileName());
				
				File file = fileList.get(i);
				file.setDirectoryId(copyDir.getDirectoryId());  
				file.setFileId(null);
					
				mapper2.insert(file);

			}
		} else {
			for (int i = 0; i < dirList.size(); i++) {
				this.copyOneDir(dirList.get(i).getDirectoryId(), copyDir.getDirectoryId(), uId);
			}

		}
		return 0;
	}
	@Override
	public int dirAndFileHave(int aimId, String[] dirIdList, String[] fileIdList, int uId){
		File file;
		Directory dir;
		String re = "[^0-9]";
		Pattern p = Pattern.compile(re);
		int result = 1;//1不重复  ,>1已存在 
		// 文件夹重复 
		if (dirIdList != null) {
			for (int i = 0; i < dirIdList.length; i++) {
				Matcher m = p.matcher(dirIdList[i]);
				Integer id = Integer.parseInt(m.replaceAll("").trim());
				dir=mapper1.selectByPrimaryKey(id);
				if(mapper1.selectDirByName(dir.getDirectoryName(), aimId, uId) != null);{
					result++;
				}
			}
		}
		// 文件重复
		if (fileIdList != null) {
			for (int i = 0; i < fileIdList.length; i++) {
				Matcher m = p.matcher(fileIdList[i]);
				Integer id = Integer.parseInt(m.replaceAll("").trim());
				file = mapper2.selectByPrimaryKey(id);
				if(mapper2.userSelecttByName(aimId, file.getFileName(), uId) != null){
					result++; 
				}
			
			}
		} 
		return result; 
		
	}


	/* (non-Javadoc)
	 * @see com.qst.service.UserFileManager#addFile(com.qst.mapper.FileMapper)
	 */
	@Override
	public int addFile(File file) {
		return mapper2.insert(file);
	}

	/* (non-Javadoc)
	 * @see com.qst.service.UserFileManager#findById()
	 */
	@Override
	public File findById(int fileId) { 
		// TODO Auto-generated method stub
		return mapper2.selectByPrimaryKey(fileId);
	}

	/* (non-Javadoc)
	 * @see com.qst.service.UserFileManager#findDirById(int)
	 */
	@Override
	public Directory findDirById(int id) {
		// TODO Auto-generated method stub
		return mapper1.selectByPrimaryKey(id);
	}

	/* (non-Javadoc)
	 * @see com.qst.service.UserFileManager#findChildFileList(java.lang.Integer)
	 */
	@Override
	public List<File> findFileListByDirId(Integer directoryId) {
		// TODO Auto-generated method stub
		return mapper2.findFileListByDirId(directoryId);
	}


	@Override
	public int typeFilePage(int type, int uId, int pageSize) {
		int num = mapper2.fileNumberByType(type, uId);   
		int allpage = 0;
		if (num % pageSize == 0) {
			allpage = num / pageSize;
		} else {
			allpage = num / pageSize + 1;
		}
		return allpage;
	} 

	@Override
	public List<File> typeFileList(int type, int uId, int nowPage, int pageSize) {
		int pageNum = this.typeFilePage(type, uId, pageSize);   
		System.out.println("nowPage"+nowPage+"pageNum"+pageNum);    
		if (nowPage <= 1) {
			nowPage = 1;
		} else if (nowPage>pageNum) { 
			nowPage = pageNum;
		}
		int start = (nowPage - 1) * pageSize;
		System.out.println("start:" + start+"nowPage"+nowPage);   
		List<File> fileList = mapper2.fileByType(type, uId, start, pageSize); 
		System.out.println("【Imp FileList:】" + fileList);
		return fileList;
	}
	public List<File>  findRecycleFile(int uId){
		List<File>  file=mapper2.findRecycleFile(uId);
		if(file!=null){
		for(int i=0;i<file.size();i++){
			File f=file.get(i);
			if(f.getDirectoryId()!=0){		
				
			Directory d=mapper1.selectByPrimaryKey(f.getDirectoryId());
			if(d==null){
				System.out.println("父目录不存在："+f);
				file.remove(i);
				i--;
			}
			else if(d.getDirectoryStatus()==3){
				file.remove(i); 
				i--;  
			}
			} 
			} 
		}
		System.out.println("回收文件"+file);
		return file;
		
	}
	public List<Directory>  findRecycleDir(int uId){

	
		List<Directory> dir=mapper1.findRecycleDir(uId);
		System.out.println("回收站目录显示1："+dir);  
		if(dir!=null){
			for(int i=0;i<dir.size();i++){	
				//System.out.println("i="+i);  
				if(dir.get(i).getParentId()!=0){ 				
				Directory d=mapper1.selectByPrimaryKey(dir.get(i).getParentId());
				if(d==null){
					System.out.println("父目录不存在："+dir.get(i)); 
					dir.remove(i);
					i--;    
				}
				else if(d.getDirectoryStatus()==3){  
					dir.remove(i); 
					i--;
				}
				} 
				
				}  
			}   
		System.out.println("回收文件夹显示2："+dir); 
		return dir; 
		
	}

	@Override
	public int deleteRecDir(String[] dirIdList, String[] fileIdList, int uId) {
		for (int i = 0; i < dirIdList.length; i++) {
			this.deleteRDir(Integer.parseInt(dirIdList[i]), uId);
			Directory dir = mapper1.selectByPrimaryKey(Integer.parseInt(dirIdList[i]));
			dir.setDirectoryStatus(3);
			System.out.println("回收站 删除顶层文件夹:" + dirIdList[i]);
			
			mapper1.deleteByPrimaryKey(dir.getDirectoryId());
		}
		for (int i = 0; i < fileIdList.length; i++) {
			System.out.println("回收站  删除顶层文件:" + fileIdList[i]);
			File file = mapper2.selectByPrimaryKey(Integer.parseInt(fileIdList[i]));
			
			//删除真实文件
			//删除数据库信息
			mapper2.deleteByPrimaryKey(file.getFileId());
		}
		return 0;
	} 
	//回收站删除
	public void deleteRDir(int dirId, int uId) {
		Directory dir = new Directory();
		dir.setParentId(dirId);
		dir.setUserId(uId);
		//删除当前目录文件
		List<File> fileList = mapper2.userSelectAllFileByDirId(dirId, uId);
		for (int i = 0; i < fileList.size(); i++) {
			System.out.println(" 回收站   删除文件:" + fileList.get(i).getFileName());

			//删除真实文件
			
			//删除数据库信息
			mapper2.deleteByPrimaryKey(fileList.get(i).getFileId());

		}
		List<Directory> dirList = mapper1.findChidrenById(dir);
		System.out.println("回收站 子文件夹长度:"+dirList.size()); 		
		if (dirList.size() == 0) {
			
		} else {
			for (int i = 0; i < dirList.size(); i++) {
				this.deleteDir(dirList.get(i).getDirectoryId(), uId);
				System.out.println("回收站  删除文件夹：" + dirList.get(i).getDirectoryName()); 		
				mapper1.deleteByPrimaryKey(dirList.get(i).getDirectoryId());
			}

		}

	}
	@Override
	public int reRecyle(String[] dirIdList, String[] fileIdList, int uId) {
		for (int i = 0; i < dirIdList.length; i++) {
			this.reDir(Integer.parseInt(dirIdList[i]), uId); 
			System.out.println("恢复顶层文件夹:" + dirIdList[i]);
			Directory dir = mapper1.selectByPrimaryKey(Integer.parseInt(dirIdList[i]));
			dir.setDirectoryStatus(1);
			mapper1.updateByPrimaryKey(dir);
		}
		for (int i = 0; i < fileIdList.length; i++) {
			System.out.println("恢复顶层文件:" + fileIdList[i]);
			File file = mapper2.selectByPrimaryKey(Integer.parseInt(fileIdList[i]));
			file.setFileStatus(1);
			mapper2.updateByPrimaryKey(file);
		}
		return 0;
	}

	public void reDir(int dirId, int uId) { 		
		List<File> fileList = mapper2.alreadyDeleteFileByDirId(dirId);
		//System.out.println("test2:"+fileList);
		for (int i = 0; i < fileList.size(); i++) {
		System.out.println("恢复文件:" + fileList.get(i).getFileName());
			fileList.get(i).setFileStatus(1);
			mapper2.updateByPrimaryKey(fileList.get(i));

		}  
		List<Directory> dirList = mapper1.alreadyDeleteDirById(dirId);
		System.out.println("恢复 -子文件夹长度:"+dirList.size()); 
		if (dirList.size() == 0) {  
			
		} else {
			for (int i = 0; i < dirList.size(); i++) {
				this.reDir(dirList.get(i).getDirectoryId(), uId);
				System.out.println("恢复 文件夹：" + dirList.get(i).getDirectoryName());
				dirList.get(i).setDirectoryStatus(1);
				mapper1.updateByPrimaryKey(dirList.get(i));
			}

		}

	}
	
}
