package petmily.petsitter;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import petmily.customer.ReserveDataBean;


public class PetLogDBBean {
	
	private static PetLogDBBean instance = new PetLogDBBean();
	   
    public static PetLogDBBean getInstance() {
    	return instance;
    }
   
    private PetLogDBBean() {}
   
    private Connection getConnection() throws Exception {
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource)envCtx.lookup("jdbc/petmily");
        return ds.getConnection();
    }

    // 1. 일지 작성
    public void insertPetLog(PetLogDataBean petlog) 
    throws Exception {
    	Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = getConnection();
           
            pstmt = conn.prepareStatement(
            		"insert into petlog(pet_id, cus_id, dog_id, pet_name, cus_name, dog_name, dog_pic, log_title, log_content, log_pic1, log_pic2, log_pic3, log_ip, res_date, log_date) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			pstmt.setString(1, petlog.getPet_id());
			pstmt.setString(2, petlog.getCus_id());
			pstmt.setString(3, petlog.getDog_id());
			pstmt.setString(4, petlog.getPet_name());
			pstmt.setString(5, petlog.getCus_name());
			pstmt.setString(6, petlog.getDog_name());
			pstmt.setString(7, petlog.getDog_pic());
			pstmt.setString(8, petlog.getLog_title());
			pstmt.setString(9, petlog.getLog_content());
			pstmt.setString(10, petlog.getLog_pic1());
			pstmt.setString(11, petlog.getLog_pic2());
			pstmt.setString(12, petlog.getLog_pic3());
			pstmt.setString(13, petlog.getLog_ip());
			pstmt.setString(14, petlog.getRes_date());
			pstmt.setTimestamp(15, petlog.getLog_date());
            pstmt.executeUpdate();
        }catch(Exception ex) {
        	ex.printStackTrace();
        } finally {
            if (pstmt != null) 
            	try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) 
            	try { conn.close(); } catch(SQLException ex) {}
        }
     }
    
	// 2. 펫시터가 오늘 작성한 일지
 	public PetLogDataBean getTodayLog(String pet_id, String res_date, String log_date) throws Exception {
 		Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         PetLogDataBean petlog = null;
         
         try {
        	 conn = getConnection();
           
             pstmt = conn.prepareStatement(
           	     "select * from petlog where pet_id = ? and res_date = ? and log_date like ?"); // 오늘 날짜 가져와서 예약 날짜랑 비교 후, 있으면 출력
             pstmt.setString(1, pet_id);
             pstmt.setString(2, res_date);   
             pstmt.setString(3, log_date+'%');   
             rs = pstmt.executeQuery();

             if (rs.next()) {
				petlog = new PetLogDataBean();
				
				petlog.setLog_num(rs.getInt("log_num"));
				petlog.setPet_id(rs.getString("pet_id"));
				petlog.setCus_id(rs.getString("cus_id"));
				petlog.setDog_id(rs.getString("dog_id"));
				petlog.setPet_name(rs.getString("pet_name"));
				petlog.setCus_name(rs.getString("cus_name"));
				petlog.setDog_name(rs.getString("dog_name"));
				petlog.setDog_pic(rs.getString("dog_pic"));
				petlog.setLog_count(rs.getString("log_count"));
				petlog.setLog_title(rs.getString("log_title"));
				petlog.setLog_content(rs.getString("log_content"));
				petlog.setLog_pic1(rs.getString("log_pic1"));
				petlog.setLog_pic2(rs.getString("log_pic2"));
				petlog.setLog_pic3(rs.getString("log_pic3"));
				petlog.setLog_ip(rs.getString("log_ip"));
				petlog.setRes_date(rs.getString("res_date"));
				petlog.setLog_date(rs.getTimestamp("log_date"));
 			 }
         }catch(Exception ex) {
             ex.printStackTrace();
         }finally {
             if (rs != null) 
            	 try { rs.close(); } catch(SQLException ex) {}
             if (pstmt != null) 
            	 try { pstmt.close(); } catch(SQLException ex) {}
             if (conn != null) 
            	 try { conn.close(); } catch(SQLException ex) {}
         }
 		return petlog;
     }
 	
 	// 3. 일지 번호 출력하기 
 	public int getPetLogNum(String pet_id, String res_date) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int logNum = 0;

		try {
			conn = getConnection();

			String sql = "SELECT log_num FROM PETLOG WHERE pet_id=? AND res_date=?;";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pet_id);
			pstmt.setString(2, res_date);
			
			rs = pstmt.executeQuery();
			
			if (rs.next())
				logNum = rs.getInt(1);
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
		return logNum;
	}

}