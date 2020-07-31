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

import petmily.petsitter.PetsitterDataBean;

/*import java.text.SimpleDateFormat;*/

public class ReserveDBBean {
	
	private static ReserveDBBean instance = new ReserveDBBean();
	   
    public static ReserveDBBean getInstance() {
    	return instance;
    }
   
    private ReserveDBBean() {}
   
    private Connection getConnection() throws Exception {
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource)envCtx.lookup("jdbc/petmily");
        return ds.getConnection();
    }

    // 1. 예약하기
    public void insertReserve(ReserveDataBean reserve) 
    throws Exception {
    	Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = getConnection();
			   
            pstmt = conn.prepareStatement(
            		"insert into reserve(res_date, cus_id, cus_name, dog_id, dog_name, pet_id, pet_name, pet_cash, petmily_pet, petmily_fee, res_comment, res_reg_date) values (?,?,?,?,?,?,?,?,?,?,?,?)");

			pstmt.setString(1, reserve.getRes_date());
			pstmt.setString(2, reserve.getCus_id());
			pstmt.setString(3, reserve.getCus_name());
			pstmt.setString(4, reserve.getDog_id());
			pstmt.setString(5, reserve.getDog_name());
			pstmt.setString(6, reserve.getPet_id());
			pstmt.setString(7, reserve.getPet_name());
			pstmt.setInt(8, reserve.getPet_cash());
			pstmt.setInt(9, reserve.getPetmily_pet());
			pstmt.setInt(10, reserve.getPetmily_fee());
			pstmt.setString(11, reserve.getRes_comment());
			pstmt.setTimestamp(12, reserve.getRes_reg_date());
			
			/*pstmt.setInt(1, reserve.getRes_num());
			pstmt.setString(2, reserve.getCus_id());
			pstmt.setString(3, reserve.getCus_name());
			pstmt.setString(4, reserve.getDog_id());
			pstmt.setString(5, reserve.getDog_name());
			pstmt.setString(6, reserve.getPet_id());
			pstmt.setString(7, reserve.getPet_name());
			pstmt.setTimestamp(8, reserve.getRes_reg_date());*/
			
            pstmt.executeUpdate();
        }catch(Exception ex) {
        	ex.printStackTrace();
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
    }
    
    // 고객 페이지용 (cus_my_reserve)
    // 2. cus_id의 예약한 펫시터 목록 확인하기 - 배열 방법
  	public ReserveDataBean[] getResPetsitter(int count, String cus_id) throws Exception {
  		Connection conn = null;
  		PreparedStatement pstmt = null;
  		ResultSet rs = null;
  		ReserveDataBean resList[] = null;
  		int i = 0;

  		try {
  			conn = getConnection();

  			String sql = "select * from reserve where cus_id=? order by res_date";

  			pstmt = conn.prepareStatement(sql);
  			pstmt.setString(1, cus_id);	
  			rs = pstmt.executeQuery();

  			if (rs.next()) {
  				resList = new ReserveDataBean[count];

  				do {
  					ReserveDataBean reservation = new ReserveDataBean();

  					reservation.setRes_date(rs.getString("res_date"));
  					reservation.setCus_id(rs.getString("cus_id"));
  					reservation.setCus_name(rs.getString("cus_name"));
  					reservation.setDog_id(rs.getString("dog_id"));
  					reservation.setDog_name(rs.getString("dog_name"));
  					reservation.setPet_id(rs.getString("pet_id"));
  					reservation.setPet_name(rs.getString("pet_name"));
  					reservation.setPet_cash(rs.getInt("pet_cash"));
  					reservation.setRes_comment(rs.getString("res_comment"));
  					reservation.setRes_reg_date(rs.getTimestamp("res_reg_date"));
  					
  					resList[i] = reservation;
  					i++;

  				} while (rs.next() && i<resList.length);
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
  		return resList;
  	}
  	
  	// 2-1. cus_id의 예약한 전체 펫시터 수
  	public int getResPetsitterCount(String cus_id) throws Exception {
 		Connection conn = null;
 		PreparedStatement pstmt = null;
 		ResultSet rs = null;

 		int x = 0;

 		try {
 			conn = getConnection();

 			pstmt = conn.prepareStatement("select count(*) from reserve where cus_id = ?");
 			pstmt.setString(1, cus_id);	
 			rs = pstmt.executeQuery();

 			if (rs.next())
 				x = rs.getInt(1);
 		} catch (Exception ex) {
 			ex.printStackTrace();
 		} finally {
 			if (rs != null)
 				try {
 					rs.close();
 				} catch (SQLException ex) {
 				}
 			if (pstmt != null)
 				try {
 					pstmt.close();
 				} catch (SQLException ex) {
 				}
 			if (conn != null)
 				try {
 					conn.close();
 				} catch (SQLException ex) {
 				}
 		}
 		return x;
 	}
  	
  	// 2-2. (blog2) 해당 날짜, 해당 펫시터의 정보 추출
   	public ReserveDataBean getResPetsitterForRev(String cus_id, String pet_id, String res_date) throws Exception {
   		Connection conn = null;
   		PreparedStatement pstmt = null;
   		ResultSet rs = null;
   		ReserveDataBean reserve = null;

   		try {
   			conn = getConnection();

   			String sql = "select * from reserve where cus_id=? and pet_id=? and res_date=?";

   			pstmt = conn.prepareStatement(sql);
   			pstmt.setString(1, cus_id);	
   			pstmt.setString(2, pet_id);	
   			pstmt.setString(3, res_date);	
   			rs = pstmt.executeQuery();

   			if (rs.next()) {
   				reserve = new ReserveDataBean();

   				reserve.setRes_date(rs.getString("res_date"));
   				reserve.setCus_id(rs.getString("cus_id"));
   				reserve.setCus_name(rs.getString("cus_name"));
   				reserve.setDog_id(rs.getString("dog_id"));
				reserve.setDog_name(rs.getString("dog_name"));
				reserve.setPet_id(rs.getString("pet_id"));
				reserve.setPet_name(rs.getString("pet_name"));
				reserve.setPet_cash(rs.getInt("pet_cash"));
				reserve.setRes_comment(rs.getString("res_comment"));
				reserve.setRes_reg_date(rs.getTimestamp("res_reg_date"));
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
   		return reserve;
   	}
   	
   	// 2-2-1. (blog2) 해당 펫시터에게 예약한 고객 정보 추출
   	public ReserveDataBean getResCustomer(String cus_id, String pet_id) throws Exception {
   		Connection conn = null;
   		PreparedStatement pstmt = null;
   		ResultSet rs = null;
   		ReserveDataBean reserve = null;

   		try {
   			conn = getConnection();

   			String sql = "select * from reserve where cus_id=? and pet_id=?";

   			pstmt = conn.prepareStatement(sql);
   			pstmt.setString(1, cus_id);	
   			pstmt.setString(2, pet_id);	
   			rs = pstmt.executeQuery();

   			if (rs.next()) {
   				reserve = new ReserveDataBean();

   				reserve.setRes_date(rs.getString("res_date"));
   				reserve.setCus_id(rs.getString("cus_id"));
   				reserve.setCus_name(rs.getString("cus_name"));
   				reserve.setDog_id(rs.getString("dog_id"));
				reserve.setDog_name(rs.getString("dog_name"));
				reserve.setPet_id(rs.getString("pet_id"));
				reserve.setPet_name(rs.getString("pet_name"));
				reserve.setPet_cash(rs.getInt("pet_cash"));
				reserve.setRes_comment(rs.getString("res_comment"));
				reserve.setRes_reg_date(rs.getTimestamp("res_reg_date"));
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
   		return reserve;
   	}
   	
   	// 2-3. (blog2) 해당 날짜, 해당 펫시터 있는지 확인하는 체크 비트 (셀렉트 박스 안에 속성값)
   	public int getResPetsitterForRevYN(String cus_id, String pet_id, String res_date) throws Exception {
   		Connection conn = null;
   		PreparedStatement pstmt = null;
   		ResultSet rs = null;
   		ReserveDataBean reserve = null;
   		int check = 0;

   		try {
   			conn = getConnection();

   			String sql = "select count(*) from reserve where cus_id=? and pet_id=? and res_date=?";

   			pstmt = conn.prepareStatement(sql);
   			pstmt.setString(1, cus_id);	
   			pstmt.setString(2, pet_id);	
   			pstmt.setString(3, res_date);	
   			rs = pstmt.executeQuery();

   			if (rs.next()) {
   				check = rs.getInt(1);
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
   		return check;
   	}
   	
   	// 2-4. (blog2) 해당 날짜, 해당 펫시터 있는지 확인하는 체크 비트 (후기 작성란을 띄울지 말지 / 1이상이면 무조건 띄운다)
   	public int getResPetsitterForRevYN(String cus_id, String pet_id, String res_date1, String res_date2, String res_date3, 
   					String res_date4, String res_date5, String res_date6, String res_date7, String res_date8) throws Exception {
   		Connection conn = null;
   		PreparedStatement pstmt = null;
   		ResultSet rs = null;
   		ReserveDataBean reserve = null;
   		int check = 0;

   		try {
   			conn = getConnection();

   			String sql = "select count(*) from reserve where cus_id=? and pet_id=? and "
   					+ "(res_date=? OR res_date=? OR res_date=? OR res_date=? OR res_date=? OR res_date=? OR res_date=? OR res_date=?)";

   			pstmt = conn.prepareStatement(sql);
   			pstmt.setString(1, cus_id);	
   			pstmt.setString(2, pet_id);	
   			pstmt.setString(3, res_date1);
   			pstmt.setString(4, res_date2);
   			pstmt.setString(5, res_date3);
   			pstmt.setString(6, res_date4);
   			pstmt.setString(7, res_date5);
   			pstmt.setString(8, res_date6);
   			pstmt.setString(9, res_date7);	
   			pstmt.setString(10, res_date8);	
   			rs = pstmt.executeQuery();

   			if (rs.next()) {
   				check = rs.getInt(1);
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
   		return check;
   	}
   	
  	// 펫시터 페이지용
  	// 3. pet_id의 예약된 고객 목록 확인하기 - 배열 방법
  	public ReserveDataBean[] getResdCustomer(int count, String pet_id) throws Exception {
  		Connection conn = null;
  		PreparedStatement pstmt = null;
  		ResultSet rs = null;
  		ReserveDataBean resdList[] = null;
  		int i = 0;

  		try {
  			conn = getConnection();

  			String sql = "select * from reserve where pet_id=? order by res_date";

  			pstmt = conn.prepareStatement(sql);
  			pstmt.setString(1, pet_id);	
  			rs = pstmt.executeQuery();

  			if (rs.next()) {
  				resdList = new ReserveDataBean[count];

  				do {
  					ReserveDataBean reservation = new ReserveDataBean();

  					reservation.setRes_date(rs.getString("res_date"));
  					reservation.setCus_id(rs.getString("cus_id"));
  					reservation.setCus_name(rs.getString("cus_name"));
  					reservation.setDog_id(rs.getString("dog_id"));
  					reservation.setDog_name(rs.getString("dog_name"));
  					reservation.setPet_id(rs.getString("pet_id"));
  					reservation.setPet_name(rs.getString("pet_name"));
  					reservation.setPet_cash(rs.getInt("pet_cash"));
  					reservation.setRes_comment(rs.getString("res_comment"));
  					reservation.setRes_reg_date(rs.getTimestamp("res_reg_date"));
  					
  					resdList[i] = reservation;
  					i++;

  				} while (rs.next() && i<resdList.length);
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
  		return resdList;
  	}
  	
  	// 3-1. pet_id의 예약한 전체 펫시터 수
  	public int getResdCustomerCount(String pet_id) throws Exception {
 		Connection conn = null;
 		PreparedStatement pstmt = null;
 		ResultSet rs = null;

 		int x = 0;

 		try {
 			conn = getConnection();

 			pstmt = conn.prepareStatement("select count(*) from reserve where pet_id = ?");
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
  	
  	// 매니저 페이지용
  	// 4. 예약된 목록 확인하기 - 배열 방법 (오늘 이전과 이후로 나누어서 과거 내역, 미래 내역으로... 해보기)
   	public ReserveDataBean[] getReserve(int count) throws Exception {
   		Connection conn = null;
   		PreparedStatement pstmt = null;
   		ResultSet rs = null;
   		ReserveDataBean reserveList[] = null;
   		int i = 0;

   		try {
   			conn = getConnection();

   			String sql = "select * from reserve order by res_reg_date";

   			pstmt = conn.prepareStatement(sql);
   			rs = pstmt.executeQuery();

   			if (rs.next()) {
   				reserveList = new ReserveDataBean[count];

   				do {
   					ReserveDataBean reservation = new ReserveDataBean();

   					reservation.setRes_num(rs.getInt("res_num"));
   					reservation.setRes_date(rs.getString("res_date"));
   					reservation.setCus_id(rs.getString("cus_id"));
   					reservation.setCus_name(rs.getString("cus_name"));
   					reservation.setDog_id(rs.getString("dog_id"));
   					reservation.setDog_name(rs.getString("dog_name"));
   					reservation.setPet_id(rs.getString("pet_id"));
   					reservation.setPet_name(rs.getString("pet_name"));
   					reservation.setPet_cash(rs.getInt("pet_cash"));
   					reservation.setPetmily_pet(rs.getInt("petmily_pet"));
   					reservation.setPetmily_fee(rs.getInt("petmily_fee"));
   					reservation.setRes_comment(rs.getString("res_comment"));
   					reservation.setRes_reg_date(rs.getTimestamp("res_reg_date"));
   					
   					reserveList[i] = reservation;
   					i++;

   				} while (rs.next() && i<reserveList.length);
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
   		return reserveList;
   	}
   	
   	// 4-1. 예약한 전체 건수
   	public int getResCount() throws Exception {
  		Connection conn = null;
  		PreparedStatement pstmt = null;
  		ResultSet rs = null;

  		int x = 0;

  		try {
  			conn = getConnection();

  			pstmt = conn.prepareStatement("select count(*) from reserve");
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
   	
	// 5. 펫시터에게 오늘 예약된 건
	public ReserveDataBean getTodayReserve(String pet_id, String res_date) throws Exception {
		Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ReserveDataBean reserve = null;
        
        try {
       	 conn = getConnection();
          
            pstmt = conn.prepareStatement(
          	     "select * from reserve where pet_id = ? and res_date = ?"); // 오늘 날짜 가져와서 예약 날짜랑 비교 후, 있으면 출력
            pstmt.setString(1, pet_id);
            pstmt.setString(2, res_date);   
            rs = pstmt.executeQuery();

            if (rs.next()) {
            	reserve = new ReserveDataBean();

            	reserve.setRes_date(rs.getString("res_date"));
            	reserve.setCus_id(rs.getString("cus_id"));
            	reserve.setCus_name(rs.getString("cus_name"));
            	reserve.setDog_id(rs.getString("dog_id"));
            	reserve.setDog_name(rs.getString("dog_name"));
            	reserve.setPet_id(rs.getString("pet_id"));
				reserve.setPet_name(rs.getString("pet_name"));
				reserve.setPet_cash(rs.getInt("pet_cash"));
				reserve.setRes_comment(rs.getString("res_comment"));
				reserve.setRes_reg_date(rs.getTimestamp("res_reg_date"));
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
		return reserve;
    }

	 
}