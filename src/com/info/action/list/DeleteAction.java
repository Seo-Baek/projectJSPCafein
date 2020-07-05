package com.info.action.list;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.info.action.Action;
import com.info.action.ActionForward;
import com.info.model.info.InfoDAO;

public class DeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		PrintWriter out = response.getWriter();
		String no = request.getParameter("no");
		String genre = request.getParameter("genre");
		if (no != null) {
			int info_no = Integer.parseInt(no);
			InfoDAO dao = InfoDAO.getInstance();
			int result = dao.deleteCont(info_no, genre);
			
			out.print(result);
			out.close();
		}
		return null;
	}
}
