package com.info.action.cff;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.info.action.Action;
import com.info.action.ActionForward;
import com.info.model.cff.CffDAO;
import com.info.model.cff.CffDTO;

public class CffDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 삭제 폼 페이지로 이동

		int cff_no = Integer.parseInt(request.getParameter("no"));

		CffDAO dao = CffDAO.getInstance();
		CffDTO dto = dao.getCont(cff_no);

		request.setAttribute("no", cff_no);
		request.setAttribute("cont", dto);

		ActionForward forward = mnum(request);

		if (forward == null) {
			// view page로 포워딩
			forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("./coffee/cff_delete.jsp");

			return forward;
		}
		return forward;

	}

}
