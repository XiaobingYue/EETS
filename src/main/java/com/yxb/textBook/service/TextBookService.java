package com.yxb.textBook.service;

import com.yxb.common.entity.Page;
import com.yxb.teachTask.entity.Task;
import com.yxb.textBook.entity.TextBook;

import java.util.List;
import java.util.Map;

/**
 * Created by yxb on 2018/5/10
 */
public interface TextBookService {

    Page<TextBook> queryTextBookList(Map<String,Object> paramMap,Integer pageNo,Integer pageSize);

    void addTextBook(TextBook textBook);

    TextBook queryById(Integer id);

    void editTextBook(TextBook textBook);

    void deleteById(Integer id);

    List<TextBook> queryAllTextBookList();
}
