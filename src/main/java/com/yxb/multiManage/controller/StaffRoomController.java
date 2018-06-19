package com.yxb.multiManage.controller;

import com.yxb.common.constant.Const;
import com.yxb.common.entity.AjaxResult;
import com.yxb.common.entity.Page;
import com.yxb.common.util.StringUtil;
import com.yxb.multiManage.entity.Course;
import com.yxb.multiManage.entity.StaffRoom;
import com.yxb.multiManage.service.CourseService;
import com.yxb.multiManage.service.StaffRoomService;
import com.yxb.user.entity.User;
import com.yxb.user.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by yxb on 2018/5/5
 */
@Controller
@RequestMapping("/staffRoomController")
public class StaffRoomController {

    private static final Logger log = LoggerFactory.getLogger(StaffRoomController.class);

    @Autowired
    private StaffRoomService staffRoomService;
    @Autowired
    private UserService userService;

    @ResponseBody
    @RequestMapping("/queryAll.do")
    public Object queryAll() {
        AjaxResult result = new AjaxResult();
        try {
            List<StaffRoom> staffRoomList = staffRoomService.queryAll();
            result.setData(staffRoomList);
            result.setSuccess(true);
        } catch (Exception e) {
            log.error("获取所有教研室出现异常",e);
            result.setData(e.getMessage());
        }
        return result;
    }

    @RequestMapping("/toIndex.do")
    public String toCourseList(Model model) {
        List<User> headerList = userService.queryUserListByRoleId(Const.VICE_DEAN_OF_TEACHING);
        model.addAttribute("headerList",headerList);
        return "manager/multiManage/list_staffRoom";
    }

    @ResponseBody
    @RequestMapping("/queryStaffRoomList.do")
    public Object queryStaffRoomList(String queryText, Integer pageNo, Integer pageSize) {
        AjaxResult<StaffRoom> result = new AjaxResult<>();
        try {
            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("start", (pageNo - 1) * pageSize);
            paramMap.put("size", pageSize);
            if (StringUtil.isNotEmpty(queryText)) paramMap.put("queryText", queryText);
            Page<StaffRoom> page = staffRoomService.queryStaffRoomList(paramMap, pageNo, pageSize);
            result.setPage(page);
            result.setSuccess(true);
        } catch (Exception e) {
            log.error("分页查询教研室出错",e);
            result.setData(e.getMessage());
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/editStaffRoom.do")
    public Object editStaffRoom(StaffRoom staffRoom) {
        AjaxResult result = new AjaxResult();
        try {
            staffRoomService.editStaffRoom(staffRoom);
            result.setSuccess(true);
        } catch (Exception e) {
            result.setData(e.getMessage());
            log.error("修改教研室遇到异常",e);
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/addStaffRoom.do")
    public Object addStaffRoom(StaffRoom staffRoom) {
        AjaxResult result = new AjaxResult();
        try {
            staffRoomService.addStaffRoom(staffRoom);
            result.setSuccess(true);
        } catch (Exception e) {
            result.setData(e.getMessage());
            log.error("新增教研室遇到异常",e);
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/deleteStaffRoom.do")
    public Object deleteStaffRoom(Integer id) {
        AjaxResult result = new AjaxResult();
        try {
            staffRoomService.deleteStaffRoom(id);
            result.setSuccess(true);
        } catch (Exception e) {
            result.setData(e.getMessage());
            log.error("删除教研室遇到异常",e);
        }
        return result;
    }
}
