package com.yxb.role.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.yxb.common.entity.Page;
import com.yxb.role.Bean.RoleBean;
import com.yxb.role.dao.RoleDao;
import com.yxb.role.entity.Role;
import com.yxb.user.dao.UserDao;
import com.yxb.user.entity.User;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yxb.role.service.RoleService;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

@Service
public class RoleServiceImpl implements RoleService {

    @Autowired
    private RoleDao dao;
    @Autowired
    private UserDao userDao;

    /**
     * 分页查询用户信息
     *
     * @param paramMap 查询参数
     * @param pageNo   页号
     * @param pageSize 每页数量
     * @return Page<Role>
     */
    @Override
    public Page<Role> queryRoleList(Map<String, Object> paramMap, Integer pageNo, Integer pageSize) {
        List<Role> roleList = dao.queryRoleList(paramMap);
        Page<Role> rolePage = new Page<>();
        if (!CollectionUtils.isEmpty(roleList)) {
            int totalSize = this.queryPageSize(paramMap);
            rolePage.setData(roleList);
            rolePage.setPageNo(pageNo);
            rolePage.setPageSize(pageSize);
            rolePage.setTotalNo(totalSize, pageSize);
            rolePage.setTotalSize(totalSize);
        }
        return rolePage;
    }

    @Override
    public int queryPageSize(Map<String, Object> paramMap) {
        return dao.queryPageSize(paramMap);
    }

    @Override
    public List<Role> queryAllRole() {
        return dao.queryAllRole();
    }

    /**
     * 根据id查询出一个角色
     *
     * @param id 角色id
     * @return RoleBean
     */
    @Override
    public RoleBean queryRoleById(Integer id) {
        Role role = dao.queryRoleById(id);
        if (role == null) return null;
        else {
            RoleBean roleBean = new RoleBean();
            BeanUtils.copyProperties(role, roleBean);
            return roleBean;
        }
    }

    /**
     * 修改角色信息
     *
     * @param roleBean 角色信息
     */
    @Override
    public void modifyRole(RoleBean roleBean) {
        dao.updateRoleById(roleBean);
    }

    /**
     * 添加角色
     *
     * @param roleBean 角色信息
     */
    @Override
    public void addRole(RoleBean roleBean) {
        dao.insertRole(roleBean);
    }

    /**
     * 单个删除角色
     * modify by yxb on 2016/06/19
     * 判断是否为系统初始化角色，初始化角色不可删除
     *
     * @param roleBean 角色信息
     */
    @Override
    public String deleteRole(RoleBean roleBean) {
        // 先判断该角色是否已经赋予某人
        List<Integer> userIds = dao.queryUserIdsByRoleId(roleBean.getId());
        if (CollectionUtils.isEmpty(userIds)) {
            // 为空说明该角色未赋予任何人，判断该角色是否为系统初始化角色
            Role role = dao.queryRoleById(roleBean.getId());
            if(role != null && "1".equals(role.getNote())) {
                //系统初始化角色不能删除
                return "系统初始化角色不能删除";
            }
            dao.deletePermissionByRoleId(roleBean.getId());
            dao.deleteRoleById(roleBean);
            return null;
        } else {
            // 查出所赋予角色的人员，返回人员姓名
            List<String> userNames = new ArrayList<>();
            for (Integer userId : userIds) {
                User user = userDao.queryById(userId);
                if (user != null) {
                    userNames.add(user.getName());
                }
            }
            return "该角色已经赋予以下用户："+userNames.toString();
        }
    }

    @Override
    @Transactional
    public void assignPermission(Map<String, Object> paramMap) {
        dao.deletePermissionByRoleId((Integer) paramMap.get("roleId"));
        dao.addRolePermission(paramMap);
    }


}
