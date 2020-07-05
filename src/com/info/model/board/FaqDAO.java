package com.info.model.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class FaqDAO {
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = null;
	
	// 싱글턴 객체 만들기
	private static FaqDAO instance = new FaqDAO();
	
	// 기본생성자
	private FaqDAO() {	
	}
	
	// 생성자 대신에 싱글톤 객체를 리턴해주는 getInstance 만들기
	public static FaqDAO getInstance() {
		if(instance == null) {
			instance = new FaqDAO();
		}
		return instance;
	}
	
	public Connection openConn() {
		
		
		try {
			// 1. JNDI 서버 객체 생성
			InitialContext ic = new InitialContext();
			
			// 2. lookup() 메서드를이용하여 매칭되는 커넥션을 찾는다.
			DataSource ds = (DataSource)ic.lookup("java:comp/env/jdbc/myoracle");
			
			// 3. DataSource 객체를 이용하여 커넥션 객체를 하나 가져온다.
			con=ds.getConnection();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return con;	
	}
	
	public void closeConn(Connection con, PreparedStatement pstmt, ResultSet rs) {	
			try {
				if(rs != null) {
				rs.close();
				}
				if(pstmt != null) {
					pstmt.close();
				}
				if(con != null) {
					con.close();
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	} // closeConn() 메서드 end

	
	// 한페이지당 나올 게시물의 수
	public List<FaqDTO> getFaqList(int startNo,int endNo) {
		List<FaqDTO> list = new ArrayList<>();

		try {			
			con=openConn();
			sql = "select * from (select p.*,row_number()over(order by faq_no desc) rnum from faq p) where rnum >= ? and rnum <= ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startNo);
			pstmt.setInt(2, endNo);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				FaqDTO dto = new FaqDTO();
				dto.setFaq_no(rs.getInt("faq_no"));
				dto.setFaq_title(rs.getString("faq_title"));
				dto.setFaq_cont(rs.getString("faq_cont"));
				list.add(dto);
			}

			} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(con, pstmt, rs);
		}
		return list;
	}   // getBoardList() 메서드 end

	
	// 전체 게시물의 수 조회 
	public int getListCount() {
		int count=0;
		
		try {
			con=openConn();
			sql = "select count(*) from faq";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(con, pstmt, rs);
		}
		return count;
	}   //getListCount() 메소드 end
		
	
	

	
}
