package com.info.action.notice;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.info.action.Action;
import com.info.action.ActionForward;
import com.info.model.user.MemberDAO;
import com.info.model.user.NoticeDTO;
import com.info.model.user.SquareDAO;

public class ConfirmUploadAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 게시글을 노출하는 메소드
		int board_no = Integer.parseInt(request.getParameter("board_no"));
		SquareDAO dao = SquareDAO.getInstance();
		NoticeDTO dto = dao.getNoticeContent(board_no);
		HttpSession session = request.getSession();
		int userNo = (int)session.getAttribute("userNo");
		MemberDAO mem = MemberDAO.getInstance();
		String memPwd = mem.getUserPwd(userNo);
		dto.setBoard_pwd(memPwd);
		
		System.out.println("무슨번호냐? "+ dto.getBoard_no());
		request.setAttribute("dto", dto);
		ActionForward forward = new ActionForward();
		forward.setPath("03notice/upload_check.jsp");
		forward.setRedirect(false);
		return forward;
	}

}
