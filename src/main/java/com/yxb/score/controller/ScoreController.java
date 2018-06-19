package com.yxb.score.controller;

import com.alibaba.fastjson.JSON;
import com.yxb.common.entity.AjaxResult;
import com.yxb.exam.entity.Exam;
import com.yxb.exam.entity.SubIndexPoint;
import com.yxb.exam.service.ExamService;
import com.yxb.multiManage.entity.Classes;
import com.yxb.multiManage.entity.Course;
import com.yxb.multiManage.service.ClassesService;
import com.yxb.multiManage.service.CourseService;
import com.yxb.multiManage.service.InstituteService;
import com.yxb.score.bean.Result;
import com.yxb.score.entity.Score;
import com.yxb.score.service.ScoreService;
import com.yxb.trainingPlan.entity.IndexPoint;
import com.yxb.trainingPlan.service.IndexPointService;
import com.yxb.user.entity.User;
import com.yxb.user.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by yxb on 2018/5/30
 */
@Controller
@RequestMapping("/scoreController")
public class ScoreController {

    private static final Logger log = LoggerFactory.getLogger(ScoreController.class);

    @Autowired
    private ScoreService scoreService;
    @Autowired
    private ExamService examService;
    @Autowired
    private CourseService courseService;
    @Autowired
    private UserService userService;
    @Autowired
    private ClassesService classesService;
    @Autowired
    private InstituteService instituteService;
    @Autowired
    private IndexPointService indexPointService;

    @RequestMapping("/toAddScore.do")
    public String toIndex(Integer id, Model model) {
        try {
            Exam exam = examService.queryById(id);
            List<IndexPoint> indexPointList = indexPointService.queryIndexPointByCourseId(exam.getCourseId());
            scoreService.addScore(id,indexPointList);
            String jsonIndexPoint = JSON.toJSONString(indexPointList);
            List<SubIndexPoint> subIndexPointList = scoreService.querySubIndexPointByIndexPointId(indexPointList);
            Result result = scoreService.getScoreResult(exam);
            Integer methodCount = result.getTestMethodList().size();
            model.addAttribute("result",result);
            model.addAttribute("exam",exam);
            model.addAttribute("indexPointList", indexPointList);
            model.addAttribute("subIndexPointList", subIndexPointList);
            model.addAttribute("jsonIndexPoint", jsonIndexPoint);
            model.addAttribute("methodCount", methodCount);
        } catch (Exception e) {
            log.error("前往录入页面出现异常",e);
        }
        return "manager/score/list";
    }

    @ResponseBody
    @RequestMapping("/queryScoreTable.do")
    public Object queryScoreTable(Integer id) {
        List<Map<String, Object>> scoreList = new ArrayList<>();
        try {
            scoreList = scoreService.addScore(id,new ArrayList<IndexPoint>());
        } catch (Exception e) {
            log.error("分数录入出现异常", e);
        }
        return scoreList;
    }

    /**
     * 修改单个题目分数
     *
     * @param score 分数
     * @return AjaxResult
     */
    @ResponseBody
    @RequestMapping("/editScore.do")
    public Object editScore(Score score) {
        AjaxResult result = new AjaxResult();
        try {
            scoreService.editScore(score);
            result.setSuccess(true);
        } catch (Exception e) {
            log.error("修改分数出现异常", e);
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/analysisScore.do")
    public Object analysisScore (Score score) {
        AjaxResult result = new AjaxResult();
        try {
            scoreService.analysisScore(score);
            result.setSuccess(true);
        } catch (Exception e) {
            log.error("分析成绩出现异常",e);
        }
        return result;
    }

    @RequestMapping("/toDetail.do")
    public String toDetail (Integer examId) {
        return "manager/score/detail";
    }

    @RequestMapping("/changeState.do")
    @ResponseBody
    public Object changeState (SubIndexPoint subIndexPoint) {
        AjaxResult result = new AjaxResult();
        try {
            scoreService.changeState(subIndexPoint);
            result.setSuccess(true);
        } catch (Exception e) {
            log.error("增加指标点与题目关系出现异常",e);
            result.setData(e.getMessage());
        }
        return result;
    }

    @RequestMapping("/toInputScore.do")
    public String toInputScore () {
        return "manager/score/inputScore";
    }
}
