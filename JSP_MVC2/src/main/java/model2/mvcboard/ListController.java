package model2.mvcboard;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import utils.BoardPage;

public class ListController extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// GET 방식 요청이 있을 시 서버에서 처리
		req.setCharacterEncoding("text.html; charset=utf-8");
		
		// 1. DAO 객체 생성 (Model : 비즈니스 로직 처리)
		MVCBoardDAO dao = new MVCBoardDAO();
		
		// 2. View에 전달할 매개변수 저장용 맵 생성 (Key, Value)
		Map<String, Object> map = new HashMap<String, Object>();
		
		String searchField = req.getParameter("searchField");
		String searchWord = req.getParameter("searchWord");
		
		if (searchWord != null) {	// searchWord(검색어)가 존재할 경우 map에 값을 저장
			map.put("searchField", searchField);
			map.put("searchWord", searchWord);
		}
		
		// 게시물 개수 확인하기 (DAO의 selectCount(map))
		int totalCount = dao.selectCount(map);
		// System.out.println("전체 레코드 수 : " + totalCount);
		// System.out.println("List.do 요청시 Controller 페이지 정상 응답...");
		
		// 페이징 처리 부분 start
		
			// web.xml에 셋팅된 변수값 불러오기(param-name)
		ServletContext application = getServletContext();
		
		int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
		int blockPage = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));
		
		// System.out.println(pageSize);
		// System.out.println(blockPage);
		
		// 현재 페이지 확인
		int pageNum = 1;
		String pageTemp = req.getParameter("pageNum");
		if (pageTemp != null && !pageTemp.equals("")) {
			pageNum = Integer.parseInt(pageTemp);	// 값이 비어있지 않을 때 넘어오는 페이지 변수를 정수로 변환하여 pageNum에 할당
		}
		
		// 목록에 출력할 게시물 범위계산
		int start = (pageNum - 1) * pageSize + 1;	// 첫 게시물 번호
		int end = pageNum * pageSize;	// 마지막 게시물 번호
		
		// view 페이지에 값을 전달
		map.put("start", start);
		map.put("end", end);
		
		// 페이징 처리 부분 end
		
		// 게시물 목록 받아오기 (DAO 객체에 작업을 전달)
			// boardLists는 DB의 레코드를 담은 DTO 객체가 포함되어 있음
		List<MVCBoardDTO> boardLists = dao.selectListPage(map);
		dao.close();
		
		// view 페이지에 전달할 매개변수들을 추가
		String pagingImg = BoardPage.pagingStr(totalCount, pageSize, blockPage, pageNum, "../mvcboard/list.do");
		map.put("pagingImg", pagingImg);
		map.put("totalCount", pagingImg);
		map.put("pageSize", pageSize);
		map.put("pageNum", pageNum);
		
		// view 페이지로 데이터 전달, request 영역에 전달할 데이터를 저장 후 List.jsp (View 페이지)로 포워드
		req.setAttribute("boardLists", boardLists);
		req.setAttribute("map", map);
		req.getRequestDispatcher("/mvcboard/List.jsp").forward(req, res);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// POST 방식 요청이 있을 시 서버에서 처리
	}
	
}
