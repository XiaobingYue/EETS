package com.yxb.common.entity;

import java.util.List;

import com.yxb.user.entity.User;

/**
 * 数据包装类，用于封装数据
 * @author 18801
 *
 */
public class Datas {
	
	private List<User> users;
	private List<Integer> ids;

	public List<Integer> getIds() {
		return ids;
	}

	public void setIds(List<Integer> ids) {
		this.ids = ids;
	}

	public List<User> getUsers() {
		return users;
	}

	public void setUsers(List<User> users) {
		this.users = users;
	}

}
