package com.yxb.score.service;

import com.yxb.exam.entity.Exam;
import com.yxb.exam.entity.SubIndexPoint;
import com.yxb.score.bean.Result;
import com.yxb.score.entity.Score;
import com.yxb.trainingPlan.entity.IndexPoint;

import java.util.List;
import java.util.Map;

/**
 * Created by yxb on 2018/5/30
 */
public interface ScoreService {

    List<Map<String, Object>> addScore(Integer id, List<IndexPoint> indexPointList);

    void editScore(Score score);

    void analysisScore(Score score);

    Result getScoreResult(Exam exam);

    void changeState(SubIndexPoint subIndexPoint);

    List<SubIndexPoint> querySubIndexPointByIndexPointId(List<IndexPoint> indexPointList);

    void deleteByExamId(Integer id);
}
