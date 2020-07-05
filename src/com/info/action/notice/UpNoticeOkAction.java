package com.info.action.notice;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.info.action.Action;
import com.info.action.ActionForward;
import com.info.model.user.NoticeDTO;
import com.info.model.user.SquareDAO;

public class UpNoticeOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 공지사항을 정보광장에 올리는 메소드
		int board_no = Integer.parseInt(request.getParameter("board_no"));
		
		SquareDAO dao = SquareDAO.getInstance();
		NoticeDTO dto = dao.getNoticeContent(board_no);
		
		dto.setBoard_show(1);
		
		System.out.println(dto.getBoard_cont());
		
		int result = dao.uploadToInfo(dto);
		
		System.out.println(result);
		
		PrintWriter out = response.getWriter();
		
		if(result >0) {
			out.println("<script>");
			out.println("alert('게시 성공')");
			out.println("location.href='enter_list.do?mno=-1&&accept=-1'");
			out.println("</script>");
		} else if(result == -1) {
			out.println("<script>");
			out.println("alert('게시된 공지사항이 5개 이상인지 확인해주세요.')");
			out.println("location.href='enter_list.do?mno=-1&&accept=-1'");
			out.println("</script>");
		} else {
			out.println("<script>");
			out.println("alert('게시 실패')");
			out.println("history.back()");
			out.println("</script>");
		}
		return null;
	}

}
