package com.yxb.exam.entity;

import java.util.ArrayList;
import java.util.List;

/**
 * 考试命题审批表实体
 *
 * Created by yxb on 2018/5/18
 */
public class Exam {

    /**
     * 主键
     */
    private Integer id;

    private String name;

    private Integer courseId;

    private String courseName;

    private Integer instituteId;

    private String instituteName;

    private Integer staffRoomId;

    private Integer developerId;

    private String developerName;

    private String classIds;

    private List<Integer> classIdList = new ArrayList<>();

    private String classesName;

    /**
     * 考核方式（开卷、闭卷、机试、论文、其他）
     */
    private String testType;

    private String courseEndTime;

    private Long timestamp;

    private String createTime;

    private String fileName;

    /**
     * 命题方式（题库抽题、集体出题、任课教师出题、他人出题）
     */
    private String propositionType;

    /**
     * 以下为试做人所填信息
     * 试卷类型（A、B）
     */
    private String testPaperType;

    /**
     *是否有标准答案及评分标准（1：有、0：无）
     */
    private String ifHaveAnswer;

    /**
     * 考试时间
     */
    private String examTime;

    /**
     * 试做人试做所需时间
     */
    private String testDoNeedTime;

    /**
     * 试做总结
     */
    private String testDoSummary;

    /**
     * 试做人id
     */
    private Integer testerId;

    private String testerName;

    /**
     * 试做时间
     */
    private String testDoTime;

    /**
     *
     * 审批人
     */
    private Integer approverId;

    private String approverName;

    private String approveTime;

    /**
     * 流转状态（1：创建状态，待试做人试做，2：试做状态，待审批，3：审核通过，0：审核不通过）
     */
    private String state;

    public String getApproveTime() {
        return approveTime;
    }

    public void setApproveTime(String approveTime) {
        this.approveTime = approveTime;
    }

    public String getApproverName() {
        return approverName;
    }

    public void setApproverName(String approverName) {
        this.approverName = approverName;
    }

    public String getTesterName() {
        return testerName;
    }

    public void setTesterName(String testerName) {
        this.testerName = testerName;
    }

    private List<Integer> indexPointId = new ArrayList<>();

    private List<String> testMode = new ArrayList<>();

    private List<String> score = new ArrayList<>();

    public List<Integer> getIndexPointId() {
        return indexPointId;
    }

    public void setIndexPointId(List<Integer> indexPointId) {
        this.indexPointId = indexPointId;
    }

    public List<String> getTestMode() {
        return testMode;
    }

    public void setTestMode(List<String> testMode) {
        this.testMode = testMode;
    }

    public List<String> getScore() {
        return score;
    }

    public void setScore(List<String> score) {
        this.score = score;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getCourseId() {
        return courseId;
    }

    public void setCourseId(Integer courseId) {
        this.courseId = courseId;
    }

    public Integer getInstituteId() {
        return instituteId;
    }

    public void setInstituteId(Integer instituteId) {
        this.instituteId = instituteId;
    }

    public Integer getStaffRoomId() {
        return staffRoomId;
    }

    public void setStaffRoomId(Integer staffRoomId) {
        this.staffRoomId = staffRoomId;
    }

    public Integer getDeveloperId() {
        return developerId;
    }

    public void setDeveloperId(Integer developerId) {
        this.developerId = developerId;
    }

    public String getClassIds() {
        return classIds;
    }

    public void setClassIds(String classIds) {
        this.classIds = classIds;
    }

    public List<Integer> getClassIdList() {
        return classIdList;
    }

    public void setClassIdList(List<Integer> classIdList) {
        this.classIdList = classIdList;
    }

    public String getTestType() {
        return testType;
    }

    public void setTestType(String testType) {
        this.testType = testType;
    }

    public String getCourseEndTime() {
        return courseEndTime;
    }

    public void setCourseEndTime(String courseEndTime) {
        this.courseEndTime = courseEndTime;
    }

    public Long getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Long timestamp) {
        this.timestamp = timestamp;
    }

    public String getPropositionType() {
        return propositionType;
    }

    public void setPropositionType(String propositionType) {
        this.propositionType = propositionType;
    }

    public String getTestPaperType() {
        return testPaperType;
    }

    public void setTestPaperType(String testPaperType) {
        this.testPaperType = testPaperType;
    }

    public String getIfHaveAnswer() {
        return ifHaveAnswer;
    }

    public void setIfHaveAnswer(String ifHaveAnswer) {
        this.ifHaveAnswer = ifHaveAnswer;
    }

    public String getExamTime() {
        return examTime;
    }

    public void setExamTime(String examTime) {
        this.examTime = examTime;
    }

    public String getTestDoNeedTime() {
        return testDoNeedTime;
    }

    public void setTestDoNeedTime(String testDoNeedTime) {
        this.testDoNeedTime = testDoNeedTime;
    }

    public String getTestDoSummary() {
        return testDoSummary;
    }

    public void setTestDoSummary(String testDoSummary) {
        this.testDoSummary = testDoSummary;
    }

    public Integer getTesterId() {
        return testerId;
    }

    public void setTesterId(Integer testerId) {
        this.testerId = testerId;
    }

    public String getTestDoTime() {
        return testDoTime;
    }

    public void setTestDoTime(String testDoTime) {
        this.testDoTime = testDoTime;
    }

    public Integer getApproverId() {
        return approverId;
    }

    public void setApproverId(Integer approverId) {
        this.approverId = approverId;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getInstituteName() {
        return instituteName;
    }

    public void setInstituteName(String instituteName) {
        this.instituteName = instituteName;
    }

    public String getDeveloperName() {
        return developerName;
    }

    public void setDeveloperName(String developerName) {
        this.developerName = developerName;
    }

    public String getClassesName() {
        return classesName;
    }

    public void setClassesName(String classesName) {
        this.classesName = classesName;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }
}
