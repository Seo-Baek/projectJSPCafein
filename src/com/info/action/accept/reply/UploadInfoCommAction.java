package com.info.action.accept.reply;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.info.action.Action;
import com.info.action.ActionForward;
import com.info.model.user.ReplyDAO;
import com.info.model.user.ReplyDTO;

public class UploadInfoCommAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 회원광장에 해당하는 댓글을 insert 하는 클래스
		HttpSession session = request.getSession();
		int board_no = Integer.parseInt(request.getParameter("board_no"));
		int writernum = (int)session.getAttribute("userNo");
		System.out.println("글쓴이 : "+writernum);
		String cont = request.getParameter("commentInsertText");
		int parentnum = 0;
		int dep = 0;
		if(request.getParameter("commentParentNum") != null) {
			parentnum = Integer.parseInt(request.getParameter("commentParentNum"));
		}
		ReplyDTO dto = new ReplyDTO();
		dto.setInfo_no(board_no);
		dto.setCont(cont);
		dto.setWriternum(writernum);
		dto.setDep(dep);
		dto.setParentnum(parentnum);
		if(request.getParameter("category")!=null) {
			System.out.println(board_no);
			System.out.println(request.getParameter("category"));
			dto.setR_category("공지사항");
		} else {
			dto.setR_category("정보광장");
		}
		
		ReplyDAO dao = ReplyDAO.getInstance();
		int result = dao.insertRep(dto);
		PrintWriter out = response.getWriter();
		out.println(result);
		out.close();
		return null;
	}

}
