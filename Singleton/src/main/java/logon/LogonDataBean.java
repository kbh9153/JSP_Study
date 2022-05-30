package logon;

import java.sql.Timestamp;

public class LogonDataBean {	// DTO, VO, Bean (DTO, DAO) : 백엔드에서 처리하는 Java 페이지
	// 데이터를 Setter로 주입 받아서 Getter로 출력해주는 전달자 역할
	private String id;
	private String passwd;
	private String name;
	private Timestamp reg_date;		// 가입 날짜의 시간을 등록
	private String tel;
	private String address;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
}
