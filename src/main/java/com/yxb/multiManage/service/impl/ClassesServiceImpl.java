package com.yxb.multiManage.service.impl;

import com.yxb.common.constant.Const;
import com.yxb.common.entity.Page;
import com.yxb.multiManage.dao.ClassesDao;
import com.yxb.multiManage.entity.Classes;
import com.yxb.multiManage.entity.Course;
import com.yxb.multiManage.service.ClassesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by yxb on 2018/5/7
 */
@Service
public class ClassesServiceImpl implements ClassesService {

    @Autowired
    private ClassesDao classesDao;

    @Override
    public List<Classes> queryAllClasses() {
        Map<String , Object> paramMap = new HashMap<>();
        paramMap.put("state" , Const.ENABLE_1);
        return classesDao.queryAllClasses(paramMap);
    }

    @Override
    public Page<Classes> queryClassesList(Map<String, Object> paramMap, Integer pageNo, Integer pageSize) {
        paramMap.put("state" , Const.ENABLE_1);
        List<Classes> classesList = classesDao.queryAllClasses(paramMap);
        Page<Classes> page = new Page<>();
        if(!CollectionUtils.isEmpty(classesList)) {
            int count = classesDao.queryCount(paramMap);
            page.setPageNo(pageNo);
            page.setTotalSize(count);
            page.setPageSize(pageSize);
            page.setTotalNo(count , pageSize);
            page.setData(classesList);
        }
        return page;
    }

    @Override
    public void editClasses(Classes classes) {
        classes.setTimestamp(System.currentTimeMillis());
        classesDao.editClasses(classes);
    }

    @Override
    public void addClasses(Classes classes) {
        classes.setTimestamp(System.currentTimeMillis());
        classes.setState(Const.ENABLE_1);
        classesDao.addClasses(classes);
    }

    @Override
    public void deleteClasses(Integer id) {
        Classes classes = classesDao.queryById(id);
        if(classes != null) {
            classes.setState(Const.UNENABLE_0);
            classes.setTimestamp(System.currentTimeMillis());
            classesDao.editClasses(classes);
        }
    }

    @Override
    public Classes queryById(Integer id) {
        return classesDao.queryById(id);
    }
}
