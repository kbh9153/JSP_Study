package model2.mvcboard;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import common.DBConnPool;

public class MVCBoardDAO extends DBConnPool {
	// 기본 생성자 호출시 부모 클래스를 호출
	public MVCBoardDAO() {
		super();	// DBConnPool 객체의 기본 생성자 호출, DBCP에서 conn 객체 활성화
	}
	
	// 검색 조건에 맞는 게시물 개수를 반환
	public int selectCount(Map<String, Object> map) {
		int totalCount = 0;
		String query = "select count(*) from mvcboard";		// 레코드의 총 개수
		
		if (map.get("searchWord") != null) {	// 검색 기능을 사용했을 시
			query += " where " + map.get("searchField") + " " + " like '%" + map.get("searchWord") + "%'";;
		}
		
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(query);
			rs.next();
			totalCount = rs.getInt(1);
		} catch (Exception e) {
			System.out.println("게시물 카운트 중 예외 발생");
			e.printStackTrace();
		}
		
		return totalCount;
	}
	// 검색 조건에 맞는 게시물 목록을 반환
		// DataBase에서 select한 결과값을 DTO에 담아서 return
	public List<MVCBoardDTO> selectListPage(Map<String, Object> map) {	// List에 MVCBoacrdDTO 데이터가 저장
		List<MVCBoardDTO> board = new Vector<MVCBoardDTO>();
		String query = "select * from("
					+ "select Tb.*, rownum rNUM from("
					+ "select * from mvcboard";
		
		if (map.get("searchWord") != null) {	// 검색기능을 사용했을 경우
			query += " where " + map.get("searchField")
					+ "like '%" + map.get("searchWord") + "%'";
		} else {
			query += " order by "
					+ " ) Tb "
					+ ") "
					+ "where rNUM between ? and ?";
		}
		
		try {	// pstmt 객체 생성 후 쿼리 실행
			pstmt = conn.prepareStatement(query);	// preparedStatement
			
			pstmt.setString(1, map.get("start").toString());
			pstmt.setString(2, map.get("end").toString());
			
			rs = pstmt.executeQuery();	// DataBase에서 select한 결과값을 rs에 저장
			
			// rs의 저장된 값을 DTO에 저장 -> DTO 객체를 List에 add
			while(rs.next()) {
				MVCBoardDTO dto = new MVCBoardDTO();
				
				dto.setIdx(rs.getString(1));
				dto.setName(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setPostdate(rs.getDate(5));
				dto.setOfile(rs.getString(6));
				dto.setSfile(rs.getString(7));
				dto.setDowncount(rs.getInt(8));
				dto.setPass(rs.getString(9));
				dto.setVisitcount(rs.getInt(10));
				
				board.add(dto);	// board : List. List에 rs(DB 데이터)의 하나의 레코드 값을 DTO에 저장하고 DTO를 List에 추가
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return board;	// board는 DTO 객체를 저장하고 있음
	};
	
	// 목록 검색 (Select) : 주어진 일련번호에 해당하는 값을 DTO에 담아 반환 (한페이지 read)
	
	// 데이터 삽입 (Insert)
	public int insertWrite(MVCBoardDTO dto) {
		int result = 0;
		
		try {
			String query = "insert into mvcboard ("
				+ "idx, name, title, content, ofile, sfile, pass) "
				+ "values("
				+ "seq_mvcboard_num.nextval, ?, ?, ?, ?, ?, ?)";
			
			pstmt = conn.prepareStatement(query);	// PreparedStatement 객체 생성
			
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getOfile());
			pstmt.setString(5, dto.getSfile());
			pstmt.setString(6, dto.getPass());
			
			result = pstmt.executeUpdate();	// 성공된 insert 횟수 반환
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;	// result : Insert 성공시 > 0, 실패시 0
	}
	
	// 데이터 수정 (Update)
	
	// 데이터 삭제 (Delete)
	
	// 데이터 검색 (Select 특정 조건으로 검색)
}
