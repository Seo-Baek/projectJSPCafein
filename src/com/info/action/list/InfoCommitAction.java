package com.info.action.list;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.info.action.Action;
import com.info.action.ActionForward;
import com.info.model.DTO;
import com.info.model.info.BeansDTO;
import com.info.model.info.CountryDTO;
import com.info.model.info.ExtraDTO;
import com.info.model.info.InfoDAO;
import com.info.model.info.InfoDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class InfoCommitAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		String path = request.getServletContext().getRealPath("/storage");

		File directory = new File(path); // storage 디렉토리의 정보들을 받기 위해 File 객체 생성

		if (!directory.exists()) { // storage 디렉토리 없으면
			directory.mkdir(); // 하나 만들어라
		}

		MultipartRequest req = new MultipartRequest(request, // 저장할 파일 파라미터가 들어있는 request 객체
				path, // 파일을 저장할 시킬 디렉토리(String)
				500 * 1024 * 1024, // 허용할 최대 파일 용량 (byte단위, 500 mb)
				"UTF-8", // 파일 이름, 일반 파라미터의 문자 인코딩 타입
				new DefaultFileRenamePolicy() // 파일 이름 충돌이 있을 경우, 나중에 저장되는 파일 이름 + 숫자(1, 2, ..)

		);

		String no = req.getParameter("no");
		String nowPage = req.getParameter("page");
		String info_genre = req.getParameter("genre");
		String info_title = req.getParameter("title");
		String info_cont = req.getParameter("cont");
		String dtoFile = req.getParameter("dtoFile");
		String info_file = null;

		File file = req.getFile("file");
		if (file != null) {
			String fileName = info_title + file.getName();
			String upPath = path + "/" + info_genre; // upload 경로

			directory = new File(upPath);

			if (!directory.exists()) {
				directory.mkdir();
			}

			file.renameTo(new File(upPath + "/" + fileName));
			info_file = "/" + info_genre + "/" + fileName;
		} else {
			info_file = dtoFile;
		}

		InfoDAO dao = InfoDAO.getInstance();

		DTO dto = null;

		switch (info_genre) {
		case "beans":
			int coun_no = Integer.parseInt(req.getParameter("coun_no"));
			int beans_aroma = Integer.parseInt(req.getParameter("beans_aroma"));
			int beans_acidity = Integer.parseInt(req.getParameter("beans_acidity"));
			int beans_sweet = Integer.parseInt(req.getParameter("beans_sweet"));
			int beans_bitter = Integer.parseInt(req.getParameter("beans_bitter"));
			int beans_body = Integer.parseInt(req.getParameter("beans_body"));

			dto = new BeansDTO();
			((BeansDTO) dto).setCoun_no(coun_no);
			((BeansDTO) dto).setBeans_aroma(beans_aroma);
			((BeansDTO) dto).setBeans_acidity(beans_acidity);
			((BeansDTO) dto).setBeans_sweet(beans_sweet);
			((BeansDTO) dto).setBeans_bitter(beans_bitter);
			((BeansDTO) dto).setBeans_body(beans_body);
			((BeansDTO) dto).setInfo_title(info_title);
			((BeansDTO) dto).setInfo_cont(info_cont);
			((BeansDTO) dto).setInfo_file(info_file);

			break;
		case "country":
			String coun_val = req.getParameter("coun_val");
			String coun_add = req.getParameter("coun_add");
			StringTokenizer st = new StringTokenizer(coun_val, "|");
			int coun_num = Integer.parseInt(st.nextToken());
			String coun_7 = st.nextToken();
			String conu_no = req.getParameter("conu_no");
			int counNO ;

			dto = new CountryDTO();

			if (conu_no != null) {
				counNO = Integer.parseInt(conu_no);
			} else {
				Map<String, Integer> coun = dao.getcounCount();
				int num = 1;
				if (coun.get(coun_7) != null) {
					num += coun.get(coun_7);
				}
				counNO = (coun_num * 100) + num;
			}

			((CountryDTO) dto).setCoun_no(counNO);
			((CountryDTO) dto).setCoun_7(coun_7);
			((CountryDTO) dto).setCoun_add(coun_add);
			((CountryDTO) dto).setInfo_title(info_title);
			((CountryDTO) dto).setInfo_cont(info_cont);
			((CountryDTO) dto).setInfo_file(info_file);

			break;
		case "extra":
			String extra_genre = req.getParameter("extra_genre");

			dto = new ExtraDTO();

			((ExtraDTO) dto).setExtra_genre(extra_genre);
			((ExtraDTO) dto).setInfo_title(info_title);
			((ExtraDTO) dto).setInfo_cont(info_cont);
			((ExtraDTO) dto).setInfo_file(info_file);

			break;
		default:
			dto = new InfoDTO();

			((InfoDTO) dto).setInfo_genre(info_genre);
			((InfoDTO) dto).setInfo_title(info_title);
			((InfoDTO) dto).setInfo_cont(info_cont);
			((InfoDTO) dto).setInfo_file(info_file);

			break;
		}

		ActionForward forward = mnum(request);

		if (forward == null) {
			if (no != null) {
				int info_no = Integer.parseInt(no);
				int result = dao.updateDTO(info_no, info_genre, dto);
				request.setAttribute("no", no);
				request.setAttribute("page", nowPage);
				if (result > 0) {
					ActionForward forword = new ActionForward();
					forword.setRedirect(true);
					forword.setPath("info_cont.do?no=" + info_no + "&page=" + nowPage + "&genre=" + info_genre);
					return forword;
				} else {
					PrintWriter out = response.getWriter();
					out.println("<script>");
					out.println("alert('게시글 수정 실패~~')");
					out.println("history.back()");
					out.println("</script>");
					return null;
				}
			} else {
				int result = dao.wirteCommit(info_genre, dto);

				if (result > 0) {
					ActionForward forword = new ActionForward();
					forword.setRedirect(true);
					forword.setPath("info_list.do?genre=" + info_genre);
					return forword;
				} else {
					PrintWriter out = response.getWriter();
					out.println("<script>");
					out.println("alert('게시글 추가 실패~~')");
					out.println("history.back()");
					out.println("</script>");
					return null;
				}
			}
		}
		return forward;

	}
}
