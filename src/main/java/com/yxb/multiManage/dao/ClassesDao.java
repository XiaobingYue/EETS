package com.yxb.multiManage.dao;

import com.yxb.multiManage.entity.Classes;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by yxb on 2018/5/7
 */
@Repository
public interface ClassesDao {


    List<Classes> queryAllClasses(Map<String , Object> paramMap);

    int queryCount(Map<String, Object> paramMap);

    void editClasses(Classes classes);

    Classes queryById(Integer id);

    void addClasses(Classes classes);
}
