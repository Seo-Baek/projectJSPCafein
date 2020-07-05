package com.info.action.manage;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.info.action.Action;
import com.info.action.ActionForward;
import com.info.model.user.SquareDAO;

public class AllowContAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 허가 전 게시글을 사용자가 입력한 대로 되돌리는 클래스
		int	board_no = Integer.parseInt(request.getParameter("board_no"));
		String title = request.getParameter("title");
		String cont = request.getParameter("cont");
		
		StringTokenizer st = new StringTokenizer(cont, "반려사유");
		String cont1st = st.nextToken();
		String realCont = cont1st.substring(0, cont1st.length()-3);
		
		SquareDAO dao = SquareDAO.getInstance();
		int res = dao.allowCont(board_no, title, realCont);
		
		HttpSession session = request.getSession();
		
		int userNo = (int)session.getAttribute("userNo");
		
		PrintWriter out = response.getWriter();
		if(res > 0) {
			out.println("<script>");
			out.println("alert('게시 성공.')");
			out.println("location.href='enter_list.do?mno="+userNo+"&&accept=0'");
			out.println("</script>");
		} else {
			out.println("<script>");
			out.println("alert('게시 실패.')");
			out.println("history.back()");
			out.println("</script>");
		}
		return null;
	}

}
