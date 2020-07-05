package com.info.action.list;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.info.action.Action;
import com.info.action.ActionForward;

public class DownloadAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String fileName = request.getParameter("file");

		// 1. storage 폴더에서 fileName 이름을 가진 파일을 가져옴

		// 1-1. storage 진짜 경로 받기
		String realPath = request.getServletContext().getRealPath("/storage");

		// 1-2. 전송할 File 객체 생성 (스트림 생성에 사용, 파일 사이즈 확인에 사용)
		File file = new File(realPath, fileName);

		// 1-3. File 내용물을 받기 위한 스트림 생성 ( 자동으로 스트림에 file 내용물이 채워짐 )
		BufferedInputStream bis = new BufferedInputStream(new FileInputStream(file));

		// 2. response 메시지의 header 설정 + 스트림
		// 2-1. header 설정
		String contentDp = "attachment;fileName=" + new String(URLEncoder.encode(fileName, "UTF-8")).replace("+", " ");
		// new String(URLEncoder.encode(fileName,"UTF-8")) : fileName 을 UTF-8 인코딩
		// ==> 안하면 한글 파일명 --> 'download' 이름으로 전달됨
		// replace("+", " ") : + 를 공백으로 변경
		// ==> 안하면 파일명에 공백 대신 + 가 나옴

		String contentLg = String.valueOf(file.length());
		response.setHeader("Content-Disposition", contentDp);
		response.setHeader("Content-Length", contentLg);// Content-Length:1004

		// 2-2. body 를 채울 스트림 생성
		BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());

		// 3. bis에 들어있는 데이터 ===> bos에 복사
		byte[] arr = new byte[(int) file.length()];
		bis.read(arr); // bis의 내용을 '읽어들여서' arr에 복사
		bos.write(arr); // bos에 arr의 내용을 '쓰기'

		// 4. 스트림 닫기
		bis.close();
		bos.close();
		return null;
	}
}
