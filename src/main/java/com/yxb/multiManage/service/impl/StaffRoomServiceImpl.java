package com.yxb.multiManage.service.impl;

import com.yxb.common.constant.Const;
import com.yxb.common.entity.Page;
import com.yxb.multiManage.dao.CourseDao;
import com.yxb.multiManage.dao.StaffRoomDao;
import com.yxb.multiManage.entity.Course;
import com.yxb.multiManage.entity.StaffRoom;
import com.yxb.multiManage.service.CourseService;
import com.yxb.multiManage.service.StaffRoomService;
import com.yxb.user.entity.User;
import com.yxb.user.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by yxb on 2018/5/5
 */
@Service
public class StaffRoomServiceImpl implements StaffRoomService {

    @Autowired
    private StaffRoomDao staffRoomDao;
    @Autowired
    private UserService userService;

    @Override
    public List<StaffRoom> queryAll() {
        Map<String , Object> paramMap = new HashMap<>();
        paramMap.put("state" , Const.ENABLE_1);
        return staffRoomDao.queryAll(paramMap);
    }

    @Override
    public Page<StaffRoom> queryStaffRoomList(Map<String, Object> paramMap, Integer pageNo, Integer pageSize) {
        paramMap.put("state" , Const.ENABLE_1);
        List<StaffRoom> staffRoomList = staffRoomDao.queryAll(paramMap);
        Page<StaffRoom> page = new Page<>();
        if(!CollectionUtils.isEmpty(staffRoomList)) {
            for(StaffRoom staffRoom : staffRoomList) {
                if (staffRoom.getHeaderId() != null) {
                    User user = userService.queryById(staffRoom.getHeaderId());
                    staffRoom.setHeaderName(user.getName());
                } else {
                    staffRoom.setHeaderName("");
                }
            }
            int count = staffRoomDao.queryCount(paramMap);
            page.setPageNo(pageNo);
            page.setTotalSize(count);
            page.setPageSize(pageSize);
            page.setTotalNo(count , pageSize);
            page.setData(staffRoomList);
        }
        return page;
    }

    @Override
    public void editStaffRoom(StaffRoom staffRoom) {
        staffRoom.setTimestamp(System.currentTimeMillis());
        staffRoomDao.editStaffRoom(staffRoom);
    }

    @Override
    public void addStaffRoom(StaffRoom staffRoom) {
        staffRoom.setTimestamp(System.currentTimeMillis());
        staffRoom.setState(Const.ENABLE_1);
        staffRoomDao.addStaffRoom(staffRoom);
    }

    @Override
    public void deleteStaffRoom(Integer id) {
        StaffRoom staffRoom = staffRoomDao.queryById(id);
        if(staffRoom != null) {
            staffRoom.setState(Const.UNENABLE_0);
            staffRoom.setTimestamp(System.currentTimeMillis());
            staffRoomDao.editStaffRoom(staffRoom);
        }
    }

    @Override
    public StaffRoom queryById(Integer id) {
        return staffRoomDao.queryById(id);
    }
}
