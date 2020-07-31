package petmily.petsitter;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class PetsitterMaDBBean {
	
	private static PetsitterMaDBBean instance = new PetsitterMaDBBean();
	   
    public static PetsitterMaDBBean getInstance() {
    	return instance;
    }
   
    private PetsitterMaDBBean() {}
   
    private Connection getConnection() throws Exception {
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource)envCtx.lookup("jdbc/petmily");
        return ds.getConnection();
    }

    public void insertCustomerMa(PetsitterMaDataBean customer, String m_que, String pet_id) 
    throws Exception {
    	Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = getConnection();
           
            pstmt = conn.prepareStatement(
            		"insert into PETSITTER_ma values (?)");
            pstmt.setString(1, pet_id);
            pstmt.setString(2, customer.getPet_Id());
            
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

}