package com.yxb.multiManage.service.impl;

import com.yxb.common.constant.Const;
import com.yxb.common.entity.Page;
import com.yxb.multiManage.dao.InstituteDao;
import com.yxb.multiManage.entity.Institute;
import com.yxb.multiManage.service.InstituteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by yxb on 2018/5/8
 */
@Service
public class InstituteServiceImpl implements InstituteService {

    @Autowired
    private InstituteDao instituteDao;

    @Override
    public List<Institute> queryAllInstitute() {
        Map<String , Object> paramMap = new HashMap<>();
        paramMap.put("state" , Const.ENABLE_1);
        return instituteDao.queryAllInstitute(paramMap);
    }

    @Override
    public Page<Institute> queryInstituteList(Map<String, Object> paramMap, Integer pageNo, Integer pageSize) {
        paramMap.put("state" , Const.ENABLE_1);
        List<Institute> instituteList = instituteDao.queryAllInstitute(paramMap);
        Page<Institute> page = new Page<>();
        if(!CollectionUtils.isEmpty(instituteList)) {
            int count = instituteDao.queryCount(paramMap);
            page.setPageNo(pageNo);
            page.setTotalSize(count);
            page.setPageSize(pageSize);
            page.setTotalNo(count , pageSize);
            page.setData(instituteList);
        }
        return page;
    }

    @Override
    public void editInstitute(Institute institute) {
        institute.setTimestamp(System.currentTimeMillis());
        instituteDao.editInstitute(institute);
    }

    @Override
    public void addInstitute(Institute institute) {
        institute.setTimestamp(System.currentTimeMillis());
        institute.setState(Const.ENABLE_1);
        instituteDao.addInstitute(institute);
    }

    @Override
    public void deleteInstitute(Integer id) {
        Institute institute = instituteDao.queryById(id);
        if(institute != null) {
            institute.setState(Const.UNENABLE_0);
            institute.setTimestamp(System.currentTimeMillis());
            instituteDao.editInstitute(institute);
        }
    }

    @Override
    public Institute queryById(Integer id) {
        return instituteDao.queryById(id);
    }
}
