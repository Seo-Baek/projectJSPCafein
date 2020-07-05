package com.info.action.list;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.info.action.Action;
import com.info.action.ActionForward;
import com.info.model.DTO;
import com.info.model.info.InfoDAO;

public class InfoWriteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String info_genre = request.getParameter("genre");
		String nowPage = request.getParameter("page");
		String no = request.getParameter("no");

		InfoDAO dao = InfoDAO.getInstance();
		
		if (no != null) {
			int info_no = Integer.parseInt(no);
			DTO contdto = dao.getDto(info_no, info_genre);
			request.setAttribute("contDTO", contdto);
			request.setAttribute("no", no);
			request.setAttribute("page", nowPage);
		}
		Map<Integer, String> coun_no = dao.getcountry();

		request.setAttribute("country", coun_no);
		request.setAttribute("genre", info_genre);

		ActionForward forward = mnum(request);
		if (forward == null) {
			forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("./info/info_write.jsp");
			return forward;
		}
		return forward;

	}
}
