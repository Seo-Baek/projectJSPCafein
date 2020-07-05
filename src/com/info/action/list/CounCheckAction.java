package com.info.action.list;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.info.action.Action;
import com.info.action.ActionForward;
import com.info.model.info.InfoDAO;

public class CounCheckAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		PrintWriter out = response.getWriter();
		String name = request.getParameter("coun");
		
		// DB와 연동
		InfoDAO dao = InfoDAO.getInstance();
		int res = dao.check(name);
		
		out.println(res);
		out.close();
		return null;
	}
}
