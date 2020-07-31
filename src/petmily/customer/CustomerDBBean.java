package petmily.customer;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CustomerDBBean {
	
	/*DataSource dataSource;
	
	public CustomerDBBean() {
		try {
			InitialContext initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:comp/env");
			dataSource = (DataSource) envContext.lookup("jdbc/petmily");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}*/
	
	private static CustomerDBBean instance = new CustomerDBBean();
	   
    public static CustomerDBBean getInstance() {
    	return instance;
    }
   
    private CustomerDBBean() {}
   
    private Connection getConnection() throws Exception {
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource)envCtx.lookup("jdbc/petmily");
        return ds.getConnection();
    }

    // 1. 회원가입
    public void insertCustomer(CustomerDataBean customer) 
    throws Exception {
    	Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = getConnection();
			   
            pstmt = conn.prepareStatement(
            		"insert into customer(cus_id, cus_passwd, cus_name, cus_gender, cus_birth, cus_phone, cus_post, cus_addr, cus_reg_date) values (?,?,?,?,?,?,?,?,?)");
        			
			pstmt.setString(1, customer.getCus_id());
			pstmt.setString(2, customer.getCus_passwd());
			pstmt.setString(3, customer.getCus_name());
			pstmt.setString(4, customer.getCus_gender());
			pstmt.setString(5, customer.getCus_birth());
			pstmt.setString(6, customer.getCus_phone());
			pstmt.setString(7, customer.getCus_post());
			pstmt.setString(8, customer.getCus_addr());
			pstmt.setTimestamp(9, customer.getCus_reg_date());
			
            pstmt.executeUpdate();
        }catch(Exception ex) {
        	ex.printStackTrace();
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }

     // 2. 사용자 인증처리
	 public int CustomerCheck(String id, String passwd) 
	 throws Exception {
		 Connection conn = null;
         PreparedStatement pstmt = null;
		 ResultSet rs= null;
         String dbpasswd="";
		 int x=-1;
       
		 try {
			conn = getConnection();
           
			pstmt = conn.prepareStatement(
				    "select cus_passwd from customer where cus_id = ?");
				pstmt.setString(1, id);
				rs= pstmt.executeQuery();

				if(rs.next()){
					dbpasswd= rs.getString("cus_passwd"); 
					if(dbpasswd.equals(passwd))
						x = 1; //인증 성공
					else
						x = 0; //비밀번호 틀림
				}else
					x = -1;//해당 아이디 없음
				
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

	 // 3. 중복아이디 체크
	 public int confirmCostomerId(String id) 
	 throws Exception {
		 Connection conn = null;
         PreparedStatement pstmt = null;
		 ResultSet rs= null;
		 int x=-1;
       
		 try {
			 conn = getConnection();
			 /*conn = dataSource.getConnection();*/
	           
             pstmt = conn.prepareStatement(
           	  "select cus_id from customer where cus_id = ?");
             pstmt.setString(1, id);
             rs= pstmt.executeQuery();

			 if(rs.next() || id.equals(""))
				 x= 0; //해당 아이디 있음
			 else
				 x= 1;//해당 아이디 없음	: 가입 가능 	
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
	 
	 // 4. 회원정보를 수정하기 위해 기존의 정보를 표시
	 public CustomerDataBean getCustomer(String id) 
     throws Exception {
    	 Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         CustomerDataBean customer=null;
         
         try {
        	 conn = getConnection();
           
             pstmt = conn.prepareStatement(
           	     "select * from customer where cus_id = ?");
             pstmt.setString(1, id);
             rs = pstmt.executeQuery();

             if (rs.next()) {
            	 customer = new CustomerDataBean();
            	 
            	 customer.setCus_id(rs.getString("cus_id"));
            	 customer.setCus_passwd(rs.getString("cus_passwd"));
            	 customer.setCus_name(rs.getString("cus_name"));
            	 customer.setCus_gender(rs.getString("cus_gender"));
            	 customer.setCus_birth(rs.getString("cus_birth"));
            	 customer.setCus_phone(rs.getString("cus_phone"));
				 customer.setCus_post(rs.getString("cus_post"));
				 customer.setCus_addr(rs.getString("cus_addr"));     
            	 customer.setCus_reg_date(rs.getTimestamp("cus_reg_date")); 
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
		 return customer;
     }
   
     // 5. 회원의 정보수정
	 public void updateCustomer(CustomerDataBean customer) 
		     throws Exception {
		    	 Connection conn = null;
		         PreparedStatement pstmt = null;
		       
		         try {
		        	 conn = getConnection();
		           
		             pstmt = conn.prepareStatement(
		               "update customer set cus_passwd=?,cus_gender=?,cus_phone=?,cus_post=?,cus_addr=? "+
		               "where cus_id=?");
		             pstmt.setString(1, customer.getCus_passwd());
		             pstmt.setString(2, customer.getCus_gender());
		             pstmt.setString(3, customer.getCus_phone());
		             pstmt.setString(4, customer.getCus_post());
		             pstmt.setString(5, customer.getCus_addr());
		             pstmt.setString(6, customer.getCus_id());
		           
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
   
     // 6. 회원탈퇴
	 public int deleteCustomer(String id, String passwd) 
     throws Exception {
         Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs= null;
         String dbpasswd="";
         int x=-1;
         
         try {
			 conn = getConnection();

             pstmt = conn.prepareStatement(
           	  "select cus_passwd from customer where cus_id = ?");
             pstmt.setString(1, id);
             rs = pstmt.executeQuery();
           
			 if(rs.next()){
				 dbpasswd= rs.getString("cus_passwd"); 
				 if(dbpasswd.equals(passwd))
				 {
					 pstmt = conn.prepareStatement("delete from customer where cus_id=?");
                     pstmt.setString(1, id);
                     pstmt.executeUpdate();
					 x= 1; //회원탈퇴 성공
				 }else
					 x= 0; //비밀번호 틀림
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
	 
 	 // 7. 아이디 찾기
     public CustomerDataBean searchId(String cus_name, String cus_phone) throws Exception
     {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        CustomerDataBean sid = null;
        
        try
        {
           conn = getConnection();
           pstmt = conn.prepareStatement("select cus_id from customer where cus_name = ? " +
                 "and cus_phone =?");
           pstmt.setString(1, cus_name);
           pstmt.setString(2, cus_phone);
           
           rs = pstmt.executeQuery();
           
           if(rs.next())
           {
              sid = new CustomerDataBean();
              sid.setCus_id(rs.getString("cus_id"));
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
     
	// 8. 마일리지 출력
 	public int getCusMileage(String cus_id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int x = 0;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select cus_mile from customer where cus_id=?");
			pstmt.setString(1, cus_id);	
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
 	
	// 8-1. 회원의 마일리지 충전 UPDATE 문
 	public void updateMileage(int mile, String id) throws Exception {
     	 Connection conn = null;
          PreparedStatement pstmt = null;
        
          try {
         	 conn = getConnection();
            
              pstmt = conn.prepareStatement(
                "update customer set cus_mile=? where cus_id=?");
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
 	
     // 8. 비밀번호 찾기
     /*public int searchPwd(CustomerDataBean customer, String cus_id, String cus_email) throws Exception
     {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
       
        String dbpasswd="";
        int x = 0;
        int signCheck = cus_email.indexOf("@");
        int comCheck = cus_email.indexOf(".com");
       
        try
        {
        	conn = getConnection();
				 
        	pstmt = conn.prepareStatement("select cus_passwd from customer where cus_id = ? ");
            pstmt.setString(1, cus_id);
            
            rs = pstmt.executeQuery();
            
            if(rs.next())
            {
            	dbpasswd= rs.getString("cus_passwd"); 
            	if (signCheck!=-1 && comCheck!=1)  // 둘 다 안들어있지 않으면 즉, 이메일 형식이 맞으면
					x = 1; // 아이디도 있고, 이메일도 허용 양식임
				else
					x = 0; // 이메일 허용되는 형식이 아님
			}
            else
			{
				x = -1;//해당 아이디 없음
        	}
        }catch(Exception ex){
           ex.printStackTrace();
        }finally{
           if(rs != null) try { rs.close(); } catch(SQLException ex) {}
           if(pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
           if(conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
        return x;
     }*/
     
     // 9.비밀번호 찾기
     public CustomerDataBean searchPw(String cus_id, String cus_name) throws Exception
     {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        CustomerDataBean sid = null;
        
        try
        {
           conn = getConnection();
           pstmt = conn.prepareStatement("select cus_passwd from customer where cus_id = ? " +
                 "and cus_name =?");
           pstmt.setString(1, cus_id);
           pstmt.setString(2, cus_name);
           
           rs = pstmt.executeQuery();
           
           if(rs.next())
           {
              sid = new CustomerDataBean();
              sid.setCus_passwd(rs.getString("cus_passwd"));
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

}