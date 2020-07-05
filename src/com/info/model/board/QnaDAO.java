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



public class QnaDAO {
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = null;
	
     private static QnaDAO instance = new QnaDAO();
     
     private QnaDAO()  {
     }
     
     
     public static QnaDAO getInstance() {
    	 if(instance == null) {
    		 instance = new QnaDAO();
    	 }
    	 return instance;
     }
	
     public Connection openConn() {

		try {
			InitialContext ic = new InitialContext();
			
			DataSource ds = (DataSource)ic.lookup("java:comp/env/jdbc/myoracle");
			
			con = ds.getConnection();
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		return con;
     }
     
     public void closeConn(Connection con, PreparedStatement pstmt, ResultSet rs) {
    	
    		 try {
    			if (rs != null) {
				rs.close();
    			}
    			if (pstmt != null) {
		    		pstmt.close();
		    	 }
		    	 if  (con != null) {
		    		 con.close();
		    	 }
			} catch (Exception e) {
				e.printStackTrace();
			}
    	 }  // closeConn() 메서드 end

    
     // qna 전체 게시글 수 
	public int getListCount() {
	   int count=0;
	   
		try {
				con = openConn();
				sql="select count(*) from qna";
				pstmt=con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					count=rs.getInt(1);
				}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(con, pstmt, rs);
		}
		return count;
	}   // getListCount() 메소드 end

	
	
   // 한페이지당 나올 게시물의 수 
	public List<QnaDTO> getQnaList(int startNo, int endNo) {
		List<QnaDTO>list=new ArrayList<>();
		
		try {
			con = openConn();
			sql = "select *"
					+ " from (select p.*,row_number()over(order by qna_group desc, qna_step asc) rnum from qna p) "
					+ "where rnum >= ? and rnum <= ? ";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, startNo);
			pstmt.setInt(2, endNo);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				QnaDTO dto= new QnaDTO();
				dto.setQna_no(rs.getInt("qna_no"));
				dto.setQna_title(rs.getString("qna_title"));
				dto.setQna_writer(rs.getString("qna_writer"));
				dto.setQna_cont(rs.getString("qna_cont"));
				dto.setQna_pwd(rs.getString("qna_pwd"));
				dto.setQna_file(rs.getString("qna_file"));
				dto.setQna_date(rs.getString("qna_date"));
				dto.setQna_group(rs.getInt("qna_group"));
				dto.setQna_step(rs.getInt("qna_step"));
				dto.setQna_indent(rs.getInt("qna_indent"));
				dto.setQna_modify(rs.getInt("qna_modify"));
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(con, pstmt, rs);
		}
		return list;
	}


	// 검색하고난 후의 상세내역 
	public QnaDTO getQnaCont(int qna_no) {
		QnaDTO dto = new QnaDTO();
		
		try {
			con = openConn();
			sql = "select * from qna where qna_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, qna_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				dto.setQna_no(rs.getInt("qna_no"));
				dto.setQna_title(rs.getString("qna_title"));
				dto.setQna_writer(rs.getString("qna_writer"));
				dto.setQna_cont(rs.getString("qna_cont"));
				dto.setQna_pwd(rs.getString("qna_pwd"));
				dto.setQna_file(rs.getString("qna_file"));
				dto.setQna_date(rs.getString("qna_date"));
				dto.setQna_group(rs.getInt("qna_group"));
				dto.setQna_step(rs.getInt("qna_step"));
				dto.setQna_indent (rs.getInt("qna_indent"));
				dto.setQna_modify(rs.getInt("qna_modify"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(con, pstmt, rs);
		}
		return dto;
	}   // getQnaCont() 메소드 end


	// 수정 메소드 (비밀번호가 맞았을 경우)
	public int updateQna(QnaDTO dto) {
		int result = 0;

		try {
			con=openConn();
			sql = "select * from qna where qna_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, dto.getQna_no());
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				if(dto.getQna_pwd().equals(rs.getString("qna_pwd"))) {
				sql = "update  qna set qna_title=?, qna_cont=? where qna_no=?";
			    pstmt=con.prepareStatement(sql);
			    pstmt.setString(1, dto.getQna_title());
			    pstmt.setString(2, dto.getQna_cont());
			    pstmt.setInt(3, dto.getQna_no());
			    result=pstmt.executeUpdate();   // 성공하면 0보다 큰값. 
				}else {
					result=-1;     // 비밀번호가 틀린경우
				}
			}else {
				result=-2;
			}
			} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(con, pstmt, rs);
		}
		return result;		
	}  // updateQna() 메소드 end


	// 게시물 삭제
	public int qnaDelete(int qna_no, String qna_pwd) {
		int result =0;
		
		try {
			con = openConn();
			sql = "select * from qna where qna_no=?";
			pstmt= con.prepareStatement(sql);
			pstmt.setInt(1, qna_no);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				if(qna_pwd.equals(rs.getString("qna_pwd"))) {
					sql="delete from qna where qna_no=?";
					pstmt=con.prepareStatement(sql);
					pstmt.setInt(1, qna_no);
					result = pstmt.executeUpdate();
				} else  {
					result=-1;
				}
			}else {
				result = -2;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(con, pstmt, rs);
		}
		return result;
	}   // qnaDelete() 메소드 end


	// 문의하기 메서드 
	public int insertQna(QnaDTO dto) {
	int result=0;
	
	try {
		con=openConn();
		sql="insert into qna values(qna_seq.nextval,?,?,?,?,?,sysdate,qna_seq.currval,0,0,0)";
		pstmt=con.prepareStatement(sql);
		pstmt.setString(1,dto.getQna_title());
		pstmt.setString(2, dto.getQna_writer());
		pstmt.setString(3, dto.getQna_cont());
		pstmt.setString(4, dto.getQna_pwd());
		pstmt.setString(5, dto.getQna_file());
		result=pstmt.executeUpdate();
	} catch (SQLException e) {
		e.printStackTrace();
	}finally {
		closeConn(con, pstmt, rs);
	}
	return result;	
	}  // insertQna() 메서드 end

	
	// 답변하기
	public int replyQna(QnaDTO dto) {
		int result=0;
		
		try {
			con=openConn();
			sql="insert into qna values(qna_seq.nextval,?,?,?,?,?,sysdate,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1,dto.getQna_title());
			pstmt.setString(2, dto.getQna_writer());
			pstmt.setString(3, dto.getQna_cont());
			pstmt.setString(4, dto.getQna_pwd());
			pstmt.setString(5, dto.getQna_file());
			pstmt.setInt(6, dto.getQna_group());
			pstmt.setInt(7, dto.getQna_step()+1);
			pstmt.setInt(8, dto.getQna_indent()+1);
			pstmt.setInt(9, dto.getQna_modify());
			result=pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(con, pstmt, rs);
		}
		return result;	
		}  // insertQna() 메서드 end
	
	
    // 최신답글을 위쪽으로,,,,, 해주기 위한 메서드
	public void replyUpdate(int qna_group, int qna_step) {
		
		try {
			con=openConn();
			sql="update qna set qna_step = qna_step + 1 where qna_group=? and qna_step>?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,qna_group);
			pstmt.setInt(2,qna_step);
			pstmt.executeUpdate();
			con.commit();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(con, pstmt, rs);
		}
	} // replyUpdate() 메서드 end


	// 검색어에 해당하는 레코드의 수를 조회하는 메서드
	public int searchListCount(String find_field, String find_name) {
	    int count=0;
	    
     con = openConn();
     if(find_field.equals("title")) {    
	    try {
	 	    sql="select count(*) from qna where qna_title like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,"%" + find_name + "%");
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(con, pstmt, rs);
		}
	  } else if(find_field.equals("cont")) {    
    	 try {
    	    sql="select count(*) from qna where qna_cont like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+find_name+"%");
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(con, pstmt, rs);
		}
     }else if(find_field.equals("title_cont")) {
    	 try {
     	    sql="select count(*) from qna where  qna_title like ?  or  qna_cont like?";
 			pstmt = con.prepareStatement(sql);
 			pstmt.setString(1, "%"+find_name+"%");
 			rs=pstmt.executeQuery();
 			
 			if(rs.next()) {
 				count=rs.getInt(1);
 			}
 		} catch (SQLException e) {
 			e.printStackTrace();
 		}finally {
 			closeConn(con, pstmt, rs);
 		}
     }else if(find_field.equals("writer")) {
    	 try {
      	    sql="select count(*) from qna where qna_writer like ? ";
  			pstmt = con.prepareStatement(sql);
  			pstmt.setString(1, "%"+find_name+"%");
  			rs=pstmt.executeQuery();
  			
  			if(rs.next()) {
  				count=rs.getInt(1);
  			}
  		} catch (SQLException e) {
  			e.printStackTrace();
  		}finally {
  			closeConn(con, pstmt, rs);
  		}
     }
     return count;
 }  // searchListCount() 메서드 end

   
	
	// 검색한 내용을 가지고 페이징 처리하는 메서드
	public List<QnaDTO> searchQnaList(String find_field, String find_name, int startNo, int endNo) {
		List<QnaDTO> list = new ArrayList<QnaDTO>();
		
		con = openConn();
		
		if(find_field.equals("title")) {
			try {
				sql="select * from(select p.*,row_number()over(order by qna_no desc)rnum from qna p where qna_title like ?) where rnum >=? and rnum <=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, "%"+find_name+"%");
				pstmt.setInt(2, startNo);
				pstmt.setInt(3, endNo);
				rs=pstmt.executeQuery();
				
				while(rs.next()) {
					QnaDTO dto = new QnaDTO();
					dto.setQna_no(rs.getInt("qna_no"));
					dto.setQna_title(rs.getString("qna_title"));
					dto.setQna_writer(rs.getString("qna_writer"));
					dto.setQna_cont(rs.getString("qna_cont"));
					dto.setQna_pwd(rs.getString("qna_pwd"));
					dto.setQna_file(rs.getString("qna_file"));
					dto.setQna_date(rs.getString("qna_date"));
					dto.setQna_group(rs.getInt("qna_group"));
					dto.setQna_step(rs.getInt("qna_step"));
					dto.setQna_indent(rs.getInt("qna_indent"));
					dto.setQna_modify(rs.getInt("qna_modify"));
					list.add(dto);
					
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
	  			closeConn(con, pstmt, rs);
	  		}
		}else if(find_field.equals("cont")) {
			try {
				sql="select * from(select p.*,row_number()over(order by qna_no desc)rnum from qna p where qna_cont like ?) where rnum >=? and rnum <=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, "%"+find_name+"%");
				pstmt.setInt(2, startNo);
				pstmt.setInt(3, endNo);
				rs=pstmt.executeQuery();
				
				while(rs.next()) {
					QnaDTO dto = new QnaDTO();
					dto.setQna_no(rs.getInt("qna_no"));
					dto.setQna_title(rs.getString("qna_title"));
					dto.setQna_writer(rs.getString("qna_writer"));
					dto.setQna_cont(rs.getString("qna_cont"));
					dto.setQna_pwd(rs.getString("qna_pwd"));
					dto.setQna_file(rs.getString("qna_file"));
					dto.setQna_date(rs.getString("qna_date"));
					dto.setQna_group(rs.getInt("qna_group"));
					dto.setQna_step(rs.getInt("qna_step"));
					dto.setQna_indent(rs.getInt("qna_indent"));
					dto.setQna_modify(rs.getInt("qna_modify"));
					list.add(dto);
					
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
	  			closeConn(con, pstmt, rs);
	  		}
		}else if(find_field.equals("title_cont")) {
			try {
				sql="select * from(select p.*,row_number()over(order by qna_no desc)rnum from qna p where qna_title like ? or qna_cont like ?) where rnum >=? and rnum <=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, "%"+find_name+"%");
				pstmt.setInt(2, startNo);
				pstmt.setInt(3, endNo);
				rs=pstmt.executeQuery();
				
				while(rs.next()) {
					QnaDTO dto = new QnaDTO();
					dto.setQna_no(rs.getInt("qna_no"));
					dto.setQna_title(rs.getString("qna_title"));
					dto.setQna_writer(rs.getString("qna_writer"));
					dto.setQna_cont(rs.getString("qna_cont"));
					dto.setQna_pwd(rs.getString("qna_pwd"));
					dto.setQna_file(rs.getString("qna_file"));
					dto.setQna_date(rs.getString("qna_date"));
					dto.setQna_group(rs.getInt("qna_group"));
					dto.setQna_step(rs.getInt("qna_step"));
					dto.setQna_indent(rs.getInt("qna_indent"));
					dto.setQna_modify(rs.getInt("qna_modify"));
					list.add(dto);
					
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
	  			closeConn(con, pstmt, rs);
	  		}
		}else if(find_field.equals("writer")) {
			try {
				sql="select * from(select p.*,row_number()over(order by qna_no desc)rnum from qna p where qna_writer like ?) where rnum >=? and rnum <=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, "%"+find_name+"%");
				pstmt.setInt(2, startNo);
				pstmt.setInt(3, endNo);
				rs=pstmt.executeQuery();
				
				while(rs.next()) {
					QnaDTO dto = new QnaDTO();
					dto.setQna_no(rs.getInt("qna_no"));
					dto.setQna_title(rs.getString("qna_title"));
					dto.setQna_writer(rs.getString("qna_writer"));
					dto.setQna_cont(rs.getString("qna_cont"));
					dto.setQna_pwd(rs.getString("qna_pwd"));
					dto.setQna_file(rs.getString("qna_file"));
					dto.setQna_date(rs.getString("qna_date"));
					dto.setQna_group(rs.getInt("qna_group"));
					dto.setQna_step(rs.getInt("qna_step"));
					dto.setQna_indent(rs.getInt("qna_indent"));
					dto.setQna_modify(rs.getInt("qna_modify"));
					list.add(dto);
					
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
	  			closeConn(con, pstmt, rs);
	  		}
		}
		return list;
	}  //searchQnaList()메서드 end

	// 수정되면 옆에 수정됨. 뜨게 하는 메서드
		public void modifyok(int qna_no) {
	      
			try {
				con=openConn();
				sql="update qna set qna_modify=1 where qna_no=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, qna_no);
				pstmt.executeUpdate();
				rs=pstmt.executeQuery();
				con.commit();
			} catch (SQLException e) {
				e.printStackTrace();
			}finally {
	  			closeConn(con, pstmt, rs);
	  		}
		} // modifyok() 메서드 end

	
}


