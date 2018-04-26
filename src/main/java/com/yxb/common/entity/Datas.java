package com.yxb.common.entity;

import java.util.List;

import com.yxb.user.Bean.UserBean;
import com.yxb.user.entity.User;

/**
 * 数据封装类，用于封装数据
 *
 * Created By yxb on 2018/04/24
 */
public class Datas {
	
	private List<UserBean> users;
	private List<Integer> ids;

	public List<Integer> getIds() {
		return ids;
	}

	public void setIds(List<Integer> ids) {
		this.ids = ids;
	}

	public List<UserBean> getUsers() {
		return users;
	}

	public void setUsers(List<UserBean> users) {
		this.users = users;
	}

}
