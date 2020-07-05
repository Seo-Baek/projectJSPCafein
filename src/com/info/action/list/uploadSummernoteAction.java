package com.info.action.list;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.info.action.Action;
import com.info.action.ActionForward;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class uploadSummernoteAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		PrintWriter out = response.getWriter();   /** AJAX에 보낼 printwriter객체 생성*/
        
		String path = request.getServletContext().getRealPath("/storage");
		System.out.println(path);

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
		// UUID 객체를 통한 랜덤 uuid 생성(보안)
        UUID uuid = UUID.randomUUID();

		String info_file = null;

		File file = req.getFile("file");
		
		if (file != null) {
			String fileName = file.getName();
			String upPath = path + "/" + uuid; // upload 경로

			directory = new File(upPath);

			if (!directory.exists()) {
				directory.mkdir();
			}

			file.renameTo(new File(upPath + "/" + fileName));
			info_file = "/" + uuid + "/" + fileName;
			out.print("storage"+info_file);
			out.close();
		}
		return null;
	}
}
