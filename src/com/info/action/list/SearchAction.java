package com.info.action.list;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.info.action.Action;
import com.info.action.ActionForward;
import com.info.model.info.InfoDTO;

public class SearchAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String find_name = request.getParameter("find_name");
		String nowPage = request.getParameter("page");
		
		List<InfoDTO> list = searchPaging(request, find_name, nowPage);

		request.setAttribute("list", list);

		ActionForward forward = mnum(request);
		if (forward == null) {
			forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("./info/list_view.jsp");
			return forward;
		}
		return forward;
	}
}
