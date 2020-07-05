package com.info.action.cff;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.info.action.Action;
import com.info.action.ActionForward;
import com.info.model.cff.CffDAO;
import com.info.model.cff.CffDTO;

public class CffListAction implements Action {
	
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		// DB의 전체 레코드를 화면으로 이동시켜서 출력시키는 클래스
		// CffDAO dao = CffDAO.getInstance();
		// List<CffDTO> list =  dao.getCffList();
		
		int rowsize = 3;
		int block = 3;
		int totalRecord = 0;
		int allPage = 0;
		
		int page = 0;
		
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}else {
			page = 1;
		}
		
		int startNo = (page * rowsize) - (rowsize - 1);
		
		int endNo = (page * rowsize);
		
		int startBlock = (((page - 1) / block) * block) + 1;
		
		int endBlock = (((page - 1) / block) * block) + block;
		
		CffDAO dao = CffDAO.getInstance();
		totalRecord = dao.getListCount();
		
		allPage = (int)Math.ceil(totalRecord / (double)rowsize);
		
		if(endBlock > allPage) {
			endBlock = allPage;
		}
		
		List<CffDTO> list = dao.getCffList(page,rowsize);
		
		
		
		request.setAttribute("page", page);     // 사용됨
		request.setAttribute("rowsize", rowsize);
		request.setAttribute("block", block);    // 사용됨
		request.setAttribute("totalRecord", totalRecord);
		request.setAttribute("allPage", allPage);    // 사용됨
		request.setAttribute("startNo", startNo);
		request.setAttribute("endNo", endNo);
		request.setAttribute("startBlock", startBlock);    // 사용됨
		request.setAttribute("endBlock", endBlock);  
		request.setAttribute("List", list);
		
		
		
		ActionForward forward = mnum(request);
		
		if (forward == null) {
			// view page로 포워딩
			forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("./coffee/cff_list.jsp");
			
			return forward;
		}
		return forward;
		

	}

}
