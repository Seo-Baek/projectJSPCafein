package com.info.action.board;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.info.action.Action;
import com.info.action.ActionForward;
import com.info.model.board.QnaDAO;
import com.info.model.board.QnaDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;


public class QnaEditOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 수정 폼에서 넘어온 데이터를 db에 저장.
		QnaDTO dto = new QnaDTO();
		
		// 첨부파일 
		String saveFolder = "C:\\NCS\\workspace(jspTeam)\\00_temp\\WebContent\\qna_upload";
		
		int fileSize = 10 * 1024 * 1024;
		
		MultipartRequest multi = new MultipartRequest(
				request,
				saveFolder,
				fileSize,
				"UTF-8",
				new DefaultFileRenamePolicy()
				);
		
		// hidden 값 처리
				int qna_no = Integer.parseInt(multi.getParameter("qna_no").trim());
				
				int nowPage= Integer.parseInt(multi.getParameter("page").trim());
				
		// 수정 폼에서 넘어온 데이터 처리.
		String qna_title=multi.getParameter("title").trim();
		String qna_writer=multi.getParameter("writer").trim();
		String qna_cont=multi.getParameter("cont").trim();
		String qna_pwd=multi.getParameter("pwd").trim();
		File qna_file = multi.getFile("file");
		
		
		
		// 첨부파일이 존재하는 경우
		if(qna_file != null) {
			String fileName = qna_file.getName();
			
			// 날짜 객체 생성
			Calendar cal = Calendar.getInstance();
			int year = cal.get(Calendar.YEAR);
			int month = cal.get(Calendar.MONTH)+1;
			int day = cal.get(Calendar.DAY_OF_MONTH);
			
			String homedir = saveFolder + "/" +year + "-" +month + "-" + day;
			
			File path1 = new File(homedir);
			if(!path1.exists()) {        // 폴더가 존재하지 않는 경우
				path1.mkdirs();          // 실제 폴더가 만들어짐.
			}
			
			// 파일을 만들어 보자.
			String refileName = qna_writer+"_"+fileName;
			qna_file.renameTo(new File(homedir + "/" + refileName));
			String fileDBName = "/" + year + "-" + month + "-" + day + "/" +refileName;
			dto.setQna_file(fileDBName);
		}
		
		dto.setQna_no(qna_no);
		dto.setQna_title(qna_title);
		dto.setQna_writer(qna_writer);
		dto.setQna_cont(qna_cont);
		dto.setQna_pwd(qna_pwd);
		
		QnaDAO dao = QnaDAO.getInstance();
		int res = dao.updateQna(dto);
		
		
		
		PrintWriter out = response.getWriter();
		
	/*	if(res>0) {     // 게시물 수정 성공.
			out.println("<script>");
			out.println("alert('게시물 수정 성공'); location.href='qna_list.do'");
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
			out.println("alert('게시물 수정 실패~~~')");
			out.println("history.back()");
			out.println("</script>");
		}
*/
		
		if(res>0) {
			dao.modifyok(qna_no);
		}
		
	   out.println(res);
	   out.close();
		return null;
	}

}
