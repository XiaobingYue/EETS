package com.yxb.user.entity;

public class User {
	private Integer id;
	private String userAcct;
	private String username;
	private String password;
	private String email;

	public String getUserAcct(){
	    return userAcct;
    }

    public void setUserAcct(String userAcct){
	    this.userAcct = userAcct;
    }

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

}
