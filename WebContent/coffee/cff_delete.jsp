<%@page import="com.info.model.cff.CffDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	int no = Integer.parseInt(request.getParameter("no"));

	// db와 연동
	CffDAO dao = CffDAO.getInstance();
	int res = dao.deleteCff(no);
	out.println(res);

%>