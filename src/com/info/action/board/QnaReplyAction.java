package com.info.action.board;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.info.action.Action;
import com.info.action.ActionForward;
import com.info.model.board.QnaDAO;
import com.info.model.board.QnaDTO;


public class QnaReplyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int qna_no = Integer.parseInt(request.getParameter("no"));
		int nowPage = Integer.parseInt(request.getParameter("page"));
		
		QnaDAO dao = QnaDAO.getInstance();
		QnaDTO dto = dao.getQnaCont(qna_no);
		
		request.setAttribute("reply", dto);
		request.setAttribute("page",nowPage);
	

		ActionForward forward = mnum(request);

		if (forward == null) {
			// view page로 포워딩
			forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("./board/qna_reply.jsp");

			return forward;
		}
		return forward;

	}

}
