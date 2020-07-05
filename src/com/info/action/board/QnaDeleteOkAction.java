package com.info.action.board;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.info.action.Action;
import com.info.action.ActionForward;
import com.info.model.board.QnaDAO;

public class QnaDeleteOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String qna_pwd = request.getParameter("pwd").trim();
		
		int qna_no= Integer.parseInt(request.getParameter("qna_no"));
		int nowPage = Integer.parseInt(request.getParameter("page"));
		
		QnaDAO dao = QnaDAO.getInstance();
		int res = dao.qnaDelete(qna_no,qna_pwd);
		
		 PrintWriter out = response.getWriter();
	
	   
	    
/*    if(res>0) {     // 게시물 수정 성공.
			out.println("<script>");
			out.println("alert('게시물 삭제 성공'); location.href='qna_list.do'");
			out.println("</script>");
	    }else if (res== -1) {
			out.println("<script>");
			out.println("alert('비밀번호가 틀립니다. 확인요망.')");
			out.println("history.back()");
			out.println("</script>");
		}else if(res==-2) {
			out.println("<script>");
			out.println("alert('해당 게시글이 없습니다.')");
			out.println("history.back()");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('게시물 삭제 실패~~~')");
			out.println("history.back()");
			out.println("</script>");
		}
*/
		  out.println(res);
	      out.close();
	      return null;
	}

}
