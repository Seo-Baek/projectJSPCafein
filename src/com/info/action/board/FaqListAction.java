package com.info.action.board;



import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.info.action.Action;
import com.info.action.ActionForward;
import com.info.model.board.FaqDAO;
import com.info.model.board.FaqDTO;



public class FaqListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)  {
	    // 페이징 처리
		int rowsize = 3;       // 한 페이지당 보여질 게시물의 수
		int block = 3;           // 보여질 블록 수
		int totalRecord =0; // 전체 게시물의 수 초기 값 설정
		int allPage = 0; // 전체 페이지수 초기  값 설정
		
		int page = 0; // 현재 페이지 초기값
		 
		if(request.getParameter("page")!=null) {
			page = Integer.parseInt(request.getParameter("page"));
		}else {
			page=1;    //  처음으로 "게시물 목록" 태그를 클릭한 경우 
		}
		
		
		// 해당 페이지에서 게시물 시작 번호
		int startNo = (page*rowsize)-(rowsize-1);
		int endNo = (page*rowsize);
		
		// 해당 페이지의 시작 블럭 
		int startBlock = (((page-1) / block) *  block) +1;
		// 해당 페이지의 마지막 블럭
		int endBlock = (((page-1) / block) *  block) + block;
		
		FaqDAO dao = FaqDAO.getInstance();
		totalRecord = dao.getListCount();
		
	
		allPage = (int)Math.ceil(totalRecord / (double)rowsize);
		
		if(endBlock<allPage) {
			endBlock = allPage;
		}
		
		List<FaqDTO>list =  dao.getFaqList(startNo,endNo);
		
		request.setAttribute("page", page);
		request.setAttribute("rowsize", rowsize);
		request.setAttribute("block", block);
		request.setAttribute("totalRecord", totalRecord);
		request.setAttribute("allPage", allPage);
		request.setAttribute("startNo",startNo);
		request.setAttribute("endNo", endNo);
		request.setAttribute("startBlock", startBlock);
		request.setAttribute("endBlock", endBlock);
		request.setAttribute("List",list);
		
		ActionForward forward =new ActionForward();
			forward.setRedirect(false);
			forward.setPath("./board/faq_list.jsp");    // 경로 지정.

			return forward;
		
	}
}	
	