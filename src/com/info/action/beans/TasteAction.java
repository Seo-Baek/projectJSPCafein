package com.info.action.beans;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.info.action.Action;
import com.info.action.ActionForward;
import com.info.model.beans.QueDAO;

public class TasteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		PrintWriter out = response.getWriter();
		QueDAO dao = QueDAO.getInstance();
		dao.resetHit();
		int val[];
		if (request.getParameter("count") != null) {
			int count = Integer.parseInt(request.getParameter("count"));
			System.out.println(count);
			val = new int[count + 1];
			for (int i = 1; i <= count; i++) {
				String values = request.getParameter("que[" + i + "]");
				if (values != null) {
					val[i] = Integer.parseInt(values);
					dao.queHit(i, val[i]);
				}
			}

			Map<String, Integer> que = dao.setTable();
			HttpSession session = request.getSession();
			int mnum = session.getAttribute("mno") != null ? (int) session.getAttribute("mno") : -1;
			int result = dao.setque(mnum, que);

			out.println(result);
			out.close();

		}
		return null;
	}
}
