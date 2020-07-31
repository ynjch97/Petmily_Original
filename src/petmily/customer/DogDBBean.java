package petmily.customer;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DogDBBean {
	
	private static DogDBBean instance = new DogDBBean();
	   
    public static DogDBBean getInstance() {
    	return instance;
    }
   
    private DogDBBean() {}
   
    private Connection getConnection() throws Exception {
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource)envCtx.lookup("jdbc/petmily");
        return ds.getConnection();
    }

    // 1. 개 정보 삽입
    public void insertDog(DogDataBean dog, String cus_id) 
    throws Exception {
    	Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = getConnection();
           
            pstmt = conn.prepareStatement(
            		"insert into dog values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
            pstmt.setString(1, dog.getDog_id());
            pstmt.setString(2, cus_id);
			pstmt.setString(3, dog.getDog_pic());
			pstmt.setString(4, dog.getDog_name());
			pstmt.setString(5, dog.getDog_gender());
			pstmt.setString(6, dog.getDog_kind());
			pstmt.setString(7, dog.getDog_wei());
			pstmt.setString(8, dog.getDog_birth());
			pstmt.setString(9, dog.getDog_rqrd());
			pstmt.setString(10, dog.getDog_reg());
			pstmt.setString(11, dog.getDog_surg());
			pstmt.setString(12, dog.getDog_fri());
			pstmt.setString(13, dog.getDog_bow());
			pstmt.setString(14, dog.getDog_bow_spec());
			pstmt.setString(15, dog.getDog_sick());
			pstmt.setString(16, dog.getDog_sick_spec());
			pstmt.setString(17, dog.getDog_poo());
			pstmt.setString(18, dog.getDog_poo_spec());
			pstmt.setString(19, dog.getDog_hspt());
			pstmt.setString(20, dog.getDog_hspt_tel());
			pstmt.setString(21, dog.getDog_hspt_post());
			pstmt.setString(22, dog.getDog_hspt_addr());
			pstmt.setTimestamp(23, dog.getReg_date());
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

    // 2. 개 정보 가져오기
    public DogDataBean getDog(String id) 
    	    throws Exception {
    	   	 Connection conn = null;
    	        PreparedStatement pstmt = null;
    	        ResultSet rs = null;
    	        DogDataBean dog=null;
    	        
    	        try {
    	       	 conn = getConnection();
    	          
    	            pstmt = conn.prepareStatement(
    	           		"select * from dog where dog_id = ?");
    	        			/*"select * from dog where cus_id = ? and dog_name = ?");*/
    	            pstmt.setString(1, id);
    	            /*pstmt.setString(2, dogName);*/
    	            rs = pstmt.executeQuery();

    	            if (rs.next()) {
    	           	 dog = new DogDataBean();

    	           	 dog.setCus_id(rs.getString("cus_id"));
    	           	 dog.setDog_id(rs.getString("dog_id"));
    	           	 dog.setDog_pic(rs.getString("dog_pic"));
    	           	 dog.setDog_name(rs.getString("dog_name")); 
    	           	 dog.setDog_rqrd(rs.getString("dog_rqrd"));
    	           	 dog.setDog_gender(rs.getString("dog_gender"));
    	           	 dog.setDog_kind(rs.getString("dog_kind"));
    	           	 dog.setDog_wei(rs.getString("dog_wei"));
    	           	 dog.setDog_birth(rs.getString("dog_birth"));
    	           	 dog.setDog_reg(rs.getString("dog_reg"));
    	           	 dog.setDog_surg(rs.getString("dog_surg"));
    	           	 dog.setDog_fri(rs.getString("dog_fri"));
    	           	 dog.setDog_bow(rs.getString("dog_bow"));
    	           	 dog.setDog_bow_spec(rs.getString("dog_bow_spec"));
    	           	 dog.setDog_sick(rs.getString("dog_sick"));
    	           	 dog.setDog_sick_spec(rs.getString("dog_sick_spec"));
    	           	 dog.setDog_poo(rs.getString("dog_poo"));
    	           	 dog.setDog_poo_spec(rs.getString("dog_poo_spec"));
    	           	 dog.setDog_hspt(rs.getString("dog_hspt"));
    	           	 dog.setDog_hspt_tel(rs.getString("dog_hspt_tel"));
    	           	 dog.setDog_hspt_post(rs.getString("dog_hspt_post"));
    	           	 dog.setDog_hspt_addr(rs.getString("dog_hspt_addr"));
    	           	 dog.setReg_date(rs.getTimestamp("reg_date")); 
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
    			 return dog;
    	    }

    // 2-1. 개 정보 가져오기
    public DogDataBean getDogs(String id) 
    	    throws Exception {
    	   	 Connection conn = null;
    	        PreparedStatement pstmt = null;
    	        ResultSet rs = null;
    	        DogDataBean dog=null;
    	        
    	        try {
    	       	 conn = getConnection();
    	          
    	            pstmt = conn.prepareStatement(
    	           		"select * from dog where cus_id = ?");
    	        			/*"select * from dog where cus_id = ? and dog_name = ?");*/
    	            pstmt.setString(1, id);
    	            /*pstmt.setString(2, dogName);*/
    	            rs = pstmt.executeQuery();

    	            if (rs.next()) {
    	           	 dog = new DogDataBean();

    	           	 dog.setCus_id(rs.getString("cus_id"));
    	           	 dog.setDog_id(rs.getString("dog_id"));
    	           	 dog.setDog_pic(rs.getString("dog_pic"));
    	           	 dog.setDog_name(rs.getString("dog_name")); 
    	           	 dog.setDog_rqrd(rs.getString("dog_rqrd"));
    	           	 dog.setDog_gender(rs.getString("dog_gender"));
    	           	 dog.setDog_kind(rs.getString("dog_kind"));
    	           	 dog.setDog_wei(rs.getString("dog_wei"));
    	           	 dog.setDog_birth(rs.getString("dog_birth"));
    	           	 dog.setDog_reg(rs.getString("dog_reg"));
    	           	 dog.setDog_surg(rs.getString("dog_surg"));
    	           	 dog.setDog_fri(rs.getString("dog_fri"));
    	           	 dog.setDog_bow(rs.getString("dog_bow"));
    	           	 dog.setDog_bow_spec(rs.getString("dog_bow_spec"));
    	           	 dog.setDog_sick(rs.getString("dog_sick"));
    	           	 dog.setDog_sick_spec(rs.getString("dog_sick_spec"));
    	           	 dog.setDog_poo(rs.getString("dog_poo"));
    	           	 dog.setDog_poo_spec(rs.getString("dog_poo_spec"));
    	           	 dog.setDog_hspt(rs.getString("dog_hspt"));
    	           	 dog.setDog_hspt_tel(rs.getString("dog_hspt_tel"));
    	           	 dog.setDog_hspt_post(rs.getString("dog_hspt_post"));
    	           	 dog.setDog_hspt_addr(rs.getString("dog_hspt_addr"));
    	           	 dog.setReg_date(rs.getTimestamp("reg_date")); 
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
    			 return dog;
    	    }
    
    // 3. 개 아이디 가져오기
    public String getDogId(String cusId) 
    throws Exception {
   	 Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String dogId=null;
        
        try {
       	 conn = getConnection();
          
            pstmt = conn.prepareStatement(
           		"select dog_id from dog where cus_id = ?");
        			/*"select * from dog where cus_id = ? and dog_name = ?");*/
            pstmt.setString(1, cusId);
            /*pstmt.setString(2, dogName);*/
            rs = pstmt.executeQuery();

            if (rs.next()) {
           	 dogId = rs.getString("dog_id").toString();
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
		 return dogId;
    }
    
    // 4. 개 정보 수정 
    public void updateDog(DogDataBean dog) 
    	    throws Exception {
    	   	 Connection conn = null;
    	        PreparedStatement pstmt = null;
    	      
    	        try {
    	       	 conn = getConnection();
    	          
    	            pstmt = conn.prepareStatement(
    	              "update dog set dog_pic=?,dog_gender=?,dog_wei=?,dog_rqrd=?,dog_reg=?,dog_surg=?,dog_fri=?,dog_bow=?,dog_bow_spec=?,dog_sick=?,dog_sick_spec=?,dog_poo=?,dog_poo_spec=?,dog_hspt=?,dog_hspt_tel=?,dog_hspt_post=?,dog_hspt_addr=? "+
    	              "where cus_id=?");
    	            pstmt.setString(1, dog.getDog_pic());
    	            pstmt.setString(2, dog.getDog_gender());
    	            pstmt.setString(3, dog.getDog_wei());
    	            pstmt.setString(4, dog.getDog_rqrd());
    	            pstmt.setString(5, dog.getDog_reg());
    	            pstmt.setString(6, dog.getDog_surg());
    	            pstmt.setString(7, dog.getDog_fri());
    	            pstmt.setString(8, dog.getDog_bow());
    	            pstmt.setString(9, dog.getDog_bow_spec());
    	            pstmt.setString(10, dog.getDog_sick());
    	            pstmt.setString(11, dog.getDog_sick_spec());
    	            pstmt.setString(12, dog.getDog_poo());
    	            pstmt.setString(13, dog.getDog_poo_spec());
    	            pstmt.setString(14, dog.getDog_hspt());
    	            pstmt.setString(15, dog.getDog_hspt_tel());
    	            pstmt.setString(16, dog.getDog_hspt_post());
    	            pstmt.setString(17, dog.getDog_hspt_addr());
    	            pstmt.setString(18, dog.getCus_id()); 
    	    
    	            
    	          
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