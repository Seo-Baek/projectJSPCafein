package com.info.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.info.model.info.InfoDAO;

@WebServlet("/aa")
public class Info extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		InfoDAO dao = InfoDAO.getInstance();
		for (int i = 1; i < 20; i++) {
			String sql = "insert into info values(" + i + ", 'country', '', '', default, sysdate, '')";
			int r = dao.setSql(sql);
			System.out.println(r);
		}
		for (int i = 20; i < 46; i++) {
			String sql = "insert into info values(" + i + ", 'beans', '', '', default, sysdate, '')";
			int r = dao.setSql(sql);
			System.out.println(r);
		}
	}
}
