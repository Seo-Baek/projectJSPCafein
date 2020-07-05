package com.info.action.beans;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.info.action.Action;
import com.info.action.ActionForward;
import com.info.model.beans.QueDAO;
import com.info.model.beans.QueMDTO;
import com.info.model.info.BeansDTO;

public class BeansListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		QueDAO dao = QueDAO.getInstance();
		String no = request.getParameter("q_no");
		if (no != null) {
			int mno = Integer.parseInt(no);
			QueMDTO dto = dao.queDTO(mno);
			int[] arr = {dto.getBeans_acidity(), dto.getBeans_aroma(), dto.getBeans_bitter(), dto.getBeans_bitter(), dto.getBeans_body(), dto.getBeans_sweet()};
			
			int max = arr[0];
			
			for(int i=0;i<arr.length;i++) {
			    if(max<arr[i]) {
				//max의 값보다 array[i]이 크면 max = array[i]
				max = arr[i];
			    }
				
			}
			
			String nowPage = request.getParameter("page");
			HttpSession session = request.getSession();
			int mnum = session.getAttribute("mno") != null ? (int) session.getAttribute("mno") : -1;

			if (mnum != -1) {
				List<QueMDTO> list = tastePaging(request, mnum, nowPage);
				request.setAttribute("list", list);
			}
			
			dao.updateV(dto, max);
			dto = dao.queMDTO(mno);
			List<BeansDTO> list = dao.beansList(dto);
			request.setAttribute("beanslist", list);
			
			ActionForward forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("./beans/taste_list.jsp");
			return forward;

		}

		return null;
	}
}
