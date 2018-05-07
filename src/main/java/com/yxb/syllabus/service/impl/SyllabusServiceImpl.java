package com.yxb.syllabus.service.impl;

import com.yxb.common.constant.Const;
import com.yxb.common.entity.Page;
import com.yxb.syllabus.dao.SyllabusDao;
import com.yxb.syllabus.entity.Syllabus;
import com.yxb.syllabus.service.SyllabusService;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.List;
import java.util.Map;

/**
 * Created by yxb on 2018/5/1
 */
@Service
public class SyllabusServiceImpl implements SyllabusService {

    private static final Logger log = LoggerFactory.getLogger(SyllabusServiceImpl.class);

    private final SyllabusDao syllabusDao;

    @Autowired
    public SyllabusServiceImpl(SyllabusDao syllabusDao) {
        this.syllabusDao = syllabusDao;
    }

    @Override
    public Page<Syllabus> querySyllabusList(Map<String, Object> paramMap, Integer pageNo, Integer pageSize) {
        paramMap.put("status", Const.ENABLE_1);
        List<Syllabus> syllabusList = syllabusDao.queryAll(paramMap);
        Page<Syllabus> page = new Page<>();
        if (!CollectionUtils.isEmpty(syllabusList)) {
            Integer totalSize = syllabusDao.querySyllabusCount(paramMap);
            page.setData(syllabusList);
            page.setPageNo(pageNo);
            page.setPageSize(pageSize);
            page.setTotalNo(totalSize, pageSize);
            page.setTotalSize(totalSize);
        }
        return page;
    }

    /**
     * 根据id查找教学大纲
     *
     * @param id 教学大纲id
     * @return Syllabus
     */
    @Override
    public Syllabus queryById(Integer id) {
        Syllabus syllabus = new Syllabus();
        syllabus.setId(id);
        syllabus.setStatus(Const.ENABLE_1);
        return syllabusDao.queryById(syllabus);
    }

    /**
     * 更新教学大纲
     *
     * @param syllabus 前台数据
     */
    @Override
    public void updateSyllabus(Syllabus syllabus) {
        syllabus.setTimestamp(System.currentTimeMillis());
        if (StringUtils.isBlank(syllabus.getName())) {
            syllabus.setName(syllabus.getCourseName() + "教学大纲");
        }
        syllabusDao.updateSyllabus(syllabus);
    }

    /**
     * 逻辑删除
     *
     * @param id 教学大纲id
     */
    @Override
    public void deleteSyllabus(Integer id) {
        Syllabus syllabus = this.queryById(id);
        syllabus.setTimestamp(System.currentTimeMillis());
        syllabus.setStatus(Const.UNENABLE_0);
        this.updateSyllabus(syllabus);
    }

    @Override
    public void addSyllabus(Syllabus syllabus) {
        syllabus.setTimestamp(System.currentTimeMillis());
        syllabus.setStatus(Const.ENABLE_1);
        if(StringUtils.isBlank(syllabus.getName())) {
            syllabus.setName(syllabus.getCourseName()+"教学大纲");
        }
        syllabusDao.addSyllabus(syllabus);
    }
}
