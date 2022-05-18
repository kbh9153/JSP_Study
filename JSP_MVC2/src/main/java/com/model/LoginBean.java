package com.model;

public class LoginBean {	// 비즈니스 로직을 처리하는 DTO (웹에서 데이터를 DTO를 통해 DAO에 전송 (임시적인 전달자 역할)
	private String id;
	private String password;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	public boolean validate() {
		if (password.equals("admin")) {
			return true;
		} else {
			return false;
		}
	}
	
}
