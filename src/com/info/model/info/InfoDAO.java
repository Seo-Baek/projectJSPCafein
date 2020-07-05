package com.info.model.info;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.info.model.DAO;
import com.info.model.DTO;
import com.info.model.member.MemberDAO;

public class InfoDAO extends DAO {

	private static InfoDAO instance = new InfoDAO();

	private InfoDAO() {
	}

	public static InfoDAO getInstance() {
		if (instance == null) {
			instance = new InfoDAO();
		}
		return instance;
	}

	/**
	 * 게시물 종류에 따른 게시글 리스트 가져오기 + paging
	 * @param info_genre
	 * @param start
	 * @param end
	 * @return 게시글 리스트
	 */
	public List<InfoDTO> infoList(String info_genre, int start, int end) {
		List<InfoDTO> list = new ArrayList<>();
		try {
			con = openConn();
			sql = "select * from (select p.*, row_number() over(order by info_no desc) rnum from info_v p where info_genre like ?) where rnum between ? and ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + info_genre + "%");
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				InfoDTO dto = new InfoDTO();
				dto.setInfo_no(rs.getInt("info_no"));
				dto.setInfo_genre(rs.getString("info_genre"));
				dto.setInfo_title(rs.getString("info_title"));
				dto.setInfo_hit(rs.getInt("info_hit"));
				dto.setInfo_date(rs.getString("info_date"));
				dto.setInfo_file(rs.getString("info_file"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConn(con, pstmt, rs);
		}
		return list;
	}
	
	/**
	 * 검색 시 게시물 종류에 따른 게시글 리스트 가져오기 + paging
	 * @param find_name
	 * @param start
	 * @param end
	 * @return 게시글 리스트
	 */
	public List<InfoDTO> searchList(String find_name, int start, int end) {
		List<InfoDTO> list = new ArrayList<>();
		try {
			con = openConn();
			sql = "select * from (select p.*, row_number() over(order by info_no desc) rnum from info_v p where info_title like ?) where rnum between ? and ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + find_name + "%");
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				InfoDTO dto = new InfoDTO();
				dto.setInfo_no(rs.getInt("info_no"));
				dto.setInfo_genre(rs.getString("info_genre"));
				dto.setInfo_title(rs.getString("info_title"));
				dto.setInfo_hit(rs.getInt("info_hit"));
				dto.setInfo_date(rs.getString("info_date"));
				dto.setInfo_file(rs.getString("info_file"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConn(con, pstmt, rs);
		}
		return list;
	}

	/**
	 * 페이징 처리를 위한 게시글 수 체크
	 * @param info_genre
	 * @return 게시글 수
	 */
	public int getCount(String info_genre) {
		int count = 0;
		try {
			con = openConn();
			sql = "select count(*) from info where info_genre like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + info_genre + "%");
			rs = pstmt.executeQuery();

			while (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConn(con, pstmt, rs);
		}
		return count;
	}
	
	/**
	 * 검색 시 페이징 처리를 위한 게시글 수 체크
	 * @param find_name
	 * @return 게시글 수
	 */
	public int getSearchCount(String find_name) {
		int count = 0;
		try {
			con = openConn();
			sql = "select count(*) from info_v where info_title like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + find_name + "%");
			rs = pstmt.executeQuery();

			while (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConn(con, pstmt, rs);
		}
		return count;
	}

	/**
	 * 나라번호와 나라이름 가져오기
	 * @return HashMap<나라번호, 나라이름>
	 */
	public Map<Integer, String> getcountry() {
		Map<Integer, String> coun = new HashMap<>();
		try {
			con = openConn();
			sql = "select * from country";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int coun_no = rs.getInt("coun_no");
				String info_title = rs.getString("info_title");
				coun.put(coun_no, info_title);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConn(con, pstmt, rs);
		}
		return coun;
	}

	/**
	 * 새로운 나라생성시 번호 부여를 위한 대륙마다 나라수 체크
	 * @return HashMap<대륙이름, 나라수>
	 */
	public Map<String, Integer> getcounCount() {
		Map<String, Integer> coun = new HashMap<>();
		try {
			con = openConn();
			sql = "select coun_7, count(*) count from country group by coun_7";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String coun_7 = rs.getString("coun_7");
				int count = rs.getInt("count");
				coun.put(coun_7, count);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConn(con, pstmt, rs);
		}
		return coun;
	}

	/**
	 * 나라등록시 중복된 나라 등록을 방지하기위한 체크 메서드
	 * @param name
	 * @return 중복된 나라인 경우 return 1;
	 */
	public int check(String name) {
		int result = 0;
		try {
			con = openConn();
			sql = "select info_title from country where info_title=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, name);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConn(con, pstmt, rs);
		}
		return result;
	}

	/**
	 * 게시물 종류에 따른 게시글 상세 내용 가져오기
	 * @param info_no
	 * @param info_genre
	 * @return 해당 종류의 게시물 DTO
	 */
	public DTO getDto(int info_no, String info_genre) {
		DTO dto = null;
		try {
			con = openConn();
			switch (info_genre) {
			case "beans":
				dto = new BeansDTO();
				sql = "select * from " + info_genre + "_v where info_no=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, info_no);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					((BeansDTO) dto).setInfo_no(rs.getInt("info_no"));
					((BeansDTO) dto).setCoun_no(rs.getInt("Coun_no"));
					((BeansDTO) dto).setBeans_coun(rs.getString("beans_coun"));
					((BeansDTO) dto).setBeans_counadd(rs.getString("beans_counadd"));
					((BeansDTO) dto).setBeans_aroma(rs.getInt("beans_aroma"));
					((BeansDTO) dto).setBeans_acidity(rs.getInt("beans_acidity"));
					((BeansDTO) dto).setBeans_sweet(rs.getInt("beans_sweet"));
					((BeansDTO) dto).setBeans_bitter(rs.getInt("beans_bitter"));
					((BeansDTO) dto).setBeans_body(rs.getInt("beans_body"));
					((BeansDTO) dto).setInfo_title(rs.getString("info_title"));
					((BeansDTO) dto).setInfo_cont(rs.getString("info_cont"));
					((BeansDTO) dto).setInfo_file(rs.getString("info_file"));
				}
				break;
			case "country":
				dto = new CountryDTO();
				sql = "select * from " + info_genre + " where info_no=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, info_no);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					((CountryDTO) dto).setInfo_no(rs.getInt("info_no"));
					((CountryDTO) dto).setCoun_no(rs.getInt("coun_no"));
					((CountryDTO) dto).setCoun_7(rs.getString("coun_7"));
					((CountryDTO) dto).setCoun_add(rs.getString("coun_add"));
					((CountryDTO) dto).setInfo_title(rs.getString("info_title"));
					((CountryDTO) dto).setInfo_cont(rs.getString("info_cont"));
					((CountryDTO) dto).setInfo_file(rs.getString("info_file"));
				}
				break;
			case "extra":
				dto = new ExtraDTO();
				sql = "select * from " + info_genre + " where info_no=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, info_no);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					((ExtraDTO) dto).setInfo_no(rs.getInt("info_no"));
					((ExtraDTO) dto).setExtra_genre(rs.getString("extra_genre"));
					((ExtraDTO) dto).setInfo_title(rs.getString("info_title"));
					((ExtraDTO) dto).setInfo_cont(rs.getString("info_cont"));
					((ExtraDTO) dto).setInfo_file(rs.getString("info_file"));
				}
				break;
			default:
				dto = new InfoDTO();
				sql = "select * from " + info_genre + " where info_no=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, info_no);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					((InfoDTO) dto).setInfo_no(rs.getInt("info_no"));
					((InfoDTO) dto).setInfo_genre(rs.getString("info_genre"));
					((InfoDTO) dto).setInfo_title(rs.getString("info_title"));
					((InfoDTO) dto).setInfo_cont(rs.getString("info_cont"));
					((InfoDTO) dto).setInfo_hit(rs.getInt("info_hit"));
					((InfoDTO) dto).setInfo_date(rs.getString("info_date"));
					((InfoDTO) dto).setInfo_file(rs.getString("info_file"));
				}
				break;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConn(con, pstmt, rs);
		}
		return dto;
	}

	/**
	 * 게시글 조회수 증가
	 * @param info_no
	 */
	public void infoHit(int info_no) {
		try {
			con = openConn();
			sql = "update info set info_hit = info_hit + 1 where info_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, info_no);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConn(con, pstmt, rs);
		}
	}

	/**
	 * 게시물 종류에 따른 게시글 추가
	 * @param info_genre
	 * @param dto
	 * @return 게시글 추가 성공시 return 1;
	 */
	public int wirteCommit(String info_genre, DTO dto) {
		int result = 0;
		boolean commit = false;
		sql = "insert into " + info_genre + " values(info_seq.nextval, ";
		try {
			con = openConn();
			switch (info_genre) {
			case "beans":
				sql += "	?, ?, ?, ?, ?, ?, ?, ?, ?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, ((BeansDTO) dto).getCoun_no());
				pstmt.setInt(2, ((BeansDTO) dto).getBeans_aroma());
				pstmt.setInt(3, ((BeansDTO) dto).getBeans_acidity());
				pstmt.setInt(4, ((BeansDTO) dto).getBeans_sweet());
				pstmt.setInt(5, ((BeansDTO) dto).getBeans_bitter());
				pstmt.setInt(6, ((BeansDTO) dto).getBeans_body());
				pstmt.setString(7, ((BeansDTO) dto).getInfo_title());
				pstmt.setString(8, ((BeansDTO) dto).getInfo_cont());
				pstmt.setString(9, ((BeansDTO) dto).getInfo_file());
				rs = pstmt.executeQuery();
				if (rs.next()) {
					commit = true;
				}
				break;
			case "country":
				sql += "	?, ?, ?, ?, ?, ?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, ((CountryDTO) dto).getCoun_no());
				pstmt.setString(2, ((CountryDTO) dto).getCoun_7());
				pstmt.setString(3, ((CountryDTO) dto).getCoun_add());
				pstmt.setString(4, ((CountryDTO) dto).getInfo_title());
				pstmt.setString(5, ((CountryDTO) dto).getInfo_cont());
				pstmt.setString(6, ((CountryDTO) dto).getInfo_file());

				rs = pstmt.executeQuery();
				if (rs.next()) {
					commit = true;
				}
				break;
			case "extra":
				sql += "	?, ?, ?, ?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, ((ExtraDTO) dto).getExtra_genre());
				pstmt.setString(2, ((ExtraDTO) dto).getInfo_title());
				pstmt.setString(3, ((ExtraDTO) dto).getInfo_cont());
				pstmt.setString(4, ((ExtraDTO) dto).getInfo_file());

				rs = pstmt.executeQuery();
				if (rs.next()) {
					commit = true;
				}
				break;
			default:
				sql += "	?, ?, ?, default, sysdate, ?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, info_genre);
				pstmt.setString(2, ((InfoDTO) dto).getInfo_title());
				pstmt.setString(3, ((InfoDTO) dto).getInfo_cont());
				pstmt.setString(4, ((InfoDTO) dto).getInfo_file());
				rs = pstmt.executeQuery();
				if (rs.next()) {
					commit = true;
				}
				break;
			}
			if (commit == true) {
				if (!info_genre.equals("info")) {
					sql = "insert into info (info_no, info_genre, info_hit, info_date) values(info_seq.currval, ?, default, sysdate)";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, info_genre);
					rs = pstmt.executeQuery();
					if (rs.next()) {
						result = 1;
					}

				} else {
					result = 1;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConn(con, pstmt, rs);
		}
		return result;
	}

	/**
	 * 게시글 수정하기
	 * @param info_no
	 * @param info_genre
	 * @param dto
	 * @return 성공 시 return 1;
	 */
	public int updateDTO(int info_no, String info_genre, DTO dto) {
		int result = 0;
		sql = "update " + info_genre + " set ";
		try {
			con = openConn();
			switch (info_genre) {
			case "beans":
				sql += "	coun_no=?, beans_aroma=?, beans_acidity=?, beans_sweet=?, beans_bitter=?, beans_body=?, info_title=?, info_cont=?, info_file=? where info_no = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, ((BeansDTO) dto).getCoun_no());
				pstmt.setInt(2, ((BeansDTO) dto).getBeans_aroma());
				pstmt.setInt(3, ((BeansDTO) dto).getBeans_acidity());
				pstmt.setInt(4, ((BeansDTO) dto).getBeans_sweet());
				pstmt.setInt(5, ((BeansDTO) dto).getBeans_bitter());
				pstmt.setInt(6, ((BeansDTO) dto).getBeans_body());
				pstmt.setString(7, ((BeansDTO) dto).getInfo_title());
				pstmt.setString(8, ((BeansDTO) dto).getInfo_cont());
				pstmt.setString(9, ((BeansDTO) dto).getInfo_file());
				pstmt.setInt(10, info_no);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					result = 1;
				}
				break;
			case "country":
				sql += "	coun_no=?, coun_7=?, coun_add=?, info_title=?, info_cont=?, info_file=? where info_no = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, ((CountryDTO) dto).getCoun_no());
				pstmt.setString(2, ((CountryDTO) dto).getCoun_7());
				pstmt.setString(3, ((CountryDTO) dto).getCoun_add());
				pstmt.setString(4, ((CountryDTO) dto).getInfo_title());
				pstmt.setString(5, ((CountryDTO) dto).getInfo_cont());
				pstmt.setString(6, ((CountryDTO) dto).getInfo_file());
				pstmt.setInt(7, info_no);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					result = 1;
				}
				break;
			case "extra":
				sql += "	extra_genre=?, info_title=?, info_cont=?, info_file=? where info_no = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, ((ExtraDTO) dto).getExtra_genre());
				pstmt.setString(2, ((ExtraDTO) dto).getInfo_title());
				pstmt.setString(3, ((ExtraDTO) dto).getInfo_cont());
				pstmt.setString(4, ((ExtraDTO) dto).getInfo_file());
				pstmt.setInt(5, info_no);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					result = 1;
				}
				break;
			default:
				sql += "	info_title=?, info_cont=?, info_file=? where info_no = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, ((InfoDTO) dto).getInfo_title());
				pstmt.setString(2, ((InfoDTO) dto).getInfo_cont());
				pstmt.setString(3, ((InfoDTO) dto).getInfo_file());
				pstmt.setInt(4, info_no);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					result = 1;
				}
				break;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConn(con, pstmt, rs);
		}
		return result;
	}

	/**
	 * 게시글 삭제
	 * @param info_no
	 * @param genre
	 * @return 성공 시 return 1;
	 */
	public int deleteCont(int info_no, String genre) {
		int result = 0;
		try {
			con = openConn();
			sql = "delete from " + genre + " where info_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, info_no);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (!genre.equals("info")) {
					sql = "delete from info where info_no=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, info_no);
					rs = pstmt.executeQuery();
					if (rs.next()) {
						result = 1;
					}
				} else {
					result = 1;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConn(con, pstmt, rs);
		}
		return result;
	}

	/**
	 * 해당 게시글의 댓글 가져오기
	 * @param info_no
	 * @param mnum 
	 * @return 댓글 리스트
	 */
	public List<ReplyDTO> getrep(int info_no) {
		ArrayList<ReplyDTO> list = new ArrayList<>();
		try {
			con = openConn();
			sql = "SELECT *  FROM (SELECT * FROM info_reply WHERE info_no=?) START WITH parentnum = 0 CONNECT BY PRIOR  rep_num = parentnum";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, info_no);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ReplyDTO dto = new ReplyDTO();
				dto.setRep_num(rs.getInt("rep_num"));
				dto.setInfo_no(rs.getInt("Info_no"));
				dto.setCont(rs.getString("cont"));
				dto.setWriter(MemberDAO.getInstance().getMember(rs.getInt("writerNum")).getM_nickname());
				dto.setWriterNum(rs.getInt("writerNum"));
				dto.setDep(rs.getInt("dep"));
				dto.setParentNum(rs.getInt("parentNum"));
				dto.setRegdate(rs.getString("regdate"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConn(con, pstmt, rs);
		}
		return list;
	}

	public int insert(ReplyDTO dto) {
		int result = 0;
		try {
			con = openConn();
			sql = "INSERT INTO info_reply VALUES(" + 
					"rep_seq.NEXTVAL," + 
					"?," + // 게시글 번호
					"?," + // 댓글 내용
					"?," + // 댓글쓴이 번호
					"?," + // 이 댓글의 깊이 
					"?," + // 부모 댓글 번호 
					"SYSDATE,'')";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, dto.getInfo_no());
			pstmt.setString(2, dto.getCont());
			pstmt.setInt(3, dto.getWriterNum());
			pstmt.setInt(4, dto.getDep());
			pstmt.setInt(5, dto.getParentNum());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConn(con, pstmt, rs);
		}
		return result;
	}

}
