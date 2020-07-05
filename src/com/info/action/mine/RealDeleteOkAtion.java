package com.info.action.mine;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.info.action.Action;
import com.info.action.ActionForward;
import com.info.model.user.SquareDAO;

public class RealDeleteOkAtion implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 게시 허가 되지 않은 게시글을 삭제하는 클래스
		System.out.println(request.getParameter("board_no"));
		int board_no = Integer.parseInt(request.getParameter("board_no"));
		HttpSession session = request.getSession();
		int mno = (int)session.getAttribute("userNo");
		
		SquareDAO dao = SquareDAO.getInstance();
		int res = dao.realDeleteCont(board_no);
		
		PrintWriter out = response.getWriter();
		
		if(res > 0) {
			out.println("<script>");
			out.println("alert('게시글 삭제 성공')");
			out.println("location.href='my_list.do?mno="+mno+"&&accept=-1'");
			out.println("</script>");
		} else {
			out.println("<script>");
			out.println("alert('게시글 삭제 실패')");
			out.println("location.href='getMyCont.do?board_no="+board_no+"'");
			out.println("</script>");
		}
		return null;
	}

}
