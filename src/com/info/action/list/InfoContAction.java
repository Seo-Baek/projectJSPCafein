package com.info.action.list;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.info.action.Action;
import com.info.action.ActionForward;
import com.info.model.DTO;
import com.info.model.info.InfoDAO;
import com.info.model.info.InfoDTO;
import com.info.model.info.ReplyDTO;

public class InfoContAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int info_no = Integer.parseInt(request.getParameter("no"));
		String info_genre = request.getParameter("genre");
		String nowPage = request.getParameter("page");
		InfoDAO dao = InfoDAO.getInstance();
		dao.infoHit(info_no);
		DTO contdto = dao.getDto(info_no, info_genre);

		request.setAttribute("contDTO", contdto);
		request.setAttribute("genre", info_genre);
		request.setAttribute("page", nowPage);

		List<ReplyDTO> repList = dao.getrep(info_no);

		List<InfoDTO> list = infoPaging(request, info_genre, nowPage);

		request.setAttribute("list", list);
		request.setAttribute("repList", repList);

		ActionForward forward = mnum(request);

		if (forward == null) {
			// view page로 포워딩
			forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("./info/info_cont.jsp");

			return forward;
		}
		return forward;

	}
}
