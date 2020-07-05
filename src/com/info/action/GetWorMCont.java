package com.info.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.info.model.user.InfoDTO;
import com.info.model.user.SquareDAO;



public class GetWorMCont implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 글번호에 맞는 대기게시글을 가져오는 클래스
		int board_no = 0;
		
		if(request.getParameter("board_no") != null)
			board_no = Integer.parseInt(request.getParameter("board_no"));
		
		SquareDAO dao = SquareDAO.getInstance();
		InfoDTO cont = dao.getInfoContent(board_no);
		
		request.setAttribute("Cont", cont);

		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		if(request.getParameter("category") != null) {
			request.setAttribute("cat", "마이 리스트");
			forward.setPath("04mypage/my_cont.jsp");
		} else {
			forward.setPath("02management/man_cont.jsp");
			request.setAttribute("cat", "대기글 리스트");
		}
		return forward;
	}

}
