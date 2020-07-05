package com.info.action.notice;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.info.action.Action;
import com.info.action.ActionForward;
import com.info.model.user.NoticeDTO;
import com.info.model.user.SquareDAO;

public class NotAllowAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 체크된 값을 board_show=0으로 만들어주는 클래스
		String[] value = request.getParameterValues("is_check");
		int result = 0;
		for(int i = 0; i < value.length; i++) {
			SquareDAO dao = SquareDAO.getInstance();
			NoticeDTO dto = dao.getNoticeContent(Integer.parseInt(value[i]));
			dto.setBoard_show(0);
			result = dao.uploadToInfo(dto);
		}
		
		PrintWriter out = response.getWriter();
		if(result >0) {
			out.println("<script>");
			out.println("alert('게시 취소 성공.')");
			out.println("location.href='enter_list.do?mno=-1&&accept=-1'");
			out.println("</script>");
		} else {
			out.println("<script>");
			out.println("alert('게시 취소 실패')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return null;
	}

}
