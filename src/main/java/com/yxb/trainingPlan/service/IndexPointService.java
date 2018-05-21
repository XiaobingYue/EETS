package com.yxb.trainingPlan.service;

import com.yxb.trainingPlan.entity.IndexPoint;

import java.util.List;
import java.util.Set;

/**
 * Created by yxb on 2018/5/16
 */
public interface IndexPointService {

    List<IndexPoint> queryByReqId(Integer id);

    Set<String> queryCodesByReqId(Integer id);

    void addIndexPoint(IndexPoint point);

    void deleteByReqId(Integer id);

    List<IndexPoint> queryIndexPointByCourseId(Integer id);
}
