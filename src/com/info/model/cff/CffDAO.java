package com.info.model.cff;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CffDAO {

	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = null;
	
	private static CffDAO instance = new CffDAO();
	
	private CffDAO() {   }
	
	public static CffDAO getInstance() {
		if(instance == null) {
			instance = new CffDAO();
		}
		return instance;
	}
	
	public Connection openConn() {
		
		try {
			InitialContext ic = new InitialContext();
			DataSource ds = 
					(DataSource)ic.lookup("java:comp/env/jdbc/myoracle");
			
			con = ds.getConnection();
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return con;
		
	}
	
	public void closeConn(ResultSet rs, PreparedStatement pstmt, Connection con) {
		try {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(con != null) con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public int getListCount() {
		int count = 0;

		try {
			con = openConn();
			sql = "select count(*) from cff";   // count() -> sql에서 갯수를 구하는 함수
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return count;
	}
	
	// cff 전체리스트 불러오기.
	public List<CffDTO> getCffList(int page, int rowsize) {
		List<CffDTO> list = new ArrayList<CffDTO>();
		
		// 해당 페이지의 시작 번호 
		int startNo = (page * rowsize) - (rowsize - 1);
		
		// 해당 페이지의 끝 번호 
		int endNo = (page * rowsize);

		try {
			con = openConn();
			sql = "select * from "
					+ "(select p.*, row_number() "
					+ "over(order by cff_no) rnum "
					+ "from cff p) "
					+ "where rnum >=? and rnum <=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startNo);
			pstmt.setInt(2, endNo);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				CffDTO dto = new CffDTO();
				dto.setCff_no(rs.getInt("cff_no"));
				dto.setCff_file(rs.getString("cff_file"));
				dto.setCff_title(rs.getString("cff_title"));
				dto.setCff_cont1(rs.getString("cff_cont1"));
				dto.setCff_cont2(rs.getString("cff_cont2"));
				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return list;
	}
	
	// 상세내용
	public CffDTO getCont(int no) {
		CffDTO dto = new CffDTO();

		try {
			con = openConn();
			sql = "select * from cff where cff_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto.setCff_no(rs.getInt("cff_no"));
				dto.setCff_file(rs.getString("cff_file"));
				dto.setCff_title(rs.getString("cff_title"));
				dto.setCff_cont1(rs.getString("cff_cont1"));
				dto.setCff_cont2(rs.getString("cff_cont2"));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return dto;
	}
	
	public int insertCff(CffDTO dto) {
		int result = 0, count = 1;

		try {			
			con = openConn();
			sql = "select max(cff_no) from cff";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1) + 1;
			}
			
			sql = "insert into cff values(?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, count);
			pstmt.setString(2, dto.getCff_file());
			pstmt.setString(3, dto.getCff_title());
			pstmt.setString(4, dto.getCff_cont1());
			pstmt.setString(5, dto.getCff_cont2());
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}
	
	// 수정 폼
	public int updateCff(CffDTO dto) {
		int result = 0;

		try {
			con = openConn();
			sql = "update cff set cff_title=?, cff_file=?, cff_cont1=?, cff_cont2=? where cff_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getCff_title());
			pstmt.setString(2, dto.getCff_file());
			pstmt.setString(3, dto.getCff_cont1());
			pstmt.setString(4, dto.getCff_cont2());
			pstmt.setInt(5, dto.getCff_no());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
	}
	
	// 삭제 폼
	public int deleteCff(int no) {
		int result = 0;

		try {
			con = openConn();
			sql = "select * from cff where cff_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				sql = "delete from cff where cff_no=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, no);
				rs = pstmt.executeQuery();
				result = 1;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}
	
	// 검색 폼
	public int searchListCount(String find_field, String find_name) {
		int count = 0;
	
		con = openConn();
		if(find_field.equals("title")) {
		
		try {						
			sql = "select count(*) from cff where cff_title like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+find_name+"%");
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
	}else if(find_field.equals("cont")) {
		try {
			sql = "select count(*) from cff where cff_cont1 like ? or cff_cont2 like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+find_name+"%");
			pstmt.setString(2, "%"+find_name+"%");
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
	}else if(find_field.equals("title_cont")) {
		try {
			sql = "select count(*) from cff where cff_title like ? or cff_cont1 like ? or cff_cont2 like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+find_name+"%");
			pstmt.setString(2, "%"+find_name+"%");
			pstmt.setString(3, "%"+find_name+"%");
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
	}
	return count;	
}
	
	// 검색화면 페이징 처리
	public List<CffDTO> searchCffList(String find_field, String find_name, int page, int rowsize) {
		List<CffDTO> list = new ArrayList<CffDTO>();
		
		// 해당 페이지의 시작번호
		int startNo = (page * rowsize) - (rowsize - 1);
		// 해당 페이지의 끝번호
		int endNo = (page * rowsize);
		
		con = openConn();
		
		if(find_field.equals("title")) {
			
			try {
				sql = "select * from"
						+ "(select p.*, row_number() "
						+ "over(order by cff_no) rnum "
						+ "from cff p where cff_title like ?) "
						+ "where rnum >=? and rnum <=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+find_name+"%");
				pstmt.setInt(2, startNo);
				pstmt.setInt(3, endNo);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					CffDTO dto = new CffDTO();
					dto.setCff_no(rs.getInt("cff_no"));
					dto.setCff_file(rs.getString("cff_file"));
					dto.setCff_title(rs.getString("cff_title"));
					dto.setCff_cont1(rs.getString("cff_cont1"));
					dto.setCff_cont2(rs.getString("cff_cont2"));
					list.add(dto);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				closeConn(rs, pstmt, con);
			}
		}else if(find_field.equals("cont")) {
		
			try {
				sql = "select * from"
						+ "(select p.*, row_number() "
						+ "over(order by cff_no) rnum "
						+ "from cff p where cff_cont1 like ? or cff_cont2 like ?) "
						+ "where rnum >=? and rnum <=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+find_name+"%");
				pstmt.setString(2, "%"+find_name+"%");
				pstmt.setInt(3, startNo);
				pstmt.setInt(4, endNo);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					CffDTO dto = new CffDTO();
					dto.setCff_no(rs.getInt("cff_no"));
					dto.setCff_file(rs.getString("cff_file"));
					dto.setCff_title(rs.getString("cff_title"));
					dto.setCff_cont1(rs.getString("cff_cont1"));
					dto.setCff_cont2(rs.getString("cff_cont2"));
					list.add(dto);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				closeConn(rs, pstmt, con);
			}
			
		}else if(find_field.equals("title_cont")) {
			
			try {
				sql = "select * from"
						+ "(select p.*, row_number() "
						+ "over(order by cff_no) rnum "
						+ "from cff p where cff_title like ? or cff_cont1 like ? or "
						+ "cff_cont2 like ?) "
						+ "where rnum >=? and rnum <=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+find_name+"%");
				pstmt.setString(2, "%"+find_name+"%");
				pstmt.setString(3, "%"+find_name+"%");
				pstmt.setInt(4, startNo);
				pstmt.setInt(5, endNo);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					CffDTO dto = new CffDTO();
					dto.setCff_no(rs.getInt("cff_no"));
					dto.setCff_file(rs.getString("cff_file"));
					dto.setCff_title(rs.getString("cff_title"));
					dto.setCff_cont1(rs.getString("cff_cont1"));
					dto.setCff_cont2(rs.getString("cff_cont2"));
					list.add(dto);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				closeConn(rs, pstmt, con);
			}
			
		}
		return list;
	}

}
