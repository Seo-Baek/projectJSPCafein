package com.info.action.manage;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.info.action.Action;
import com.info.action.ActionForward;
import com.info.model.user.SquareDAO;

public class UpdateCheckOKAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 수정된 대기글을 전달하는 클래스
		int board_no = Integer.parseInt(request.getParameter("board_no"));
		String title = request.getParameter("title");
		String cont = request.getParameter("cont");
		
		SquareDAO dao = SquareDAO.getInstance();
		
		int res = dao.updateCheck(board_no, title, cont);
		
		PrintWriter out = response.getWriter();
		
		if(res > 0) {
			out.println("<script>");
			out.println("alert('수정 완료')");
			out.println("location.href='goWorMCont.do?board_no="+board_no+"'");
			out.println("</script>");
		} else {
			out.println("<script>");
			out.println("alert('수정 실패')");
			out.println("history.back()");
			out.println("</script>");
		}
		return null;
	}

}
