package com.yxb.exam.service.impl;

import com.yxb.common.constant.Const;
import com.yxb.common.entity.Page;
import com.yxb.exam.dao.ExamDao;
import com.yxb.exam.entity.Exam;
import com.yxb.exam.entity.TestDetail;
import com.yxb.exam.entity.TestMethod;
import com.yxb.exam.service.ExamService;
import com.yxb.multiManage.entity.Classes;
import com.yxb.multiManage.entity.Course;
import com.yxb.multiManage.service.ClassesService;
import com.yxb.multiManage.service.CourseService;
import com.yxb.multiManage.service.InstituteService;
import com.yxb.score.service.ScoreService;
import com.yxb.trainingPlan.dao.IndexPointDao;
import com.yxb.trainingPlan.entity.IndexPoint;
import com.yxb.user.entity.User;
import com.yxb.user.service.UserService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by yxb on 2018/5/19
 */
@Service
public class ExamServiceImpl implements ExamService {

    @Autowired
    private ExamDao examDao;
    @Autowired
    private CourseService courseService;
    @Autowired
    private UserService userService;
    @Autowired
    private ClassesService classesService;
    @Autowired
    private IndexPointDao indexPointDao;
    @Autowired
    private InstituteService instituteService;
    @Autowired
    private ScoreService scoreService;

    @Override
    public Page<Exam> queryListByPage(Map<String, Object> paramMap, Integer pageNo, Integer pageSize) {
        List<Exam> examList = examDao.queryAll(paramMap);
        Page<Exam> page = new Page<>();
        if (!CollectionUtils.isEmpty(examList)) {
            for (Exam exam : examList) {
                Course course = courseService.queryById(exam.getCourseId());
                exam.setCourseName(course.getName());
                User developer = userService.queryById(exam.getDeveloperId());
                exam.setDeveloperName(developer.getName());
                String[] classesIds = exam.getClassIds().split(",");
                String classesName = "";
                for (String classesId : classesIds) {
                    Classes classes = classesService.queryById(Integer.valueOf(classesId));
                    classesName = classes.getClassName() + " ";
                }
                exam.setClassesName(classesName);
            }
            Integer totalSize = examDao.queryCount(paramMap);
            page.setData(examList);
            page.setPageNo(pageNo);
            page.setPageSize(pageSize);
            page.setTotalNo(totalSize, pageSize);
            page.setTotalSize(totalSize);
        }
        return page;
    }

    @Override
    public Exam queryById(Integer examId) {
        Exam exam = examDao.queryById(examId);
        Course course = courseService.queryById(exam.getCourseId());
        exam.setCourseName(course.getName());
        User developer = userService.queryById(exam.getDeveloperId());
        exam.setDeveloperName(developer.getName());
        String[] classesIds = exam.getClassIds().split(",");
        StringBuilder classesName = new StringBuilder();
        exam.setInstituteName(instituteService.queryById(exam.getInstituteId()).getName());
        for (String classesId : classesIds) {
            Classes classes = classesService.queryById(Integer.valueOf(classesId));
            classesName.append(classes.getClassName()).append(" ");
        }
        exam.setClassesName(classesName.toString());
        return exam;
    }

    /**
     * 指定试做人
     *
     * @param teacherId 试做人id
     * @param examId    审批表id
     * @return String
     */
    @Override
    public String assignTestDoPerson(Integer teacherId, Integer examId) {
        Exam exam = examDao.queryById(examId);
        if (exam != null && exam.getState().equals(Const.EXAM_STATE_1)) {
            exam.setTesterId(teacherId);
            exam.setState(Const.EXAM_STATE_2);
            examDao.assignTester(exam);
            return "";
        } else {
            return "不存在该审批表或者该审批表已指定试做人";
        }
    }

    @Override
    public void addExam(Exam exam) {
        StringBuilder classIds = new StringBuilder();
        for (Integer classId : exam.getClassIdList()) {
            classIds.append(classId).append(",");
        }
        Course course = courseService.queryById(exam.getCourseId());
        exam.setName(course.getName()+"命题审批表");
        exam.setClassIds(classIds.substring(0, classIds.length() - 1));
        exam.setTimestamp(System.currentTimeMillis());
        exam.setState(Const.EXAM_STATE_1);
        examDao.addExam(exam);

        List<String> testModeList = exam.getTestMode();
        List<String> scores = exam.getScore();
        for (int i=0;i<testModeList.size();i++) {
            TestMethod testMethod = new TestMethod();
            testMethod.setCourseId(exam.getCourseId());
            testMethod.setTestMode(testModeList.get(i));
            testMethod.setScores(scores.get(i));
            examDao.addTestMethod(testMethod);
        }
    }

    @Override
    public void updateExam(Exam exam) {
        StringBuilder classIds = new StringBuilder();
        for (Integer classId : exam.getClassIdList()) {
            classIds.append(classId).append(",");
        }
        Course course = courseService.queryById(exam.getCourseId());
        exam.setName(course.getName()+"命题审批表");
        exam.setClassIds(classIds.substring(0, classIds.length() - 1));
        exam.setTimestamp(System.currentTimeMillis());
        exam.setState(Const.EXAM_STATE_1);
        examDao.updateExam(exam);

        //将原来的考核办法根据课程id删除，重新加入最新的
        examDao.deleteTestMethodByCourseId(exam.getCourseId());
        List<String> testModeList = exam.getTestMode();
        List<String> scores = exam.getScore();
        for (int i=0;i<testModeList.size();i++) {
            TestMethod testMethod = new TestMethod();
            testMethod.setCourseId(exam.getCourseId());
            testMethod.setTestMode(testModeList.get(i));
            testMethod.setScores(scores.get(i));
            examDao.addTestMethod(testMethod);
        }
    }

    @Override
    public List<TestMethod> queryTestMethodByCourseId(Integer courseId) {
        return examDao.queryTestMethodByCourseId(courseId);
    }

    @Override
    public void updateExamTestDoInfo(Exam exam) {
        exam.setState(Const.EXAM_STATE_4);
        exam.setTimestamp(System.currentTimeMillis());
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        exam.setTestDoTime(sdf.format(new Date()));
        examDao.updateExamTestDoInfo(exam);
    }

    @Override
    public void assignApprover(Integer examId, Integer teacherId) {
        User user = userService.queryById(teacherId);
        Exam exam = examDao.queryById(examId);
        exam.setState(Const.EXAM_STATE_4);
        exam.setTimestamp(System.currentTimeMillis());
        exam.setApproverId(teacherId);
        exam.setApproverName(user.getName());
        examDao.assignApprover(exam);
    }

    @Override
    public String approve(String state, Integer examId) {
        Exam exam = examDao.queryById(examId);
        if (exam != null && exam.getState().equals(Const.EXAM_STATE_4)) {
            exam.setTimestamp(System.currentTimeMillis());
            exam.setState(state);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            exam.setApproveTime(sdf.format(new Date()));
            examDao.approve(exam);
            return "";
        } else {
            return "审批表不存在或者审批表状态不正确";
        }
    }

    /**
     * 删除命题审批表，同时删除课程考核办法及考核办法与指标点关系
     * modify by yxb on 2018/06/19
     * 同时删除分数信息
     *
     * @param id 命题审批表id
     */
    @Override
    public void deleteById(Integer id) {
        Exam exam = examDao.queryById(id);
        examDao.deleteSubIndexPointByTestMethodId(exam.getCourseId());
        examDao.deleteTestMethodByCourseId(exam.getCourseId());
        scoreService.deleteByExamId(exam.getId());
        examDao.deleteById(id);
    }

    @Override
    public Exam queryByCourseId(Integer courseId) {
        return examDao.queryByCourseId(courseId);
    }

    @Override
    public Integer queryMyTestDoCount(Map<String, Object> paramMap) {
        return examDao.queryCount(paramMap);
    }

    @Override
    public void updateFileName(Exam exam) {
        examDao.updateFileName(exam);
    }
}
