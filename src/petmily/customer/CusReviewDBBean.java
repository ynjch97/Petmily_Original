package petmily.customer;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Date;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import java.util.ArrayList;
import java.util.List;

/*import java.text.SimpleDateFormat;*/

public class CusReviewDBBean {
	
	private static CusReviewDBBean instance = new CusReviewDBBean();
	   
    public static CusReviewDBBean getInstance() {
    	return instance;
    }
   
    private CusReviewDBBean() {}
   
    private Connection getConnection() throws Exception {
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource)envCtx.lookup("jdbc/petmily");
        return ds.getConnection();
    }
    
    // 1. ∏Æ∫‰ ¿€º∫
    public void insertReview(CusReviewDataBean review) 
    throws Exception {
    	Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = getConnection();
			   
            pstmt = conn.prepareStatement(
            		"insert into cusreview(rev_num, pet_id, cus_id, dog_id, pet_name, cus_name, dog_name, dog_pic, rev_content, rev_star, rev_ip, res_date, rev_date) values (?,?,?,?,?,?,?,?,?,?,?,?,?)");

			pstmt.setString(1, review.getRev_num());
			pstmt.setString(2, review.getPet_id());
			pstmt.setString(3, review.getCus_id());
			pstmt.setString(4, review.getDog_id());
			pstmt.setString(5, review.getPet_name());
			pstmt.setString(6, review.getCus_name());
			pstmt.setString(7, review.getDog_name());
			pstmt.setString(8, review.getDog_pic());
			pstmt.setString(9, review.getRev_content());
			pstmt.setInt(10, review.getRev_star());
			pstmt.setString(11, review.getRev_ip());
			pstmt.setString(12, review.getRes_date());
			pstmt.setTimestamp(13, review.getRev_date());
			
            pstmt.executeUpdate();
        }catch(Exception ex) {
        	ex.printStackTrace();
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
    
   	// 2. ∏Æ∫‰ »Æ¿Œ«œ±‚ - πËø≠ πÊπ˝ («ÿ¥Á ∆ÍΩ√≈Õ¿« ∏Æ∫‰)
	public CusReviewDataBean[] getCusReview(int count, String pet_id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		CusReviewDataBean reviewList[] = null;
		int i = 0;

		try {
			conn = getConnection();

			String sql = "select * from cusreview where pet_id=? order by rev_date";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pet_id);	
			rs = pstmt.executeQuery();

			if (rs.next()) {
				reviewList = new CusReviewDataBean[count];

				do {
					CusReviewDataBean review = new CusReviewDataBean();

					review.setRev_num(rs.getString("rev_num"));
					review.setPet_id(rs.getString("pet_id"));
					review.setCus_id(rs.getString("cus_id"));
					review.setDog_id(rs.getString("dog_id"));
					review.setPet_name(rs.getString("pet_name"));
					review.setCus_name(rs.getString("cus_name"));
					review.setDog_name(rs.getString("dog_name"));
					review.setDog_pic(rs.getString("dog_pic"));
					review.setRev_content(rs.getString("rev_content"));
					review.setRev_star(rs.getInt("rev_star"));
					review.setRev_ip(rs.getString("rev_ip"));
					review.setRes_date(rs.getString("res_date"));
					review.setRev_date(rs.getTimestamp("rev_date"));
					
					reviewList[i] = review;
					i++;

				} while (rs.next() && i<reviewList.length);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) 
            	try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) 
            	try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) 
            	try { conn.close(); } catch(SQLException ex) {}
		}
		return reviewList;
	}
    	
    // 2-1. «ÿ¥Á ∆ÍΩ√≈Õ¿« ∏Æ∫‰ ∞≥ºˆ
	public int getCusReviewCount(String pet_id) throws Exception {
   		Connection conn = null;
   		PreparedStatement pstmt = null;
   		ResultSet rs = null;

   		int x = 0;

   		try {
   			conn = getConnection();

   			pstmt = conn.prepareStatement("select count(*) from cusreview where pet_id=?");
   			pstmt.setString(1, pet_id);	
   			rs = pstmt.executeQuery();

   			if (rs.next())
   				x = rs.getInt(1);
   		} catch (Exception ex) {
   			ex.printStackTrace();
   		} finally {
   			if (rs != null)
   				try { rs.close(); } catch (SQLException ex) { }
   			if (pstmt != null)
   				try { pstmt.close(); } catch (SQLException ex) { }
   			if (conn != null)
   				try { conn.close(); } catch (SQLException ex) { }
   		}
   		return x;
   	}
	
	// 2-2. «ÿ¥Á ∆ÍΩ√≈Õ¿« ∫∞¡° ∆Ú±’
	public float getCusRevStar(String pet_id) throws Exception {
   		Connection conn = null;
   		PreparedStatement pstmt = null;
   		ResultSet rs = null;

   		float x = 0;

   		try {
   			conn = getConnection();

   			pstmt = conn.prepareStatement("SELECT avg(rev_star) FROM `cusreview` where pet_id=?;");
   			pstmt.setString(1, pet_id);	
   			rs = pstmt.executeQuery();

   			if (rs.next())
   				x = rs.getFloat(1);
   		} catch (Exception ex) {
   			ex.printStackTrace();
   		} finally {
   			if (rs != null)
   				try { rs.close(); } catch (SQLException ex) { }
   			if (pstmt != null)
   				try { pstmt.close(); } catch (SQLException ex) { }
   			if (conn != null)
   				try { conn.close(); } catch (SQLException ex) { }
   		}
   		return x;
   	}
    	
}