package com.yxb.score.service.impl;

import com.yxb.common.util.Utils;
import com.yxb.exam.entity.Exam;
import com.yxb.exam.entity.SubIndexPoint;
import com.yxb.exam.entity.TestMethod;
import com.yxb.exam.service.ExamService;
import com.yxb.score.bean.Result;
import com.yxb.score.dao.ScoreDao;
import com.yxb.score.entity.Score;
import com.yxb.score.service.ScoreService;
import com.yxb.trainingPlan.entity.IndexPoint;
import com.yxb.trainingPlan.service.IndexPointService;
import com.yxb.user.entity.User;
import com.yxb.user.service.UserService;
import org.apache.commons.lang3.StringUtils;
import org.aspectj.weaver.ast.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.*;

/**
 * Created by yxb on 2018/5/30
 */
@Service
public class ScoreServiceImpl implements ScoreService {

    @Autowired
    private ScoreDao scoreDao;
    @Autowired
    private ExamService examService;
    @Autowired
    private UserService userService;
    @Autowired
    private IndexPointService indexPointService;


    @Override
    public List<Map<String, Object>> addScore(Integer id, List<IndexPoint> indexPointList) {
        Exam exam = examService.queryById(id);
        List<Score> scoreList = scoreDao.queryByExamId(id);
        if (CollectionUtils.isEmpty(scoreList)) {
            String[] classesIds = exam.getClassIds().split(",");
            List<User> stuList = new ArrayList<>();
            for (String classesId : classesIds) {
                stuList.addAll(userService.queryByClassesId(Integer.valueOf(classesId)));
            }
            for (User user : stuList) {
                Score score = new Score();
                score.setExamId(id);
                score.setStuCode(user.getUserAcct());
                score.setStuName(user.getName());
                if (!CollectionUtils.isEmpty(indexPointList)) {
                    String indexPointScore = "";
                    for (IndexPoint indexPoint : indexPointList) {
                        indexPointScore += "0,";
                    }
                    score.setIndexPointScore(indexPointScore.substring(0, indexPointScore.length() - 1));
                }
                scoreList.add(score);
            }
            if (!CollectionUtils.isEmpty(scoreList)) {
                scoreDao.addScore(scoreList);
            }
            scoreList = scoreDao.queryByExamId(id);
        }
        List<Map<String, Object>> result = new ArrayList<>();
        for (Score score : scoreList) {
            Map<String, Object> map = Utils.transBean2Map(score);
            if (StringUtils.isNotBlank(score.getIndexPointScore())) {
                String[] indexPointScore = score.getIndexPointScore().split(",");
                for (int i = 0; i < indexPointScore.length; i++) {
                    map.put("target" + i, indexPointScore[i]);
                }
            }
            result.add(map);
        }
        return result;
    }

    @Override
    public void editScore(Score score) {
        Float examScore = score.getOne() + score.getTwo() + score.getThree() + score.getFour() + score.getFive() + score.getSix() + score.getSeven() + score.getEight() + score.getNine() + score.getTen();
        score.setExamScore(examScore);
        scoreDao.updateScore(score);
    }

    @Override
    public void analysisScore(Score score) {
        Exam exam = examService.queryById(score.getExamId());
        List<TestMethod> testMethodList = examService.queryTestMethodByCourseId(exam.getCourseId());
        List<Integer> testMethodIdList = new ArrayList<>();
        for (TestMethod testMethod : testMethodList) {
            testMethodIdList.add(testMethod.getId());
        }
        List<SubIndexPoint> subIndexPointList = scoreDao.querySIPByTestMethodId(testMethodIdList);
        List<IndexPoint> indexPointList = indexPointService.queryIndexPointByCourseId(exam.getCourseId());
        Float testScale = score.getTestScale();
        Float dailyScale = score.getDailyScale();
        Float examScale = score.getExamScale();
        List<Score> scoreList = scoreDao.queryByExamId(score.getExamId());
        for (Score score1 : scoreList) {
            score1.setAllScore(Utils.format(score1.getExamScore() * examScale + score1.getTestScore() * testScale + score1.getDailyScore() * dailyScale));
            String indexPointScore = "";
            for (IndexPoint indexPoint : indexPointList) {
                Float examScore = 0F;
                Float testScore = 0F;
                Float dailyScore = 0F;
                Float examTotal = 0F;
                Float testTotal = 0F;
                Float dailyTotal = 0F;
                for (SubIndexPoint subIndexPoint : subIndexPointList) {
                    if (Objects.equals(subIndexPoint.getIndexPointId(), indexPoint.getId())) {
                        for (int i = 0; i < testMethodList.size(); i++) {
                            if (subIndexPoint.getTestMethodId().equals(testMethodList.get(i).getId())) {
                                switch (i) {
                                    case 0:
                                        testScore += score1.getTestScore();
                                        testTotal += Float.parseFloat(testMethodList.get(i).getScores());
                                        break;
                                    case 1:
                                        dailyScore += score1.getDailyScore();
                                        dailyTotal += Float.parseFloat(testMethodList.get(i).getScores());
                                        break;
                                    case 2:
                                        examScore += score1.getOne();
                                        examTotal += Float.parseFloat(testMethodList.get(i).getScores());
                                        break;
                                    case 3:
                                        examScore += score1.getTwo();
                                        examTotal += Float.parseFloat(testMethodList.get(i).getScores());
                                        break;
                                    case 4:
                                        examScore += score1.getThree();
                                        examTotal += Float.parseFloat(testMethodList.get(i).getScores());
                                        break;
                                    case 5:
                                        examScore += score1.getFour();
                                        examTotal += Float.parseFloat(testMethodList.get(i).getScores());
                                        break;
                                    case 6:
                                        examScore += score1.getFive();
                                        examTotal += Float.parseFloat(testMethodList.get(i).getScores());
                                        break;
                                    case 7:
                                        examScore += score1.getSix();
                                        examTotal += Float.parseFloat(testMethodList.get(i).getScores());
                                        break;
                                    case 8:
                                        examScore += score1.getSeven();
                                        examTotal += Float.parseFloat(testMethodList.get(i).getScores());
                                        break;
                                    case 9:
                                        examScore += score1.getEight();
                                        examTotal += Float.parseFloat(testMethodList.get(i).getScores());
                                        break;
                                    case 10:
                                        examScore += score1.getNine();
                                        examTotal += Float.parseFloat(testMethodList.get(i).getScores());
                                        break;
                                    case 11:
                                        examScore += score1.getTen();
                                        examTotal += Float.parseFloat(testMethodList.get(i).getScores());
                                        break;
                                }
                            }
                        }
                    }
                }
                if (examTotal > 0 && testTotal > 0 && dailyTotal > 0) {
                    examScore = (examScore / examTotal) * examScale;
                    testScore = (testScore / testTotal) * testScale;
                    dailyScore = (dailyScore / dailyTotal) * dailyScale;
                } else if (testTotal > 0 && examTotal == 0 && dailyScore == 0) {
                    testScore = (testScore / testTotal);
                    examScale = 0F;
                    dailyScore = 0F;
                } else if (dailyTotal > 0 && testTotal == 0 && examTotal == 0) {
                    dailyScore = (dailyScore / dailyTotal);
                    examScore = 0F;
                    testScore = 0F;
                } else if (examTotal > 0 && dailyTotal == 0 && testTotal == 0) {
                    examScore = (examScore / examTotal);
                    dailyScore = 0F;
                    testScore = 0F;
                } else if (examTotal > 0 && dailyTotal > 0 && testTotal == 0) {
                    Float newExamScale = examScale / (examScale + dailyScale);
                    Float newDailyScale = dailyScale / (examScale + dailyScale);
                    examScore = (examScore / examTotal) * newExamScale;
                    dailyScore = (dailyScore / dailyTotal) * newDailyScale;
                    testScore = 0F;
                } else if (examTotal > 0 && testTotal > 0 && dailyTotal == 0) {
                    Float newExamScale = examScale / (examScale + testScale);
                    Float newTestScale = testScale / (examScale + testScale);
                    examScore = (examScore / examTotal) * newExamScale;
                    testScore = (testScore / testTotal) * newTestScale;
                    dailyScore = 0F;
                } else if (examTotal == 0 && dailyTotal > 0 && testScore > 0) {
                    Float newDailyScale = dailyScale / (dailyScale + testScale);
                    Float newTestScale = testScale / (dailyScale + testScale);
                    dailyScore = (dailyScore / dailyTotal) * newDailyScale;
                    testScore = (testScore / testTotal) * newTestScale;
                    examScore = 0F;
                }
                indexPointScore += Utils.format(examScore + testScore + dailyScore) + ",";
            }
            if (StringUtils.isNotBlank(indexPointScore)) {
                score1.setIndexPointScore(indexPointScore.substring(0, indexPointScore.length() - 1));
            }
            scoreDao.analysisScore(score1);
        }
    }

    @Override
    public Result getScoreResult(Exam exam) {
        List<Score> scoreList = scoreDao.queryByExamId(exam.getId());
        Result result = new Result();
        Float totalScore = 0F;
        List<Float> testList = new ArrayList<>();
        List<Float> dailyList = new ArrayList<>();
        List<Float> oneList = new ArrayList<>();
        List<Float> twoList = new ArrayList<>();
        List<Float> threeList = new ArrayList<>();
        List<Float> fourList = new ArrayList<>();
        List<Float> fiveList = new ArrayList<>();
        List<Float> sixList = new ArrayList<>();
        List<Float> sevenList = new ArrayList<>();
        List<Float> eightList = new ArrayList<>();
        List<Float> nineList = new ArrayList<>();
        List<Float> tenList = new ArrayList<>();
        if (!CollectionUtils.isEmpty(scoreList)) {
            for (Score score : scoreList) {
                testList.add(score.getTestScore());
                dailyList.add(score.getDailyScore());
                oneList.add(score.getOne());
                twoList.add(score.getTwo());
                threeList.add(score.getThree());
                fourList.add(score.getFour());
                fiveList.add(score.getFive());
                sixList.add(score.getSix());
                sevenList.add(score.getSeven());
                eightList.add(score.getEight());
                nineList.add(score.getNine());
                tenList.add(score.getTen());
            }
            result = scoreDao.queryResult(exam.getId());
            result.setMaxScore(Utils.format(result.getMaxScore()));
            result.setMinScore(Utils.format(result.getMinScore()));
            List<TestMethod> testMethodList = examService.queryTestMethodByCourseId(exam.getCourseId());
            for (int i = 0; i < testMethodList.size(); i++) {
                switch (i) {
                    case 0:
                        Float totalTest = 0F;
                        for (Float test : testList) {
                            totalTest += test;
                        }
                        testMethodList.get(i).setAverage(Utils.format(totalTest / (float) result.getExamCount()));
                        break;
                    case 1:
                        Float totalDaily = 0F;
                        for (Float daily : dailyList) {
                            totalDaily += daily;
                        }
                        testMethodList.get(i).setAverage(Utils.format(totalDaily / (float) result.getExamCount()));
                        break;
                    case 2:
                        Float totalOne = 0F;
                        for (Float one : oneList) {
                            totalOne = totalOne + one;
                        }
                        testMethodList.get(i).setAverage(Utils.format(totalOne / (float) result.getExamCount()));
                        break;
                    case 3:
                        Float totalTwo = 0F;
                        for (Float two : twoList) {
                            totalTwo = totalTwo + two;
                        }
                        testMethodList.get(i).setAverage(Utils.format(totalTwo / (float) result.getExamCount()));
                        break;
                    case 4:
                        Float totalThree = 0F;
                        for (Float three : threeList) {
                            totalThree = totalThree + three;
                        }
                        testMethodList.get(i).setAverage(Utils.format(totalThree / (float) result.getExamCount()));
                        break;
                    case 5:
                        Float totalFour = 0F;
                        for (Float four : fourList) {
                            totalFour = totalFour + four;
                        }
                        testMethodList.get(i).setAverage(Utils.format(totalFour / (float) result.getExamCount()));
                        break;
                    case 6:
                        Float totalFive = 0F;
                        for (Float five : fiveList) {
                            totalFive = totalFive + five;
                        }
                        testMethodList.get(i).setAverage(Utils.format(totalFive / (float) result.getExamCount()));
                        break;
                    case 7:
                        Float totalSix = 0F;
                        for (Float six : sixList) {
                            totalSix = totalSix + six;
                        }
                        testMethodList.get(i).setAverage(Utils.format(totalSix / (float) result.getExamCount()));
                        break;
                    case 8:
                        Float totalSeven = 0F;
                        for (Float seven : sevenList) {
                            totalSeven = totalSeven + seven;
                        }
                        testMethodList.get(i).setAverage(Utils.format(totalSeven / (float) result.getExamCount()));
                        break;
                    case 9:
                        Float totalEight = 0F;
                        for (Float eight : eightList) {
                            totalEight = totalEight + eight;
                        }
                        testMethodList.get(i).setAverage(Utils.format(totalEight / (float) result.getExamCount()));
                        break;
                    case 10:
                        Float totalNine = 0F;
                        for (Float nine : nineList) {
                            totalNine = totalNine + nine;
                        }
                        testMethodList.get(i).setAverage(Utils.format(totalNine / (float) result.getExamCount()));
                        break;
                    case 11:
                        Float totalTen = 0F;
                        for (Float ten : tenList) {
                            totalTen = totalTen + ten;
                        }
                        testMethodList.get(i).setAverage(Utils.format(totalTen / (float) result.getExamCount()));
                        break;
                }
            }
            result.setTestMethodList(testMethodList);
            for (Score score : scoreList) {
                totalScore = totalScore + score.getAllScore();
            }
            result.setAverage(Utils.format(totalScore / (float) result.getExamCount()));
            int unPassCount = scoreDao.queryUnPassCount(exam.getId());
            result.setUnPassRate(Utils.format((float) unPassCount * 100 / (float) result.getExamCount()));
            int thanNinetyCount = scoreDao.queryThanNinetyCount(exam.getId());
            result.setThanNinetyCount(thanNinetyCount);
            result.setThanNinetyRate(Utils.format((float) thanNinetyCount * 100 / (float) result.getExamCount()));
            int between80To89Count = scoreDao.queryBetween80To89Count(exam.getId());
            result.setBetween80To89Count(between80To89Count);
            result.setBetween80To89Rate(Utils.format((float) between80To89Count * 100 / (float) result.getExamCount()));
            int between70To79Count = scoreDao.queryBetween70To79Count(exam.getId());
            result.setBetween70To79Count(between70To79Count);
            result.setBetween70To79Rate(Utils.format((float) between70To79Count * 100 / (float) result.getExamCount()));
            int between60To69Count = scoreDao.queryBetween60To69Count(exam.getId());
            result.setBetween60To69Count(between60To69Count);
            result.setBetween60To69Rate(Utils.format((float) between60To69Count * 100 / (float) result.getExamCount()));
            int between30To59Count = scoreDao.queryBetween30To59Count(exam.getId());
            result.setBetween30To59Count(between30To59Count);
            result.setBetween30To59Rate(Utils.format((float) between30To59Count * 100 / (float) result.getExamCount()));
            int between0To29Count = scoreDao.queryBetween0To29Count(exam.getId());
            result.setBetween0To29Count(between0To29Count);
            result.setBetween0To29Rate(Utils.format((float) between0To29Count * 100 / (float) result.getExamCount()));
        }
        return result;
    }

    @Override
    public void changeState(SubIndexPoint subIndexPoint) {
        SubIndexPoint queryResult = scoreDao.queryByIndexPointAndTestMethod(subIndexPoint);
        if (queryResult != null) {
            scoreDao.deleteSubIndexPointById(queryResult.getId());
        } else {
            scoreDao.addSubIndexPoint(subIndexPoint);
        }
    }

    @Override
    public List<SubIndexPoint> querySubIndexPointByIndexPointId(List<IndexPoint> indexPointList) {
        List<Integer> indexPointIdList = new ArrayList<>();
        for (IndexPoint indexPoint : indexPointList) {
            indexPointIdList.add(indexPoint.getId());
        }
        if (!CollectionUtils.isEmpty(indexPointIdList)) {
            return scoreDao.querySIPByIndexPointId(indexPointIdList);
        } else {
            return new ArrayList<>();
        }
    }

    @Override
    public void deleteByExamId(Integer id) {
        scoreDao.deleteByExamId(id);
    }
}
