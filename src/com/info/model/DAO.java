package com.info.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DAO {

	protected Connection con = null;
	protected PreparedStatement pstmt = null;
	protected ResultSet rs = null;
	protected String sql = null;

	/**
	 * JNDI 객체를 이용하여 커넥션풀에 있는 커넥션 사용
	 * 
	 * @return Connection 객체
	 * @throws Exception
	 */
	protected Connection openConn() throws Exception {

		InitialContext ic = new InitialContext();

		DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/myoracle");

		return ds.getConnection();
	}

	/**
	 * 인자로 들어온 Connection, PreparedStatement, ResultSet 객체를 close()
	 * 
	 * @param con
	 * @param pstmt
	 * @param rs
	 */
	protected void closeConn(Connection con, PreparedStatement pstmt, ResultSet rs) {
		try {
			if (rs != null) {
				rs.close();
			}
			if (pstmt != null) {
				pstmt.close();
			}
			if (con != null) {
				con.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * sql문을 받아서 처리하는 메서드
	 * 
	 * @param sql
	 * @return 성공 시 return = 1;
	 */
	public int setSql(String sql) {
		int result = 0;
		try {
			con = openConn();
			pstmt = con.prepareStatement(sql);
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

}
