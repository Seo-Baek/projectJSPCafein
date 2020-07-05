package com.info.action.notice;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.info.action.Action;
import com.info.action.ActionForward;
import com.info.action.CreateThumbnail;
import com.info.model.user.NoticeDTO;
import com.info.model.user.SquareDAO;

public class UpdateOkForNoticeAction extends CreateThumbnail implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 공지사항을 업데이트하는 메소드
		int board_no = Integer.parseInt(request.getParameter("board_no"));
		String title = request.getParameter("title");
		String cont = request.getParameter("cont");
		int mno = Integer.parseInt(request.getParameter("mno"));
		String mname = request.getParameter("mname");
		
			
		
		String file_name = null;
		
		SquareDAO dao = SquareDAO.getInstance();
		NoticeDTO dto = dao.getNoticeContent(board_no);
		dto.setBoard_no(board_no);
		dto.setBoard_cont(cont);
		dto.setBoard_title(title);
		
		String show = request.getParameter("show");
		if(show.equals("show"))
			dto.setBoard_show(1);
		else if(show.equals("hide"))
			dto.setBoard_show(0);
		
		
		/**********************
		 * 첨부 파일을 받아오는 작업  *
		 **********************/
		if(request.getParameter("thumbnail") != "") {
			file_name = request.getParameter("thumbnail");
			String fileDBName = getThumbnail(request,response,file_name);
				// DB에 저장될 파일 이름을 dto에 저장
			dto.setBoard_file(fileDBName);
		}
		
		int result = dao.uploadToInfo(dto);
		
		System.out.println(result);
		
PrintWriter out = response.getWriter();
		
		if(result >0) {
			out.println("<script>");
			out.println("alert('게시 성공')");
			out.println("location.href='getNoticeCont.do?board_no="+board_no+"'");
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
