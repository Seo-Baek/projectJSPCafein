<%@page import="java.io.PrintWriter"%>
<%@page import="com.info.model.user.ReplyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int rep_num = Integer.parseInt(request.getParameter("comNo"));
	String cont = request.getParameter("cont");
	System.out.println("진입성공");
	System.out.println("댓글번호: "+rep_num+" 글내용: "+cont);
	ReplyDAO dao = ReplyDAO.getInstance();
	int result = dao.updateReply(rep_num,cont);
	out.println(result);
%>