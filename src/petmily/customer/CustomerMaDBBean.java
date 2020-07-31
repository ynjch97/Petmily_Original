package petmily.customer;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CustomerMaDBBean {
	
	private static CustomerMaDBBean instance = new CustomerMaDBBean();
	   
    public static CustomerMaDBBean getInstance() {
    	return instance;
    }
   
    private CustomerMaDBBean() {}
   
    private Connection getConnection() throws Exception {
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource)envCtx.lookup("jdbc/petmily");
        return ds.getConnection();
    }
    // 4. 매칭 정보 가져오기
	 public CustomerMaDataBean getMa(String id) 
    throws Exception {
   	 Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        CustomerMaDataBean cus_ma=null;
        
        try {
       	 conn = getConnection();
          
            pstmt = conn.prepareStatement(
          	     "select * from cus_ma where cus_id = ?");
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
           	 cus_ma = new CustomerMaDataBean();
           	 
           	 cus_ma.setCus_Id(rs.getString("cus_id"));
           	 cus_ma.setM_que(rs.getString("m_que"));
           	 cus_ma.setM_ans(rs.getString("m_ans"));
           
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
		 return cus_ma;
    }
	 // 5. 매칭정보 수정하기
	 public void updateMa(CustomerMaDataBean cus_ma) 
     throws Exception {
    	 Connection conn = null;
         PreparedStatement pstmt = null;
       
         try {
        	 conn = getConnection();
           
             pstmt = conn.prepareStatement(
               "update cus_ma set m_que=?,m_ans=? "+
               "where cus_id=?");
             pstmt.setString(1, cus_ma.getM_que());
             pstmt.setString(2, cus_ma.getM_ans());
             pstmt.setString(3, cus_ma.getCus_Id());
            
             pstmt.executeUpdate();
         }catch(Exception ex) {
             ex.printStackTrace();
         }finally {
             if (pstmt != null) 
            	 try { pstmt.close(); } catch(SQLException ex) {}
             if (conn != null) 
            	 try { conn.close(); } catch(SQLException ex) {}
         }
     }
    
}