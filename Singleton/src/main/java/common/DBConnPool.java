package common;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DBConnPool {
	
	public Connection conn;
	public Statement stmt;
	public PreparedStatement pstmt;
	public ResultSet rs;
	
	// 기본 생성자
	public DBConnPool() {
		try {
			// 톰캣에 설정한 커넥션 풀(DBCP) 정보 얻어오기
			Context initCtx = new InitialContext();
			Context ctx = (Context)initCtx.lookup("java:comp/env");
			DataSource source = (DataSource)ctx.lookup("dbcp_myoracle");
			
			// 커넥션 풀을 통해서 연결
			conn = source.getConnection();
			
			System.out.println("Connection Pool(DBCP) Synch Success");
			
		} catch (Exception e) {
			System.out.println("Connection Pool(DBCP) Synch Failed");
			e.printStackTrace();	// (자세한)오류 메세지 출력
		}
	};
	
	// 자원 연결 해제 (자원 반납) : close() 메소드 호출시 자원을 반납하도록 설정
    public void close() {
    	try {	// 자원을 커넥션 풀로 반납
    		if(rs != null) {
    			rs.close();
    		}
    		if(stmt != null) {
    			stmt.close();
    		}
    		if(pstmt != null) {
    			pstmt.close();
    		}
    		if(conn != null) {
    			conn.close();
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    }
}
