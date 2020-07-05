package com.info.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.info.model.DTO;
import com.info.model.user.NoticeDTO;
import com.info.model.user.SquareDAO;


public class GetListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 승인된 글 리스트를 불러오는 클래스
		
		String nowPage = null;
		if(request.getParameter("page") != null)
			nowPage = request.getParameter("page");
		else
			nowPage = "1";
		int mno = Integer.parseInt(request.getParameter("mno"));
		int accept = Integer.parseInt(request.getParameter("accept"));
		System.out.println("회원번호 : " +mno + "허가번호 : "+accept);
		
		// 페이징 처리를 하는 메소드 호출
		SquareDAO dao = SquareDAO.getInstance();
		List<DTO> list = paging(request, mno, accept, nowPage);
		request.setAttribute("board_list", list);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		if(mno == -1 && accept == 1) {
			List<NoticeDTO> notice = dao.showNotice(); 
			request.setAttribute("notice_list", notice);
			forward.setPath("01accept_board/info_list.jsp");
		} else if(mno <= 100 && accept == 0) {
			forward.setPath("02management/man_list.jsp");
		} else if(mno == -1 && accept == -1) {
			List<NoticeDTO> notice = dao.showNotice(); 
			request.setAttribute("notice_list", notice);
			forward.setPath("03notice/notice_list.jsp");
		} else if(mno >100 && accept == -1) {
			forward.setPath("04mypage/my_list.jsp");
		}
		
		return forward;
	}

}
