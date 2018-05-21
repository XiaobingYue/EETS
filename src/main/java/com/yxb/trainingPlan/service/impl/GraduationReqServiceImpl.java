package com.yxb.trainingPlan.service.impl;

import com.yxb.common.constant.Const;
import com.yxb.common.entity.Page;
import com.yxb.multiManage.entity.Profession;
import com.yxb.multiManage.service.ProfessionService;
import com.yxb.trainingPlan.dao.GraduationReqDao;
import com.yxb.trainingPlan.entity.GraduationReq;
import com.yxb.trainingPlan.service.GraduationReqService;
import com.yxb.trainingPlan.service.IndexPointService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.List;
import java.util.Map;

/**
 * Created by yxb on 2018/5/16
 */
@Service
public class GraduationReqServiceImpl implements GraduationReqService {

    @Autowired
    private GraduationReqDao graduationReqDao;
    @Autowired
    private ProfessionService professionService;
    @Autowired
    private IndexPointService indexPointService;

    @Override
    public Page<GraduationReq> queryListByPage(Map<String, Object> paramMap, Integer pageNo, Integer pageSize) {
        paramMap.put("state", Const.ENABLE_1);
        List<GraduationReq> graduationReqList = graduationReqDao.queryAll(paramMap);
        Page<GraduationReq> page = new Page<>();
        if (!CollectionUtils.isEmpty(graduationReqList)) {
            for(GraduationReq graduationReq : graduationReqList) {
                Profession profession = professionService.queryById(graduationReq.getProfessionId());
                graduationReq.setProfessionName(profession.getName());
            }
            Integer totalSize = graduationReqDao.queryCount(paramMap);
            page.setData(graduationReqList);
            page.setPageNo(pageNo);
            page.setPageSize(pageSize);
            page.setTotalNo(totalSize, pageSize);
            page.setTotalSize(totalSize);
        }
        return page;
    }

    @Override
    public GraduationReq queryById(Integer id) {
        return graduationReqDao.queryById(id);
    }

    @Override
    public void updateGraduationReq(GraduationReq graduationReq) {
        graduationReq.setTimestamp(System.currentTimeMillis());
        graduationReq.setState(Const.ENABLE_1);
        graduationReqDao.updateGraduationReq(graduationReq);
    }

    @Override
    public void addGraduationReq(GraduationReq graduationReq) {
        List<Integer> courseIdList = graduationReq.getCourseIdList();
        if (!CollectionUtils.isEmpty(graduationReq.getCourseIdList())) {
            StringBuilder courseIds = new StringBuilder();
            for (Integer id : courseIdList) {
                courseIds.append(id).append(",");
            }
            graduationReq.setCourseIds(courseIds.substring(0,courseIds.length()-1));
        }
        graduationReq.setTimestamp(System.currentTimeMillis());
        graduationReq.setState(Const.ENABLE_1);
        graduationReqDao.addGraduationReq(graduationReq);
    }

    @Override
    public void deleteById(Integer id) {
        GraduationReq graduationReq = graduationReqDao.queryById(id);
        graduationReq.setTimestamp(System.currentTimeMillis());
        graduationReq.setState(Const.UNENABLE_0);
        indexPointService.deleteByReqId(graduationReq.getId());
        graduationReqDao.updateGraduationReq(graduationReq);
    }
}
