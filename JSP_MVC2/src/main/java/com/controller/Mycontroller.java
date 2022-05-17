package com.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model.LoginBean;

public class Mycontroller extends HttpServlet {		// Controller Setting (Mycontroller가 서블릿(Controller) -> 클라이언트의 요청을 처리)

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Client에서 Get 방식으로 요청할 경우 처리하는 블록
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Client에서 Post 방식으로 요청할 경우 처리하는 블록
		response.setContentType("text.html; charset = utf-8");
			// Client에 View 페이지로 전송할 컨텐츠 ContentType을 정의
		
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		
		LoginBean bean = new LoginBean();
		
		bean.setId(id);
		bean.setPassword(password);
		
		request.setAttribute("bean", bean);	// setAttribute(String "변수명 지정", 객체). 객체를 변수값으로 할당. View의 요청값을 jsp로 전달
		
		boolean status = bean.validate();	// password가 "admin"이면 status가 true
		
		if (status) {
			RequestDispatcher rd = request.getRequestDispatcher("mvc_success.jsp");		// status가 true이면 mvc_success.jsp 호출
			rd.forward(request, response);
		} else {
			RequestDispatcher rd = request.getRequestDispatcher("mvc_error.jsp");	// status가 false이면 mvc_error.jsp 호출
			rd.forward(request, response);
		}
	}

}
