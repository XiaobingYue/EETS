package com.yxb.trainingPlan.service.impl;

import com.yxb.common.constant.Const;
import com.yxb.common.entity.Page;
import com.yxb.multiManage.entity.Profession;
import com.yxb.multiManage.service.ProfessionService;
import com.yxb.trainingPlan.dao.TrainingPlanDao;
import com.yxb.trainingPlan.entity.Plan;
import com.yxb.trainingPlan.service.TrainingPlanService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.List;
import java.util.Map;

/**
 * Created by yxb on 2018/5/15
 */
@Service
public class TrainingPlanServiceImpl implements TrainingPlanService {

    @Autowired
    private TrainingPlanDao trainingPlanDao;
    @Autowired
    private ProfessionService professionService;


    @Override
    public Page<Plan> queryListByPage(Map<String, Object> paramMap,Integer pageNo,Integer pageSize) {
        paramMap.put("state", Const.ENABLE_1);
        List<Plan> planList = trainingPlanDao.queryAll(paramMap);
        Page<Plan> page = new Page<>();
        if (!CollectionUtils.isEmpty(planList)) {
            for(Plan plan : planList) {
                Profession profession = professionService.queryById(plan.getProfessionId());
                plan.setProfessionName(profession.getName());
            }
            Integer totalSize = trainingPlanDao.queryCount(paramMap);
            page.setData(planList);
            page.setPageNo(pageNo);
            page.setPageSize(pageSize);
            page.setTotalNo(totalSize, pageSize);
            page.setTotalSize(totalSize);
        }
        return page;
    }

    @Override
    public Plan queryById(Integer id) {
        return trainingPlanDao.queryById(id);
    }

    @Override
    public void updatePlan(Plan plan) {
        plan.setTimestamp(System.currentTimeMillis());
        plan.setState(Const.ENABLE_1);
        trainingPlanDao.updatePlan(plan);
    }

    @Override
    public void addPlan(Plan plan) {
        plan.setTimestamp(System.currentTimeMillis());
        plan.setState(Const.ENABLE_1);
        trainingPlanDao.addPlan(plan);
    }

    @Override
    public void deleteById(Integer id) {
        Plan plan = trainingPlanDao.queryById(id);
        plan.setTimestamp(System.currentTimeMillis());
        plan.setState(Const.UNENABLE_0);
        trainingPlanDao.updatePlan(plan);
    }
}
