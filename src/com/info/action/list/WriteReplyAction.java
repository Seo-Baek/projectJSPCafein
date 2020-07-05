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

public class WriteReplyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		ReplyDTO dto = new ReplyDTO();
		dto.setCont(request.getParameter("content"));
		dto.setWriterNum((int) request.getSession().getAttribute("mno"));
		dto.setInfo_no(Integer.parseInt(request.getParameter("boardNum")));
		dto.setParentNum(Integer.parseInt(request.getParameter("parentNum")));
		dto.setDep(Integer.parseInt(request.getParameter("depth")));

		int info_no = Integer.parseInt(request.getParameter("boardNum"));
		String info_genre = request.getParameter("genre");
		String nowPage = request.getParameter("page");
		InfoDAO dao = InfoDAO.getInstance();
		DTO contdto = dao.getDto(info_no, info_genre);

		request.setAttribute("contDTO", contdto);
		request.setAttribute("genre", info_genre);
		request.setAttribute("page", nowPage);

		List<ReplyDTO> repList = dao.getrep(info_no);

		List<InfoDTO> list = infoPaging(request, info_genre, nowPage);

		request.setAttribute("list", list);
		request.setAttribute("repList", repList);

		int res = dao.insert(dto);

		ActionForward forward = mnum(request);

		if (forward == null) {
			if (res == 1) {
				forward = new ActionForward();
				forward.setRedirect(false);
				forward.setPath("info_cont.do?no=" + info_no + "&page=" + nowPage + "&genre=" + info_genre);

				return forward;
			}
		}
		return forward;

	}
}
