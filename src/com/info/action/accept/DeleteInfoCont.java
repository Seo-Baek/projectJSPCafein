package com.info.action.accept;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.info.action.Action;
import com.info.action.ActionForward;
import com.info.model.user.SquareDAO;

public class DeleteInfoCont implements Action{
	
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 실제로 글을 삭제하는 클래스
		int board_no = Integer.parseInt(request.getParameter("board_no"));
		SquareDAO dao = SquareDAO.getInstance();
		int res = dao.deleteInfoCont(board_no);
		PrintWriter out = response.getWriter();
		
		if(res > 0) {
			out.println("<script>");
			out.println("alert('삭제 성공')");
			out.println("location.href='enter_list.do?mno=-1&&accept=1'");
			out.println("</script>");
		} else {
			out.println("<script>");
			out.println("alert('삭제 실패')");
			out.println("location.href='getInfo_Cont.do?board_no="+board_no+"'");
			out.println("</script>");
		}
		
		
		return null;
	}
}
