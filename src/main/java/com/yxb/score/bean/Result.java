package com.yxb.score.bean;

import com.yxb.exam.entity.TestMethod;

import java.util.ArrayList;
import java.util.List;

/**
 * 分数分析结果Bean
 *
 * Created by yxb on 2018/5/30
 */
public class Result {

    private Integer examCount = 0;

    private Float maxScore = 0F;

    private Float minScore = 0F;

    private Float average = 0F;

    private Integer unPassCount = 0;

    private Float unPassRate = 0F;

    private Integer thanNinetyCount;

    private Float thanNinetyRate;

    private Integer between80To89Count;

    private Float between80To89Rate;

    private Integer between70To79Count;

    private Float between70To79Rate;

    private Integer between60To69Count;

    private Float between60To69Rate;

    private Integer between30To59Count;

    private Float between30To59Rate;

    private Integer between0To29Count;

    private Float between0To29Rate;

    private List<TestMethod> testMethodList = new ArrayList<>();

    public Integer getUnPassCount() {
        return unPassCount;
    }

    public void setUnPassCount(Integer unPassCount) {
        this.unPassCount = unPassCount;
    }

    public Integer getExamCount() {
        return examCount;
    }

    public void setExamCount(Integer examCount) {
        this.examCount = examCount;
    }

    public Float getMaxScore() {
        return maxScore;
    }

    public void setMaxScore(Float maxScore) {
        this.maxScore = maxScore;
    }

    public Float getMinScore() {
        return minScore;
    }

    public void setMinScore(Float minScore) {
        this.minScore = minScore;
    }

    public Float getAverage() {
        return average;
    }

    public void setAverage(Float average) {
        this.average = average;
    }

    public Float getUnPassRate() {
        return unPassRate;
    }

    public void setUnPassRate(Float unPassRate) {
        this.unPassRate = unPassRate;
    }

    public Integer getThanNinetyCount() {
        return thanNinetyCount;
    }

    public void setThanNinetyCount(Integer thanNinetyCount) {
        this.thanNinetyCount = thanNinetyCount;
    }

    public Float getThanNinetyRate() {
        return thanNinetyRate;
    }

    public void setThanNinetyRate(Float thanNinetyRate) {
        this.thanNinetyRate = thanNinetyRate;
    }

    public Integer getBetween80To89Count() {
        return between80To89Count;
    }

    public void setBetween80To89Count(Integer between80To89Count) {
        this.between80To89Count = between80To89Count;
    }

    public Float getBetween80To89Rate() {
        return between80To89Rate;
    }

    public void setBetween80To89Rate(Float between80To89Rate) {
        this.between80To89Rate = between80To89Rate;
    }

    public Integer getBetween70To79Count() {
        return between70To79Count;
    }

    public void setBetween70To79Count(Integer between70To79Count) {
        this.between70To79Count = between70To79Count;
    }

    public Float getBetween70To79Rate() {
        return between70To79Rate;
    }

    public void setBetween70To79Rate(Float between70To79Rate) {
        this.between70To79Rate = between70To79Rate;
    }

    public Integer getBetween60To69Count() {
        return between60To69Count;
    }

    public void setBetween60To69Count(Integer between60To69Count) {
        this.between60To69Count = between60To69Count;
    }

    public Float getBetween60To69Rate() {
        return between60To69Rate;
    }

    public void setBetween60To69Rate(Float between60To69Rate) {
        this.between60To69Rate = between60To69Rate;
    }

    public Integer getBetween30To59Count() {
        return between30To59Count;
    }

    public void setBetween30To59Count(Integer between30To59Count) {
        this.between30To59Count = between30To59Count;
    }

    public Float getBetween30To59Rate() {
        return between30To59Rate;
    }

    public void setBetween30To59Rate(Float between30To59Rate) {
        this.between30To59Rate = between30To59Rate;
    }

    public Integer getBetween0To29Count() {
        return between0To29Count;
    }

    public void setBetween0To29Count(Integer between0To29Count) {
        this.between0To29Count = between0To29Count;
    }

    public Float getBetween0To29Rate() {
        return between0To29Rate;
    }

    public void setBetween0To29Rate(Float between0To29Rate) {
        this.between0To29Rate = between0To29Rate;
    }

    public List<TestMethod> getTestMethodList() {
        return testMethodList;
    }

    public void setTestMethodList(List<TestMethod> testMethodList) {
        this.testMethodList = testMethodList;
    }
}
