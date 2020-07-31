package petmily.manager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import petmily.customer.CustomerDataBean;
import petmily.petsitter.PetsitterDataBean;

import java.util.Date;
/*import java.util.Calendar;*/
/*import java.text.DecimalFormat;*/

public class ManMonDBBean {

	private static ManMonDBBean instance = new ManMonDBBean();

	public static ManMonDBBean getInstance() {
		return instance;
	}

	private ManMonDBBean() {
	}

	// 커넥션풀로부터 커넥션객체를 얻어내는 메소드
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/petmily");
		return ds.getConnection();
	}

	// 1. 마일리지 충전 금액만큼 관리자 수익으로
    public void insertMile(ManMonDataBean manager) 
    throws Exception {
    	Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = getConnection();
			   
            pstmt = conn.prepareStatement(
            		"insert into man_mon values (?,?,?,?,?,?)");
        			
			pstmt.setString(1, manager.getMon_id());
			pstmt.setString(2, manager.getMon_name());
			pstmt.setString(3, manager.getMon_kind());
			pstmt.setInt(4, manager.getMon_mile());
			pstmt.setInt(5, manager.getMon_miletot());
			pstmt.setTimestamp(6, manager.getMon_date());

            pstmt.executeUpdate();
        }catch(Exception ex) {
        	ex.printStackTrace();
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
    
    // 2. 가장 최근 날짜의 총 수익 가져오기 (즉, 누적 금액) - man_chart_all
    // SELECT MAX(mon_miletot) FROM `man_mon` ORDER BY mon_date DESC;
    // 여기서 제일 최근 금액을 가져와야됨
    public int getTotMileage() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int x = 0;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("SELECT MAX(mon_miletot) FROM `man_mon` ORDER BY mon_date DESC");
			/*pstmt.setString(1, cus_id);*/	
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
    
    // 4. 회원정보를 수정하기 위해 기존의 정보를 표시
 	 public ManMonDataBean getMileage(String id) 
      throws Exception {
     	 Connection conn = null;
          PreparedStatement pstmt = null;
          ResultSet rs = null;
          ManMonDataBean mile=null;
          
          try {
         	 conn = getConnection();
            
              pstmt = conn.prepareStatement(
            	     "select * from man_mon order by mon_date desc");
              pstmt.setString(1, id);
              rs = pstmt.executeQuery();

              if (rs.next()) {
            	  mile = new ManMonDataBean();

            	  mile.setMon_id(rs.getString("mon_id"));
            	  mile.setMon_name(rs.getString("mon_name"));
            	  mile.setMon_kind(rs.getString("mon_kind"));
            	  mile.setMon_mile(rs.getInt("mon_mile"));
            	  mile.setMon_miletot(rs.getInt("mon_miletot"));     
            	  mile.setMon_date(rs.getTimestamp("mon_date")); 
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
 		 return mile;
      }
    
}