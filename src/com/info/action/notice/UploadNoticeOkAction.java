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

public class UploadNoticeOkAction extends CreateThumbnail implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 글쓰기 폼에서 작성된 공지사항을 올리는 클래스
		
		int mno = Integer.parseInt(request.getParameter("mno"));
		
		NoticeDTO dto = new NoticeDTO();
		
		MemberDAO mem = MemberDAO.getInstance();
		String pwd = mem.getUserPwd(mno);
		dto.setBoard_pwd(pwd);
		
		SquareDAO dao = SquareDAO.getInstance();
			
		String mname = request.getParameter("mname");
		String title = request.getParameter("title");
		String cont = request.getParameter("cont");
		String file_name = null;
		
		
		/**********************
		 * 첨부 파일을 받아오는 작업  *
		 **********************/
		if(request.getParameter("thumbnail") != "") {
			file_name = request.getParameter("thumbnail");
			String fileDBName = getThumbnail(request,response,file_name);
				// DB에 저장될 파일 이름을 dto에 저장
			dto.setBoard_file(fileDBName);
		}
		
		dto.setBoard_mno(mno);
		dto.setBoard_writer(mname);
		dto.setBoard_title(title);
		dto.setBoard_cont(cont);
		
			
		
		int res = dao.uploadNotice(dto);
			
		PrintWriter out = response.getWriter();
			
			if(res > 0) {
				out.println("<script>");
				out.println("alert('글 등록 성공')");
				out.println("location.href='enter_list.do?mno=-1&&accept=-1'");
				out.println("</script>");
			} else {
				out.println("<script>");
				out.println("alert('글 등록 실패')");
				out.println("history.back()");
				out.println("</script>");
			}
			
	
		return null;
	}

}
