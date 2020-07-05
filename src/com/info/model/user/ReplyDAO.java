package com.info.model.user;

import java.util.ArrayList;
import java.util.List;

import com.info.model.DAO;


public class ReplyDAO extends DAO{
	
		// 싱글턴 객체 만들기
		// 1. 싱글턴 객체를 만들 때는, 우선적으로 접근지정자는 private으로 선언한다.
		// 2. 정적 멤버로 선언한다. - static으로 선언을 한다.
		private static ReplyDAO instance = new ReplyDAO();
		
		// 3. 기본 생성자는 외부에서 접근이 불가능하도록 해야한다. - private으로 생성자 만듬. 
		//    외부에서 new를 사용하지 못하게 하는 접근 기법.
		private ReplyDAO() {}
		
		// 4. 생성자 대신에 싱글턴 객체를  return 해 주는 getInstance() 메소드를 만들어 주자.
		public static ReplyDAO getInstance() {
			if(instance == null) {
				instance = new ReplyDAO();
			}
			return instance;
		}
		
		// reply 테이블에서 댓글 목록을 받아오는 메소드
		public List<ReplyDTO> getReply(String category, int info_no){
			List<ReplyDTO> list = new ArrayList<ReplyDTO>();
			try {
				con = openConn();
				sql = "select * from info_reply where r_category = ? and info_no=? "+
						"start with dep = 0 "+
						"connect by prior rep_num = parentnum "+
						"order siblings by regdate";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, category);
				pstmt.setInt(2, info_no);
				rs = pstmt.executeQuery();
				MemberDAO dao = MemberDAO.getInstance();
				while(rs.next()) {
					ReplyDTO dto = new ReplyDTO();
					dto.setRep_num(rs.getInt("rep_num"));
					dto.setInfo_no(rs.getInt("info_no"));
					dto.setCont(rs.getString("cont"));
					dto.setWriternum(rs.getInt("writernum"));
					dto.setDep(rs.getInt("dep"));
					dto.setParentnum(rs.getInt("parentnum"));
					dto.setR_category(rs.getString("r_category"));
					dto.setWriter(dao.getUserName(dto.getWriternum()));
					list.add(dto);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				closeConn(con, pstmt, rs);
			}
			return list;
		}	//getReply() end
		
		// 선택한 댓글번호에 해당하는 댓글 호출
		public String getRepCont(int rep_num) {
			String cont = null;
			try {
				con = openConn();
				sql = "select cont from info_reply where rep_num = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, rep_num);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					cont = rs.getString(1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				closeConn(con, pstmt, rs);
			}
			return cont;
		}
		
		// 댓글번호에 맞는 댓글 수정
		public int updateReply(int rep_num, String cont) {
			int result = 0;
			try {
				con = openConn();
				sql = "update info_reply set cont=? where rep_num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, cont);
				pstmt.setInt(2, rep_num);
				result = pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				closeConn(con, pstmt, rs);
			}
			return result;
		}	// updateReply() end
		
		// 댓글 번호에 맞는 댓글을 삭제 용도 수정하는 메소드
		public int deleteRep(int rep_num) {
			System.out.println("진입성공~~");
			int result = 0;
			try {
				con = openConn();
				sql = "update info_reply set cont='삭제된 댓글입니다.', writernum=-1 where rep_num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, rep_num);
				result = pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				closeConn(con, pstmt, rs);
			}
			System.out.println(result);
			return result;
		}	// deleteRep() end
		
		// 댓글을 추가하는 메소드
		public int insertRep(ReplyDTO dto) {
			int result = 0;
			try {
				int max = 0;
				int dep = 0;
				con = openConn();
				sql = "select max(rep_num) from info_reply";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					max = rs.getInt(1);
				}
				if(dto.getParentnum() != 0) {
					sql = "select dep from info_reply where rep_num = ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, dto.getParentnum());
					rs = pstmt.executeQuery();
					if(rs.next()) {
						dep = rs.getInt(1)+1;
					}
				}
				sql = "insert into info_reply values(?,?,?,?,?,?,sysdate,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, max+1);
				pstmt.setInt(2, dto.getInfo_no());
				pstmt.setString(3, dto.getCont());
				pstmt.setInt(4, dto.getWriternum());
				pstmt.setInt(5, dep);
				pstmt.setInt(6, dto.getParentnum());
				pstmt.setString(7, dto.getR_category());
				result = pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				closeConn(con, pstmt, rs);
			}
			System.out.println("결과값"+result);
			return result;
		}	// insertRep() end
}
