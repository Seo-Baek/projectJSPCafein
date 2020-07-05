package com.info.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.info.model.DTO;
import com.info.model.beans.QueDAO;
import com.info.model.beans.QueMDTO;
import com.info.model.info.InfoDAO;
import com.info.model.info.InfoDTO;
import com.info.model.user.SquareDAO;

public interface Action {

	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException;

	int size = 10; // 한 페이지당 보여질 게시물의 수
	int block = 5; // 아래에 보여질 페이지의 최대 수

	public default ActionForward mnum(HttpServletRequest request) {
		// 1. 세션 받기
		HttpSession session = request.getSession();

		// 2. 세션에서 회원번호 애트리뷰트 꺼내기
		int mnum = session.getAttribute("mno") != null ? (int) session.getAttribute("mno") : -1;

		// 3. num이 없을 경우 바로 로그인 페이지로 이동 ( result : false )
		if (mnum == -1) { // 세션이 없음(로그인을 안했음 혹은 시간 초과로 세션이 사라짐)
			ActionForward forword = new ActionForward();
			forword.setRedirect(true);
			forword.setPath("member.do");
			return forword;
		}
		
		request.setAttribute("mnum", mnum);
	
		return null;
	}

	public default List<InfoDTO> infoPaging(HttpServletRequest request, String info_genre, String nowPage) {
		int page = 1;
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
		InfoDAO dao = InfoDAO.getInstance();
		total = dao.getCount(info_genre);
		// 검색된 전체 게시물의 수를 한 페이지당 보여질 게시물의 수로 나누어 전체 페이지 수 구하기(나머지는 무조건 올림)
		allPage = (int) Math.ceil(total / (double) size);

		if (allPage > 0) {
			if (endBlock > allPage)
				endBlock = allPage;
			list = dao.infoList(info_genre, startNo, endNo);// 현재 페이지에 해당하는 글 목록
		}
		if (list == null) {
			page = 0;
		}

		request.setAttribute("genre", info_genre);
		request.setAttribute("page", page);
		request.setAttribute("block", block);
		request.setAttribute("allPage", allPage);
		request.setAttribute("startNo", startNo);
		request.setAttribute("endNo", endNo);
		request.setAttribute("startBlock", startBlock);
		request.setAttribute("endBlock", endBlock);

		return list;
	}
	
	public default List<InfoDTO> searchPaging(HttpServletRequest request, String find_name, String nowPage) {
		int page = 1;
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
		InfoDAO dao = InfoDAO.getInstance();
		total = dao.getSearchCount(find_name);
		// 검색된 전체 게시물의 수를 한 페이지당 보여질 게시물의 수로 나누어 전체 페이지 수 구하기(나머지는 무조건 올림)
		allPage = (int) Math.ceil(total / (double) size);

		if (allPage > 0) {
			if (endBlock > allPage)
				endBlock = allPage;
			list = dao.searchList(find_name, startNo, endNo);// 현재 페이지에 해당하는 글 목록
		}
		if (list == null) {
			page = 0;
		}

		request.setAttribute("genre", find_name);
		request.setAttribute("page", page);
		request.setAttribute("block", block);
		request.setAttribute("allPage", allPage);
		request.setAttribute("startNo", startNo);
		request.setAttribute("endNo", endNo);
		request.setAttribute("startBlock", startBlock);
		request.setAttribute("endBlock", endBlock);

		return list;
	}
	
	public default List<QueMDTO> tastePaging(HttpServletRequest request, int mno, String nowPage) {
		int page = 1;
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

		List<QueMDTO> list = null;
		QueDAO dao = QueDAO.getInstance();
		total = dao.getCount(mno);
		// 검색된 전체 게시물의 수를 한 페이지당 보여질 게시물의 수로 나누어 전체 페이지 수 구하기(나머지는 무조건 올림)
		allPage = (int) Math.ceil(total / (double) size);

		if (allPage > 0) {
			if (endBlock > allPage)
				endBlock = allPage;
			list = dao.list(mno, startNo, endNo);// 현재 페이지에 해당하는 글 목록
		}
		if (list == null) {
			page = 0;
		}

		request.setAttribute("genre", mno);
		request.setAttribute("page", page);
		request.setAttribute("block", block);
		request.setAttribute("allPage", allPage);
		request.setAttribute("startNo", startNo);
		request.setAttribute("endNo", endNo);
		request.setAttribute("startBlock", startBlock);
		request.setAttribute("endBlock", endBlock);

		return list;
	}
	
	public default List<DTO> paging(HttpServletRequest request,int mno, int accept, String nowPage){
		int size = 0; // 한 페이지당 보여질 게시물의 수
		
		
	      int page = 1;
	      if(mno==-1&&accept==1 || mno==-1 && accept==-1 || mno>100&&accept==-1) {
	    	  size = 10;
	      } else if(mno<= 100&&accept==0) {
	    	  size = 8;
	      }
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

	      List<DTO> list = null;
	      SquareDAO dao = SquareDAO.getInstance();
	      total = dao.getInfoCount(mno, accept);
	      // 검색된 전체 게시물의 수를 한 페이지당 보여질 게시물의 수로 나누어 전체 페이지 수 구하기(나머지는 무조건 올림)
	      allPage = (int) Math.ceil(total / (double) size);
	      System.out.println(allPage);

	      if (allPage > 0) {
	         if (endBlock > allPage)
	            endBlock = allPage;
	         list = dao.getBaordList(mno, accept, startNo, endNo);// 현재 페이지에 해당하는 글 목록

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