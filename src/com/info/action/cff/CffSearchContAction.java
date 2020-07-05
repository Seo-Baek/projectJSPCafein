package com.info.action.cff;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.info.action.Action;
import com.info.action.ActionForward;
import com.info.model.cff.CffDAO;
import com.info.model.cff.CffDTO;

public class CffSearchContAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 검색된 글 상세내역
		int cff_no = Integer.parseInt(request.getParameter("no"));
		int nowPage = Integer.parseInt(request.getParameter("page"));
		String find_field = request.getParameter("find_field");
		String find_name = request.getParameter("find_name");

		CffDAO dao = CffDAO.getInstance();
		CffDTO dto = dao.getCont(cff_no);

		request.setAttribute("searchCont", dto);
		request.setAttribute("page", nowPage);
		request.setAttribute("find_field", find_field);
		request.setAttribute("find_name", find_name);

		ActionForward forward = mnum(request);

		if (forward == null) {
			// view page로 포워딩
			forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("./coffee/cff_search_cont.jsp");

			return forward;
		}
		return forward;

	}

}
