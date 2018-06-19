package com.yxb.multiManage.service;

import com.yxb.common.entity.Page;
import com.yxb.multiManage.entity.Course;
import com.yxb.multiManage.entity.StaffRoom;

import java.util.List;
import java.util.Map;

/**
 * Created by yxb on 2018/5/5
 */
public interface StaffRoomService {

    List<StaffRoom> queryAll();

    Page<StaffRoom> queryStaffRoomList(Map<String, Object> paramMap, Integer pageNo, Integer pageSize);

    void editStaffRoom(StaffRoom staffRoom);

    void addStaffRoom(StaffRoom staffRoom);

    void deleteStaffRoom(Integer id);

    StaffRoom queryById(Integer id);
}
