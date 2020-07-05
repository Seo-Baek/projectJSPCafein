<%@page import="com.info.model.user.ReplyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int rep_num = Integer.parseInt(request.getParameter("comNo"));
	ReplyDAO dao = ReplyDAO.getInstance();
	String cont = dao.getRepCont(rep_num);
	out.println(cont);
%>