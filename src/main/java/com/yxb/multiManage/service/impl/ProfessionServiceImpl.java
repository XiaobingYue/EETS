package com.yxb.multiManage.service.impl;

import com.yxb.common.constant.Const;
import com.yxb.common.entity.Page;
import com.yxb.multiManage.dao.ProfessionDao;
import com.yxb.multiManage.entity.Profession;
import com.yxb.multiManage.service.ProfessionService;
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
public class ProfessionServiceImpl implements ProfessionService {

    @Autowired
    private ProfessionDao professionDao;

    @Override
    public List<Profession> queryAllProfession() {
        Map<String , Object> paramMap = new HashMap<>();
        paramMap.put("state" , Const.ENABLE_1);
        return professionDao.queryAllProfession(paramMap);
    }

    @Override
    public Page<Profession> queryProfessionList(Map<String, Object> paramMap, Integer pageNo, Integer pageSize) {
        paramMap.put("state" , Const.ENABLE_1);
        List<Profession> professionList = professionDao.queryAllProfession(paramMap);
        Page<Profession> page = new Page<>();
        if(!CollectionUtils.isEmpty(professionList)) {
            int count = professionDao.queryCount(paramMap);
            page.setPageNo(pageNo);
            page.setTotalSize(count);
            page.setPageSize(pageSize);
            page.setTotalNo(count , pageSize);
            page.setData(professionList);
        }
        return page;
    }

    @Override
    public void editProfession(Profession profession) {
        profession.setTimestamp(System.currentTimeMillis());
        professionDao.editProfession(profession);
    }

    @Override
    public void addProfession(Profession profession) {
        profession.setTimestamp(System.currentTimeMillis());
        profession.setState(Const.ENABLE_1);
        professionDao.addProfession(profession);
    }

    @Override
    public void deleteProfession(Integer id) {
        Profession profession = professionDao.queryById(id);
        if(profession != null) {
            profession.setState(Const.UNENABLE_0);
            profession.setTimestamp(System.currentTimeMillis());
            professionDao.editProfession(profession);
        }
    }

    @Override
    public Profession queryById(Integer id) {
        return professionDao.queryById(id);
    }
}
