package com.yxb.trainingPlan.dao;

import com.yxb.trainingPlan.entity.GraduationReq;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by yxb on 2018/5/16
 */
@Repository
public interface GraduationReqDao {

    List<GraduationReq> queryAll(Map<String,Object> paramMap);

    Integer queryCount(Map<String,Object> paramMap);

    GraduationReq queryById(Integer id);

    void updateGraduationReq(GraduationReq req);

    void addGraduationReq(GraduationReq req);
}
