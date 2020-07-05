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


public class QnaWriteOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 문의하기 폼에서 넘어온 데이터를 db에 저장.
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
				
				
				dto.setQna_title(qna_title);
				dto.setQna_writer(qna_writer);
				dto.setQna_cont(qna_cont);
				dto.setQna_pwd(qna_pwd);
				
				QnaDAO dao = QnaDAO.getInstance();
				int res = dao.insertQna(dto);
			
				
				PrintWriter out = response.getWriter();
				ActionForward forward = new ActionForward();
				
				 /*  if(res>0) {     // 게시물 수정 성공.
						out.println("<script>");
						out.println("alert('게시글 추가 성공')");
						forward.setRedirect(true);       
						forward.setPath("qna_list.do");  
						out.println("</script>");
					
					}else {
						out.println("<script>");
						out.println("alert('게시글 추가 실패~~~')");
						forward.setRedirect(false);       
						forward.setPath("qna_write.jsp");  
						out.println("</script>");
					}*/

				  out.println(res);
			      out.close();
			      return null;
				}

			}

		