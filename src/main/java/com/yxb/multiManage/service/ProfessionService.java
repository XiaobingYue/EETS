package com.yxb.multiManage.service;

import com.yxb.common.entity.Page;
import com.yxb.multiManage.entity.Profession;

import java.util.List;
import java.util.Map;

/**
 * Created by yxb on 2018/5/7
 */
public interface ProfessionService {
    
    List<Profession> queryAllProfession();

    Page<Profession> queryProfessionList(Map<String, Object> paramMap, Integer pageNo, Integer pageSize);

    void editProfession(Profession Profession);

    void addProfession(Profession Profession);

    void deleteProfession(Integer id);

    Profession queryById(Integer professionId);
}
