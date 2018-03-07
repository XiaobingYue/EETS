package com.yxb.role.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.yxb.common.entity.Page;
import com.yxb.common.util.StringUtil;
import com.yxb.user.entity.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yxb.common.entity.AjaxResult;
import com.yxb.role.entity.Role;
import com.yxb.role.service.RoleService;

@Controller
@RequestMapping("/roleController")
public class RoleController {
	
	private final RoleService roleService;

	private  static  final Logger log = LoggerFactory.getLogger(RoleController.class);

    @Autowired
    public RoleController(RoleService roleService) {
        this.roleService = roleService;
    }

    @RequestMapping("/toRoleList")
	public String toRoleList(){
		return "manager/role/list";
	}
	
	@ResponseBody
	@RequestMapping("/queryRoleList")
	public Object queryRoleList(String queryText , Integer pageNo , Integer pageSize){
		AjaxResult<Role> result = new AjaxResult<>();
		try{
            Map<String,Object> paramMap = new HashMap<>();
            paramMap.put("start" , (pageNo - 1)*pageSize);
            paramMap.put("size" , pageSize);
            if(StringUtil.isNotEmpty(queryText))
                paramMap.put("queryText" , queryText);
            List<Role> roleList = roleService.queryRoleList(paramMap);
            int totalSize = roleService.queryPageSize(paramMap);
            int totalNo = 0;
            if(totalSize % pageSize ==  0)
                totalNo = totalSize/pageSize;
            else
                totalNo = totalSize/pageSize + 1;
            Page<Role> rolePage = new Page<>();
            rolePage.setDatas(roleList);
            rolePage.setPageno(pageNo);
            rolePage.setPagesize(pageSize);
            rolePage.setTotalno(totalNo);
            rolePage.setTotalsize(totalSize);
            result.setPage(rolePage);
            result.setSuccess(true);
		}catch(Exception e){
		    log.debug(e.getMessage());
			result.setSuccess(false);
		}
		return result;
	}
}
