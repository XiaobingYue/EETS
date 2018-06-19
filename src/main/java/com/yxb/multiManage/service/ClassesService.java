package com.yxb.multiManage.service;

import com.yxb.common.entity.Page;
import com.yxb.multiManage.entity.Classes;

import java.util.List;
import java.util.Map;

/**
 * Created by yxb on 2018/5/7
 */
public interface ClassesService {
    List<Classes> queryAllClasses();

    Page<Classes> queryClassesList(Map<String, Object> paramMap, Integer pageNo, Integer pageSize);

    void editClasses(Classes classes);

    void addClasses(Classes classes);

    void deleteClasses(Integer id);

    Classes queryById(Integer integer);
}
