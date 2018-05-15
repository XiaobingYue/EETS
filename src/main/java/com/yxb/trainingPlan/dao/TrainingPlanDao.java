package com.yxb.trainingPlan.dao;

import com.yxb.trainingPlan.entity.Plan;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by yxb on 2018/5/15
 */

@Repository
public interface TrainingPlanDao {

    List<Plan> queryAll(Map<String,Object> paramMap);

    Integer queryCount(Map<String, Object> paramMap);

    Plan queryById(Integer id);

    void updatePlan(Plan plan);

    void addPlan(Plan plan);
}
