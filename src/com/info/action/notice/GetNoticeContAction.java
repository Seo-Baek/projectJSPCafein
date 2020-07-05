package com.info.action.notice;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.info.action.Action;
import com.info.action.ActionForward;
import com.info.model.user.NoticeDTO;
import com.info.model.user.ReplyDAO;
import com.info.model.user.ReplyDTO;
import com.info.model.user.SquareDAO;

public class GetNoticeContAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
	// 글번호에 맞는 게시글을 조회하는 클래스
		
		int board_no = 0;
		
		if(request.getParameter("board_no") != null)
			board_no = Integer.parseInt(request.getParameter("board_no"));
		
		

		
		SquareDAO dao = SquareDAO.getInstance();
		NoticeDTO cont = dao.getNoticeContent(board_no);

		ReplyDAO rdao = ReplyDAO.getInstance();
		List<ReplyDTO> reply = rdao.getReply("공지사항", board_no);
		
		System.out.println(cont.getBoard_cont());
		
		request.setAttribute("Cont", cont);
		request.setAttribute("Reply", reply);
		request.setAttribute("cat", "공지사항");
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		if(request.getParameter("category") != null)
			forward.setPath("03notice/notice_update2.jsp");
		else
			forward.setPath("03notice/notice_cont.jsp");
		return forward;
	}

}

