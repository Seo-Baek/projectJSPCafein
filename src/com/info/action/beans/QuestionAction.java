package com.info.action.beans;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.info.action.Action;
import com.info.action.ActionForward;
import com.info.model.beans.QueDAO;
import com.info.model.beans.QueDTO;

public class QuestionAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		QueDAO dao = QueDAO.getInstance();
		List<QueDTO> list = dao.getQue();
		request.setAttribute("list", list);
		request.setAttribute("count", list.size());

		ActionForward forward = mnum(request);
		if (forward == null) {
			forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("./beans/taste.jsp");
			return forward;
		}
		return forward;

	}
}
