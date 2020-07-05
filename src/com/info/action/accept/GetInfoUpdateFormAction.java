package com.info.action.accept;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.info.action.Action;
import com.info.action.ActionForward;
import com.info.model.user.InfoDTO;
import com.info.model.user.SquareDAO;


public class GetInfoUpdateFormAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 글번호에 맞는 게시글의 상세정보를 update 폼에 넘기는 클래스
		int board_no = Integer.parseInt(request.getParameter("board_no"));
		String category = null;
		if(request.getParameter("category") != null)
			category = request.getParameter("category");
		
		SquareDAO dao = SquareDAO.getInstance();
		InfoDTO dto = dao.getInfoContent(board_no);
		
		request.setAttribute("dto", dto);
		request.setAttribute("category", category);
		
		ActionForward forward = new ActionForward();
		forward.setPath("01accept_board/info_update.jsp");
		forward.setRedirect(false);
		return forward;
	}

}
