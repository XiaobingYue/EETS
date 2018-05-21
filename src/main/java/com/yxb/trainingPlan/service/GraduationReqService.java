package com.yxb.trainingPlan.service;

import com.yxb.common.entity.Page;
import com.yxb.trainingPlan.entity.GraduationReq;

import java.util.Map;

/**
 * Created by yxb on 2018/5/16
 */
public interface GraduationReqService {

    Page<GraduationReq> queryListByPage(Map<String, Object> paramMap, Integer pageNo, Integer pageSize);

    GraduationReq queryById(Integer id);

    void updateGraduationReq(GraduationReq graduationReq);

    void addGraduationReq(GraduationReq graduationReq);

    void deleteById(Integer id);
}
