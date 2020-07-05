package com.info.action.manage;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.info.action.Action;
import com.info.action.ActionForward;
import com.info.model.user.InfoDTO;
import com.info.model.user.SquareDAO;

public class UpdateContAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 게시글에 맞는 대기글을 폼으로 넘겨주는 클래스
		int board_no = Integer.parseInt(request.getParameter("board_no"));
		SquareDAO dao = SquareDAO.getInstance();
		InfoDTO dto = dao.getInfoContent(board_no);
		
		request.setAttribute("dto", dto);
		
		ActionForward forward = new ActionForward();
		forward.setPath("02management/man_update.jsp");
		forward.setRedirect(false);
		return forward;
	}

}
