package com.info.action.member;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import com.info.action.Action;
import com.info.action.ActionForward;
import com.info.model.member.MemberDAO;
import com.info.model.member.MemberDTO;

public class LoginAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		PrintWriter out = response.getWriter();
		String id = request.getParameter("m_id");
		String pwd = request.getParameter("m_pwd");

		// DB와 연동
		MemberDAO dao = MemberDAO.getInstance();
		int res = dao.userCheck(id, pwd);
		
		HttpSession session = request.getSession();

		if (res > 0) {
			MemberDTO dto = dao.getMember(id, pwd);

			// 회원의 정보를 세션 객체에 저장
			session.setAttribute("id", dto.getM_id());
			session.setAttribute("nickname", dto.getM_nickname());
			session.setAttribute("userName", dto.getM_nickname());
			session.setAttribute("mno", dto.getM_no());
			session.setAttribute("userNo", dto.getM_no());

		}
		
		out.println(res);
		out.close();
		return null;

	}
}
