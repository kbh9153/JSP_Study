package logon;

import common.DBConnPool;
import work.crypt.BCrypt;
import work.crypt.SHA256;

public class LogonDBBean extends DBConnPool {
	// DAO : 실제 DB를 Select, Insert, Delete, Update

	// LogonDBBean : 전역 객체 생성 -> 한개의 객체만 생성해서 공유 (싱글톤 패턴)
		// 외부에 다른 클래스에서 new 키를 사용하면 여러개의 객체를 생성 가능
		// 특정 클래스는 여러개의 객체를 생성하지 못하도록 하고 단 하나의 객체만 생성해서 사용해야될 경우가 있음
			// ex. Class 회사
	
		// 싱글톤 패턴 : 외부에서 여러개의 객체를 생성할 수 없도록 설정
			// 1. private static으로 객체 생성
			// 2. 생성된 객체를 메소드로 객체를 전달
	private static LogonDBBean instance = new LogonDBBean();
	
	// LogonDBBean 객체를 리턴하는 메소드
		// 메소드를 사용해서만 객체를 생성할 수 있음
	public static LogonDBBean getInstance() {
		return instance;
	};
	
	// 기본생성자 : private (외부에서 객체 생성이 불가능)
		// 부모 클래스의 기본 생성자 호출
	private LogonDBBean() {
		super();
	};
	
	// 회원 가입 처리 (registerPro.jsp)에서 넘어오는 값을 DB에 저장 (Insert)
	public void insertMember(LogonDataBean member) {
		SHA256 sha = SHA256.getInsatnce();
		
		try {
			// Form에서 전달받은 Password를 DB에 저장할 때 암호화하여 저장
			
			// orgPass : Form 넘겨받은 password
			String orgPass = member.getPasswd();
			String shaPass = sha.Sha256Encrypt(orgPass.getBytes());  // hash 알고리즘으로 암호화
			String bcPass = BCrypt.hashpw(shaPass, BCrypt.gensalt());	// bcPass : 암호화된 패스워드
			
			System.out.println("암호화되지 않은 패스워드 : " + orgPass);
			System.out.println("암호화된 패스워드 : " + bcPass);
			
			String sql = "insert into member01 values(?, ?, ?, ?, ?, ?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, bcPass);		// 암호화된 패스워드 저장
			pstmt.setString(2, member.getPasswd());		// 암호화되지 않은 패스워드 저장
			pstmt.setString(3, member.getName());			
			pstmt.setTimestamp(4, member.getReg_date());			
			pstmt.setString(5, member.getAddress());
			pstmt.setString(6, member.getTel());
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("회원정보 DB 입력 예외 발생");
		} finally {
			instance.close();
		}
	};
	
	// 로그인 처리 (loginPro.jsp) : Form에서 넘겨받은 ID와 Pass를 DB에서 확인
		// 사용자 인증처리, DB의 정보를 수정할 때, DB의 정보를 삭제할 때
		// 사용자 인증(MemberCheck.jsp)에서 사용하는 메소드
	public int userCheck(String id, String passwd) {
		// 암호화된 Password를 복호화
		int x = -1;	// x = -1 : id가 존재하지 않음, x = 1 : id, passwd 일치. 인증 성공
		
		SHA256 sha = SHA256.getInsatnce();
		
		try {
			String orgPass = passwd;
			String shaPass = sha.getSha256(orgPass.getBytes());
			
			String sql = "select passwd from member01 where id = ?";
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {	// 아이디가 존재하면 rs.next() = true
				String dbpasswd = rs.getString("passwd");	// DB에서 가져온 passwd
				
				if (BCrypt.checkpw(shaPass, dbpasswd)) {	// DB의 패스워드는 암호화된 상태
					x = 1;	// form에서 넘겨온 패스워드와 DB에서 가져온 패스워드가 일치할 때 x = 1 (Form의 password = DB의 password)
				} else {
					x = -1;	// x = -1 (Form의 password != DB의 password)
				}
			}
			
			pstmt = conn.prepareStatement(sql);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("ID와 Password 인증을 실패하였습니다.");
		} finally {
			instance.close();	// 객체(rs, stmt, pstmt, conn) 사용 종료
		}
				
		return x;
	}
	
	// ID 중복 체크 (confirmId.jsp) : 아이디 중복을 확인
	public int confirmId(String id) {
		int x = -1;	// x = -1 : DB에 일치하는 기존 id가 없음(id 사용 가능), x = 1 : DB에 일치하는 기존 id가 있음(id 사용 불가능)
		
		try {
			String sql = "select id from member01 where id = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {	// ID가 DB에 존재하는 경우
				x = 1;
			} else {
				x = -1;
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("ID 중복체크 중 예외 발생");
		} finally {
			instance.close();
		}
		
		return x;
	}
	
	// 회원정보 수정 (modifyForm.jsp) : DB에서 회원정보의 값을 가져오는 메소드
	public LogonDataBean getMember(String id, String passwd) {
		LogonDataBean member = null;
		SHA256 sha = SHA256.getInsatnce();
		
		try {
			String orgPass = passwd;
			String shaPass = sha.getSha256(orgPass.getBytes());
			
			String sql = "select * from member01 where = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {	// 해당 아이디가 DB에 존재
				String dbpasswd = rs.getString("passwd");	// DB의 패스워드를 변수값으로 할당
				
				if (BCrypt.checkpw(shaPass, dbpasswd)) {
					// DB의 passwd와 Form에서 넘겨온 Pass가 같을 때 처리할 부분
						// DB에서 select 레코드를 DTO(LogonDataBean)
					member = new LogonDataBean();	// memebr 객체 생성(객체 생성 후 DB의 rs에 저장된 값을 setter 주입 후 리턴)
					member.setId(rs.getString("id"));
					member.setName(rs.getString("name"));
					member.setReg_date(rs.getTimestamp("reg_date"));
					member.setAddress(rs.getString("address"));
					member.setTel(rs.getString("tel"));
				} else {
					// DB의 passwd와 Form에서 넘겨온 Pass가 다를 때 처리할 부분
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("회원 정보 읽어오는 중 예외 발생");
		} finally {
			instance.close();
		}
		
		return member;	// member (LogonDataBean : DTO에 Setter 주입 후 객체를 return)
	}
	
	// 수정 페이지에서 수정한 내용을 DB에 저장하는 메소드
	
	// 회원정보 수정 처리 (modifyPro.jsp)에서 회원정보 수정을 처리하는 메소드
	public int updateMember(LogonDataBean member) {
		int x = -1;	// x = 1 : update 실패, x = 1 : update 성공
		
		// ID와 Passwd를 확인 후 업데이트 진행
		SHA256 sha = SHA256.getInsatnce();	// 객체 활성화
		
		try {
			String orgPass = member.getPasswd();
			String shaPass = sha.getSha256(orgPass.getBytes());
			
			String sql = "select passwd from member01 where id = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			rs = pstmt.executeQuery();
			
			if (rs.next()) {	// 해당 아이디가 DB에 존재할 경우
				String dbpasswd = rs.getString("passwd");
				if (BCrypt.checkpw(shaPass, dbpasswd)) {	// 두 패스워가 일치할 때
					// DTO (member)에서 들어온 값을 DB에 Update
					sql = "update member01 set name = ?, address = ?, tel = ? ";
					sql += "where id = ?";
				    
				    pstmt = conn.prepareStatement(sql);
				    pstmt.setString(1, member.getName());
				    pstmt.setString(2, member.getAddress());
				    pstmt.setString(3, member.getTel());
				    
				    pstmt.executeUpdate();
				    x = 1;	// update 성공시 x, 변수에 1을 할당
				}
			} else {	// 해당 아이디가 DB에 존재하지 않을 경우
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("회원정보 수정시 예외 발생");
		} finally {
			instance.close();
		}
		return x;
	}
	
	// 회원탈퇴 처리 (deletePro.jsp)에서 회원정보 삭제 메소드
	public int deleteMember(String id, String passwd) {
		int x = -1;	 // x = -1 : 회원탈퇴 실패
					 // x = 1 : 회원탈퇴 성공
		
		SHA256 sha = SHA256.getInsatnce();	// 객체를 호출해서 변수에 할당
		
		try {
			String orgPass = passwd;
			String shaPass = sha.getSha256(orgPass.getBytes());
			
			String sql = "select passwd from member01 where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {	// id가 DB에 존재하는 경우
				String dbpasswd = rs.getString("passwd");
				
				if (BCrypt.checkpw(shaPass, dbpasswd)) {	// Form에서 전달받은 password와 DB의 password가 일치하는 경우
					sql = "delete member01 where id = ?";
					
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, id);
					pstmt.executeUpdate();
					
					x = 1;	// delete 성공시
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("회원탈퇴 예외발생");
		} finally {
			instance.close();
		}
		
		return x;	// x = 1 : delete 성공, 실패시 기본값 -1 반환
	}
}
