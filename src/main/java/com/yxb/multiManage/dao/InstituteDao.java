package com.yxb.multiManage.dao;

import com.yxb.multiManage.entity.Institute;
import com.yxb.multiManage.entity.Profession;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by yxb on 2018/5/7
 */
@Repository
public interface InstituteDao {


    List<Institute> queryAllInstitute(Map<String, Object> paramMap);

    int queryCount(Map<String, Object> paramMap);

    void editInstitute(Institute institute);

    Institute queryById(Integer id);

    void addInstitute(Institute institute);
}
