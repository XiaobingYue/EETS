package com.yxb.syllabus.service;

import com.yxb.common.entity.Page;
import com.yxb.syllabus.entity.Syllabus;

import java.util.Map; /**
 * Created by yxb on 2018/5/1
 */
public interface SyllabusService {
    Page<Syllabus> querySyllabusList(Map<String, Object> paramMap, Integer pageNo, Integer pageSize);

    Syllabus queryById(Integer id);

    void updateSyllabus(Syllabus syllabus);

    void deleteSyllabus(Integer id);

    void addSyllabus(Syllabus syllabus);
}
