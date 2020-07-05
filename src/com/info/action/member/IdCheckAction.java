package com.info.action.member;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.info.action.Action;
import com.info.action.ActionForward;
import com.info.model.member.MemberDAO;

public class IdCheckAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		PrintWriter out = response.getWriter();
		String id = request.getParameter("userId");

		// DB와 연동
		MemberDAO dao = MemberDAO.getInstance();
		int res = dao.checkMemberId(id);
		
		out.println(res);
		out.close();
		return null;
	}
}
