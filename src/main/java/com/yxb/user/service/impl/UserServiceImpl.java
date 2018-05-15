package com.yxb.user.service.impl;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

import com.yxb.common.constant.Const;
import com.yxb.common.entity.Page;
import com.yxb.common.util.ExcelUtil;
import com.yxb.common.util.MD5Util;
import com.yxb.common.util.Utils;
import com.yxb.user.Bean.ImportUserBean;
import com.yxb.user.Bean.JsonDate;
import com.yxb.user.Bean.UserBean;
import com.yxb.user.entity.LoginRecord;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yxb.permission.entity.Permission;
import com.yxb.user.dao.UserDao;
import com.yxb.user.entity.User;
import com.yxb.user.service.UserService;
import org.springframework.util.CollectionUtils;
import org.springframework.web.multipart.MultipartFile;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDao dao;

    public UserBean doUserLogin(UserBean userBean) {
        User user = dao.loginUser(userBean);
        if (user == null) return null;
        else BeanUtils.copyProperties(user, userBean);
        return userBean;
    }

    public void registerUser(UserBean user) {
        user.setTimestamp(System.currentTimeMillis());
        user.setIfEnable(Const.ENABLE_1);
        dao.registerUser(user);
        User queryUser = dao.findUserByUserAcct(user);
        if(!CollectionUtils.isEmpty(user.getRoleIds())) {
            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("userId", queryUser.getId());
            paramMap.put("roleIds", user.getRoleIds());
            this.assign(paramMap);
        }
    }

    public List<Permission> getPermissionsByUserId(Map<String , Object> paramMap) {
        return dao.getPermissionsByUserId(paramMap);
    }

    @Override
    public Page<User> queryUserList(Map<String, Object> paramMap, Integer pageNo, Integer pageSize) {
        List<User> userList = dao.queryUserList(paramMap);
        Page<User> userPage = new Page<>();
        if (!CollectionUtils.isEmpty(userList)) {
            int totalSize = this.queryPageSize(paramMap);
            userPage.setData(userList);
            userPage.setPageNo(pageNo);
            userPage.setPageSize(pageSize);
            userPage.setTotalNo(totalSize, pageSize);
            userPage.setTotalSize(totalSize);
        }
        return userPage;
    }

    /**
     * 逻辑删除
     *
     * @param user 用户信息
     * @return int
     */
    @Override
    public int deleteUser(UserBean user) {
        user.setTimestamp(System.currentTimeMillis());
        user.setIfEnable(Const.UNENABLE_0);
        dao.deleteRoleByUserId(user);
        return dao.deleteUser(user);
    }

    @Override
    public UserBean findUserByUserAcct(String userAcct) {
        User user = new User();
        user.setUserAcct(userAcct);
        user.setIfEnable(Const.ENABLE_1);
        user = dao.findUserByUserAcct(user);
        if (user == null) return null;
        UserBean userBean = new UserBean();
        BeanUtils.copyProperties(user, userBean);
        return userBean;
    }

    @Override
    public int queryPageSize(Map<String, Object> paramMap) {
        return dao.queryPageSize(paramMap);
    }

    @Override
    public void modifyUser(UserBean user) {
        user.setTimestamp(System.currentTimeMillis());
        if( !CollectionUtils.isEmpty(user.getRoleIds()) ) {
            dao.unAssignByUserId(user.getId());
            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("userId", user.getId());
            paramMap.put("roleIds", user.getRoleIds());
            this.assign(paramMap);
        }
        dao.modifyUser(user);
    }

    @Override
    public UserBean queryById(Integer id) {
        User user = dao.queryById(id);
        if (user == null) return null;
        else {
            UserBean userBean = new UserBean();
            BeanUtils.copyProperties(user, userBean);
            return userBean;
        }
    }

    @Override
    public List<Integer> queryRoleIdByUserId(Integer id) {
        return dao.queryRoleIdByUserId(id);
    }

    @Override
    public void assign(Map<String, Object> paramMap) {
        dao.assign(paramMap);
    }

    @Override
    public void unAssign(Map<String, Object> paramMap) {
        dao.unAssign(paramMap);
    }

    /**
     * 查询人员权限并组装成父子结构
     *
     * @return 权限集合
     */
    @Override
    public List<Permission> queryUserPermission(Integer id) {
        Map<String,Object> paramMap = new HashMap<>();
        paramMap.put("id",id);
        paramMap.put("type","1");
        List<Permission> list = this.getPermissionsByUserId(paramMap);
        List<Permission> root = new ArrayList<>();
        Map<Integer, Permission> permissionMap = new HashMap<>();
        for (Permission permission : list) {
            permissionMap.put(permission.getId(), permission);
        }
        for (Permission permission : list) {
            if (permission.getParentId() == 0) {
                root.add(permission);
            } else {
                Permission parent = permissionMap.get(permission.getParentId());
                parent.getChildren().add(permission);
            }
        }
        return root;
    }

    /**
     * @param file            待解析文件
     * @param wellList        保存成功列表
     * @param exitList        已存在列表
     * @param infoNotExitList 必填项为空列表
     * @param errorList       错误信息列表
     */
    @Override
    public void importUser(MultipartFile file, Set<ImportUserBean> wellList, List<ImportUserBean> exitList, List<ImportUserBean> infoNotExitList, List<ImportUserBean> errorList) throws Exception {
        List<ImportUserBean> allList = new ArrayList<>();
        this.parseExcel(file, allList);
        for (ImportUserBean userBean : allList) {
            User user = new User();
            BeanUtils.copyProperties(userBean,user);
            dao.registerUser(user);
        }
    }

    @Override
    public List<User> queryTeacherListByRoleId() {
        return dao.queryTeacherListByRoleId(Const.TEACHER_ROLE_ID);
    }

    @Override
    public List<Permission> queryMyPermission(Integer id) {
        Map<String,Object> paramMap = new HashMap<>();
        paramMap.put("id",id);
        return dao.getPermissionsByUserId(paramMap);
    }

    @Override
    public void changePassword(UserBean userBean, String newPwd) {
        userBean.setPassword(MD5Util.digest(newPwd));
        userBean.setTimestamp(System.currentTimeMillis());
        dao.changePassword(userBean);
    }

    @Override
    public Map<String,Object> queryRecentLoginRecord() {
        List<String> dateList = Utils.getRecentDate("yyyy-MM-dd");
        Map<String,Object> paramMap = new HashMap<>();
        paramMap.put("dateList",dateList);
        Map<String,Object> jsonDatas = new HashMap<>();
        List<LoginRecord> loginRecordList = dao.queryRecentLoginRecord(paramMap);
        List<String> xContent = new ArrayList<>();
        List<Long> date = new ArrayList<>();
        JsonDate jsonDate = new JsonDate();
        for (LoginRecord record : loginRecordList) {
            xContent.add(record.getDate());
            date.add(record.getCount());
        }
        jsonDate.setData(date);
        jsonDatas.put("xContent",xContent);
        jsonDatas.put("data",jsonDate);
        return jsonDatas;
    }

    @Override
    public void addLoginRecord() {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(new Date());
        Date date = calendar.getTime();
        String str = new SimpleDateFormat("yyyy-MM-dd").format(date);
        LoginRecord record = dao.queryLoginRecordByDate(str);
        if(record == null) {
            record = new LoginRecord();
            record.setCount(1L);
            record.setDate(str);
            dao.addLoginRecord(record);
        } else {
            record.setCount(record.getCount()+1L);
            dao.updateLoginRecord(record);
        }
    }

    private void parseExcel(MultipartFile file, List<ImportUserBean> allList) throws Exception {
        String columnHeader[] = {Const.USER_COLUMN_HEADER_ACCOUNT, Const.USER_COLUMN_HEADER_NAME, Const.USER_COLUMN_HEADER_EMAIL, Const.USER_COLUMN_HEADER_SEX, Const.USER_COLUMN_HEADER_PHONE};
        Sheet sheet = ExcelUtil.parseExcel(file, 0);
        if (sheet != null) {
            int colLens = sheet.getRow(0).getPhysicalNumberOfCells();//获取到第0行的真实列数
            if (colLens != columnHeader.length) {// 列数有误，退出解析
                throw new Exception("列数不对");
            }
            //判断第一列列名是否符合
            for (int i = 0; i < colLens; i++) {
                String columnName = sheet.getRow(0).getCell(i).getStringCellValue();
                if (!columnHeader[i].equals(columnName)) {//列名不符，跳出解析
                    throw new Exception("列名不对");
                }
            }
            for(int i=1;i<sheet.getPhysicalNumberOfRows();i++){
                ImportUserBean excel = new ImportUserBean();
                excel.setPassword(MD5Util.digest("123456"));
                excel.setSort("999");
                excel.setIfEnable("1");
                excel.setTimestamp(System.currentTimeMillis());
                Row row = sheet.getRow(i);
                if (row.getCell(0) != null) {
                    excel.setUserAcct(ExcelUtil.lrTrim(row.getCell(0).getStringCellValue()));// 警号
                }
                if (row.getCell(1) != null) {
                    excel.setName(ExcelUtil.lrTrim(row.getCell(1).getStringCellValue()));// 姓名
                }
                if (row.getCell(2) != null) {
                    excel.setEmail(ExcelUtil.lrTrim(row.getCell(2).getStringCellValue()));// email
                }
                if (row.getCell(3) != null) {
                    excel.setSex(ExcelUtil.lrTrim(row.getCell(3).getStringCellValue()).equals("男")?Const.USER_SEX_MAN_1:Const.USER_SEX_WOMAN_0);// 性别
                }
                if (row.getCell(4) != null) {
                    excel.setPhone(ExcelUtil.lrTrim(row.getCell(4).getStringCellValue()));// 手机
                }
                allList.add(excel);
            }
        }
    }

}

