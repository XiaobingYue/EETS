package com.yxb.score.dao;

import com.yxb.exam.entity.SubIndexPoint;
import com.yxb.score.bean.Result;
import com.yxb.score.entity.Score;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by yxb on 2018/5/29
 */
@Repository
public interface ScoreDao {

    void addScore(List<Score> list);

    List<Score> queryByExamId(Integer examId);

    void updateScore(Score score);

    void analysisScore(Score score);

    Result queryResult(Integer examId);

    Integer queryUnPassCount(Integer examId);

    Integer queryThanNinetyCount(Integer examId);

    Integer queryBetween80To89Count(Integer examId);

    Integer queryBetween70To79Count(Integer examId);

    Integer queryBetween60To69Count(Integer examId);

    Integer queryBetween30To59Count(Integer examId);

    Integer queryBetween0To29Count(Integer examId);

    SubIndexPoint queryByIndexPointAndTestMethod(SubIndexPoint subIndexPoint);

    void deleteSubIndexPointById(Integer id);

    void addSubIndexPoint(SubIndexPoint subIndexPoint);

    List<SubIndexPoint> querySIPByIndexPointId(List<Integer> list);

    List<SubIndexPoint> querySIPByTestMethodId(List<Integer> list);
}
