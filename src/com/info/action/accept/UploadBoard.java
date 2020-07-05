package com.info.action.accept;


import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.info.action.Action;
import com.info.action.ActionForward;
import com.info.action.CreateThumbnail;
import com.info.model.user.InfoDTO;
import com.info.model.user.MemberDAO;
import com.info.model.user.SquareDAO;

public class UploadBoard extends CreateThumbnail implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 폼에서 받아온 정보들을 DB에 저장하는 클래스
		int mno = Integer.parseInt(request.getParameter("mno"));
		
		InfoDTO dto = new InfoDTO();
		
		MemberDAO mem = MemberDAO.getInstance();
		String pwd = mem.getUserPwd(mno);
		dto.setBoard_pwd(pwd);
		
		SquareDAO dao = SquareDAO.getInstance();
		int group = 0;
		int step = 0;
		int parent = 0;
		if(request.getParameter("parent") != null) {
			parent = Integer.parseInt(request.getParameter("parent"));
			InfoDTO temp = dao.getInfoContent(parent);
			step = temp.getBoard_step()+1;
			group = temp.getBoard_group();
		}
			
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
		
		dto.setBoard_group(group);
		dto.setBoard_step(step);
		dto.setBoard_mno(mno);
		dto.setBoard_writer(mname);
		dto.setBoard_title(title);
		dto.setBoard_cont(cont);
		dto.setBoard_parent(parent);
			
		
			
		
		int res = dao.uploadBoard(dto);
			
		PrintWriter out = response.getWriter();
			
			if(res > 0) {
				out.println("<script>");
				out.println("alert('글 등록 성공')");
				out.println("location.href='enter_list.do?mno=-1&&accept=1'");
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
