package com.qst.controller;

import com.qst.aspect.LoginType;
import com.qst.entity.Person;
import com.qst.entity.User;
import com.qst.service.UserService;
import com.qst.tool.CommonExcel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * @Auther: CGL
 * @Date: 2019/9/2 09:14
 * @Description: 用户类后台管理控制器
 */

@Controller
@LoginType
public class UserBackController {
    private final static int PAGE_SIZE = 10;

    @Autowired
    private UserService userService;

    /**
     * 分页查看状态为 启用与禁用的用户列表
     * @param request
     * @param model
     * @param page
     * @return
     */
    @RequestMapping("/showUsers")
    public String showUserList(HttpServletRequest request, Model model,Integer page){
       // System.out.println(page);
        if(page==null||page <1 )
            page = 1;
        List<User> userList = userService.selectByPage(4,1,PAGE_SIZE);
     //   System.out.println(userList.get(0).toString());
        int totalNum = userService.searchStatusCount(4);
        int totalPage = totalNum%PAGE_SIZE>0 ? totalNum/PAGE_SIZE+1 :totalNum/PAGE_SIZE;
        model.addAttribute("totalNum",totalNum);
        model.addAttribute("userList",userList);
        model.addAttribute("page",page);
        model.addAttribute("totalPage",totalPage);
        return "../back/userList";
    }

    /**
     * 查看待审核用户列表
     * @param model
     * @param request
     * @param page
     * @return
     */
    @RequestMapping("/showAuditionUsers")
    public String showAuditionUser(Model model,HttpServletRequest request,Integer page){
        if(page==null||page <1 )
            page = 1;
        List<User> userList = userService.selectByPage(0,1,PAGE_SIZE);
        //   System.out.println(userList.get(0).toString());
        int totalNum = userService.searchStatusCount(0);
        int totalPage = totalNum%PAGE_SIZE>0 ? totalNum/PAGE_SIZE+1 :totalNum/PAGE_SIZE;
        model.addAttribute("totalNum",totalNum);
        model.addAttribute("userList",userList);
        model.addAttribute("page",page);
        model.addAttribute("totalPage",totalPage);
        return "../back/auditionUserList";
    }

    /**
     * 查看已删除用户列表
     * @param model
     * @param page
     * @return
     */
    @RequestMapping("/showDeleteUsers")
    public String showDeleteUser(Model model,Integer page){
        if(page==null||page <1 )
            page = 1;
        List<User> userList = userService.selectByPage(3,1,PAGE_SIZE);
        //   System.out.println(userList.get(0).toString());
        int totalNum = userService.searchStatusCount(3);
        int totalPage = totalNum%PAGE_SIZE>0 ? totalNum/PAGE_SIZE+1 :totalNum/PAGE_SIZE;
        model.addAttribute("totalNum",totalNum);
        model.addAttribute("userList",userList);
        model.addAttribute("page",page);
        model.addAttribute("totalPage",totalPage);
        return "../back/deleteUserList";

    }

    /**
     * 启用与禁用用户
     * @param model
     * @param request
     * @param userId
     * @param response
     * @return
     */
    @RequestMapping("/stopAndStart")
    @ResponseBody
    public String stopAndStart(Model model, HttpServletRequest request, Integer userId, HttpServletResponse response){
        //System.out.println(userId);
        String result = userService.stopAndStart(userId);
      //  System.out.println(result);
        return  result;
    }

    /**
     * 恢复被删除用户
     * @param model
     * @param userId
     * @return
     */
    @RequestMapping("/resumeUser")
    @ResponseBody
    public String resumeUser(Model model,Integer userId){
        String result = "error";
        User user = userService.selectById(userId);
        if(user.getUserStatus()==3){
            user.setUserStatus(1);
            userService.updateByPrimaryKeySelective(user);
            result = "success";
        }

        return result;
    }

    /**
     * 注销账号  将数据彻底删除
     * @param userId
     * @return
     */
    @RequestMapping("/resetUser")
    @ResponseBody
    public String resetUser(Integer userId){
        String result = userService.resetUser(userId);

        return result;
    }

    /**
     * 审核用户
     * @param userId
     * @return
     */
    @RequestMapping("/auditingUser")
    @ResponseBody
    public String auditionUser(Integer userId){
      // String result = userService.auditingUser(userId);
       //return result;
        String result = "error";
        User user = userService.selectById(userId);
        if(user.getUserStatus()==0){
            user.setUserStatus(1);
            userService.updateByPrimaryKeySelective(user);
            result = "success";
        }
        return result;
    }

    /**
     * 批量删除用户信息
     * @param model
     * @param request
     * @param userId
     * @return
     */
    @RequestMapping("/batchDeleteUser")
    public String deleteMany(Model model,HttpServletRequest request,Integer[] userId){
      //  System.out.println(userId.toString());
        userService.deleteMany(userId);
        return showUserList(request,model,1);
    }

    /**
     * 根据id删除单个用户
     * @param model
     * @param userId
     * @return
     */
    @RequestMapping("/deleteUser")
    @ResponseBody
    public String deleteUser(Model model,Integer userId){
        String result = "error";
        if(userService.deleteById(userId)>0)
            result = "success";

        return result;
    }

    /**
     * 查看用户信息
     * @param model
     * @param userId
     * @return
     */
    @RequestMapping("/userDetail")
    public String userDetail(Model model,Integer userId){
        User user = userService.selectById(userId);
      //  System.out.println(user);
        model.addAttribute("user",user);
        return "../back/user-show";
    }

    @RequestMapping("/exportUser")
    @ResponseBody
    public String downLoadExcel(HttpServletRequest request,HttpServletResponse response,Integer page) throws IOException {

        String result = "error";
        // Service层获取数据库 的数据
        System.out.println(page);
        String fileName="用户报表"+String.valueOf(System.currentTimeMillis()).substring(4,13)+".xls";
        List<User> userList=userService.selectByPage(4,page,PAGE_SIZE);
      /*  response.setContentType("application/octet-stream");
        response.setContentType("application/OCTET-STREAM;charset=UTF-8");
        response.setHeader("Content-Disposition", "attachment;filename="+fileName );*/

        // 定义标题（第一行）
        String title = "用户报表";

        // 定义列名（第二行）
        String[] rowsName = new String[]{"序号","用户名","密码","邮箱","手机号","注册时间"};

        // 定义主题内容（第三行起）
        List<Object[]>  dataList = new ArrayList<Object[]>();

        // 定义每一行的临时变量，并放入数据
        Object[] objs = null;
        for (int i = 0; i < userList.size(); i++) {
            objs = new Object[rowsName.length];
            objs[0] = i;
            objs[1] = userList.get(i).getUserName();
            objs[2] = userList.get(i).getUserPassword();
            objs[3] = userList.get(i).getPerson().getEmail();
            objs[4] = userList.get(i).getPerson().getPhone();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            objs[5] = dateFormat.format(userList.get(i).getPerson().getCreateDatetime());
            dataList.add(objs);
        }
        String fPath = null;
            try {
                fPath = CommonExcel.export(title, rowsName, dataList);
            } catch (Exception e1) {
                // TODO Auto-generated catch block
                e1.printStackTrace();
            }
            if (fPath != null) {
                result = fPath;
            }

        // 定义Excel文件名

        return result;
    }

    /**
     * 更新用户回显链接
     * @param model
     * @param userId
     * @return    返回用户基本信息展示页面
     */
    @RequestMapping("/modifyUser")
    public String updateUser(Model model,Integer userId){
        System.out.println(11111);
        User user = userService.selectById(userId);
        model.addAttribute("user",user);
        System.out.println(user);
        return "../back/user-edit";
    }

    @RequestMapping("/submitModify")
    @ResponseBody
    public String submitUpdate(Model model,User user,Person person){
       // System.out.println("进入修改提交界面");
        String result = "error";
        user.setPerson(person);
        try {
            result = userService.updateUser(user);
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
      //  System.out.println(user);
        //System.out.println(person);
        return result;
    }

    /**
     * 异步插入数据
     * @param user
     * @param person
     * @return
     */
    @RequestMapping("/insertUser")
    @ResponseBody
    public String insertUser(User user,Person person){
        String result = "error";
        System.out.println("进入插入方法");
        user.setPerson(person);
        try{
            result = userService.insertUser(user);
        }catch (Exception e){
            e.printStackTrace();
            return "error";
        }
        return result;
    }

    @RequestMapping("/sexInfo")
    public String sexInfo(Model model){
        HashMap<String,Integer> sexCount = userService.sexInfo();
        model.addAttribute("sexCount",sexCount);
        System.out.println(sexCount);
        return "../back/sexInfo";
    }

    @RequestMapping("/ageInfo")
    public String ageInfo(Model model){
        HashMap<String,Integer> ageCount = userService.ageInfo();
        model.addAttribute("ageCount",ageCount);
        return "../back/ageInfo";
    }

   /* @RequestMapping("/fuzzySearch")
    public String fuzzySearch(Model model,Integer page,Integer status,String key){

        return "";
    }*/

}
