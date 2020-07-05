package com.info.action.accept;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.info.action.Action;
import com.info.action.ActionForward;
import com.info.model.user.InfoDTO;
import com.info.model.user.SquareDAO;

public class InfoDeleteAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 글번호와 비밀번호를 넘기는 클래스
		int board_no = Integer.parseInt(request.getParameter("board_no"));
		SquareDAO dao = SquareDAO.getInstance();
		InfoDTO dto = dao.getInfoContent(board_no);
		String category = "";
		if(request.getParameter("category") != null)
			category = request.getParameter("category");
		
		System.out.println("무슨번호냐? "+ dto.getBoard_no());
		request.setAttribute("category", category);
		request.setAttribute("dto", dto);
		ActionForward forward = new ActionForward();
		forward.setPath("01accept_board/delete_check.jsp");
		forward.setRedirect(false);
		return forward;
	}
}
