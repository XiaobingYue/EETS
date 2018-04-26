package com.yxb.role.entity;

import org.hibernate.validator.constraints.NotBlank;

public class Role {
	private Integer id;
	@NotBlank(message = "角色名称不能为空")
	private String roleName;
	private String note;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

}
