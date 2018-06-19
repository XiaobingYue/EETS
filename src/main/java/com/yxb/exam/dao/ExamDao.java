package com.yxb.exam.dao;

import com.yxb.exam.entity.Exam;
import com.yxb.exam.entity.TestMethod;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by yxb on 2018/5/19
 */
@Repository
public interface ExamDao {

    List<Exam> queryAll(Map<String, Object> paramMap);

    Integer queryCount(Map<String, Object> paramMap);

    Exam queryById(Integer id);

    void addExam(Exam exam);

    void assignTester(Exam exam);

    void updateExam(Exam exam);

    void addTestMethod(TestMethod testMethod);

    List<TestMethod> queryTestMethodByCourseId(Integer courseId);

    void deleteTestMethodByCourseId(Integer courseId);

    void updateExamTestDoInfo(Exam exam);

    void assignApprover(Exam exam);

    void approve(Exam exam);

    void deleteById(Integer id);

    Exam queryByCourseId(Integer courseId);

    void updateFileName(Exam exam);

    void deleteSubIndexPointByTestMethodId(Integer courseId);
}

