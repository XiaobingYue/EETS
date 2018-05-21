package com.yxb.trainingPlan.dao;

import com.yxb.trainingPlan.entity.IndexPoint;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by yxb on 2018/5/16
 */
@Repository
public interface IndexPointDao {

    List<IndexPoint> queryByReqId(Integer reqId);

    IndexPoint queryById(Integer id);

    List<String> queryCodesByReqId(Integer reqId);

    void addIndexPoint(IndexPoint point);

    void deleteByReqId(Integer reqId);

    List<IndexPoint> queryIndexPointByCourseId(Integer courseId);
}
