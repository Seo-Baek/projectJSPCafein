<%@page import="java.io.PrintWriter"%>
<%@page import="com.info.model.user.InfoDTO"%>
<%@page import="com.info.model.user.SquareDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int parent = Integer.parseInt(request.getParameter("parent"));
	
	SquareDAO dao = SquareDAO.getInstance();
	InfoDTO dto = dao.getInfoContent(parent);
	
	int[] gNs = {dto.getBoard_group(), dto.getBoard_step()};
	
	out.println(gNs);

%>