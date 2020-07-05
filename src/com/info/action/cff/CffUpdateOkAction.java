package com.info.action.cff;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.info.action.Action;
import com.info.action.ActionForward;
import com.info.model.cff.CffDAO;
import com.info.model.cff.CffDTO;

public class CffUpdateOkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		       // 자료실 폼에서 넘어온 데이터를 DB에 저장하는 클래스
				CffDTO dto = new CffDTO();
				
				// 첨부파일이 저장될 위치.
				String saveFolder = 
						"C:\\NCS\\workspace(jspTeam)\\00_temp\\WebContent\\images";
				
				// 첨부파일의 최대 크기 설정.
				int fileSize = 10 * 1024 * 1024;
				
				// 파일 업로드 진행 시 이진파일 업로드를 위한 객체 생성
				MultipartRequest multi = new MultipartRequest( 
						request, 
						saveFolder, 
						fileSize,
						"UTF-8",
						new DefaultFileRenamePolicy()
						);
				
				// 자료실 폼 창에서 넘어온 데이터들을 처리해 주자.
				int cff_no = Integer.parseInt(multi.getParameter("cff_no"));
				int nowPage = Integer.parseInt(multi.getParameter("page"));
				String cff_title2 = multi.getParameter("title2").trim();
				String cff_cont1 = multi.getParameter("content1").trim();
				String cff_cont2 = multi.getParameter("content2").trim();
				String old_file = multi.getParameter("old_file").trim();
					
				// 자료실 폼 창에서 type="file" 이라고 되어 있으면
				// getFile() 메서드로 받아주어야 한다.
				File images_file = multi.getFile("title1");
				//File old_file = multi.getFile("old_file");
				
				if(images_file != null) {     // 첨부파일이 존재하는 경우
					// getName() : 첨부파일의 이름을 문자열로 반환하는 메서드
					String fileName1 = images_file.getName();
					
					String homdir = saveFolder;
					
					File path1 = new File(homdir);
					if(!path1.exists()) {     // 폴더가 존재하지 않는 경우
						path1.mkdirs();    // 실제 폴더가 만들어짐.
					}
					
					// 파일을 만들어 보자.
					
					images_file.renameTo(new File(homdir + "/" + fileName1));    // 이름을 바꿔줌   // homdir는 경로까지 모두 들어가있는것임.
					
					String fileDBName1 = 
								fileName1;
					dto.setCff_file(fileDBName1);    // 첨부파일 있는 경우
										
				}else {
					/*String homdir = saveFolder;
                    String fileName2 = old_file.getName();
					old_file.renameTo(new File(homdir + "/" + old_file));    // 이름을 바꿔줌   // homdir는 경로까지 모두 들어가있는것임.
					
					String fileDBName2 = 
								old_file;*/
					
					dto.setCff_file(old_file);
				}
				dto.setCff_no(cff_no);
				dto.setCff_title(cff_title2);
				dto.setCff_cont1(cff_cont1);
				dto.setCff_cont2(cff_cont2);
				
				CffDAO dao = CffDAO.getInstance();
				int res = dao.updateCff(dto);
				
				PrintWriter out = response.getWriter();
						
			/*	if(res > 0) {
					out.println("<script>");
					out.println("alert('게시물 수정 완료')");
					out.println("location.href='cff_cont.do?no="+cff_no+"&page="+nowPage+"'");
					out.println("</script>");
				}else {
					out.println("<script>");
					out.println("alert('게시물 수정 실패')");
					out.println("history.back()");
					out.println("</script>");
				}*/
					
				out.println(res);
				out.close();
				return null;
			}
		

}
