package com.info.action.beans;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.info.action.Action;
import com.info.action.ActionForward;
import com.info.model.beans.QueMDTO;

public class TasteListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		String nowPage = request.getParameter("page");
		HttpSession session = request.getSession();
		int mnum = session.getAttribute("mno") != null ? (int) session.getAttribute("mno") : -1;

		if (mnum != -1) {
			List<QueMDTO> list = tastePaging(request, mnum, nowPage);
			request.setAttribute("list", list);
		}
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("./beans/taste_list.jsp");
		return forward;

	}
}
