package com.yxb.trainingPlan.service.impl;

import com.yxb.multiManage.entity.Course;
import com.yxb.multiManage.service.CourseService;
import com.yxb.trainingPlan.dao.IndexPointDao;
import com.yxb.trainingPlan.entity.GraduationReq;
import com.yxb.trainingPlan.entity.IndexPoint;
import com.yxb.trainingPlan.service.GraduationReqService;
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
    @Autowired
    private CourseService courseService;
    @Autowired
    private GraduationReqService graduationReqService;

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

    @Override
    public List<IndexPoint> queryByCode(String code) {
        List<IndexPoint> indexPointList = indexPointDao.queryByCode(code);
        for (IndexPoint indexPoint :indexPointList) {
            Course course = courseService.queryById(indexPoint.getCourseId());
            if(course != null) {
                indexPoint.setCourseName(course.getName());
            }
        }
        return indexPointList;
    }

    /**
     * 修改指标点
     *
     * @param indexPoint 指标点
     */
    @Override
    public String editIndexPoint(IndexPoint indexPoint) {
        List<Integer> idList = indexPoint.getIdList();
        List<String> scoreList = indexPoint.getScoreList();
        for (int i=0;i<indexPoint.getIdList().size();i++) {
            IndexPoint point = indexPointDao.queryById(idList.get(i));
            if(point != null) {
                point.setCode(indexPoint.getCode());
                point.setName(indexPoint.getName());
                point.setScore(Float.parseFloat(scoreList.get(i)));
                indexPointDao.updateIndexPoint(point);
            }
        }
        return "";
       /* int count = indexPointDao.deleteByIds(indexPoint.getIdList());
        if (count == 0) {
            return "页面数据已过期，请刷新页面再进行操作";
        }
        GraduationReq graduationReq = graduationReqService.queryById(indexPoint.getReqId());
        if (graduationReq != null) {
            String[] courseIds = graduationReq.getCourseIds().split(",");
            for (int i=0;i<courseIds.length;i++) {
                IndexPoint point = new IndexPoint();
                point.setCode(indexPoint.getCode());
                point.setName(indexPoint.getName());
                point.setReqId(indexPoint.getReqId());
                point.setCourseId(Integer.valueOf(courseIds[i]));
                point.setScore(Float.parseFloat(indexPoint.getScoreList().get(i)));
                indexPointDao.addIndexPoint(point);
            }
        }
        return "";*/
    }

    @Override
    public void deleteByCode(String code) {
        indexPointDao.deleteByCode(code);
    }

}
