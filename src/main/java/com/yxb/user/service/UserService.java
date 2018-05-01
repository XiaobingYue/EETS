package com.yxb.user.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.yxb.common.entity.Page;
import com.yxb.permission.entity.Permission;
import com.yxb.user.Bean.ImportUserBean;
import com.yxb.user.Bean.UserBean;
import com.yxb.user.entity.User;
import org.springframework.web.multipart.MultipartFile;

public interface UserService {

    UserBean doUserLogin(UserBean user);

    void registerUser(UserBean user);

    List<Permission> getPermissionsByUserId(Integer id);

    Page<User> queryUserList(Map<String, Object> paramMap, Integer pageNo, Integer pageSize);

    int deleteUser(UserBean user);

    UserBean findUserByUserAcct(String userAcct);

    int queryPageSize(Map<String, Object> paramMap);

    void modifyUser(User user);

    UserBean queryById(Integer id);

    List<Integer> queryRoleIdByUserId(Integer id);

    void assign(Map<String, Object> paramMap);

    void unAssign(Map<String, Object> paramMap);

    /**
     * 根据人员id获取人员权限并组装成父子结构
     *
     * @param id 人员id
     * @return 权限集合
     */
    List<Permission> queryUserPermission(Integer id);

    /**
     * @param file            待解析文件
     * @param wellList        保存成功列表
     * @param exitList        已存在列表
     * @param infoNotExitList 必填项为空列表
     * @param errorList       错误信息列表
     */
    void importUser(MultipartFile file, Set<ImportUserBean> wellList, List<ImportUserBean> exitList, List<ImportUserBean> infoNotExitList, List<ImportUserBean> errorList) throws Exception;
}
