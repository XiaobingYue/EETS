package com.yxb.multiManage.service;

import com.yxb.common.entity.Page;
import com.yxb.multiManage.entity.Institute;

import java.util.List;
import java.util.Map;

/**
 * Created by yxb on 2018/5/7
 */
public interface InstituteService {
    
    List<Institute> queryAllInstitute();

    Page<Institute> queryInstituteList(Map<String, Object> paramMap, Integer pageNo, Integer pageSize);

    void editInstitute(Institute institute);

    void addInstitute(Institute institute);

    void deleteInstitute(Integer id);
}
