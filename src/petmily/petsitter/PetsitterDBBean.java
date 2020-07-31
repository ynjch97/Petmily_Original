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

import petmily.customer.CustomerDataBean;

public class PetsitterDBBean {
	
	private static PetsitterDBBean instance = new PetsitterDBBean();
	   
    public static PetsitterDBBean getInstance() {
    	return instance;
    }
   
    private PetsitterDBBean() {}
   
    private Connection getConnection() throws Exception {
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource)envCtx.lookup("jdbc/petmily");
        return ds.getConnection();
    }

    // 1. ȸ������
    public void insertPetsitter(PetsitterDataBean petsitter) 
    throws Exception {
    	Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = getConnection();
           
            pstmt = conn.prepareStatement(
            		"insert into petsitter(pet_id, pet_passwd, pet_name, pet_gender, pet_birth, pet_phone, pet_post, pet_addr, pet_lic, pet_reg_date) values (?,?,?,?,?,?,?,?,?,?)");
			pstmt.setString(1, petsitter.getPet_id());
			pstmt.setString(2, petsitter.getPet_passwd());
			pstmt.setString(3, petsitter.getPet_name());
			pstmt.setString(4, petsitter.getPet_gender());
			pstmt.setString(5, petsitter.getPet_birth());
			pstmt.setString(6, petsitter.getPet_phone());
			pstmt.setString(7, petsitter.getPet_post());
			pstmt.setString(8, petsitter.getPet_addr());
			pstmt.setString(9, petsitter.getPet_lic());
			pstmt.setTimestamp(10, petsitter.getPet_reg_date());
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

     // 2. ����� ����ó��
	 public int PetsitterCheck(String id, String passwd) 
	 throws Exception {
		 Connection conn = null;
         PreparedStatement pstmt = null;
		 ResultSet rs= null;
         String dbpasswd="";
		 int x=-1;
       
		 try {
			conn = getConnection();
           
			pstmt = conn.prepareStatement(
				    "select pet_passwd from petsitter where pet_id = ?");
				pstmt.setString(1, id);
				rs= pstmt.executeQuery();

				if(rs.next()){
					dbpasswd= rs.getString("pet_passwd"); 
					if(dbpasswd.equals(passwd))
						x = 1; //���� ����
					else
						x = 0; //��й�ȣ Ʋ��
				}else
					x = -1;//�ش� ���̵� ����
				
         }catch(Exception ex) {
        	 ex.printStackTrace();
         } finally {
			 if (rs != null) 
				 try { rs.close(); } catch(SQLException ex) {}
             if (pstmt != null) 
            	 try { pstmt.close(); } catch(SQLException ex) {}
             if (conn != null) 
            	 try { conn.close(); } catch(SQLException ex) {}
         }
		 return x;
	 }

	 // 3. �ߺ����̵� üũ
	 public int confirmCostomerId(String id) 
	 throws Exception {
		 Connection conn = null;
         PreparedStatement pstmt = null;
		 ResultSet rs= null;
		 int x=-1;
       
		 try {
			 conn = getConnection();
           
             pstmt = conn.prepareStatement(
           	  "select pet_id from petsitter where pet_id = ?");
             pstmt.setString(1, id);
             rs= pstmt.executeQuery();

			 if(rs.next())
				 x= 1; //�ش� ���̵� ����
			 else
				 x= -1;//�ش� ���̵� ����		
         }catch(Exception ex) {
             ex.printStackTrace();
         } finally {
			 if (rs != null) 
				 try { rs.close(); } catch(SQLException ex) {}
             if (pstmt != null) 
            	 try { pstmt.close(); } catch(SQLException ex) {}
             if (conn != null) 
            	 try { conn.close(); } catch(SQLException ex) {}
         }
		 return x;
	 }
	 
	 // 4. ȸ�������� �����ϱ� ���� ������ ������ ǥ��
	 public PetsitterDataBean getPetsitter(String id) 
     throws Exception {
    	 Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         PetsitterDataBean petsitter=null;
         
         try {
        	 conn = getConnection();
           
             pstmt = conn.prepareStatement(
           	     "select * from petsitter where pet_id = ?");
             pstmt.setString(1, id);
             rs = pstmt.executeQuery();

             if (rs.next()) {
            	 petsitter = new PetsitterDataBean();

            	 petsitter.setPet_id(rs.getString("pet_id"));
            	 petsitter.setPet_passwd(rs.getString("pet_passwd"));
            	 petsitter.setPet_name(rs.getString("pet_name"));
            	 petsitter.setPet_gender(rs.getString("pet_gender"));
            	 petsitter.setPet_birth(rs.getString("pet_birth"));
            	 petsitter.setPet_phone(rs.getString("pet_phone"));
            	 petsitter.setPet_post(rs.getString("pet_post"));
            	 petsitter.setPet_addr(rs.getString("pet_addr"));     
            	 petsitter.setPet_reg_date(rs.getTimestamp("pet_reg_date")); 
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
		 return petsitter;
     }
   
     // 5. ȸ���� ��������
	 public void updatePetsitter(PetsitterDataBean petsitter) 
     throws Exception {
    	 Connection conn = null;
         PreparedStatement pstmt = null;
       
         try {
        	 conn = getConnection();
           
             pstmt = conn.prepareStatement(
               "update petsitter set pet_passwd=?,pet_phone=?,pet_post=?,pet_addr=? "+
               "where pet_id=?");
             pstmt.setString(1, petsitter.getPet_passwd());
             pstmt.setString(2, petsitter.getPet_phone());
             pstmt.setString(3, petsitter.getPet_post());
             pstmt.setString(4, petsitter.getPet_addr());
             pstmt.setString(5, petsitter.getPet_id());
           
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
   
     // 6. ȸ��Ż��
     public int deletePetsitter(String id, String passwd) 
     throws Exception {
         Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs= null;
         String dbpasswd="";
         int x=-1;
         
         try {
			 conn = getConnection();

             pstmt = conn.prepareStatement(
           	  "select pet_passwd from petsitter where pet_id = ?");
             pstmt.setString(1, id);
             rs = pstmt.executeQuery();
           
			 if(rs.next()){
				 dbpasswd= rs.getString("pet_passwd"); 
				 if(dbpasswd.equals(passwd)){
					 pstmt = conn.prepareStatement("delete from petsitter where pet_id=?");
                     pstmt.setString(1, id);
                     pstmt.executeUpdate();
					 x= 1; //ȸ��Ż�� ����
				 }else
					 x= 0; //��й�ȣ Ʋ��
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
		 return x;
     }

	 // 7. ȸ������ - 2�ܰ� (�Ұ� ������ �� ���� �� ��)
     public void insertPetsitterTwo(PetsitterDataBean petsitter, String id) 
     throws Exception {
     	Connection conn = null;
         PreparedStatement pstmt = null;
         
         try {
             conn = getConnection();
            
             pstmt = conn.prepareStatement(
            		 "update petsitter set pet_intro=?, pet_cash=?, pet_intro1=?, pet_intro2=?, pet_intro3=? where pet_id=?");
			pstmt.setString(1, petsitter.getPet_intro());
			pstmt.setInt(2, petsitter.getPet_cash());
			pstmt.setString(3, petsitter.getPet_intro1());
			pstmt.setString(4, petsitter.getPet_intro2());
			pstmt.setString(5, petsitter.getPet_intro3());
			pstmt.setString(6, id);


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
     
     // 8. ���̵� ã��
     public PetsitterDataBean searchId(String pet_name, String pet_phone) throws Exception
     {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        PetsitterDataBean sid = null;
        
        try
        {
           conn = getConnection();
           pstmt = conn.prepareStatement("select pet_id from petsitter where pet_name = ? " +
                 "and pet_phone =?");
           pstmt.setString(1, pet_name);
           pstmt.setString(2, pet_phone);
           
           rs = pstmt.executeQuery();
           
           if(rs.next())
           {
              sid = new PetsitterDataBean();
              sid.setPet_id(rs.getString("pet_id"));
           }
        }catch(Exception ex){
           ex.printStackTrace();
        }finally{
           if(rs != null) try { rs.close(); } catch(SQLException ex) {}
           if(pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
           if(conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
        return sid;
     }
     
     // 9. ��й�ȣ ã��     
     public PetsitterDataBean searchPw(String pet_id, String pet_name) throws Exception
     {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        PetsitterDataBean sid = null;
        
        try
        {
           conn = getConnection();
           pstmt = conn.prepareStatement("select pet_passwd from petsitter where pet_id = ? " +
                 "and pet_name =?");
           pstmt.setString(1, pet_id);
           pstmt.setString(2, pet_name);
           
           rs = pstmt.executeQuery();
           
           if(rs.next())
           {
              sid = new PetsitterDataBean();
              sid.setPet_passwd(rs.getString("pet_passwd"));
           }
        }catch(Exception ex){
           ex.printStackTrace();
        }finally{
           if(rs != null) try { rs.close(); } catch(SQLException ex) {}
           if(pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
           if(conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
        return sid;
     }
     
	// 10. ���ϸ��� ���
  	public int getPetMileage(String pet_id) throws Exception {
 		Connection conn = null;
 		PreparedStatement pstmt = null;
 		ResultSet rs = null;

 		int x = 0;

 		try {
 			conn = getConnection();

 			pstmt = conn.prepareStatement("select pet_mile from petsitter where pet_id=?");
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
  	
  	// 10-1. ȸ���� ���ϸ��� ȯ�� UPDATE �� 
  		// + ���� �� ������ 90%�� �ݾ� UPDATE ��
   	public void updateMileage(int mile, String id) throws Exception {
       	 Connection conn = null;
            PreparedStatement pstmt = null;
          
            try {
           	 conn = getConnection();
              
                pstmt = conn.prepareStatement(
                  "update petsitter set pet_mile=? where pet_id=?");
                pstmt.setInt(1, mile);
                pstmt.setString(2, id);
              
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
   	
   	// 11. �̸� ���
   	public String getPetName(String pet_id) throws Exception {
  		Connection conn = null;
  		PreparedStatement pstmt = null;
  		ResultSet rs = null;

  		String x = null;

  		try {
  			conn = getConnection();

  			pstmt = conn.prepareStatement("select pet_name from petsitter where pet_id=?");
  			pstmt.setString(1, pet_id);	
  			rs = pstmt.executeQuery();

  			if (rs.next())
  				x = rs.getString(1);
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