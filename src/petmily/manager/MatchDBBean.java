package petmily.manager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import petmily.customer.CustomerMaDataBean;
import petmily.petsitter.PetsitterDataBean;
import petmily.manager.ManagerDataBean;
import petmily.petsitter.PetsitterMaDataBean;

public class MatchDBBean {
	
	private static MatchDBBean instance = new MatchDBBean();
	   
    public static MatchDBBean getInstance() {
    	return instance;
    }
   
    private MatchDBBean() {}
   
    private Connection getConnection() throws Exception {
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource)envCtx.lookup("jdbc/petmily");
        return ds.getConnection();
    }
    
    // 1. 매칭값이 있는 고객에게 매칭값이 있는 펫시터를 매칭시켜주는 메소드
      // ManagerDBBean에서 "펫시터 회원가입 승인을 위한 승인되지 않은 or 승인된 펫시터 정보 표시 - 배열 방법" 참고
    public PetsitterDataBean[] getMatchPetsitter(String cus_id, int count) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		PetsitterDataBean petList[] = null;
		int i = 0;

		try {
			conn = getConnection();

			String sql = "SELECT pm.pet_id,p.pet_name, p.pet_intro,\r\n" + 
					"p.pet_intro1, p.pet_intro2, p.pet_intro3, sum(m.m_wei) score\r\n" + 
					"FROM matching m, petsitter p, \r\n" + 
					"cus_ma cm inner join pet_ma pm\r\n" + 
					"on cm.m_que = pm.m_que and cm.m_ans =  pm.m_ans\r\n" + 
					"where cm.cus_id = ? \r\n" + 
					"and pm.m_que = m.m_que\r\n" + 
					"and cm.m_que = m.m_que\r\n" + 
					"and p.pet_id = pm.pet_id \r\n" + 
					"group by pet_id\r\n" + 
					"order by score desc";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cus_id);	
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				petList = new PetsitterDataBean[count];

				do {
					PetsitterDataBean petsitter = new PetsitterDataBean();

					petsitter.setPet_id(rs.getString("pet_id"));
					petsitter.setPet_passwd(rs.getString("pet_passwd"));
					petsitter.setPet_name(rs.getString("pet_name"));
					petsitter.setPet_gender(rs.getString("pet_gender"));
					petsitter.setPet_birth(rs.getString("pet_birth"));
					petsitter.setPet_phone(rs.getString("pet_phone"));
					petsitter.setPet_post(rs.getString("pet_post"));
					petsitter.setPet_addr(rs.getString("pet_addr"));
					petsitter.setPet_lic(rs.getString("pet_lic"));
					petsitter.setPet_apprv(rs.getString("pet_apprv"));
					petsitter.setPet_intro(rs.getString("pet_intro"));
					petsitter.setPet_intro1(rs.getString("pet_intro1"));
					petsitter.setPet_intro2(rs.getString("pet_intro2"));
					petsitter.setPet_intro3(rs.getString("pet_intro3"));
					petsitter.setPet_reg_date(rs.getTimestamp("pet_reg_date"));
					
					petList[i] = petsitter;
					i++;
					
				} while (rs.next() && i<petList.length);
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
		return petList;
	}

}