package com.info.action.accept.reply;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.info.action.Action;
import com.info.action.ActionForward;
import com.info.model.user.ReplyDAO;

public class DeleteReplyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 댓글을 삭제 대용 수정하는 클래스
		int rep_num = Integer.parseInt(request.getParameter("rep_no"));
		int board_no = Integer.parseInt(request.getParameter("board_no"));
		System.out.println(board_no);
		
		ReplyDAO dao = ReplyDAO.getInstance();
		
		int res = dao.deleteRep(rep_num);
		PrintWriter out = response.getWriter();
		
		if(res > 0) {
			out.println("<script>");
			if(request.getParameter("category") != null)
				out.println("location.href='getNoticeCont.do?board_no="+board_no+"'");
			else
				out.println("location.href='getInfo_Cont.do?board_no="+board_no+"'");
			out.println("</script>");
		} else {
			out.println("<script>");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return null;
	}

}
