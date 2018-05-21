package com.yxb.exam.service;

import com.yxb.common.entity.Page;
import com.yxb.exam.entity.Exam;
import com.yxb.exam.entity.TestMethod;

import java.util.List;
import java.util.Map;

/**
 * Created by yxb on 2018/5/19
 */
public interface ExamService {

    Page<Exam> queryListByPage(Map<String, Object> paramMap, Integer pageNo, Integer pageSize);

    Exam queryById(Integer examId);

    String assignTestDoPerson(Integer teacherId, Integer examId);

    void addExam(Exam exam);

    void updateExam(Exam exam);

    List<TestMethod> queryTestMethodByCourseId(Integer courseId);

    void updateExamTestDoInfo(Exam exam);

    void assignApprover(Integer examId, Integer teacherId);

    String approve(String state, Integer examId);

    void deleteById(Integer id);

    Exam queryByCourseId(Integer courseId);

    Integer queryMyTestDoCount(Map<String, Object> paramMap);

    void updateFileName(Exam exam);
}
