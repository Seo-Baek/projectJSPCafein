package com.info.action.member;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.info.action.Action;
import com.info.action.ActionForward;
import com.info.model.member.MemberDAO;
import com.info.model.member.MemberDTO;

public class MemberListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		MemberDAO dao = MemberDAO.getInstance();
		List<MemberDTO> list = dao.getMemberList();
		request.setAttribute("List", list);
		List<MemberDTO> outList = dao.outMemberList();
		request.setAttribute("outList", outList);
		
		ActionForward forward = mnum(request);

		if (forward == null) {
			forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("./member/adminpage.jsp");
			return forward;
		}
		return forward;
		
	}

}