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

public class DeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		PrintWriter out = response.getWriter();

		// 1. 세션 받기
		HttpSession session = request.getSession();

		// 2. 세션에서 회원번호 애트리뷰트 꺼내기
		int mnum = session.getAttribute("mno") != null ? (int) session.getAttribute("mno") : -1;

		String no = request.getParameter("no");
		int m_no = -1;
		if (no != null) {
			m_no = Integer.parseInt(no);
		}

		if (m_no != -1) {

			MemberDAO dao = MemberDAO.getInstance();
			MemberDTO dto = dao.getMember(m_no);
			int result = 0;
			if (dao.keepDeleteMember(dto) == 1) {
				result = dao.delete(m_no);
			}

			if(result> 0) {
				if (mnum > 100) {
					// 현재 클라이언트의 세션 끊기
					session.removeAttribute("mno"); // 세션에 들어있는 회원 번호 삭제
					session.invalidate(); // 세션 갱신
					out.print("index.jsp");
				}
				out.print("member_list.do");
			}
		}

		return null;
	}
}