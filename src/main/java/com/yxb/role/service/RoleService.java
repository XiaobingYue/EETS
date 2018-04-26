package com.yxb.role.service;

import java.util.List;
import java.util.Map;

import com.yxb.common.entity.Page;
import com.yxb.role.Bean.RoleBean;
import com.yxb.role.entity.Role;

public interface RoleService {

    /**
     * 分页查询用户信息
     *
     * @param paramMap 查询参数
     * @param pageNo   页号
     * @param pageSize 每页数量
     * @return Page<Role>
     */
    Page<Role> queryRoleList(Map<String, Object> paramMap, Integer pageNo, Integer pageSize);

    int queryPageSize(Map<String, Object> paramMap);

    List<Role> queryAllRole();

    /**
     * 根据id查询出一个角色
     *
     * @param id 角色id
     * @return RoleBean
     */
    RoleBean queryRoleById(Integer id);

    /**
     * 修改角色信息
     *
     * @param roleBean 角色信息
     */
    void modifyRole(RoleBean roleBean);

    /**
     * 添加角色
     *
     * @param roleBean 角色信息
     */
    void addRole(RoleBean roleBean);

    /**
     * 单个删除角色,如果该角色已经赋予某用户，返回用户名称
     *
     * @param roleBean 角色信息
     */
    List<String> deleteRole(RoleBean roleBean);

    void assignPermission(Map<String, Object> paramMap);
}
