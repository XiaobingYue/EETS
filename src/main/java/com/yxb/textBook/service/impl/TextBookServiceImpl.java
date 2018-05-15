package com.yxb.textBook.service.impl;

import com.yxb.common.constant.Const;
import com.yxb.common.entity.Page;
import com.yxb.teachTask.entity.Task;
import com.yxb.teachTask.service.TeachTaskService;
import com.yxb.textBook.dao.TextBookDao;
import com.yxb.textBook.entity.TextBook;
import com.yxb.textBook.service.TextBookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by yxb on 2018/5/10
 */
@Service
public class TextBookServiceImpl implements TextBookService{

    @Autowired
    private TextBookDao textBookDao;
    @Autowired
    private TeachTaskService teachTaskService;

    @Override
    public Page<TextBook> queryTextBookList(Map<String, Object> paramMap,Integer pageNo,Integer pageSize) {
        paramMap.put("state", Const.ENABLE_1);
        List<TextBook> textBookList = textBookDao.queryTextBookList(paramMap);
        Page<TextBook> page = new Page<>();
        if (!CollectionUtils.isEmpty(textBookList)) {
            Integer totalSize = textBookDao.queryCount(paramMap);
            for (TextBook textBook : textBookList) {
                Task task = teachTaskService.queryById(textBook.getTaskId());
                textBook.setClassesName(task.getClassesName());
                textBook.setCourseName(task.getCourseName());
                textBook.setProName(task.getProName());
                textBook.setTaskName(task.getName());
            }
            page.setData(textBookList);
            page.setPageNo(pageNo);
            page.setPageSize(pageSize);
            page.setTotalNo(totalSize, pageSize);
            page.setTotalSize(totalSize);
        }
        return page;
    }

    @Override
    public void addTextBook(TextBook textBook) {
        textBook.setState(Const.ENABLE_1);
        textBook.setTimestamp(System.currentTimeMillis());
        textBookDao.addTextBook(textBook);
    }

    @Override
    public TextBook queryById(Integer id) {
        TextBook textBook = new TextBook();
        textBook.setId(id);
        textBook.setState(Const.ENABLE_1);
        return textBookDao.queryById(textBook);
    }

    @Override
    public void editTextBook(TextBook textBook) {
        textBook.setState(Const.ENABLE_1);
        textBook.setTimestamp(System.currentTimeMillis());
        textBookDao.updateTextBook(textBook);
    }

    @Override
    public void deleteById(Integer id) {
        textBookDao.deleteById(id);
    }

    @Override
    public List<TextBook> queryAllTextBookList() {
        Map<String,Object> paramMap = new HashMap<>();
        paramMap.put("state", Const.ENABLE_1);
        List<TextBook> textBookList = textBookDao.queryTextBookList(paramMap);
        for (TextBook textBook : textBookList) {
            Task task = teachTaskService.queryById(textBook.getTaskId());
            textBook.setClassesName(task.getClassesName());
            textBook.setCourseName(task.getCourseName());
            textBook.setProName(task.getProName());
            textBook.setTaskName(task.getName());
        }
        return textBookList;
    }
}
