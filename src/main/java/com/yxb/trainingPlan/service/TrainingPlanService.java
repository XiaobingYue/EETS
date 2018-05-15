package com.yxb.trainingPlan.service;

import com.yxb.common.entity.Page;
import com.yxb.trainingPlan.entity.Plan;

import java.util.Map;

/**
 * Created by yxb on 2018/5/15
 */
public interface TrainingPlanService {

    Page<Plan> queryListByPage(Map<String,Object> paramMap,Integer pageNo,Integer pageSize);

    Plan queryById(Integer id);

    void updatePlan(Plan plan);

    void addPlan(Plan plan);

    void deleteById(Integer id);
}
