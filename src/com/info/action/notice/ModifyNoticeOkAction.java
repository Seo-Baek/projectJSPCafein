package com.info.action.notice;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.info.action.Action;
import com.info.action.ActionForward;
import com.info.action.CreateThumbnail;
import com.info.model.user.MemberDAO;
import com.info.model.user.NoticeDTO;
import com.info.model.user.SquareDAO;

public class ModifyNoticeOkAction extends CreateThumbnail implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 업데이트를 하는 클래스!
		
		int mno = Integer.parseInt(request.getParameter("mno"));
		int board_no = Integer.parseInt(request.getParameter("board_no"));
		
		NoticeDTO dto = new NoticeDTO();
		
		MemberDAO mem = MemberDAO.getInstance();
		String pwd = mem.getUserPwd(mno);
		dto.setBoard_pwd(pwd);
		
		SquareDAO dao = SquareDAO.getInstance();
		
		String file = dao.getNoticeContent(board_no).getBoard_file();
			
		String mname = request.getParameter("mname");
		String title = request.getParameter("title");
		String cont = request.getParameter("cont");
		String file_name = null;
		
		
		/**********************
		 * 첨부 파일을 받아오는 작업  *
		 **********************/
		if(request.getParameter("thumbnail") != "") {
			if(request.getParameter("thumbnail").equals(file)) {
				dto.setBoard_file(file);
			} else {
				file_name = request.getParameter("thumbnail");
				String fileDBName = getThumbnail(request,response,file_name);
				// DB에 저장될 파일 이름을 dto에 저장
				dto.setBoard_file(fileDBName);
			}
		} else {
			dto.setBoard_file(file);
		}
		
		if(request.getParameter("show").equals("노출"))
			dto.setBoard_show(1);
		else
			dto.setBoard_show(0);
		System.out.println("게시할거에요? " + dto.getBoard_show());
		
		dto.setBoard_no(board_no);
		dto.setBoard_mno(mno);
		dto.setBoard_writer(mname);
		dto.setBoard_title(title);
		dto.setBoard_cont(cont);
		
		int result = dao.uploadToInfo(dto);
		
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
