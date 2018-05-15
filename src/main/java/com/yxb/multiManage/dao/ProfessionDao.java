package com.yxb.multiManage.dao;

import com.yxb.multiManage.entity.Classes;
import com.yxb.multiManage.entity.Profession;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by yxb on 2018/5/7
 */
@Repository
public interface ProfessionDao {


    List<Profession> queryAllProfession(Map<String, Object> paramMap);

    int queryCount(Map<String, Object> paramMap);

    void editProfession(Profession profession);

    Profession queryById(Integer id);

    void addProfession(Profession profession);
}
