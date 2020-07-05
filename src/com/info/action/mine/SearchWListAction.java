package com.info.action.mine;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.info.action.Action;
import com.info.action.ActionForward;
import com.info.model.user.InfoDTO;
import com.info.model.user.SquareDAO;

public class SearchWListAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 조건에 따른 검색 리스트를 불러오는 클래스
		int mno = Integer.parseInt(request.getParameter("mno"));
		String nowPage = null;
		if(request.getParameter("page") != null)
			nowPage = request.getParameter("page");
		else
			nowPage = "1";
		
		String req_box = request.getParameter("req_box");
		String req_text = request.getParameter("req_text");
		System.out.println("검색조건 : " + req_box+" 조건값 : "+req_text);
		
		SquareDAO dao = SquareDAO.getInstance();
		List<InfoDTO> list = paging(request, mno, nowPage, req_box, req_text);
		request.setAttribute("board_list", list);
		request.setAttribute("req_text", req_text);
		request.setAttribute("req_box", req_box);
		
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("04mypage/my_search.jsp");
		return forward;
	}
	
	public List<InfoDTO> paging(HttpServletRequest request,int mno, String nowPage, String req_box, String req_text) {
		// 조건에 맞는 리스트를 기준으로 하기위해 Action 페이지의 paging 메소드 overload
			int block = 5; // 아래에 보여질 페이지의 최대 수	
			int size = 0; // 한 페이지당 보여질 게시물의 수
			
			
		      int page = 1;
		     
		    	  size = 10;
		      if (nowPage != null) {
		         page = Integer.parseInt(nowPage);
		      }
		      int total = 0; // DB 상의 레코드 전체 수 (게시물의 수)
		      int allPage = 0; // 전체 페이지 수
		      // 해당 페이지에서 시작 번호
		      int startNo = (page * size) - (size - 1);
		      // 해당 페이지의 끝 번호
		      int endNo = (page * size);
		      // 해당 페이지의 시작 블럭
		      int startBlock = (((page - 1) / block) * block) + 1;
		      // 해당 페이지의 마지막 블럭
		      int endBlock = (((page - 1) / block) * block) + block;

		      List<InfoDTO> list = null;
		      SquareDAO dao = SquareDAO.getInstance();
		      total = dao.getWSearchCount(mno, req_box, req_text);
		      // 검색된 전체 게시물의 수를 한 페이지당 보여질 게시물의 수로 나누어 전체 페이지 수 구하기(나머지는 무조건 올림)
		      allPage = (int) Math.ceil(total / (double) size);
		      System.out.println(allPage);

		      if (allPage > 0) {
		         if (endBlock > allPage)
		            endBlock = allPage;
		         list = dao.getSearchWaitList(mno,startNo, endNo, req_box, req_text);// 현재 페이지에 해당하는 글 목록

		      }
		      
		      request.setAttribute("page", page);
		      request.setAttribute("block", block);
		      request.setAttribute("allPage", allPage);
		      request.setAttribute("startNo", startNo);
		      request.setAttribute("endNo", endNo);
		      request.setAttribute("startBlock", startBlock);
		      request.setAttribute("endBlock", endBlock);
		      
		      return list;
	
	}

	
}
