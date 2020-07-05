package com.info.action.cff;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.info.action.Action;
import com.info.action.ActionForward;
import com.info.model.cff.CffDAO;
import com.info.model.cff.CffDTO;

public class CffContAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 사진을 클릭했을 때 상세 내용을 보여주는 클래스
		int cff_no = Integer.parseInt(request.getParameter("no"));
		int nowPage = Integer.parseInt(request.getParameter("page"));

		CffDAO dao = CffDAO.getInstance();
		CffDTO dto = dao.getCont(cff_no);

		request.setAttribute("cont", dto);
		request.setAttribute("page", nowPage);

		ActionForward forward = mnum(request);

		if (forward == null) {
			// view page로 포워딩
			forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("./coffee/cff_cont.jsp");

			return forward;
		}
		return forward;

	}

}
