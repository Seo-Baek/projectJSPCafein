package com.info.model.member;

import java.util.ArrayList;
import java.util.List;

import com.info.model.DAO;

public class MemberDAO extends DAO {

	private static MemberDAO instance = new MemberDAO();

	private MemberDAO() {
	}

	public static MemberDAO getInstance() {
		if (instance == null) {
			instance = new MemberDAO();
		}
		return instance;
	}

	/**
	 * id와 pwd 기준으로 회원 정보 가져오기
	 * 
	 * @param id
	 * @param pwd
	 * @return 회원정보
	 */
	public MemberDTO getMember(String id, String pwd) {
		MemberDTO dto = new MemberDTO();
		try {
			con = openConn();
			sql = "select * from member_in where m_id=? and m_pwd=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto.setM_id(rs.getString("m_id"));
				dto.setM_nickname(rs.getString("m_nickname"));
				dto.setM_pwd(rs.getString("m_pwd"));
				dto.setM_tel(rs.getString("m_tel"));
				dto.setM_address(rs.getString("m_address"));
				dto.setM_email(rs.getString("m_email"));
				dto.setM_date(rs.getString("m_date"));
				dto.setM_no(rs.getInt("m_no"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConn(con, pstmt, rs);
		}
		return dto;
	}

	/**
	 * 회원번호 기준으로 회원 정보 가져오기
	 * 
	 * @param id
	 * @param pwd
	 * @return 회원정보
	 */
	public MemberDTO getMember(int mno) {
		MemberDTO dto = new MemberDTO();
		try {
			con = openConn();
			sql = "select * from member_in where m_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, mno);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto.setM_id(rs.getString("m_id"));
				dto.setM_nickname(rs.getString("m_nickname"));
				dto.setM_pwd(rs.getString("m_pwd"));
				dto.setM_tel(rs.getString("m_tel"));
				dto.setM_address(rs.getString("m_address"));
				dto.setM_email(rs.getString("m_email"));
				dto.setM_date(rs.getString("m_date"));
				dto.setM_no(rs.getInt("m_no"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConn(con, pstmt, rs);
		}
		return dto;
	}

	/**
	 * 아이디 중복 확인
	 * 
	 * @param id
	 * @return 중복인 경우 : 1
	 */
	public int checkMemberId(String id) {
		int result = 0;
		try {
			con = openConn();
			sql = "select m_id from member_in where m_id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
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
	 * DB 확인하여 로그인 정보 가져오기
	 * 
	 * @param id
	 * @param pwd
	 * @return 아이디 없는경우 : -2, 잘못된 비밀번호 : -1, 성공 시 : 1
	 */
	public int userCheck(String id, String pwd) {
		int result = 0; // 회원여부를 저장할 변수

		try {
			con = openConn();
			sql = "select * from member_in where m_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				if (pwd.equals(rs.getString("m_pwd"))) {
					result = 1;
				} else {
					result = -1;
				}
			} else {
				result = -2;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConn(con, pstmt, rs);
		}
		return result;
	}

	/**
	 * 관리자 가입
	 * 
	 * @return 가입시 사용할 회원번호
	 */
	public int admin_noCheck() {
		int result = 0;
		try {
			con = openConn();
			sql = "select max(m_no) from member_in where m_no <= 100";
			pstmt = con.prepareStatement(sql);
			;
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConn(con, pstmt, rs);
		}
		return result + 1;
	}

	/**
	 * 일반회원 가입
	 * 
	 * @return 가입시 사용할 회원번호
	 */
	public int m_noCheck() {
		int result = 0;
		try {
			con = openConn();
			sql = "select max(m_no) from member_in where m_no > 100";
			pstmt = con.prepareStatement(sql);
			;
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConn(con, pstmt, rs);
		}
		return result + 1;
	}

	/**
	 * 회원 가입 정보 DB 추가하기
	 * 
	 * @param dto
	 * @return 성공 시 : 1
	 */
	public int insertMember(MemberDTO dto) {
		int result = 0;

		try {
			con = openConn();
			sql = "insert into member_in values(?,?,?,?,?,?,sysdate,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getM_id());
			pstmt.setString(2, dto.getM_nickname());
			pstmt.setString(3, dto.getM_pwd());
			pstmt.setString(4, dto.getM_tel());
			pstmt.setString(5, dto.getM_address());
			pstmt.setString(6, dto.getM_email());
			pstmt.setInt(7, dto.getM_no());
			result = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConn(con, pstmt, rs);
		}
		return result;
	}

	/**
	 * 패스워드 확인하기
	 * 
	 * @param m_id
	 * @param m_email
	 * @return
	 */
	public String pwdCheck(String m_id, String m_email) {
		String result = null;
		try {
			con = openConn();
			sql = "select * from member_in where m_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, m_id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				if (m_email.equals(rs.getString("m_email"))) {
					result = "PASSWORD : " + rs.getString("m_pwd");
				} else {
					result = "이메일 확인 요망!!";
				}
			} else {
				result = "아이디 확인 요망!!";
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConn(con, pstmt, rs);
		}
		return result;
	}

	/**
	 * 회원 정보 DB 수정하기
	 * 
	 * @param dto
	 * @return 성공 시 : 1
	 */
	public int updateMember(MemberDTO dto) {
		int result = 0;

		try {
			con = openConn();
			sql = "update member_in set m_nickname=?, m_pwd=?, m_tel=?, m_address=?, m_email=? where m_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getM_nickname());
			pstmt.setString(2, dto.getM_pwd());
			pstmt.setString(3, dto.getM_tel());
			pstmt.setString(4, dto.getM_address());
			pstmt.setString(5, dto.getM_email());
			pstmt.setInt(6, dto.getM_no());
			result = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConn(con, pstmt, rs);
		}
		return result;
	}

	/**
	 * 회원 번호 기준으로 탈퇴
	 * @param m_no
	 * @return
	 */
	public int delete(int m_no) {
		int result = 0;
		try {
			con = openConn();
			sql = "delete from member_in where m_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, m_no);
			result = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConn(con, pstmt, rs);
		}
		return result;
	}
	
	
	/**
	 * 탈퇴회원 정보 DB에 저장하기
	 * 
	 * @param m_no
	 * @return 성공 시 : 1
	 */	
	public int keepDeleteMember(MemberDTO dto) {
		int result = 0;
		
		try {
			con = openConn();
			sql = "insert into member_out values(?,?,?,?,?,?,sysdate,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getM_id());
			pstmt.setString(2, dto.getM_nickname());
			pstmt.setString(3, dto.getM_pwd());
			pstmt.setString(4, dto.getM_tel());
			pstmt.setString(5, dto.getM_address());
			pstmt.setString(6, dto.getM_email());
			pstmt.setInt(7, dto.getM_no());
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}


	/**
	 * 회원 리스트 받아오기
	 * @return list
	 */
	public List<MemberDTO> getMemberList() {
		List<MemberDTO> list = new ArrayList<>();

		try {			
			con = openConn();
			sql = "select * from member_in order by m_no desc";
			
			pstmt = con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				MemberDTO dto = new MemberDTO();
				dto.setM_id(rs.getString("m_id"));
				dto.setM_nickname(rs.getString("m_nickname"));
				dto.setM_pwd(rs.getString("m_pwd"));
				dto.setM_tel(rs.getString("m_tel"));
				dto.setM_address(rs.getString("m_address"));
				dto.setM_email(rs.getString("m_email"));
				dto.setM_date(rs.getString("m_date"));
				dto.setM_no(rs.getInt("m_no"));
				
				list.add(dto);
			}

			} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(con, pstmt, rs);
		}
		return list;
	}
	
	/**
	 * 탈퇴회원 리스트 받아오기
	 * @return list
	 */
	public List<MemberDTO> outMemberList() {
		List<MemberDTO> list = new ArrayList<>();

		try {			
			con = openConn();
			sql = "select * from member_out order by m_no desc";
			
			pstmt = con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				MemberDTO dto = new MemberDTO();
				dto.setM_id(rs.getString("m_id"));
				dto.setM_nickname(rs.getString("m_nickname"));
				dto.setM_pwd(rs.getString("m_pwd"));
				dto.setM_tel(rs.getString("m_tel"));
				dto.setM_address(rs.getString("m_address"));
				dto.setM_email(rs.getString("m_email"));
				dto.setM_date(rs.getString("m_date"));
				dto.setM_no(rs.getInt("m_no"));
				
				list.add(dto);
			}

			} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(con, pstmt, rs);
		}
		return list;
	}

}
