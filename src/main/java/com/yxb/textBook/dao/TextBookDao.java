package com.yxb.textBook.dao;

import com.yxb.textBook.entity.TextBook;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by yxb on 2018/5/10
 */
@Repository
public interface TextBookDao {

    List<TextBook> queryTextBookList(Map<String,Object> paramMap);

    Integer queryCount(Map<String, Object> paramMap);

    void addTextBook(TextBook textBook);

    TextBook queryById(TextBook textBook);

    void updateTextBook(TextBook textBook);

    void deleteById(Integer id);
}
