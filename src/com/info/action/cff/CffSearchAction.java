package com.info.action.cff;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.info.action.Action;
import com.info.action.ActionForward;
import com.info.model.cff.CffDAO;
import com.info.model.cff.CffDTO;

public class CffSearchAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 검색창에서 넘어온 데이터를 가지고 검색어에 해당하는 리스트를 db에서 조회하여 뷰 페이지로 이동시키는 클래스.
		String find_field = request.getParameter("find_field");
		String find_name = request.getParameter("find_name").trim();

		// 페이징 처리 기법
		int rowsize = 3;
		int block = 3;
		int totalRecord = 0;
		int allPage = 0;

		int page = 1;

		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}

		int startNo = (page * rowsize) - (rowsize - 1);

		int endNo = (page * rowsize);

		int startBlock = (((page - 1) / block) * block) + 1;

		int endBlock = (((page - 1) / block) * block) + block;

		CffDAO dao = CffDAO.getInstance();
		totalRecord = dao.searchListCount(find_field, find_name);

		allPage = (int) Math.ceil(totalRecord / (double) rowsize);

		if (endBlock > allPage) {
			endBlock = allPage;
		}

		List<CffDTO> list = dao.searchCffList(find_field, find_name, page, rowsize);

		request.setAttribute("page", page); // 사용됨
		request.setAttribute("rowsize", rowsize);
		request.setAttribute("block", block); // 사용됨
		request.setAttribute("totalRecord", totalRecord);
		request.setAttribute("allPage", allPage); // 사용됨
		request.setAttribute("startNo", startNo);
		request.setAttribute("endNo", endNo);
		request.setAttribute("startBlock", startBlock); // 사용됨
		request.setAttribute("endBlock", endBlock);
		request.setAttribute("find_field", find_field);
		request.setAttribute("find_name", find_name);
		request.setAttribute("searchList", list);

		ActionForward forward = mnum(request);

		if (forward == null) {
			// view page로 포워딩
			forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("./coffee/cff_search.jsp");

			return forward;
		}
		return forward;


	}

}
