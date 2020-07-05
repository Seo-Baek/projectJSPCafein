package com.info.model.user;


import java.util.ArrayList;
import java.util.List;

import com.info.model.DAO;
import com.info.model.DTO;

	/************************************ 
	 * 회원 광장의 전체적인 DAO를 관리하는 클래스 	*
	 ************************************/
public class SquareDAO extends DAO{

	// 객체 생성
	private static SquareDAO instance = new SquareDAO();
	
	// 기본 생성자 숨기기
	private SquareDAO() {  }
	
	// 싱글턴 객체 return
	public static SquareDAO getInstance() {
		if(instance == null) instance = new SquareDAO();
		return instance;
	}
	
	// 정보광장에 보여줄 공지사항을 가져오는 메소드
	public List<NoticeDTO> showNotice(){
		List<NoticeDTO> list = new ArrayList<NoticeDTO>();
		try {
			con = openConn();
			sql = "select * from noticeboard where board_show=? order by board_no desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, 1);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				NoticeDTO dto = new NoticeDTO();
				dto.setBoard_no(rs.getInt("board_no"));
				dto.setBoard_mno(rs.getInt("board_mno"));
				dto.setBoard_writer(rs.getString("board_writer"));
				dto.setBoard_title(rs.getString("board_title"));
				dto.setBoard_cont(rs.getString("board_cont"));
				dto.setBoard_file(rs.getString("board_file"));
				dto.setBoard_pwd(rs.getString("board_pwd"));
				dto.setBoard_hit(rs.getInt("board_hit"));
				dto.setBoard_init(rs.getString("board_init"));
				dto.setBoard_date(rs.getString("board_date"));
				dto.setBoard_show(rs.getInt("board_show"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConn(con, pstmt, rs);
		}
		return list;
	}	// showNotice() end 
	
	
	/****************************************
	 * -- 각 게시판에 해당하는 getList 메소드를    -- *
	 * -- 조건에 맞는 게시판을 불러오게끔                 -- *
	 * -- 하나로 묶어 작성함                                    -- *
	 * -- 조건값 @param mno, @param accept -- *
	 ****************************************/
	
	// 불러올 테이블에서 조건에 맞는 리스트들을 불러오는 메소드
	public List<DTO> getBaordList(int mno, int accept, int startNo, int endNo){
		List<DTO> list = new ArrayList<DTO>();
		try {
			con = openConn();
			if(mno == -1 && accept == -1) {
				sql = "select * from (select rownum ra, i.* from("+
						"select * from noticeboard order by board_no desc) i) "+
						"where ra >= ? and ra<=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, startNo);
				pstmt.setInt(2, endNo);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					NoticeDTO dto = new NoticeDTO();
					dto.setBoard_no(rs.getInt("board_no"));
					dto.setBoard_mno(rs.getInt("board_mno"));
					dto.setBoard_writer(rs.getString("board_writer"));
					dto.setBoard_title(rs.getString("board_title"));
					dto.setBoard_cont(rs.getString("board_cont"));
					dto.setBoard_file(rs.getString("board_file"));
					dto.setBoard_pwd(rs.getString("board_pwd"));
					dto.setBoard_hit(rs.getInt("board_hit"));
					dto.setBoard_init(rs.getString("board_init"));
					dto.setBoard_date(rs.getString("board_date"));
					dto.setBoard_show(rs.getInt("board_show"));
					list.add(dto);
				}
			} else {
				if(mno == -1) {
					sql = "select * from (select rownum ra, i.* from" + 
							"(select * "+
							"from infoboard where board_accept=1 "+ 
							"start with board_step=0 " + 
							"connect by prior board_no = board_parent " + 
							"order siblings by board_group desc, board_no desc ) i) where ra>=? and ra<=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, startNo);
					pstmt.setInt(2, endNo);
				} else if(accept == -1) {
					sql = "select * from (select rownum ra, i.* from(" + 
							"select *  " + 
							"from infoboard where board_mno = ?"+
							" order by board_no desc) i) where ra>=? and ra<=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, mno);
					pstmt.setInt(2, startNo);
					pstmt.setInt(3, endNo);
					
				} else if(mno <= 100 && accept == 0) {
					sql = "select * from (select rownum ra, i.* from(" + 
							"select * from infoboard where board_accept=0 "+
								"order by board_no asc, BOARD_INIT asc) i) "+
								"where ra>=? and ra<=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, startNo);
					pstmt.setInt(2, endNo);
				}
				rs = pstmt.executeQuery();
				while(rs.next()) {
					InfoDTO dto = new InfoDTO();
					dto.setBoard_no(rs.getInt("board_no"));
					dto.setBoard_title(rs.getString("board_title"));
					dto.setBoard_cont(rs.getString("board_cont"));
					dto.setBoard_file(rs.getString("board_file"));
					dto.setBoard_pwd(rs.getString("board_pwd"));
					dto.setBoard_hit(rs.getInt("board_hit"));
					dto.setBoard_init(rs.getString("board_init"));
					dto.setBoard_accept(rs.getInt("board_accept"));
					dto.setBoard_date(rs.getString("board_date"));
					dto.setBoard_parent(rs.getInt("board_parent"));
					dto.setBoard_group(rs.getInt("board_group"));
					dto.setBoard_step(rs.getInt("board_step"));
					dto.setBoard_writer(rs.getString("board_writer"));
					list.add(dto);
				}		
			} 	//첫번째 if - else end
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConn(con, pstmt, rs);
		}
		
		return list;
	}	// getBoardList() end
	
	// 페이징 처리할 게시판의 게시물의 수를 받아오는 메소드
	public int getInfoCount(int mno, int accept) {
		int count = 0;
		try {
			con = openConn();
			if(mno == -1 && accept == 1) {
				sql = "select count(*) from infoboard where board_accept = 1";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					count = rs.getInt(1);
				}
			} else if(mno > 100 && accept == -1) {
				sql = "select count(*) from infoboard where board_mno = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, mno);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					count = rs.getInt(1);
				}
			}  else if(mno <= 100 && accept == 0) {
				sql = "select count(*) from infoboard where board_accept = 0";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					count = rs.getInt(1);
				}
			} else if(mno == -1 && accept == -1) {
				sql = "select count(*) from noticeboard";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					count = rs.getInt(1);
				}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(con, pstmt, rs);
		}
		return count;
	}	//getInfoCount() end
		
	
	/************************************
	 * -- 정보광장 게시판에 사용되는 DAO 작성 -- *
	 ************************************/
	
	// 이전글, 다음글을 불러오는 메소드
	public List<InfoDTO> getPreNextCont(int board_no) {
		List<InfoDTO> list = new ArrayList<InfoDTO>();
		try {
			int req = 0;
			int pre = 0;
			int next = 0;
			con = openConn();
			
			sql = "select board_group from infoboard where board_no = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board_no);
			rs = pstmt.executeQuery();
			if(rs.next())
				req = rs.getInt(1);
			// 이전 그룹번호 받아오기
			sql = "select max(board_group) from (select * from infoboard where board_accept=1)"+
					"where board_group < ? and board_step=0";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, req);
			rs = pstmt.executeQuery();
			if(rs.next()) 
				pre = rs.getInt(1);
			// 다음 그룹번호 받아오기
			sql = "select min(board_group) from (select * from infoboard where board_accept=1)"
					+"where board_group > ? and board_step=0";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, req);
			rs = pstmt.executeQuery();
			if(rs.next())
				next = rs.getInt(1);
			
			if(pre == 0 || next == 0) {
				sql = "select * from infoboard "+
						"where board_group = ? and board_step = 0";
				pstmt = con.prepareStatement(sql);
				if(pre == 0 && next != 0)
					pstmt.setInt(1, next);
				else if(pre != 0 && next == 0)
					pstmt.setInt(1, pre);
			} else if(next != 0 && pre != 0) {
				sql = "select * from (select * from infoboard where board_step = 0) "+
						"where board_group = ? or board_group = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, next);
				pstmt.setInt(2, pre);
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				InfoDTO dto = new InfoDTO();
				dto.setBoard_no(rs.getInt("board_no"));
				dto.setBoard_title(rs.getString("board_title"));
				dto.setBoard_cont(rs.getString("board_cont"));
				dto.setBoard_file(rs.getString("board_file"));
				dto.setBoard_pwd(rs.getString("board_pwd"));
				dto.setBoard_hit(rs.getInt("board_hit"));
				dto.setBoard_init(rs.getString("board_init"));
				dto.setBoard_accept(rs.getInt("board_accept"));
				dto.setBoard_date(rs.getString("board_date"));
				dto.setBoard_parent(rs.getInt("board_parent"));
				dto.setBoard_group(rs.getInt("board_group"));
				dto.setBoard_step(rs.getInt("board_step"));
				dto.setBoard_writer(rs.getString("board_writer"));
				list.add(dto);
				System.out.println("받은 번호 : " + dto.getBoard_no());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConn(con, pstmt, rs);
		}
		return list;
	}
	
	// 검색 조건에 맞춰 테이블의 row 갯수를 출력하는 메소드
	public int getInfoSearchCount(String req_box, String req_text) {
		int count = 0;
		try {
			con = openConn();
			if(req_box.equals("title")) {
				sql = "select count(*) from infoboard " +
						"where board_accept = 1 and "+
						"board_title like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+req_text+"%");
			} else if(req_box.equals("writer")) {
				sql = "select count(*) from infoboard " +
						"where board_accept = 1 and " +
						"board_writer like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+req_text+"%");
			} else if(req_box.equals("cont")) {
				sql = "select count(*) from infoboard " +
						"where board_accept = 1 and " +
						"board_cont like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+req_text+"%");
				
			} else if(req_box.equals("title+cont")) {
				sql = "select count(*) from infoboard " +
						"where board_accept = 1 and " +
						"board_cont like ? or " +
						"board_title like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+req_text+"%");				
				pstmt.setString(2, "%"+req_text+"%");				
			}
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConn(con, pstmt, rs);
		}
		return count;
	}
	
	// 검색 조건에 맞는 리스트를 반환하는 메소드
	public List<InfoDTO> getSearchList
	  (int startNo, int endNo, String req_box, String req_text) {
		List<InfoDTO> list = new ArrayList<InfoDTO>();
		try {
			con = openConn();
			if(req_box.equals("title")) {
				sql = "select * from infoboard " +
						"where board_accept = 1 and "+
						"board_title like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+req_text+"%");
			} else if(req_box.equals("writer")) {
				sql = "select * from infoboard " +
						"where board_accept = 1 and " +
						"board_writer like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+req_text+"%");
			} else if(req_box.equals("cont")) {
				sql = "select * from infoboard " +
						"where board_accept = 1 and " +
						"board_cont like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+req_text+"%");
				
			} else if(req_box.equals("title+cont")) {
				sql = "select * from infoboard " +
						"where board_accept = 1 and " +
						"board_cont like ? or " +
						"board_title like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+req_text+"%");				
				pstmt.setString(2, "%"+req_text+"%");				
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				InfoDTO dto = new InfoDTO();
				dto.setBoard_no(rs.getInt("board_no"));
				dto.setBoard_title(rs.getString("board_title"));
				dto.setBoard_cont(rs.getString("board_cont"));
				dto.setBoard_file(rs.getString("board_file"));
				dto.setBoard_pwd(rs.getString("board_pwd"));
				dto.setBoard_hit(rs.getInt("board_hit"));
				dto.setBoard_init(rs.getString("board_init"));
				dto.setBoard_accept(rs.getInt("board_accept"));
				dto.setBoard_date(rs.getString("board_date"));
				dto.setBoard_parent(rs.getInt("board_parent"));
				dto.setBoard_group(rs.getInt("board_group"));
				dto.setBoard_step(rs.getInt("board_step"));
				dto.setBoard_writer(rs.getString("board_writer"));
				list.add(dto);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConn(con, pstmt, rs);
		}
		return list;
	}
	
	
	// infoboard 테이블에 작성한 글 저장
	public int uploadBoard(InfoDTO dto) {
		int result = 0;
		try {
			int maxNo = 0;
			con = openConn();
			sql = "select max(board_no) from infoboard";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) 
				maxNo = rs.getInt(1);
			
			// 실제 DB 저장
			if(dto.getBoard_group() == 0) 
				dto.setBoard_group(maxNo+1);
			
			sql = "insert into infoboard values(?,?,?,?,?,?,default,"
					+"sysdate,default,default,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, maxNo+1);
			pstmt.setInt(2, dto.getBoard_mno());
			pstmt.setString(3, dto.getBoard_title());
			pstmt.setString(4, dto.getBoard_cont());
			pstmt.setString(5, dto.getBoard_file());
			pstmt.setString(6, dto.getBoard_pwd());
			pstmt.setInt(7, dto.getBoard_parent());
			pstmt.setInt(8, dto.getBoard_group());
			pstmt.setInt(9, dto.getBoard_step());
			pstmt.setString(10, dto.getBoard_writer());
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConn(con, pstmt, rs);
		}
		return result;
	}	//uploadBoard() end
	
	// 글번호에 해당하는 게시글의 조회수를 +1 해주는 메소드
	public void add1ToHit(int board_no) {
		try {
			con = openConn();
			sql = "update infoboard set board_hit = board_hit+1 where board_no = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board_no);
			pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(con, pstmt, rs);
		}
		
	}
	
	// 글번호에 해당하는 게시글을 infoboard에서 넘겨주는 메소드
	public InfoDTO getInfoContent(int board_no) {
		InfoDTO dto = new InfoDTO();
		try {
			con = openConn();
			sql = "select * from infoboard where board_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board_no);
			rs = pstmt.executeQuery();
			MemberDAO dao = MemberDAO.getInstance();
			if(rs.next()) {
				dto.setBoard_no(rs.getInt("board_no"));
				dto.setBoard_mno(rs.getInt("board_mno"));
				dto.setBoard_title(rs.getString("board_title"));
				dto.setBoard_cont(rs.getString("board_cont"));
				dto.setBoard_file(rs.getString("board_file"));
				dto.setBoard_pwd(dao.getUserPwd(dto.getBoard_mno()));
				dto.setBoard_hit(rs.getInt("board_hit"));
				dto.setBoard_init(rs.getString("board_init"));
				dto.setBoard_accept(rs.getInt("board_accept"));
				dto.setBoard_date(rs.getString("board_date"));
				dto.setBoard_parent(rs.getInt("board_parent"));
				dto.setBoard_group(rs.getInt("board_group"));
				dto.setBoard_step(rs.getInt("board_step"));
				dto.setBoard_writer(rs.getString("board_writer"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConn(con, pstmt, rs);
		}
		return dto;
	}	//getInfoCont() end
	
	//글 번호에 맞는 게시글을 수정하는 메소드
	public int updateBoard(InfoDTO dto) {
		int result = 0;
		try {
			if(dto.getBoard_file() == "") {
				con = openConn();
				sql = "select board_file from infoboard where board_no=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, dto.getBoard_no());
				rs = pstmt.executeQuery();
				if(rs.next()) {
					dto.setBoard_file(rs.getString("board_file"));
				}
			}
			con = openConn();
			sql = "update infoboard set board_title=?, board_cont=?, "+
					"board_writer=?, board_pwd=?, board_file=? where board_no =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getBoard_title());
			pstmt.setString(2, dto.getBoard_cont());
			pstmt.setString(3, dto.getBoard_writer());
			pstmt.setString(4, dto.getBoard_pwd());
			pstmt.setString(5, dto.getBoard_file());
			pstmt.setInt(6, dto.getBoard_no());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConn(con, pstmt, rs);
		}
		return result;
	}	//updateBoard() end
	
	//글 번호에 맞는 게시글을 삭제문구로 수정하는 메소드
	public int deleteInfoCont(int board_no) {
		int result = 0;
		try {
			con = openConn();
			sql = "update infoboard set board_writer='' "+
					", board_title='삭제된 게시글입니다.', board_file='', board_hit=0,board_mno=-1 where board_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board_no);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConn(con, pstmt, rs);
		}
		return result;
	}	// deleteInfoCont() end

	
	
	
	/************************************
	 * --  대기글 게시판에 사용되는 DAO 작성  -- *
	 ************************************/
	
	
	// 글번호에 맞는 대기글을 가져오는 메소드는 getInfoContent()로 대체

	
	// 글번호에 맞는 대기글을 수정하는 메소드
	public int updateCheck(int board_no, String title, String cont) {
		int result = 0;
		try {
			con = openConn();
			sql = "update infoboard set board_title = ?, board_cont = ? where board_no = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, cont);
			pstmt.setInt(3, board_no);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConn(con, pstmt, rs);
		}
		return result;
	}	// updateCheck() end
	
	// 글번호에 맞는 대기글을 게시 허가하는 메소드
	
	public int allowCont(int board_no, String title, String cont) {
		int result = 0;
		try {
			con = openConn();
			sql = "update infoboard set board_title = ?, board_cont = ?, board_accept = 1"+
					", board_date=sysdate where board_no = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, cont);
			pstmt.setInt(3, board_no);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConn(con, pstmt, rs);
		}
		return result;
	}	// allowCont() end

	
	
	/************************************
	 * --   마이 리스트에 사용되는 DAO 작성    -- *
	 ************************************/
	
	// 허가 되지 않은 게시글을 완전히 삭제처리하는 메소드
	public int realDeleteCont(int board_no) {
		int result = 0;
		try {
			con = openConn();
			sql = "delete from infoboard where board_no = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board_no);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConn(con, pstmt, rs);
		}
		return result;
	}	// realDeleteCont() end

	
	// 조건에 맞게 리스트를 가져오는 메소드
	public List<InfoDTO> getSearchWaitList(int mno, int startNo, int endNo, String req_box, String req_text) {
		List<InfoDTO> list = new ArrayList<InfoDTO>();
		try {
			con = openConn();
			if(req_box.equals("title")) {
				sql = "select * from infoboard " +
						"where board_mno = ? and "+
						"board_title like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, mno);
				pstmt.setString(2, "%"+req_text+"%");
			} else if(req_box.equals("writer")) {
				sql = "select * from infoboard " +
						"where board_mno = ? and " +
						"board_writer like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, mno);
				pstmt.setString(2, "%"+req_text+"%");
			} else if(req_box.equals("cont")) {
				sql = "select * from infoboard " +
						"where board_mno=? and " +
						"board_cont like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, mno);
				pstmt.setString(2, "%"+req_text+"%");
				
			} else if(req_box.equals("title+cont")) {
				sql = "select * from infoboard " +
						"where board_mno=? and " +
						"board_cont like ? or " +
						"board_title like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, mno);
				pstmt.setString(2, "%"+req_text+"%");				
				pstmt.setString(3, "%"+req_text+"%");				
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				InfoDTO dto = new InfoDTO();
				dto.setBoard_no(rs.getInt("board_no"));
				dto.setBoard_title(rs.getString("board_title"));
				dto.setBoard_cont(rs.getString("board_cont"));
				dto.setBoard_file(rs.getString("board_file"));
				dto.setBoard_pwd(rs.getString("board_pwd"));
				dto.setBoard_hit(rs.getInt("board_hit"));
				dto.setBoard_init(rs.getString("board_init"));
				dto.setBoard_accept(rs.getInt("board_accept"));
				dto.setBoard_date(rs.getString("board_date"));
				dto.setBoard_parent(rs.getInt("board_parent"));
				dto.setBoard_group(rs.getInt("board_group"));
				dto.setBoard_step(rs.getInt("board_step"));
				dto.setBoard_writer(rs.getString("board_writer"));
				list.add(dto);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConn(con, pstmt, rs);
		}
		return list;
	}	// getSearchWaitList() end

	
	// 조건에 맞는 리스트의 갯수를 구하는 메소드
	public int getWSearchCount(int mno , String req_box, String req_text) {
		int count = 0;
		try {
			con = openConn();
			if(req_box.equals("title")) {
				sql = "select count(*) from infoboard " +
						"where board_mno=? and "+
						"board_title like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, mno);
				pstmt.setString(2, "%"+req_text+"%");
			} else if(req_box.equals("cont")) {
				sql = "select count(*) from infoboard " +
						"where board_mno = ? and " +
						"board_cont like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, mno);
				pstmt.setString(2, "%"+req_text+"%");
				
			} else if(req_box.equals("title+cont")) {
				sql = "select count(*) from infoboard " +
						"where board_mno = ? and " +
						"board_cont like ? or " +
						"board_title like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, mno);
				pstmt.setString(2, "%"+req_text+"%");				
				pstmt.setString(3, "%"+req_text+"%");				
			}
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConn(con, pstmt, rs);
		}
		return count;
	}	// getWSearchCount() end

	
	
	/************************************
	 * -- 공지사항 게시판에 사용되는 DAO 작성 -- *
	 ************************************/
	
	// 글번호에 맞는 공지사항을 가져오는 메소드
	public NoticeDTO getNoticeContent(int board_no) {
		NoticeDTO dto = new NoticeDTO();
		try {
			con = openConn();
			sql = "select * from noticeboard where board_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board_no);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setBoard_no(rs.getInt("board_no"));
				dto.setBoard_mno(rs.getInt("board_mno"));
				dto.setBoard_writer(rs.getString("board_writer"));
				dto.setBoard_title(rs.getString("board_title"));
				dto.setBoard_cont(rs.getString("board_cont"));
				dto.setBoard_file(rs.getString("board_file"));
				dto.setBoard_pwd(rs.getString("board_pwd"));
				dto.setBoard_hit(rs.getInt("board_hit"));
				dto.setBoard_init(rs.getString("board_init"));
				dto.setBoard_date(rs.getString("board_date"));
				dto.setBoard_show(rs.getInt("board_show"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConn(con, pstmt, rs);
		}
		return dto;
	}	// getNoticeContent() end

	// 공지사항 게시판에 글을 등록하는 메소드
	public int uploadNotice(NoticeDTO dto) {
		int result = 0;
		try {
			int max = 0;
			con = openConn();
			sql = "select max(board_no) from noticeboard";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next())
				max = rs.getInt(1)+1;
			
			sql = "insert into noticeboard "+
					"values(?,?,?,?,?,?,?,default,sysdate,default,0)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, max);
			pstmt.setInt(2, dto.getBoard_mno());
			pstmt.setString(3, dto.getBoard_writer());
			pstmt.setString(4, dto.getBoard_title());
			pstmt.setString(5, dto.getBoard_cont());
			pstmt.setString(6, dto.getBoard_file());
			pstmt.setString(7, dto.getBoard_pwd());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConn(con, pstmt, rs);
		}
		return result;
	}	// uploadNotice() end

	
	// 공지사항을 수정하는 메소드
	public int uploadToInfo(NoticeDTO dto) {
		int result = 0;
		System.out.println(result);
		try {
			int count = 0;
			con = openConn();
			if(dto.getBoard_show() == 1) {
				sql = "select count(*) from noticeboard where board_show = 1";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					count = rs.getInt(1);
					System.out.println(count);
				}
				if(count >= 5) {
					return -1;
				}
			}
			sql = "update noticeboard "+
					"set board_mno=?,board_writer=?,board_title=?,"+
					"board_cont=?,board_file=?,board_pwd=?,board_date=sysdate,"+
					"board_show=? where board_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, dto.getBoard_mno());
			pstmt.setString(2, dto.getBoard_writer());
			pstmt.setString(3, dto.getBoard_title());
			pstmt.setString(4, dto.getBoard_cont());
			pstmt.setString(5, dto.getBoard_file());
			pstmt.setString(6, dto.getBoard_pwd());
			pstmt.setInt(7, dto.getBoard_show());
			pstmt.setInt(8, dto.getBoard_no());
			
			result = pstmt.executeUpdate();
			System.out.println(result);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConn(con, pstmt, rs);
		}
		return result;
	}	// uploadToInfo() end
	
	
	
	
	
}
