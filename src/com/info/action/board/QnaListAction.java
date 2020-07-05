package com.info.action.board;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.info.action.Action;
import com.info.action.ActionForward;
import com.info.model.board.QnaDAO;
import com.info.model.board.QnaDTO;


public class QnaListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		int rowsize = 5;
		int block =3;
		int totalRecord = 0;
		int allPage = 0;
		
		int page = 1;
		
		if(request.getParameter("page")!=null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		
		int startNo = (page*rowsize)-(rowsize-1);
		int endNo = (page*rowsize);
		
		int startBlock = (((page-1)/block)*block)+1;
		int endBlock = (((page-1)/block)*block)+block;
		
		// 전체 게시물의 수 가져오기
		QnaDAO dao = QnaDAO.getInstance();
		totalRecord = dao.getListCount();
		
		allPage = (int)Math.ceil(totalRecord/(double)rowsize);
		
		if(endBlock>allPage) {
			endBlock=allPage;
		}
		
		// 한페이지에 나올 게시물들 가져오기.
		List<QnaDTO>list = dao.getQnaList(startNo, endNo);
		
		
		request.setAttribute("page",page);
		request.setAttribute("rowsize",rowsize);
		request.setAttribute("block",block);
		request.setAttribute("totalRecord",totalRecord);
		request.setAttribute("allPage",allPage);
		request.setAttribute("startNo",startNo);
		request.setAttribute("endNo",endNo);
		request.setAttribute("startBlock",startBlock);
		request.setAttribute("endBlock",endBlock);
		request.setAttribute("List",list);
		
		ActionForward forward = mnum(request);

		if (forward == null) {
			// view page로 포워딩
			forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("./board/qna_list.jsp");

			return forward;
		}
		return forward;
		
	}

}
