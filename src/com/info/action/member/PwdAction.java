package com.info.action.member;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.info.action.Action;
import com.info.action.ActionForward;
import com.info.model.member.MemberDAO;

public class PwdAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		PrintWriter out = response.getWriter();
		String m_id = request.getParameter("m_id");
		String m_email1 = request.getParameter("m_email1");
		String m_email2 = request.getParameter("m_email2");
		String m_email = m_email1 + "@" + m_email2;

		// DB와 연동
		MemberDAO dao = MemberDAO.getInstance();
		String res = dao.pwdCheck(m_id, m_email);

		out.println(res);
		out.close();
		return null;

	}
}
