package com.yxb.multiManage.dao;

import com.yxb.multiManage.entity.Course;
import com.yxb.multiManage.entity.StaffRoom;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by yxb on 2018/5/5
 */
@Repository
public interface StaffRoomDao {

    List<StaffRoom> queryAll(Map<String, Object> paramMap);

    int queryCount(Map<String, Object> paramMap);

    void editStaffRoom(StaffRoom staffRoom);

    void addStaffRoom(StaffRoom staffRoom);

    StaffRoom queryById(Integer id);
}
