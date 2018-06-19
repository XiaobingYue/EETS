package com.yxb.syllabus.dao;

import com.yxb.syllabus.entity.Syllabus;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by yxb on 2018/5/1
 */
@Repository
public interface SyllabusDao {
    List<Syllabus> queryAll(Map<String, Object> paramMap);

    int querySyllabusCount(Map<String, Object> paramMap);

    Syllabus queryById(Syllabus syllabus);

    void updateSyllabus(Syllabus syllabus);

    void addSyllabus(Syllabus syllabus);
}
