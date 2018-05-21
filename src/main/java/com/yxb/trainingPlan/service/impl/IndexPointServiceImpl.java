package com.yxb.trainingPlan.service.impl;

import com.yxb.trainingPlan.dao.IndexPointDao;
import com.yxb.trainingPlan.entity.IndexPoint;
import com.yxb.trainingPlan.service.IndexPointService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Created by yxb on 2018/5/16
 */
@Service
public class IndexPointServiceImpl implements IndexPointService {

    @Autowired
    private IndexPointDao indexPointDao;

    @Override
    public List<IndexPoint> queryByReqId(Integer id) {
        return indexPointDao.queryByReqId(id);
    }

    @Override
    public Set<String> queryCodesByReqId(Integer id) {
        List<String> codeList = indexPointDao.queryCodesByReqId(id);
        Set<String> codeSet = new HashSet<>();
        codeSet.addAll(codeList);
        return codeSet;
    }

    @Override
    public void addIndexPoint(IndexPoint point) {
        indexPointDao.addIndexPoint(point);
    }

    @Override
    public void deleteByReqId(Integer id) {
        indexPointDao.deleteByReqId(id);
    }

    @Override
    public List<IndexPoint> queryIndexPointByCourseId(Integer id) {
        return indexPointDao.queryIndexPointByCourseId(id);
    }
}
